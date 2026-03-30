public class OrderDiscountCalculator {
    public static Decimal calculateFinalAmount(Decimal orderAmount,
    String customerType,
    String promoCode) {
        if (orderAmount <= 0) return 0;
        Decimal discount = 0;
        if (orderAmount >= 10000) {
            discount += 20;
        } else if (orderAmount >= 5000) {
            discount += 10;
        } else if (orderAmount >= 1000){
            discount += 5;
        }
        if (customerType!= null) {
            if (customerType.toLowerCase() == 'vip') {
                discount += 5;
            } else if (customerType.toLowerCase() == 'premium') {
                discount += 3;
            }
        }
        if (promoCode!= null) {
            if (promoCode.toUpperCase() == 'SUMMER10') {
                discount += 10;
            } else if (promoCode.toUpperCase() == 'WELCOME5') {
                discount += 5;
            }
        }
        
        if (discount > 50) {
            discount = 50;
        }
        Decimal finalAmount = orderAmount - (orderAmount * discount / 100);
        return finalAmount.setScale(2);
    }
}