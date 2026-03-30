public  class ForSwitchDIY {
    public static void main() {
        // • FOR LOOP DIY QUESTIONS (5)
        //     1. Multiplication Table
        //     Print the multiplication table of 5 from 1 to 10 using a for loop.
        
        for(Integer i= 1; i<=10 ; i++) {
            System.debug(i + ' * ' + 5 + ' = ' + i * 5);
        }
        
        //     2. Session Countdown (Reverse Loop)
        //     Print a countdown from 5 to 1 before a session starts. After countdown, display
        //     "Session Started".
        
        for (Integer i = 5; i >= 1; i--) {
            System.debug(i);
        }
        
        System.debug('Session Started');
        
        //     3. Sum of All Even Numbers from 1 to 20
        //     Write a loop to calculate the sum of all even numbers between 1 and 20.
        
        Integer sum = 0;
        
        for (Integer i = 2; i <= 20; i += 2) {
            sum += i;
        }
        
        System.debug('Sum of Even Numbers: ' + sum);
        
        
        //     4. Find First Number Divisible by 4 (Using break)
        //     Loop from 1 to 10 and stop immediately when you find the first number divisible by
        //     4. Print that number.
        
        for (Integer i = 1; i <= 10; i++) {
            if (Math.mod(i, 4) == 0) {
                System.debug('First divisible by 4: ' + i);
                break;
            }
        }
        
        //     5. Repeat a Welcome Message 3 Times
        //     Loop through a welcome message saying "Welcome Trainee X" where X is the count (1 to 3).
        
        for (Integer i = 1; i <= 3; i++) {
            System.debug('Welcome Trainee ' + i);
        }
        
        // E SWITCH STATEMENT DIY QUESTIONS (3)
        //     6. Course Category Identification
        //     Use a switch to check the category of a course — Tech, Design, or Marketing — and print a relevant welcome message.
        
        String category = 'Tech';
        
        switch on category {
            when 'Tech' {
                System.debug('Welcome to the Technology Course');
            }
            when 'Design' {
                System.debug('Welcome to the Design Course');
            }
            when 'Marketing' {
                System.debug('Welcome to the Marketing Course');
            }
            when else {
                System.debug('Invalid Course Category');
            }
        }
        
        //     7. Day-based Trainer Allocation
        //     Use a switch to assign a trainer name based on the day of the week (e.g., Monday
        //     → Trainer A).
        
        String day = 'Monday';
        String trainer = '';
        
        switch on day {
            when 'Monday' {
                trainer = 'Trainer A';
            }
            when 'Tuesday' {
                trainer = 'Trainer B';
            }
            when 'Wednesday' {
                trainer = 'Trainer C';
            }
            when 'Thursday' {
                trainer = 'Trainer D';
            }
            when 'Friday' {
                trainer = 'Trainer E';
            }
            when else {
                trainer = 'No Trainer Assigned';
            }
        }
        System.debug('Trainer : ' + trainer);
        
        //     8. Feedback Rating Response
        //     Take a feedback rating like "Good", "Average", or "Poor" and print a corresponding message.
        String rating = 'Good';
        
        switch on rating {
            when 'Good' {
                System.debug('Thank you for your positive feedback!');
            }
            when 'Average' {
                System.debug('We will try to improve.');
            }
            when 'Poor' {
                System.debug('We sincerely apologize for the inconvenience.');
            }
            when else {
                System.debug('Invalid Rating');
            }
        }
    }
}