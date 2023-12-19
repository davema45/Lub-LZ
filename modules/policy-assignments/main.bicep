var resourceTypes = [
  'Microsoft.Compute/virtualMachines'
  'Microsoft.Storage/storageAccounts'
  'Microsoft.Network/virtualNetworks'
]

targetScope = 'managementGroup'

resource resPolicyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny Deletion'
  properties: {
    displayName: 'Deny Resource Deletion'
    description: 'Denies the deletion of resources created by Lub-LZ'
    metadata: {
      category: 'Virtual Machines'
    }
    policyRule: {
      if: {
        anyof: [
          for resourceType in resourceTypes: {
            field: 'type'
            equals: resourceType
          }
        ]  
      }
      then: {
        effect: 'DenyAction'
        details: {
          actionNames: ['Delete']
        }
      }
    }
  }
}

resource ResPolicyAssignment 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Deny Resource Deletion'
  scope: managementGroup()
  properties: {
    displayName: 'Deny Resource Deletion'
    description: 'Denies the deletion of resources'
    policyDefinitionId: resPolicyDefinition.id
  }
}
