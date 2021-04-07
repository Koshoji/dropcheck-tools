# 引数チェック
if ($args.Length -le 0 ) {
    Write-Output "Usage: .\ipv6.ps1 <Interface Index> <true or false(dhcp)> <ipv6 address> <prefix length>"
    exit 0
}

# 変数定義
$InterfaceIndex = $args[0]
$InterfaceDhcp = $args[1]
$Ipv6Address = $args[2]
$Ipv6Prefix = $args[3]

if ($InterfaceDhcp -eq "true") {
    Set-NetIPInterface -AddressFamily IPv6 -InterfaceIndex $InterfaceIndex -Dhcp Enabled
} elseif ($InterfaceDhcp -eq "false") {
    Set-NetIPInterface -AddressFamily IPv6 -InterfaceIndex $InterfaceIndex -Dhcp Disabled
    Set-NetIPAddress -AddressFamily IPv6 -InterfaceIndex $InterfaceIndex -IPAddress $Ipv6Address -PrefixLength $Ipv6Prefix
}