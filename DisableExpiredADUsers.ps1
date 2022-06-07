# This script disables expired AD users, and users that have not logged-in in over 90 days.
# Run on Domain Controller server

#Find Expired accounts and disable them
Search-ADAccount -AccountExpired -UsersOnly | Where-Object {$_.Enabled}| Disable-ADAccount

#Find accounts that haven't been logged into in over 90 days and disable them. Modify as needed.
$date = (Get-Date).AddDays(-90)
Search-ADAccount -AccountInactive -UsersOnly -DateTime $date | Where-Object {$_.Enabled -and $_.LastLogonDate -ne $NULL} | Disable-ADAccount