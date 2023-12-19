#Import Tenant settings
$paramTenant = Import-Csv ".\tenantconfig.csv"
$resourceGroups = "mgmt","identity","AVD","GEN","storage","NET"

#Select Subscription to create resources
Select-AzSubscription -Subscription $paramTenant.subscriptionid

#Create ResourceGroups
foreach($group in $resourceGroups) {
    $resourceGroup = $paramTenant.tenantid + "-" + $group
    Write-Host "Creating ResourceGroup" $resourceGroup
    New-AzResourceGroup -Name $resourceGroup -Location $paramTenant.location
}

