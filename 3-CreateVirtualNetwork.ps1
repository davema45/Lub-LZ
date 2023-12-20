#Deploy virtualnetwork via bicep module 
#https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/network/virtual-network

$templateFile = ".\modules\virtual-network\main.bicep"
$templateParameterFile = ".\modules\virtual-network\main.parameters.json"

#Import Tenant settings
$paramTenant = Import-Csv ".\tenantconfig.csv"

#Generate connectivity resource group name
$resourceGroup = $paramTenant.tenantid + "-NET"

#Select Subscription to create resources
Select-AzSubscription -Subscription $paramTenant.subscriptionid

# Parameters necessary for deployment
$inputObject = @{
    DeploymentName        = 'llz-vnet-{0}' -f ( -join (Get-Date -Format 'yyyyMMddTHHMMssffffZ')[0..63])
    ResourceGroupName     = $resourceGroup
    TemplateFile          = $templateFile
    TemplateParameterFile = $templateParameterFile
    location              = $paramTenant.location
  }

  New-AzResourceGroupDeployment @inputObject