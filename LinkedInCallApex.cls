public class LinkedInCallApex {
    
	public String authCodeFromURL; 
    public static String basicInfo; 
    public static String token;
	public static String theTokenResponse;
    public static Final String consumerKey = '7882rfmj493d02';
    public static Final String consumerSecret ='8SHm8NsqL7UJd7pf';
    public static Final String redirect_URI = 'https://anavcloudssoftwaresoloution-dev-ed.lightning.force.com/c/LinkedInCallApp.app';
    public static Final String linkedln_AuthUrl = 'https://www.linkedin.com/oauth/v2/authorization?';
    public static Final String accessToken_Endpoint = 'https://www.linkedin.com/oauth/v2/accessToken';
    
    public LinkedInCallApex(){
        authCodeFromURL = ApexPages.currentPage().getParameters().get('code');
        System.debug(authCodeFromURL);
         System.debug('urlokkk');
    } 
    
    
   
    
     @AuraEnabled
    public static String doGetAuthorizationCode( String requestoAuthURL){
       /* String requestoAuthURL = linkedln_AuthUrl + 'response_type=code&client_id='+consumerKey+'&redirect_uri='+redirect_URI+
                                     '&state=foobar&scope=r_liteprofile%20r_emailaddress%20w_member_social';*/
        PageReference pageRef = new PageReference(requestoAuthURL);
        System.debug(pageRef);
        String pg = String.valueOf(pageRef.getUrl());
        return pg;
    }
    
     @AuraEnabled
    public static String fetchCode(String theCode){ 
        String s =  theCode;
        s = s.split('&')[0];
        String s1 = s.split('=')[1];
	     return s1;        
    }
    
    @AuraEnabled
    public static String callOut(String theCode){ 
       HttpRequest req = new HttpRequest();
        Http http = new Http();
        
        String auth_url = 'https://www.linkedin.com/oauth/v2/accessToken?grant_type=authorization_code&code='+theCode+'&redirect_uri=https://anavcloudssoftwaresoloution-dev-ed.lightning.force.com/c/LinkedInCallApp.app&client_id=7882rfmj493d02&client_secret=8SHm8NsqL7UJd7pf';
      //  String params = 'grant_type=authorization_code&code='+theCode+'&redirect_uri=https://dev.example.com/auth/linkedin/callback&client_id=7882rfmj493d02&client_secret=8SHm8NsqL7UJd7pf';
       	req.setMethod('GET');
        req.setEndpoint(auth_url);
        HTTPResponse resp = http.send(req);
        System.debug(resp.getStatusCode());
        System.debug(resp.getBody());
        
        Map<String, Object> response = (Map<String, Object>)JSON.deserializeUntyped(resp.getBody());
        String acc = String.valueOf(response.get('access_token'));
        String exp = String.valueOf(response.get('expires_in'));
        String sc = String.valueOf(response.get('scope'));
        System.debug(sc);
       	
        List<LinkedIn_Information__c> lst =  new List<LinkedIn_Information__c>();
        LinkedIn_Information__c l = new LinkedIn_Information__c();
        l.Name = 'Linkedin Access Token';
        l.Access_Token__c = acc;
       	l.Expires_In_Seconds__c = Integer.valueOf(exp);
        /*LinkedIn_Information__c l2 = [select Name,Access_Token__c,Expires_In_Seconds__c from LinkedIn_Information__c where Name = 'Linkedin Access Token' LIMIT 1];
        if(l2==NULL)
        {
            insert l;
        }
        else {
            l2.Access_Token__c = acc;
            l2.Expires_In_Seconds__c = Integer.valueOf(exp);
        }*/
        insert l;
        return 'inserted';
    }
    
    @AuraEnabled
    public static List<String> doFetchBasicInfo(){
    
        String endPoint = 'https://api.linkedin.com/v2/me';
        Http http = new Http();
        HttpRequest httpReq = new HttpRequest();
        HttpResponse httpRes = new HttpResponse();
        String ln, fn, mail;
        LinkedIn_Record__c lr = new LinkedIn_Record__c();    
        
        LinkedIn_Information__c linkedlnInfoListNew = [Select Id, Name,Access_Token__c,Expires_In_Seconds__c From LinkedIn_Information__c order by CreatedDate DESC LIMIT 1];
        System.debug(linkedlnInfoListNew);
        httpReq.SetMethod('GET');
        httpReq.setEndpoint(endPoint);
        httpReq.setHeader('Authorization', 'Bearer '+linkedlnInfoListNew.Access_Token__c);
        httpRes = http.send(httpReq);
        System.debug('responseeeeee - '+httpRes.getStatusCode());    
        System.debug('responseeeee body - '+httpRes.getBody());   
        if(httpRes.getStatusCode() == 200)
        {
            Map<String, Object> response = (Map<String, Object>)JSON.deserializeUntyped(httpRes.getBody());
            ln = String.valueOf(response.get('localizedLastName'));
            System.debug(ln);
            fn = String.valueOf(response.get('localizedFirstName'));
            System.debug(fn);
            String idn = String.valueOf(response.get('id'));
            System.debug(idn);
        } 
        
        Http http1 = new Http();
        HttpRequest httpReq1 = new HttpRequest();
        HttpResponse httpRes1 = new HttpResponse();
        httpReq1.SetMethod('GET');
        httpReq1.setEndpoint('https://api.linkedin.com/v2/emailAddress?q=members&projection=(elements*(handle~))');
        httpReq1.setHeader('Authorization', 'Bearer '+linkedlnInfoListNew.Access_Token__c);
        httpRes1 = http1.send(httpReq1);
        System.debug('codeeee - '+httpRes1.getStatusCode());    
       	System.debug('bodyeee - '+httpRes1.getBody());  
        if(httpRes1.getStatusCode() == 200)
        {
         	Map<String, Object> response = (Map<String, Object>)JSON.deserializeUntyped(httpRes1.getBody());
            String ml = String.valueOf(response.get('elements'));
            System.debug(ml);
            mail = ml.substring(ml.lastIndexOfIgnoreCase('=')+1,ml.lastIndexOfIgnoreCase('}')-1);
            System.debug(mail);
            
        }
        if(ln != NULL && fn != NULL && mail != NULL)
        {
            lr.First_Name__c = fn;
            lr.Last_Name__c = ln;
            lr.Email__c = mail;
            insert lr;
            
		}
        List<String> str = new List<String>();
        str.add(fn);
        str.add(ln);
        str.add(mail);
        return str;
        
    }
    

    @AuraEnabled
    public static String doSharePostOnLinkedIn(){
    String errorMessage ='';
        Http http = new Http();
        
        HttpRequest httpReq = new HttpRequest();
        HttpResponse httpRes = new HttpResponse();
        
         System.debug('reqqqqqq');
        
        List<LinkedIn_Information__c> linkedlnInfoListNew = [Select Id, Name,Access_Token__c,Expires_In_Seconds__c From LinkedIn_Information__c order by CreatedDate DESC LIMIT 1];
        System.debug(linkedlnInfoListNew);
        
        httpReq.SetMethod('POST');
        httpReq.setEndpoint('https://api.linkedin.com/v2/ugcPosts');
        httpReq.setHeader('Authorization', 'Bearer '+linkedlnInfoListNew[0].Access_Token__c);
       //httpReq.setHeader('Content-Type', 'application/json');
        //httpReq.setHeader('x-li-format' , 'json');
        String requestBody = '{'+
                                '"author": "urn:li:person:SsVMnKQWCM",'
                                +'"lifecycleState": "PUBLISHED",'+
                                    '"specificContent": {'+
                                		'"com.linkedin.ugc.ShareContent": {'+
                                		'"shareCommentary": {'+
                                			'"text": "Hello LinkedIn!"'+
            							'},'+
                                    '"shareMediaCategory": "NONE"'+
            						'}'+
            					'}'+
                                   ' "visibility": {'+
       							'"com.linkedin.ugc.MemberNetworkVisibility": "PUBLIC"'+
   						 	'}'+
						'}';
            httpReq.setBody(requestBody);
        System.debug(httpReq.getBody());
       	httpReq.setTimeout(120000); 
        httpRes = http.send(httpReq);
        System.debug(httpRes.getStatusCode());
        //system.debug(httpRes.getBody());
        // Map<String,object> sharedPostInformaionMap = (Map<String,object>)JSON.deserializeUntyped(httpRes.getBody());*/
        
	return 'call';
    }
}