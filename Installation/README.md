# Install Virtual Machines

 1. Install ISOs
    * Installed Windows Server 2022
    * Installed Windows 11 as Workstation
 2. Configures base systems for first snapshot to create templates
    * Set Admin password and basic network configuration on server
        - Use "SConfig" :
            - Change the Hostname
            - Configure IP to static
            - Configure DNS to own
    * Set Local_Admin account as local account

# Install Active Directory Domain Controller On Window Server

 1. Install AD-Domain Services
    Command: Install-WindowsFeature AD-Domain-Services -IncludeManagementFeatures
        
 2. Import ADDSDeployment
    Command: Import-Module ADDSDeployment
        
 3. Install Forest
    Command: install-ADDSForest

 4. Congigure Forest
    * Set Domain Name
    * Set SafeModePassword
    * Once Reboot is complete reset DNS to own.

# Add Clients to Domain

 1. Set Client DNS to Domain Controller IP

 2. Add to Domain
        Command: add-computer -domainname xyz.com -Credenttial xyz\Administrator -Force -Restart
        ---- Enter Domain Admin Credential

        