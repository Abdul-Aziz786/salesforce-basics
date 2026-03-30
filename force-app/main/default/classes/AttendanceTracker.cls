// 3. Attendance Tracker
public class AttendanceTracker {
    
    public static Integer totalPresentDays = 0;
    
    public static void markPresent() {
        totalPresentDays++;
        System.debug('markPresent() → Present Days: ' + totalPresentDays);
    }
}