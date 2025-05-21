public class OpportunityTriggerHandler {
    
    public static void afterUpdateHandler(List<Opportunity> newRecords){
        List<Task> taskListToInsert = new List<Task>();
        for(Opportunity opp: newRecords){
            if(opp.StageName == 'Closed Won'){
                Task newTask = new task();
                newTask.Priority = 'High';
                newTask.Subject = 'Split Revenue';
                newTask.WhatId = opp.Id;
                newTask.OwnerId = opp.OwnerId;
                newTask.Description = 'Split Revenue among the members';
                taskListToInsert.add(newTask);
            }
        }
        if(!taskListToInsert.isEmpty()){
            insert taskListToInsert;
        }
    }
    
    public static void beforeUpdateHandler(List<Opportunity> newRecords, Map<Id, Opportunity> oldMap){
        
        for(Opportunity opp: newRecords){
            if(oldMap.get(opp.Id).StageName != opp.StageName){
                opp.Amount = opp.Probability * opp.ExpectedRevenue;
            }
        }
        
    }
}