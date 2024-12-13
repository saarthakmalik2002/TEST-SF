public class RestAPIMulesoft {
    public static void callMuleAPI(){
        Http http= new HTTP();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setEndpoint('http://login.salesforce.com');
        req.setMethod('POST');
        Map<string,string> body= new Map<string,string>();
        body.put('x','5');
        body.put('y','5');
        String jsonString= JSON.serialize(body);
        req.setBody(jsonString);
        req.setHeader('Content-Type','application/json');
        res = http.send(req);
        System.debug(res.getBody());
     }

}