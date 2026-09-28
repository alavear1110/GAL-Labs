param(
  [string]$OutputDirectory = "dist",
  [ValidateSet("codex","kiro","claude-code")]
  [string[]]$Hosts = @("codex")
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
$RuntimeSource = Join-Path $RepoRoot "runtime"
$StageRoot = Join-Path $RepoRoot $OutputDirectory
$PackageRoot = Join-Path $StageRoot "gal-runtime"

if (Test-Path $PackageRoot) { Remove-Item $PackageRoot -Recurse -Force }
New-Item -ItemType Directory -Force $PackageRoot | Out-Null

# Copy only explicitly public runtime components. Never copy the repository root
# or test-suite wholesale.
foreach ($name in @("gal.ps1","README.md","schemas","steering","templates","contracts")) {
  Copy-Item (Join-Path $RuntimeSource $name) (Join-Path $PackageRoot $name) -Recurse -Force
}

New-Item -ItemType Directory -Force (Join-Path $PackageRoot "adapters") | Out-Null
foreach ($host in $Hosts) {
  $adapter = Join-Path $RuntimeSource "adapters/$host"
  if (!(Test-Path $adapter)) { throw "Requested host adapter is unavailable: $host" }
  Copy-Item $adapter (Join-Path $PackageRoot "adapters/$host") -Recurse -Force

  switch ($host) {
    "codex" {
      Copy-Item (Join-Path $RepoRoot "AGENTS.md") (Join-Path $PackageRoot "AGENTS.md") -Force
    }
    "claude-code" {
      $loader = Join-Path $RepoRoot "CLAUDE.md"
      if (!(Test-Path $loader)) { throw "Claude Code loader is unavailable in this release" }
      Copy-Item $loader (Join-Path $PackageRoot "CLAUDE.md") -Force
    }
  }
}

foreach ($publicDoc in @("LICENSE","SECURITY.md")) {
  $source = Join-Path $RepoRoot $publicDoc
  if (Test-Path $source) { Copy-Item $source (Join-Path $PackageRoot $publicDoc) -Force }
}

# Fail closed if any internal-test naming leaks into the staged deliverable.
$forbiddenNames = @("test-suite","regression","conformance","fixture","answer-key","expected-answer")
$leaks = @()
Get-ChildItem $PackageRoot -Recurse -Force | ForEach-Object {
  $relative = $_.FullName.Substring($PackageRoot.Length).TrimStart([IO.Path]::DirectorySeparatorChar)
  foreach ($term in $forbiddenNames) {
    if ($relative -match [regex]::Escape($term)) { $leaks += $relative; break }
  }
}
if ($leaks.Count) {
  throw "Public package rejected: internal-test path(s) detected: $($leaks -join ', ')"
}

$manifest = Get-ChildItem $PackageRoot -Recurse -File | ForEach-Object {
  $_.FullName.Substring($PackageRoot.Length).TrimStart([IO.Path]::DirectorySeparatorChar).Replace("\","/")
} | Sort-Object
$manifest | Set-Content -Encoding UTF8 (Join-Path $PackageRoot "PACKAGE-MANIFEST.txt")

Write-Host "GAL public runtime staged at $PackageRoot" -ForegroundColor Green
Write-Host "Hosts: $($Hosts -join ', ')"
Write-Host "Files: $($manifest.Count + 1)"
