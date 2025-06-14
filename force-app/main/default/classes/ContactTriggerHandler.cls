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

      // for (Contact existingCon : existingContacts) {
      //   if (
      //     con.LastName == existingCon.LastName ||
      //     con.Phone == existingCon.Phone ||
      //     con.Email == existingCon.Email
      //   ) {
      //     con.addError('Duplicate Found');
      //   }
      // }
    }
  }
  public static void afterInsertHandler(List<Contact> newRecords) {
    List<ContactShare> addRecordToList = new List<ContactShare>();
    Id conInnoPublicGroup = [
      SELECT Id, Name
      FROM Group
      WHERE Name = 'Contact Innovators'
      LIMIT 1
    ]
    .Id;
    for (Contact con : newRecords) {
      ContactShare conS = new ContactShare();
      conS.ContactId = con.Id;
      conS.UserOrGroupId = con.OwnerId;
      conS.RowCause = 'Manual';
      conS.ContactAccessLevel = 'Edit';
      addRecordToList.add(conS);
    }
  }
}
