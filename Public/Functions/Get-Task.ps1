<#
.SYNOPSIS
Retrieves Habitica tasks or a specific task.

.DESCRIPTION
This function fetches tasks from Habitica. If no parameters are provided,
it returns all tasks. If you specify a Type, it filters tasks by type.
If you specify a TaskId, it returns detailed information about that task,
including checklist items.

.PARAMETER TaskId
The ID of a specific task to retrieve. If provided, detailed info is returned.

.PARAMETER Type
The type of tasks to filter by. Valid values: "todo", "daily", "habit".

.EXAMPLE
Get-Task -Type todo
Returns all Todo tasks.

.EXAMPLE
Get-Task -TaskId "abcd1234"
Returns the full details of the specified task, including checklist items.
#>
function Get-Task {
    [CmdletBinding(DefaultParameterSetName = 'All')]
    param(
        [Parameter(ParameterSetName = 'ById')]
        [string]$TaskId,

        [Parameter(ParameterSetName = 'ByType')]
        [ValidateSet('todo', 'daily', 'habit')]
        [string]$Type
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'ById') {
            $uri = "/tasks/$TaskId"
            $response = Invoke-Api -Uri $uri -Method Get

            if ($response.success) {
                Write-Verbose "Task '$TaskId' retrieved successfully."
                return $response.data
            }
        }
        else {
            $uri = "/tasks/user"

            if ($PSCmdlet.ParameterSetName -eq 'ByType') {
                switch ($Type.ToLower()) {
                    "todo" { $apiType = "todos" }
                    "daily" { $apiType = "dailys" }
                    "habit" { $apiType = "habits" }
                    default { throw "Unsupported task type '$Type'" }
                }
                $uri = $uri + "?type=$apiType"
            }

            $response = Invoke-Api -Uri $uri -Method Get

            if ($response.success) {
                Write-Verbose "Tasks retrieved successfully."
                return $response.data
            }
        }
    }
}
