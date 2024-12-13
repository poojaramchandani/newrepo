public class getAccountList {
    @AuraEnabled
	public static List<Account> getAcc(Integer off, Integer recordno)
    {
        system.debug(off);
        return [select Id, Name from Account Where Id!=NUll ORDER BY Name ASC LIMIT:recordno OFFSET:off];
        
    }
    @AuraEnabled
	public static Boolean insertAcc(String acname)
    {
        Account a = new Account();
        a.Name = acname;
        insert a;
        return true;
    }
    @AuraEnabled
	public static Account getAccById(Id acid)
    {
        
        return [select Id, Name from Account where Id=:acid];
    }
    
    @AuraEnabled
	public static Boolean editAccMethod(String acname, Id accid)
    {
        Account a = new Account();
        a.Id = accid;
        a.Name = acname;
		update a;        
        return true;
    }
    
    @AuraEnabled
	public static Boolean deleteAccMethod(String acname, Id accid)
    {
        Account a = new Account();
        a.Id = accid;
        a.Name = acname;
		delete a;        
        return true;
    }
    
    @AuraEnabled
	public static ACcount accSize()
    {
       	List<Account> accList = [select Id, Name from Account];
        Integer s = accList.size();
       // return s;
        return [select Id, Name from Account Where Id!=NUll ORDER BY Name DESC LIMIT 1];
    }
    
}