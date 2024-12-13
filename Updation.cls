public class Updation {
    public static void updateRecords()
    {
		/*Leave_Request__c leave = [select Leave_Status__c, Name from Leave_Request__c where name= 'Leave 2'];
        leave.name='Latest Leave2';
        leave.Mail_ID__c='secret30girl@gmail.com';
        update leave;
       	System.debug('Records Updated');
		Leave_Request__c l1 = [select id, Name from Leave_Request__c where id='a085i000006XGmbAAG'];
        l1.name='Pooja';
        update l1;*/
        
        
        Account a1= [Select Name, AccountNumber, Type From Account where Name='ICICI'];
        a1.type='Prospect';
        a1.AccountNumber='123';
            update a1;
        System.debug(a1+'Successfuly Updated');
    }
}