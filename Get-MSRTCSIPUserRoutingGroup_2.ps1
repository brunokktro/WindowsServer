$user = get-aduser -filter * -Properties name,MsRTCSIP-UserRoutingGroupID | where {$_."MsRTCSIP-UserRoutingGroupID" -ne $Null}

foreach ($item in $user){

	$HexRoutingGroupID = @()

	ForEach ($StringValue in $item."MsRTCSIP-UserRoutingGroupID")
	{

		$HexValue = "{0:x}" -f $StringValue
		$HexRoutingGroupID = $HexRoutingGroupID + $HexValue

	}

	$UserRoutingGroupID1Inverse = $HexRoutingGroupID[-13..(-16)]
	$UserRoutingGroupID2Inverse = $HexRoutingGroupID[-11..(-12)]
	$UserRoutingGroupID3Inverse = $HexRoutingGroupID[-9..(-10)]
	$UserRoutingGroup4 = $HexRoutingGroupID[8..16]
 	$outputvalue = $item.name +", "+ $UserRoutingGroupID1Inverse +" " + $UserRoutingGroupID2Inverse + " " + $UserRoutingGroupID3Inverse + " " + $UserRoutingGroup4
	$outputvalue
}