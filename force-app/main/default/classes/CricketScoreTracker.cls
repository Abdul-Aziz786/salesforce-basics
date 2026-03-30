// 1. Cricket Score Tracker
public class CricketScoreTracker {
    
    public static Integer totalScore = 0;
    
    public static void addRuns(Integer runs) {
        totalScore += runs;
        System.debug('addRuns(' + runs + ') → Total Score: ' + totalScore);
    }
}