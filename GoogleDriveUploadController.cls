public with sharing class GoogleDriveUploadController {
    private static final Integer CHUNK_SIZE = 10 * 1024 * 1024; // 10 MB

   /* @AuraEnabled
    public static String uploadFile(String fileName, Blob fileContent) {
        Integer fileSize = fileContent.size();
        Integer offset = 0;

        String uploadSessionId = initiateUploadSession(fileName);
        while (offset < fileSize) {
            Integer chunkSize = Math.min(CHUNK_SIZE, fileSize - offset);
            Blob chunk = fileContent.substring(offset+'', (offset + chunkSize)+'');
            uploadChunk(uploadSessionId, chunk, offset, chunkSize);
            offset += chunkSize;
        }

        return completeUploadSession(uploadSessionId);
    }*/

    private static String initiateUploadSession(String fileName) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:GoogleDrive/upload/drive/v3/files?uploadType=resumable');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json; charset=UTF-8');
        req.setHeader('Authorization', 'Bearer ' + getAccessToken());

        String body = '{"name": "' + 'test' + '"}';
        req.setBody(body);

        Http http = new Http();
        HttpResponse res = http.send(req);
        return res.getHeader('Location');
    }

    private static void uploadChunk(String uploadSessionId, Blob chunk, Integer offset, Integer chunkSize) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(uploadSessionId);
        req.setMethod('PUT');
        req.setHeader('Content-Range', 'bytes ' + offset + '-' + (offset + chunkSize - 1) + '/' + chunkSize);
        req.setHeader('Content-Length', String.valueOf(chunkSize));
        req.setHeader('Authorization', 'Bearer ' + getAccessToken());
        req.setBodyAsBlob(chunk);

        Http http = new Http();
        HttpResponse res = http.send(req);
        if (res.getStatusCode() != 200 && res.getStatusCode() != 201) {
            throw new CalloutException('Failed to upload chunk. Status: ' + res.getStatus());
        }
    }

    private static String completeUploadSession(String uploadSessionId) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(uploadSessionId);
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + getAccessToken());

        Http http = new Http();
        HttpResponse res = http.send(req);
        if (res.getStatusCode() == 200) {
            return res.getBody();
        } else {
            throw new CalloutException('Failed to complete upload session. Status: ' + res.getStatus());
        }
    }

    private static String getAccessToken() {
        // Implement logic to get access token from Named Credential or OAuth token storage
        return 'YOUR_ACCESS_TOKEN';
    }
}