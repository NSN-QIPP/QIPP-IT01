@isTest
private with sharing class scheduleReminderNotify_Test{

  private static testmethod void testscheduleReminderNotify() {
    Test.StartTest();
    scheduleReminderNotify testsr=new scheduleReminderNotify();
    String sch='0 0 23 * * ?';
    system.schedule('Schedule Test Starting',sch,testsr);
    Test.StopTest();
  }
}