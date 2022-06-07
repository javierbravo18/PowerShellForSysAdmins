#This script retrives users who have not logged-in in amount of time specified below.
#Run on Domain Controller server

#Getting users who haven't logged in over 90 days, modify the -90 value as needed
$Date = (Get-Date).AddDays(-90)
 
#Filtering All enabled users who haven't logged in in amount of time specified above.
Get-ADUser -Filter {((Enabled -eq $true) -and (LastLogonDate -lt $date))} -Properties LastLogonDate | select samaccountname, Name, LastLogonDate | Sort-Object LastLogonDate