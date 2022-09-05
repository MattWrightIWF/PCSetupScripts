# APP INSTALL - new PC setup script, Matt W, 25/08/2022

$user = "iwfsetup"
$password = Get-Content "iwf.k2" | ConvertTo-SecureString -Key (Get-Content "iwf.k1")
$credential = New-Object System.Management.Automation.PsCredential($user,$password)
$approot = "C:\TechTools\software"


Write-Host "This script will install applications relevant to this PC's use"
Write-Host "1 - Hotline Desktop"
Write-Host "2 - Office - On Site Desktop"
Write-Host "3 - Office - Laptop / Roaming Desktop"
Write-Host "4 - Airgap / Hashing computer"
Write-Host " "
$purpchoice = Read-Host "Please enter 1 to 4:"
Write-Host " "

& 'C:\Windows\notepad.exe' "$approot\keys.txt"

if ($purpchoice -eq '1') {
Write-Host "Setting up as Hotline desktop...."
Read-Host "Please ensure this PC is connected to the HOTLINE Network and press enter"
$softwarelocation = "$approot\hotline-n-office", "$approot\hotline"
}


if ($purpchoice -eq '2') {
Write-Host "Setting up as Office on site..."
Read-Host "Please ensure this PC is connected to the OFFICE Network and press enter"
$softwarelocation = "$approot\hotline-n-office", "$approot\office"
}


if ($purpchoice -eq '3') {
Write-Host "Setting up as Office roaming..."
Read-Host "Please ensure this PC is connected to the OFFICE Network and press enter"
$softwarelocation = "$approot\hotline-n-office", "$approot\office", "$approot\roaming"
}


if ($purpchoice -eq '4') {
Write-Host "Setting up as Airgap machine..."
Read-Host "Please ensure this PC is connected to the AIRGAP Network and press enter"
$softwarelocation = "$approot\airgap"
}

$exeFiles = Get-ChildItem -Path $softwarelocation -Recurse -Include *.exe

foreach ( $exefile in $exeFiles ) {
  $exefullPath = $exefile.FullName
  Write-Host "Installing '$exefullPath'"
  Start-Process -FilePath $exefullPath -NoNewWindow  -ArgumentList '/silent', '/install' -Wait
  Write-Host "$exefullPath is finished being installed"
}

$msiFiles = Get-ChildItem -Path $softwarelocation -Recurse -Include *.msi

foreach ( $msifile in $msiFiles ) {
  $msifullPath = $msifile.FullName
  Write-Host "Installing '$msifullPath'"
  Start-Process -FilePath msiexec.exe -ArgumentList "/I `"$msifullPath`"","/qb","ADDLOCAL=ALL","ALLUSERS=TRUE" -Wait
  Write-Host "$msifullPath is finished being installed"
}

Write-Host " "
Write-Host "Software installation complete! - Hopefully :)"
