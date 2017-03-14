@isTest
private class MCAR_Open_MoreThan_90Days_Scheduled_Test{
Static testmethod void test_MCAR_Open_MoreThan_90Days_Scheduled(){
MCAR_Open_MoreThan_90Days_Scheduled mcar = new MCAR_Open_MoreThan_90Days_Scheduled();
SchedulableContext SC;
mcar.execute(SC);
}
}