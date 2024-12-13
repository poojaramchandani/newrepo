public class Deletion {
	public static void deleteRecords()
    {
        //Integer i;
       	List<Child__c> l1 =[Select ID from Child__c];
		delete l1;
		List<Account> l2 =[Select ID from Account WHERE name='SBI'];
		delete l2;
		List<Bank_Account__c> l3 =[Select ID from Bank_Account__c WHERE name IN('WXYZ','XYZ')];
        delete l3;
        List<Leave_Balance__c> l4 =[Select ID from Leave_Balance__c];
        delete l4;
        System.debug('All Records deleted');
    }
}