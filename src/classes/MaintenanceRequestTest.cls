@IsTest
public class MaintenanceRequestTest {
    
    @IsTest
    static void test1() {
        //Repair request
        testMaintenanceRequest('Repair', 1, 'Closed');
        
        //Routin Maintenance request
        testMaintenanceRequest('Routine Maintenance', 1, 'Closed');
    }
    
    @IsTest
    static void test2() {
        
        //Different type
        testMaintenanceRequest('Other', 1, 'Closed');
        
        //Different status
        testMaintenanceRequest('Repair', 1, 'Working');
        
        //Different status
        testMaintenanceRequest('Routine Maintenance', 1, 'Escalated');
    }
    
    @IsTest
    static void test3() {
        //Test Routine maintance bulk
        testMaintenanceRequest('Routine Maintenance', 300, 'Closed');
        
        //Test Repair maintance bulk
        testMaintenanceRequest('Repair', 300, 'Closed');
    }
    
    @IsTest
    static void test4() {
        
        //different type bulk
        testMaintenanceRequest('Other', 300, 'Closed');
        
        //different status bulk
        testMaintenanceRequest('Repair', 300, 'Working');
        
        //different status bulk
        testMaintenanceRequest('Routine Maintenance', 300, 'Escalated');
    }
    
    private static void testMaintenanceRequest(string Type, integer howmany, string Status) {
        //Test Repair maintance request
        List<Case> MRList = TestDataFactory.createMaintenanceRequest(Type, howmany);
        for (Case c: MRList) {
            c.Status = Status;
        }
        update MRList;
        
        List<Case> followupMRList = [SELECT id, Type, Status, Vehicle__c, Equipment__c, Subject, Origin, Date_Reported__c, Date_Due__c
                                          FROM Case WHERE ParentId IN: MRList 
                                          AND Status = 'New'];
        
        integer expectedCount = 0;
        if(Status == 'Closed' && (Type =='Repair' || Type == 'Routine Maintenance')) {
            expectedCount = howmany;
        }
      
        
        if (expectedCount>0) {
            for (Case c: followupMRList) {
                System.assertEquals('Routine Maintenance', c.Type);
                System.assertEquals('Test Maintenance Request', c.Subject);
                System.assertEquals(Date.today(), c.Date_Reported__c);
                
            }
        }
    }
}