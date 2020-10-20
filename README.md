# Powershell

Powershell script to automate the building of NLB. Prequesites, NLB-adapter are configured with a static IP-address on the remote nodes. Specific NIC configuartions like do not add to DNS will have to be done manually.
Fill out feilds below in script: 

$InterfaceName = "NLB"
$ClusterFqdn = "<DNS-name>"
$ClusterPrimaryIP = "<IP>"
$ClusterPrimaryIPSubnetMask = "255.255.255.0"
$nodeIpAddress = "<node IP>"
  
 Follow prompts for 2nd node.
