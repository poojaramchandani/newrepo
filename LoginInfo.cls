public class LoginInfo {
    public String loginemail {get; set;}
    public String loginmail {get; set;}
    public String pass{set;get;}
    public List<Contact> conList{set;get;}
    
    public LoginInfo()
    {
        //this.loginemail = loginemail;
        System.debug('logininfo '  + loginmail);
    }
   	
    public PageReference signUp()
    {
        PageReference p = new PageReference('/apex/ContactRecordLoginInfo');
        System.debug(p);
        return p;
    }
    
    
    public PageReference loginDetails()
    {
        PageReference p;
        if(loginemail!=NULL)
        {
            conList =[select Id,FirstName,LastName,Email,Password__c from Contact where Email =: loginemail LIMIT 1];
      
        	if(conList.size()==0)
        	{
            	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Email doesnot exist'));
            	p= null;
        	}
        	else
        	{
                if(pass!=NULL)
                {
                    if(conList[0].Password__c == pass)
           			{
               		 	p = new PageReference('/apex/NewLoginInfo');
              		                
           			} 
                    else
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Wrong Password click on to forget password if you dont remember'));
                    }
                }
                else{
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Email cannot be null'));
                }
           		
        	}
       
        }
        else
        {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Email cannot be null '));
        }
        return p;
    }
    
    
    public PageReference otpPage()
    {
       	PageReference p = new PageReference('/apex/GenerateOtpInfo');
		return p; 
    }
    
    
 		
    
}