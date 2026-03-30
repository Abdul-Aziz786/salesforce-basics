@IsTest
private class MathUtilityDIYTest {
    @IsTest
    static void testPrivateMathMethods() {
        Assert.areEqual(9, MathUtilityDIY.add(4, 5), 'Should be 9');
        Assert.areEqual(20, MathUtilityDIY.multiply(4, 5), 'Should be 20');
        Assert.areEqual(-1, MathUtilityDIY.subtract(4, 5), 'Should be -1');
    }
}