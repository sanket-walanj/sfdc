trigger ContactTrigger on Contact(before insert, after insert) {
  switch on Trigger.operationType {
    when BEFORE_INSERT {
      ContactTriggerHandler.beforeInsertHandler(Trigger.new);
    }
    when AFTER_INSERT {
      ContactTriggerHandler.afterInsertHandler(Trigger.new);
    }
  }
}
