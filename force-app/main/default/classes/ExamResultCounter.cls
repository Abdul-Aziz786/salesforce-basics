// 6. Exam Result Counter
public class ExamResultCounter {
    
    public static Integer totalPass = 0;
    public static Integer totalFail = 0;
    
    public static void checkResult(Integer marks) {
        
        if (marks >= 40) {
            totalPass++;
        } else {
            totalFail++;
        }
        
        System.debug('checkResult(' + marks + ') → Pass: '
            + totalPass + ', Fail: ' + totalFail);
    }
}