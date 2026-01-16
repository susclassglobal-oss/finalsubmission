# ============================================================
# CACHE CLEANUP SCRIPT FOR WINDOWS
# ============================================================
# Cleans up development caches, temp files, and build artifacts
# Safe to run - only removes temporary/cache files
# ============================================================

Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║           CACHE CLEANUP UTILITY                        ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

$totalFreed = 0

function Get-FolderSize {
    param([string]$Path)
    if (Test-Path $Path) {
        try {
            $size = (Get-ChildItem $Path -Recurse -Force -ErrorAction SilentlyContinue | 
                     Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
            return [math]::Round($size / 1GB, 2)
        } catch {
            return 0
        }
    }
    return 0
}

function Remove-CacheFolder {
    param(
        [string]$Path,
        [string]$Name
    )
    
    if (Test-Path $Path) {
        $sizeBefore = Get-FolderSize $Path
        Write-Host "🗑️  Cleaning $Name... ($sizeBefore GB)" -ForegroundColor Yellow
        
        try {
            Remove-Item $Path -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "   ✅ Removed $sizeBefore GB" -ForegroundColor Green
            return $sizeBefore
        } catch {
            Write-Host "   ⚠️  Could not remove (may be in use)" -ForegroundColor Red
            return 0
        }
    } else {
        Write-Host "⏭️  Skipping $Name (not found)" -ForegroundColor Gray
        return 0
    }
}

# ============================================================
# 1. NPM CACHE
# ============================================================
Write-Host "`n📦 Node.js / NPM Cache" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan

$npmCache = "$env:APPDATA\npm-cache"
$sizeBefore = Get-FolderSize $npmCache
Write-Host "   Current size: $sizeBefore GB" -ForegroundColor Yellow

try {
    npm cache clean --force 2>$null
    $totalFreed += $sizeBefore
    Write-Host "   ✅ NPM cache cleaned" -ForegroundColor Green
} catch {
    Write-Host "   ⚠️  NPM cache clean failed" -ForegroundColor Red
}

# ============================================================
# 2. DOCKER (if installed)
# ============================================================
Write-Host "`n🐳 Docker Cache" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan

if (Get-Command docker -ErrorAction SilentlyContinue) {
    Write-Host "   Pruning Docker system..." -ForegroundColor Yellow
    try {
        docker system prune -af --volumes 2>$null
        Write-Host "   ✅ Docker cleaned (images, containers, volumes)" -ForegroundColor Green
        # Docker size is hard to estimate, adding 2GB estimate
        $totalFreed += 2
    } catch {
        Write-Host "   ⚠️  Docker cleanup failed (may not be running)" -ForegroundColor Red
    }
} else {
    Write-Host "   ⏭️  Docker not installed" -ForegroundColor Gray
}

# ============================================================
# 3. WINDOWS TEMP FILES
# ============================================================
Write-Host "`n🗂️  Windows Temp Files" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan

$totalFreed += Remove-CacheFolder "$env:TEMP" "User Temp"
$totalFreed += Remove-CacheFolder "C:\Windows\Temp" "System Temp"
$totalFreed += Remove-CacheFolder "$env:LOCALAPPDATA\Temp" "Local Temp"

# Recreate temp folders
New-Item -Path "$env:TEMP" -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
New-Item -Path "C:\Windows\Temp" -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
New-Item -Path "$env:LOCALAPPDATA\Temp" -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null

# ============================================================
# 4. VS CODE CACHE
# ============================================================
Write-Host "`n💻 VS Code Cache" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan

$totalFreed += Remove-CacheFolder "$env:APPDATA\Code\Cache" "Code Cache"
$totalFreed += Remove-CacheFolder "$env:APPDATA\Code\CachedData" "Cached Data"
$totalFreed += Remove-CacheFolder "$env:APPDATA\Code\logs" "VS Code Logs"

# ============================================================
# 5. .NET BUILD CACHE
# ============================================================
Write-Host "`n🔷 .NET Build Cache" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan

$totalFreed += Remove-CacheFolder "$env:LOCALAPPDATA\Microsoft\dotnet" ".NET Cache"
$totalFreed += Remove-CacheFolder "$env:USERPROFILE\.nuget\packages" "NuGet Packages"

# ============================================================
# 6. BROWSER CACHES
# ============================================================
Write-Host "`n🌐 Browser Caches" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan

# Chrome
$totalFreed += Remove-CacheFolder "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache" "Chrome Cache"
$totalFreed += Remove-CacheFolder "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Code Cache" "Chrome Code Cache"

# Edge
$totalFreed += Remove-CacheFolder "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache" "Edge Cache"

# Firefox
$totalFreed += Remove-CacheFolder "$env:LOCALAPPDATA\Mozilla\Firefox\Profiles\*\cache2" "Firefox Cache"

# ============================================================
# 7. PYTHON PIP CACHE
# ============================================================
Write-Host "`n🐍 Python Cache" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan

if (Get-Command pip -ErrorAction SilentlyContinue) {
    try {
        $pipCache = "$env:LOCALAPPDATA\pip\cache"
        $totalFreed += Remove-CacheFolder $pipCache "Pip Cache"
    } catch {
        Write-Host "   ⚠️  Pip cache clean failed" -ForegroundColor Red
    }
} else {
    Write-Host "   ⏭️  Python/Pip not installed" -ForegroundColor Gray
}

# ============================================================
# 8. NODE_MODULES IN PROJECT (OPTIONAL - COMMENTED OUT)
# ============================================================
Write-Host "`n📁 Project node_modules" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "   ⏭️  Skipped (uncomment to clean project dependencies)" -ForegroundColor Gray
# Uncomment below to remove node_modules from project (you'll need to run npm install again)
# $totalFreed += Remove-CacheFolder "E:\susclassroom\lms-mvp-tier1\backend\node_modules" "Backend node_modules"
# $totalFreed += Remove-CacheFolder "E:\susclassroom\lms-mvp-tier1\client\node_modules" "Client node_modules"

# ============================================================
# 9. WINDOWS PREFETCH & LOGS
# ============================================================
Write-Host "`n📋 Windows System Cache" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan

$totalFreed += Remove-CacheFolder "C:\Windows\Prefetch" "Prefetch Cache"
$totalFreed += Remove-CacheFolder "$env:LOCALAPPDATA\Microsoft\Windows\Explorer" "Explorer Cache"

# ============================================================
# 10. RECYCLE BIN
# ============================================================
Write-Host "`n🗑️  Recycle Bin" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan

try {
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
    Write-Host "   ✅ Recycle Bin emptied" -ForegroundColor Green
} catch {
    Write-Host "   ⚠️  Could not empty recycle bin" -ForegroundColor Red
}

# ============================================================
# SUMMARY
# ============================================================
Write-Host "`n" -ForegroundColor Cyan
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                    CLEANUP COMPLETE                    ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "💾 Estimated space freed: $([math]::Round($totalFreed, 2)) GB" -ForegroundColor Green
Write-Host ""
Write-Host "💡 Tips:" -ForegroundColor Yellow
Write-Host "   • Run Windows Disk Cleanup for more space (cleanmgr)" -ForegroundColor Gray
Write-Host "   • Use Storage Sense: Settings > System > Storage" -ForegroundColor Gray
Write-Host "   • Check Docker Desktop settings to limit disk usage" -ForegroundColor Gray
Write-Host ""
Write-Host "✨ Done! Your system should feel lighter now." -ForegroundColor Cyan
Write-Host ""

# Pause to see results
Read-Host "Press Enter to exit"
