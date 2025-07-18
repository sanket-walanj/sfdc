public class OpportunityTriggerHandler {
  public static void afterUpdateHandler(List<Opportunity> newRecords) {
    List<Task> taskListToInsert = new List<Task>();
    List<Id> listOfoppIds = new List<Id>();
    List<OpportunityTeamMember> deleteMemberList = new List<OpportunityTeamMember>();

    for (Opportunity opp : newRecords) {
      listOfoppIds.add(opp.Id);
    }
    List<OpportunityTeamMember> oppTeamMembers = [
      SELECT Id, OpportunityId
      FROM OpportunityTeamMember
      WHERE OpportunityId IN :listOfoppIds
    ];
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
      } else if (opp.StageName == 'Closed Lost') {
        for (OpportunityTeamMember teamMember : oppTeamMembers) {
          if (teamMember.OpportunityId == opp.Id) {
            deleteMemberList.add(teamMember);
          }
        }
      }
    }
    if (!taskListToInsert.isEmpty()) {
      insert taskListToInsert;
    }
    if (!deleteMemberList.isEmpty()) {
      delete deleteMemberList;
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

  public static void addTeamMembers(
    List<Opportunity> newRecords,
    Map<Id, Opportunity> oldMapRecords
  ) {
    List<User> opportunists = [
      SELECT Id, UserRole.Name
      FROM User
      WHERE isActive = TRUE AND UserRole.Name = 'Opportunists'
    ];
    List<OpportunityTeamMember> oppMemberList = new List<OpportunityTeamMember>();
    for (Opportunity opp : newRecords) {
      if (
        opp.StageName == 'Needs Analysis' &&
        opp.StageName != oldMapRecords.get(opp.Id).StageName
      ) {
        for (User userRec : opportunists) {
          OpportunityTeamMember oppMember = new OpportunityTeamMember();
          oppMember.OpportunityId = opp.Id;
          oppMember.OpportunityAccessLevel = 'Edit';
          oppMember.UserId = userRec.Id;
          oppMemberList.add(oppMember);
        }
      }
    }
    if (!oppMemberList.isEmpty()) {
      insert oppMemberList;
    }
  }
}
