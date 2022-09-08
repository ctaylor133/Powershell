##Change the property code to match the list of servers
## This server will look for AD connected servers with a link name and then poll them for ATI* services. Once it has finished it will output the results to an HTML file.##
##


$Header = @"
<style>
TABLE {border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}
TH {border-width: 1px; padding: 3px; border-style: solid; border-color: black; background-color: #6495ED;}
TD {border-width: 1px; padding: 3px; border-style: solid; border-color: black;}
</style>
"@


$Service_Array =@()

$OasisServers = Get-ADComputer -Filter {Name -like "GRD*"} | Select -ExpandProperty Name   ## Add the property code under the quotes with * ##

foreach($Server in $OasisServers){
    if (Test-NetConnection -ComputerName $Server -port 135){
    $Service_Array += Get-WmiObject -ComputerName $Server -Class win32_service | Where-Object {$_.DisplayName -like "ATI.*"} | Select @{Expression={$_.PSComputerName};Label="Server Name"}, @{Expression={$_.DisplayName};Label="Service Name"}, @{Expression={$_.State};Label="Service Status"}, @{Expression={$_.StartName};Label="Logon User"}, @{Expression={$_.StartMode};Label="Startup Type"} 
    }
    else {}
    }


$Service_Array | ConvertTo-Html -Head $Header | Out-File -FilePath c:\Services.html


#$Service_Array
