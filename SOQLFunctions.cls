public class SOQLFunctions {
	public static void soql()
    {
        Integer i = [select count() from opportunity];
		System.debug('Total no of opp  - '+i);
        AggregateResult ar1 = [select min(amount) from opportunity]; 
        System.debug('Min of Amt  - '+ar1);
         
         AggregateResult ar2 = [select count(ID) from opportunity]; 
        System.debug('Total no of opp  - '+ar2);
         AggregateResult ar3 = [select count(amount) from opportunity]; 
        System.debug('Count of amount field records  - '+ar3);
       // System.debug(ar2-ar3);
       AggregateResult ar4 = [select avg(amount) from opportunity]; 
        System.debug('average of amount field records  - '+ar4);
        
           AggregateResult ar5 = [select Count_Distinct(amount) from opportunity]; 
        //IT WILL RETURN THE COUNT OF AMOUNT RECORDS HAVING UNIQUE AMOUNT RECORDS 
        //AND WILL NOT INCLUDE NULL VALUES
        System.debug('Count of amount field HAVING UNIQUE records  - '+ar5);
        
    	//Convert aggregate result into datatype (integer format)
        Integer j =(Integer) ar3.get('expr0');
         System.debug('Count of amount field HAVING UNIQUE records  - '+j);
        System.debug(i-j);
    }
}