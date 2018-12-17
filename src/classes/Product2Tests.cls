@isTest (seeAllData=true)
private class Product2Tests {
    
    /**
* @name product2Extension_UnitTest
* @description UnitTest for product2Extension
**/
    @isTest 
    static void Product2Extension_UnitTest(){
    
        Test.startTest();
        PageReference pageRef = Page.Product2New;
        Test.setCurrentPage(pageRef);
        Product2 prod = new Product2(name='Test Prod',isActive=true);        
        ApexPages.StandardController stdcontroller = new ApexPages.StandardController(prod);        
        Product2Extension ext = new Product2Extension(stdcontroller);        
        System.assertEquals(Constants.DEFAULT_ROWS, ext.productsToInsert.size());
        ext.addRows();
        System.assertEquals(Constants.DEFAULT_ROWS, ext.productsToInsert.size());
        for (Integer i = 0; i < 5; i++) {
            Product2Extension.ProductWrapper wrapper = ext.productsToInsert[i];
            Product2 testProd = new Product2();
            testProd.Name = 'Test Product' + i;
            testProd.IsActive = true;
            testProd.Initial_Inventory__c = 20;
            testProd.Family = Constants.PRODUCT_FAMILY[0].getValue();
            wrapper.productRecord = testProd;
            PricebookEntry testEntry = new PricebookEntry();
            testEntry.IsActive = true;
            testEntry.UnitPrice = 10;
            wrapper.pricebookEntryRecord = testEntry;
        }
        ext.save();
        ext.GetFamilyOptions();
        ext.GetInventory();
        Test.stopTest();
        List<Product2> createdProducts = [
            SELECT
            Id
            FROM
            Product2
        ];
        //System.assertEquals(5, createdProducts.size());
    }
    
    @isTest
    static void Product2Trigger_UnitTest(){
        
        Test.startTest();
        //TestDataFactory.InsertTestData(5);
        Product2 p=new Product2();
        p.Name='Test Product';
        p.Family='Side';
        p.IsActive=true;
        p.Quantity_Ordered__c =50;
        p.Initial_Inventory__c =100;
        insert p;
        CollaborationGroup c=new CollaborationGroup();
        c.Name='Test IA';
        c.Description='test method group';
        c.CollaborationType='public';
        insert c;
        p.Quantity_Ordered__c=96;
        update p;
        Test.stopTest();
    }
}