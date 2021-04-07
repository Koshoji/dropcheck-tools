# 引数チェック
if ($args.Length -le 0 ) {
    Write-Output "Usage: .\ipv4.ps1 <Interface Index> <true or false(dhcp)> <ipv4 address> <prefix length> <gateway>"
    exit 0
}

# 変数定義
$InterfaceIndex = $args[0]
$InterfaceDhcp = $args[1]
$Ipv4Address = $args[2]
$Ipv4Prefix = $args[3]
$Gateway = $args[4]

if ($InterfaceDhcp -eq "true") {
    Set-NetIPInterface -AddressFamily IPv4 -InterfaceIndex $InterfaceIndex -Dhcp Enabled
} elseif ($InterfaceDhcp -eq "false") {
    Set-NetIPInterface -AddressFamily IPv4 -InterfaceIndex $InterfaceIndex -Dhcp Disabled
    Set-NetIPAddress -AddressFamily IPv4 -InterfaceIndex $InterfaceIndex -IPAddress $Ipv4Address -PrefixLength $Ipv4Prefix -DefaultGateway $Gateway
    Set-NetIPInterface -InterfaceIndex $InterfaceIndex -ServerAddresses 1.1.1.1
}