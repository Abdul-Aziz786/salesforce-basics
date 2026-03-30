public class MapWithListDIY1 {
    
    
    public static void demo() {
        // 1.
        EmployeeTaskManager etm = new EmployeeTaskManager();
        etm.addTask('Alice', 'Review');
        etm.showTasks();
        // 2
        StudentSubjectManager ssm = new StudentSubjectManager();
        ssm.addSubject('Rahul', 'History');
        ssm.showSubjects();
        // 3
        SalesOpportunityManager som = new SalesOpportunityManager();
        
        som.addOpportunity('Meena', 'Opp4');
        som.showOpportunities();
    }
    // 1. EmployeeTaskManager
    public class EmployeeTaskManager {
        
        Map<String, List<String>> empTaskMap;
        
        public EmployeeTaskManager(){
            empTaskMap = new Map<String, List<String>>();
            
            empTaskMap.put('John', new List<String>{'Design'});
            empTaskMap.put('Alice', new List<String>{'Testing'});
        }
        
        public void addTask(String empName, String newTask){
            
            if(empTaskMap.containsKey(empName)){
                empTaskMap.get(empName).add(newTask);
            }
            else{
                System.debug('Employee not found');
            }
        }
        
        public void showTasks(){
            
            for(String emp : empTaskMap.keySet()){
                System.debug('Employee: ' + emp);
                
                for(String task : empTaskMap.get(emp)){
                    System.debug('   - ' + task);
                }
            }
        }
    }
    
    // 2 — StudentSubjectManager
    public class StudentSubjectManager {
        
        Map<String, List<String>> studentSubjectMap;
        
        public StudentSubjectManager(){
            
            studentSubjectMap = new Map<String, List<String>>();
            
            studentSubjectMap.put('Rahul', new List<String>{'Maths'});
            studentSubjectMap.put('Priya', new List<String>{'English', 'Science'});
        }
        
        public void addSubject(String studentName, String newSubject){
            
            if(studentSubjectMap.containsKey(studentName)){
                studentSubjectMap.get(studentName).add(newSubject);
            }
            else{
                System.debug('Student not found');
            }
        }
        
        public void showSubjects(){
            
            for(String student : studentSubjectMap.keySet()){
                System.debug('Student: ' + student);
                
                for(String subject : studentSubjectMap.get(student)){
                    System.debug('   - ' + subject);
                }
            }
        }
    }
    
    // 3 — SalesOpportunityManager
    public class SalesOpportunityManager {
        
        Map<String, List<String>> salesOppMap;
        
        public SalesOpportunityManager(){
            
            salesOppMap = new Map<String, List<String>>();
            
            salesOppMap.put('Kiran', new List<String>{'Opp1', 'Opp2'});
            salesOppMap.put('Meena', new List<String>{'Opp3'});
        }
        
        public void addOpportunity(String salesPerson, String newOpp){
            
            if(salesOppMap.containsKey(salesPerson)){
                salesOppMap.get(salesPerson).add(newOpp);
            }
            else{
                System.debug('Salesperson not found');
            }
        }
        
        public void showOpportunities(){
            
            for(String person : salesOppMap.keySet()){
                System.debug('Salesperson: ' + person);
                
                for(String opp : salesOppMap.get(person)){
                    System.debug('   - ' + opp);
                }
            }
        }
    }
}