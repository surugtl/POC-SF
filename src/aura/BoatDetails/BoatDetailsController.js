({
     init: function(component, event, helper) {
        component.set("v.enableFullDetails", $A.get("e.force:navigateToSObject"));
    },
    
    onBoatSelected : function(component, event, helper) {
        
        var boat = event.getParam("boat");
        component.set("v.id",boat.Id);
        component.set('v.selectedBoat',boat);
        var tempRec = component.find("service");
        tempRec.set("v.recordId", boat.Id);
        tempRec.reloadRecord();
        
    },
   
    onBoatReviewAdded : function(component, event, helper) {
        console.log("event reached");
        component.find("details").set("v.selectedTabId", "boatreviewtab");
        
        //invoke refresh controller method
        var refreshBR = component.find("BoatReviews");
        refreshBR.refresh(); 
    },        
})