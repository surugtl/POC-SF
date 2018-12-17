({
    onInit : function(component,event) {
        component.find("service").getNewRecord(
            "BoatReview__c", 
            null,     
            false,     
            $A.getCallback(function() {
                var rec = component.get("v.boatReview");
                var error = component.get("v.recordError");
                var boat=component.get("v.boat");
                component.set("v.boatReviewRecord.Boat__c",boat.Id);
                component.set("v.boatReview.Boat__c",boat.Id);
                if(error) {
                    console.log("Error occured: " + error);
                }
            })
        );
    }
})