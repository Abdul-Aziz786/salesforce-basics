@IsTest
private class UserGreetingDiscountTest {
    @IsTest
    static void testGetDiscountByProfile() {
        Assert.areEqual(50, UserGreetingDiscount.getDiscountByProfile('SalesRep'));
        Assert.areEqual(60, UserGreetingDiscount.getDiscountByProfile('LeadMarketingRepTeam'));
        Assert.areEqual(0, UserGreetingDiscount.getDiscountByProfile('SupportUser'));
        Assert.areEqual(0, UserGreetingDiscount.getDiscountByProfile(null));
    }
}