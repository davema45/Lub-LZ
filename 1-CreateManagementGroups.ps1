#Import Tenant settings
$paramTenant = Import-Csv ".\tenantconfig.csv"
$subGroups = "Prod","Test"

#Create tenant group
$parentGroup = New-AzManagementGroup -GroupName $paramTenant.tenantid

#Create sub groups
foreach($group in $subGroups) {
    New-AzManagementGroup -GroupName $group -ParentId $parentGroup.Id
}