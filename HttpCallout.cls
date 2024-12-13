public class HttpCallout {
    @future(callout=true)
    public static void makeCalloutFuture(String Endpoint, String Method, String Body, Map<String,String> headers){
        try{
            System.debug('Endpoint'+ Endpoint);
            System.debug('Method'+ Method);
            System.debug('Body'+ Body);
            System.debug('headers'+ headers);
            HttpRequest request = new HttpRequest();
            request.setEndpoint(Endpoint);
            request.setMethod(Method);
            if(Body != ''){
                request.setBody(Body);
            }
            for(String key: headers.keySet()){
                request.setHeader(key, headers.get(key));
            }
            Http http = new Http();
            HttpResponse response = http.send(request);
            System.debug('CODE++++++'+response.getStatusCode());
            System.debug(response.getBody());
            if (response != NULL && response.getStatusCode() != NULL && response.getStatusCode() == 200) {
                
               
                // return response.getBody();
            }
            else{
                
             system.debug('Exception');
            }
            
        } catch(Exception e) {
            
            system.debug('Exception'+e);
        }
    }
}