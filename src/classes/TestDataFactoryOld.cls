@IsTest
public class TestDataFactoryOld {

    public static List<Case> createMaintenanceRequest(string Type, integer howmany) {

        List<Case> MRList = new List<Case>();

        if (howmany >0 && Type != null ){
            //create Veichle
            Vehicle__c v = new Vehicle__c(Name='TestVehicle', VIN_Number__c='asdfgf424');
            insert v;

            //create multiple equipments
            List<Product2> equips = new List<Product2>();
            equips.add(new Product2(Name='TestEquipment1', Warehouse_SKU__c='1111111', Lifespan_Months__c=6, Maintenance_Cycle__c=30, Replacement_Part__c=true));
            equips.add(new Product2(Name='TestEquipment2', Warehouse_SKU__c='9999999', Lifespan_Months__c=12, Maintenance_Cycle__c=30, Replacement_Part__c=true));
            equips.add(new Product2(Name='TestEquipment3', Warehouse_SKU__c='5555555', Lifespan_Months__c=18, Maintenance_Cycle__c=60, Replacement_Part__c=true));
            equips.add(new Product2(Name='TestEquipment4', Warehouse_SKU__c='4444444', Lifespan_Months__c=24, Maintenance_Cycle__c=90, Replacement_Part__c=true));
            insert equips; 

            //create maintenance requests
            for (integer i = 0; i<howmany; i++) {
                MRList.add(new Case(Type = Type, Status='New', Origin='Phone', Equipment__c=equips[0].id, Subject='Test Maintenance Request'));
            }
            insert MRList;

            //create work parts for maintenance requests
            List<Work_Part__c> wpList = new List<Work_Part__c>();
            for (Case c: MRList) {
                wpList.add(new Work_Part__c(Equipment__c=equips[0].id, Maintenance_Request__c=c.id, Quantity__c=1));
                wpList.add(new Work_Part__c(Equipment__c=equips[1].id, Maintenance_Request__c=c.id, Quantity__c=2));
            }
            insert wpList;

        }   

        return MRList;
    }
}