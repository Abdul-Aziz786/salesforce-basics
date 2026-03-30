@IsTest
public  class VowelCounterTest {
    @IsTest
    static void testCountVowels() {
        String input = 'Test';
        Integer actualCount = VowelCounter.countVowels(input);
        System.assertEquals(1, actualCount, 'The vowel count should be correct.');
    }
}