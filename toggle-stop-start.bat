@echo off & cd /d "%~dp0"
fsutil dirty query %systemdrive% >nul && goto:GA || nsudo -U:E -P:E -UseCurrentConsole -ShowWindowMode:hide "%~0" %* && exit /b
:GA
sc query NVDisplay.ContainerLocalSystem | find "RUNNING" && goto nvcontainerD || goto nvcontainerE
:nvcontainerD
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NVDisplay.ContainerLocalSystem" /v "Start" /t REG_DWORD /d "3" /f
sc stop NVDisplay.ContainerLocalSystem
reg add "HKCR\DesktopBackground\Shell\0Toggle\shell\4NVCP" /v "icon" /t REG_SZ /d "c:\windows\SystemResources\compstui.dll.mun,-64007" /f
reg add "HKCR\DesktopBackground\Shell\0Toggle\shell\4NVCP" /v "MUIVerb" /t REG_SZ /d "NVCP: Disable" /f
exit
:nvcontainerE
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NVDisplay.ContainerLocalSystem" /v "Start" /t REG_DWORD /d "2" /f
sc start NVDisplay.ContainerLocalSystem
reg add "HKCR\DesktopBackground\Shell\0Toggle\shell\4NVCP" /v "icon" /t REG_SZ /d "c:\windows\SystemResources\compstui.dll.mun,-64008" /f
reg add "HKCR\DesktopBackground\Shell\0Toggle\shell\4NVCP" /v "MUIVerb" /t REG_SZ /d "NVCP: Enable" /f
exit