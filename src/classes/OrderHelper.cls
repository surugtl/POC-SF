public class OrderHelper {

    /**
     * @name AfterUpdate
     * @description 
     * @param List<Order> newList
     * @param List<Order> oldList
     * @return void
    **/
    public static void AfterUpdate(List<Order> newList, List<Order> oldList){
        
        Set<Id> orderIds = new Set<Id>();
        
        for(integer i=0;i<newList.size();i++){
        
            if(newList[i].Status == Constants.ACTIVATED_ORDER_STATUS &&
               oldList[i].Status == Constants.DRAFT_ORDER_STATUS){
               
               orderIds.add(newList[i].id);
            }
        }
        
        //call Rollup method
        if(orderIds.size() > 0)
          RollUpOrderItems(orderIds);
    }

    /**
     * @name RollUpOrderItems
     * @description Given a set of Activated Order ids, query the child Order Items and related Products to calculate Inventory levels
     * @param Set<Id> activatedOrderIds
     * @return void
    **/
    public static void RollUpOrderItems(Set<Id> activatedOrderIds){
        //ToDo: Declare a Map named "productMap" of Ids to Product2 records
        Map<Id,Product2> productMap = new Map<Id,Product2>();
        Set<Id> prodIdSet = new Set<Id>();

        //ToDo: Loop through a query of OrderItems related to the activatedOrderIds
           for(OrderItem oi : [SELECT Id,Product2Id,Quantity
                               FROM OrderItem 
                               WHERE OrderId IN:activatedOrderIds]){
                prodIdSet.add(oi.Product2Id);           
           }
            //ToDo: Populate the map with the Id of the related Product2 as the key and Product2 record as the value
       if(prodIdSet.size() > 0){
            
               for(Product2 pr : [SELECT Id,Name,Quantity_Ordered__c
                                  FROM Product2
                                  WHERE Id IN:prodIdSet]){
                   productMap.put(pr.id,pr);               
               }                   
            

            //ToDo: Loop through a query that aggregates the OrderItems related to the Products in the ProductMap keyset
            for(AggregateResult prodAR : [SELECT Product2Id,SUM(Quantity) totalCount
                                          FROM OrderItem
                                          WHERE Product2Id IN:productMap.keySet()
                                          GROUP BY Product2Id]){
                                          
                 productMap.get((String) prodAR.get('Product2Id')).Quantity_Ordered__c = Integer.ValueOf(prodAR.get('totalCount'));                         
            }
    
            //ToDo: Perform an update on the records in the productMap
               update productMap.values();
       }     
    }

}