@RestResource(urlMapping='/myurlclass/*')
Global class MyAPIController{
	
    @HttpPost
    /*Global static String dataCreation(String name){
        
        Account acc = new Account();
        acc.name=name;
        insert acc;
        return name;
    }*/
    
    Global static Account getAcc(Id accid){
        Account acc = [select Id, Name from Account where Id=:accid];
        return acc;
    }
}