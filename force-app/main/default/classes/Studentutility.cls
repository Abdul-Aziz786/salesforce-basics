public class Studentutility {
    public static String calculateGrade(Integer m1, Integer m2, Integer m3) {
        if (m1 == null || m2 == null || m3 == null) {
            return 'No Grade';
        }
        
        Decimal averageMarks = (m1 + m2 + m3) / 3.0;
        if (averageMarks >= 90) {
            return 'A';
        } else if (averageMarks >= 75) {
            return 'B';
        } else if (averageMarks >= 60) {
            return 'C';
        } else if (averageMarks >= 40) {
            return 'D';
        }
        
        return 'F';
    }
}