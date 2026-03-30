public  class NotificationHelper {
    public static void sendNotification(Id userId, String message) {
        CustomNotificationType notificationType = [SELECT Id FROM CustomNotificationType WHERE DeveloperName = 'NotifyContactDeactivation' LIMIT 1];
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        notification.setTitle('Contact Deactivation Alert');
        notification.setBody(message);
        notification.setTargetId(userId);
        notification.setNotificationTypeId(notificationType.Id);
        
        try {
            notification.send(new Set<String>{userId});
        } catch (Exception e) {
            System.debug('Error sending notification: ' + e.getMessage());
        }
    }
}