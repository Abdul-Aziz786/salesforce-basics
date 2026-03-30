@IsTest
public class MathUtilTest {
    @IsTest
    static void testAdd() {
        Assert.areEqual(5, MathUtill.addNumbers(2, 3), 'Adding 2 and 3 should return 5');
    }
    
    @IsTest
    static void testIsEven() {
        Assert.isTrue(MathUtill.isEven(4), '4 should be even');
        Assert.isFalse(MathUtill.isEven(5), '5 should not be even');
    }
}