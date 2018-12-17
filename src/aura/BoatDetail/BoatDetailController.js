({
    init: function(component, event, helper) {
        component.set("v.enableFullDetails", $A.get("e.force:navigateToSObject"));
    },
    
    onBoatSelected : function(component, event, helper) {
        var boatSelected = event.getParam("boat");
        component.set("v.id",boatSelected.Id);
        var service = component.find("service");
        service.reloadRecord() ;
    },
    onFullDetails: function(component, event, helper) {
        var navigate = $A.get("e.force:navigateToSObject");
        navigate.setParams({
            "recordId": component.get("v.boat.Id")
        });
        navigate.fire();
    },   
})