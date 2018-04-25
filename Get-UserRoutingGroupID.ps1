#
# Get-UserRoutingGroupID.ps1
#

function GetADObject ($ObjectDN)
{
      $ADObject =  New-Object DirectoryServices.DirectoryEntry "LDAP://$ObjectDN"
      $ADObject
}

$LogFileName = [string]$Env:Temp + "\Get-UserRoutingGroupID_" + (Get-Date -format "yyyyMMdd_hhmm") + ".log"

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

$sipaddr = read-host "SIP Address"
$user = get-csuser | where {$_.sipaddress -match $sipaddr}

if (!($user))
  { 
    $user = get-csapplicationendpoint | where {$_.sipaddress -match $sipaddr}
    if (!($user))
      { 
        write-host "SIP address not found."
        exit
      }
  }

$object = GetADObject $user.distinguishedName
$id = [guid]$object."msRTCSIP-UserRoutingGroupId".value

if ($id)
  {
    $title = "User Routing Group ID (" + (Get-Date -format g) +")"
    $sepcount = ($title.tochararray()).count

    write-host
    write-host $title 
    write-host $('='*($sepcount))

    add-content " " -path $LogFileName
    add-content $title -path $LogFileName
    add-content $('='*($sepcount)) -path $LogFileName

    write-host "SIP Address   : $sipaddr"
    write-host "RoutingGroupID: $id"
    write-host

    add-content "SIP Address   : $sipaddr" -path $LogFileName
    add-content "RoutingGroupID: $id" -path $LogFileName

    write-host
  }

