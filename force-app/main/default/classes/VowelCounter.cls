public  class VowelCounter {
    public static Integer countVowels(String input) {
        Integer count = 0;
        String vowels = 'AEIOUaeiou';
        
        for (Integer i = 0; i < input.length(); i++) {
            if (vowels.contains(input.substring(i, i + 1))) {
                count++;
            }
        }
        
        return count;
    }
}