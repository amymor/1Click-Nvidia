@echo off & cd /d "%~dp0"
fsutil dirty query %systemdrive% >nul && goto:GA || nsudo -U:E -P:E -UseCurrentConsole "%~0" %* && exit /b
:GA
echo.
echo [33m Add to Desktop right click [0m
:: menu
reg add "HKCR\DesktopBackground\Shell\0Toggle" /v "SeparatorBefore" /t REG_SZ /d "" /f
reg add "HKCR\DesktopBackground\Shell\0Toggle" /v "SubCommands" /t REG_SZ /d "" /f
reg add "HKCR\DesktopBackground\Shell\0Toggle" /v "Icon" /t REG_SZ /d "c:\windows\system32\mmsys.cpl,-115" /f
reg add "HKCR\DesktopBackground\Shell\0Toggle" /v "MUIVerb" /t REG_SZ /d "Toggle Disable/Enable" /f
:: sub-menu
reg add "HKCR\DesktopBackground\Shell\0Toggle\shell\4NVCP" /v "icon" /t REG_SZ /d "c:\windows\SystemResources\compstui.dll.mun,-64008" /f
reg add "HKCR\DesktopBackground\Shell\0Toggle\shell\4NVCP" /v "MUIVerb" /t REG_SZ /d "NVCP: Enable" /f
reg add "HKCR\DesktopBackground\Shell\0Toggle\shell\4NVCP\command" /ve /t REG_SZ /d "\"%~dp0toggle-stop-start.bat\"" /f
echo.
pause
exit