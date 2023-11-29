### Connect to vSphere ###

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 
Set-ExecutionPolicy RemoteSigned

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false 

Connect-VIServer -Server #vCenter IP# -User administrator@vsphere.local -Password #vCenter Password#

## Fill out Varriables 
$subnet = "255.255.255.0"       
$gateway = ""
$dnsServers = ""                ## I think this can be comma seperated, need to test
$domain = ""                    ## fqdn
$ip = "0.0.0"                 ## First 3 octets with no period
$user = ""                      ## domain admin
$password = ""                  ## domain password
$adpassword = ""                ## domain admin password
$license = ""                   ## Windows product key with dashes-
$Name ""                        #Organization Owner
$Time ""                        #Timezone example "Central (U.S. and Canada)", more examples here: https://vdc-download.vmware.com/vmwb-repository/dcr-public/73d6de02-05fd-47cb-8f73-99d1b33aea17/850c6b63-eb82-4d9c-bfcf-79279b5e5637/doc/New-OSCustomizationSpec.html
##  repeat line 24 and 41-42 for as many VM's needed to be created. Line 24 builds the Custom Spec and line 41-42 adds the IP to it. Increment the numbers in $vmname, $oscust and $ip.$vmip

$oscust1 = New-OSCustomizationSpec -Name ($vmname1 = Read-host "Enter 1st VM name")  -FullName $Name -OrgName "whitecloud" -OSType "Windows" -NamingScheme "vm" -ProductKey $license -AutoLogonCount 0 -TimeZone $Time -AdminPassword $adpassword -Domain $domain -DomainUsername $user -DomainPassword $password -ChangeSid
$oscust2 = New-OSCustomizationSpec -Name ($vmname2 = Read-host "Enter 2nd VM name") -FullName $Name  -OrgName "whitecloud" -OSType "Windows" -NamingScheme "vm" -ProductKey $license -AutoLogonCount 0 -TimeZone $Time -AdminPassword $adpassword -Domain $domain -DomainUsername $user -DomainPassword $password -ChangeSid
$oscust3 = New-OSCustomizationSpec -Name ($vmname3 = Read-host "Enter 3rd VM name")  -FullName $Name -OrgName "whitecloud" -OSType "Windows" -NamingScheme "vm" -ProductKey $license -AutoLogonCount 0 -TimeZone $Time -AdminPassword $adpassword -Domain $domain -DomainUsername $user -DomainPassword $password -ChangeSid
$oscust4 = New-OSCustomizationSpec -Name ($vmname4 = Read-host "Enter 4th VM name") -FullName $Name  -OrgName "whitecloud" -OSType "Windows" -NamingScheme "vm" -ProductKey $license -AutoLogonCount 0 -TimeZone $Time -AdminPassword $adpassword -Domain $domain -DomainUsername $user -DomainPassword $password -ChangeSid
$oscust5 = New-OSCustomizationSpec -Name ($vmname5 = Read-host "Enter 5th VM name")  -FullName $Name -OrgName "whitecloud" -OSType "Windows" -NamingScheme "vm" -ProductKey $license -AutoLogonCount 0 -TimeZone $Time -AdminPassword $adpassword -Domain $domain -DomainUsername $user -DomainPassword $password -ChangeSid
$oscust6 = New-OSCustomizationSpec -Name ($vmname6 = Read-host "Enter 6th VM name") -FullName $Name  -OrgName "whitecloud" -OSType "Windows" -NamingScheme "vm" -ProductKey $license -AutoLogonCount 0 -TimeZone $Time -AdminPassword $adpassword -Domain $domain -DomainUsername $user -DomainPassword $password -ChangeSid
$oscust7 = New-OSCustomizationSpec -Name ($vmname7 = Read-host "Enter 7th VM name")  -FullName $Name -OrgName "whitecloud" -OSType "Windows" -NamingScheme "vm" -ProductKey $license -AutoLogonCount 0 -TimeZone $Time -AdminPassword $adpassword -Domain $domain -DomainUsername $user -DomainPassword $password -ChangeSid
$oscust8 = New-OSCustomizationSpec -Name ($vmname8 = Read-host "Enter 8th VM name") -FullName $Name  -OrgName "whitecloud" -OSType "Windows" -NamingScheme "vm" -ProductKey $license -AutoLogonCount 0 -TimeZone $Time -AdminPassword $adpassword -Domain $domain -DomainUsername $user -DomainPassword $password -ChangeSid
$oscust9 = New-OSCustomizationSpec -Name ($vmname9 = Read-host "Enter 9th VM name")  -FullName $Name -OrgName "whitecloud" -OSType "Windows" -NamingScheme "vm" -ProductKey $license -AutoLogonCount 0 -TimeZone $Time -AdminPassword $adpassword -Domain $domain -DomainUsername $user -DomainPassword $password -ChangeSid
$oscust10 = New-OSCustomizationSpec -Name ($vmname10 = Read-host "Enter 10th VM name") -FullName $Name  -OrgName "whitecloud" -OSType "Windows" -NamingScheme "vm" -ProductKey $license -AutoLogonCount 0 -TimeZone $Time -AdminPassword $adpassword -Domain $domain -DomainUsername $user -DomainPassword $password -ChangeSid
$oscust11 = New-OSCustomizationSpec -Name ($vmname11 = Read-host "Enter 11th VM name")  -FullName $Name -OrgName "whitecloud" -OSType "Windows" -NamingScheme "vm" -ProductKey $license -AutoLogonCount 0 -TimeZone $Time -AdminPassword $adpassword -Domain $domain -DomainUsername $user -DomainPassword $password -ChangeSid
$oscust12 = New-OSCustomizationSpec -Name ($vmname12 = Read-host "Enter 12th VM name") -FullName $Name  -OrgName "whitecloud" -OSType "Windows" -NamingScheme "vm" -ProductKey $license -AutoLogonCount 0 -TimeZone $Time -AdminPassword $adpassword -Domain $domain -DomainUsername $user -DomainPassword $password -ChangeSid
$oscust13 = New-OSCustomizationSpec -Name ($vmname13 = Read-host "Enter 13th VM name")  -FullName $Name -OrgName "whitecloud" -OSType "Windows" -NamingScheme "vm" -ProductKey $license -AutoLogonCount 0 -TimeZone $Time -AdminPassword $adpassword -Domain $domain -DomainUsername $user -DomainPassword $password -ChangeSid
$oscust14 = New-OSCustomizationSpec -Name ($vmname14 = Read-host "Enter 14th VM name") -FullName $Name  -OrgName "whitecloud" -OSType "Windows" -NamingScheme "vm" -ProductKey $license -AutoLogonCount 0 -TimeZone $Time -AdminPassword $adpassword -Domain $domain -DomainUsername $user -DomainPassword $password -ChangeSid
$oscust15 = New-OSCustomizationSpec -Name ($vmname15 = Read-host "Enter 15th VM name")  -FullName $Name -OrgName "whitecloud" -OSType "Windows" -NamingScheme "vm" -ProductKey $license -AutoLogonCount 0 -TimeZone $Time -AdminPassword $adpassword -Domain $domain -DomainUsername $user -DomainPassword $password -ChangeSid
## Ask the user for an IP address, the first (3) octets are appended for you including period.

