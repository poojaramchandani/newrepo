@isTest
public class PrimaryContactTest {
	@isTest
    public static void primaryContactTest()
    {
        Account acc = UtilityContactInsertion.addAcc('test');
        Insert acc;
        system.assertEquals('test', acc.Name);
        List<Contact> conList = new List<Contact>();
        conList.add(UtilityContactInsertion.addContact('test1', 1, acc.Id));
        conList.add(UtilityContactInsertion.addContact('test2',2, acc.Id));
        conList.add(UtilityContactInsertion.addContact('test3',3, acc.Id));
        conList.add(UtilityContactInsertion.addContact('test4',4, acc.Id)); 
        
        conList[3].Primary__c = True;
        INSERT conList;
        
       	conList[2].Primary__c = True;     
        update conList;
        delete conList;
        
    }
}