public class HttpCalloutSample {

  // Pass in the endpoint to be used using the string url
  public static String getCalloutResponseContents(String city) {

    // Instantiate a new Http object
    Http h = new Http();

     // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
    HttpRequest req = new HttpRequest();
    req.setEndpoint('https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/'+city+'?unitGroup=metric&key=SNFQYH2Y6XY62ANYLN7E49QMX&contentType=json');
    req.setMethod('GET');

    // Send the request, and return a response
    HttpResponse res = h.send(req);
      System.debug(res.getBody());
    return res.getBody();
      
  }
}