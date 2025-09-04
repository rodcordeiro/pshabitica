
function Set-Tag {
    <#
.SYNOPSIS
    Updates an existing Habitica tag.

.DESCRIPTION
    Calls the Habitica API to update the name of an existing tag by its ID.

.PARAMETER Id
    The ID of the tag to update.

.PARAMETER Name
    The new name for the tag.

.EXAMPLE
    Set-Tag -Id "12345678-abcd-1234-abcd-1234567890ab" -Name "UpdatedTag"

    Renames the specified tag to "UpdatedTag".

.EXAMPLE
    Get-Tag | Where-Object { $_.name -eq "Work" } | Set-Tag -Name "Office"

    Finds the "Work" tag and renames it to "Office".
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$Id,

        [Parameter(Mandatory)]
        [string]$Name
    )

    process {
        try {
            $Body = @{ name = $Name }
            $response = Invoke-Api -Uri "/tags/$Id" -Method PUT -Body $Body
            return $response.data
        }
        catch {
            throw "Failed to update tag '$Id'. Details: $_"
        }
    }
}
