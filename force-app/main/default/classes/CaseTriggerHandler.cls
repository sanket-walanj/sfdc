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
}
