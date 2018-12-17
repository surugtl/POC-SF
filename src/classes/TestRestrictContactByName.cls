@isTest
private class TestRestrictContactByName{

   
    

    @isTest static void ContactTrigger() {
    
       Contact C = new Contact();
       C.LastName = 'INVALIDNAME';
       C.FirstName = 'Test';
       C.Email = 'test@trail.com';
       
       insert C;
       
       C.FirstName = 'Test Update';
       Update C;
        
    }
   
    
   
}