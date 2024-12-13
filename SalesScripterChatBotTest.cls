@isTest
public class SalesScripterChatBotTest {
	@isTest
    public static void detectIntentTest() {
        System.Test.startTest();
        System.Test.setMock(HttpCalloutMock.class, new MockHttpResponse());
        String reply = SalesScripterChatBot.detectIntent('What is your full name');
        System.Test.stopTest();
        System.assertEquals('Mary Thomas', reply);
    }
    public class MockHttpResponse implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            res.setBody('{"response":"Mary Thomas","intent": {"displayName": "Default Fallback Intent"}}');
            return res;
        }
    }
}