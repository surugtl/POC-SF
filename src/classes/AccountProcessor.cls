public class AccountProcessor{

    @future
    public static void countContacts(List<Id> accountIds) {
    List<Account> accounts = [Select Id, Name,(Select id from Contacts) from Account Where Id IN :accountIds];
    
       for(Account a : accounts){
       
          a.Number_of_Contacts__c = a.contacts.size();
       }
       
         update accounts;
       
  }
}