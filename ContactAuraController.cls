public class ContactAuraController {
    @AuraEnabled
    public static ContactDataTableWrapper getContactData(Decimal pageNumber, Decimal pageSize) {
         
        Integer pSize = (Integer)pageSize;
        Integer pNumber = (Integer)pageNumber;
         
        //Offset for SOQL
        Integer offset = (pNumber - 1) * pSize;
         
        //Total Records
        Integer totalRecords = [SELECT COUNT() FROM Contact where CreatedDate != 2022-08-02T03:41:21.000+0000];
        Integer recordEnd = pSize * pNumber;
 
        //Instance of Contact DataTable Wrapper Class
        ContactDataTableWrapper objDT =  new ContactDataTableWrapper();  
        objDT.pageSize = pSize;
        objDT.pageNumber = pNumber;
        objDT.recordStart = offset + 1;
        objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        objDT.totalRecords = totalRecords;
        objDT.contactList = [SELECT Id, Name, Phone, Email FROM Contact where CreatedDate != 2022-08-02T03:41:21.000+0000 ORDER BY Name LIMIT :pSize OFFSET :offset];
        return objDT;
    }
     
    //Wrapper Class For Contact DataTable  
    public class ContactDataTableWrapper {
        @AuraEnabled
        public Integer pageSize {get;set;}
        @AuraEnabled
        public Integer pageNumber {get;set;}
        @AuraEnabled
        public Integer totalRecords {get;set;}
        @AuraEnabled
        public Integer recordStart {get;set;}
        @AuraEnabled
        public Integer recordEnd {get;set;}
        @AuraEnabled
        public List<Contact> contactList {get;set;}
    }
    
     @AuraEnabled
	public static Contact getConById(Id conid)
    {
        
        return [select Id, Name, Phone, Email from Contact where Id=:conid ];
    }
    
    @AuraEnabled
	public static Boolean editConMethod(Id conid, String phon, String mail)
    {
        Contact c = new Contact();
        c.Id = conid;
        c.Phone = phon;
        c.Email = mail;
		update c;        
        return true;
    }
    
        @AuraEnabled
	public static Boolean insertCon(String ln, String phon, String email)
    {
        Contact a = new Contact();
        a.LastName = ln;
        a.Phone = phon;
        a.Email = email;
        insert a;
        return true;
    }
    
    @AuraEnabled
	public static Boolean deleteConMethod(Id conid)
    {
        Contact a = new Contact();
        a.Id = conid;
        
		delete a;        
        return true;
    }
    
    
    @AuraEnabled 
    public static void DeleteMass(List<Id> delIDs){
       
     List<Contact> lstOfDeleteAccount =  new List<Contact>();
         for(Id st: delIDs){
             Contact con = new Contact();
             con.Id = st ;
               lstOfDeleteAccount.add(con);  
          }
          Delete lstOfDeleteAccount;
 
    }
}