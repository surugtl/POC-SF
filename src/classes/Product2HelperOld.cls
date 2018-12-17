public class Product2HelperOld {

    /**
     * @name COLLABORATION_GROUP
     * @description List of CollaborationGroup used in both business and test logic
    **/
    static List<CollaborationGroup> COLLABORATION_GROUP = [
        SELECT Id
        FROM CollaborationGroup
        WHERE Name =:Constants.INVENTORY_ANNOUNCEMENTS
        OR Name = :('TEST'+Constants.INVENTORY_ANNOUNCEMENTS)
        LIMIT 1
    ];

    /**
     * @name afterUpdate
     * @description called by product2 Trigger on After Update
     * @param List<Product2> newList
     * @param List<Product2> oldList
    **/
    public static void AfterUpdate(List<Product2> newList){
        //ToDo: Declare a List of Product2 records named needsAnnouncement
        List<Product2> needsAnnouncement = new List<Product2>();

        //ToDo: Declare a Map of Strings to Inventory_Setting__mdt records
        Map<String, Inventory_Setting__mdt> INVMap = new Map<String, Inventory_Setting__mdt>();

        //ToDo: Loop through a query of Inventory_Setting__mdt records and populate the Map with Name as the key
        List<Inventory_Setting__mdt> invList = [SELECT Id,DeveloperName, Low_Quantity_Alert__c,Label 
                                                FROM Inventory_Setting__mdt];
            for (Inventory_Setting__mdt is : invList) {
                INVMap.put(is.Label, is);
            }
        //ToDo: Loop through the Products in newList
        // Use the corresponding Inventory Setting record to determine the correct Low Quantity Alert
        // If the Product's Quantity Remaining has been changed to less than the Low Quantity Alert
        //      add it to the needsAnnouncement list
        
        /*for (Product2 pr : newList) {
            if (INVMap.containsKey(pr.Family) && (pr.Quantity_Remaining__c < Integer.valueof(INVMap.get(pr.Family).Low_Quantity_Alert__c))) {
                needsAnnouncement.add(pr);
            }
        }*/
        
        for(Integer i=0;i<newList.size();i++){
        
            Inventory_Setting__mdt inventorySetting = (Inventory_Setting__mdt)INVMap.get(newList[i].Family);
            Integer alertQuantity = (Integer)inventorySetting.Low_Quantity_Alert__c;
            
            if( newList[i].Quantity_Remaining__c <= alertQuantity ){
                   needsAnnouncement.add(newList[i]);
               }
            
            /*(if( newList[i].Quantity_Remaining__c <= alertQuantity && 
               oldList[i].Quantity_Remaining__c > alertQuantity){
                   needsAnnouncement.add(newList[i]);
               }*/
        }
        

        //ToDo: Pass records to the postAlerts method
        //if(needsAnnouncement.size() > 0)
           PostAlerts(needsAnnouncement);
    }

    /**
     * @name postAlerts
     * @description called by product2 Trigger on After Update
     * @param List<Product2> productList
    **/
    public static void PostAlerts(List<Product2> productList){
        List<ConnectApi.AnnouncementInput> toPost = new List<ConnectApi.AnnouncementInput>();
        
        for ( Product2 p : productList ){
            // ToDo: Construct a new AnnouncementInput for the Chatter Group so that it:
            // expires in a day
            // does not notify users via email.
            // and has a text body that includes the name of the product followed by the INVENTORY_LEVEL_LOW constant
            
            ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
            ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();
            ConnectApi.AnnouncementInput announcement = new ConnectApi.AnnouncementInput();
            announcement.parentId = COLLABORATION_GROUP[0].Id;
            announcement.expirationDate = System.today().addDays(1);
            announcement.sendEmails = false;
            
            textSegmentInput.text = p.Name + ' ' + Constants.INVENTORY_LEVEL_LOW;
            messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
            messageBodyInput.messageSegments.add(textSegmentInput);
            announcement.body = messageBodyInput;
            toPost.add(announcement);
        }
        // ToDo: Create and enqueue an instance of the announcementQueuable class with the list of Products
        if(toPost.size() > 0){
            AnnouncementQueueable aq = new AnnouncementQueueable(toPost);
            aq.toPost = toPost;
            System.enqueueJob(aq);
        }
    }
}