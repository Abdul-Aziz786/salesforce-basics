@IsTest
public  class DiscountCalculatorTest {
    @IsTest
    static void testCalculateDiscount() {
        Decimal discount20Percentage = DiscountCalculator.calculateDiscount(10000);
        Assert.areEqual(8000, discount20Percentage, 'Discount for 10000 with 20% should be 8000');
        Decimal discount10Percentage = DiscountCalculator.calculateDiscount(5000);
        Assert.areEqual(4500, discount10Percentage, 'Discount for 5000 with 10% should be 4500');
        Decimal discount5Percentage = DiscountCalculator.calculateDiscount(1000);
        Assert.areEqual(950, discount5Percentage, 'Discount for 1000 with 5% should be 950');
        Decimal discount0Percentage = DiscountCalculator.calculateDiscount(500);
        Assert.areEqual(500, discount0Percentage, 'Discount for 500 with 0% should be 500');
    }
}