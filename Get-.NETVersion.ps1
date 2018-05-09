$Reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $Server)
    $RegKey= $Reg.OpenSubKey("SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full")
    [int]$NetVersionKey= $RegKey.GetValue("Release")
 
    if($NetVersionKey -ge 381029)
    {
        "4.6 or later"
        return
    }
    switch ($NetVersionKey)
    {
        {($_ -ge 378389) -and ($_ -lt 378675)} {"4.5"}
        {($_ -ge 378675) -and ($_ -lt 379893)} {"4.5.1"}
        {$_ -ge 379893} {"4.5.2"}
        default {"Unable to Determine"}
    } 