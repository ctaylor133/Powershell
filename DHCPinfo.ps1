## Script to gather DHCP info from a remote server and output it to csv
## To do: Create a variable for -ScopeID
## To do: Create option for Poller DHCP servers
Set-ExecutionPolicy -ExecutionPolicy Bypass

$Header = @"
<style>
TABLE {border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}
TH {border-width: 1px; padding: 3px; border-style: solid; border-color: black; background-color: #6495ED;}
TD {border-width: 1px; padding: 3px; border-style: solid; border-color: black;}
</style>
"@

## Removing the slashes from logon server output
$pattern = '[\\]'
$dcname = $env:LOGONSERVER
$string = $dcname -replace $pattern, ''



Invoke-Command -ComputerName $string -ScriptBlock {Get-DhcpServerv4Scope -Computername $using:string} | Select @{Expression={$_.PSComputerName};Label="Server Name"}, @{Expression={$_.SubnetMask};Label="SubnetMask"}, @{Expression={$_.ScopeID};Label="ScopeID"}, @{Expression={$_.LeaseDuration};Label="Lease Time"} | ConvertTo-Html -Head $Header | Out-File -FilePath $ENV:UserProfile\Desktop\dhcpinfo.html
Invoke-Command -ComputerName $string -ScriptBlock {Get-DhcpServerv4OptionValue -Computername $using:string -ScopeID "10.139.123.0"} | Select @{Expression={$_.Name};Label="DNS Name"}, @{Expression={$_.Value};Label="DNS Servers"} | ConvertTo-Html -Head $Header | Out-File -Append -FilePath $ENV:UserProfile\Desktop\dhcpinfo.html
Invoke-Command -ComputerName $string {[Net.ServicePointManager]::SecurityProtocol} | select @{Expression={$_.PSComputername};Label="Server"}, @{Expression={$_.value};Label="TLS"} | ConvertTo-Html -Head $Header | Out-File -Append -FilePath $ENV:UserProfile\Desktop\dhcpinfo.html
