
## Obtém as informações da chave de registro e suas entradas/modificações (ver key DisabledComponents)
Get-ItemProperty "hklm:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"

## Obtém as pastas-filho da chave de Registro especificada
Get-ChildItem "hklm:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"

## Note The Internet Protocol Version 6 (TCP/IPv6) check box affects only the specific network adapter and will unbind IPv6 from the selected network adapter. 
## To disable IPv6 on the host, use the DisabledComponents registry value. 
## The DisabledComponents registry value does not affect the state of the check box. 
## Therefore, even if the DisabledComponents registry key is set to disable IPv6, the check box in the Networking tab for each interface can still be checked. 
##This is expected behavior.

## Refer: https://support.microsoft.com/en-us/help/929852/how-to-disable-ipv6-or-its-components-in-windows
