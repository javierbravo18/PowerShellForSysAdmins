#Run on Domain Controller server, and modify groups as needed.

Import-Module ServerManager
Add-WindowsFeature -Name "RSAT-AD-PowerShell" –IncludeAllSubFeature
#check if log file exists
$filecheck = Test-Path -Path C:\logFiles\userLog.txt -PathType Leaf

#if log file does not exist, create it
if ($filecheck -ne "True") {

    New-Item -Path "C:\" -Name "logFiles" -ItemType "directory"

    New-Item -Path "C:\logFiles\" -Name "userLog.txt" -ItemType "file" -Value "Monthly User Log:"

    $filecheck = Test-Path -Path C:\logFiles\userLog.txt -PathType Leaf

    Write-Output "Log file has been created."
}

#disable accounts that have expired so that they are not counted
Search-ADAccount -AccountExpired -UsersOnly | Where-Object {$_.Enabled}| Disable-ADAccount

#Find accounts that haven't been logged into in over 90 days and disable them so they are not counted
$date = (Get-Date).AddDays(-90)
Search-ADAccount -AccountInactive -UsersOnly -DateTime $date | Where-Object {$_.Enabled -and $_.LastLogonDate -ne $NULL} | Disable-ADAccount

# Get Servername and Date and append it to the log file
$hostname = HOSTNAME.EXE
$today = Get-Date -format 'MM-dd-yyyy'
"Date: $today Server name: $hostname"  | Out-File -FilePath C:\logFiles\userLog.txt -Append

# Get active user count and append it to the log file
$userCount = (Get-AdUser -filter * |Where {$_.enabled -eq "True"}).count 
"Total active user count: $userCount" | Out-File -FilePath C:\logFiles\userLog.txt -Append

#Get member groups of Word
$groupsWord = @(Get-ADGroupMember -Identity 'MSWord')

#Get member groups of Excel
$groupsExcel = @(Get-ADGroupMember -Identity 'MSExcel')

#write word users per client header in logfile
"Word users per client:"  | Out-File -FilePath C:\logFiles\userLog.txt -Append

ForEach ($group in $groupsWord){
    
    $client = $group.Name

    $wordusers =  @(Get-ADGroupMember -Identity $group.Name)

    $wordcount = $wordusers.count
    
    "$client users: $wordcount"  | Out-File -FilePath C:\logFiles\userLog.txt -Append

}

#write excel users per client header in logfile
"Excel users per client:"  | Out-File -FilePath C:\logFiles\userLog.txt -Append

ForEach ($group in $groupsExcel){
    
    $client = $group.Name

    $excelusers =  @(Get-ADGroupMember -Identity $group.Name)

    $excelcount = $excelusers.count
    
    "$client users: $excelcount"  | Out-File -FilePath C:\logFiles\userLog.txt -Append

}

#Leave an empty line below so each month is separated in the log file.
" "  | Out-File -FilePath C:\logFiles\userLog.txt -Append

