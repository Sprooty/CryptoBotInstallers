Write-Host Download latest version of PT Feeder -ForegroundColor green -BackgroundColor black
$InstallPath = Read-Host -Prompt 'Where do you want to install Profit Feeder? eg: C:\ptfeeder'

Write-Host Cleaning up any old folders. Error is expected here. -ForegroundColor green -BackgroundColor black

Remove-Item $InstallPath -Force -Recurse

Write-Host Create new Directory -ForegroundColor green -BackgroundColor black

mkdir $InstallPath

cd $InstallPath

Write-Host Downloading Profit Feeder -ForegroundColor green -BackgroundColor black

$client = new-object System.Net.WebClient
$client.DownloadFile("https://github.com/mehtadone/PTFeeder/releases/download/pt-feeder-v1.3.4.236/pt-feeder-v1.3.4.236.zip",$InstallPath +"PTFeeder.zip")

Write-Host Downloading DotNet -ForegroundColor green -BackgroundColor black

$client = new-object System.Net.WebClient
$client.DownloadFile("https://download.microsoft.com/download/1/1/5/115B762D-2B41-4AF3-9A63-92D9680B9409/dotnet-sdk-2.1.4-win-gs-x64.exe#",$InstallPath +"dotnet-sdk-2.1.4-win-gs-x64.exe")

Expand-Archive -Path $InstallPath\ptfeeder.zip -DestinationPath $InstallPath\ptfeeder -Force

Write-Host Installing Dotnet -ForegroundColor green -BackgroundColor black
.\dotnet-sdk-2.1.4-win-gs-x64.exe /install /passive /norestart

Write-Host Setting Profit Feeder License Key -ForegroundColor green -BackgroundColor black
$PTKey = Read-Host -Prompt 'What is your PT license key'
(Get-Content $InstallPath\ptfeeder\config\hostsettings.json).Replace("`"LicenseKey`": `"`"", "`"LicenseKey`": `"" + $PTKey + "`"") | Set-Content $InstallPath\ptfeeder\config\hostsettings.json

Write-Host LicenseKey set to $PTKEY -ForegroundColor green -BackgroundColor black

$PTKey = Read-Host -Prompt 'What is your PT license key'
[string]$importLic = Get-Content C:\PTFeeder\ptfeeder\config\hostsettings.json
$updatedLic=$importLic.Replace("`"LicenseKey`": `"`"", "`"LicenseKey`": `"" + $PTKey + "`"")
$updatedLic | Set-Content C:\PTFeeder\ptfeeder\config\hostsettings.json


$BinanceProfitTrailerFolder = Read-Host -Prompt 'Where is the root your Profit Trailer folder located for Binance exchange? eg: C:\ProfitTrailer   If you are not using Binance, hit Enter.'
(Get-Content $InstallPath\ptfeeder\config\hostsettings.json).Replace("`"BinancePairsLocation`": `"`"", "`"BinancePairsLocation`": `"" + $BinanceProfitTrailerFolder + "`"") | Set-Content $InstallPath\ptfeeder\config\hostsettings.json

$TrexProfitTrailerFolder = Read-Host -Prompt 'Where is the root your Profit Trailer folder located for Trex exchange? eg: C:\ProfitTrailer         If you are not using Trex, hit Enter.'
(Get-Content $InstallPath\ptfeeder\config\hostsettings.json).Replace("`"TrexPairsLocation`": `"`"", "`"TrexPairsLocation`": `"" + $TrexProfitTrailerFolder + "`"") | Set-Content $InstallPath\ptfeeder\config\hostsettings.json

$PoloProfitTrailerFolder = Read-Host -Prompt 'Where is the root your Profit Trailer folder located for Polinex exchange? eg: C:\ProfitTrailer      If you are not using Polinex, hit Enter.'

#TO DO - FIX#
#(Get-Content $InstallPath\ptfeeder\config\hostsettings.json).Replace("`"PoloPairsLocation`": `"`"C:\\pt\\vps\\pt\\polo\\trading", "`"PoloPairsLocation`": `"" + $PoloProfitTrailerFolder + "`"") | Set-Content $InstallPath\ptfeeder\config\hostsettings3.json 