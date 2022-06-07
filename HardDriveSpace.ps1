#Script checks each drive mapped to computer and writes to host if there are drives with over 90% utilization

$computername = (Get-Content Env:COMPUTERNAME)
$volumes = (Get-Volume)
$listOfDrives = @()

#$volumes.GetType().SizeRemaining

foreach($volume in $volumes)
{
    $spaceRemaining = [single]($volume.SizeRemaining)
    $spaceAlloted = [single]($volume.Size)
    $spaceUnusedPercent = ($spaceRemaining / $spaceAlloted)

    if($spaceUnusedPercent -lt .10)
    {

       $listOfDrives += [string]($volume.DriveLetter)

    }

}

if(($listOfDrives.Count -ge 1))
{
Write-Host ("Drives with over 90% utilization on " + $computername + ":")
$listOfDrives
}