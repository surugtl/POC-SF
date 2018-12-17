trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {

    List<Task> TaskList = New List<Task>();
    
       for(Opportunity O : Trigger.new){
          if(O.StageName == 'Closed Won'){
          
               Task T = new Task();
               T.Subject = 'Follow Up Test Task';
               T.WhatID = O.id;
               
               TaskList.add(T);
          }
       }
       
       if(TaskList.size() > 0)
          insert TaskList;

}