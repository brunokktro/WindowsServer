
## Obtém as informações da chave de registro e suas entradas/modificações
Get-ItemProperty "hkcu:\Software\Policies\Microsoft\Internet Explorer\Control Panel"

## Altera as opções da chave de Registro especificada
Set-ItemProperty -Path "hkcu:\Software\Policies\Microsoft\Internet Explorer\Control Panel" -Name Proxy -Value 0
Set-ItemProperty -Path "hkcu:\Software\Policies\Microsoft\Internet Explorer\Control Panel" -Name Autoconfig -Value 0
