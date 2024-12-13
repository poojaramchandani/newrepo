public class CurrencyConverter {
     
    @AuraEnabled
    public static String getCurrency(String sourceCode,String targetCode) {
        String url = 'https://globalcurrencies.xignite.com/xGlobalCurrencies.json/GetRealTimeRate?Symbol=';
        url += sourceCode+targetCode+'&_token=YOURTOKEN';
         
        // Instantiate a new http object
        Http http = new Http();
         
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
         
        HttpResponse res = new HttpResponse();
         
        // Send the request, and return a response
        if((sourceCode != null && sourceCode.trim().length() > 0) && (targetCode != null && targetCode.trim().length() > 0))
            res = http.send(req);
        else
            return null;
         
        Map<String, Object> response = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        String text = (String)response.get('Text');
                 
        return text;
    }
    
    
    @AuraEnabled
    public static String calloutCurrency() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://v6.exchangerate-api.com/v6/ff6c447b5977cf947741f741/latest/USD');
        req.setMethod('GET'); 
        Http http = new Http();
        HTTPResponse res = http.send(req);
        //System.debug(res.getBody());
        return res.getBody();
        
        //Map<String,Object> resultstring = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
        //System.debug(resultstring);
        //System.debug(resultstring.get('address'));
    }
    
    @AuraEnabled
    public static Double conversion(String str1, String str2, Integer i4)
    {
        String s = calloutCurrency();
        Object s1,s2 ;
        //System.debug(s);
       Double i, i1, i2,i3;
        Map<String,Object> resultstring = (Map<String,Object>)JSON.deserializeUntyped(s);
        
        if(resultstring.containsKey('conversion_rates')){
            Object obj = resultstring.get('conversion_rates');
            Map<String,Object> temp = (Map<String,Object>)JSON.deserializeUntyped(JSON.serialize(obj));
            System.debug(temp.get(str1));
            S1 = temp.get(str1);
            s2 = temp.get(str2);
        }
        String strJSON = JSON.serialize(s1);
      	 String strJSON2 = JSON.serialize(s2);
        
        i3 = Double.valueOf(i4);
        i1 = Double.valueOf(strJSON);
        i2 = Double.valueOf(strJSON2);
        i=(i4/1)*(i1/i2);
        return i;
            
    }
       

}