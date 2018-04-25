<#
.DESCRIPTION
	This script checks for issues with certificates in the Certificate Store.

.NOTES
  Version      	   		: 1.0
  Author    			: David Paulino http://blogs.technet.com/b/uclobby/
  Change Log            : https://gallery.technet.microsoft.com/LyncSkype4B-Certificate-81944851
  

#>

$startTime=Get-Date;

Write-Host "Check #1 – Misplaced certificates in Trusted Root CA" -ForegroundColor Cyan
$check = Get-Childitem cert:\LocalMachine\root -Recurse | Where-Object {$_.Issuer -ne $_.Subject}

if(($check).count -gt 0){
Write-Host "Found" ($check).count "misplaced certificate(s) in Trusted Root CA:" -ForegroundColor yellow
$check | Select Issuer, Subject, Thumbprint | fl 
} else {
Write-Host "No misplaced certificate found in Trusted Root CA." -ForegroundColor Green
}

Write-Host "Check #2 – Duplicates in Trusted Root CA" -ForegroundColor Cyan
$check = Get-Childitem cert:\LocalMachine\root | Group-Object -Property Thumbprint | Where-Object {$_.Count -gt 1}

if(($check).count -gt 0){
Write-Host "Found" ($check).count "duplicated Trusted Root CA certificate(s):" -ForegroundColor yellow
$check | Select Issuer, Subject, Thumbprint | fl 
} else {
Write-Host "No duplicated certificate(s) found." -ForegroundColor Green
}

Write-Host "Check #3 – More than 100 certificates in Trusted Root CA store" -ForegroundColor Cyan
$check = (Get-Childitem cert:\LocalMachine\root).count

if($check -gt 100){
Write-Host "Found" $check "Trusted Root CA certificates." -ForegroundColor yellow
$check | Select Issuer, Subject, Thumbprint | fl 
} else {
Write-Host "Found" $check "Trusted Root CA certificates." -ForegroundColor Green
}

Write-Host "Check #4 – Root CA certificates in Personal Store" -ForegroundColor Cyan
$check = Get-Childitem cert:\LocalMachine\my -Recurse | Where-Object {$_.Issuer -eq $_.Subject} 

if(($check).count -gt 0){
Write-Host "Found" ($check).count "Root CA certificate(s) in Personal Store:" -ForegroundColor yellow
$check | Select FriendlyName, Issuer, Subject, Thumbprint | fl 
} else {
Write-Host "No Root CA certificate(s) found in Personal Store." -ForegroundColor Green
}


Write-Host "Check #5 – Duplicated Friendly Name" -ForegroundColor Cyan
$check = Get-Childitem cert:\LocalMachine\my | Group-Object -Property FriendlyName | Where-Object {$_.Count -gt 1} 

if(($check).count -gt 0){
Write-Host "Found" ($check).count "certificate(s) with the same Friendly Name:" -ForegroundColor yellow
$check | Select-Object -ExpandProperty Group | Select FriendlyName, Issuer, Subject, Thumbprint | fl
} else {
Write-Host "No duplicated certificate(s) found." -ForegroundColor Green
}

Write-Host "Check #6 – Misplaced Root CA certificates in Intermediate CA store" -ForegroundColor Cyan
$check = Get-ChildItem Cert:\localmachine\CA | Where-Object {$_.Issuer -eq $_.Subject} 

if(($check).count -gt 0){
Write-Host "Found" ($check).count "misplaced Root CA certificate(s) in Intermediate CA store:" -ForegroundColor yellow
$check | Select Issuer, Subject, Thumbprint | fl
} else {
Write-Host "No misplaced Root CA certificate found." -ForegroundColor Green
}

$endTime=Get-Date; 
$totalTime= [math]::round(($endTime - $startTime).TotalSeconds,2)
Write-Host "Execution time:" $totalTime "seconds." -ForegroundColor Cyan