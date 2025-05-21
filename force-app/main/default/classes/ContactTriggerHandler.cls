public class ContactTriggerHandler {
		
    public static void beforeInsertHandler(List<Contact> newRecords){
        for(Contact conn: newRecords){
            if(conn.AccountId == null){
                conn.addError('Parent Account Information is Mandatory');
            }
        }
    }
}