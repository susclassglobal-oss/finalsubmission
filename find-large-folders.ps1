# Find large folders/files on C drive
Write-Host "🔍 Scanning for large folders (this may take a minute)..." -ForegroundColor Cyan
Write-Host ""

# Common cache locations to check
$locations = @(
    "$env:LOCALAPPDATA",
    "$env:APPDATA",
    "$env:TEMP",
    "C:\Windows\Temp",
    "C:\ProgramData"
)

$results = @()

foreach ($location in $locations) {
    if (Test-Path $location) {
        Write-Host "Scanning: $location" -ForegroundColor Gray
        
        Get-ChildItem $location -Directory -ErrorAction SilentlyContinue | ForEach-Object {
            $size = 0
            try {
                $size = (Get-ChildItem $_.FullName -Recurse -Force -ErrorAction SilentlyContinue | 
                        Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
            } catch {}
            
            if ($size -gt 100MB) {
                $results += [PSCustomObject]@{
                    Path = $_.FullName
                    SizeGB = [math]::Round($size / 1GB, 2)
                }
            }
        }
    }
}

Write-Host ""
Write-Host "📊 Folders larger than 100 MB:" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host ""

$results | Sort-Object SizeGB -Descending | Select-Object -First 20 | Format-Table -AutoSize

Write-Host ""
Write-Host "💡 Consider cleaning:" -ForegroundColor Cyan
Write-Host "   • Microsoft Teams cache: $env:APPDATA\Microsoft\Teams" -ForegroundColor Gray
Write-Host "   • OneDrive cache: $env:LOCALAPPDATA\Microsoft\OneDrive" -ForegroundColor Gray
Write-Host "   • Windows Update: C:\Windows\SoftwareDistribution" -ForegroundColor Gray
Write-Host ""
