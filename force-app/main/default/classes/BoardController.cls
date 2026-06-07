public with sharing class BoardController {
    @AuraEnabled(cacheable=true)
    public static List<Board__c> getBoards() {
        
        try {
            return [SELECT Id, Name, Description__c, NoOfSections__c 
                    FROM Board__c 
                    ORDER BY CreatedDate DESC];
        } catch(Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }
    @AuraEnabled
    public static Id saveBoard(Board__c board,List<Board_Section__c> sections) {
        try {
            insert board;
            for(Board_Section__c section : sections) {
                section.Board__c = board.Id;
            }
            insert sections;
            return board.Id;
        } catch(Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Board_Section__c> getBoardDetails(String boardId) {
        try {
            List<Board_Section__c> sections = [
                SELECT Id, Name, Board__c, Items_Backgroud_Theme__c,
                 (SELECT Description__c, LikeCount__c, Section__c, Name, Id 
                  FROM Board_Section_Items__r)
                FROM Board_Section__c 
                WHERE Board__c = :boardId];
            return sections;
        } catch(Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}