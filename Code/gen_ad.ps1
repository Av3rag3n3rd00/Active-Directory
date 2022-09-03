param( [Parameter(Mandatory=$true)] $JSONFile )
$json = (Get-Content $JSONFile | ConvertFrom-Json )
$Global:Domain = $json.domain

function CreateADGroup {
    param ( [Parameter(Mandatory=$true)] $groupObject)
    
    $name = $groupObject.name
    New-ADGroup -name $name -GroupScope Global
}
function CreateADUser {
    param ( [Parameter(Mandatory=$true)] $userObject)
    
    $name = $userObject.name
    $firstname, $lastname = $name.Split(" ")
    $password = $userObject.password

    #Generate First Intial + Lastname Username Stucture
    $username = ($firstname[0] + $lastname).ToLower()
    $samAccountName = $username
    $prinicpalName = $username

    #Create AD User
    New-ADUser -Name "$name" -GivenName $firstname -Surname $lastname -SamAccountName $samAccountName -UserPrincipalName $prinicpalName@$Global:Domain -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru | Enable-ADAccount

    foreach ( $group_name in $userObject.$groups) {

        try {
            Get-ADGroup -Identity "$group_name"
            Add-ADGroupMember -Identity $group_name -Member $username
        }
        catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
        {
            Write-Warning "User $name NOT added to group $group_name because it does not exist"
        }
        
    }

}

foreach ($group in $json.groups) {
    CreateADGroup $group
}

foreach ($user in $json.users) {
    CreateADUser $user
}

