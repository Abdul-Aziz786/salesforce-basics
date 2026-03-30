@isTest
public  class OrderDiscountCalculatorTest {
    @IsTest
    static void testCalculateFinalAmount() {
        Decimal result1 = OrderDiscountCalculator.calculateFinalAmount(500, 'Regular', null);
        System.assertEquals(500, result1, 'Expected final amount to be 500');
        
        Decimal result2 = OrderDiscountCalculator.calculateFinalAmount(1000, 'VIP', null);
        System.assertEquals(900, result2, 'Expected final amount to be 900');
        
        Decimal result3 = OrderDiscountCalculator.calculateFinalAmount(2000, 'Premium', 'SUMMER10');
        System.assertEquals(1640, result3, 'Expected final amount to be 1640');
        
        Decimal result4 = OrderDiscountCalculator.calculateFinalAmount(5000, 'VIP', 'SUMMER10');
        System.assertEquals(3750, result4, 'Expected final amount to be 3750');
        
        Decimal result5 = OrderDiscountCalculator.calculateFinalAmount(20000, 'VIP', 'SUMMER10');
        System.assertEquals(13000, result5, 'Expected final amount to be 13000');
        
        Decimal result6 = OrderDiscountCalculator.calculateFinalAmount(-100, 'Regular', null);
        System.assertEquals(0, result6, 'Expected final amount to be 0');
    }
}