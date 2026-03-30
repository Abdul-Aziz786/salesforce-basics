public  class ConditionalStatementsDIY {
    
      public static void tasks() {
        //DIY 1: Lead Qualification Check
        // Scenario:
        // A company considers a lead qualified only if the budget meets the minimum threshold required for enterprise solutions.
        // * Task:
        // Print whether the lead is "Qualified" or "Not Qualified" based on the budget value.
        Decimal leadBudget = 50000;
        Decimal qualificationThreshold = 100000;
        Boolean isQualified = leadBudget >= qualificationThreshold;
        System.debug('Lead Qualification Status: ' + (isQualified ? 'Qualified' : 'Not Qualified'));
        
        //DIY 2: Opportunity Discount Decision
        // Scenario:
        // The sales team is allowed to offer discounts only when the opportunity value is large enough to justify the margin.
        // * Task:
        // Based on the opportunity amount, print whether the discount is "Approved" or "Denied".
        
        Decimal opportunityValue = 150000;
        Decimal discountApprovalThreshold = 100000;
        Boolean isDiscountApproved = opportunityValue >= discountApprovalThreshold;
        System.debug('Discount Approval Status: ' + (isDiscountApproved ? 'Approved' : 'Denied'));
        
        //DIY 3: Support Case Priority Assignment
        // Scenario:
        // Cases with short response time expectations are treated as urgent.
        //The rest are categorized into medium and low priorities depending on how much time is available for response.
        // Task:
        // Print the appropriate priority level: "High Priority", "Medium Priority", or "Low Priority".
        
        Integer responseTimeInHours = 2;
        if(responseTimeInHours <= 4) {
            System.debug('Case Priority: High Priority');
        } else if(responseTimeInHours <= 24) {
            System.debug('Case Priority: Medium Priority');
        } else {
            System.debug('Case Priority: Low Priority');
        }
        
        //DIY 4: Inventory Status Display
        // Scenario:
        // The warehouse system must show the stock status. If stock is plenty, it should show "In Stock".
        // If few items are left, show "Limited Stock". If none, display "Out of Stock".
        // Task:
        // Based on available stock quantity, print the correct stock status.
        
        Integer stockQuantity = 5;
        if(stockQuantity > 10) {
            System.debug('Stock Status: In Stock');
        } else if(stockQuantity > 0) {
            System.debug('Stock Status: Limited Stock');
        } else {
            System.debug('Stock Status: Out of Stock');
        }
        
        // DIY 5: Payment Reminder Trigger
        // Scenario:
        // Customers who have any pending dues should receive a payment reminder.
        // If the dues are already cleared, no action is required.
        // Task:
        // Print whether a "Payment Reminder" should be sent or "No Action Needed".
        
        Decimal pendingDues = 0;
        Boolean shouldSendReminder = pendingDues > 0;
        System.debug('Payment Reminder Status: ' + (shouldSendReminder ? 'Payment Reminder' : 'No Action Needed'));
        
        // DIY 6: Assign Agent Based on Region
        // Scenario:
        // In a support process, incoming customer queries are routed to agents based on the region:
        // • South region queries go to one agent,
        // • North to another,
        // • West to someone else,
        // • All other regions go to a fallback agent.
        // * Task:
        // Print the name of the agent to whom the ticket should be assigned.
        
        String customerRegion = 'North';
        String assignedAgent;
        if(customerRegion == 'South') {
            assignedAgent = 'Agent A';
        } else if(customerRegion == 'North') {
            assignedAgent = 'Agent B';
        } else if(customerRegion == 'West') {
            assignedAgent = 'Agent C';
        } else {
            assignedAgent = 'Fallback Agent';
        }
        System.debug('Assigned Agent: ' + assignedAgent);
        
        // DIY 7: Loyalty Tier Assignment
        // Scenario:
        // Customers are assigned loyalty tiers based on their total purchases:
        // • The highest tier is for premium spenders,
        // • The middle tiers reward moderate spenders,
        // • The lowest tier includes everyone else.
        // Task:
        // Print whether the customer is a "Platinum", "Gold", "Silver", or "Bronze" member.
        
        Decimal totalPurchases = 75000;
        String loyaltyTier;
        if(totalPurchases >= 100000) {
            loyaltyTier = 'Platinum';
        } else if(totalPurchases >= 50000) {
            loyaltyTier = 'Gold';
        } else if(totalPurchases >= 10000) {
            loyaltyTier = 'Silver';
        } else {
            loyaltyTier = 'Bronze';
        }
        System.debug('Loyalty Tier: ' + loyaltyTier);
        
        // DIY 8: Notification Decision for New Lead
        // Scenario:
        // The CRM system should notify the sales team when a new lead comes from important sources like website or referral.
        // Other sources can be ignored for now.
        // • Task:
        // Print whether a "Notification Sent" or "No Notification" is needed.
        
        String leadSource = 'Website';
        Boolean shouldNotify = leadSource == 'Website' || leadSource == 'Referral';
        System.debug('Notification Status: ' + (shouldNotify ? 'Notification Sent' : 'No Notification'));
        
        // DIY 9: Contact Validation
        // Scenario:
        // Before saving a contact, make sure it has both an email and a phone number filled in.
        // If either is missing, it's considered incomplete.
        // Task:
        // Print "Valid Contact" or "Incomplete Contact".
        
        String email = '';
        String phoneNumber = '1234567890';
        Boolean isValidContact =  email != '' &&  phoneNumber != '';
        System.debug('Contact Status: ' + (isValidContact ? 'Valid Contact' : 'Incomplete Contact'));
        
        // % DIY 10: Shipping Method Selection
        // Scenario:
        // Shipping method is selected based on the order amount:
        // • Orders above a high-value threshold get Free Express Shipping,
        // • Mid-range orders get Free Standard Shipping,
        // • All others must pay 100 as a shipping fee.
        // * Task:
        // Print the selected shipping method.
        Decimal orderAmount = 120000;
        String shippingMethod;
        if(orderAmount > 10000) {
            shippingMethod = 'Free Express Shipping';
        } else if(orderAmount > 5000) {
            shippingMethod = 'Free Standard Shipping';
        } else {
            shippingMethod = 'Shipping Fee: 100';
        }
        System.debug('Selected Shipping Method: ' + shippingMethod);
    }
    

    
    public static void run() {
    // Create a simple apex program to find result of a student
    // Declare variable to store student name
    // Declare three variables to store mark (Ex: integer physicsMark,chemistryMark, mathsMark)
    // Declare variables to store total, result, average, grade of the student
    // Requirement:
    // Find result for the student based on the marks stored
    // Find total, average, grade for the student Display total, average, grade using system.debug Average:
    // Student should be passed and average greater than 90 then S grade
    // Student should be passed and average greater than 80 then A grade
    // Student should be passed and average greater than 70 then B grade
    // Student should be passed and average greater than 50 then C grade
    // Student failed then no grade for the student
        Integer passMark = 35;
        
        String studentName = 'Ajees';
        
        Integer physicsMark = 85;
        Integer chemistryMark = 90;
        Integer mathsMark = 80;
        
        Integer total, average;
        String result, grade;
        
        if(physicsMark >= passMark && chemistryMark >= passMark && mathsMark >= passMark) {
            result = 'Passed';
            total = physicsMark + chemistryMark +mathsMark;
            average = total / 3;
            if(average > 90) {
                grade = 'S';
            } else if(average > 80) {
                grade = 'A';
            } else if(average > 70) {
                grade = 'B';
            } else if(average > 50) {
                grade = 'C';
            } else {
                grade = 'No Grade';
            }
        } else {
            result = 'Fail';
            grade = 'No Grade';
        }
        System.debug('Student ' + studentName + ' has ' + result);
        System.debug('Total Marks: ' + total);
        System.debug('Average Marks: ' + average);
        System.debug('Grade: ' + grade);
    }
}