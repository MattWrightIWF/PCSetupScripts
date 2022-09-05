# AZURE DOMAIN JOIN - new PC setup script, Matt W, 25/08/22

#Step 1 – Grab Current Device Name
set PCName1=%computername%

#Step 2 – Install PPKG
c:\windows\system32\provtool.exe C:\TechTools\iwfprov\IWF.ppkg /quiet

#Step 3 – Rename Machine
WMIC ComputerSystem where Name="%computername%" call Rename Name="%PCName1%"

#Step 4 – Apply Reg Keys with Original Device Name

reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\ComputerName\ComputerName" /v ComputerName /t REG_SZ /d "%PCName1%" /f

reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v HostName /t REG_SZ /d "%PCName1%" /f

reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters" /v "NV Hostname” /t REG_SZ /d "%PCName1%" /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Provisioning\NodeCache\CSP\Device\MS DM Server\Nodes\1" /v ExpectedValue /t REG_SZ /d "%PCName1%" /f /reg:64

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability” /v LastComputerName /t REG_SZ /d "%PCName1%" /f /reg:64

reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Tcpip\Parameters\DNSRegisteredAdapters\{FC5B1177-F053-4F20-A47F-063553C16BED}" /v Hostname /t REG_SZ /d "%PCName1%"
