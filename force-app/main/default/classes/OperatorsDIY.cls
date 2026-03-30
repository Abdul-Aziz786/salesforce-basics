public class OperatorsDIY {
    public static void run() {
        // • 1. Discount Eligibility Check
        // A customer makes a purchase of 78,500.
        // The company offers a 10% discount for purchases above 710,000.
        // Write a program to check if the customer is eligible for the discount.
        
        Decimal purchaseAmount = 78500;
        Decimal discountThreshold = 71000;
        
        Boolean isEligible = purchaseAmount > discountThreshold;
        
        System.debug('Eligible for Discount: ' + isEligible);
        
        // • 2. Sales Bonus Approval
        // A salesperson closed 18 deals and achieved Rs 1,25,000 in revenue.
        // Bonus eligibility requires at least 15 deals and minimum revenue of 1,00,000.
        // Write a program to check if the person is eligible for the bonus.
        
        Integer dealsClosed = 18;
        Decimal revenue = 125000;
        
        
        Boolean bonusEligible = dealsClosed >= 15 && revenue >= 100000;
        
        System.debug('Bonus Eligible: ' + bonusEligible);
        
        
        // • 3. Service Slot Tracker
        // A support team handles 40 service slots daily. As tickets are assigned, the available slots must be updated.
        // Write a program to reduce the available count when a new ticket is assigned.
        Integer totalSlots = 40;
        Integer assignedTickets = 1;
        
        Integer availableSlots = totalSlots - assignedTickets;
        
        System.debug('Available Service Slots: ' + availableSlots);
        
        
        
        // • 4. Inventory Value Calculator
        // A product has 120 units in stock and each unit costs 2275.
        // Write a program to calculate the total inventory value.
        
        Integer unitsInStock = 120;
        Integer unitCost = 2275;
        Decimal inventoryValue = unitsInStock * unitCost;
        System.debug('Total Inventory Value: ' + inventoryValue);
        
        // • 5. Customer Loyalty Program Check
        // A customer has made 7 purchases and referred 3 new customers.
        //Loyalty tier-2 requires 5 purchases and 2 referrals.
        // Write a program to check if the customer qualifies for Tier-2 status.
        Integer purchases = 7;
        Integer referrals = 3;
        Boolean isLoyalCustomer = purchases >= 5 && referrals >= 2;
        System.debug('Loyalty Tier-2 Status: ' + isLoyalCustomer);
        
        // • 6. Lead Conversion Eligibility
        // A lead can be marked as "Ready to Convert" if either the lead score is above 80 or the contact has responded positively.
        // Write a program to evaluate if a lead can be marked ready.
        Integer leadScore = 85;
        Boolean positiveResponse = false;
        Boolean readyToConvert = leadScore > 80 || positiveResponse;
        System.debug('Lead Ready to Convert: ' + readyToConvert);
        
        // • 7. Product Return Window Validation
        // A customer is trying to return a product after 18 days. The return window is 15 days.
        // Write a program to validate if the return is allowed.
        Integer daysAfterPurchase = 18;
        Integer returnWindow = 15;
        Boolean isReturnAllowed = daysAfterPurchase <= returnWindow;
        System.debug('Return Allowed: ' + isReturnAllowed);
        
        // • 8. Invoice Payment Tracker
        // A client has paid 3 out of 4 invoices. When one more is cleared, update the paid invoice count and display it.
        // Simulate this scenario in code.
        Integer totalInvoices = 4;
        Integer paidInvoices = 3;
        paidInvoices++;
        System.debug('Paid Invoices: ' + paidInvoices);
        
        // • 9. Email Campaign Reach Estimator
        // A marketing manager wants to calculate how many people will receive an email campaign.
        //If there are 4 lists, each with 2,500 contacts, Write a program to calculate the total estimated reach.
        Integer lists = 4;
        Integer contactsPerList = 2500;
        Integer totalReach = lists * contactsPerList;
        System.debug('Total Estimated Reach: ' + totalReach);
        
        // • 10. Agent Response Quality Check
        // An agent responded to 92 tickets this week with a feedback score of 4.8.
        //The quality benchmark is at least 90 tickets and 4.5 rating.
        // Write a program to determine if the agent meets the benchmark.
        Integer ticketsResponded = 92;
        Decimal feedbackScore = 4.8;
        Boolean meetsBenchmark = ticketsResponded >= 90 && feedbackScore >= 4.5;
        System.debug('Meets Quality Benchmark: ' + meetsBenchmark);
    }
}