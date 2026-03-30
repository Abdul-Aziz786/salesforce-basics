AsyncOptions options = new AsyncOptions();
options.MaximumQueueableStackDepth = 5;
System.enqueueJob(new RecursiveQueueDemo(1), options);

Database.executeBatch(new BatchUpdateAllAccountIndustryIfBlank(), 200);

System.schedule('Close Overdue Opportunities', '0 30 21 ? * SUN *', new ScheduleCloseOverdueOpportunities());