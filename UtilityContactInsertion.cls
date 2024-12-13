public class UtilityContactInsertion {
	public static Contact addContact(String lName, Integer serialNo, Id accId){
    	Contact con = new Contact(LastName = lName, Serial_Number__c = serialNo, AccountId = accId);
    	return con;
	}
    
    public static Account addAcc(String name)
    {
        Account acc = new Account(Name = name);
        return acc;
    }
}