public class ShippingCalculator {
    public static Decimal calculateShipping(Decimal weight, String destination) {
        Decimal shippingCharge = 0;
        if (weight <= 0) {
            shippingCharge = 0;
        } else if (weight <= 5) {
            shippingCharge = 50;
        }
        else if (weight <= 10) {
            shippingCharge = 100;
        } else if (weight <= 20) {
            shippingCharge = 200;
        } else {
            shippingCharge = 500;
        }
        if (destination != null && destination.toLowerCase() != 'local') {
            shippingCharge += 150;
        }
        return shippingCharge;
    }
}