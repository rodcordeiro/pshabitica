<#
.SYNOPSIS
Creates a new Habitica task (Todo, Daily, or Habit).

.DESCRIPTION
This function allows you to create tasks in Habitica via its API.
It supports all available task types (todo, daily, habit), and exposes
the main fields such as text, notes, tags, priority, recurrence,
checklist items, and habit up/down directions.

.PARAMETER Type
The type of the task. Valid values are: "todo", "daily", "habit".

.PARAMETER Text
The title or name of the task.

.PARAMETER Alias
A custom string identifier for the task (unique within your account).

.PARAMETER Note
An optional description or additional details for the task.

.PARAMETER Tags
A list of tag IDs or names to associate with the task.

.PARAMETER Priority
Task difficulty. Valid values are:
0.1 = Trivial, 1 = Easy, 1.5 = Medium, 2 = Hard.
(Default is 1).

.PARAMETER Attribute
Which attribute this task affects. Valid values are:
"str", "int", "con", "per". (Default is "str").

.PARAMETER Checklist
An array of checklist item texts to include in the task.

.PARAMETER DueDate
(For todos only) Due date of the task.

.PARAMETER Frequency
(For dailies only) Recurrence type. Valid values:
"daily", "weekly", "monthly", "yearly".

.PARAMETER RepeatDays
(For dailies only) Days of the week to repeat. Example: @(1,3,5).

.PARAMETER WeeksOfMonth
(For dailies only) Which weeks of the month the daily should repeat.

.PARAMETER DaysOfMonth
(For dailies only) Specific days of the month to repeat.

.PARAMETER Up
(For habits only) Whether the habit can be scored "up" (positive).

.PARAMETER Down
(For habits only) Whether the habit can be scored "down" (negative).

.EXAMPLE
New-Task -Type todo -Text "Finish report" -DueDate (Get-Date).AddDays(3) `
         -Checklist @("Write draft","Review","Send") -Priority 2 -Attribute int `
         -Tags @("work","urgent")

Creates a Todo task due in 3 days, with a checklist and tags.

.EXAMPLE
New-Task -Type daily -Text "Go for a run" -Frequency weekly `
         -RepeatDays @(1,3,5) -Checklist @("Warm up","Run 5km","Cool down") `
         -Priority 1.5 -Note "Morning routine"

Creates a Daily that repeats every Monday, Wednesday, and Friday.

