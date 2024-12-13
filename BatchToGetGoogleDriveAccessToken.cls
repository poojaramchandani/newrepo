public class BatchToGetGoogleDriveAccessToken implements Database.Batchable<sObject>, Database.stateful, Database.AllowsCallouts, Schedulable{
    public Database.QueryLocator start(Database.BatchableContext BC){
        return null;
    }
    
    public void execute(Database.BatchableContext BC, List<User> scope){
        
    }
    
    public void finish(Database.BatchableContext BC){
        
    }
    
    public void execute(SchedulableContext sc) {   
    
    }    
}