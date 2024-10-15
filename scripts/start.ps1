Write-Host "Creando adb reverse al puerto 8080" -ForegroundColor Magenta
adb reverse --remove-all
adb reverse tcp:8080 tcp:3090

Write-Host "Proxy inverso: http://localhost:3090" -ForegroundColor Cyan
Write-Host "URL para dispositivo: http://localhost:8080 (Ok)" -ForegroundColor Green
node proxy-server.js
