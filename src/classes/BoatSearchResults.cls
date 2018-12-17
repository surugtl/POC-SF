public class BoatSearchResults
{
  
    @AuraEnabled
    public static Boat__c[]  getBoats(String boatTypeId)
    {
        if(boatTypeId !='foo') {
        
            Boat__c[] boatList = new Boat__c[]{};
            
            boatList = [SELECT id, BoatType__c, picture__c, name,contact__r.Name
                    FROM Boat__c
                    WHERE BoatType__c =:boatTypeId LIMIT 10];
            
            //return boats
            return boatList;        
        }else {
          
            Boat__c[] allboatList = new Boat__c[]{};
            //return a list of all boats
            allboatList = [SELECT id, BoatType__c, picture__c, name,contact__r.Name
                    FROM Boat__c LIMIT 10];
                    
            return allboatList;        
        }
    }
}