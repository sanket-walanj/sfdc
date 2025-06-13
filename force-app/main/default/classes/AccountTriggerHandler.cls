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
}
