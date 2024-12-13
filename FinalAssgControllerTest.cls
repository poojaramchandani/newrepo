@isTest public with sharing class FinalAssgControllerTest{
   
    @isTest
    public static void insertObjTest () {
        Test.startTest();
        Contact c = new Contact();
        c = FinalAssgController.insertObj('Pooja', 'SHarma', 'vaishali', 'Ajmer', 'Raj', '342222', 'India', 'Raj', 'secret20@gmail.com', 1);
    	
    }
    
    @isTest
    public static String calloutTest() {
       Test.setMock(HTTPCalloutMock.class, new FinalAssgControllerTestCalloutMock()); 
        String s1;
        Contact c = new Contact();
        HTTPResponse response = new HTTPResponse();
      	response.setBody(FinalAssgController.callout(c));
        String fakeBody = response.getBody();
        String expected = '{"url":["https://anavcloudssoftwaresoloution-dev-ed--c.vf.force.com/apex/FinalAssgPage?contId=0035i00000Ieos7AAB"]}';
        System.assertEquals(200, response.getStatusCode());
        System.assertEquals(fakeBody, expected);
        if(response.getStatusCode()==200)
        {
            s1 = expected.split('=')[2];
        }
        return s1; 
    }
    
    
    @isTest
    public static void insertStripeTest()
    {
        String s1 = 'contId=0035i00000Ieos7AAB';
        FinalAssgController.insertStripe(s1);
        Test.stopTest(); 
    }
}