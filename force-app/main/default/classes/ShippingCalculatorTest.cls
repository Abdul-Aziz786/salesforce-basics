@IsTest
public   class ShippingCalculatorTest {
    @IsTest
    static  void testCalculateShipping() {
        Decimal shippingCharge1 = ShippingCalculator.calculateShipping(0, 'Local');
        System.assertEquals(0, shippingCharge1, 'Shipping charge should be 0 for weight 0 and local destination.');
        
        Decimal shippingCharge2 = ShippingCalculator.calculateShipping(3, 'Local');
        System.assertEquals(50, shippingCharge2, 'Shipping charge should be 50 for weight 3 and local destination.');
        
        Decimal shippingCharge3 = ShippingCalculator.calculateShipping(7, 'Local');
        System.assertEquals(100, shippingCharge3, 'Shipping charge should be 100 for weight 7 and local destination.');
        
        Decimal shippingCharge4 = ShippingCalculator.calculateShipping(15, 'Local');
        System.assertEquals(200, shippingCharge4, 'Shipping charge should be 200 for weight 15 and local destination.');
        
        Decimal shippingCharge5 = ShippingCalculator.calculateShipping(25, 'Local');
        System.assertEquals(500, shippingCharge5, 'Shipping charge should be 500 for weight 25 and local destination.');
        
        Decimal shippingCharge6 = ShippingCalculator.calculateShipping(3, 'Non-Local');
        System.assertEquals(200, shippingCharge6, 'Shipping charge should be 200 for weight 3 and non-local destination.');
        
        Decimal shippingCharge7 = ShippingCalculator.calculateShipping(-5, 'Local');
        System.assertEquals(0, shippingCharge7, 'Shipping charge should be 0 for negative weight and local destination.');
    }
}