Write-Host "Creando adb reverse al puerto 8080" -ForegroundColor Magenta
adb -s R5CWB1TZMBR reverse --remove-all
adb -s R5CWB1TZMBR reverse tcp:8080 tcp:3090

Write-Host "Proxy inverso: http://localhost:3090" -ForegroundColor Cyan
Write-Host "URL para dispositivo: http://localhost:8080 (Ok)" -ForegroundColor Green
node proxy-server.js
