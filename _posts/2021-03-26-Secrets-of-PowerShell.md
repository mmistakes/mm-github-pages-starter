---
Title: PowerShell Secrets
Date: 2021-03-26 22:40 -0800
Categories: tech powershell 2021
---

## Secrets??

![](/assets/images/pirate_meme.jpg)

I've been on a journey to better verse myself in PowerShell.. And some say a great way to learn is to teach, so here goes..


Ok enough intro, `Get-Help`, and `Get-Command`. That's it. That's the secret. `Get-help` and `Get-Command` are two of the great secrets of PowerShell. Well they aren't really secrets, they're just overlooked. 

I believe that using these two commands is one of if not the best way to learn PowerShell cmdlets as they were intended to work. 

- Can't quite remember the full command? No problem just use `Get-Command` with * wildcards like so:

```PowerShell

Get-Command *dns*

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Alias           dnsn -> Disconnect-PSSession
Function        Add-DnsClientNrptRule                              1.0.0.0    DnsClient
Function        Add-VpnConnectionTriggerDnsConfiguration           2.0.0.0    VpnClient
Function        Clear-DnsClientCache                               1.0.0.0    DnsClient
Function        Disable-NetDnsTransitionConfiguration              1.0.0.0    NetworkTransition
Function        Enable-NetDnsTransitionConfiguration               1.0.0.0    NetworkTransition
Function        Get-DnsClient                                      1.0.0.0    DnsClient
Function        Get-DnsClientCache                                 1.0.0.0    DnsClient
Function        Get-DnsClientGlobalSetting                         1.0.0.0    DnsClient
Function        Get-DnsClientNrptGlobal                            1.0.0.0    DnsClient
Function        Get-DnsClientNrptPolicy                            1.0.0.0    DnsClient
Function        Get-DnsClientNrptRule                              1.0.0.0    DnsClient
Function        Get-DnsClientServerAddress                         1.0.0.0    DnsClient
Function        Get-NetDnsTransitionConfiguration                  1.0.0.0    NetworkTransition
Function        Get-NetDnsTransitionMonitoring                     1.0.0.0    NetworkTransition
Function        Register-DnsClient                                 1.0.0.0    DnsClient
Function        Remove-DnsClientNrptRule                           1.0.0.0    DnsClient
Function        Remove-VpnConnectionTriggerDnsConfiguration        2.0.0.0    VpnClient
Function        Reset-NetDnsTransitionConfiguration                1.0.0.0    NetworkTransition
Function        Set-DnsClient                                      1.0.0.0    DnsClient
Function        Set-DnsClientGlobalSetting                         1.0.0.0    DnsClient
Function        Set-DnsClientNrptGlobal                            1.0.0.0    DnsClient
Function        Set-DnsClientNrptRule                              1.0.0.0    DnsClient
Function        Set-DnsClientServerAddress                         1.0.0.0    DnsClient
Function        Set-NetDnsTransitionConfiguration                  1.0.0.0    NetworkTransition
Function        Set-VpnConnectionTriggerDnsConfiguration           2.0.0.0    VpnClient
Cmdlet          Resolve-DnsName                                    1.0.0.0    DnsClient
```

Here it lists all cmdlets within installed modules with "dns" in the name.

A tip for using `Get-Help` (I usually like using it's alias `help`) is adding the -examples or -full parameters to get all of that sweet sweet info for the command in question.

For example let's use the cmdlet: `Get-DnsClient` we want to know some of it's parameters, and maybe an example of how it's used. The -Full parameter would be a good choice for this;

`Get-Help Get-DnsClient -full` 

I won't post the long output here, but Feel free to try this out with this and other commands.

I'll be adding more quick PowerShell tip posts as I work my way through learning the ins and outs.

