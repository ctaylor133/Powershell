## Short script to grab the bad leases from a DHCP server, delete them, wait 30 seconds and print out how many bad leases there are.
## TO do -- make varriable for fetching ScopeID(s)
## Run the below command by itself and grab the ScopID and replace "IP" in line 5
### Get-DhcpServerv4Scope

$scope = "IP"

Get-DhcpServerv4Scope -ScopeId $scope | Get-DhcpServerv4Lease -BadLeases | Remove-DhcpServerv4Lease


Start-Sleep -Seconds 30



(Get-DhcpServerv4Scope -ScopeId $scope | Get-DhcpServerv4Lease -BadLeases).Length
