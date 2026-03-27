[CmdletBinding()]
param(
    [Alias("CodexHome")]
    [string]$AgentHome = (Join-Path $env:USERPROFILE ".agent"),
    [string]$RepoRoot,
    [string]$WorktreesRoot,
    [switch]$TrustAllSafeDirectories
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-Step {
    param([string]$Message)
    Write-Host "[bootstrap-agent-environment] $Message"
}

function Ensure-Directory {
    param([Parameter(Mandatory = $true)][string]$Path)

    New-Item -ItemType Directory -Force -Path $Path -ErrorAction Stop | Out-Null
}

function Invoke-Git {
    param([Parameter(Mandatory = $true)][string[]]$Args)

    $nativeVar = Get-Variable -Name PSNativeCommandUseErrorActionPreference -ErrorAction SilentlyContinue
    if ($null -ne $nativeVar) {
        $oldNativePref = $PSNativeCommandUseErrorActionPreference
        $PSNativeCommandUseErrorActionPreference = $false
    }

    $oldErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Continue"

    try {
        $output = & git @Args 2>&1
        return [PSCustomObject]@{
            ExitCode = $LASTEXITCODE
            Output = @($output)
        }
    }
    finally {
        $ErrorActionPreference = $oldErrorActionPreference

        if ($null -ne $nativeVar) {
            $PSNativeCommandUseErrorActionPreference = $oldNativePref
        }
    }
}

function Add-SafeDirectory {
    param([Parameter(Mandatory = $true)][string]$Path)

    if (-not (Test-Path $Path)) {
        Write-Step "Skipped missing path: $Path"
        return
    }

    $resolved = (Resolve-Path $Path).Path
    $existingResult = Invoke-Git -Args @("config", "--global", "--get-all", "safe.directory")
    $existing = if ($existingResult.ExitCode -eq 0) { @($existingResult.Output) } else { @() }

    $normalizedResolved = $resolved.Replace("\", "/")
    $normalizedExisting = $existing | ForEach-Object { $_.ToString().Replace("\", "/") }

    if ($normalizedExisting -contains $normalizedResolved) {
        Write-Step "safe.directory already present: $resolved"
        return
    }

    $addResult = Invoke-Git -Args @("config", "--global", "--add", "safe.directory", $resolved)
    if ($addResult.ExitCode -ne 0) {
        throw "Failed to add git safe.directory '$resolved'. Ensure write access to the global git config. Details: $($addResult.Output -join '; ')"
    }

    Write-Step "Added git safe.directory: $resolved"
}

function Add-SafeDirectoriesUnderRoot {
    param([Parameter(Mandatory = $true)][string]$RootPath)

    if (-not (Test-Path $RootPath)) {
        Write-Step "Skipped missing worktrees root: $RootPath"
        return
    }

    $resolvedRoot = (Resolve-Path $RootPath).Path
    $gitRoots = [System.Collections.Generic.List[string]]::new()

    if (Test-Path (Join-Path $resolvedRoot ".git")) {
        $gitRoots.Add($resolvedRoot)
    }

    $nestedRoots = Get-ChildItem -Path $resolvedRoot -Directory -Recurse -ErrorAction SilentlyContinue |
        Where-Object { Test-Path (Join-Path $_.FullName ".git") } |
        Select-Object -ExpandProperty FullName -Unique

    foreach ($path in $nestedRoots) {
        $gitRoots.Add($path)
    }

    $gitRoots = $gitRoots | Select-Object -Unique

    foreach ($path in $gitRoots) {
        Add-SafeDirectory -Path $path
    }
}

function Add-WildcardSafeDirectory {
    $existingResult = Invoke-Git -Args @("config", "--global", "--get-all", "safe.directory")
    $existing = if ($existingResult.ExitCode -eq 0) { @($existingResult.Output) } else { @() }

    if ($existing -contains "*") {
        Write-Step "safe.directory '*' already present."
        return
    }

    $addResult = Invoke-Git -Args @("config", "--global", "--add", "safe.directory", "*")
    if ($addResult.ExitCode -ne 0) {
        throw "Failed to add wildcard git safe.directory '*'. Ensure write access to the global git config. Details: $($addResult.Output -join '; ')"
    }

    Write-Step "Added git safe.directory '*'."
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "git is not available in PATH."
}

if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
    $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

if ([string]::IsNullOrWhiteSpace($WorktreesRoot)) {
    $WorktreesRoot = Join-Path $env:USERPROFILE ".agent\worktrees"
}

$agentHomeResolved = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($AgentHome)
Ensure-Directory -Path $agentHomeResolved
Ensure-Directory -Path (Join-Path $agentHomeResolved "appdata")
Ensure-Directory -Path (Join-Path $agentHomeResolved "cache")
Ensure-Directory -Path (Join-Path $agentHomeResolved "temp")

Write-Step "Prepared agent home: $agentHomeResolved"

if ($TrustAllSafeDirectories) {
    Add-WildcardSafeDirectory
}
else {
    if ($RepoRoot) {
        Add-SafeDirectory -Path $RepoRoot
    }

    if ($WorktreesRoot) {
        Add-SafeDirectoriesUnderRoot -RootPath $WorktreesRoot
    }
}

Write-Step "Bootstrap completed."
