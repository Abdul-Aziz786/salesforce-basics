public class StaticVarAndMethodDIYs {
    
    
    public static void demo() {
        //1. Cricket Score Tracker
        CricketScoreTracker.addRuns(4);
        CricketScoreTracker.addRuns(6);
        
        //2. Ticket Booking Counter
        TicketBookingCounter.bookTicket(2);
        TicketBookingCounter.bookTicket(3);
        
        //3. Attendance Tracker
        AttendanceTracker.markPresent();
        AttendanceTracker.markPresent();
        
        //4. Shopping Cart Total
        ShoppingCart.addItemPrice(250);
        ShoppingCart.addItemPrice(150);
        
        //5. Bonus Tracker
        BonusTracker.payBonus(5000);
        BonusTracker.payBonus(3000);
        
        //6. Exam Result Counter
        ExamResultCounter.checkResult(55);
        ExamResultCounter.checkResult(35);
    }
    
}