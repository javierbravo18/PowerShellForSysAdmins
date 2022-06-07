# Access Citrix subscribtion without needing to input credentials each time.
Set-XDCredentials -APIKey <EnterCitrixAPIKey> -SecretKey <EnterCitrixKey> -CustomerId <EnterCustomerID> -StoreAs $XDStoredCredentials
Get-XDAuthentication

#Enter SMTP (Mail Server) information, used to send Alerts
$password = "<EnterSMTPAccountPassword>" | ConvertTo-SecureString -asPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ("<EnterSMTPAccountUsername>", $password)
$smtpServer = "<EnterSMTPServerAddress>" #for example smtp.fake.com
$senderEmail = "<EnterEmailSender>"      # fake@gmail.com
$receiverEmail = "<EnterEmailToReceive>"


$citrixMachines = (Get-BrokerMachine)
$totalMachines = $citrixMachines.count
$ErrorActionPreference = "Continue"
$machinesInMaintenanceMode = @()
$totalCount = 0

foreach($machine in $citrixMachines)
{

    if($machine.PowerState -eq 'On' -and $machine.MaintenanceModeReason -eq 'Administrator')
    {
        $totalCount += 1
        $machinesInMaintenanceMode += [string]($machine.DNSName)

    }

if($totalCount -ge 1)
{

    $message = "$totalCount Citrix machines are in Maintenance Mode! See their computer names: $machinesInMaintenanceMode"
    Write-Host ($message)
    Send-MailMessage -From "$senderEmail" -To "$receiverEmail" -Subject "Citrix MM Alert" -Body "$message" –SmtpServer '$smtpServer' -Credential $mycreds

}

else
{
    Write-Host ("No Citrix machines are in Maintenance Mode.")
}