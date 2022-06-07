# Schedules midnight restart using Task Scheduler.

#create action
$taskAction = New-ScheduledTaskAction `
    -Execute "shutdown" `
    -Argument "/r"

$taskAction

$targetDate = (Get-Date).AddDays(1)
$targetDate = $targetDate.Date

#create trigger                                     
$taskTrigger = New-ScheduledTaskTrigger -Once -At $targetDate
$taskTrigger


#name of scheduled task
$taskName = "ServerRestart"

#description of scheduled task
$description = "Scheduled server restart."

#Register the scheduled task
Register-ScheduledTask `
    -TaskName $taskName `
    -Action $taskAction `
    -Trigger $taskTrigger `
    -Description $description 
