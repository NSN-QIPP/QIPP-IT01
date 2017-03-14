Global class NQT_Assign_Backup_To implements Schedulable{
    global void execute (SchedulableContext SC){
        List<NQT_Assign_Backup_Person__c> ABP = [SELECT ownerID,NQT_Availability_Status__c, NQT_Backup_Person__c, NQT_From__c,
                                                NQT_Related_CPR__c, NQT_To__c FROM NQT_Assign_Backup_Person__c];       
        for(NQT_Assign_Backup_Person__c BckPer : ABP)
            update BckPer; 
            
        /*************************Adding & Deleting Permission Set Flags in User Detail*************************/
        /*******************************************************************************************************/    
        /*Id PermissionId;
        list<PermissionSetAssignment> UserId = new list<PermissionSetAssignment>();
        try{PermissionId = [SELECT Id FROM PermissionSet WHERE Name = 'NQT_FE' LIMIT 1].Id;}catch(exception e){}
        try{UserId = [SELECT Id, AssigneeId FROM PermissionSetAssignment WHERE PermissionSetId =: PermissionId];}catch(exception e){}
        for(PermissionSetAssignment uId : UserId){
            User user = new User();
            try{user = [SELECT FE__c FROM User WHERE Id =: uId.AssigneeId];}catch(exception e){}
            user.FE__c = TRUE;
            update user;
            }
        
        try{PermissionId = [SELECT Id FROM PermissionSet WHERE Name = 'NQT_SE' LIMIT 1].Id;}catch(exception e){}
        try{UserId = [SELECT Id, AssigneeId FROM PermissionSetAssignment WHERE PermissionSetId =: PermissionId];}catch(exception e){}
        for(PermissionSetAssignment uId : UserId){
            User user = new User();
            try{user = [SELECT SE__c FROM User WHERE Id =: uId.AssigneeId];}catch(exception e){}
            user.SE__c = TRUE;
            update user;
            }
            
        try{PermissionId = [SELECT Id FROM PermissionSet WHERE Name = 'NQT_SE_MSC' LIMIT 1].Id;}catch(exception e){}
        try{UserId = [SELECT Id, AssigneeId FROM PermissionSetAssignment WHERE PermissionSetId =: PermissionId];}catch(exception e){}
        for(PermissionSetAssignment uId : UserId){
            User user = new User();
            try{user = [SELECT SEMSC__c FROM User WHERE Id =: uId.AssigneeId];}catch(exception e){}
            user.SEMSC__c = TRUE;
            update user;
            }
        
        try{PermissionId = [SELECT Id FROM PermissionSet WHERE Name = 'NQT_Program_Manager' LIMIT 1].Id;}catch(exception e){}
        try{UserId = [SELECT Id, AssigneeId FROM PermissionSetAssignment WHERE PermissionSetId =: PermissionId];}catch(exception e){}
        for(PermissionSetAssignment uId : UserId){
            User user = new User();
            try{user = [SELECT PM__c FROM User WHERE Id =: uId.AssigneeId];}catch(exception e){}
            user.PM__c = TRUE;
            update user;
            }
        
        Id PermissionIdFE;
        Id PermissionIdSE;
        Id PermissionIdMSC;
        Id PermissionIdPM;
        list<User> UserCheck = new list<User>();
        
        try{PermissionIdFE = [SELECT Id FROM PermissionSet WHERE Name = 'NQT_FE' LIMIT 1].Id;}catch(exception e){}
        try{PermissionIdSE = [SELECT Id FROM PermissionSet WHERE Name = 'NQT_SE' LIMIT 1].Id;}catch(exception e){}
        try{PermissionIdMSC = [SELECT Id FROM PermissionSet WHERE Name = 'NQT_SE_MSC' LIMIT 1].Id;}catch(exception e){}
        try{PermissionIdPM = [SELECT Id FROM PermissionSet WHERE Name = 'NQT_Program_Manager' LIMIT 1].Id;}catch(exception e){}
        try{UserCheck = [SELECT Id, FE__c, SE__c, SEMSC__c, PM__c FROM User WHERE FE__c = TRUE OR SE__c = TRUE OR SEMSC__c = TRUE OR PM__c = TRUE];}catch(exception e){}
        for(User user : UserCheck){
            if(user.FE__c == TRUE){
                try{UserId = [SELECT Id FROM PermissionSetAssignment WHERE AssigneeId =: user.id AND PermissionSetId =: PermissionIdFE];}catch(exception e){}
                if(UserId.isEmpty())
                    user.FE__c = FALSE;
                }
            if(user.SE__c == TRUE){
                try{UserId = [SELECT Id FROM PermissionSetAssignment WHERE AssigneeId =: user.id AND PermissionSetId =: PermissionIdSE];}catch(exception e){}
                if(UserId.isEmpty())
                    user.SE__c = FALSE;
                }
            if(user.SEMSC__c == TRUE){
                try{UserId = [SELECT Id FROM PermissionSetAssignment WHERE AssigneeId =: user.id AND PermissionSetId =: PermissionIdMSC];}catch(exception e){}
                if(UserId.isEmpty())
                    user.SEMSC__c = FALSE;
                }    
            if(user.PM__c == TRUE){
                try{UserId = [SELECT Id FROM PermissionSetAssignment WHERE AssigneeId =: user.id AND PermissionSetId =: PermissionIdPM];}catch(exception e){}
                if(UserId.isEmpty())
                    user.PM__c = FALSE;
                }
            }
        update UserCheck;*/
        }
        
    static testMethod void testNQT_Assign_Backup_To(){
        NQT_Assign_Backup_To ABT = new NQT_Assign_Backup_To();
        SchedulableContext SC;// = new SchedulableContext();
        ABT.execute(SC);
        }
    }