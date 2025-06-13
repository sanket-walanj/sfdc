public class LeadTriggerHandler {
  public static void beforeUpdateHandler(List<Lead> newRecords) {
    for (Lead leadRecord : newRecords) {
      leadRecord.Status = 'Working-Contacted';

      if (leadRecord.Industry == 'Healthcare') {
        leadRecord.LeadSource = 'Purchased List';
        leadRecord.SICCode__c = '1100';
        leadRecord.Primary__c = 'Yes';
      }
    }
  }
}
