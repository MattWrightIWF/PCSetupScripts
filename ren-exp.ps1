# RENAME, EXPAND, ENCRYPT - new PC setup script, Simon C, 30-3-22

$bitlockerstorage = "\\IWF-ITSERV\bitlocker"
$user = "iwfsetup"
$password = Get-Content "iwf.k2" | ConvertTo-SecureString -Key (Get-Content "iwf.k1")
$credential = New-Object System.Management.Automation.PsCredential($user,$password)
$todaysdate = (get-date).ToString("dd-MM-yyyy")


Write-Host "This script will:"
Write-Host "- Expand the C:\ partition to fill available space on drive"
Write-Host "- Rename the PC to your desired hostname"
Write-Host " "
Read-Host "Press Enter to continue or Ctrl + C to quit"


Write-Host "Expanding C: ...."
Resize-Partition -DriveLetter C -Size $(Get-PartitionSupportedSize -DriveLetter C).SizeMax

$hostname = Read-Host "Please enter new or re-enter existing hostname, e.g. IWF0001, and press enter"

Write-Host "Renaming PC ...."

Rename-Computer -NewName $hostname -Force -Passthru

Read-Host "Done! Press enter to continue and reboot the PC, NOTE:Reboot will start in 30 seconds"

Start-Sleep -s 3
Restart-Computer
