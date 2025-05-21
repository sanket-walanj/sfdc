trigger TaskTrigger on Task (before insert){
    
    switch on Trigger.operationType{   
        when BEFORE_INSERT{
            TaskTriggerHandler.beforeInsertHandler(Trigger.new);
        }   
    }
}