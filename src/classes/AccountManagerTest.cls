@isTest
private class AccountManagerTest {
  @isTest
     static void test(){
         Account a=new Account();
         a.Name='Test Apex Web Services';
         insert a;
         
         Contact c=new Contact();
         c.LastName='Web Service';
         c.FirstName='Test Apex';
         c.Accountid=a.id;
         insert c;
         
        RestRequest request =new RestRequest();
        request.requestURI='https://surugtl-dev-ed.my.salesforce.com/services/apexrest/Accounts/'+a.id+'/contacts'; 
         request.httpMethod='GET';
         RestContext.request=request;
         Account a1=AccountManager.getAccount();
    }
}