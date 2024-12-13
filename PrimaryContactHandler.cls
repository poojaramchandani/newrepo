public class PrimaryContactHandler {
	public static void insertAfter(List<Contact> newCont)
    {
		List<Contact> conList = new List<Contact>();
            for(Contact con : newCont){
                if(con.AccountId != Null){
                    Id accid = con.AccountId;
                    if(con.Primary__c == True){
                        List<Contact> cList = [Select AccountId, Id, Primary__c from Contact where AccountId =: accid And Id !=: (con.Id)];
                        for(Contact con2 : cList){
                            if(con2.Primary__c == True){
                                con2.Primary__c = False;
                                conList.add(con2);
                            }                            
                        }
                    }
                }

            }
        	update conList;
    }
    
    
    
    public static void updateAfter(List<Contact> newCont)
    {
		List<Contact> conList = new List<Contact>();
            for(Contact con : newCont){
                if(con.AccountId != Null ){
                    Id accid = con.AccountId;
                    if(con.Primary__c == True){
                        List<Contact> cList = [Select AccountId, Id, Primary__c from Contact where AccountId =: accid And Id !=: (con.Id)];
                        for(Contact con2 : cList){
                            if(con2.Primary__c == True){
                                con2.Primary__c = False;
                                conList.add(con2);
                            }                            
                        }
                    }
                }
            }
        	update conList;
    }

    public static void deleteAfter(List<Contact> contct) //Map<Id,Contact> conMap)
    {
		List<Contact> conList = new List<Contact> ();
       set<Id> accid = new set<Id>();
        for(Contact c : contct){
            if(c.AccountId != null && c.Primary__c ==True){
                accid.add(c.AccountId);
               
            }
        }
        List<Contact> cList =  [Select Id, Primary__c, AccountId, LastName, CreatedDate from Contact where AccountId IN:accid ORDER BY CreatedDate ASC LIMIT 1];
        for(Contact con : cList)
        {
           	con.Primary__c = True;
            conList.add(con);
         }
        
        
       update conList;
    }
    
    
}