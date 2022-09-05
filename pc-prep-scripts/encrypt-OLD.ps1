# RENAME, EXPAND, ENCRYPT - new PC setup script, Simon C, 30-3-22

$bitlockerstorage = "\\IWF-ITSERV\bitlocker"
$user = "iwfsetup"
$password = Get-Content "iwf.k2" | ConvertTo-SecureString -Key (Get-Content "iwf.k1")
$credential = New-Object System.Management.Automation.PsCredential($user,$password)
$todaysdate = (get-date).ToString("dd-MM-yyyy")


Write-Host "This script will:"
Write-Host "- Encrypt the C:\ drive and store the bitlocker key on $($bitlockerstorage)"
Write-Host " "
Read-Host "Press Enter to continue or Ctrl + C to quit"

New-PSDrive -Name "bls" -Root "$($bitlockerstorage)" -PSProvider "FileSystem" -Credential $credential

Write-Host "Encrypting C: ...."

Enable-Bitlocker -MountPoint c: -UsedSpaceOnly -SkipHardwareTest -RecoveryPasswordProtector

Write-Host "Saving Bitlocker recovery info to network drive ...."
manage-bde -protectors -get "C:" > "bls:\$($hostname) on $todaysdate.txt"
