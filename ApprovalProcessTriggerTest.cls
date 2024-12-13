@isTest
public class ApprovalProcessTriggerTest {
	@isTest
    public static void insertApprovalTest()
    {
        Account acc = UtilityContactInsertion.addAcc('Acc11');
        acc.BillingStreet = 'Address';
        acc.BillingCity = 'jaipur';
        acc.BillingCountry = 'India';
        acc.BillingState = 'Raj';
        acc.BillingPostalCode = '1234';
		        
        insert acc;
        List<Account> accList = new List<Account>();
        
        String bCon = (String)acc.BillingCountry;
        if(bCon.equalsIgnoreCase('india') && acc.CheckBox__c==true)
        {
            acc.BillingCountry = 'Indonesia';
            accList.add(acc);
        }
        update acc;
    }  
}