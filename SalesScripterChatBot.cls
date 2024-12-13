public class SalesScripterChatBot {
    @AuraEnabled
    public static String detectIntent(String message) {
        if(String.isNotBlank(message)) {
            try{
                String endpoint = System.Label.ChatBotEndPoint;
                String body = 'message=' + EncodingUtil.urlEncode(message, 'UTF-8');
                
                HttpRequest req = new HttpRequest();
                req.setEndpoint(endpoint);
                req.setMethod('POST');
                req.setHeader('Content-Type', System.Label.ChatBotHeaderContentType);
                req.setHeader('referer', System.Label.ChatBotHeaderReferer);
                req.setBody(body);
                
                Http http = new Http();
                HttpResponse res = http.send(req);
                
                if (res.getStatusCode() == 200) {
                    Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                    String responsed = (String) responseMap.get('response');
                    if (responseMap.containsKey('intent')) {
        				Map<String, Object> intent = (Map<String, Object>) responseMap.get('intent');
        				if (intent.containsKey('displayName')) {
            				String displayName = (String) intent.get('displayName');
                            system.debug(displayName);
                            if (displayName == 'Default Fallback Intent'){
                                String endpoint1 = System.Label.ChatBotSaveIntentEndpoint;
								String query = 'query=' + EncodingUtil.urlEncode(message, 'UTF-8');                                
                                HttpRequest req1 = new HttpRequest();
                                req1.setEndpoint(endpoint1);
                                req1.setMethod('POST');
                                req1.setBody(query); 
                                
                                Http http1 = new Http();
                                HttpResponse res1 = http1.send(req1);
                                system.debug(res1.getStatusCode());
                            }
                        }
                    }
                    return responsed;
                } else {
                    return 'Callout failed with response: ' + res.getBody();
                }   
            } catch(Exception e){
            	throw new AuraHandledException(e.getMessage());
            }
        }
        return NULL;
    }
}