function Invoke-Api {
    param(
        [uri]$Uri,
        [string]$Method = "GET",
        [AllowNull()][Object]$Body,
        [switch]$IgnoreVault = $false
    )
    begin {
        if (-not $IgnoreVault) {
            try {
                $userId = (Get-Secret -Name "HABITICA_USER_ID" -Vault "PSHabitica" -AsPlainText)
                $token = (Get-Secret -Name "HABITICA_API_TOKEN" -Vault "PSHabitica" -AsPlainText)
                $client = (Get-Secret -Name "HABITICA_CLIENT" -Vault "PSHabitica" -AsPlainText)
            }
            catch {
                Throw "Authentication metadata not found. Please reconnect!"
            }
        }

    }
    process {
        $escapedUri = [URI]::EscapeUriString("$HABITICA_API_URL/$Uri")
        $scheme, $rest = $escapedUri -split "://", 2
        $cleanedRest = $rest -replace "/{2,}", "/"
        $Uri = "$($scheme)://$cleanedRest";

        $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"

        $headers.Add("Content-Type", "application/json")
        $headers.Add("x-client", $client)
        $headers.Add("x-api-key", $token)
        $headers.Add("x-api-user", $userId)


        $response = Invoke-RestMethod $Uri -Method $Method -Headers $headers -Body ($Body | ConvertTo-Json -Depth 10)
        return $response
    }
}