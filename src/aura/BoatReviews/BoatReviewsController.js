({
	
   doInit : function(component,event,helper){
        helper.onInit(component, event);
    },
    
   onUserInfoClick : function(component,event,helper){
        var userSFId = event.currentTarget.getAttribute("data-userid");
        var navigateToUser = $A.get("e.force:navigateToSObject");
        navigateToUser.setParams({
            "recordId" : userSFId,
        });
        navigateToUser.fire()

    },
})