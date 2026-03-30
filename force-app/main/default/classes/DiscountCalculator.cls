public class DiscountCalculator {
    public static Decimal calculateDiscount(Decimal amount) {
        if (amount <= 0) return 0;
        Decimal discountPercent;
        if (amount>=10000) {
            discountPercent = 20;
        } else if (amount >= 5000) {
            discountPercent = 10;
        } else if (amount >= 1000) {
            discountPercent = 5;
        } else {
            discountPercent = 0;
        }
        return amount - (amount * discountPercent / 100);
    }
}