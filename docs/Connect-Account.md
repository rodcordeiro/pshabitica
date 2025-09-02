---
external help file: pshabitica-help.xml
Module Name: pshabitica
online version:
schema: 2.0.0
---

# Connect-Account

## SYNOPSIS
Connects to a Habitica account and securely stores authentication data in a SecretVault.

## SYNTAX

```
Connect-Account [-Client] <String> [-Username] <String> [-Password] <SecureString> [<CommonParameters>]
```

## DESCRIPTION
This function authenticates a user against Habitica's API using username and password.
Once authenticated, it stores the User ID, API Token, and Client identifier in a SecretVault ("PSHabitica"),
allowing subsequent API calls to authenticate without reentering credentials.

## EXAMPLES

### EXEMPLO 1
```
$password = Read-Host "Enter Habitica password" -AsSecureString
```

PS\> Connect-Account -Client "myuser-pshabitica" -Username "myuser@email.com" -Password $password

Connects to Habitica and stores the authentication data in the SecretVault.

### EXEMPLO 2
```
$password = ConvertTo-SecureString "SuperSecret123" -AsPlainText -Force
```

PS\> Connect-Account -Client "dev-pshabitica" -Username "dev@example.com" -Password $password

Connects with plain text converted to SecureString.

### EXEMPLO 3
```
$password = Get-Credential | Select-Object -ExpandProperty Password
```

PS\> Connect-Account -Client "corp-pshabitica" -Username "corpadmin" -Password $password

Uses Windows Credential Manager prompt to obtain the SecureString password.

## PARAMETERS

### -Client
The x-client attribute.
Required by Habitica API. 
Format: \<username\>-\<appname\>.
Refer to: https://github.com/HabitRPG/habitica/wiki/API-Usage-Guidelines#x-client-header

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Username
The Habitica username (email address or handle).
Required for first authentication.

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

### -Password
The Habitica account password, passed as a SecureString.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Rodrigo Cordeiro  
Module: PSHabitica  
This function registers the SecretVault "PSHabitica" automatically if not present.

## RELATED LINKS
