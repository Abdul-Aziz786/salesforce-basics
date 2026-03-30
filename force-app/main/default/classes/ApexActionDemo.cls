public class ApexActionDemo {
    @InvocableMethod(label = 'Split CheckboxGroup Values' Description = 'Split CheckboxGroup Selected Values')
    public static List<List<String>> getCheckboxGroupValues(List<String> values) {
        List<String> selectedVales = values[0].split(';');
        
        List<List<String>> output = new List<List<String>>();
        output.add(selectedVales);
        return output;
    }
}