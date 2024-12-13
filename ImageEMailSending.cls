public class ImageEMailSending {
	public static void imageSend(){
        String link1 = 'https://us-east-1.online.tableau.com/#/site/sci/views/JustEnergyICDView/CUSTOMERSACQUIREDORGView';
        
        HttpRequest req = new HttpRequest();         
        Http http = new Http();         
        HttpResponse res = new HttpResponse(); 
        req.setMethod('POST');         
        req.setEndPoint('https://us-east-1.online.tableau.com/api/3.18/auth/signin'); 
        req.setBody('{'+ 
                    
                    '	"credentials": {'+ 
                    
                    '		"personalAccessTokenName": "Anavcloud",'+ 
                    
                    '		"personalAccessTokenSecret": "sF0gmX9hRJ6guXsdToOXqg==:CUNdO3cjnoER9GIxJZk6ejURPrddHsrb",'+ 
                    
                    '		"site": {'+ 
                    
                    '			"contentUrl": "sci"'+ 
                    
                    '		}'+ 
                    
                    '	}'+ 
                    
                    '}'); 
        req.setHeader('Content-Type','application/json');
        req.setHeader('accept','application/json'); 
        res = http.send(req); 
        System.debug(res.getStatusCode()); 
        
        if(res.getStatusCode()==200){ 
            System.debug(res.getBody()); 
            
            Map<String, Object> response = (Map<String, Object>)JSON.deserializeUntyped(res.getBody()); 
            String returnurl = String.valueOf(response.get('credentials')); 
            system.debug(returnurl); 
            String token = returnurl.substring(returnurl.lastIndexOf('token'), returnurl.lastIndexOf(',')); 
            String siteId = returnurl.split(',')[2]; 
            siteId = siteId.split('}')[0];
            siteId = siteId.split('=')[1];
            system.debug(token); 
            system.debug(siteId); 
            token = token.split('=')[1]; 
            system.debug(token); 
            
            HttpRequest req2 = new HttpRequest(); 
            Http http2 = new Http(); 
            HttpResponse res2 = new HttpResponse(); 
            req2.setMethod('GET'); 
            req2.setEndpoint('https://us-east-1.online.tableau.com/api/3.18/sites/'+siteId+'/workbooks/');
            req2.setHeader('Authorization', 'Bearer '+token); 
            req2.setHeader('Content-Type','application/json'); 
            req2.setHeader('accept','application/json'); 
            res2 = http2.send(req2); 
            
            System.debug(res2.getStatusCode());    
            if(res2.getStatusCode()==200){ 
                system.debug(res2.getBody());
                Map<String, Object> response2 = (Map<String, Object>)JSON.deserializeUntyped(res2.getBody()); 
                String respValue = String.valueOf(response2.get('workbooks')); 
                system.debug(respValue);
                Map<String, Object> workbookVal = (Map<String, Object>)response2.get('workbooks');
                system.debug(workbookVal);
                List<Object> workbookVal2 = (List<Object>)workbookVal.values();
                system.debug(workbookVal2);
                String workbookVal3 = JSON.serialize(workbookVal2);
                system.debug(workbookVal3);
                String wrkbknm = 'Just Energy (ICD View)';
                String link = link1;
                link = link.split('/')[7];
                system.debug(link);
                Integer index = workbookVal3.indexOf(wrkbknm)+wrkbknm.length();
                system.debug(index);
                workbookVal3 = workbookVal3.substring(index);
                system.debug(workbookVal3);
                String idVal = workbookVal3;
                system.debug(idVal);
                idVal = idVal.split('\"')[4];
                system.debug(idVal);
                
                HttpRequest req3 = new HttpRequest(); 
                Http http3 = new Http(); 
                HttpResponse res3 = new HttpResponse(); 
                req3.setMethod('GET'); 
                req3.setEndpoint('https://us-east-1.online.tableau.com/api/3.18/sites/'+siteId+'/workbooks/'+idVal);
                req3.setHeader('Authorization', 'Bearer '+token); 
                req3.setHeader('Content-Type','application/json'); 
                req3.setHeader('accept','application/json'); 
                res3= http3.send(req3); 
                
                System.debug(res3.getStatusCode()); 
                if(res3.getStatusCode()==200){ 
                    System.debug(res3.getBody()); 
                    Map<String, Object> response3 = (Map<String, Object>)JSON.deserializeUntyped(res3.getBody()); 
                    Map<String, Object> views = (Map<String, Object>)response3.get('workbook');
                    system.debug(views);
                    List<Object> viewsVals = (List<Object>)views.values();
                    String viewsVals2 = JSON.serialize(viewsVals);
                    system.debug(viewsVals2);
                    String link2 = link1.split('/')[8];
                    system.debug(link2);
                    Integer indexView = viewsVals2.indexOf(link2)+link2.length();
					Integer indexView1 =  viewsVals2.indexOf('COMMODITIESSOLDORGView');                  
                    viewsVals2 = viewsVals2.substring(indexView);
                    system.debug(viewsVals2);
                    String viewsVals3 = viewsVals2;
                    viewsVals3 = viewsVals3.split('id')[1];
                    viewsVals3 = viewsVals3.split('\"')[2];
                    system.debug(viewsVals3);
                    
                    HttpRequest req4 = new HttpRequest(); 
                    Http http4 = new Http(); 
                    HttpResponse res4 = new HttpResponse(); 
                    req4.setMethod('GET'); 
                    req4.setEndpoint('https://us-east-1.online.tableau.com/api/3.18/sites/'+siteId+'/views/'+viewsVals3+'/image');
                    system.debug(req4.getEndpoint());
                    req4.setHeader('Authorization', 'Bearer '+token); 
                    req4.setHeader('Content-Type','application/json'); 
                    req4.setHeader('accept','application/json'); 
                    res4= http4.send(req4);
                    if(res4.getStatusCode()==200){ 
                        System.debug(res4.getBody()); 
                        Map<String, Object> response4 = (Map<String, Object>)JSON.deserializeUntyped(res.getBody()); 
                        blob image1 = res4.getBodyAsBlob(); 
                        System.debug(image1); 
                        String urlOrg = URL.getOrgDomainUrl().toExternalForm();
						String orgId = (UserInfo.getOrganizationId());
						Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setToAddresses(new String[] { 'ramchandanipooja18@gmail.com' });
                        mail.setSubject('Test Subject');
                        mail.setPlainTextBody('Test Body');
                        Document getDoc = [SELECT Id,Name, Body, BodyLength, ContentType FROM Document WHERE Id=:'0152w0000029sKQ'];
                        mail.setHtmlBody('<html><body>Here is an inline image:<br><img src="'+urlOrg+'/servlet/servlet.ImageServer?id='+getDoc.Id+'&oid='+orgId+'" ></body></html>');
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                        
                    }
                }
            } 
        } 
    }
}