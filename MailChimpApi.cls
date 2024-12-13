public class MailChimpApi {
    public static void callOut1(List<String> memberEmail, List<String> firstNm, List<String> lastNm){
       // memberEmail.add('pooja@anavcloudsoftwares.com');
        //memberEmail.add('vinay@anavcloudsoftwares.com');
        //String token = System.Label.MailchimpToken;
        //
        //one thing we can do is passing map and list of string key = mail id and value = list of string where we pass first name and last name value 
        //where we can consider that key and value size same that is passing nos of mail ids and first name and last name are same 
        
        if(!(memberEmail.isEmpty()) && memberEmail.size()>0){
         	for(String email : memberEmail){
                    String site = System.Label.MailchimpSite;
                    String listId = System.Label.MailchimpListId;
                    String firstn = 'Pooja';
                    String lastn = 'Ramchandani';
                    String body = '{'+
                        '  "email_address": "'+email+ '",'+
                        '  "status": "subscribed",'+
                        '  "merge_fields": {'+
                        '    "FNAME": "'+firstn+'",'+
                        '    "LNAME": "'+lastn+'"'+
                        '  }'+
                        '}'+
                        '';
                    
                    HttpRequest req = new HttpRequest();
                    req.setMethod('POST');
                    req.setEndpoint(System.Label.MailchimpSite+'/lists'+System.Label.MailchimpListId+'members');
                    req.setHeader('Content-Type', 'application/json');
                	req.setHeader('Authorization', 'Bearer'+System.Label.MailchimpToken);
                    req.setBody(body);
                    
                    Http http = new Http();
                    HTTPResponse res = http.send(req);
                    if(res.getStatusCode()==200){
                        system.debug('Members Created');
						body = '{'+
                                '    "type":"regular",'+
                                '    "recipients":{"list_id":"a85aa6cc82"},'+
                                '    "settings":'+
                                '    {'+
                                '        "subject_line":"Test Campaign Subject",'+
                                '        "template_id": 10558058,'+
                                '        "preview_text": "Preview Text",'+
                                '        "reply_to":"pooja@anavcloudsoftwares.com",'+
                                '        "from_name":"Pooja"'+
                                '    }'+
                                ''+
                                 '}';
                        req = new HttpRequest();
                        req.setMethod('POST');
                        req.setEndpoint(System.Label.MailchimpSite+'/campaigns');
                        req.setHeader('Content-Type', 'application/json');
                        req.setHeader('Authorization', 'Bearer'+System.Label.MailchimpToken);
                        req.setBody(body);
                        http = new Http();
                    	res = http.send(req);
                        if(res.getStatusCode()==200){
                            system.debug('campaign created');
                        }
            		}
            }
        }
/*camapign making
{
    "type":"regular",
    "recipients":{"list_id":"a85aa6cc82"},
    "settings":
    {
        "subject_line":"Test Campaign Subject",
        "template_id": 10558058,
        "preview_text": "Preview Text",
        "reply_to":"pooja@anavcloudsoftwares.com",
        "from_name":"Pooja"
    }

}

members making
{
    "type":"regular",
    "recipients":{"list_id":"a85aa6cc82"},
    "settings":
    {
        "subject_line":"Test Campaign Subject",
        "template_id": 10558058,
        "preview_text": "Preview Text",
        "reply_to":"pooja@anavcloudsoftwares.com",
        "from_name":"Pooja"
    }

}
*/
                    
    }

}