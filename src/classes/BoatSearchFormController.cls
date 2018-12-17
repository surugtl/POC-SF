public class BoatSearchFormController
{
  
    @AuraEnabled
    public static List<BoatType__c> getBoatTypes()
    {
        List<BoatType__c> returnList = new List<BoatType__c>();
        returnList = [SELECT Id, Name from BoatType__c ORDER BY Name];
        
        return returnList;
    }
}