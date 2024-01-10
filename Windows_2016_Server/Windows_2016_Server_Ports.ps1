# This is where you will put the port number to block 
$port = 3389 # This is the Remote Desktop Protocol

# Create the new firewall rule
$fwrule = New-Object -ComObject hnetcfg.fwpolicy2
$rule = New-Object -ComObject HNetCfg.FWRule

# This will set the rule properties
$rule.Name = "Block Port $port"
$ruke.Protocol = 6 # TCP protocol
$rule.LocalPorts = $port
$rule.Action = 0 # Blocks the traffic
$rule.Enable = $true

# Adds the rule to the Windows Firewall
$fwRule.Rules.Add9($rule)

# This will save the changes made to the firewall
$fwRule.Rules | foreach {$_.Enabled = $true}
