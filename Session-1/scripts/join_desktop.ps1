# Disable Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Disable Windows Defender
Set-MpPreference -DisableBehaviorMonitoring $true -DisableRealtimeMonitoring $true -DisableScriptScanning $true -DisableIOAVProtection $true -EnableNetworkProtection 0

# Configure Machine A as the DNS Server
$net_adapters = Get-WmiObject Win32_NetworkAdapterConfiguration
$net_adapters | ForEach-Object {$_.SetDNSServerSearchOrder("10.0.0.9")}

# Add Computer to Domainn
$username = "vagrant"
$password = "vagrant"
$secure_password = $password | ConvertTo-SecureString -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential($username, $secure_password)
$domain = "auror.local"

Add-Computer -DomainName $domain -Credential $credentials

# Add User Adam to Local Administrators
net localgroup "Administrators" auror\alice /add

