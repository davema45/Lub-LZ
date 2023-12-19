#Deploy Policies on Management Group level Prod

$templateFile = ".\modules\policy-assignments\main.bicep"

#Import Tenant settings
$paramTenant = Import-Csv ".\tenantconfig.csv"

$managementGroupId = "Prod"

# Parameters necessary for deployment
$inputObject = @{
    DeploymentName        = 'llz-policies-{0}' -f ( -join (Get-Date -Format 'yyyyMMddTHHMMssffffZ')[0..63])
    ManagementGroupId     = $managementGroupId
    TemplateFile          = $templateFile
    location              = $paramTenant.location
  }

  New-AzManagementGroupDeployment @inputObject