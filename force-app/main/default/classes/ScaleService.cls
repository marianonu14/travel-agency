@RestResource(urlMapping='/Scale/*')
global with sharing class ScaleService {
    
    @HttpGet
    global static List<Scale__c> getScaleById() {
        RestRequest request = RestContext.request;

        String scaleId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);

        if(scaleId != ''){
            List<Scale__c> result = ([SELECT Origin__c, Destination__c, Cost__c, Available_Seats__c
            FROM Scale__c
            WHERE Id = :scaleId]);

            return result;
        }

        List<Scale__c> result = ([SELECT Origin__c, Destination__c, Cost__c, Available_Seats__c FROM Scale__c]);
        
        return result;
    }

    @HttpPost
    global static List<Scale__c> createScale(List<Scale__c> listOfScales) {

        List<Scale__c> newList = new List<Scale__c>();

        for (Scale__c scale : listOfScales) {

            Scale__c newScale = new Scale__c();

            newScale.Departure_Date__c = scale.Departure_Date__c;
            newScale.Arrival_Date__c = scale.Arrival_Date__c;
            newScale.Origin__c = scale.Origin__c;
            newScale.Destination__c = scale.Destination__c;
            newScale.Cost__c = scale.Cost__c;
            
            newList.add(newScale);
        }

        insert newList;
        
        return newList;
    } 
     

    @HttpDelete
    global static void deleteScale() {
        RestRequest request = RestContext.request;
        
        String scaleId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        
        Scale__c thisScale = [SELECT Id FROM Scale__c WHERE Id = :scaleId];
        
        delete thisScale;
    }    
     
    @HttpPut
    global static List<Scale__c> upsertScale(List<Scale__c> listOfScales) {
        List<Scale__c> newList = new List<Scale__c>();

        for (Scale__c scale : listOfScales) {

            Scale__c newScale = new Scale__c();

            newScale.Id = scale.Id;
            newScale.Departure_Date__c = scale.Departure_Date__c;
            newScale.Arrival_Date__c = scale.Arrival_Date__c;
            newScale.Origin__c = scale.Origin__c;
            newScale.Destination__c = scale.Destination__c;
            newScale.Cost__c = scale.Cost__c;
            
            newList.add(newScale);
        }

        upsert newList;
        
        return newList;
    }    

    @HttpPatch
    global static Scale__c updateScale() {
        RestRequest request = RestContext.request;

        String scaleId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);

        Scale__c thisScale = [SELECT Origin__c, Destination__c, Cost__c, Available_Seats__c FROM Scale__c WHERE Id = :scaleId];

        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        
        for(String fieldName : params.keySet()) {
            thisScale.put(fieldName, params.get(fieldName));
        }

        update thisScale;
        
        return thisScale;
    } 
}