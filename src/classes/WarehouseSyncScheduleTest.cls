@isTest
private class WarehouseSyncScheduleTest {
  
  @isTest
    static void test(){
        Test.startTest();
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock()); 
        
        WarehouseSyncSchedule WSS = new WarehouseSyncSchedule();
        
        Datetime dt = Datetime.now().addMinutes(3);
        String CRON_EXP = '0 '+ dt.minute() + ' * ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();

        System.schedule('Test Scheduler', CRON_EXP, WSS);
        
        Test.stopTest();             
        
    }
    
}