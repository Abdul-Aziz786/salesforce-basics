public class MapWithListDIY2 {
    
    public static void demo() {
        
        // 1. Project Task Manager
        
        ProjectTaskManager ptm = new ProjectTaskManager();
        
        ptm.addTask('CRM Upgrade', 'Requirement Gathering');
        ptm.addTask('CRM Upgrade', 'Data Migration');
        ptm.addTask('CRM Upgrade', 'UAT Testing');
        
        ptm.addTask('Website Redesign', 'UI Design');
        ptm.addTask('Website Redesign', 'Frontend Development');
        
        ptm.printTasks();
        
        System.debug('CRM Upgrade Count: ' + ptm.countTasks('CRM Upgrade'));
        System.debug('Website Redesign Count: ' + ptm.countTasks('Website Redesign'));
        
        
        // 2. Student Marks Manager
        
        StudentMarksManager smm = new StudentMarksManager();
        
        smm.addMark('Tony', 80);
        smm.addMark('Tony', 90);
        smm.addMark('Tony', 70);
        
        smm.addMark('Sophia', 85);
        smm.addMark('Sophia', 95);
        
        smm.printStudentMarks();
        
        System.debug('Tony Avg: ' + smm.getAverage('Tony'));
        System.debug('Sophia Avg: ' + smm.getAverage('Sophia'));
        
        
        // 3. Event Manager
        
        EventManager em = new EventManager();
        
        em.registerAttendee('Bandham\'25', 'Arun');
        em.registerAttendee('Bandham\'25', 'Meera');
        em.registerAttendee('Bandham\'25', 'Kiran');
        em.registerAttendee('Bandham\'25', 'Nila');
        
        em.registerAttendee('Salesforce Meetup', 'David');
        em.registerAttendee('Salesforce Meetup', 'Sara');
        
        em.printEventAttendees();
        
        em.printEventsWithMoreThanN(3);
    }
    
    
    // 1. ProjectTaskManager
    
    public class ProjectTaskManager {
        
        Map<String, List<String>> projectTaskMap;
        
        public ProjectTaskManager(){
            projectTaskMap = new Map<String, List<String>>();
        }
        
        public void addTask(String project, String task){
            
            if(projectTaskMap.containsKey(project)){
                projectTaskMap.get(project).add(task);
            }
            else{
                projectTaskMap.put(project, new List<String>{task});
            }
        }
        
        public void printTasks(){
            
            for(String project : projectTaskMap.keySet()){
                
                System.debug('Project: ' + project);
                
                for(String task : projectTaskMap.get(project)){
                    System.debug('   - ' + task);
                }
            }
        }
        
        public Integer countTasks(String project){
            
            if(projectTaskMap.containsKey(project)){
                return projectTaskMap.get(project).size();
            }
            
            return 0;
        }
    }
    
    
    // 2. StudentMarksManager
    
    public class StudentMarksManager {
        
        private Map<String, List<Integer>> studentMarksMap;
        
        public StudentMarksManager(){
            studentMarksMap = new Map<String, List<Integer>>();
        }
        
        public void addMark(String student, Integer mark){
            
            if(studentMarksMap.containsKey(student)){
                studentMarksMap.get(student).add(mark);
            }
            else{
                studentMarksMap.put(student, new List<Integer>{mark});
            }
        }
        
        public void printStudentMarks(){
            
            for(String student : studentMarksMap.keySet()){
                
                System.debug('Student: ' + student);
                
                for(Integer mark : studentMarksMap.get(student)){
                    System.debug('   - ' + mark);
                }
            }
        }
        
        public Decimal getAverage(String student){
            
            if(!studentMarksMap.containsKey(student)){
                return 0;
            }
            
            List<Integer> marks = studentMarksMap.get(student);
            Integer total = 0;
            
            for(Integer m : marks){
                total += m;
            }
            
            return total / (Decimal)marks.size();
        }
    }
    
    
    // 3. EventManager
    
    public class EventManager {
        
        private Map<String, List<String>> eventMap;
        
        public EventManager(){
            eventMap = new Map<String, List<String>>();
        }
        
        public void registerAttendee(String event, String attendee){
            
            if(eventMap.containsKey(event)){
                eventMap.get(event).add(attendee);
            }
            else{
                eventMap.put(event, new List<String>{attendee});
            }
        }
        
        public void printEventAttendees(){
            
            for(String event : eventMap.keySet()){
                
                System.debug('Event: ' + event);
                
                for(String attendee : eventMap.get(event)){
                    System.debug('   - ' + attendee);
                }
            }
        }
        
        public void printEventsWithMoreThanN(Integer n){
            
            for(String event : eventMap.keySet()){
                
                if(eventMap.get(event).size() > n){
                    System.debug('Event with more than ' + n + ' attendees: ' + event);
                }
            }
        }
    }
}