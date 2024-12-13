public class SpoonacularApi {
    
    private static final String spoonacular_API = 'https://api.spoonacular.com';
    private static final String API_Key = '95389c04e76244e4b417b4465c56c52a';
    
    public static String getRandomRecipe(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(spoonacular_API+'/recipes/random?apiKey='+API_Key);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('response code ::--'+ response.getStatusCode());
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
   			 return response.getBody();
	    }
        return 'null';

    }
    
    public static String getRecipe(String recipeId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(spoonacular_API+'/recipes/'+recipeId+'/information?apiKey='+API_Key);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('response code ::--'+ response.getStatusCode());
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
   			 return response.getBody();
	    }
        return 'null';

    }
    
    public static String getRecipeByIngredient(String ingredients){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(spoonacular_API+'/recipes/findByIngredients?apiKey='+API_Key+'&ingredients='+ingredients);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('response code ::--'+ response.getStatusCode());
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
   			 return response.getBody();
	    }
        return 'null';

    }
}