trigger AccountTrigger on Account(before update, after update) {
  switch on Trigger.operationType {
    when BEFORE_UPDATE {
      AccountTriggerHandler.beforeUpdateHandler(Trigger.new, Trigger.oldMap);
    }
    when AFTER_UPDATE {
      AccountTriggerHandler.afterUpdateHandler(Trigger.new, Trigger.oldMap);
    }
  }
}
