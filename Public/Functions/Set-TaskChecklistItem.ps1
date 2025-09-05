
<#
.SYNOPSIS
Updates an existing checklist item.

.PARAMETER TaskId
The ID of the Habitica task.

.PARAMETER ItemId
The ID of the checklist item to update.

.PARAMETER Text
The new text for the checklist item.

.EXAMPLE
Set-TaskChecklistItem -TaskId "12345" -ItemId "6789" -Text "Write conclusion"
#>
function Set-TaskChecklistItem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$TaskId,

        [Parameter(Mandatory)]
        [string]$ItemId,

        [Parameter(Mandatory)]
        [string]$Text
    )

    process {
        $uri = "/tasks/$TaskId/checklist/$ItemId"
        $body = @{ text = $Text }
        $response = Invoke-Api -Uri $uri -Method Put -Body $body

        if ($response.success) {
            Write-Verbose "Checklist item '$ItemId' updated successfully."
            return $response.data
        }
    }
}
