public class DIYDynamicSOQL {
    public static void demo() {
        List<String> fields = new List<String>{'FirstName__c', 'Position__c', 'Salary__c'};
        List<Employee__c> records = searchRecords('Employee__c', fields);
        System.debug(records);
        
        List<Employee__c> filteredRecords = searchRecords('Employee__c', fields, 'Salary__c', '>', 1000);
        System.debug(filteredRecords);
    }
    
    public static List<SObject> searchRecords(String objectName, List<String> fieldNames) {
        String query = 'SELECT ' + String.join(fieldNames, ', ') + ' FROM ' + objectName;
        return Database.query(query);
    }
    
    public static List<SObject> searchRecords(
        String objectName,
    List<String> fieldNames,
    String searchField,
    String operator,
    Decimal value) {
        String query = 'SELECT ' + String.join(fieldNames, ', ') + ' FROM ' + objectName +
            ' WHERE ' + searchField + ' ' + operator + ' ' + value;
        return Database.query(query);
    }
}