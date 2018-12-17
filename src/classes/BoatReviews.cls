public class BoatReviews
{
    @AuraEnabled
    public static List<BoatReview__c>  getAll(String boatTypeId)
    {
        List<BoatReview__c> BRList = new List<BoatReview__c>();
        BRList = [SELECT Id, Comment__c,Rating__c,CreatedBy.Id,
                  CreatedBy.Name,CreatedBy.SmallPhotoUrl,CreatedBy.CompanyName,
                  LastModifiedDate,CreatedDate 
                  FROM BoatReview__c 
                  WHERE Boat__c =:boatTypeId];
                  
        return BRList;          
    }
}