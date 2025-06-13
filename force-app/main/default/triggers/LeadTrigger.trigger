trigger LeadTrigger on Lead(before update) {
  switch on Trigger.operationType {
    when BEFORE_UPDATE {
      LeadTriggerHandler.beforeUpdateHandler(Trigger.new);
    }
  }
}
