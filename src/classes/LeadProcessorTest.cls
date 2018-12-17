@isTest
private class LeadProcessorTest{
    @testSetup 
    static void setup() {
        List<Lead> leads = new List<Lead>();
        
        // insert 200 leads
        for (Integer i=0;i<200;i++) {
            leads.add(new lead(firstname='Lead '+i,lastname='Last',Company ='C' ,
                LeadSource='Dreamforce'));
        }
        insert leads;
        
        
    }
    static testmethod void test() {        
        Test.startTest();
        LeadProcessor lca = new LeadProcessor();
        Id batchId = Database.executeBatch(lca);
        Test.stopTest();
       
    }
    
}