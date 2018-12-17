global class LeadProcessor implements 
    Database.Batchable<sObject>, Database.Stateful {
    
    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, LeadSource FROM Lead '
            
              
            
        );
    }
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        // process each batch of records
        List<Lead> updateList = new List<Lead>();
        for (Lead l : scope) {
              if(l.LeadSource == 'Dreamforce')
                updateList.add(l);
        
        }
        update updateList;
    }    
    global void finish(Database.BatchableContext bc){
        
    }    
}