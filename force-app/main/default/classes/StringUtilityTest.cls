@IsTest
public  class StringUtilityTest {
    @IsTest
    static void testReverseString() {
        String result = StringUtility.reverseString('Hello');
        System.Assert.areEqual('olleH', result, 'The reverse of "Hello" should be "olleH"');
    }
    
    @IsTest
    static void testIsPalindrome() {
        Boolean result1 = StringUtility.isPalindrome('Madam');
        System.Assert.isTrue(result1, '"Madam" should be  palindrome');
        Boolean result2 = StringUtility.isPalindrome('Hello');
        System.Assert.isFalse(result2, '"Hello" should not a palindrome');
    }
}