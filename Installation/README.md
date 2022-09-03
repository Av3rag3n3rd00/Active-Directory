# Install Virtual Machines

 * Install ISOs
    1. Installed Windows Server 2022
    2. Installed Windows 11 as Workstation
 * Configures base systems for first snapshot to create templates
    1. Set Admin password and basic network configuration on server
        - Use "SConfig" :
            - Change the Hostname
            - Configure IP to static
            - Configure DNS to own
    2. Set Local_Admin account as local account

# Install Active Directory Domain Controller On Window Server

 * Install AD-Domain Services
    1. Use Command:
        Install-WindowsFeature AD-Domain-Services -IncludeManagementFeatures
        