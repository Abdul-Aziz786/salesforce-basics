public class Calculator {
    public static void test(Integer a,Integer b) {        
        Calculator c = new Calculator();
        System.debug('Add ' + a +' + ' + b +' = '+ c.add(a, b));
        System.debug('Subtract ' + a +' - ' + b +' = '+ c.subtract(a, b));
        System.debug('Multiply ' + a +' * ' + b +' = '+ c.multiply(a, b));
        System.debug('Divide ' + a +' / ' + b +' = '+ c.divide(a, b));
        
    }
    public  Integer add(Integer a,Integer b) {       
        return a + b;
    }
    public  Integer subtract(Integer a,Integer b) {
        return a - b;
    }
    public  Integer multiply(Integer a,Integer b) {
        return a * b;
    }
    public  Integer divide(Integer a,Integer b) {
        return a / b;
    }
    
    public class StudentResult {
        
        public Integer getTotal(Integer m1, Integer m2, Integer m3) {
            return m1 + m2 + m3;
        }
        
        public Decimal getAverage(Integer m1, Integer m2, Integer m3) {
            return (m1 + m2 + m3) / 3.0;
        }
        
        public String getGrade(Integer m1, Integer m2, Integer m3) {
            Decimal avg = getAverage(m1, m2, m3);
            
            if (avg >= 90) return 'S';
            else if (avg >= 80) return 'A';
            else if (avg >= 70) return 'B';
            else if (avg >= 50) return 'C';
            else return 'Fail';
        }
    }
}