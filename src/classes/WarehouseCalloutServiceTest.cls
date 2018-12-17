@isTest
private class WarehouseCalloutServiceTest {
  // implement your mock callout test here
    @isTest
    static void WarehouseEquipmentSync(){
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock()); 
        
        WarehouseCalloutService.runWarehouseEquipmentSync();
        
        Test.stopTest(); 
        
        Integer equipmentCount = [SELECT count() FROM Product2 Where Warehouse_SKU__c ='4435678'];       
        System.assertEquals(1, equipmentCount);        
        
    }
    
}