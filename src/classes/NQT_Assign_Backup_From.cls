Global class NQT_Assign_Backup_From implements Schedulable{
    global void execute (SchedulableContext SC){
    
        List<NQT_Assign_Backup_Person__c> ABP = [SELECT ownerID,NQT_Availability_Status__c, NQT_Backup_Person__c, NQT_From__c,
                                                NQT_Related_CPR__c, NQT_To__c FROM NQT_Assign_Backup_Person__c];
        for(NQT_Assign_Backup_Person__c BckPer : ABP)
            Update BckPer;   
        }
    static testMethod void testNQT_Assign_Backup_From(){
        NQT_Assign_Backup_From ABF = new NQT_Assign_Backup_From();
        SchedulableContext SC;
        ABF.execute(SC);
        }
    }