<#
.SYNOPSIS
Removes a checklist item from a Habitica task.

.PARAMETER TaskId
The ID of the Habitica task.

.PARAMETER ItemId
The ID of the checklist item to remove.

.EXAMPLE
Remove-TaskChecklistItem -TaskId "12345" -ItemId "6789"
#>
function Remove-TaskChecklistItem {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]$TaskId,

        [Parameter(Mandatory)]
        [string]$ItemId
    )

    process {
        if ($PSCmdlet.ShouldProcess("Checklist item $ItemId", "Remove")) {
            $uri = "/tasks/$TaskId/checklist/$ItemId"
            $response = Invoke-Api -Uri $uri -Method Delete

            if ($response.success) {
                Write-Verbose "Checklist item '$ItemId' removed successfully."
                return $true
            }
        }
    }
}
