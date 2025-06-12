public with sharing class IntegrationHome {
  @AuraEnabled(cacheable=true)
  public static List<Account> getAllAccounts() {
    return [SELECT Id, Name, Phone, Industry, Rating FROM Account LIMIT 100];
  }
}