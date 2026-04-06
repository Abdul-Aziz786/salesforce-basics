Http api = new Http();
HttpRequest req = new HttpRequest();
req.setEndpoint('Callout:StripeAPI/v1/customers');
req.setMethod('POST');
String body = 'name=' + EncodingUtil.urlEncode('John Doe', 'UTF-8');
body += '&email=' + EncodingUtil.urlEncode('john@example.com', 'UTF-8');


req.setBody(body);

HttpResponse res = api.send(req);
System.debug(res.getBody());