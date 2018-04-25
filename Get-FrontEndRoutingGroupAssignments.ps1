#
# Get-FrontEndRoutingGroupAssignments.ps1
#

$LogFileName = [string]$Env:Temp + "\Get-FrontEndRoutingGroupAssignments_" + (Get-Date -format "yyyyMMdd_hhmm") + ".log"

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

$frontend = ((get-cspool $poolfqdn).computers) | get-random

$list = @(SQLCMD.exe -S "tcp:$frontend\RTCLOCAL" -d "rtc" -W -Q "select fe.Fqdn, rga.RoutingGroupName from dbo.RoutingGroupAssignment as rga with (nolock) inner join dbo.FrontEnd as fe with (nolock) on (fe.FrontEndId = rga.FrontEndId) order by fe.Fqdn")

if ($list)
  { 
    $title = "Front End Routing Group Assignments (" + (Get-Date -format g) +")"
    $sepcount = ($title.tochararray()).count

    write-host
    write-host $title 
    write-host $('='*($sepcount))

    add-content " " -path $LogFileName

    add-content $title -path $LogFileName
    add-content $('='*($sepcount)) -path $LogFileName
  
    foreach ($item in $list) 
      {  
        if (($item -match "-") -and ($item -notmatch "--"))
          { 
            $value = ([string]$item).split(" ")
            $value = $value[1] + $(' '*(2)) + $value[0]
            write-host $value
            add-content $value -path $LogFileName
          }
      }
  }

write-host