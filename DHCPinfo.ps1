## Script to gather DHCP info from a remote server and output it to csv
## To do: Create a variable for -ScopeID

## Removing the slashes from logon server output
$pattern = '[\\]'
$dcname = $env:LOGONSERVER
$string = $dcname -replace $pattern, ''

Invoke-Command -ComputerName $string -ScriptBlock {Get-DhcpServerv4Scope -Computername $using:string} | Out-File -FilePath $ENV:UserProfile\Desktop\dhcpinfo.csv
Invoke-Command -ComputerName $string -ScriptBlock {Get-DhcpServerv4OptionValue -Computername $using:string -ScopeID "10.139.123.0"} | Out-File -Append -FilePath $ENV:UserProfile\Desktop\dhcpinfo.csv
