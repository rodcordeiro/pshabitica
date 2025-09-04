---
external help file: pshabitica-help.xml
Module Name: pshabitica
online version:
schema: 2.0.0
---

# Get-Tag

## SYNOPSIS
Retrieves the current user's tags from Habitica.

## SYNTAX

```
Get-Tag [<CommonParameters>]
```

## DESCRIPTION
Calls the Habitica API to return the list of tags defined by the user.
Tags can be used to group tasks like todos, dailies, or habits.

## EXAMPLES

### EXEMPLO 1
```
Get-Tag
```

Returns all tags for the authenticated Habitica user.

### EXEMPLO 2
```
Get-Tag | Where-Object { $_.name -eq "Work" }
```

Returns the "Work" tag object.

### EXEMPLO 3
```
(Get-Tag).name
```

Lists the names of all tags.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
