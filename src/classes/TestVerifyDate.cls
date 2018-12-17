@isTest
private class TestVerifyDate{

    VerifyDate VD = new VerifyDate();
    

    @isTest static void test30Days() {
        Date d1 = system.today();
        Date d2 = d1.addDays(30);
        VerifyDate.CheckDates(d1,d2);
    }
    
    @isTest static void testEndofMonth() {
        Date d1 = system.today();
        Date d2 = d1.addDays(29);
        VerifyDate.CheckDates(d1,d2);
    }
    
   
}