public with sharing class getScales {
    
    @AuraEnabled(cacheable=true)
    public static List<Scale__c> getScale(String origin, String destination, Datetime travelDate){

        DateTime myDateTime = DateTime.newInstance(2023, 3, 9, 13, 0, 0);
        
        return [SELECT Id, Origin__c, Destination__c, Arrival_Date__c, Departure_Date__c, Cost__c FROM Scale__c 
        WHERE Origin__c =:origin AND Destination__c =:destination AND Arrival_Date__c =:myDateTime];

    }
}