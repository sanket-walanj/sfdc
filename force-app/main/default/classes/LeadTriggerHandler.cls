public class LeadTriggerHandler {
  public static void beforeUpdateHandler(List<Lead> newRecords) {
    for (Lead leadRecord : newRecords) {
      leadRecord.Status = 'Working-Contacted';
    }
  }
}
