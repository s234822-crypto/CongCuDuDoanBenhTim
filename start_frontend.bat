@echo off
chcp 65001 >nul
echo.
echo ============================================
echo   CardioPredict AI - Frontend (Vite/React)
echo   Port: 5175
echo ============================================
echo.

REM Kiểm tra Node.js đã cài chưa
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [LOI] Khong tim thay Node.js. Hay cai Node.js 18+ truoc.
    pause
    exit /b 1
)

cd /d "%~dp0Fontend"

REM Cài node_modules nếu chưa có
if not exist "node_modules\" (
    echo [INFO] Cai dat node_modules...
    npm install
)

echo.
echo [INFO] Khoi dong Frontend Dev Server...
echo [INFO] Frontend se chay tai: http://localhost:5175/CongCuDuDoanBenhTim/
echo [INFO] Dam bao Backend API dang chay tai port 5001 truoc khi mo trang.
echo [INFO] Nhan CTRL+C de dung server.
echo.
npm run dev
pause
