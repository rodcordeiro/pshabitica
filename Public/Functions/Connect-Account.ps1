function Connect-Account {
    <#
.SYNOPSIS
    Connects to a Habitica account and securely stores authentication data in a SecretVault.

.DESCRIPTION
    This function authenticates a user against Habitica's API using username and password.
    Once authenticated, it stores the User ID, API Token, and Client identifier in a SecretVault ("PSHabitica"),
    allowing subsequent API calls to authenticate without reentering credentials.

.PARAMETER Client
    The x-client attribute. Required by Habitica API.
    Format: <username>-<appname>.
    Refer to: https://github.com/HabitRPG/habitica/wiki/API-Usage-Guidelines#x-client-header

.PARAMETER Username
    The Habitica username (email address or handle). Required for first authentication.

.PARAMETER Password
    The Habitica account password, passed as a SecureString.

.EXAMPLE
    PS> $password = Read-Host "Enter Habitica password" -AsSecureString
    PS> Connect-Account -Client "myuser-pshabitica" -Username "myuser@email.com" -Password $password

    Connects to Habitica and stores the authentication data in the SecretVault.

.EXAMPLE
    PS> $password = ConvertTo-SecureString "SuperSecret123" -AsPlainText -Force
    PS> Connect-Account -Client "dev-pshabitica" -Username "dev@example.com" -Password $password

    Connects with plain text converted to SecureString.

.EXAMPLE
    PS> $password = Get-Credential | Select-Object -ExpandProperty Password
    PS> Connect-Account -Client "corp-pshabitica" -Username "corpadmin" -Password $password

    Uses Windows Credential Manager prompt to obtain the SecureString password.

.NOTES
    Author: Rodrigo Cordeiro
    Module: PSHabitica
    This function registers the SecretVault "PSHabitica" automatically if not present.
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true,
            HelpMessage = "The x-client attribute. Format: <username>-<appname>.")]
        [string]$Client,

        [Parameter(Mandatory = $true,
            HelpMessage = "Your Habitica username (email or handle).")]
        [string]$Username,

        [Parameter(Mandatory = $true,
            HelpMessage = "Your Habitica account password as SecureString.")]
        [securestring]$Password
    )

    begin {
        $vault = Get-SecretVault -Name "PSHabitica" -ErrorAction SilentlyContinue
        if (-not $vault) {
            Register-SecretVault -Name "PSHabitica" -ModuleName Microsoft.PowerShell.SecretStore -PassThru -Verbose:$false | Out-Null
        }
    }

    process {
        $Body = @{
            username = $Username
            password = (Unprotect-SecureString $Password)
        }

        $response = Invoke-Api -Uri "/user/auth/local/login" -Method POST -Body $Body -IgnoreVault

        Write-Output "You will be requested a password for securing the authentication data.
This password will be prompted if the vault remains idle for a while. Save it safely."

        Set-Secret -Name "HABITICA_USER_ID" -Vault "PSHabitica" -Secret $response.data.id
        Set-Secret -Name "HABITICA_API_TOKEN" -Vault "PSHabitica" -Secret $response.data.apiToken
        Set-Secret -Name "HABITICA_CLIENT" -Vault "PSHabitica" -Secret $Client

        Write-Output "Welcome to PSHabitica $($response.data.username)!"
    }
}
