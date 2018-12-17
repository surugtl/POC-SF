@isTest
global class WarehouseCalloutServiceMock implements HttpCalloutMock {
    // implement http mock callout
    global HttpResponse respond(HttpRequest request){
        
                
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[{"_id":"3345lkjdjdduprenpj345","replacement":false,"quantity":3,"name":"Test Equipment","maintenanceperiod":90,"lifespan":120,"cost":5000,"sku":"4435678"}]');
        response.setStatusCode(200);
        return response;
    }
}