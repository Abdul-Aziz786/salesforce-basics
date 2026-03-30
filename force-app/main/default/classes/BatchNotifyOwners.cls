public  class BatchNotifyOwners implements Database.Batchable<SObject>, Database.Stateful {
    
    Map<Id,Integer> ownerContactCountMap = new Map<Id,Integer>();
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Email, AccountId, Account.OwnerId FROM Contact WHERE Email = null]);
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> scope) {
        for (Contact c : scope) {
            if (c.AccountId != null) {
                if (ownerContactCountMap.containsKey(c.Account.OwnerId)) {
                    ownerContactCountMap.put(c.Account.OwnerId, ownerContactCountMap.get(c.Account.OwnerId) + 1);
                } else {
                    ownerContactCountMap.put(c.Account.OwnerId, 1);
                }
            }
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        for (Id ownerId : ownerContactCountMap.keySet()) {
            String message = 'You have ' + ownerContactCountMap.get(ownerId) + ' contacts without email addresses.';
            NotificationHelper.sendNotification(ownerId, message);
        }
    }
}