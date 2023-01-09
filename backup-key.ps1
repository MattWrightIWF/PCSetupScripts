# BACKUP KEY - new PC setup script, Simon C, 31-3-22
# hacky edit to only 1 option - 4-4-22

$bitlockerstorage = "\\IWF-ITSERV\bitlocker"

Write-Host "This script will export your bitlocker recovery keys to:"
Write-Host "$bitlockerstorage"


$user = "iwfsetup"
$password = Get-Content "iwf.k2" | ConvertTo-SecureString -Key (Get-Content "iwf.k1")
$credential = New-Object System.Management.Automation.PsCredential($user,$password)
$todaysdate = (get-date).ToString("dd-MM-yyyy")


Write-Host "Exporting to $($bitlockerstorage)"
Read-Host "Press Enter to continue or Ctrl + C to quit"

New-PSDrive -Name "blbak" -Root "$($bitlockerstorage)" -PSProvider "FileSystem" -Credential $credential

Write-Host "Saving Bitlocker recovery info to network drive ...."
manage-bde -protectors -get "C:" > "blbak:\$($env:computername) on $todaysdate.txt"
Write-Host "Saving Bitlocker recovery info to C:\TechTools\ ...."
manage-bde -protectors -get "C:" > "C:\TechTools\$($env:computername) on $todaysdate.txt"

Read-Host "Done! Press enter to exit"