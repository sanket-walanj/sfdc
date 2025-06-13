public class ContactTriggerHandler {
  public static void beforeInsertHandler(List<Contact> newRecords) {
    List<Contact> existingContacts = [
      SELECT Id, LastName, Phone, Email
      FROM Contact
      LIMIT 50000
    ];

    for (Contact con : newRecords) {
      if (con.AccountId == null) {
        con.AccountId.addError(
          'Parent Account cannot be null while creating a new contact'
        );
      }

      for (Contact existingCon : existingContacts) {
        if (
          con.LastName == existingCon.LastName ||
          con.Phone == existingCon.Phone ||
          con.Email == existingCon.Email
        ) {
          con.addError('Duplicate Found');
        }
      }
    }
  }
}
