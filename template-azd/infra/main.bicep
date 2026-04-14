targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the azd environment. Used as a prefix for resource names.')
param environmentName string

@description('Primary location for all resources.')
param location string

// Load abbreviations for consistent resource naming
var abbrs = loadJsonContent('./abbreviations.json')
var resourceSuffix = toLower(uniqueString(subscription().id, environmentName, location))
var tags = {
  'azd-env-name': environmentName
}

// Resource group for all project resources
resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: '${abbrs.resourcesResourceGroups}${environmentName}'
  location: location
  tags: tags
}

// Example module: Storage Account
// Replace or extend with your own modules in infra/modules/.
module storage './modules/storage.bicep' = {
  scope: rg
  params: {
    storageAccountName: '${abbrs.storageAccounts}${resourceSuffix}'
    location: location
    tags: tags
  }
}

// ---------------------------------------------------------------------------
// Outputs
//
// azd captures these as environment variables available to hook scripts
// and in `azd env get-values`.
// ---------------------------------------------------------------------------
output AZURE_RESOURCE_GROUP string = rg.name
output STORAGE_ACCOUNT_NAME string = storage.outputs.storageAccountName
