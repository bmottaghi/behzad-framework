# behzad-framework setup script for Windows
# Run from project root after: git submodule add https://github.com/bmottaghi/behzad-framework.git .behzad

param(
    [switch]$Force
)

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  behzad-framework Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if running from correct location
if (-not (Test-Path ".behzad")) {
    Write-Host "Error: .behzad directory not found." -ForegroundColor Red
    Write-Host ""
    Write-Host "Make sure you:" -ForegroundColor Yellow
    Write-Host "1. Run this from your project root" -ForegroundColor Yellow
    Write-Host "2. Have added the submodule first:" -ForegroundColor Yellow
    Write-Host "   git submodule add https://github.com/bmottaghi/behzad-framework.git .behzad" -ForegroundColor Gray
    Write-Host ""
    exit 1
}

# Step 1: Copy CLAUDE.md
Write-Host "Step 1: Setting up CLAUDE.md..." -ForegroundColor White
if ((Test-Path "CLAUDE.md") -and -not $Force) {
    Write-Host "  CLAUDE.md already exists. Use -Force to overwrite." -ForegroundColor Yellow
} else {
    Copy-Item ".behzad\CLAUDE.md" "." -Force
    Write-Host "  Copied CLAUDE.md" -ForegroundColor Green
}

# Step 2: Create .claude\commands directory
Write-Host "Step 2: Setting up commands..." -ForegroundColor White
if (-not (Test-Path ".claude\commands")) {
    New-Item -ItemType Directory -Path ".claude\commands" -Force | Out-Null
    Write-Host "  Created .claude\commands\" -ForegroundColor Green
}

# Step 3: Try symlinks first, fall back to copy
$useSymlinks = $true
try {
    $testLink = ".claude\commands\_test_symlink_temp"
    New-Item -ItemType SymbolicLink -Path $testLink -Target ".behzad\README.md" -Force -ErrorAction Stop | Out-Null
    Remove-Item $testLink -Force
    Write-Host "  Using symlinks (updates automatically)" -ForegroundColor Green
} catch {
    Write-Host "  Symlinks not available, using copy instead" -ForegroundColor Yellow
    Write-Host "  (Run as Admin or enable Developer Mode for symlinks)" -ForegroundColor Gray
    $useSymlinks = $false
}

# Step 4: Setup command files
$commandFiles = Get-ChildItem ".behzad\.claude\commands\*.md" -ErrorAction SilentlyContinue
$count = 0

foreach ($cmd in $commandFiles) {
    $target = ".claude\commands\$($cmd.Name)"

    # Remove existing file/symlink
    if (Test-Path $target) {
        Remove-Item $target -Force
    }

    if ($useSymlinks) {
        $relativePath = "..\..\$($cmd.FullName.Substring((Get-Location).Path.Length + 1))"
        New-Item -ItemType SymbolicLink -Path $target -Target $cmd.FullName -Force | Out-Null
    } else {
        Copy-Item $cmd.FullName $target -Force
    }
    $count++
}

Write-Host "  Setup $count commands" -ForegroundColor Green

# Step 5: Create docs structure (only if not exists)
Write-Host "Step 3: Setting up docs structure..." -ForegroundColor White
$dirs = @("docs", "docs\tech-spine", "docs\execution", "docs\learning", "docs\research")
$created = 0
foreach ($dir in $dirs) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        $created++
    }
}
if ($created -gt 0) {
    Write-Host "  Created $created directories" -ForegroundColor Green
} else {
    Write-Host "  Docs structure already exists" -ForegroundColor Gray
}

# Done
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Open this project in VSCode with Claude Code" -ForegroundColor White
Write-Host "2. Type: /init-existing" -ForegroundColor White
Write-Host ""
Write-Host "To update the framework later:" -ForegroundColor Cyan
Write-Host "  git submodule update --remote .behzad" -ForegroundColor Gray
if (-not $useSymlinks) {
    Write-Host "  Then re-run: .\.behzad\setup.ps1 -Force" -ForegroundColor Gray
}
Write-Host ""
