
function Remove-Tag {
    <#
.SYNOPSIS
    Deletes a Habitica tag.

.DESCRIPTION
    Calls the Habitica API to delete a tag by its ID.

.PARAMETER Id
    The ID of the tag to delete.

.EXAMPLE
    Remove-Tag -Id "12345678-abcd-1234-abcd-1234567890ab"

    Deletes the specified tag.

.EXAMPLE
    Get-Tag | Where-Object { $_.name -eq "Obsolete" } | Remove-Tag

    Deletes the tag named "Obsolete".
#>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$Id
    )

    process {
        if ($PSCmdlet.ShouldProcess("Tag ID $Id", "Delete")) {
            try {
                $response = Invoke-Api -Uri "/tags/$Id" -Method DELETE
                return $response.success
            }
            catch {
                throw "Failed to delete tag '$Id'. Details: $_"
            }
        }
    }
}
