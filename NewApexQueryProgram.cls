public class NewApexQueryProgram {
	public static void myQuery(integer j)
    {
        /*List <College__c> l1 = [SELECT NAME, COLLEGE_UNIVERSITY__C, TOTAL_NUMBER_OF_STUDENTS__C FROM College__c WHERE TOTAL_NUMBER_OF_STUDENTS__C >0];
    	for(Integer i=0; i<l1.size(); i++)
        {
            System.debug(l1.COLLEGE_UNIVERSITY__C);
        }*/
        
        /*List<Account> accList = [Select Name, NumberOfEmployees from account where NumberOfEmployees=:j];
        for(integer i=0; i<accList.size(); i++)
        {
        System.debug(accList[i].Name);
        }
        for(Account a:acclist)
        {
        	System.debug('Acc Name =  '+a.Name+' NumOfEmp = '+a.numberOfEmployees);
        }*/
        /*AggregateResult agr = [Select sum(amount)from opportunity];
		 System.debug(agr);
		AggregateResult agr2 = [Select count(name)from account];//count the values present in name field
        System.debug(agr2);*/
    }
}