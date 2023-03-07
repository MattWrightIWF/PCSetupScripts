#Create Temp folder on C
New-Item -Path 'C:\temp' -ItemType Directory

#Download Webroot and place installer in temp
$URL = “https://theiwf-my.sharepoint.com/:u:/g/personal/matt_iwf_org_uk/EcNMUcPs4xFOqriSOXWRUEgBQVwRDKJIh7px_QSx29OdfA?download=1”
$Path=”C:\temp\2a51entpa3186e4748a4.exe”
Invoke-WebRequest -URI $URL -OutFile $Path

#Install Webroot exe located in C:\Temp
$exeFiles = Get-ChildItem -Path $Path -Recurse -Include *.exe
foreach ( $exefile in $exeFiles ) {
  $exefullPath = $exefile.FullName
  Write-Host "Installing '$exefullPath'"
  Start-Process -FilePath $exefullPath -NoNewWindow -ArgumentList "/s","/silent","/passive","/norestart" -Wait
  Write-Host "$exefullPath is finished being installed"
}