@isTest
Private class MCAR_7DComp_NotClosed_Scheduled_Test {
Static testmethod void test_MCAR_7DCompleted_NotClosed_Scheduled(){
      MCAR_7DCompleted_ButNotClosed_Scheduled test =new MCAR_7DCompleted_ButNotClosed_Scheduled();
      SchedulableContext SC;
      test.execute(SC);
  }
}