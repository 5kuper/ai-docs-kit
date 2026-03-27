[CmdletBinding()]
param(
    [Parameter()]
    [string]$RepoRoot,

    [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
    [string[]]$DotnetArgs
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-Step {
    param([string]$Message)
    Write-Host "[dotnet-wrapper] $Message"
}

function Ensure-Directory {
    param([Parameter(Mandatory = $true)][string]$Path)

    New-Item -ItemType Directory -Force -Path $Path -ErrorAction Stop | Out-Null
}

function Set-Or-RemoveEnv {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [AllowNull()][string]$Value
    )

    if ($null -eq $Value) {
        Remove-Item "Env:$Name" -ErrorAction SilentlyContinue
    }
    else {
        Set-Item "Env:$Name" -Value $Value
    }
}

function Resolve-AgentHome {
    param(
        [Parameter(Mandatory = $true)][string]$RepoRootPath,
        [Parameter(Mandatory = $true)][string]$UserProfile
    )

    $primary = Join-Path $UserProfile ".agent"

    try {
        Ensure-Directory -Path $primary
        Ensure-Directory -Path (Join-Path $primary "appdata")
        Ensure-Directory -Path (Join-Path $primary "dotnet-home")
        return $primary
    }
    catch {
        $fallback = Join-Path $RepoRootPath ".agent-local"
        Ensure-Directory -Path $fallback
        Ensure-Directory -Path (Join-Path $fallback "appdata")
        Ensure-Directory -Path (Join-Path $fallback "dotnet-home")
        return $fallback
    }
}

function Ensure-NuGetConfig {
    param([Parameter(Mandatory = $true)][string]$AppDataRoot)

    $nugetDir = Join-Path $AppDataRoot "NuGet"
    Ensure-Directory -Path $nugetDir

    $nugetConfigPath = Join-Path $nugetDir "NuGet.Config"
    if (-not (Test-Path $nugetConfigPath)) {
        $nugetXml = @"
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageSources>
    <add key="nuget.org" value="https://api.nuget.org/v3/index.json" />
  </packageSources>
</configuration>
"@
        Set-Content -Path $nugetConfigPath -Value $nugetXml -Encoding UTF8
        Write-Step "Created NuGet config: $nugetConfigPath"
    }
}

function Resolve-NuGetPackagesPath {
    param(
        [Parameter(Mandatory = $true)][string]$RepoRootPath,
        [Parameter(Mandatory = $true)][string]$UserProfile
    )

    $userPackages = Join-Path $UserProfile ".nuget\packages"
    if (Test-Path $userPackages) {
        return $userPackages
    }

    $fallback = Join-Path $RepoRootPath ".agent-local\nuget-packages"
    Ensure-Directory -Path $fallback
    return $fallback
}

function Test-HasArg {
    param(
        [Parameter(Mandatory = $true)][string[]]$Args,
        [Parameter(Mandatory = $true)][string[]]$Candidates
    )

    foreach ($arg in $Args) {
        if ($Candidates -contains $arg) {
            return $true
        }
    }

    return $false
}

function Test-MatchesPrefix {
    param(
        [Parameter(Mandatory = $true)][string]$Token,
        [Parameter(Mandatory = $true)][string[]]$Prefixes
    )

    foreach ($prefix in $Prefixes) {
        if ($Token.StartsWith($prefix, [System.StringComparison]::OrdinalIgnoreCase)) {
            return $true
        }
    }

    return $false
}

function Get-RestoreArgs {
    param([Parameter(Mandatory = $true)][string[]]$Args)

    $restoreArgs = [System.Collections.Generic.List[string]]::new()
    $restoreArgs.Add("restore")

    if ($Args.Count -le 1) {
        return @($restoreArgs)
    }

    $switches = @(
        "--disable-parallel",
        "--force",
        "--force-evaluate",
        "--ignore-failed-sources",
        "--interactive",
        "--locked-mode",
        "--no-cache",
        "--use-current-runtime",
        "--ucr"
    )

    $valueOptions = @(
        "--source",
        "-s",
        "--packages",
        "--configfile",
        "--runtime",
        "-r",
        "--framework",
        "-f",
        "--verbosity",
        "-v",
        "--arch",
        "--os"
    )

    $valueOptionPrefixes = @(
        "--source=",
        "--packages=",
        "--configfile=",
        "--runtime=",
        "--framework=",
        "--verbosity=",
        "--arch=",
        "--os="
    )

    $propertyPrefixes = @(
        "/p:",
        "-p:",
        "/property:",
        "-property:",
        "/m",
        "-m"
    )

    for ($i = 1; $i -lt $Args.Count; $i++) {
        $token = $Args[$i]

        if ($switches -contains $token) {
            $restoreArgs.Add($token)
            continue
        }

        if ($valueOptions -contains $token) {
            $restoreArgs.Add($token)

            if ($i + 1 -lt $Args.Count) {
                $i++
                $restoreArgs.Add($Args[$i])
            }

            continue
        }

        if (Test-MatchesPrefix -Token $token -Prefixes $valueOptionPrefixes) {
            $restoreArgs.Add($token)
            continue
        }

        if (Test-MatchesPrefix -Token $token -Prefixes $propertyPrefixes) {
            $restoreArgs.Add($token)
            continue
        }

        if (-not ($token.StartsWith("-") -or $token.StartsWith("/"))) {
            $restoreArgs.Add($token)
        }
    }

    return @($restoreArgs)
}

function Invoke-Dotnet {
    param([Parameter(Mandatory = $true)][string[]]$Args)

    & dotnet @Args
    return $LASTEXITCODE
}

if (-not (Get-Command dotnet -ErrorAction SilentlyContinue)) {
    throw "dotnet is not available in PATH."
}

if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
    $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

$repoRootResolved = (Resolve-Path $RepoRoot).Path
$agentHome = Resolve-AgentHome -RepoRootPath $repoRootResolved -UserProfile $env:USERPROFILE
$appDataRoot = Join-Path $agentHome "appdata"
$dotnetCliHome = Join-Path $agentHome "dotnet-home"
$msbuildUserExtensionsPath = Join-Path $agentHome "msbuild"
$nugetPackages = Resolve-NuGetPackagesPath -RepoRootPath $repoRootResolved -UserProfile $env:USERPROFILE

Ensure-Directory -Path $appDataRoot
Ensure-Directory -Path $dotnetCliHome
Ensure-Directory -Path $msbuildUserExtensionsPath
Ensure-NuGetConfig -AppDataRoot $appDataRoot

$original = @{
    APPDATA = $env:APPDATA
    DOTNET_CLI_HOME = $env:DOTNET_CLI_HOME
    MSBuildUserExtensionsPath = $env:MSBuildUserExtensionsPath
    MSBuildEnableWorkloadResolver = $env:MSBuildEnableWorkloadResolver
    NUGET_PACKAGES = $env:NUGET_PACKAGES
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE = $env:DOTNET_SKIP_FIRST_TIME_EXPERIENCE
    DOTNET_ADD_GLOBAL_TOOLS_TO_PATH = $env:DOTNET_ADD_GLOBAL_TOOLS_TO_PATH
    DOTNET_GENERATE_ASPNET_CERTIFICATE = $env:DOTNET_GENERATE_ASPNET_CERTIFICATE
}

$pushedLocation = $false
$exitCode = 0

try {
    Set-Or-RemoveEnv -Name "APPDATA" -Value $appDataRoot
    Set-Or-RemoveEnv -Name "DOTNET_CLI_HOME" -Value $dotnetCliHome
    Set-Or-RemoveEnv -Name "MSBuildUserExtensionsPath" -Value $msbuildUserExtensionsPath
    Set-Or-RemoveEnv -Name "MSBuildEnableWorkloadResolver" -Value "false"
    Set-Or-RemoveEnv -Name "NUGET_PACKAGES" -Value $nugetPackages
    Set-Or-RemoveEnv -Name "DOTNET_SKIP_FIRST_TIME_EXPERIENCE" -Value "1"
    Set-Or-RemoveEnv -Name "DOTNET_ADD_GLOBAL_TOOLS_TO_PATH" -Value "false"
    Set-Or-RemoveEnv -Name "DOTNET_GENERATE_ASPNET_CERTIFICATE" -Value "false"

    Push-Location $repoRootResolved
    $pushedLocation = $true

    $command = if ($DotnetArgs.Count -gt 0) { $DotnetArgs[0].ToLowerInvariant() } else { "" }
    $skipRestore = Test-HasArg -Args $DotnetArgs -Candidates @("--no-restore", "/p:Restore=false", "-p:Restore=false")

    if ($command -in @("build", "test", "publish", "pack") -and -not $skipRestore) {
        $restoreArgs = Get-RestoreArgs -Args $DotnetArgs
        $restoreArgs += @(
            "/m:1",
            "/p:RestoreDisableParallel=true",
            "/p:RestoreUseStaticGraphEvaluation=false",
            "--ignore-failed-sources"
        )

        Write-Step "Running dotnet restore via wrapper."
        $exitCode = Invoke-Dotnet -Args $restoreArgs
        if ($exitCode -eq 0) {
            $commandArgs = $DotnetArgs + @("--no-restore")
            Write-Step ("Running dotnet {0} via wrapper." -f $command)
            $exitCode = Invoke-Dotnet -Args $commandArgs
        }
    }
    else {
        if ([string]::IsNullOrWhiteSpace($command)) {
            Write-Step "Running dotnet via wrapper."
        }
        else {
            Write-Step ("Running dotnet {0} via wrapper." -f $command)
        }
        $exitCode = Invoke-Dotnet -Args $DotnetArgs
    }
}
finally {
    if ($pushedLocation) {
        Pop-Location
    }

    foreach ($kv in $original.GetEnumerator()) {
        Set-Or-RemoveEnv -Name $kv.Key -Value $kv.Value
    }
}

exit $exitCode