($vmip1 = Read-host "Enter $vmname1 IP Address")
Get-OSCustomizationSpec $oscust1 | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress "$ip.$vmip1" -SubnetMask $subnet -Dns $dnsServers -DefaultGateway $gateway -Position 1

($vmip2 = Read-host "Enter $vmname2 IP Address")
Get-OSCustomizationSpec $oscust2 | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress "$ip.$vmip2" -SubnetMask $subnet -Dns $dnsServers -DefaultGateway $gateway -Position 1

($vmip3 = Read-host "Enter $vmname3 IP Address")
Get-OSCustomizationSpec $oscust3 | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress "$ip.$vmip3" -SubnetMask $subnet -Dns $dnsServers -DefaultGateway $gateway -Position 1

($vmip4 = Read-host "Enter $vmname4 IP Address")
Get-OSCustomizationSpec $oscust4 | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress "$ip.$vmip4" -SubnetMask $subnet -Dns $dnsServers -DefaultGateway $gateway -Position 1

($vmip5= Read-host "Enter $vmname5IP Address")
Get-OSCustomizationSpec $oscust5| Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress "$ip.$vmip5" -SubnetMask $subnet -Dns $dnsServers -DefaultGateway $gateway -Position 1

($vmip6 = Read-host "Enter $vmname6 IP Address")
Get-OSCustomizationSpec $oscust6 | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress "$ip.$vmip6" -SubnetMask $subnet -Dns $dnsServers -DefaultGateway $gateway -Position 1

($vmip7 = Read-host "Enter $vmname7 IP Address")
Get-OSCustomizationSpec $oscust7 | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress "$ip.$vmip7" -SubnetMask $subnet -Dns $dnsServers -DefaultGateway $gateway -Position 1

($vmip8 = Read-host "Enter $vmname8 IP Address")
Get-OSCustomizationSpec $oscust8 | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress "$ip.$vmip8" -SubnetMask $subnet -Dns $dnsServers -DefaultGateway $gateway -Position 1

($vmip9 = Read-host "Enter $vmname9 IP 9Address")
Get-OSCustomizationSpec $oscust9 | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress "$ip.$vmip9" -SubnetMask $subnet -Dns $dnsServers -DefaultGateway $gateway -Position 1

($vmip10 = Read-host "Enter $vmname10 IP Address")
Get-OSCustomizationSpec $oscust10 | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress "$ip.$vmip10" -SubnetMask $subnet -Dns $dnsServers -DefaultGateway $gateway -Position 1

($vmip11 = Read-host "Enter $vmname11 IP Address")
Get-OSCustomizationSpec $oscust11 | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress "$ip.$vmip11" -SubnetMask $subnet -Dns $dnsServers -DefaultGateway $gateway -Position 1

($vmip12 = Read-host "Enter $vmname12 IP Address")
Get-OSCustomizationSpec $oscust12 | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress "$ip.$vmi12" -SubnetMask $subnet -Dns $dnsServers -DefaultGateway $gateway -Position 1

($vmip13 = Read-host "Enter $vmname13 IP Address")
Get-OSCustomizationSpec $oscust13 | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress "$ip.$vmip13" -SubnetMask $subnet -Dns $dnsServers -DefaultGateway $gateway -Position 1

($vmip14 = Read-host "Enter $vmname14 IP Address")
Get-OSCustomizationSpec $oscust14 | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress "$ip.$vmip14" -SubnetMask $subnet -Dns $dnsServers -DefaultGateway $gateway -Position 1

($vmip15 = Read-host "Enter $vmname15 IP Address")
Get-OSCustomizationSpec $oscust15 | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress "$ip.$vmip15" -SubnetMask $subnet -Dns $dnsServers -DefaultGateway $gateway -Position 1
