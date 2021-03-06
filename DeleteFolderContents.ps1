# This script is for deleting the contents of a folder

#For folder whose content you want to delete, enter folder path like so C:\FakeFolder
$folderPath = <EnterFolderPath>
$folderDelete = Get-ChildItem $folderPath
$day = (Get-Date).Day
$month = (Get-Date).Month
$year = (Get-Date).Year
#Modify the -30 value to match your needs. -30 value means that all files that have not been modified in 30 days will be deleted. 
#if all files need to be deleted then remove the portion .AddDays(-30)
$deleteDate = (Get-Date).AddDays(-30)


foreach($i in $folderDelete)
{

    if($i.LastWriteTime -le $deleteDate)
    {
        
        $folderName = $i.Name
        
        try
        {
            Remove-Item "$folderPath\$folderName" -Recurse -ErrorAction Stop
            Write-Host("Deleting the following file: $folderName.")
            
        }

        catch
        {

            Write-Host("Could not delete file: $folderName.")

        }

    }

}
