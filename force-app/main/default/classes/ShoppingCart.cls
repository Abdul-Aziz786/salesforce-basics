// 4. Shopping Cart Total
public class ShoppingCart {
    
    public static Decimal cartTotal = 0;
    
    public static void addItemPrice(Decimal price) {
        cartTotal += price;
        System.debug('addItemPrice(' + price + ') → Cart Total: ' + cartTotal);
    }
}