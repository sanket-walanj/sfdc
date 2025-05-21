public class AccountTriggerHandler {

    public static void beforeUpdateHandler(List<Account> newRecords, Map<Id, Account> oldMap){
        for(Account accRecord: newRecords){
            if(accRecord.Industry == 'Agriculture' && accRecord.Type == 'Prospect'){
                if(oldMap.get(accRecord.Id).Ownership != accRecord.Ownership && accRecord.Ownership == 'Private'){
                    accRecord.addError('You cannot change the ownership to Private');
                }
            }
        }
    }
    public static void afterUpdateHandler(List<Account> newRecords, Map<Id, Account> oldMap){
        Map<Id, String>accToWebsiteMap =new Map<Id, String>();
        for(Account accRecord: newRecords){
            if(accRecord.Website != oldMap.get(accRecord.Id).website){
                accToWebsiteMap.put(accRecord.Id, accRecord.Website);
            }
        }
        
        if(!accToWebsiteMap.isEmpty()){
            List<Contact> contactToUpdate = new List<Contact>();
            List<Contact> contactRecords = [SELECT Id, Website__c, AccountId, FirstName FROM CONTACT WHERE AccountId IN: accToWebsiteMap.keySet()];
            for(Contact conn: contactRecords){
                conn.Website__c = accToWebsiteMap.get(conn.AccountId);
                contactToUpdate.add(conn);
            }
            
            if(!contactToUpdate.isEmpty()){
                update contactToUpdate;
            }
        }
    }
    public static void afterInsertHandler(List<Account> newRecords){
        List<Contact> conList = new List<Contact>();
        for(Account acc: newRecords){
            if(acc.Create_n_contacts__c != null){
                for(Integer i = 0; i < acc.Create_n_contacts__c; i++){
                    Contact con = new Contact();
                    con.LastName = acc.Name + i;
                    con.AccountId = acc.Id;
                    conList.add(con);
                }
            }
        }
        if(!conList.isEmpty()){
            insert conList;
        }
    }
}