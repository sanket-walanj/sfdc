public class CaseTriggerHandler {
  public static void beforeInsertHandler(List<Case> newRecords) {
    for (Case caseRecord : newRecords) {
      if (caseRecord.Origin == 'Phone') {
        caseRecord.Priority = 'High';
      } else {
        caseRecord.Priority = 'Low';
      }
    }
  }
  public static void beforeDeleteHandler(List<Case> oldRecords) {
    Id currentUserProfileId = UserInfo.getProfileId();
    Id sysAdminProfileId = [
      SELECT Id, Name
      FROM Profile
      WHERE Name = 'System Administrator'
      LIMIT 1
    ]
    .Id;
    for (Case caseRecord : oldRecords) {
      if (currentUserProfileId != sysAdminProfileId) {
        caseRecord.addError('You are not allowed to delete the record');
      }
    }
  }
}
