public with sharing class CTPeopleTracingController {
    
    public static List<People_Tracing__c> getTraces(String personId){
        return [SELECT Id, Contact_Date__c, Person_1__c, Person_1__r.Health_Status__c, Person_1__r.Token__c, Person_2__c, Person_2__r.Health_Status__c,  Person_2__r.Token__c 
        FROM People_Tracing__c 
        WHERE Person_1__c = :personId 
            OR Person_2__c = :personId 
        ORDER BY Contact_Date__c DESC];
    }

    public static List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> newPeopleTraces){

        Set<Id> personaIds = new Set<Id>();
        for(People_Tracing__c trace: newPeopleTraces){
            personaIds.add(trace.Person_1__c);
            personaIds.add(trace.Person_2__c);
        }

        List<People_Tracing__c> duplicates = new List<People_Tracing__c>();

        Map<Id,Set<Id>> mapOfExistingRecords = new Map<Id,Set<Id>>();

        List<People_Tracing__c> existingRecords = [SELECT Id, Person_1__c,Person_2__c 
                                                        FROM People_Tracing__c 
                                                        WHERE Person_1__c IN :personaIds 
                                                            OR Person_2__c IN :personaIds];

        if(existingRecords != null && existingRecords.size() >0){
            for(People_Tracing__c trace: existingRecords){
                if(!mapOfExistingRecords.containsKey(trace.Person_1__c)){
                    mapOfExistingRecords.put(trace.Person_1__c, new Set<Id>());
                }
                mapOfExistingRecords.get(trace.Person_1__c).add(trace.Person_2__c);


                if(!mapOfExistingRecords.containsKey(trace.Person_2__c)){
                    mapOfExistingRecords.put(trace.Person_2__c, new Set<Id>());
                }
                mapOfExistingRecords.get(trace.Person_2__c).add(trace.Person_1__c);
            }


            for(People_Tracing__c trace:newPeopleTraces){
                if((mapOfExistingRecords.containsKey(trace.Person_1__c) && mapOfExistingRecords.get(trace.Person_1__c).contains(trace.Person_2__c)) ||
                (mapOfExistingRecords.containsKey(trace.Person_2__c) && mapOfExistingRecords.get(trace.Person_2__c).contains(trace.Person_1__c))
                ){
                    duplicates.add(trace);
                }
            }
        }
        return duplicates;
    }
}