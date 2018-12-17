({
    doInit : function(component, event, helper) {
        helper.onInit(component,event);
    },
    onSave : function(component, event, helper) {
        component.set("v.boatReview.Boat__c",component.get("v.boat.Id"));
        component.find("service").saveRecord(function(saveResult){
            if(saveResult.state==="SUCCESS" || saveResult.state === "DRAFT")
            {
                
               var resultsToast = $A.get("e.force:showToast");
                if(resultsToast)
                {
                    resultsToast.setParams({
                        "title": "Saved",
                        "message": "Boat Review Created"
                    });
                    resultsToast.fire(); 
                }
                else
                {
                    alert('Boat Review Created');
                }
                
                var BRAddedEvnt=component.getEvent("boatReviewAdded");
                BRAddedEvnt.fire();
                helper.onInit(component,event,helper);
            }
            
            
        });
       
    },
    onRecordUpdated : function(component, event, helper) {
        var eventParams = event.getParams();
        if(eventParams.changeType === "CHANGED") {
            var changedFields = eventParams.changedFields;
            var saveResultsToast = $A.get("e.force:showToast");
                if(saveResultsToast!='undefined')
                {
                    saveResultsToast.setParams({
                        "title": "Saved",
                        "message": "Boat review updated"
                    });
                    saveResultsToast.fire(); 
                }
                else
                {
                    alert('Boat review updated');
                }
        }
    }
})