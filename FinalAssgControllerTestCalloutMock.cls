@isTest
global class FinalAssgControllerTestCalloutMock implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest request) {
        HTTPResponse response  = new HTTPResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"url":["https://anavcloudssoftwaresoloution-dev-ed--c.vf.force.com/apex/FinalAssgPage?contId=0035i00000Ieos7AAB"]}');
        response.setStatusCode(200);
        return response;
    }
    	
    
}