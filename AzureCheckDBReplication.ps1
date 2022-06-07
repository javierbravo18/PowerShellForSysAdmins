#To connect to Azure subscription, uncomment line below and enter Azure subscriptionID
#Connect-AzAccount -Subscription <SubscriptionID>

#For Primary enter Azure SQL Server name, for PartnerResourceGroup enter the name of the Resource Group where the Azure SQL Server is being replicated to.
$East = @{Primary='<AzureSQLServerName>';PartnerResourceGroup = '<ReplicationResourceGroup (where Primary is being replicated to)>'}
$West = @{Primary='<AzureSQLServerName>';PartnerResourceGroup = '<ReplicationResourceGroup (where Primary is being replicated to)>'}
$North = @{Primary='<AzureSQLServerName>';PartnerResourceGroup = '<ReplicationResourceGroup (where Primary is being replicated to)>'}
$South = @{Primary='<AzureSQLServerName>';PartnerResourceGroup = '<ReplicationResourceGroup (where Primary is being replicated to)>'}

$SQLServers = (Get-AzSqlServer)
$listOfDbs = @()

foreach($i in $SQLServers) {

    $ServerName = $i.ServerName

    $ResourceGroup = $i.ResourceGroupName

    $SqlDatabase = (Get-AzSqlDatabase -ServerName $ServerName -ResourceGroupName $ResourceGroup -WarningAction SilentlyContinue) 

    if($ServerName -eq $East.Primary){

        $PartnerResourceGroup = $East.PartnerResourceGroup

    }

    if($ServerName -eq $West.Primary){

        $PartnerResourceGroup = $West.PartnerResourceGroup

    }

    if($ServerName -eq $North.Primary){

        $PartnerResourceGroup = $North.PartnerResourceGroup

    }

     
    if($ServerName -eq $South.Primary){

        $PartnerResourceGroup = $South.PartnerResourceGroup

    }



    foreach($database in $SqlDatabase) 
    {

        $replication = (Get-AzSqlDatabaseReplicationLink -DatabaseName $database.DatabaseName -PartnerResourceGroupName $PartnerResourceGroup -ResourceGroupName $ResourceGroup -ServerName $ServerName -WarningAction SilentlyContinue)


        if(($replication -eq $null) -and ($database.DatabaseName -notlike '*Test*')){
            
            $listOfDbs += $database.DatabaseName

        }

    }


}

Write-Host "WebApp databases missing replication:";
Write-Host "-------------------------------------";

$listOfDbs | sort -descending
