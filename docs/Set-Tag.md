---
external help file: pshabitica-help.xml
Module Name: pshabitica
online version:
schema: 2.0.0
---

# Set-Tag

## SYNOPSIS
Updates an existing Habitica tag.

## SYNTAX

```
Set-Tag [-Id] <String> [-Name] <String> [<CommonParameters>]
```

## DESCRIPTION
Calls the Habitica API to update the name of an existing tag by its ID.

## EXAMPLES

### EXEMPLO 1
```
Set-Tag -Id "12345678-abcd-1234-abcd-1234567890ab" -Name "UpdatedTag"
```

Renames the specified tag to "UpdatedTag".

### EXEMPLO 2
```
Get-Tag | Where-Object { $_.name -eq "Work" } | Set-Tag -Name "Office"
```

Finds the "Work" tag and renames it to "Office".

## PARAMETERS

### -Id
The ID of the tag to update.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
The new name for the tag.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
