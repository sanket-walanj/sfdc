trigger OpportunityTrigger on Opportunity(
  after update,
  before update,
  after delete
) {
  switch on Trigger.operationType {
    when AFTER_UPDATE {
      OpportunityTriggerHandler.afterUpdateHandler(Trigger.new);
      OpportunityTriggerHandler.addTeamMembers(Trigger.new, Trigger.oldmap);
    }
    when BEFORE_UPDATE {
      OpportunityTriggerHandler.beforeUpdateHandler(
        Trigger.new,
        Trigger.oldMap
      );
    }
    when AFTER_DELETE {
      OpportunityTriggerHandler.afterDeleteHandler(Trigger.old);
    }
  }
}
