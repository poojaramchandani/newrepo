public class Insertion {
	public static void insertRecords()
    {
        Integer i;
       	List<Leave_Request__c> l1 =new List<Leave_Request__c>();
		for(i=1; i<=10; i++)
        {
            Leave_Request__c l = new Leave_Request__c(Name='Leave '+i);	
            l1.add(l);
        }
        insert l1;
		System.debug('All'+(i-1)+'Record inserted');
    }
}