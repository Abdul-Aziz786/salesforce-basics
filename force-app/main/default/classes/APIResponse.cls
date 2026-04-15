global with sharing class APIResponse {
    public Boolean success;
    public String message;
    public Object data;
    
    public APIResponse() {
        this.success = false;
        this.message = '';
        this.data = null;
    }
}