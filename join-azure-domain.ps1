# join azure domain - SC 18-10-22

$user = "iwfsetup"
$password = Get-Content "iwf.k2" | ConvertTo-SecureString -Key (Get-Content "iwf.k1")
$credential = New-Object System.Management.Automation.PsCredential($user,$password)

Copy-Item -Path '\\iwf-itserv\software\ppkg\' -Destination 'c:\TechTools\ppkg\' -Credential $credential

Install-ProvisioningPackage -PackagePath 'c:\TechTools\ppkg\iwf.ppkg'