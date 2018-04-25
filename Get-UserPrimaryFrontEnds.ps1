#
# Get-UserPrimaryFrontEnds.ps1
#

$LogFileName = [string]$Env:Temp + "\Get-UserPrimaryFrontEnds_" + (Get-Date -format "yyyyMMdd_hhmm") + ".log"

if (test-path -path $LogFileName)
  { 
    clear-content -path $LogFileName 
  }
else 
  { 
    new-item -path $LogFileName -type file | out-null
    if (!(test-path -path $LogFileName))
      {
        write-host "Unable to create log file in temp folder"
      }
  }

write-host 

$poolfqdn = read-host "Pool FQDN"

write-host

$frontend = ((get-cspool $poolfqdn).computers) | get-random

$list = @(SQLCMD.exe -S "tcp:$frontend\RTCLOCAL" -d "rtc" -W -Q "Select r.UserAtHost, fe.Fqdn From dbo.Resource as r with (nolock) Inner join dbo.ResourceDirectory as rd with (nolock) on (rd.ResourceId = r.ResourceId) Inner join dbo.RoutingGroupAssignment as rga with (nolock) on (rga.RoutingGroupId = rd.RoutingGroupId) Inner join dbo.FrontEnd as fe with (nolock) on (fe.FrontEndId = rga.FrontEndId)")

if ($list)
  {
    $title = "User Primary Front Ends (" + (Get-Date -format g) +")"
    $sepcount = ($title.tochararray()).count

    write-host
    write-host $title 
    write-host $('='*($sepcount))

    add-content " " -path $LogFileName
    add-content $title -path $LogFileName
    add-content $('='*($sepcount)) -path $LogFileName

    foreach ($item in $list) 
      {  
        if ($item -match "@")
          { 
            $value = ([string]$item).split(" ")
            $value = $value[1] + $(' '*(2)) + $value[0]
            write-host $value
            add-content $value -path $LogFileName
          }
      }
  }

write-host
