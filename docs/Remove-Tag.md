---
external help file: pshabitica-help.xml
Module Name: pshabitica
online version:
schema: 2.0.0
---

# Remove-Tag

## SYNOPSIS
Deletes a Habitica tag.

## SYNTAX

```
Remove-Tag [-Id] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Calls the Habitica API to delete a tag by its ID.

## EXAMPLES

### EXEMPLO 1
```
Remove-Tag -Id "12345678-abcd-1234-abcd-1234567890ab"
```

Deletes the specified tag.

### EXEMPLO 2
```
Get-Tag | Where-Object { $_.name -eq "Obsolete" } | Remove-Tag
```

Deletes the tag named "Obsolete".

## PARAMETERS

### -Id
The ID of the tag to delete.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
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
