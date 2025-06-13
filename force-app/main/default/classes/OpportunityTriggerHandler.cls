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
}
