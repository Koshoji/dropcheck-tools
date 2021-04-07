Write-Output "### Trace to Service Chainning(IPv4) ###"
tracert 10.0.15.8
tracert 45.0.14.8
ping -4 -f -l 1472 45.0.16.8
Write-Output "### Ping to Service Chainning(IPv6) ###"
ping -6 -l 1452 2001:3E8::14:8
ping -6 -l 1452 2001:3E8::15:8