Function Get-Hello {
    param()
    begin {
        Register-SecretVault -Name SecretStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault
    }
    process {
        Write-Output "Hello"
    }
}