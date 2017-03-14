trigger Assign_Backup_Validation on NQT_Assign_Backup_Person__c (before Insert, before Update) {

      for(NQT_Assign_Backup_Person__c BckPer : Trigger.New)
            if(BckPer.NQT_From__c == date.today() && (BckPer.NQT_Availability_Status__c == 'Out of office'||BckPer.NQT_Availability_Status__c == 'Un Available')){
              //if(trigger.old[0].NQT_Availability_Status__c != 'Out of office' || trigger.old[0].NQT_Availability_Status__c != 'Un Available') 
                List<CPR__c> CPR = new List<CPR__c>();
                CPR = [SELECT Name, NQT_Class_Access_After__c, NQT_Class_Access_Before__c, NQT_Account_Manager__c, NQT_FE__c, NQT_Program_Manager__c,NQT_Project_Manager__c, NQT_SE__c, NQT_SE_MSC__c FROM CPR__c WHERE NQT_Project_Status__c !=: 'Quote Closed' AND NQT_Project_Status__c !=: 'Cancelled']; 
    
                list<CPR__c> updatedCPR = new list<CPR__c>();
                string CPR_List = '';
                Boolean Update_Check;
                integer i = 0;
                for(CPR__c Check_CPR : CPR){
                    //if(i > 148)
                    //    break;
                    Update_Check = FALSE;
                    system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+BckPer.OwnerId+'ssssssssssssssss'+Check_CPR.NQT_Program_Manager__c);
                    if(Check_CPR.NQT_Account_Manager__c == BckPer.OwnerId){
                        Check_CPR.NQT_Account_Manager_Backup__c = Check_CPR.NQT_Account_Manager__c;
                        Check_CPR.NQT_Account_Manager__c = BckPer.NQT_Backup_Person__c;
                        CPR_List = CPR_List + Check_CPR.Name + ';';
                        Update_Check = TRUE;
                        }
                        
                    if(Check_CPR.NQT_FE__c == BckPer.OwnerId){
                        Check_CPR.NQT_FE_Backup__c = Check_CPR.NQT_FE__c;
                        Check_CPR.NQT_FE__c = BckPer.NQT_Backup_Person__c;
                        CPR_List = CPR_List + Check_CPR.Name + ';';
                        Update_Check = TRUE;
                        }
                        
                    if(Check_CPR.NQT_Program_Manager__c == BckPer.OwnerId){
                        Check_CPR.NQT_Program_Manager_Backup__c = Check_CPR.NQT_Program_Manager__c;
                        Check_CPR.NQT_Program_Manager__c = BckPer.NQT_Backup_Person__c;
                        CPR_List = CPR_List + Check_CPR.Name + ';';
                        Update_Check = TRUE;
                        }
                        
                    /*if(Check_CPR.NQT_Project_Manager__c == BckPer.OwnerId){
                        Check_CPR.NQT_Project_Manager_Backup__c = Check_CPR.NQT_Project_Manager__c;
                        Check_CPR.NQT_Project_Manager__c = BckPer.NQT_Backup_Person__c;
                        CPR_List = CPR_List + Check_CPR.Name + ';';
                        Update_Check = TRUE;
                        }*/
                        
                    if(Check_CPR.NQT_SE__c == BckPer.OwnerId){
                        Check_CPR.NQT_SE_Backup__c = Check_CPR.NQT_SE__c;
                        Check_CPR.NQT_SE__c = BckPer.NQT_Backup_Person__c;
                        CPR_List = CPR_List + Check_CPR.Name + ';';
                        Update_Check = TRUE;
                        }
                        
                    if(Check_CPR.NQT_SE_MSC__c == BckPer.OwnerId){
                        Check_CPR.NQT_SE_MSC_Backup__c = Check_CPR.NQT_SE_MSC__c;
                        Check_CPR.NQT_SE_MSC__c = BckPer.NQT_Backup_Person__c;
                        CPR_List = CPR_List + Check_CPR.Name + ';';
                        Update_Check = TRUE;
                        }
                        
                    if(Update_Check == TRUE){
                        Check_CPR.NQT_Class_Access_Before__c = TRUE;
                        Check_CPR.NQT_Class_Access_After__c = TRUE;
                        updatedCPR.add(Check_CPR);
                        //update Check_CPR;
                        }
                    i++;
                    }
                BckPer.NQT_Related_CPR__c = CPR_List;
                if(!updatedCPR.isEmpty())
                    update updatedCPR;//}catch(exception e){}
                }
            

    for(NQT_Assign_Backup_Person__c BckPer : Trigger.New){
        if(BckPer.NQT_To__c != BckPer.NQT_From__c){
            if(BckPer.NQT_Availability_Status__c == 'Available' || BckPer.NQT_To__c == date.today())
                backupTo(BckPer);  
        }
        else
            if(BckPer.NQT_To__c == date.today()-1 || BckPer.NQT_Availability_Status__c == 'Available')
                backupTo(BckPer); 
    }            
    
    
    public void backupTo(NQT_Assign_Backup_Person__c BckPer){
        List<String> All_CPR = new List<String>();
        if(BckPer.NQT_Related_CPR__c != NULL)
            All_CPR = BckPer.NQT_Related_CPR__c.split(';', 0);
        List<CPR__c> CPR = new List<CPR__c>();
        if(!All_CPR.isEmpty())
            CPR = [SELECT Name, NQT_Account_Manager__c, NQT_FE__c, NQT_Program_Manager__c,
            NQT_Project_Manager__c, NQT_SE__c, NQT_SE_MSC__c FROM CPR__c WHERE
            Name IN: All_CPR];  
        Boolean Update_Check;
        if(!All_CPR.isEmpty())
            for(CPR__c Check_CPR : CPR){
                Update_Check = FALSE;
                if(Check_CPR.NQT_Account_Manager__c == BckPer.NQT_Backup_Person__c){
                    Check_CPR.NQT_Account_Manager__c = BckPer.OwnerId;
                    Update_Check = TRUE;
                    }
                    
                if(Check_CPR.NQT_FE__c == BckPer.NQT_Backup_Person__c){
                    Check_CPR.NQT_FE__c = BckPer.OwnerId;
                    Update_Check = TRUE;
                    }
                    
                if(Check_CPR.NQT_Program_Manager__c == BckPer.NQT_Backup_Person__c){
                    Check_CPR.NQT_Program_Manager__c = BckPer.OwnerId;
                    Update_Check = TRUE;
                    }
                    
                if(Check_CPR.NQT_Project_Manager__c == BckPer.NQT_Backup_Person__c){
                    Check_CPR.NQT_Project_Manager__c = BckPer.OwnerId;
                    Update_Check = TRUE;
                    }
                    
                if(Check_CPR.NQT_SE__c == BckPer.NQT_Backup_Person__c){
                    Check_CPR.NQT_SE__c = BckPer.OwnerId;
                    Update_Check = TRUE;
                    }
                    
                if(Check_CPR.NQT_SE_MSC__c == BckPer.NQT_Backup_Person__c){
                    Check_CPR.NQT_SE_MSC__c = BckPer.OwnerId;
                    Update_Check = TRUE;
                    }
                    
                if(Update_Check == TRUE){
                    Check_CPR.NQT_Class_Access_Before__c = TRUE;
                    Check_CPR.NQT_Class_Access_After__c = TRUE;
                    try{update Check_CPR;}catch(exception e){}
                    }
                }
        BckPer.NQT_Related_CPR__c = NULL;
        BckPer.NQT_Availability_Status__c = 'Available';
        }
}