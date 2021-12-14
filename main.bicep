param location string = resourceGroup().location

@secure()
param ADMIN_NAME string

@secure()
param ADMIN_PASSWORD string

var sqlServerName = 'sqlserverPocLuis'
var minTlsVersion = '1.2'

var databaseName = 'sample-db'
var databaseCollation = 'SQL_Latin1_General_CP1_CI_AS'
var databaseSampleName = 'AdventureWorksLT'
var databaseSkuName = 'Basic'
var databaseSkuTier = 'Basic'

resource sqlServer 'Microsoft.Sql/servers@2019-06-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: ADMIN_NAME
    administratorLoginPassword: ADMIN_PASSWORD
    version: '12.0'
    minimalTlsVersion: minTlsVersion
  }
}

resource db 'Microsoft.Sql/servers/databases@2019-06-01-preview' = {
  name: databaseName
  parent: sqlServer
  location: location
  sku: {
    name: databaseSkuName
    tier: databaseSkuTier
  }
  properties: {
    collation: databaseCollation
    sampleName: databaseSampleName
  }
}
