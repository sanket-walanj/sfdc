trigger LeadTrigger on Lead(before update, after insert) {
  switch on Trigger.operationType {
    when BEFORE_UPDATE {
      LeadTriggerHandler.beforeUpdateHandler(Trigger.new);
    }
    when AFTER_INSERT {
      LeadTriggerHandler.afterInsertHandler(Trigger.new);
    }
  }
}
