@isTest
public class WebSpeechApiPicklistTest {
    @isTest
    public static void testGetValues() {
        System.Test.startTest();
        String str = 'Test';
        WebSpeechApiPicklist picklist = new WebSpeechApiPicklist();
        VisualEditor.DataRow defaultValue = picklist.getDefaultValue();
        VisualEditor.DynamicPickListRows picklistValue = picklist.getValues();
        System.Test.stopTest();
        System.assertEquals('Test', str);
    }
}