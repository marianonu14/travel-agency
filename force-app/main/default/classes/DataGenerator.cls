public with sharing class DataGenerator {
    public static void createScaleBulk(Integer flightCost){

        List<Scale__c> listOfScales = new List<Scale__c>();
        
        Integer year = Datetime.now().year();
        List<String> location = new List<String>{'MVD', 'PTY', 'JFK', 'GRU', 'AEP'};

        for(String origin : location){
            for(Integer j = 0; j < location.size(); j++){
                if(origin != location[j]) {
                    for(Integer i = 1; i <= 3; i++){
                        for(Integer k = 1; k <= 29; k++){
                            Scale__c newScale = new Scale__c();
                            
                            Datetime departure = DateTime.newInstance(year, i, k, 12, 0, 0);
                            Datetime arrival = DateTime.newInstance(year, i, k, 13, 0, 0);
                
                            newScale.Departure_Date__c = departure;
                            newScale.Arrival_Date__c = arrival;
                
                            newScale.Origin__c = origin;
                            newScale.Destination__c = location[j];
                            newScale.Cost__c = flightCost;
            
                            listOfScales.add(newScale);
                        }
                    }
                }
            }
        }

        insert listOfScales;
    }

    @AuraEnabled(cacheable=true) 
    public static void createTravel(String name, String Id, Double finalPrice, String baggage, String classFlight){
        Travel__c newTravel = new Travel__c();

        newTravel.Name = name;
        newTravel.Scale__c = Id;
        newTravel.Final_Price__c = finalPrice;
        newTravel.Baggage__c = baggage;
        newTravel.Class__c = classFlight;

        insert newTravel;
    }

    public static void deleteAllScale(){
        List<Scale__c> listOfScales = [SELECT Id FROM Scale__c];

        delete listOfScales;
    }
}