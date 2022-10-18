# join azure domain - SC 18-10-22

$user = "iwfsetup"
$password = Get-Content "iwf.k2" | ConvertTo-SecureString -Key (Get-Content "iwf.k1")
$credential = New-Object System.Management.Automation.PsCredential($user,$password)

New-PSDrive -Name "adj" -PSProvider "FileSystem" -Root "\\iwf-itserv\software\ppkg" -Credential $credential -Scope Global

New-Item -Type dir "c:\TechTools\ppkg\" -Force
Copy-Item -Path "adj:\iwf.ppkg" -Destination "c:\TechTools\ppkg\" 

Remove-PSDrive -Name "adj"

Install-ProvisioningPackage -PackagePath 'c:\TechTools\ppkg\iwf.ppkg'