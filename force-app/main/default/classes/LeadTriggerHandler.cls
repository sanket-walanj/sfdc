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

  public static void afterInsertHandler(List<Lead> newRecords) {
    List<Task> taskListToInsert = new List<Task>();
    for (Lead leadRecord : newRecords) {
      Task taskRecord = new Task();
      taskRecord.OwnerId = leadRecord.OwnerId;
      taskRecord.Subject = 'Follow Up';
      taskRecord.Description = 'Follow up with the customer';
      taskRecord.WhoId = leadRecord.Id;
      taskRecord.Status = 'Not Started';
      taskListToInsert.add(taskRecord);
    }
    if (!taskListToInsert.isEmpty()) {
      insert taskListToInsert;
    }
  }

  public static void beforeDeleteHandler(List<Lead> newRecords) {
    for (Lead leadRecord : newRecords) {
      if (leadRecord.Status == 'Working-Contacted') {
        leadRecord.addError('You cannot delete a Working-Contacted Lead');
      }
    }
  }
}
