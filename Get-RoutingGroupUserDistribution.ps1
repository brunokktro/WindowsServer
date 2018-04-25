#
# Get-RoutingGroupUserDistribution.ps1
#

function GetADObject ($ObjectDN)
{
      $ADObject =  New-Object DirectoryServices.DirectoryEntry "LDAP://$ObjectDN"
      $ADObject
}

$LogFileName = [string]$Env:Temp + "\Get-RoutingGroupUserDistribution_" + (Get-Date -format "yyyyMMdd_hhmm") + ".log"

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

$groups = @()
$list = @()

$pool = read-host "Pool FQDN"
$users = @(get-csuser | where {$_.registrarpool -match $pool})
$appendpoints = @(get-csapplicationendpoint | where {$_.registrarpool -match $pool})

$users += $appendpoints

if (!($users)) 
  { 
    write-host "No users found in $pool" 
    exit 
  }
else
  {
    foreach ($user in $users)
      { 
        $object = GetADObject $user.distinguishedName
        $guid = [guid]$object."msRTCSIP-UserRoutingGroupId".value
        $groups += [string]$guid
      }
    if (!($groups)) 
      { 
        write-host "No routing groups found in $pool"
        exit 
      }

  }

$title = "Routing Group User Distribution (" + (Get-Date -format g) +")"
$sepcount = ($title.tochararray()).count

write-host
write-host $title 
write-host $('='*($sepcount))

add-content " " -path $LogFileName
add-content $title -path $LogFileName
add-content $('='*($sepcount)) -path $LogFileName

foreach ($group in $groups)
  { 
    foreach ($object in $groups)
      { 
        if ($object -match $group)
          { 
            $count += 1 
          }
      }
    $group = (($group + $(' '*(6)) + $count))
    $list += $group
    $count = 0
  }

$list = $list | select-object -unique 

foreach ($item in $list)
   { 
     write-host $item
     add-content $item -path $LogFileName
   }

write-host
