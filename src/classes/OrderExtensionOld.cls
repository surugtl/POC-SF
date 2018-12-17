/**
 * @name OrderExtension
 * @description This class is provided for you to facilitate the Super Badge
**/
public class OrderExtensionOld {

    public Order orderRecord {get;set;}
    public List<OrderItem> orderItemList {get;set;}
    public String selectedFamily {get;set;}
    public List<chartHelper.chartData> pieData {get;set;}
    public Decimal total {get;set;}

    public Map<Id,OrderItem> orderItemMap;
    ApexPages.StandardSetController standardSetController;

    public OrderExtensionOld(ApexPages.StandardController standardController){
    
        orderRecord = (Order)standardController.getRecord();
        orderItemMap = new Map<id,OrderItem>();
        if ( orderRecord.Id != null ){
            orderRecord = queryOrderRecord(orderRecord.Id);
        }
        queryData();
        total = 0;

        for (OrderItem oi : orderRecord.OrderItems){
            orderItemMap.put(oi.Product2Id, oi);
            
            if(oi.Quantity > 0){
                if(pieData == null){
                    pieData = new List<ChartHelper.ChartData>();
                }
                pieData.add(new chartHelper.ChartData(oi.Product2.Name, oi.Quantity * oi.UnitPrice));
                total += oi.UnitPrice * oi.Quantity;
            }
        }
        
        system.debug('OI Map'+orderItemMap);
        
        loadEquipment();
    }

    //ToDo: Implement your own method to populate orderItemList
    //  that you will call after pagination and/or family selection

   
    //method to load equipment data
    public void loadEquipment(){
    
                
        for (SObject obj : standardSetController.getRecords()){
            PricebookEntry pbe = (PricebookEntry)obj;

            if(orderItemMap.containsKey(pbe.Product2Id)){
                orderItemList.add(orderItemMap.get(pbe.Product2Id));
            } else{
                    OrderItem oi= new OrderItem();
                    oi.PricebookEntryId=pbe.Id;
                    oi.Product2Id=pbe.Product2Id;
                    oi.UnitPrice=pbe.UnitPrice;
                    oi.Quantity=0;
                    oi.Product2=pbe.Product2;
                    
                orderItemList.add(oi);
                orderItemMap.put(pbe.Product2Id, oi);
            }
        }
        system.debug('OI List'+orderItemList);
    }
    
    public void queryData(){
    
        orderItemList = new List<OrderItem>();
        String query = 'SELECT Name, Product2.Family, Product2.Name, Product2Id, UnitPrice, Product2.Quantity_Remaining__c'
                     + '  FROM PricebookEntry WHERE IsActive = TRUE';

        if(selectedFamily != Constants.SELECT_ONE){
            query += ' AND Product2.Family = \'' + selectedFamily + '\' ';
        }
        query += ' ORDER BY Name  LIMIT 14';

        standardSetController = new ApexPages.StandardSetController(Database.getQueryLocator(query));
        standardSetController.setPageSize(Constants.DEFAULT_ROWS);
    }

    /**
     * @name OnFieldChange
     * @description
    **/
    public void OnFieldChange(){
        //ToDo: Implement logic to store the values changed on the page
        //      and populate pieData
        //      and populate total
        for (OrderItem oi : orderItemList){
            orderItemMap.put(oi.Product2Id, oi);
        }

        pieData = null;
        total = 0;
        for (OrderItem oi : orderItemMap.values()){
            if(oi.Quantity > 0){
                if(pieData == null){
                    pieData = new List<chartHelper.ChartData>();
                }
                pieData.add(new chartHelper.ChartData(oi.Product2.Name, oi.Quantity * oi.UnitPrice));
                
                total += oi.UnitPrice * oi.Quantity;
            }

        }
    }

    /**
     * @name SelectFamily
     * @description
    **/
    public void SelectFamily(){
        //ToDo: Implement logic to filter based on the selected product family
       queryData(); 
       loadEquipment();
    }

    /**
     * @name Save
     * @description
    **/
    public void Save(){
        //ToDo: Implement logic to save the Order and populated OrderItems
        System.Savepoint sp = Database.setSavepoint();
        
        try{
            if(orderRecord.Pricebook2Id == null){
                orderRecord.Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID;
            }
            upsert orderRecord;

            List<OrderItem> orderItemsToUpsert = new List<OrderItem>();
            List<OrderItem> orderItemsToDelete = new List<OrderItem>();
            
           
            for (OrderItem oi : orderItemList) {
                if (oi.Quantity > 0) {
                    if (null == oi.OrderId) {
                        oi.OrderId = orderRecord.Id;
                    }
                    orderItemsToUpsert.add(oi);
                } else if (oi.Id != null) {
                    orderItemsToDelete.add(oi);
                }
            }
            
            //Update/insert order items for product
            upsert orderItemsToUpsert;
            
            //delete order items.
            delete orderItemsToDelete;
            
        } catch (Exception e){
            Database.rollback(sp);
            apexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,Constants.ERROR_MESSAGE));
        }
    }


    /**
     * @name First
     * @description
    **/
    public void First(){
        standardSetController.first();
        
        loadEquipment();
    }


    /**
     * @name Next
     * @description
    **/
    public void Next(){
         standardSetController.next();
         
         loadEquipment();
    }


    /**
     * @name Previous
     * @description
    **/
    public void Previous(){
        standardSetController.previous();
        
        loadEquipment();
    }

    /**
     * @name Last
     * @description
    **/
    public void Last(){
        standardSetController.last();
        
        loadEquipment();
    }

    /**
     * @name GetHasPrevious
     * @description
    **/
    public Boolean GetHasPrevious(){
        return standardSetController.getHasPrevious();
    }

    /**
     * @name GetHasNext
     * @description
    **/
    public Boolean GetHasNext(){
        return standardSetController.getHasNext();
    }

    /**
     * @name GetTotalPages
     * @description
    **/
    public Integer GetTotalPages(){
        
        Integer pageCount = (Integer)Math.ceil(standardSetController.getResultSize() / (Decimal)Constants.DEFAULT_ROWS);
        
        return pageCount; 
    }

    /**
     * @name GetPageNumber
     * @description
    **/
    public Integer GetPageNumber(){
        return standardSetController.getPageNumber();
    }

    /**
     * @name GetFamilyOptions
     * @description
    **/
    public List<SelectOption> GetFamilyOptions(){
    
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(Constants.SELECT_ONE, Constants.SELECT_ONE));
        for(Schema.Picklistentry pl : Constants.PRODUCT_FAMILY){
          options.add(new SelectOption(pl.getValue(), pl.getLabel()));
        }
        System.debug('Product Family Options'+options);
        return options;
    }

    /**
     * @name QueryOrderRecord
     * @description
    **/
    public static Order QueryOrderRecord(Id orderId){
        return [
            SELECT Id, AccountId, EffectiveDate, Name, Status, Pricebook2Id,
                (
                    SELECT Id, OrderId, Quantity, UnitPrice, PricebookEntryId, Product2Id,
                         Product2.Name, Product2.Family, Product2.Quantity_Remaining__c
                    FROM OrderItems
                )
            FROM Order
            WHERE Id = :orderId
        ];
    }

}