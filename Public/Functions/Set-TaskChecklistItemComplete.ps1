
<#
.SYNOPSIS
Toggles completion state of a checklist item.

.PARAMETER TaskId
The ID of the Habitica task.

.PARAMETER ItemId
The ID of the checklist item to toggle.

.EXAMPLE
Set-TaskChecklistItemComplete -TaskId "12345" -ItemId "6789"
#>
function Set-TaskChecklistItemComplete {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$TaskId,

        [Parameter(Mandatory)]
        [string]$ItemId
    )

    process {
        $uri = "/tasks/$TaskId/checklist/$ItemId/score"
        $response = Invoke-Api -Uri $uri -Method Post

        if ($response.success) {
            Write-Verbose "Checklist item '$ItemId' toggled successfully."
            return $response.data
        }
    }
}
