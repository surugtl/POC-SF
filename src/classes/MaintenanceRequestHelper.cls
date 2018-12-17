public class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(List<Case> cList){
        // update workorders
        
        List<Case> insertList = new List<Case>();
        
        for(Case c : cList){
        
            Case nc = new Case();
            nc.Type = 'Routine Maintenance';
            nc.Vehicle__c = c.Vehicle__c;
            nc.Equipment__c = c.Equipment__c;
            nc.subject = 'Followup maintenance';
            nc.Date_Reported__c = System.today();
            nc.accountid = c.accountid;
            nc.contactid = c.contactid;
            nc.status = 'New';
            nc.Date_Due__c = system.today().adddays(integer.valueof(c.Equipment_Maintenance_Days__c));
            
            insertList.add(nc);
            
        }
        
            if(insertList.size() > 0)
               insert insertList;
    }        
    
}