# 引数チェック
if ($args.Length -le 0 ) {
    Write-Output "Usage: .\dropcheck.ps1 <Interface Index>"
    exit 0
}

# 変数定義
$InterfaceIndex = $args[0]
Write-Output " ____                        ____  _          _ _       _      "
Write-Output "|  _ \ _____      _____ _ __/ ___|| |__   ___| | |   __| | ___"
Write-Output "| |_) / _ \ \ /\ / / _ \ '__\___ \| '_ \ / _ \ | |  / _` |/ _ \"
Write-Output "|  __/ (_) \ V  V /  __/ |   ___) | | | |  __/ | | | (_| |  __/"
Write-Output "|_|   \___/ \_/\_/ \___|_|  |____/|_| |_|\___|_|_|  \__,_|\___|"
Write-Output "`r`n"
Write-Output " ____  ____   ___  ____   ____ _   _ _____ ____ _  __"
Write-Output "|  _ \|  _ \ / _ \|  _ \ / ___| | | | ____/ ___| |/ /"
Write-Output "| | | | |_) | | | | |_) | |   | |_| |  _|| |   | ' /"
Write-Output "| |_| |  _ <| |_| |  __/| |___|  _  | |__| |___| . \"
Write-Output "|____/|_| \_\\___/|_|    \____|_| |_|_____\____|_|\_\"



# IPCheck
Write-Output "####################"
Write-Output "### IPv4 Address ###"
Write-Output "####################"
Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex $InterfaceIndex | Select-Object IPAddress | Out-String
Write-Output "####################"
Write-Output "### IPv6 Address ###"
Write-Output "####################"
Get-NetIPAddress -AddressFamily IPv6 -InterfaceIndex $InterfaceIndex | Select-Object IPAddress | Out-String

# Default Gateway
Write-Output "#########################"
Write-Output "### Default Route IPv4###"
Write-Output "#########################"
$gwv4 = Get-Netroute -InterfaceIndex $InterfaceIndex -DestinationPrefix "0.0.0.0/0" | Select-Object NextHop 2> $null
Write-Output ("GWv4:   " + $gwv4.NextHop + "`r`n")
Write-Output "#########################"
Write-Output "### Default Route IPv6###"
Write-Output "#########################"
$gwv6 = Get-Netroute -InterfaceIndex $InterfaceIndex -DestinationPrefix "::/0" | Select-Object NextHop 2> $null
Write-Output ("GWv6:   " + $gwv6.NextHop + "`r`n")

# ping
Write-Output "##############################"
Write-Output "### Ping to Gateway (IPv4) ###"
Write-Output "##############################"
ping -4 -f -l 1472 -w 1 $gwv4.NextHop
Write-Output "##############################"
Write-Output "### Ping to Gateway (IPv6) ###"
Write-Output "##############################"+++
$gwv6 = $gwv6 | Select-Object -Index 0
ping -6 -l 1452 ($gwv6.NextHop + "%" + $InterfaceIndex)
Write-Output "############################3##"
Write-Output "### Ping to Internet (IPv4) ###"
Write-Output "###############################"
ping -4 -f -l 1472 -w 1 211.129.51.61
ping -4 -f -l 1472 -w 1 113.157.238.33
ping -4 -f -l 1472 -w 1 219.67.157.20
tracert -4 -d -h 3 211.129.51.61
tracert -4 -d -h 3 113.157.238.33
tracert -4 -d -h 3 219.67.157.20

tracert -4 -d -h 3 1.1.1.1
Write-Output "###############################"
Write-Output "### Ping to Internet (IPv6) ###"
Write-Output "###############################"
ping -6 -l 1452 -w 1 2001:380:0:242b::1
ping -6 -l 1452 -w 1 2001:268:800::1
ping -6 -l 1434 -w 1 2400:2000:bb1b:0::10
tracert -6 -d -h 3 2606:4700:4700::1111

# DNS
Write-Output "#######################"
Write-Output "### DNS Check(IPv4) ###"
Write-Output "#######################"
#ipconfig /flushdns
#nslookup jprs.co.jp 1.1.1.1
wsl --exec dig `@1.1.1.1 jprs.co.jp +short
Write-Output "#######################"
Write-Output "### DNS Check(IPv6) ###"
Write-Output "#######################"
#ipconfig /flushdns
#nslookup -q=AAAA jprs.co.jp 2606:4700:4700::1111
wsl --exec dig `@2606:4700:4700::1111 jprs.co.jp +short

# Web
Write-Output "#######################"
Write-Output "### Web Check(IPv4) ###"
Write-Output "#######################"
#$webv4 = Start-Process "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList " --incognito ipv4.google.com" -PassThru
#Start-Sleep -s 10
#Stop-Process $webv4
wsl --exec curl -4 https://ipv4.google.com -s -o /dev/null -w  "Code:%{http_code}, Response_time:%{time_starttransfer}\n"

Write-Output "#######################"
Write-Output "### Web Check(IPv6) ###"
Write-Output "#######################"
#s$webv6 = Start-Process "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList " --incognito ipv6.google.com" -PassThru
#sStart-Sleep -s 10
#sStop-Process $webv6
wsl --exec curl -6 https://ipv6.google.com -s -o /dev/null -w  "Code:%{http_code}, Response_time:%{time_starttransfer}\n"

# 10.0.15.8, 45.0.14.8, 45.0.16.8