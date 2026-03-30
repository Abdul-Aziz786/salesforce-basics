// 5. Bonus Tracker
public class BonusTracker {
    
    public static Decimal totalBonusPaid = 0;
    
    public static void payBonus(Decimal bonus) {
        totalBonusPaid += bonus;
        System.debug('payBonus(' + bonus + ') → Total Bonus Paid: ' + totalBonusPaid);
    }
}