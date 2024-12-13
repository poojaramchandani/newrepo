@isTest public class ContactUpdateSerialNoTest {
    @isTest public static void afterInsertTest(){
        Account acc = new Account(Name='test');
        Insert acc;
        system.assertEquals('test', acc.Name);
        List<Contact> conList = new List<Contact>();
        conList.add(UtilityContactInsertion.addContact('Test1', 1, acc.Id));
        conList.add(UtilityContactInsertion.addContact('Test2',2, acc.Id));
        conList.add(UtilityContactInsertion.addContact('Test3',3, acc.Id));
        conList.add(UtilityContactInsertion.addContact('Test4',4, acc.Id)); 
        INSERT conList;
        system.assertEquals(4, conList.size());
        conList[0].Serial_Number__c=3;
        Update conList;
        system.assertEquals(3, conList[0].Serial_Number__c);
        List<Contact>  delList= [SELECT id from Contact where Id=: conList[2].Id];
        Delete delList;
        List<Contact>  undelList= [SELECT id from Contact where Id=: conList[2].Id All ROWS];
        Undelete undelList; 
        
    }   
}