public class ContactUpdateSerialNoHandler {
	
    //After Insert
    public static void afterInsert(List<Contact> conList)
    {
        List<Contact> newConList = new List<Contact>();
		Set<Id> accId = new Set<Id>();
        Set<Id> conId = new Set<Id>();
        Integer sNo;
        for(Contact con : conList)
        {
            accId.add(con.AccountId);
            conId.add(con.Id);
        }
        List<Contact> cList1 = [Select Serial_Number__c, AccountId, Id from Contact where AccountId IN: accId AND Id !=: conId];
        if(cList1.size()>0)
        {
            sNo = cList1.size()+1;
        }
        else 
        {
            sNo=1;
        }
       	
        List<Contact> cList2 = [Select Serial_Number__c, AccountId, Id from Contact where Id =: conId];
        for(Contact con : cList2)
        {
    		con.Serial_Number__c = sNo;
            newConList.add(con);
         }
        update newConList;
  }
    

    
    //After Update
	public static void afterUpdate(List<Contact> newCon, Map<Id,Contact> oldConMap)
    {
        List<Contact> newConList = new List<Contact>();
        List<Contact> ConList = new List<Contact>();
		Set<Id> accId = new Set<Id>();
        Set<Id> conId = new Set<Id>();
        for(Contact con : newCon)
        {
            if(con.AccountId != NULL)
            {
				accId.add(con.AccountId);
            	conId.add(con.Id);
            }
        }
        
       List<Contact> cList = [Select Serial_Number__c, AccountId, Id, LastName from Contact where AccountId IN: accId AND Id !=: conId ]; 
      
       for(Contact con : newCon)
       {
       		//Contact cont = [Select Serial_Number__c, AccountId, Id from Contact where Id =: con.Id];
           	if(con.Id == oldConMap.get(con.Id).Id && con.Serial_Number__c != oldConMap.get(con.Id).Serial_Number__c)
            {
                System.debug(cList);
               	for(Contact c : cList)
              	{
            		if(con.Serial_Number__c == c.Serial_Number__c)
                    {
                    	Integer sNo = (Integer)oldConMap.get(con.Id).Serial_Number__c;
                        c.Serial_Number__c = sNo;
                        newConList.add(c);
                     }
                    /*else
                    {
                        Integer i = (Integer)oldConMap.get(con.Id).Serial_Number__c;
                        Contact newC = oldConMap.get(con.Id);
                        newC.Serial_Number__c = i;
                        newConList.add(newC);
                    }*/
              	}
          	}
    	}
        if(newConList.size()>0)
        {
                update newConList;
        } 
        
    }
    
    
    
    
    //After Delete
    public static void afterDelete(List<Contact> newCon, List<Contact> oldCon)
    {   
        List<Contact> newConList = new List<Contact>();
		Set<Id> accId = new Set<Id>();
        Set<Id> conId = new Set<Id>();
        for(Contact con : oldCon)
        {
            if(con.AccountId != NULL)
            {
				accId.add(con.AccountId);
            	conId.add(con.Id);
            }
        }
        
        for(Contact con : oldCon)
        {
           List <Contact> cList2 = [Select Serial_Number__c, AccountId, Id from Contact where AccountId IN: accId AND Serial_Number__c >: con.Serial_Number__c Order By Serial_Number__c];
            Integer sNo = (Integer)con.Serial_Number__c;
           	for(Contact c : cList2)
            {
                c.Serial_Number__c = sNo;
                sNo=sNo+1;
                newConList.add(c);
            }
        }
        update newConList;
    }
    
    

    
    //After UnDelete
    public static void afterUndelete(List<Contact> newCon)
    {
        List<Contact> newConList = new List<Contact>();
		Set<Id> accId = new Set<Id>();
        Set<Id> conId = new Set<Id>();
        Set<Integer> sNo = new Set<Integer>();
        for(Contact con : newCon)
        {
            if(con.AccountId != NULL)
            {
				accId.add(con.AccountId);
            	conId.add(con.Id);
                Integer serialno = (Integer)con.Serial_Number__c;
                sNo.add(serialno);
            }
        }
        List<Contact> cList = [Select AccountId, Id, Serial_Number__c from Contact where AccountId IN: accId AND Id !=: conId AND Serial_Number__c >=: sNo];
        for(Contact c : newCon)
        {
            Integer serialno = (Integer)c.Serial_Number__c;
            for(Contact c2 : cList)
            {
                c2.Serial_Number__c = serialno+1;
                newConList.add(c2);
                serialno=serialno+1;
            }
        }
        update newConList;
    }
    
	

//before update    
    /*public static void beforeUpdate(List<Contact> newCon, Map<Id,Contact> oldConMap)
    {
        List<Contact> newConList = new List<Contact>();
        List<Contact> ConList = new List<Contact>();
		Set<Id> accId = new Set<Id>();
        Set<Id> conId = new Set<Id>();
      
    	for(Contact c : newCon)
    	{
        	if(c.Serial_Number__c != oldConMap.get(c.Id).Serial_Number__c)
        	{
        	    c.Serial_Number__c = oldConMap.get(c.Id).Serial_Number__c;
                newConList.add(c);
        	}
    	}
        update newConList;
    
    }*/
}