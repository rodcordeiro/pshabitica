
function New-Tag {
    <#
.SYNOPSIS
    Creates a new tag in Habitica.

.DESCRIPTION
    Calls the Habitica API to create a new tag associated with the authenticated user.

.PARAMETER Name
    The name of the tag to create.

.EXAMPLE
    New-Tag -Name "Work"

    Creates a new tag named "Work".

.EXAMPLE
    "Fitness","Health" | ForEach-Object { New-Tag -Name $_ }

    Creates multiple tags at once.
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name
    )

    process {
        try {
            $Body = @{ name = $Name }
            $response = Invoke-Api -Uri "/tags" -Method POST -Body $Body
            return $response.data
        }
        catch {
            throw "Failed to create tag '$Name'. Details: $_"
        }
    }
}
