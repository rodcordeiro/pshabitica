---
external help file: pshabitica-help.xml
Module Name: pshabitica
online version:
schema: 2.0.0
---

# New-Task

## SYNOPSIS
Creates a new Habitica task (Todo, Daily, or Habit).

## SYNTAX

### Todo (Default)
```
New-Task -Type <String> -Text <String> [-Alias <String>] [-Note <String>] [-Tags <String[]>]
 [-Priority <Double>] [-Attribute <String>] [-Checklist <String[]>] [-DueDate <DateTime>] [<CommonParameters>]
```

### Habit
```
New-Task -Type <String> -Text <String> [-Alias <String>] [-Note <String>] [-Tags <String[]>]
 [-Priority <Double>] [-Attribute <String>] [-Checklist <String[]>] [-Up] [-Down] [<CommonParameters>]
```

### Daily
```
New-Task -Type <String> -Text <String> [-Alias <String>] [-Note <String>] [-Tags <String[]>]
 [-Priority <Double>] [-Attribute <String>] [-Checklist <String[]>] [-Frequency <String>]
 [-RepeatDays <Int32[]>] [-WeeksOfMonth <Int32[]>] [-DaysOfMonth <Int32[]>] [<CommonParameters>]
```

## DESCRIPTION
This function allows you to create tasks in Habitica via its API.
It supports all available task types (todo, daily, habit), and exposes
the main fields such as text, notes, tags, priority, recurrence,
checklist items, and habit up/down directions.

## EXAMPLES

### EXEMPLO 1
```
New-Task -Type todo -Text "Finish report" -DueDate (Get-Date).AddDays(3) `
```

-Checklist @("Write draft","Review","Send") -Priority 2 -Attribute int \`
         -Tags @("work","urgent")

Creates a Todo task due in 3 days, with a checklist and tags.

### EXEMPLO 2
```
New-Task -Type daily -Text "Go for a run" -Frequency weekly `
```

-RepeatDays @(1,3,5) -Checklist @("Warm up","Run 5km","Cool down") \`
         -Priority 1.5 -Note "Morning routine"

Creates a Daily that repeats every Monday, Wednesday, and Friday.

### EXEMPLO 3
```
New-Task -Type habit -Text "Drink water" -Up -Down:$false `
```

-Priority 0.1 -Note "8 glasses per day"

Creates a Habit that can only be scored positively.

## PARAMETERS

### -Type
The type of the task.
Valid values are: "todo", "daily", "habit".

```yaml
Type: String
Parameter Sets: (All)
Aliases: Title

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Text
The title or name of the task.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Alias
A custom string identifier for the task (unique within your account).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Note
An optional description or additional details for the task.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tags
A list of tag IDs or names to associate with the task.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Priority
Task difficulty.
Valid values are:
0.1 = Trivial, 1 = Easy, 1.5 = Medium, 2 = Hard.
(Default is 1).

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Attribute
Which attribute this task affects.
Valid values are:
"str", "int", "con", "per".
(Default is "str").

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Int
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Checklist
An array of checklist item texts to include in the task.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DueDate
(For todos only) Due date of the task.

```yaml
Type: DateTime
Parameter Sets: Todo
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Frequency
(For dailies only) Recurrence type.
Valid values:
"daily", "weekly", "monthly", "yearly".

```yaml
Type: String
Parameter Sets: Daily
Aliases:

Required: False
Position: Named
Default value: Daily
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RepeatDays
(For dailies only) Days of the week to repeat.
Example: @(1,3,5).

```yaml
Type: Int32[]
Parameter Sets: Daily
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WeeksOfMonth
(For dailies only) Which weeks of the month the daily should repeat.

```yaml
Type: Int32[]
Parameter Sets: Daily
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DaysOfMonth
(For dailies only) Specific days of the month to repeat.

```yaml
Type: Int32[]
Parameter Sets: Daily
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Up
(For habits only) Whether the habit can be scored "up" (positive).

```yaml
Type: SwitchParameter
Parameter Sets: Habit
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Down
(For habits only) Whether the habit can be scored "down" (negative).

```yaml
Type: SwitchParameter
Parameter Sets: Habit
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
