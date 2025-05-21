trigger OpportunityTrigger on Opportunity(after update, before update){
    
    switch on Trigger.operationType{
        when AFTER_UPDATE{
            OpportunityTriggerHandler.afterUpdateHandler(Trigger.new);
        }
        
        when BEFORE_UPDATE{
            OpportunityTriggerHandler.beforeUpdateHandler(Trigger.new, Trigger.oldMap);
        }
    }
}