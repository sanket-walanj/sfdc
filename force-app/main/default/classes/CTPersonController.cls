public with sharing class CTPersonController {


    public static String getToken(String mobileNO){
        Blob value = Blob.valueOf(mobileNO);
        Blob hash = Crypto.generateDigest('MD5', value);

        // get the string value of Hash Blob
        return EncodingUtil.base64Encode(hash);
    }

    public static List<Person__c> getRecentHealthChanges(){
        return [SELECT Id, Name, Health_Status__c, Token__c, Mobile__c, Status_Update_Date__c FROM Person__c ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100];
    }

    public static List<Person__c> searchPeople(String searchTerm){
        searchTerm = searchTerm + '%';
        return [SELECT Id, Name, Health_Status__c, Token__c, Mobile__c, Status_Update_Date__c 
        FROM Person__c 
        WHERE Name LIKE :searchTerm 
            OR  Mobile__c LIKE :searchTerm 
            OR  Token__c LIKE :searchTerm 
        ORDER BY Status_Update_Date__c DESC NULLS LAST];
    }

    public static Person__c getPersonById(String personId){
        List<Person__c> people = [SELECT Id, Name, Health_Status__c, Token__c, Mobile__c, Status_Update_Date__c 
        FROM Person__c 
        WHERE Id=:personId];

        if(people != null && people.size() > 0){
            return people[0];
        }
        return null;
    }


    public static Map<String,Integer> getHealthStatusCount(){
        Map<String,Integer> healthCountMap = new Map<String,Integer>();
        for(AggregateResult arr:[SELECT Health_Status__c, count(Id)total FROM Person__c GROUP BY Health_Status__c]){
            String healthStatus = String.valueOf(arr.get('Health_Status__c'));
            Integer count = Integer.valueOf(arr.get('total'));
            healthCountMap.put(healthStatus, count);
        }
        return healthCountMap;
    }

}