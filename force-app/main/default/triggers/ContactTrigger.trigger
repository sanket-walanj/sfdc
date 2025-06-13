trigger ContactTrigger on Contact(
  before insert,
  after insert,
  after update,
  after delete,
  after undelete
) {
  switch on Trigger.operationType {
    when BEFORE_INSERT {
      ContactTriggerHandler.beforeInsertHandler(Trigger.new);
    }
    when AFTER_INSERT {
      Set<Id> accountIds = new Set<Id>();
      for (Contact con : Trigger.new) {
        if (String.isBlank(con.AccountId)) {
          accountIds.add(con.AccountId);
        }
      }

      List<AggregateResult> results = [
        SELECT AccountId, Count(Id) totalContacts
        FROM Contact
        WHERE Active__c = TRUE AND AccountId IN :accountIds
        GROUP BY AccountId
      ];
      List<Account> accountsToUpdate = new List<Account>();
      for (AggregateResult result : results) {
        String accId = String.valueOf(result.get('AccountId'));
        Integer totalCount = Integer.valueOf(result.get('totalContacts'));

        Account acc = new Account(Id = accId, Active_Contacts__c = totalCount);
        accountsToUpdate.add(acc);
      }
      update accountsToUpdate;
    }
    when AFTER_UPDATE {
      Set<Id> accountIds = new Set<Id>();
      for (Contact con : Trigger.new) {
        if (
          String.isBlank(con.AccountId) &&
          Trigger.oldMap.get(con.Id).Active__c != con.Active__c
        ) {
          accountIds.add(con.AccountId);
        } else if (Trigger.oldMap.get(con.Id).AccountId != con.AccountId) {
          accountIds.add(con.AccountId);
          accountIds.add(Trigger.oldMap.get(con.Id).AccountId);
        }
      }

      List<AggregateResult> results = [
        SELECT AccountId, Count(Id) totalContacts
        FROM Contact
        WHERE Active__c = TRUE AND AccountId IN :accountIds
        GROUP BY AccountId
      ];
      List<Account> accountsToUpdate = new List<Account>();
      for (AggregateResult result : results) {
        String accId = String.valueOf(result.get('AccountId'));
        Integer totalCount = Integer.valueOf(result.get('totalContacts'));

        Account acc = new Account(Id = accId, Active_Contacts__c = totalCount);
        accountsToUpdate.add(acc);
      }
      update accountsToUpdate;
    }
  }
}
