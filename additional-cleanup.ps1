# ============================================================
# ADDITIONAL DEEP CLEANUP COMMANDS
# ============================================================
# Run these commands manually for more aggressive cleaning
# ============================================================

Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║        ADDITIONAL CLEANUP RECOMMENDATIONS              ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

Write-Host "🔧 QUICK FIXES (run these now):" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

Write-Host "1️⃣  Clean WSL disk (4 GB found):" -ForegroundColor Green
Write-Host "   wsl --shutdown" -ForegroundColor White
Write-Host "   Then optimize virtual disk in WSL settings" -ForegroundColor Gray
Write-Host ""

Write-Host "2️⃣  Clear Docker completely (18.72 GB):" -ForegroundColor Green
Write-Host "   Stop Docker Desktop, then delete:" -ForegroundColor Gray
Write-Host "   C:\Users\braha\AppData\Local\Docker\wsl" -ForegroundColor White
Write-Host ""

Write-Host "3️⃣  Clear Arduino cache (11.21 GB + 2.06 GB):" -ForegroundColor Green
Write-Host "   Remove-Item -Recurse -Force '$env:LOCALAPPDATA\Arduino15\staging'" -ForegroundColor White
Write-Host "   Remove-Item -Recurse -Force '$env:LOCALAPPDATA\arduino\staging'" -ForegroundColor White
Write-Host ""

Write-Host "4️⃣  Clear Chrome cache (11.21 GB in Google folder):" -ForegroundColor Green
Write-Host "   Already cleaned, but Chrome keeps rebuilding it" -ForegroundColor Gray
Write-Host ""

Write-Host "5️⃣  Clear VS Code extensions cache:" -ForegroundColor Green
Write-Host "   Remove-Item -Recurse -Force '$env:USERPROFILE\.vscode\extensions\*\node_modules'" -ForegroundColor White
Write-Host ""

Write-Host "6️⃣  Clear Windows Update cache:" -ForegroundColor Green
Write-Host "   Stop-Service wuauserv" -ForegroundColor White
Write-Host "   Remove-Item -Recurse -Force 'C:\Windows\SoftwareDistribution\Download\*'" -ForegroundColor White
Write-Host "   Start-Service wuauserv" -ForegroundColor White
Write-Host ""

Write-Host "7️⃣  Run Windows Disk Cleanup:" -ForegroundColor Green
Write-Host "   cleanmgr /sageset:1    # Select all items" -ForegroundColor White
Write-Host "   cleanmgr /sagerun:1    # Run cleanup" -ForegroundColor White
Write-Host ""

Write-Host "💡 PERMANENT FIXES:" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "• Docker Desktop Settings > Resources:" -ForegroundColor Gray
Write-Host "  - Limit Disk image size to 20 GB" -ForegroundColor White
Write-Host "  - Enable 'Delete unused images automatically'" -ForegroundColor White
Write-Host ""
Write-Host "• Enable Storage Sense:" -ForegroundColor Gray
Write-Host "  Settings > System > Storage > Storage Sense" -ForegroundColor White
Write-Host "  - Run every week" -ForegroundColor White
Write-Host "  - Delete temp files older than 1 day" -ForegroundColor White
Write-Host ""
Write-Host "• Move Docker data to D: drive (if available):" -ForegroundColor Gray
Write-Host "  Docker Desktop > Settings > Resources > Advanced" -ForegroundColor White
Write-Host "  Change 'Disk image location'" -ForegroundColor White
Write-Host ""

Write-Host "📊 ESTIMATED RECOVERY:" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  Already freed:  6.08 GB" -ForegroundColor Green
Write-Host "  Docker cleanup: ~15 GB (if you stop and reset Docker)" -ForegroundColor Yellow
Write-Host "  Arduino cache:  ~13 GB" -ForegroundColor Yellow  
Write-Host "  WSL optimize:   ~3 GB" -ForegroundColor Yellow
Write-Host "  Windows Update: ~2 GB" -ForegroundColor Yellow
Write-Host "  ──────────────────────" -ForegroundColor Gray
Write-Host "  TOTAL POSSIBLE: ~39 GB" -ForegroundColor Green
Write-Host ""

Write-Host "⚠️  WARNING:" -ForegroundColor Red
Write-Host "  Only delete Docker data if you can rebuild containers!" -ForegroundColor Red
Write-Host "  Arduino cache will re-download when needed" -ForegroundColor Yellow
Write-Host ""
