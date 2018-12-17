/**
 * @name product2Trigger
 * @description Trigger to notify staff of low levels of inventory
**/
trigger product2Trigger on Product2 (after update) {
    
        //Product2Helper.AfterUpdate(trigger.new);
        Product2Helper.AfterUpdate((List<Product2>)trigger.new,(List<Product2>)trigger.old);
        
    
}