# DOMAIN JOIN - new PC setup script, Matt W, 25/08/22

$user = "iwfsetup"
$password = Get-Content "iwf.k2" | ConvertTo-SecureString -Key (Get-Content "iwf.k1")
$credential = New-Object System.Management.Automation.PsCredential($user,$password)
$approot = "C:\TechTools\software"


Write-Host "This script will join domain as below"
Write-Host "1 - Hotline"
Write-Host "2 - Office"
Write-Host "3 - AIRGAP"
Write-Host " "
$purpchoice = Read-Host "Please enter 1 to 3:"
Write-Host " "

if ($purpchoice -eq '1') {
$domain = "iwfhotline.org.uk" <# hotline LOCAL #>
Write-Host "Setting up as Hotline desktop...."
Read-Host "Please ensure this PC is connected to the HOTLINE Network and press enter"
}

if ($purpchoice -eq '2') {
$domain = "iwforguk.local" <# office LOCAL #>
Write-Host "Setting up as Office on site..."
Read-Host "Please ensure this PC is connected to the OFFICE Network and press enter"
}

if ($purpchoice -eq '3') {
$domain = "hotline.local" <# airgap LOCAL #>
Write-Host "Setting up as AIRGAP..."
Read-Host "Please ensure this PC is connected to the OFFICE Network and press enter"
}

Write-Host " "
Read-Host "Press Enter to continue and join the domain. Computer will restart"
 Add-Computer -DomainName $domain -Credential $credential -Restart
if ($Host.Name -eq "ConsoleHost")

#Fixes bug in windows to allow powershell script to run as admin
{
    Write-Host "Press any key to continue..."
    $Host.UI.RawUI.FlushInputBuffer()   # Make sure buffered input doesn't "press a key" and skip the ReadKey().
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
}
