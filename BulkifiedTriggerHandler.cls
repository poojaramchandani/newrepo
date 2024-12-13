public class BulkifiedTriggerHandler {
    
    //ON Before Insert
    public static void beforeInsert(List<Lead> newLeads)
    {
        for(Lead l : newLeads)
        {
            if(String.isBlank(l.FirstName))
            {
                l.FirstName = 'Testing';
            }
        }
    }
    
    //ON Before Update
    public static void beforeUpdate(List<Lead> newLeads, Map<Id,Lead> oldMap)
    {
        for(Lead ld : newLeads)
        {
            if(ld.FirstName != NULL && ld.FirstName != oldMap.get(ld.Id).FirstName)
            {
                ld.FirstName = 'XYZ';
            }
        }
    }

    
    //ON Before Delete
    public static void beforeDelete(List<Lead> newLeads)
    {
        for(Lead ld : newLeads)
        {
            if(ld.FirstName != NULL)
            {
                ld.addError('You cannot delete it if first name is not null');
            }
        }
    }

    
     //ON After Update
    public static void afterUpdate(List <Lead> oldLeads)
    {
         List<Account> aList = new List<Account>();
        for(Lead l1 :oldLeads)
        {
            Account a = new Account();
            if(l1.Company != Null)
            {
                a.Name = l1.Company;
            }
            aList.add(a);
           
        }
         insert aList;
    }
        
    //ON After Insert
    public static void afterInsert(List<Lead> newLead)
    {
        List<Contact> cList = new List<Contact>();
        for(Lead l : newLead)
        {
        	Contact c = new Contact();
        	c.LastName = 'Test';
            c.Department = l.Company;
            cList.add(C);
        }
        INSERT cList;
        
    }
    
    //ON After Delete
    /*public static void afterDelete(List<Lead> oldLead)
    {
		
        List<Family__c> fList = new List<Family__c>();
        for(Lead l : oldLead)
        {
        	Family__c f = new Family__c();
        	f.Name = l.Company;
            f.Family_Income__c = 90000;
            fList.add(f);
        } 
        INSERT fList;
    }*/


}