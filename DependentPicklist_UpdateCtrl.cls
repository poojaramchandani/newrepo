public class DependentPicklist_UpdateCtrl {
    @AuraEnabled
	public static List<Account> getAccCityName(String city)
    {
        List<Account> accList = [Select Id,Name from Account where BillingCity=:city LIMIT 5];
        return accList;
    }
    
    @AuraEnabled
	public static Account getAccById(Id accid)
    {
        return[Select Id, Name, Phone, Email__c, BillingCity, BillingCountry from Account where Id=:accid];
        
    }
        @AuraEnabled
	public static Boolean deleteAccById(Id accid)
    {
        Account a = new Account();
        a.Id = accid;
        delete a;
        //System.debug('yesssji');
        return true;        
    }
     //@AuraEnabled
	/*public static List<String> imgadd(List<String> img)
    {
        for (String i : img) {
            [i].image = 'https://cdn.jsdelivr.net/npm/svg-country-flags@1.2.10/svg/' + countries[i].value.toLowerCase() + '.svg';        
    }*/
    
    @AuraEnabled
    public static void getCity()
    {
		String endpoint = 'https://api.countrystatecity.in/v1/countries';
        Http htp = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        System.debug(req.getEndpoint());
        req.setMethod('GET');
        System.debug(req);
        //HttpResponse res = http.send(req);
    }
    

    @AuraEnabled
    public static List<String> getCalloutResponseContents(String city)
    {
        Http h = new Http();
      
        HttpRequest req = new HttpRequest();
		req.setEndpoint('https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/'+city+'?unitGroup=metric&key=SNFQYH2Y6XY62ANYLN7E49QMX&contentType=json');
		System.debug(req);
        req.setMethod('GET');
        
        // Send the request, and return a response
		HttpResponse res = h.send(req);
        System.debug(res.getStatusCode());
		System.debug('response:--> ' + res.getBody());
       
        XmlStreamReader reader = res.getXmlStreamReader();
        String xm = reader.toString();
         List<String> name = xm.split(':');
        
        
        System.debug('name'+name);
	
         
        Map<String,Object> resultstring = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
        System.debug(resultstring);
        Map<String,String> fieldsdata = new Map<String,String>();
       
           System.debug(resultstring.get('address'));
           Object obj = resultstring.get('currentConditions');
            for(String strKey: resultstring.keyset())
            {
                fieldsdata.put(strKey, String.valueof(resultstring.get(strKey)));
            }
        	System.debug(fieldsdata);
        	String lst = fieldsdata.get('currentConditions');
        	String lst2 = fieldsdata.get('days');
        	System.debug(lst);
        	System.debug('d'+lst2);
        	System.debug(resultstring.get('datetime'));
        	lst = lst.remove('{');
        
        	List<String> strLst = lst.split(',=');

        	System.debug(strLst);
        	
        	return strLst;
       	//system.debug('jsonstring-->' + jsonstring);
     }
    
}