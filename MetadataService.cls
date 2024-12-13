public without sharing class MetadataService implements Metadata.DeployCallback{
    public List<FieldWrapper> listField{get;set;}
    public class FieldWrapper
    {
        public String fieldName {get; set;}
        public String fieldAPIName {get; set;}
    }
   
    public static String updateCustomMetadata()
    {
        try {
        Google_Drive_Access_Tokens__mdt tcm = getMetaDataRecords()[0]; //retrieving custom metadata records, using the first.
        Id customMetadataId = tcm.Id;
        system.debug('CustomMetadata Id ' + customMetadataId);
        Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
        customMetadata.fullName = 'Test_Custom_Metadata.Before_Change'; //custom metadata name
        customMetadata.label = 'Before_Change';
        // customMetadata.id = customMetadataId;
        Metadata.CustomMetadataValue customField1 = new Metadata.CustomMetadataValue(); //the values you're changing/updating
        customField1.field = 'Custom_Field_1__c'; //the custom field API Name that you're wanting to insert/update a value of
        customField1.value = 'FIeld Test 1 after';
        customMetadata.values.add(customField1);//add the changes to list of changes to be deployed
       
        // if(customMetadataId != null) //if a custom metadata record exists, add the id here
        // {
        //     Metadata.CustomMetadataValue customId = new Metadata.CustomMetadataValue();
        //     customId.field = 'Id';
        //     customId.value = customMetadataId;
        //     customMetadata.values.add(customId);
        // }
        
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(customMetadata);
        
        //MetadataDeploy callback = new MetadataDeploy();
        // Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, null);
        
        //Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
        
        //system.debug('jobId is ' + jobId);
        
        // Metadata.DeployContainer metaDeploy1 = new Metadata.DeployContainer();
        // metaDeploy1.addMetadata(approvalConfigToInsert);
        // Id AsynchResult1 = Metadata.Operations.enqueueDeployment(metadeploy1, null);
        // system.debug('jobId ' + mdContainer);
        return 'Success';
            
        } catch (Exception e) {
                return e.getMessage();
        }
        }
        public static list<Google_Drive_Access_Tokens__mdt> getMetaDataRecords()
        {
            list<Google_Drive_Access_Tokens__mdt> tcm = [Select Id, label FROM Google_Drive_Access_Tokens__mdt];
            return tcm;
        }
       
    
        // find all sObjects available in the organization
        public void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
            if(result.status == Metadata.DeployStatus.SUCCEEDED)
            {
                //success
                System.debug(' ===>'+ result);
            }else{
                //not success
                System.debug(' ===> fail '+ result);
            }
            
        }

}