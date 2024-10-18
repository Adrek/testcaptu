Write-Host "Creando adb reverse al puerto 8080" -ForegroundColor Magenta
adb -s da6fd591 reverse --remove-all
adb -s da6fd591 reverse tcp:8080 tcp:3090

Write-Host "Proxy inverso: http://localhost:3090" -ForegroundColor Cyan
Write-Host "URL para dispositivo: http://localhost:8080 (Ok)" -ForegroundColor Green
node proxy-server.js
