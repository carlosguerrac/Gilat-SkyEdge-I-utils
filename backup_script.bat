@echo off

set DOFF="D:\OperationDT\doff.exe"
set ZIP="C:\Program Files\7-Zip\7z.exe"

set CDR_PATH=D:\NMS\outputs\cdrs
set LOG_PATH=D:\NMS\outputs\LOGS

set CDR_ZIP_PATH=D:\OperationDT\BACKUP_FILES\cdrs
set LOG_ZIP_PATH=D:\OperationDT\BACKUP_FILES\LOGS

echo %DOFF%
echo %ZIP%

set COUNT=3


:LOOP

    IF "%COUNT%" == "0" GOTO ENDLOOP


    SET OFFSET=-%COUNT%d

    ECHO %COUNT%
    ECHO %OFFSET%

    REM ************************

    FOR /F %%i IN ('%DOFF% yyyymmdd %OFFSET%') DO set bkday=%%i
    echo %bkday%

    REM  
    REM this is for NMS Log files
    REM

    FOR /F %%i IN ('%DOFF% yyyymmdd %OFFSET%') DO set day=%%i
    echo %day%

    set comando=%ZIP% u %LOG_ZIP_PATH%\LOG_%bkday%.zip %LOG_PATH%\NMS_%day%-????_*.LOG
    echo %comando%
    %comando%

    set comandoDelete=del %LOG_PATH%\NMS_%day%-????_*.LOG
    echo %comandoDelete%
    %comandoDelete%


    REM 
    REM this is for CDR Log files
    REM



    FOR /F %%i IN ('%DOFF% ddmmyyyy %OFFSET%') DO set day=%%i
    echo %day%


    set comando=%ZIP% u %CDR_ZIP_PATH%\CDR_%bkday%.zip %CDR_PATH%\BL%day%_??????.LOG
    echo %comando%
    %comando%


    set comandoDelete=del %CDR_PATH%\BL%day%_??????.LOG
    echo %comandoDelete%
    %comandoDelete%

    REM ************************

    SET /A COUNT-=1
    GOTO LOOP

:ENDLOOP
