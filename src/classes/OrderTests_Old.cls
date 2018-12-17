@isTest 
private class OrderTests_Old {

    @isTest (seealldata = true)
     static void testOrderTrigger(){
    
        Account a = new Account();
        a.name = 'test test';
        insert a;
        Order o = new Order();
        o.name = 'test';
        o.accountid = a.id;
        o.EffectiveDate = System.today();
        o.status = 'Draft';
        o.Pricebook2Id = [SELECT Id FROM Pricebook2 WHERE IsStandard = true].Id;
        insert o;
        Product2 p = new Product2();
        
        p.Name = 'Test Product';
        insert p;
        
        PricebookEntry pbe = new PricebookEntry();
            pbe.Product2Id = p.id;
            pbe.IsActive = true;
            pbe.UnitPrice = 10;
            pbe.Pricebook2Id = [SELECT Id FROM Pricebook2 WHERE IsStandard = true].Id;
            insert pbe;
    
        OrderItem oi = new OrderItem ();
            
            oi.OrderId=o.id;
           
            oi.PricebookEntryId=pbe.id;
            oi.Unitprice = pbe.unitprice;
            oi.Quantity=10;
            insert oi;
        
        Order o1 = new Order(Id=o.id);
        o1.Status = 'Activated';
        update o1;
        
            
    }
    
   static void SetupTestData() {
        TestDataFactory.InsertTestData(5);
    } 
   

    
    static testmethod void OrderUpdate_UnitTest (){
        Test.startTest();
        Order rec = [select id, Status from Order limit 1];
        Product2 prod = [SELECT Family,Id,Name,Quantity_Ordered__c,Quantity_Remaining__c FROM Product2 limit 1];
        system.debug('kkk '+prod.Quantity_Ordered__c);
        rec.status = constants.ACTIVATED_ORDER_STATUS;
        Update rec;
        Product2 updatedprod = [SELECT Family,Id,Name,Quantity_Ordered__c,Quantity_Remaining__c FROM Product2 limit 1];
        
        system.debug('kkk '+updatedprod.Quantity_Ordered__c);
        TestDataFactory.VerifyQuantityOrdered(prod,updatedprod,constants.DEFAULT_ROWS);
         Test.stopTest();
    }
    

    
      
}