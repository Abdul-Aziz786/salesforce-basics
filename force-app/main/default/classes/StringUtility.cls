public class StringUtility {
    public static String reverseString (String input) {
        if (input == null) return null;
        String reversed ='';
        for (Integer i = input.length() - 1; i >= 0; i--) {
            reversed += input.substring(i, i+1);
        }
        return reversed;
    }
    
    public static Boolean isPalindrome(String input) {
        if (input == null) return false;
        String reversed = reverseString(input);
        return input.equalsIgnoreCase(reversed);
    }
}