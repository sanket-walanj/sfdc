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

  public static void afterDeleteHandler(List<Opportunity> oldRecords) {
    Set<id> accountIds = new Set<id>();
    Map<id, id> oppvsAccountMap = new Map<id, id>();
    Map<id, id> accIdVsOwnerIdMap = new Map<id, id>();

    for (Opportunity opp : oldRecords) {
      accountIds.add(opp.AccountId);
      oppvsAccountMap.put(opp.Id, opp.AccountId);
    }

    for (Account acc : [
      SELECT Id, OwnerId
      FROM Account
      WHERE Id IN :accountIds
    ]) {
      accIdVsOwnerIdMap.put(acc.id, acc.OwnerId);
    }

    List<Task> taskRecordList = new List<Task>();
    for (Opportunity opp : oldRecords) {
      Task taskRecord = new Task();
      taskRecord.Priority = 'High';
      taskRecord.Description = 'Task Created Successfully';
      taskRecord.Subject = 'Follow Up';
      taskRecord.OwnerId = accIdVsOwnerIdMap.get(oppvsAccountMap.get(opp.Id));
      taskRecordList.add(taskRecord);
    }

    if (!taskRecordList.isEmpty()) {
      System.debug('taskRecordList::::' + JSON.serializePretty(taskRecordList));
      insert taskRecordList;
    }
  }
}
