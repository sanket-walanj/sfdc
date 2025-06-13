public class AccountTriggerHandler {
  public static void beforeUpdateHandler(
    List<Account> newRecords,
    Map<Id, Account> oldMap
  ) {
    for (Account acc : newRecords) {
      if (acc.Industry == 'Agriculture' && acc.Type == 'Apparel') {
        if (
          acc.Ownership != oldMap.get(acc.Id).Ownership &&
          acc.Ownership == 'Private'
        ) {
          acc.addError('Ownership cannot be set to Private');
        }
      }
    }
  }

  public static void afterUpdateHandler(
    List<Account> newRecords,
    Map<Id, Account> oldMap
  ) {
    Map<Id, String> accountsMap = new Map<Id, String>();
    for (Account acc : newRecords) {
      if (
        acc.Website != oldMap.get(acc.Id).Website &&
        String.isNotBlank(acc.Website)
      ) {
        accountsMap.put(acc.Id, acc.Website);
      }
    }

    if (accountsMap.keySet().size() > 0) {
      List<Contact> contactsToUpdate = new List<Contact>();
      for (Contact con : [
        SELECT Id, LastName, Email, Website__c, AccountId
        FROM Contact
        WHERE AccountId IN :accountsMap.keySet()
      ]) {
        con.Website__c = accountsMap.get(con.AccountId);
        contactsToUpdate.add(con);
      }

      if (!contactsToUpdate.isEmpty()) {
        update contactsToUpdate;
      }
    }
  }

  public static void afterInsertHandler(List<Account> newRecords) {
    List<Contact> listOfContact = new List<Contact>();
    for (Account acc : newRecords) {
      if (acc.Create_n_contacts__c != null) {
        for (Integer i = 0; i < acc.Create_n_contacts__c; i++) {
          Contact con = new Contact();
          con.LastName = acc.Name + i;
          con.AccountId = acc.Id;
          listOfContact.add(con);
        }
      }
    }
    if (!listOfContact.isEmpty()) {
      insert listOfContact;
    }
  }
}
