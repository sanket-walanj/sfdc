public class TaskTriggerHandler {
		
    public static void beforeInsertHandler(List<Task> newRecords){
        for(Task taskRecord : newRecords){
			taskRecord.Priority = 'High';            
        }
    }    
}