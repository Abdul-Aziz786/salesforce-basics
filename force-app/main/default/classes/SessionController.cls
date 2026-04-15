public class SessionController {
    
    public String sessionId { get; set; }
    
    public void fetchSessionId() {
        try {
            SforceService.SforceServiceSoap binding = new SforceService.SforceServiceSoap();
            binding.endpoint_x = 'https://login.salesforce.com/services/Soap/u/60.0';
            
            String password = Constants.PASSWORD ;
            SforceService.LoginResult result =
                binding.login(Constants.USERNAME, password);
            
            sessionId = result.sessionId;
            
        } catch (Exception e) {
            sessionId = 'Error: ' + e.getMessage();
        }
    }
}