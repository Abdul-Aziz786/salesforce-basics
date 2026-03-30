public  class StringFunctionDIY {
    
    public static void demo() {
        
        System.debug('--- DIY 1 ---');
        DiscountUtility discountUtil = new DiscountUtility();
        System.debug(discountUtil.calculateDiscount(10000, 20));
        System.debug(discountUtil.calculateDiscount(5000, 10));
        System.debug(discountUtil.calculateDiscount(20000, 15, true));
        System.debug('--- DIY 2 ---');
        ShippingUtility shippingUtil = new ShippingUtility();
        System.debug(shippingUtil.calculateShipping(10));
        System.debug(shippingUtil.calculateShipping(10, true));
        System.debug(shippingUtil.calculateShipping(10, true, 100));
        System.debug(shippingUtil.calculateShipping(10, 6000));
        System.debug('--- DIY 3 ---');
        StringFormatterUtility stringFormatterUtil = new StringFormatterUtility();
        System.debug(stringFormatterUtil.format('Hello World'));
        System.debug(stringFormatterUtil.format('  Hello World  ', true));
        System.debug(stringFormatterUtil.format('Hello,World,Salesforce', ',', '-'));
        System.debug('--- DIY 4 ---');
        NameFormatterUtility nameFormatterUtil = new NameFormatterUtility();
        System.debug(nameFormatterUtil.formatName('John', 'Doe'));
        System.debug(nameFormatterUtil.formatName('  John  ', '  Doe  ', true));
        System.debug(nameFormatterUtil.formatName('Dr.', 'John Doe', ' '));
        System.debug('--- DIY 5 ---');
        ProductCodeFormatter productCodeFormatterUtil = new ProductCodeFormatter();
        System.debug(productCodeFormatterUtil.formatCode('abc123'));
        System.debug(productCodeFormatterUtil.formatCode('  abc123  ', true));
        System.debug(productCodeFormatterUtil.formatCode('abc123, def456, ghi789', ',', ';'));
    }
    
    // DIY 1
    public class DiscountUtility {
        
        //Percentage Discount
        public  Decimal calculateDiscount(Decimal price, Decimal percent) {
            return price - (price * percent / 100);
        }
        
        //Flat Discount
        public  Integer calculateDiscount(Integer price, Integer amount, Boolean isFlat) {
            if(isFlat) {
                return price - amount;
            }
            return price;
        }
        
        //VIP Discount
        public  Decimal calculateDiscount(Decimal price, Decimal percent, Boolean isVIP) {
            Decimal discounted = price - (price * percent / 100);
            if(isVIP) {
                discounted = discounted - (discounted * 5 / 100);
            }
            return discounted;
        }
    }
    
    // DIY 2
    public class ShippingUtility {
        
        // 1 Standard Shipping
        public  Decimal calculateShipping(Decimal weight) {
            return weight * 50;
        }
        
        // 2 Express Shipping
        public  Decimal calculateShipping(Decimal weight, Boolean isExpress) {
            Decimal cost = weight * 50;
            if(isExpress) {
                cost += 100;
            }
            return cost;
        }
        
        // 3 Priority Shipping for VIP
        public  Decimal calculateShipping(Decimal weight, Boolean isVIP, Decimal distance) {
            Decimal cost = (weight * 50) + (distance * 10);
            if(isVIP) {
                cost *= 0.9;
            }
            return cost;
        }
        
        // 4 Free Shipping for Large Orders
        public  Decimal calculateShipping(Decimal weight, Decimal totalAmount) {
            if(totalAmount >= 5000) {
                return 0;
            }
            return calculateShipping(weight);
        }
    }
    // DIY 3
    public class StringFormatterUtility {
        
        // 1 Uppercase
        public  String format(String text) {
            return text.toUpperCase();
        }
        
        // 2 Trim + Lowercase
        public  String format(String text, Boolean trim) {
            if(trim) {
                text = text.trim();
            }
            return text.toLowerCase();
        }
        
        // 3 Split & Join
        public  String format(String text, String delimiter, String joinWith) {
            List<String> parts = text.split(delimiter);
            return String.join(parts, joinWith);
        }
    }
    // DIY 4
    public class NameFormatterUtility {
        
        // 1 Full Name Uppercase
        public  String formatName(String firstName, String lastName) {
            String full = firstName + ' ' + lastName;
            return full.toUpperCase();
        }
        
        // 2 Trim + Lowercase
        public  String formatName(String firstName, String lastName, Boolean trim) {
            if(trim) {
                firstName = firstName.trim();
                lastName = lastName.trim();
            }
            String full = firstName + ' ' + lastName;
            return full.toLowerCase();
        }
        
        // 3 Title + Initials
        public  String formatName(String title, String fullName, String delimiter) {
            
            List<String> parts = fullName.split(delimiter);
            List<String> initials = new List<String>();
            
            for(String part : parts) {
                if(part.length() > 0) {
                    initials.add(part.substring(0,1).toUpperCase());
                }
            }
            
            String joinedInitials = String.join(initials, delimiter);
            return title + ' ' + joinedInitials;
        }
    }
    
    // DIY 5
    
    public class ProductCodeFormatter {
        
        // 1 Single Code Uppercase
        public  String formatCode(String code) {
            return code.toUpperCase();
        }
        
        // 2 Trim + Uppercase
        public  String formatCode(String code, Boolean trim) {
            if(trim) {
                code = code.trim();
            }
            return code.toUpperCase();
        }
        
        // 3 Multiple Codes
        public  String formatCode(String codes, String delimiter, String newDelimiter) {
            
            List<String> parts = codes.split(delimiter);
            List<String> formatted = new List<String>();
            
            for(String part : parts) {
                if(part != null) {
                    formatted.add(part.trim().toUpperCase());
                }
            }
            
            return String.join(formatted, newDelimiter);
        }
    }
}