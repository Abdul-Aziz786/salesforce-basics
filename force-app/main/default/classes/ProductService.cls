public class ProductService {
    
    public static void demo() {
        System.debug(wrapProduct('IQOO 12', 60000));
    }
    
    public static ProductWrapper wrapProduct( String productName,  Decimal price) { 
        ProductWrapper pw = new ProductWrapper();
        pw.productName = productName;
        pw.price = price;
        
        if(price > 1000) 
            pw.isExpensive = true;
        
        return pw;
    }

    
    public class ProductWrapper {
        public String productName;
        public Decimal price;
        public Boolean isExpensive;
    } 
}