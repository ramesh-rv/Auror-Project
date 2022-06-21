# Creating a Local User
net user alice Pass@123 /add

# Allow User to perform RDP
net localgroup "Remote Desktop Users" alice /add

# Global Variables
$domain_name = "auror.local"
$domain_netbios_name = "auror"
$mode = "Win2012R2"
$password = "Password@123!"
$secure_password = $password | ConvertTo-SecureString -AsPlainText -Force

# Install Active Directory
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature

# Configuring Active Directory
## Import AD DS Deployment
Import-Module ADDSDeployment

## AD DS Forest Configuration
$forest_config = @{
	DomainName = $domain_name
	SafeModeAdministratorPassword = $secure_password
	DomainMode = $mode
	DomainNetBIOSName = $domain_netbios_name
	ForestMode = $mode
	InstallDNS = $true
	DatabasePath = "C:\Windows\NTDS"
	LogPath = "C:\Windows\NTDS"
	SYSVOLPath = "C:\Windows\SYSVOL"
	Force = $true
	NoRebootOnCompletion = $true
}

## Install AD DS Forest
Install-ADDSForest @forest_config
