public  class NestedListDIYs {
    
    public static void demo() {
        hospitalDepartmentsDoctors();
        airlineFlightSchedule();
        universityCoursesSubjects();
    }
    
    // 1: Hospital Departments & Doctors
    public static void hospitalDepartmentsDoctors() {
        List<String> departments = new List<String>{
            'Cardiology',
            'Neurology',
            'Pediatrics'
        };
        
        List<List<String>> doctors = new List<List<String>>{
            new List<String>{'Dr. Arjun', 'Dr. Meera'},
            new List<String>{'Dr. Ravi', 'Dr. Kavya'},
            new List<String>{'Dr. Sanjay', 'Dr. Anitha'}
        };
        
        for(Integer i = 0; i < departments.size(); i++) {
            System.debug('Department: ' + departments[i]);
            
            for(String doc : doctors[i]){
                System.debug('  - ' + doc);
            }
        }
    }
    
    // 2. Airline Flight Schedule
    public static void airlineFlightSchedule() {
        List<String> routes = new List<String>{
            'Chennai-Delhi',
            'Mumbai-Bangalore',
            'Hyderabad-Dubai'
        };
        
        List<List<String>> timings = new List<List<String>>{
            new List<String>{'Morning 6:00 AM', 'Afternoon 1:00 PM', 'Evening 8:00 PM'},
            new List<String>{'Morning 7:30 AM', 'Evening 6:45 PM'},
            new List<String>{'Afternoon 2:00 PM', 'Night 10:00 PM'}
        };
        
        for(Integer i = 0; i < routes.size(); i++){
            System.debug('Route: ' + routes[i]);
            
            for(String t : timings[i]){
                System.debug('  * ' + t);
            }
        }
    }
    
    // 3. University Courses & Subjects
    public static void universityCoursesSubjects() {
        List<String> courses = new List<String>{
            'B.Sc Computer Science',
            'B.Com',
            'B.A English'
        };
        
        List<List<String>> subjects = new List<List<String>>{
            new List<String>{'Data Structures', 'Operating Systems', 'Database Management'},
            new List<String>{'Accounting', 'Business Law', 'Economics'},
            new List<String>{'Literature', 'Poetry', 'Linguistics'}
        };
        
        for(Integer i = 0; i < courses.size(); i++){
            System.debug('Course: ' + courses[i]);
            
            for(String sub : subjects[i]){
                System.debug('   - ' + sub);
            }
        }
    }
}