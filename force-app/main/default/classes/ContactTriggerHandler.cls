public class ContactTriggerHandler {
  public static void beforeInsertHandler(List<Contact> newRecords) {
    for (Contact con : newRecords) {
      if (con.AccountId == null) {
        con.AccountId.addError(
          'Parent Account cannot be null while creating a new contact'
        );
      }
    }
  }
}
