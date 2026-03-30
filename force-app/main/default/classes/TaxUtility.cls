public class TaxUtility {
    public static String calculateTax(Decimal salary) {
        if (salary == null || salary == 0) {
            return 'No Tax';
        }
        
        Decimal taxAmount = 0;
        if (salary >= 1000000) {
            taxAmount = salary * 0.30;
        } else if (salary >= 500000) {
            taxAmount = salary * 0.20;
        } else if (salary >= 250000) {
            taxAmount = salary * 0.10;
        }
        
        return String.valueOf(taxAmount);
    }
}