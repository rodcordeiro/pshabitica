---
external help file: pshabitica-help.xml
Module Name: pshabitica
online version:
schema: 2.0.0
---

# Set-Task

## SYNOPSIS
Updates an existing Habitica task.

## SYNTAX

### Todo (Default)
```
Set-Task -TaskId <String> [-Text <String>] [-Notes <String>] [-Priority <Double>] [-Tags <String[]>]
 [<CommonParameters>]
```

### Habit
```
Set-Task -TaskId <String> [-Text <String>] [-Notes <String>] [-Priority <Double>] [-Tags <String[]>]
 [-Up <Boolean>] [-Down <Boolean>] [<CommonParameters>]
```

### Daily
```
Set-Task -TaskId <String> [-Text <String>] [-Notes <String>] [-Priority <Double>] [-Tags <String[]>]
 [-StartDate <DateTime>] [-Repeat <Hashtable>] [-Frequency <String>] [<CommonParameters>]
```

## DESCRIPTION
Calls the Habitica API to update a task by ID. 
Parameters are grouped into sets depending on the task type (\`todo\`, \`daily\`, or \`habit\`).

## EXAMPLES

### EXEMPLO 1
```
Set-Task -TaskId "abcd1234" -Type todo -Text "Finish docs" -Priority 2
```

### EXEMPLO 2
```
Set-Task -TaskId "abcd1234" -Type daily -StartDate (Get-Date) -Repeat @{ m=$true; t=$true; w=$true }
```

## PARAMETERS

### -TaskId
The unique identifier of the Habitica task to update.

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

### -Text
The new title of the task.

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

### -Notes
The description or details of the task.

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

### -Priority
Priority multiplier for the task.
Typical values: 0.1 (trivial), 1 (easy), 1.5 (medium), 2 (hard).

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tags
A list of tag names to associate with the task.
Tags are automatically resolved to their IDs if they exist.

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

### -StartDate
(Dailies only) Start date for the daily task.

```yaml
Type: DateTime
Parameter Sets: Daily
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Repeat
(Dailies only) Days of the week the task repeats.
Example: @{ su=$false; m=$true; t=$true; w=$true; th=$true; f=$true; s=$false }

```yaml
Type: Hashtable
Parameter Sets: Daily
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Frequency
(Dailies only) Interval type.
Valid values: "daily", "weekly", "monthly", "yearly".

```yaml
Type: String
Parameter Sets: Daily
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Up
(Habits only) Whether the habit can increment positively.

```yaml
Type: Boolean
Parameter Sets: Habit
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Down
(Habits only) Whether the habit can decrement negatively.

```yaml
Type: Boolean
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
