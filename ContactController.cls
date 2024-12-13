public with sharing class ContactController {

    public Contact c { get; set; }
    public String reenter{set;get;}
    public String pass{set;get;}
    public Boolean flag{get;set;}
    public String otpnew{get;set;}
    public Boolean flag2{get;set;}
     
        
   

    public List<Contact> conList { get; set; }
    
    
    	public ContactController(){
       	c=new Contact();
    }

    public PageReference signUp() {
        
        PageReference p;
       conList=[select Id,FirstName,LastName,Email,Password__c from Contact where Email =: c.Email];
        if(reenter==null||reenter=='')
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'pls re-enter Password'));
        }
       System.debug(conList);
        
        System.debug(reenter);
        System.debug(c.Password__c);
                
        if(conList.size()==0)
        {
            if(reenter!=c.Password__c)
        	{
             	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Password doesnot match'));
        	}
            else
            {
                insert c; 
                p=new PageReference('/apex/LoginInfo');
            }
                
        }
        else
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Email already exist, To save rcord enter a different Mail Id'));
        }
           
        
        return p;
    }

    public PageReference BackToLogin() {
      	PageReference p = new PageReference('/apex/LoginInfo');
        return p;
    }
    
    public PageReference getOtp(){
        PageReference p;
        flag2=false;
        conList=[select Id,FirstName,LastName,Email,Password__c,OTP__c from Contact where Email =: c.Email ];
        System.debug(conList);
        Integer randomNumber = Integer.valueof((Math.random() * 1000));
        Integer randomNo = randomNumber+10;
        String s;
        
        System.debug(randomNumber);
        if(conList.size()>0)
        {
            System.debug(conList[0].LastName);
        	s = conList[0].LastName + String.valueOf(randomNumber) + String.valueOf(randomNo);
            System.debug(s);
            
            Contact con =[select Id, LastName, OTP__c, Email from Contact where Email =: c.Email LIMIT 1];
        	if(con!=NULL)
        	{
              
				con.OTP__c = s;
				update con;
                flag=true;
                flag2=true;
                try{
                	String sub = 'Reset Password';
                	String body = 'Your OTP for Reseting your password is ' + s;
                	String [] addr = new String [] {con.Email};
                	EmailTemplateInfo.sendMail(sub,body,addr);    
                }
                catch(Exception e)
                {
                    System.debug(e);
                }
                
                
        	}
          	
                else
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Wrong otp'));
                }
          
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Email does not exist'));
            
        }
        
        
    	return p;
    }
    public PageReference reset()
    {
        PageReference p;
        Contact con = [select  Id, LastName, OTP__c, Password__c, Email from Contact where Email =: c.Email LIMIT 1];
        System.debug(con);
        System.debug(otpnew);
        
        if(otpnew==con.OTP__c)
        {
            p = new PageReference('/apex/ResetPassInfo');
            
        }
        else
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'ENTER CORRECT OTP'));
            p=null;
        }
        return p;
    }
    
    public PageReference resetpass()
    {
        PageReference p ;
        Contact con = [select  Id, LastName, OTP__c, Password__c, Email from Contact where Email =: c.Email LIMIT 1];
        System.debug(pass);
        if(pass==reenter)
        {
            	con.Password__c = pass;
        		update con;
            	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Password updated'));
        		System.debug(con);
        }
        else
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Password doesnot match'));
        }
       
        
        return p;
    }
    
    
   }