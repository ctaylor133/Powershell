# Powershell

Powershell script to automate the building of NLB. Prequesites, NLB-adapter are configured with a static IP-address on the remote nodes. Use DNS name to add second node. Specific NIC configuartions like do not add to DNS will have to be done manually. NLB_Cluster_np has no user prompts and defaults to IGMP Multicast. 
Fill out feilds below in script: 

$InterfaceName = "NLB"<br>
$ClusterFqdn = "<DNS-name>"<br>
$ClusterPrimaryIP = "<IP>"<br>
$ClusterPrimaryIPSubnetMask = "255.255.255.0"<br>
$nodeIpAddress = "<node IP>"<br>
  
 Follow prompts for 2nd node.<br>
