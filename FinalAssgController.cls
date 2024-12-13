public with sharing class FinalAssgController {
    
    @AuraEnabled
    public static Contact insertObj(String firstnm, String lastnm, String street, String city, String state, String code, String country, String phon, String mail, Integer qnty)
    {
        List<Contact> conList = new List<Contact>();
        Contact con = new Contact();
        con.FirstName = firstnm;
        con.LastName = lastnm;
        con.MailingStreet = street;
        con.MailingCity = city;
        con.MailingState = state;
        con.MailingPostalCode = code;
        con.MailingCountry = country;
        con.Phone = phon;
        con.Email = mail;
        con.Quantity__c = qnty;
        conList.add(con);
        system.debug(con);
        if(conList.size()>0)
        {
        	insert conList;    
        }
        return con;
    }
    
    
   @AuraEnabled
    public static String callout(Contact con){
        String returnurl='';
        if(con!=NULL)
        {
                String qnty = String.valueOf(con.Quantity__c);
                String conid = String.valueOf(con.Id);
                String ridrct = System.Label.StripeRedirectUrl+con.Id;
                HttpRequest req = new HttpRequest();
                Http http = new Http();
                req.setMethod('POST');
                String endpt = System.Label.StripSiite+qnty+System.Label.StripeRedirect+ridrct;
                String key = System.Label.StripeKey;
                req.setEndpoint(endpt);
                req.setHeader('Authorization', 'Bearer '+key);
                HttpResponse res = new HttpResponse();
                res = http.send(req);
                System.debug(res.getStatusCode());
                if(res.getStatusCode()==200)
                {
                    System.debug(res.getBody()); 
                    Map<String, Object> response = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                    returnurl = String.valueOf(response.get('url'));
                    System.debug(returnurl);
                }
        }
        return returnurl;
     }

    @AuraEnabled
    public static void insertStripe(String pgurl)
    {
        List<Stripe__c> strpList = new List<Stripe__c>();
        String cId = pgurl;
        if(cId.contains('='))
        {
            List<String> conId = cId.split('=');
            System.debug(conId);
            if(conId.size()>1){
                Stripe__c strp = new Stripe__c();
                Contact cont = [select Id from Contact where Id=:cId];
                if(cont!=NULL)
                {
					strp.Contact__c = cId;
                    strp.Price__c = 1;
                    strpList.add(strp);
                    System.debug(strp);
                    System.debug('inserted');
                }
            }
        }
        //cId = pgurl.split('&')[0];
        
        if(strpList.size() > 0)
        {
            insert strpList;
        }
        
    }
    
    
}