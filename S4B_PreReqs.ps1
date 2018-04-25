## All Server Roles require:
	# - Windows PowerShell 3.0 (is installed by default)
	# - Microsoft .NET Framework 4.5 (http://go.microsoft.com/fwlink/p/?LinkId=268529) 
	# Additional Step's after Installation: Select WCF Activation if it isn’t already selected. 
	# Then select HTTP Activation, or include in PowerShell
	# - Windows Identity Foundation 3.5 (activate via Server Manager) or add via PowerShell 
	    Add-WindowsFeature Windows-Identity-Foundation
	
    # - .NET 3.5 (must be manually activated)
	## Silverlight (https://www.microsoft.com/silverlight/)
 
## PowerShell to add features and roles
Add-WindowsFeature RSAT-ADDS, Web-Server, Web-Static-Content, Web-Default-Doc, Web-Http-Errors, Web-Asp-Net, Web-Net-Ext, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Http-Logging, Web-Log-Libraries, Web-Request-Monitor, Web-Http-Tracing, Web-Basic-Auth, Web-Windows-Auth, Web-Client-Auth, Web-Filtering, Web-Stat-Compression, Web-Dyn-Compression, NET-WCF-HTTP-Activation45, Web-Asp-Net45, Web-Mgmt-Tools, Web-Scripting-Tools, Web-Mgmt-Compat, Telnet-Client, BITS, Desktop-Experience, Windows-Identity-Foundation -Source D:\sources\sxs