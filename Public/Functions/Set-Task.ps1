function Set-Task {
    <#
    .SYNOPSIS
        Updates an existing Habitica task.

    .DESCRIPTION
        Calls the Habitica API to update a task by ID.
        Parameters are grouped into sets depending on the task type (`todo`, `daily`, or `habit`).

    .PARAMETER TaskId
        The unique identifier of the Habitica task to update.

    .PARAMETER Text
        The new title of the task.

    .PARAMETER Notes
        The description or details of the task.

    .PARAMETER Type
        The type of the task. Valid values: "habit", "daily", "todo".

    .PARAMETER Priority
        Priority multiplier for the task. Typical values: 0.1 (trivial), 1 (easy), 1.5 (medium), 2 (hard).

    .PARAMETER Tags
        A list of tag names to associate with the task. Tags are automatically resolved to their IDs if they exist.

    .PARAMETER StartDate
        (Dailies only) Start date for the daily task.

    .PARAMETER Repeat
        (Dailies only) Days of the week the task repeats. Example: @{ su=$false; m=$true; t=$true; w=$true; th=$true; f=$true; s=$false }

    .PARAMETER Frequency
        (Dailies only) Interval type. Valid values: "daily", "weekly", "monthly", "yearly".

    .PARAMETER Up
        (Habits only) Whether the habit can increment positively.

    .PARAMETER Down
        (Habits only) Whether the habit can decrement negatively.

    .EXAMPLE
        Set-Task -TaskId "abcd1234" -Type todo -Text "Finish docs" -Priority 2

    .EXAMPLE
        Set-Task -TaskId "abcd1234" -Type daily -StartDate (Get-Date) -Repeat @{ m=$true; t=$true; w=$true }
    #>
    [CmdletBinding(DefaultParameterSetName = 'Todo')]
    param(
        # -----------------------
        # Common properties
        # -----------------------
        [Parameter(Mandatory, ParameterSetName = 'Todo', ValueFromPipelineByPropertyName)]
        [Parameter(Mandatory, ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [Parameter(Mandatory, ParameterSetName = 'Habit', ValueFromPipelineByPropertyName)]
        [string]$TaskId,

        [Parameter(ParameterSetName = 'Todo', ValueFromPipelineByPropertyName)]
        [Parameter(ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [Parameter(ParameterSetName = 'Habit', ValueFromPipelineByPropertyName)]
        [string]$Text,

        [Parameter(ParameterSetName = 'Todo', ValueFromPipelineByPropertyName)]
        [Parameter(ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [Parameter(ParameterSetName = 'Habit', ValueFromPipelineByPropertyName)]
        [string]$Notes,

        [Parameter(ParameterSetName = 'Todo', ValueFromPipelineByPropertyName)]
        [Parameter(ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [Parameter(ParameterSetName = 'Habit', ValueFromPipelineByPropertyName)]
        [double]$Priority,

        [Parameter(ParameterSetName = 'Todo', ValueFromPipelineByPropertyName)]
        [Parameter(ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [Parameter(ParameterSetName = 'Habit', ValueFromPipelineByPropertyName)]
        [string[]]$Tags,

        # -----------------------
        # Daily properties
        # -----------------------
        [Parameter(ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [datetime]$StartDate,

        [Parameter(ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [hashtable]$Repeat,

        [Parameter(ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [ValidateSet("daily", "weekly", "monthly", "yearly")]
        [string]$Frequency,

        # -----------------------
        # Habit properties
        # -----------------------
        [Parameter(ParameterSetName = 'Habit', ValueFromPipelineByPropertyName)]
        [bool]$Up,

        [Parameter(ParameterSetName = 'Habit', ValueFromPipelineByPropertyName)]
        [bool]$Down
    )

    begin {

    }

    process {
        $body = @{}
        if ($PSBoundParameters.ContainsKey("Text")) { $body.text = $Text }
        if ($PSBoundParameters.ContainsKey("Notes")) { $body.notes = $Notes }
        if ($PSBoundParameters.ContainsKey("Priority")) { $body.priority = $Priority }
        if ($PSBoundParameters.ContainsKey("Type")) { $body.type = $Type }

        if ($Tags) {
            $resolvedTags = @()
            foreach ($tag in $Tags) {
                try {
                    $habiticaTag = Get-Tag | Where-Object { $_.id -ieq $tag -or $_.name -ieq $tag }
                    if ($habiticaTag) {
                        $resolvedTags += $habiticaTag.id
                    }
                    else {
                        Write-Warning "Tag '$tag' does not exist. Skipping..."
                    }
                }
                catch {
                    Write-Warning "Failed to resolve tag '$tag'. Skipping..."
                }
            }
            if ($resolvedTags.Count -gt 0) {
                $body.tags = $resolvedTags
            }
        }

        if ($PSCmdlet.ParameterSetName -eq 'Daily') {
            if ($PSBoundParameters.ContainsKey("StartDate")) { $body.startDate = $StartDate.ToString("yyyy-MM-dd") }
            if ($PSBoundParameters.ContainsKey("Repeat")) { $body.repeat = $Repeat }
            if ($PSBoundParameters.ContainsKey("Frequency")) { $body.frequency = $Frequency }
        }

        if ($PSCmdlet.ParameterSetName -eq 'Habit') {
            if ($PSBoundParameters.ContainsKey("Up")) { $body.up = $Up }
            if ($PSBoundParameters.ContainsKey("Down")) { $body.down = $Down }
        }
        $response = Invoke-Api -Uri "tasks/$TaskId" -Method PUT -Body $body
        if ($response.success) {
            Write-Verbose "Task '$Text' updated successfully"
            return $response.data
        }
    }
}
