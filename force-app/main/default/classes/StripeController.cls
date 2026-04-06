public with sharing class StripeController {
    @future(callout=true)
    public static void createCustomerInStripe(String name, String email,Id contactId) {
        try {
            Http api = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('Callout:StripeAPI/v1/customers');
            req.setMethod('POST');
            String body = 'name=' + EncodingUtil.urlEncode(name, 'UTF-8');
            body += '&email=' + EncodingUtil.urlEncode(email, 'UTF-8');
            req.setBody(body);
            HttpResponse res = api.send(req);
            System.debug(res.getBody());
            
            if(res.getStatusCode() == 200) {
                String responseBody = res.getBody();
                Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
                String stripeCustomerId = (String) data.get('id');
                
                Contact contactToUpdate = new Contact(Id = contactId, Customer_Stripe_Id__c = stripeCustomerId);
                update contactToUpdate;
            } else {
                System.debug('Failed to create customer in Stripe. Status code: ' + res.getStatusCode());
            }
        } catch (Exception e) {
            System.debug('Error creating customer in Stripe: ' + e.getMessage());
            
        }
        
    }
    
    @future(callout=true)
    public static void updatePaymentLinkInOpportunity(String amount, String oppName, String oppId) {
        final String priceId = createProductInStripe(oppName, amount);
        if (priceId == null) {
            return;
        }
        final Map<String, String> paymentLink = createPaymentLink(priceId, '1');
        if (paymentLink == null) {
            return;
        }
        Opportunity oppToUpdate = new Opportunity(Id = oppId,
        StripePaymentLink__c = paymentLink.get('url'),
        StripePaymentLinkId__c = paymentLink.get('id'));
        update oppToUpdate;
    }
    
    public static String createProductInStripe(String name, String oppAmount) {
        try {
            Http api = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('Callout:StripeAPI/v1/products');
            req.setMethod('POST');
            String body = 'name=' + EncodingUtil.urlEncode(name, 'UTF-8');
            body += '&active=' + EncodingUtil.urlEncode('true', 'UTF-8');
            body += '&default_price_data[currency]=' + EncodingUtil.urlEncode('USD', 'UTF-8');
            body += '&default_price_data[unit_amount]=' + EncodingUtil.urlEncode(oppAmount, 'UTF-8');
            req.setBody(body);
            HttpResponse res = api.send(req);
            System.debug(res.getBody());
            
            if(res.getStatusCode() == 200) {
                String responseBody = res.getBody();
                Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
                return (String) data.get('default_price');
            } else {
                System.debug('Failed to create product in Stripe. Status code: ' + res.getStatusCode());
                return null;
            }
        } catch (Exception e) {
            System.debug('Error creating product in Stripe: ' + e.getMessage());
            return null;
        }
    }
    
    public static Map<String, String> createPaymentLink(String priceId, String quantity) {
        try {
            Http api = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('Callout:StripeAPI/v1/payment_links');
            req.setMethod('POST');
            String body = 'line_items[0][price]=' + EncodingUtil.urlEncode(priceId, 'UTF-8');
            body += '&line_items[0][quantity]=' + EncodingUtil.urlEncode(quantity, 'UTF-8');
            req.setBody(body);
            HttpResponse res = api.send(req);
            System.debug(res.getBody());
            
            if(res.getStatusCode() == 200) {
                String responseBody = res.getBody();
                Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
                Map<String, String> result = new Map<String, String>();
                result.put('id', (String) data.get('id'));
                result.put('url', (String) data.get('url'));
                return result;
            } else {
                System.debug('Failed to create payment link in Stripe. Status code: ' + res.getStatusCode());
                return null;
            }
        } catch (Exception e) {
            System.debug('Error creating payment link in Stripe: ' + e.getMessage());
            return null;
        }
    }
    
    
}