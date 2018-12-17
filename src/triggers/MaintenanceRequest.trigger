trigger MaintenanceRequest on Case (before update, after update) {
    // call MaintenanceRequestHelper.updateWorkOrders 
    
    List<Case> processList = new List<Case>();
    for(Case c : Trigger.new){
    
        if(c.IsClosed && (c.type == 'Repair' || c.type =='Routine Maintenance')){
        
            processList.add(c);
        }
    } 
    
    if(processList.size() > 0){
    
      MaintenanceRequestHelper.updateWorkOrders(processList);
    }
}