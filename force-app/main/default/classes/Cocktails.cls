public class Cocktails {
    
    private static final String COCKTAILS_API = 'https://www.thecocktaildb.com';
    @AuraEnabled(cacheable=true)
    public static String getRandomCocktail(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(COCKTAILS_API+'/api/json/v1/1/search.php?f=a');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('Response '+response.getStatusCode());
        if(response.getStatusCode() == 200) {
            return response.getBody();
        }
        return '';
    }

    @AuraEnabled(cacheable=true)
    public static String getCocktailRecipe(Integer recipeId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(COCKTAILS_API+'/api/json/v1/1/lookup.php?i='+recipeId);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        System.debug('Response '+response.getStatusCode());
        if(response.getStatusCode() == 200) {
            return response.getBody();
        }
        return '';
    }

    @AuraEnabled(cacheable=true)
    public static String getSearchedCocktails(String ingredient){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(COCKTAILS_API+'/api/json/v1/1/search.php?s='+ingredient);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        System.debug('Response '+response.getStatusCode());
        if(response.getStatusCode() == 200) {
            return response.getBody();
        }
        return '';
    }
}