<#
.SYNOPSIS
Adds a new checklist item to a Habitica task.

.PARAMETER TaskId
The ID of the Habitica task.

.PARAMETER Text
The text of the new checklist item.

.EXAMPLE
Add-TaskChecklistItem -TaskId "12345" -Text "Write introduction"
#>
function Add-TaskChecklistItem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$TaskId,

        [Parameter(Mandatory)]
        [string]$Text
    )

    process {
        $uri = "/tasks/$TaskId/checklist"
        $body = @{ text = $Text }
        $response = Invoke-Api -Uri $uri -Method Post -Body $body

        if ($response.success) {
            Write-Verbose "Checklist item '$Text' added successfully."
            return $response.data
        }
    }
}
