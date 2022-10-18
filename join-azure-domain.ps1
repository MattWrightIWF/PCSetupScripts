# join azure domain

$user = "iwfsetup"
$password = Get-Content "iwf.k2" | ConvertTo-SecureString -Key (Get-Content "iwf.k1")
$credential = New-Object System.Management.Automation.PsCredential($user,$password)

$ppkgroot = "\\iwf-itserv\software\ppkg\"
$ppkgpath = "ppkg:\iwf.ppkg"

New-PSDrive -Name "ppkg" -Root "$($ppkgroot)" -PSProvider "FileSystem" -Credential $credential

Install-ProvisioningPackage -PackagePath $ppkgpath -ForceInstall -QuietInstall