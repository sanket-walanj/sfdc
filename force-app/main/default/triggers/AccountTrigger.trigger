trigger AccountTrigger on Account (before update, after update, after insert) {
    switch on Trigger.operationType{
        when BEFORE_UPDATE{
            AccountTriggerHandler.beforeUpdateHandler(Trigger.new, Trigger.oldMap);
        }
        when AFTER_UPDATE{
            AccountTriggerHandler.afterUpdateHandler(Trigger.new, Trigger.oldMap);
        }
        when AFTER_INSERT{
            AccountTriggerHandler.afterInsertHandler(Trigger.new);
        }
    }
}