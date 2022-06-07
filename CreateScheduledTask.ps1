#This script is for creating a Scheduled Task to run the PowerShell script you specifiy as $scriptPath

#Enter path to Powershell script, for example C:\scripts\Pull-AD-Count.ps1
$scriptPath = "<EnterPathToPSScript>"

$taskAction = New-ScheduledTaskAction `
    -Execute 'powershell.exe' `
    -Argument "-File $scriptPath"

#create trigger, currently set to trigger daily at 9am. Modify parameters as needed.                                     
$taskTrigger = New-ScheduledTaskTrigger -Daily -At 9am


#name of scheduled task, modify as needed
$taskName = "Active user count"

#description of scheduled task, modify as needed
$description = "Scheduled task to run Pull-AD-Count.ps1, the output will contain active users, and word/excel users. It will be added to a log file under C:\logFiles\userLog.txt"

#Register the scheduled task
Register-ScheduledTask -TaskName $taskName -Action $taskAction -Trigger $taskTrigger -Description $description -Force