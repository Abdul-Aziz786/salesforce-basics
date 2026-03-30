public class DIYClassAndMap1 {
    
    public static void demo() {
        Product product1 = new  Product('001', 'Milk', 50, 10, 5);
        Product product2 = new  Product('002', 'Oil - 1L', 100, 60, 10);
        Product product3 = new  Product('003', 'Bread', 70, 30, 10);
        
        SuperMarket sm = new SuperMarket();
        
        sm.addProduct(product1);
        sm.addProduct(product2);
        sm.addProduct(product1);
        sm.addProduct(product3);
        
        sm.displayStock();
        sm.reorderProduct('001',20);
        
        Cart c = new Cart(sm);
        c.addToCart('002',2);
        c.addToCart('001',5);
        c.addToCart('003',70);
        c.addToCart('002',5);
        
        c.billing();
        
        sm.displayStock();
        c.billing();
        
        
        
        
    }
    
    
    public class Product {
        public String code, name;
        public Decimal price, discount;
        public Integer  stock;
        
        public Product(String code,
                       String name,
                       Decimal price,
                       Integer stock,
                       Decimal discount) {
                           this.code = code;
                           this.price = price;
                           this.stock = stock;
                           this.discount = discount;
                           this.name = name;
                       }
        public void updateStock(Integer count) {
            stock += count;
        }
        public void reduceStock(Integer count) {
            stock -= count;
        }
        
        boolean isStockAvailable(Integer quantity) {
            if(quantity > stock) return false;
            return true;
        }
        
        public Decimal finalPrice() {
            return price - (price * discount / 100 );
        }
    }
    
    public class SuperMarket {
        
        Map<String,Product> products = new Map<String,Product>();
        
        
        public void addProduct(Product product) {
            if(products.containsKey(product.code)) {
                products.get(product.code).updateStock(product.stock);
            } else {
                products.put(product.code,product);
            }
        }
        
        public void displayStock() {
            for(String p: products.keySet()) {
                Product prod = products.get(p);
                System.debug(prod.name + ' - ' + prod.stock + ' Stock Available');
            }
        }
        public void reorderProduct(String productCode, Integer quantity) {
            
            if (quantity <= 0) {
                System.debug('Invalid reorder quantity');
                return;
            }
            
            Product p = products.get(productCode);
            
            if (p == null) {
                System.debug('Product not found');
                return;
            }
            
            p.updateStock(quantity);
            
            System.debug('Reordered ' + quantity + 
                         ' units of ' + p.name + ' - Stock = ' + p.stock );
            
        }
        
        public Product getProduct(String code) {
            return products.get(code);
        }
        
        
    }
    
    
    public class Cart {
        SuperMarket market;
        public Cart(SuperMarket market){
            this.market = market;
        }
        
        Map<String,Product> marketProucts {
            get {
                return market.products;
            }
        }
        
        Map<String,Integer> cartMap= new Map<String,Integer>();
        
        public void addToCart(String productCode,Integer count) {
            if (productCode == null) {
                System.debug('Product not found');
                return;
            }
            
            if(!marketProucts.containsKey(productCode))  {
                System.debug('Product not found - ' + productCode);
                return;
            }
            
            Product prd = marketProucts.get(productCode);
            
            if(!prd.isStockAvailable(count)) {
                System.debug('stock not available'   );
                return;
            }
            if(cartMap.containsKey(productCode)) {
                
                Integer currentCount = cartMap.get(productCode);
                
                cartMap.put(productCode,currentCount + count);
            } else {
                cartMap.put(productCode,count);
            }
            
            System.debug('Added to cart: ' + count + ' - ' + prd.name );
        }  
        
        public void billing() {
            Decimal totalAmount = 0;
            
            System.debug('----- BILLING --------');
            for(String pCode: cartMap.keySet()) {
                Product item = market.getProduct(pCode);
                Integer itemQuantity = cartMap.get(pCode);
                
                Decimal itemTotal = item.finalPrice() *  itemQuantity;
                totalAmount += itemTotal; 
                
                item.reduceStock(itemQuantity);
                System.debug(
                    item.name +
                    ' | Qty: ' + itemQuantity +
                    ' | Total: ' + itemTotal
                );
            }
            System.debug('Grand Total: ' + totalAmount);
            cartMap.clear();
            
        } 
        
    }
    
}