.EXAMPLE
New-Task -Type habit -Text "Drink water" -Up -Down:$false `
         -Priority 0.1 -Note "8 glasses per day"

Creates a Habit that can only be scored positively.
#>
function New-Task {
    [CmdletBinding(DefaultParameterSetName = 'Todo', ConfirmImpact = 'None')]
    param(
        # -----------------------
        # Common properties
        # -----------------------
        [Parameter(Mandatory, ParameterSetName = 'Todo', ValueFromPipelineByPropertyName)]
        [Parameter(Mandatory, ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [Parameter(Mandatory, ParameterSetName = 'Habit', ValueFromPipelineByPropertyName)]
        [ValidateSet('todo', 'daily', 'habit')]
        [string]$Type,

        [Parameter(Mandatory, ParameterSetName = 'Todo', ValueFromPipelineByPropertyName)]
        [Parameter(Mandatory, ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [Parameter(Mandatory, ParameterSetName = 'Habit', ValueFromPipelineByPropertyName)]
        [string]$Text,

        [Parameter(Mandatory = $false, ParameterSetName = 'Todo', ValueFromPipelineByPropertyName)]
        [Parameter(Mandatory = $false, ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [Parameter(Mandatory = $false, ParameterSetName = 'Habit', ValueFromPipelineByPropertyName)]
        [string]$Alias,

        [Parameter(Mandatory = $false, ParameterSetName = 'Todo', ValueFromPipelineByPropertyName)]
        [Parameter(Mandatory = $false, ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [Parameter(Mandatory = $false, ParameterSetName = 'Habit', ValueFromPipelineByPropertyName)]
        [string]$Note,

        [Parameter(Mandatory = $false, ParameterSetName = 'Todo', ValueFromPipelineByPropertyName)]
        [Parameter(Mandatory = $false, ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [Parameter(Mandatory = $false, ParameterSetName = 'Habit', ValueFromPipelineByPropertyName)]
        [string[]]$Tags,

        [Parameter(ValueFromPipelineByPropertyName)]
        [double]$Priority = 1, # 0.1, 1, 1.5, 2

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$Attribute = "int", # str, con, int, per

        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]]$Checklist,

        # -----------------------
        # Todo-specific
        # -----------------------
        [Parameter(ParameterSetName = 'Todo', ValueFromPipelineByPropertyName)]
        [datetime]$DueDate,

        # -----------------------
        # Daily-specific
        # -----------------------
        [Parameter(ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [ValidateSet('daily', 'weekly', 'monthly', 'yearly')]
        [string]$Frequency = 'daily',

        [Parameter(ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [int[]]$RepeatDays,   # e.g. @(1,3,5) for Mon, Wed, Fri

        [Parameter(ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [int[]]$WeeksOfMonth, # e.g. @(1,3) → 1st & 3rd week

        [Parameter(ParameterSetName = 'Daily', ValueFromPipelineByPropertyName)]
        [int[]]$DaysOfMonth,  # e.g. @(10,20,30)

        # -----------------------
        # Habit-specific
        # -----------------------
        [Parameter(ParameterSetName = 'Habit', ValueFromPipelineByPropertyName)]
        [switch]$Up,

        [Parameter(ParameterSetName = 'Habit', ValueFromPipelineByPropertyName)]
        [switch]$Down
    )

    begin {
        if (-not $PSBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $PSCmdlet.SessionState.PSVariable.GetValue('VerbosePreference')
        }
        if (-not $PSBoundParameters.ContainsKey('Confirm')) {
            $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
        }
        if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
        }

        $uri = '/tasks/user'
    }

    process {
        # -----------------------
        # Build task body
        # -----------------------
        $body = @{
            "type"      = $Type.ToLower()
            "text"      = $Text
            "priority"  = $Priority
            "attribute" = $Attribute
        }

        if ($Alias) { $body.alias = $Alias }
        if ($Note) { $body.notes = $Note }
        if ($Tags) {
            $tagIds = @()
            $allTags = (Invoke-Api -Uri "/tags" -Method GET).data
            foreach ($tag in $Tags) {
                $match = $allTags | Where-Object { $_.id -ieq $tag -or $_.name -ieq $tag }
                if ($match) {
                    $tagIds += $match.id
                }
                else {
                    Write-Warning "Tag '$tag' not found. Skipping."
                }
            }
            if ($tagIds) { $body.tags = $tagIds }
        }
        if ($Checklist) { $body.checklist = $Checklist | ForEach-Object { @{ text = $_ } } }

        # --- Todo
        if ($PSCmdlet.ParameterSetName -eq 'Todo' -and $DueDate) {
            $body.date = $DueDate.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
        }

        # --- Daily
        if ($PSCmdlet.ParameterSetName -eq 'Daily') {
            $body.frequency = $Frequency
            if ($RepeatDays) { $body.repeat = @{ daysOfWeek = $RepeatDays } }
            if ($WeeksOfMonth) { $body.weeksOfMonth = $WeeksOfMonth }
            if ($DaysOfMonth) { $body.daysOfMonth = $DaysOfMonth }
        }

        # --- Habit
        if ($PSCmdlet.ParameterSetName -eq 'Habit') {
            $body.up = $Up -eq $true
            $body.down = $Down -eq $true
        }

        # -----------------------
        # Call Habitica API
        # -----------------------
        $response = invoke-api -uri $uri -method Post -body $body

        if ($response.success) {
            Write-Verbose "Task '$Text' created successfully"
            return $response.data
        }
    }
}
