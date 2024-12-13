public class CalloutForOneDrive {
    @future(callout=true)
    public static void callout(){
        
        try{
            List<ContentVersion> contVerData = [SELECT Id, ContentDocumentId, IsLatest, ContentUrl, ContentBodyId, VersionData, Title FROM ContentVersion WHERE ContentDocumentId = '0695i00000Ntg4bAAB'];
            String fileName=EncodingUtil.URLENCODE(contVerData[0].Title,'UTF-8').replace('+', '%20');
            String endpoint = 'https://graph.microsoft.com/v1.0/me/drive/root:/NewFolderForImages/{filenm}:/content';
            endpoint = endpoint.replace('{filenm}',fileName+'.jpeg');
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setMethod('PUT');
            request.setEndpoint(endpoint);
            request.setHeader('Authorization', 'Bearer EwBwA8l6BAAUbDba3x2OMJElkF7gJ4z/VbCPEz0AAZ6H9Qbp9ybvp1xSkpqzD3JkUYZyGqNrNaOyvjbW30%2b1yitCEW2ou9GFc9UihJSOdmYhdT9%2bVhePjUnb4WQilHlbHh2WPMXpnBkGaNzKcoKhwTYjOcVjJhb/MEFAN82a4fN98B61Y0w/OTQxLekSF3JI7PQ9DotOM1aSDFIbcVZAP/30a4Up7D2sJtHr%2bLE8%2bbi2gidJ7jTYJQXwOrp99QvwO/j%2bYIk27YQTT8GRbngiAAEJslgpf2RMFm6hmfKctp2zM8GCnWmNc5EksESEW6OzGy9xgCGE/Luebdahy73GT54Ko66RqMAnlPcI1I2Dc3dmOswzsnISycYB7GSQ1R8DZgAACOgWPPmkTY4aQAJJ6dMnEYv9AUGsuEzxOUk1y0A3cKu6X3pVioQehO2VoN/2UqaBA7/t5ugL571WwSweYZhEgjepxrJdQIQawQlGAkKEb3DZnZQsckk4IKkGSwFPNsH2YaW5uBNd9bKsu0kdk%2byQMEnHofarDWJLTWPRk0thUPKo1aWG6IQPVzY74v32UIkdY55HpLLe6HEkZsVAgQ9YXM45sZbdPTUTkwp2ZlV0mYRv3c4I8fSbBDeE0d%2bZraygNeFaU1hWe9MHvz1df2pN5jfEK5jJR/X7xyuSKP5S2hjeMkwUq2AkxllcBaiVOQlrrps1j0iAKSo30R8tEko2iPM1iZUFWxygtXJitf6JKJC9eyN6FHVxt6trljp8z1jAzdeVTBPvEhktbH1ZWVhr%2bMsO0hUnlC9Icmt28EjT662njRp8yN2wT1kvwYJkNWKz22w5IYhzJ5wBP62LtJbMbx31zNVfb4B%2bNJDuHU4x5fS10zfPXnkVAFjz1CDEAtjD6WPRvCi3Qq/BiRqFr8kK9bWeke9MRgEdh56XJE7GdEh3xvF76Y%2bMQgI/BLRHJ3A1p41Gan48fgw275AgT1mUVyIbhbR1cvpqJ5nQL%2bGoq4hbDOTy0uGVtH2s/UMOrpeBSc//K40UdMIPF0r9lvQmhJta9DDBWEHtYluhXdVvFff%2bnf7R9dQWYoRS04d9l/iJUAJVcEKxnDej%2blGDh7SktgRqdUo2XtPAZrb87JUcFWDUQPGLoPbI8MD98VO8MtR%2bUwaeYfJO%2bwYPD7B8Ag%3d%3d');
            request.setHeader('Content-Type', 'image/jpeg');
            request.setHeader('accept', 'application/json');
            request.setBodyAsBlob(contVerData[0].VersionData);
            request.setTimeout(120000);
            //request.setBody(EncodingUtil.base64Encode(contVerData[0].VersionData));
            HttpResponse response = http.send(request);
            system.debug(response);
        }catch(System.CalloutException e){
            system.debug(e);
            system.debug(e.getLineNumber());
        }
    }
}