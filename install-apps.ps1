# APP INSTALL - new PC setup script, Matt W, 25/08/2022 - updates by Simon C 13-10-22 for SMB network "approot" folder + adding poweruser

$user = "iwfsetup"
$password = Get-Content "iwf.k2" | ConvertTo-SecureString -Key (Get-Content "iwf.k1")
$credential = New-Object System.Management.Automation.PsCredential($user,$password)
$approotlan = "\\iwf-itserv\software"
$approot = "software:"

Write-Host "This script will install applications relevant to this PC's use"
Write-Host "Please ensure you're connected to the OFFICE network and $approotlan is accessible"
Write-Host "1 - Hotline Desktop"
Write-Host "2 - Office - On Site Desktop"
Write-Host "3 - Office - Laptop / Roaming Desktop"
Write-Host "4 - Airgap / Hashing computer"
Write-Host "5 - Power User - includes all of the above + extras"

$purpchoice = Read-Host "Please enter 1 to 4:"

New-PSDrive -Name "software" -Root "$($approotlan)" -PSProvider "FileSystem" -Credential $credential

if ($purpchoice -eq '1') {
Write-Host "Setting up as Hotline desktop...."
$softwarelocation = "$approot\hotline-n-office", "$approot\hotline"
$ninitename = "$approot\ninite\hotline-n-office"
}


if ($purpchoice -eq '2') {
Write-Host "Setting up as Office on site..."
$softwarelocation = "$approot\hotline-n-office", "$approot\office"
$ninitename = "$approot\ninite\hotline-n-office"
}


if ($purpchoice -eq '3') {
Write-Host "Setting up as Office roaming..."
$softwarelocation = "$approot\hotline-n-office", "$approot\office", "$approot\roaming"
$ninitename = "$approot\ninite\hotline-n-office", "$approot\ninite\roaming"
}


if ($purpchoice -eq '4') {
Write-Host "Setting up as Airgap machine..."
$softwarelocation = "$approot\airgap"
$ninitename = "$approot\ninite\airgap"
}

if ($purpchoice -eq '5') {
Write-Host "Setting up as Power User machine..."
$softwarelocation = "$approot\hotline-n-office", "$approot\hotline", "$approot\office", "$approot\roaming", "$approot\poweruser"
$ninitename = "$approot\ninite\hotline-n-office", "$approot\ninite\poweruser"
}

& 'C:\Windows\notepad.exe' "$approot\keys.txt"

$ninFiles = Get-ChildItem -Path $ninitename -Recurse -Include *.exe
foreach ( $ninfile in $ninFiles ) {
  $ninfullPath = $ninfile.FullName
  Write-Host "Installing '$ninfullPath'"
  Start-Process -FilePath $ninfullPath -NoNewWindow  -ArgumentList -Wait
  Write-Host "$ninfullPath is finished being installed"
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
Write-Host "Software installation complete!"