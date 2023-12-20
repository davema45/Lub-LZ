#Import Tenant settings
$paramTenant = Import-Csv ".\tenantconfig.csv"
$resourceGroups = "mgmt-rg","identity-rg","AVD-rg","GEN-rg","storage-rg","NET-rg"

#Select Subscription to create resources
Select-AzSubscription -Subscription $paramTenant.subscriptionid

#Create ResourceGroups
foreach($group in $resourceGroups) {
    $resourceGroup = $paramTenant.tenantid + "-" + $group
    Write-Host "Creating ResourceGroup" $resourceGroup
    New-AzResourceGroup -Name $resourceGroup -Location $paramTenant.location
}

