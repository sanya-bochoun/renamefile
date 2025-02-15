@echo off
setlocal enabledelayedexpansion

echo Script for renaming files to format: t_trn_q_[DATE]
echo ============================================

for %%f in (*.txt *.csv) do (
    set "filename=%%f"
    
    rem แยกส่วนประกอบของชื่อไฟล์
    for /f "tokens=1,2,3,4,5 delims=_" %%a in ("!filename!") do (
        rem ตรวจสอบว่าส่วนแรกเป็น t และมีวันที่ 8 หลัก
        if "%%a"=="t" (
            set "date=%%e"
            set "date=!date:~0,8!"
            
            rem ตรวจสอบว่าเป็นตัวเลข 8 หลัก (วันที่)
            echo !date! | findstr /r "^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]" >nul
            if not errorlevel 1 (
                set "newname=t_trn_q_!date!%%~xf"
                if not "!filename!"=="!newname!" (
                    echo Renaming: !filename! to !newname!
                    ren "!filename!" "!newname!"
                )
            )
        )
    )
)

echo.
echo Process completed.
pause