public class LeadTriggerHandler {
		
    
    public static void beforeUpdateHandler(List<Lead> newRecords){
        for(Lead leadRecord: newRecords){
            leadRecord.Status = 'Working-Contacted';
            
            if(leadRecord.Industry == 'Healthcare'){
                leadRecord.LeadSource = 'Purchased List';
                leadRecord.SICCode__c = '1100';
                leadRecord.Primary__c = 'Yes';
            }
        }
    }
    public static void afterInsertHandler(List<Lead> newRecords){
        List<Task> taskListToInsert = new List<Task>();
        for(Lead leadRecord : newRecords){
            Task newTask = new task();
            newTask.OwnerId = leadRecord.OwnerId;
            newTask.WhoId = leadRecord.Id;
            newTask.Subject = 'Follow up on Lead Task';
            newTask.Priority = 'High';
            newTask.Status = 'Not Started';
            taskListToInsert.add(newTask);
            
        }
        if(!taskListToInsert.isEmpty()){
            insert taskListToInsert;
        }
    }
}