---
external help file: pshabitica-help.xml
Module Name: pshabitica
online version:
schema: 2.0.0
---

# New-Tag

## SYNOPSIS
Creates a new tag in Habitica.

## SYNTAX

```
New-Tag [-Name] <String> [<CommonParameters>]
```

## DESCRIPTION
Calls the Habitica API to create a new tag associated with the authenticated user.

## EXAMPLES

### EXEMPLO 1
```
New-Tag -Name "Work"
```

Creates a new tag named "Work".

### EXEMPLO 2
```
"Fitness","Health" | ForEach-Object { New-Tag -Name $_ }
```

Creates multiple tags at once.

## PARAMETERS

### -Name
The name of the tag to create.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
