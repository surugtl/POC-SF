public class RandomContactFactory{

    
    public static List<Contact> generateRandomContacts(Integer numCons, String LName) {
        
        List<Contact> cons  = new List<Contact>();
        
        for(Integer i=0;i<numCons;i++) {
            Contact c = new Contact(FirstName='Test ' + i,LastName = LName);
            cons.add(c);
        }
        
        insert cons;
        
            
        return cons;
    }
}