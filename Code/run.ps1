param (
    [int] $Groups,
    [int] $Users
)

Import-Module CredentialManager.psm1
$cred = Get-StoredCredential -name DomainController
$dc = New-PSSession 192.168.220.155 -Credential $cred
.\randomize.ps1 AD_Schema.json -UserCount $Users -GroupCount $Groups
Start-Sleep -Seconds .5
Copy-Item gen_ad.ps1 -ToSession $dc C:\Windows\Tasks
Copy-Item AD_Schema.json -ToSession $dc C:\Windows\Tasks
Start-Sleep -Seconds .5
Enter-PSSession $dc
Invoke-command -Session $dc -Scriptblock {
    Set-Location C:\Windows\Tasks
        .\gen_ad.ps1 AD_Schema.json
 }
