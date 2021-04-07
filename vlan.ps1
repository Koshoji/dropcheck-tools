# 引数チェック
if ($args.Length -le 0 ) {
    Write-Output "Usage: .\vlan.ps1 <add or del> <vlan id>"
    exit 0
}

# 変数定義
$ParentName ="Intel(R) Ethernet Connection (4) I219-LM"
$Method = $args[0]
$VlanId = $args[1]

if ($Method -like "add") {
    Add-IntelNetVLAN -ParentName $ParentName -VLANID $VlanId
} elseif ($Method -like "del") {
    Remove-IntelNetVLAN -ParentName $ParentName -VLANID $VlanId
}