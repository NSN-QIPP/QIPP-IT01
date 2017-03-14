@isTest(seealldata =true)
public class reminderNotify_Test{
   private static testmethod void testreminderNotify(){
     Test.StartTest();
     system.debug('********** Test Execution Started **********');
     reminderNotify rem=new reminderNotify();
     database.executeBatch(rem);
     Test.StopTest();
   }
}