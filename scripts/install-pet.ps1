param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Pet
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$sourceDir = Join-Path $repoRoot $Pet
$petJsonPath = Join-Path $sourceDir "pet.json"
$spritePath = Join-Path $sourceDir "spritesheet.webp"

if (-not (Test-Path -LiteralPath $sourceDir -PathType Container)) {
    throw "Pet package not found: $sourceDir"
}

if (-not (Test-Path -LiteralPath $petJsonPath -PathType Leaf)) {
    throw "Missing pet.json: $petJsonPath"
}

if (-not (Test-Path -LiteralPath $spritePath -PathType Leaf)) {
    throw "Missing spritesheet.webp: $spritePath"
}

$petJson = Get-Content -Raw -LiteralPath $petJsonPath | ConvertFrom-Json
if (-not $petJson.id) {
    throw "pet.json must contain an id field."
}

$destDir = Join-Path $env:USERPROFILE ".codex\pets\$($petJson.id)"
New-Item -ItemType Directory -Force -Path $destDir | Out-Null

Copy-Item -LiteralPath $petJsonPath -Destination (Join-Path $destDir "pet.json") -Force
Copy-Item -LiteralPath $spritePath -Destination (Join-Path $destDir "spritesheet.webp") -Force

Write-Host "Installed $($petJson.displayName) to $destDir"

