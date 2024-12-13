@isTest
public class AccountTriggerTest {
   
    @isTest
    public static void createContactTest()
    {
        Account acc = UtilityContactInsertion.addAcc('test');
        List<Contact> conList = new List<Contact> ();
        acc.Number_of_Contacts__c = 2;
        Insert acc;
    	if(acc.Number_of_Contacts__c<5)
        {
            for(Integer i=0; i<acc.Number_of_Contacts__c; i++)
        	{
       			conList.add(UtilityContactInsertion.addContact('test1', i, acc.Id));         
        	}
        }
        
        
        
        
        INSERT conList;
        
    }

}