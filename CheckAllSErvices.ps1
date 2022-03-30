####CSS Header####
$Header = @"
<style>
TABLE {border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}
TH {border-width: 1px; padding: 3px; border-style: solid; border-color: black; background-color: #6495ED;}
TD {border-width: 1px; padding: 3px; border-style: solid; border-color: black;}
</style>
    <script type="text/javascript" src="node_modules/jquery/dist/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.31.3/js/jquery.tablesorter.min.js" integrity="sha512-qzgd5cYSZcosqpzpn7zF2ZId8f/8CHmFKZ8j7mU4OUXTNRd5g+ZHBPsgKEwoqxCtdQvExE5LprwwPAgoicguNg==" crossorigin="anonymous"></script>
    <script type="text/javascript">
$(function() {
        $(document).find("table").tablesorter();
});
</script>
"@

$OasisServers = Get-Content $ENV:UserProfile\Desktop\server-list.txt

foreach($Server in $OasisServers){
    if (Test-NetConnection -ComputerName $Server -port 135){
    $Service_Array += Get-WmiObject -ComputerName $Server -Class win32_service | Where-Object {$_.DisplayName -like "ATI.*"} | Select @{Expression={$_.PSComputerName};Label="Server Name"}, @{Expression={$_.DisplayName};Label="Service Name"}, @{Expression={$_.State};Label="Service Status"}, @{Expression={$_.StartName};Label="Logon User"}, @{Expression={$_.StartMode};Label="Startup Type"} 
    }
    else {}
    }


$Service_Array | ConvertTo-Html -Head $Header  -PostContent (Get-Date -UFormat "%A %m/%d/%Y %r") | Out-File -FilePath $ENV:UserProfile\Desktop\Services-Check-All-Servers.html ####FileSystem::\\10.13.16.42\install$\Services-Check-All-Servers.html
