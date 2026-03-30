public class MathUtilityDIY {
    @TestVisible
    private static Integer add(Integer firstNumber, Integer secondNumber) {
        return firstNumber + secondNumber;
    }
    
    @TestVisible
    private static Integer multiply(Integer firstNumber, Integer secondNumber) {
        return firstNumber * secondNumber;
    }
    
    @TestVisible
    private static Integer subtract(Integer firstNumber, Integer secondNumber) {
        return firstNumber - secondNumber;
    }
}