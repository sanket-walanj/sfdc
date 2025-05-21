public class OpportunitiesController {
  @AuraEnabled(cacheable=true)
  public static List<OpportunitiesController.OppWrapper> getAllOpportunities() {
    list<Opportunity> oppList = [SELECT Account.name,Name,Description,CloseDate,StageName, AccountId FROM Opportunity];
    map<Id, contact> accountId_contactMap = new Map<Id, contact>();
    list<OppWrapper> oppWrapperList = new List<OppWrapper>();
    for (Opportunity opp : opplist) {
      accountId_contactMap.put(opp.AccountId, new contact());
    }
    for (Account acc : [
      SELECT Id, (SELECT Id, name, email, Phone FROM contacts ORDER BY CreatedDate DESC LIMIT 1)
      FROM account
      WHERE id IN :accountId_contactMap.keyset()
    ]) {
      if (acc.contacts.size() != 0) {
        accountId_contactMap.put(acc.id, acc.contacts[0]);
      }
    }
    for (Opportunity opp : oppList) {
      OppWrapper oppwr = new OppWrapper();
      oppwr.opp = opp;
      oppwr.con = accountId_contactMap.get(opp.AccountId);
      //opp.contactName
      oppWrapperList.add(oppwr);
    }
    System.debug(Json.serialize(oppWrapperList));
    return oppWrapperList;
  }
  public class OppWrapper {
  @AuraEnabled
    public Opportunity opp { get; set; }
    @AuraEnabled
    public Contact con { get; set; }
  }
}