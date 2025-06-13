trigger OpportunityTrigger on Opportunity(after update) {
  switch on Trigger.operationType {
    when AFTER_UPDATE {
      OpportunityTriggerHandler.afterUpdateHandler(Trigger.new);
    }
  }
}
