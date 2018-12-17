({
         onInit : function(component, event){
                var boat = component.get("v.boat");
                console.log("BOAT ID " + boat.Id);
                var action = component.get("c.getAll");
                action.setParams({"boatId" : boat.Id});
               
                //add the callback behavior for when the response is received
                action.setCallback(this,function(response){
                    var state = response.getState();
                    if (state === "SUCCESS"){
                        component.set("v.boatReviews", response.getReturnValue());
                        console.log("Boat reviews fetched from server");
                        }
                        else {
                        console.log("SOQL query failed " + state);
                        }
                });
                //enqueue action to be executed in server
                $A.enqueueAction(action);
    },
})