
function Connect-Account {
    param(
        [Parameter(Mandatory = $true, HelpMessage = "The x-client attribute. Refer to [Wiki](https://github.com/HabitRPG/habitica/wiki/API-Usage-Guidelines#x-client-header)")][string]$Client,
        [string]$Username,
        [securestring]$Password
    )
    begin {
        if (-not $Username) {
            Throw "The Username must be informed to allow the first authentication"
        }
        if (-not $Password) {
            Throw "The password must be informed to allow the first authentication"
        }
        $vault = $(Get-SecretVault -Name "PSHabitica" -ErrorAction SilentlyContinue)
        if (-not $vault) {
            Register-SecretVault -Name "PSHabitica" -ModuleName Microsoft.PowerShell.SecretStore -PassThru -Verbose:$false | Out-Null
        }
    }
    process {
        $Body = @{
            username = $Username
            password = $(Unprotect-SecureString $Password)
        }
        $response = (invoke-api -Uri "/user/auth/local/login" -Method POST -Body $Body -IgnoreVault)

        Write-Output "You will be requested a password for securing the authentication data for later usage on the first time."
        Set-Secret -Name "HABITICA_USER_ID" -Vault "PSHabitica" -Secret $response.data.id 
        Set-Secret -Name "HABITICA_API_TOKEN" -Vault "PSHabitica" -Secret $response.data.apiToken
        Set-Secret -Name "HABITICA_CLIENT" -Vault "PSHabitica" -Secret $Client 
        Write-Output "Welcome to PSHabitica $($response.data.username)!"
    }
}

