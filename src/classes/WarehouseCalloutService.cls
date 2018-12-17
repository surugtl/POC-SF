public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    // complete this method to make the callout (using @future) to the
    // REST endpoint and update equipment on hand.
    @future(callout=true)
    public static void runWarehouseEquipmentSync(){
    
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
          
            List<Object> warehouseequipments = (List<Object>) JSON.deserializeUntyped(response.getBody());
            List<Product2> equipments = new List<Product2>();
            for(Object WE :  warehouseequipments){
                Map<String, Object> equipmentMap = (Map<String, Object>)WE;
                
                Product2 equipment = new Product2();
                equipment.Name = (String)equipmentMap.get('name');
                equipment.Cost__c = (Integer)equipmentMap.get('cost');
                equipment.Current_Inventory__c = (Integer)equipmentMap.get('quantity');
                equipment.Maintenance_Cycle__c = (Integer)equipmentMap.get('maintenanceperiod');
                equipment.Replacement_Part__c = (Boolean)equipmentMap.get('replacement');
                equipment.Lifespan_Months__c = (Integer)equipmentMap.get('lifespan');
                equipment.Warehouse_SKU__c = (String)equipmentMap.get('sku');
                equipment.ProductCode = (String)equipmentMap.get('_id');
                equipments.add(equipment);
            }
            if(equipments.size() > 0){
                System.debug('EQUIPMENTS::::'+equipments);
                upsert equipments;
            }
        }
    }

}