public class ListDIYs {
    public static void demo() {
        eventAttendeesNames();
        contactPhoneNumbersUpdate();
        leadStatusTracking();
        productPriceAdjustments();
        supportTicketCategories();
        salesStageList();
        campaignEmailSubjects();
        customerFeedbackRatings();
        inventoryRestockItems();
        salesforceUsernamesForProject();
    }
    
    // 1.Event Attendee Names
    public static void eventAttendeesNames() {
        List<String> attendees = new List<String>{'John Doe', 'Jane Smith', 'Alice Johnson', 'Bob Brown', 'Charlie Davis'};
        attendees.add('Emily Wilson');
        attendees.add('Michael Clark');
        
        System.debug('Event Attendees: ' + attendees);
        attendees.remove(3);
        System.debug('Updated Attendees: ' + attendees);
    }
    
    //2. Contact Phone Numbers Update
    public static void contactPhoneNumbersUpdate() {
        String[] contactPhones = new String[]{
            '9876543210',
            '9123456780',
            '9988776655',
            '9001122334'
        };
        contactPhones.add(2, '8888888888');
        
        System.debug('Original Contact Phones: ' + contactPhones);
        contactPhones[1] = '9112233445';
        System.debug('Updated Contact Phones: ' + contactPhones);
    }
    
    // 3.Lead Status Tracking
    public static void leadStatusTracking() {
        List<String> leadStatus = new List<String>{
            'New',
            'Contacted',
            'Qualified',
            'Disqualified',
            'New'
        };
        
        leadStatus[1] = 'Converted';
        
        Integer indexOfDisqualified = leadStatus.indexOf('Disqualified');
        if (indexOfDisqualified != -1) {
            leadStatus.remove(indexOfDisqualified);
        }
        for(String status: leadStatus) {
            System.debug(status);
        }
    }
    
    // 4. Product Price Adjustments
    public static void productPriceAdjustments() {
        List<Decimal> prices = new List<Decimal>();
        
        prices.add(100);
        prices.add(200);
        prices.add(300);
        
        prices.set(0, prices[0] * 1.10);
        
        prices.remove(1);
        
        System.debug(prices);
    }
    
    // 5. Support Ticket Categories
    public static void supportTicketCategories() {
        List<String> categories = new List<String>{
            'Technical',
            'Billing',
            'General',
            'Technical',
            'Billing'
        };
        categories.add(0, 'Refund');
        
        Integer indexOfGeneral = categories.indexOf('General');
        if (indexOfGeneral != -1) {
            categories.remove(indexOfGeneral);
        }
        System.debug(categories);
    }
    
    // 6. Sales Stage List
    public static void salesStageList() {
        List<String> salesStages = new List<String>{
            'Prospecting', 'Negotiation', 'Closed Won',
            'Closed Lost'
        };
        
        salesStages.add('Qualification');
        
        Integer indexOfNegotiation = salesStages.indexOf('Negotiation');
        
        salesStages.set(indexOfNegotiation, 'Proposal Sent');
        System.debug(salesStages);
    }
    
    // 7. Campaign Email Subjects
    public static void campaignEmailSubjects() {
        List<String> subjects = new List<String>{
            'Welcome Offer',
            'Limited Time Deal',
            'Exclusive Discount',
            'Last Chance'
        };
        
        subjects.add('Flash Sale');
        subjects.add('Thank You Offer');
        
        subjects.remove(0);
        
        for(Integer i = 0; i < subjects.size(); i++){
            System.debug('Index ' + i + ': ' + subjects[i]);
        }
    }
    
    // 8. Customer Feedback Ratings
    public static void customerFeedbackRatings() {
        List<Integer> ratings = new List<Integer>{5,4,3,2,5};
        
        ratings.add(4);
        
        ratings.set(3, 4);
        
        System.debug('Total Ratings: ' + ratings.size());
    }
    
    // 9. Inventory Restock Items
    public static void inventoryRestockItems() {
        List<String> items = new List<String>{
            'Laptop',
            'Mouse',
            'Keyboard',
            'Monitor',
            'Printer',
            'Scanner'
        };
        
        items.add(0, 'Server');
        
        Integer indexOfPrinter = items.indexOf('Printer');
        if (indexOfPrinter != -1) {
            items.remove(indexOfPrinter);
        }
        System.debug(items);
    }
    
    // 10. Salesforce Usernames for a Project
    public static void salesforceUsernamesForProject() {
        List<String> usernames = new List<String>{
            'user1@org.com',
            'user2@org.com',
            'user3@org.com',
            'user4@org.com'
        };
        
        usernames.add(2, 'newuser@org.com');
        
        usernames.remove(3);
        
        System.debug(usernames);
    }
}