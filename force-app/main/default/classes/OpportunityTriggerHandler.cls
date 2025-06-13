public class OpportunityTriggerHandler {
  public static void afterUpdateHandler(List<Opportunity> newRecords) {
    List<Task> taskListToInsert = new List<Task>();
    for (Opportunity opp : newRecords) {
      if (opp.StageName == 'Closed Won') {
        Task taskRecord = new Task();
        taskRecord.Priority = 'High';
        taskRecord.OwnerId = opp.OwnerId;
        taskRecord.Description = 'Split Revenue';
        taskRecord.Subject = 'Split Revenue';
        taskRecord.Status = 'Not Started';
        taskRecord.WhatId = opp.Id;
        taskListToInsert.add(taskRecord);
      }
    }
    if (!taskListToInsert.isEmpty()) {
      insert taskListToInsert;
    }
  }

  public static void beforeUpdateHandler(
    List<Opportunity> newRecords,
    Map<Id, Opportunity> oldRecords
  ) {
    for (Opportunity opp : newRecords) {
      if (
        opp.StageName != oldRecords.get(opp.Id).StageName &&
        opp.StageName == 'Closed Won'
      ) {
        opp.Amount = opp.ExpectedRevenue * opp.Probability;
      }
    }
  }

  public static void afterDeleteHandler(List<Opportunity> oppRecords) {
    List<Task> taskRecordList = new List<Task>();
    Set<Id> accountIds = new Set<Id>();
    Map<Id, Id> oppToAccMap = new Map<Id, Id>();
    Map<Id, Id> oppIdToOwnerIdMap = new Map<Id, Id>();
    for (Opportunity opp : oppRecords) {
      accountIds.add(opp.AccountId);
      oppToAccMap.put(opp.Id, opp.AccountId);
    }
    List<Account> accounts = [
      SELECT OwnerId
      FROM Account
      WHERE Id IN :accountIds
    ];
    for (Account acc : accounts) {
      oppIdToOwnerIdMap.put(acc.Id, acc.OwnerId);
    }
    for (Opportunity opp : oppRecords) {
      Task taskRecord = new Task();
      taskRecord.Description = 'Investigate why opportunity was deleted';
      taskRecord.Priority = 'High';
      taskRecord.Subject = 'Follow up';
      taskRecord.WhatId = opp.Id;
      taskRecord.OwnerId = oppIdToOwnerIdMap.get(oppToAccMap.get(opp.Id));
      taskRecord.Status = 'Not Started';
      taskRecordList.add(taskRecord);
    }
    if (!taskRecordList.isEmpty()) {
      insert taskRecordList;
    }
  }
}
