@IsTest
private class ArithmeticTest {
    @IsTest
    static void testAdd() {
        Integer result = Arithmetic.add(2, 3);
        System.assertEquals(5, result);
    }
    
    @IsTest
    static void testSubtract() {
        Integer result = Arithmetic.subtract(5, 3);
        System.assertEquals(2, result);
    }
    
    @IsTest
    static void testMultiply() {
        Integer result = Arithmetic.multiply(2, 3);
        System.assertEquals(6, result);
    }
    
    @IsTest
    static void testDivision() {
        Integer result = Arithmetic.division(6, 3);
        System.assertEquals(2, result);
    }
}