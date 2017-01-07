@echo off

SET VAGRANTOPT1=reload
SET VAGRANTOPT2=centos71

SET LOGFILE=%DATE:/=%-%TIME:~0,2%%TIME:~3,2%_vagrant-%VAGRANTOPT1%.log
REM SET LOGFILE=%DATE:/=%_vagrant-%VAGRANTOPT1%.log
SET CURDIR=%~dp0


IF NOT EXIST %CURDIR%logs (
	mkdir %CURDIR%logs
) 


echo ########################## >> "%CURDIR%logs\%LOGFILE%"
start "%LOGFILE%" C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe "Get-Content -Path '%CURDIR%logs\%LOGFILE%' -Wait -Tail 1"
REM start "%LOGFILE%" C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe "tail -f '%CURDIR%logs\%LOGFILE%'"

echo -- %date% %time% start. >> "%CURDIR%logs\%LOGFILE%"

SET MES=vagrant %VAGRANTOPT1% %VAGRANTOPT2%
echo %MES% >> "%CURDIR%logs\%LOGFILE%"

@echo on
vagrant %VAGRANTOPT1% %VAGRANTOPT2% >> "%CURDIR%logs\%LOGFILE%" 2>&1

@echo off
taskkill /im powershell.exe
echo -- %date% %time% end. -- >> "%CURDIR%logs\%LOGFILE%"

@call cmd
