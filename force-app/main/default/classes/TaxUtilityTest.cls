@IsTest
private class TaxUtilityTest {
    @IsTest
    static void testCalculateTaxNull() {
        Assert.areEqual('No Tax', TaxUtility.calculateTax(null));
        Assert.areEqual('No Tax', TaxUtility.calculateTax(0));
    }
    
    @IsTest
    static void testCalculateTax() {
        Assert.areEqual(300000, Decimal.valueOf(TaxUtility.calculateTax(1000000)));
        Assert.areEqual(100000, Decimal.valueOf(TaxUtility.calculateTax(500000)));
        Assert.areEqual(25000, Decimal.valueOf(TaxUtility.calculateTax(250000)));
        Assert.areEqual(0, Decimal.valueOf(TaxUtility.calculateTax(100000)));
    }
}