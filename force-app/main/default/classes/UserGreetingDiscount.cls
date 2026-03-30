public class UserGreetingDiscount {
    public static Integer getDiscountByProfile(String profileName) {
        if (profileName == 'SalesRep') {
            return 50;
        }
        if (profileName != null && profileName.contains('MarketingRep')) {
            return 60;
        }
        return 0;
    }
}