/**
 * @name orderTrigger
 * @description
**/
trigger orderTrigger on Order (after update) {

    try {
        //call helper class method to process logic
        OrderHelper.AfterUpdate(Trigger.New,Trigger.Old);
    }catch ( Exception e ){
    
    }
}