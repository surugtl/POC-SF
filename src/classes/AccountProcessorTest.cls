@IsTest
public class AccountProcessorTest{

    @isTest static void APTest() {
    
        List<Account> aList = new List<Account>();
        for(integer i=0;i<5;i++){
           Account a = new account(name = 'Test '+i);
           aList.add(a);
        }
        
        insert aList;
        
        List<ID> aidList = new List<ID>();
        
        for(Account a : aList)
          aidList.add(a.id);
          
          Test.startTest(); 
          AccountProcessor.countContacts(aidList);
          Test.stopTest();
    }
    
}