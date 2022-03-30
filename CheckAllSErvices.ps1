$OasisServers = Get-Content $ENV:UserProfile\Desktop\server-list.txt

foreach($Server in $OasisServers){
    if (Test-NetConnection -ComputerName $Server -port 135){
    $Service_Array += Get-WmiObject -ComputerName $Server -Class win32_service | Where-Object {$_.DisplayName -like "ATI.*"} | Select @{Expression={$_.PSComputerName};Label="Server Name"}, @{Expression={$_.DisplayName};Label="Service Name"}, @{Expression={$_.State};Label="Service Status"}, @{Expression={$_.StartName};Label="Logon User"}, @{Expression={$_.StartMode};Label="Startup Type"} 
    }
    else {}
    }


$Service_Array | ConvertTo-Html -Head $Header  -PostContent (Get-Date -UFormat "%A %m/%d/%Y %r") | Out-File -FilePath $ENV:UserProfile\Desktop\Services-Check-All-Servers.html ####FileSystem::\\10.13.16.42\install$\Services-Check-All-Servers.html
