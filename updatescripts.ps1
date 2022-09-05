$Url = 'https://github.com/MattWrightIWF/PCSetupScripts/archive/refs/heads/main.zip'
$ZipFile = 'C:\TechTools\Scripts' + $(Split-Path -Path $Url -Leaf)
$Destination= 'C:\TechTools\Scripts'

rm $Destination\*.ps1
rm $Destination\*.bat

Invoke-WebRequest -Uri $Url -OutFile $ZipFile

$ExtractShell = New-Object -ComObject Shell.Application
$Files = $ExtractShell.Namespace($ZipFile).Items()
$ExtractShell.NameSpace($Destination).CopyHere($Files)
Start-Process $Destination

rm $ZipFile

Move-Item -Path C:\TechTools\Scripts\PCSetupScripts-main\* -Destination C:\TechTools\Scripts\ -force

rm C:\TechTools\Scripts\PCSetupScripts-main\
