function Get-Tag {
<#
.SYNOPSIS
    Retrieves the current user's tags from Habitica.

.DESCRIPTION
    Calls the Habitica API to return the list of tags defined by the user.
    Tags can be used to group tasks like todos, dailies, or habits.

.EXAMPLE
    Get-Tag

    Returns all tags for the authenticated Habitica user.

.EXAMPLE
    Get-Tag | Where-Object { $_.name -eq "Work" }

    Returns the "Work" tag object.

.EXAMPLE
    (Get-Tag).name

    Lists the names of all tags.
#>
    [CmdletBinding()]
    param()

    process {
        try {
            $response = Invoke-Api -Uri "/tags" -Method GET
            return $response.data
        }
        catch {
            throw "Failed to retrieve tags. Ensure you are authenticated with Connect-Account. Details: $_"
        }
    }
}
