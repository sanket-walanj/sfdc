trigger AccountTrigger on Account(before update) {
  switch on Trigger.operationType {
    when BEFORE_UPDATE {
      AccountTriggerHandler.beforeUpdateHandler(Trigger.new, Trigger.oldMap);
    }
  }
}
