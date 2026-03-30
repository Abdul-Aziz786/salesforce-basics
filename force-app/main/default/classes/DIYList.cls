public class DIYList {
    
    
    public static void demo() {
        List<Integer> numbers = new List<Integer>{10, -5, 23, 8, -2, 15, 6, -9};
            
        System.debug('Max = ' + findMax(numbers)); 
        findSumOfOddandEvenNumbers(numbers);
        System.debug('isContainsNegative = ' + isContainsNegative(numbers));  
         List<Integer> negativeNums = findNegativeCounts(numbers);
        System.debug('Count = ' + negativeNums.size() + ' - Nums: ' + negativeNums);
        System.debug('reverse = ' + reverse(numbers)); 
        
            
     }
    
    public static Integer findMax(List<Integer> items) {
        if(items.isEmpty()) return 0;
        Integer max = items[0];
        
        for(Integer num: items) {
            if(max < num) {
                max = num;
            }
        }
        
        return max;
    }
    
    public static void findSumOfOddandEvenNumbers(List<Integer> items) {
        Integer evenSum = 0;
        Integer oddSum = 0;
        
        for(Integer num: items) {
            if(Math.mod(num,2) == 0) {
                evenSum  += num;
            } else {
                oddSum  += num;
            }
        }
        
        System.debug('Odd Sum = ' + oddSum);
        System.debug('Even Sum = ' + evenSum);
    }
    
    public static Boolean isContainsNegative(List<Integer> items) {
        if(items.isEmpty()) return false;
        
        
        items.sort();
        
        System.debug('Sort : ' + items);
        
        /*for(Integer num: items) {
             if(num < 0) {
              return true;
               }
             } */
        
        return items[0] < 0;
    }
    
    public static List<Integer> findNegativeCounts(List<Integer> items) {
        
        List<Integer>  arr = new List<Integer>();
        if(!DIYList.isContainsNegative(items)) return arr;
        
        items.sort();
        
        for(Integer num: items) {
            if(num < 0) {
                arr.add(num);
            }
        }
        
        return arr;
    }
    
    public static List<Integer> reverse(List<Integer> items) {
        List<Integer>  arr = new List<Integer>();
        
        if(items.isEmpty()) return arr;
        
        for(Integer num = items.size()-1; num >=0; num--) {
            arr.add(items[num]);
        }
        
        return arr;
    }
    
}