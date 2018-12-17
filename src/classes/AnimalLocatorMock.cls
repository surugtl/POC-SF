@isTest
global class AnimalLocatorMock implements HttpCallOutMock
{
    public static HTTPResponse respond(HttpRequest req) 
    {
            HTTPResponse response =new HTTPResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"animal":{"id":1,"name":"chicken"}}');
            response.setStatusCode(200);

             return response;

    }

}