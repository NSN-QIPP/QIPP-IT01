trigger CPR_Validation on CPR__c (before insert, Before update) {

if(trigger.isInsert && trigger.isBefore)
    for (CPR__c i: Trigger.new) {
            
    /*****Type of request Validation*****/
        if ((i.NQT_Type_Of_Request__c == 'Equipment Only' || i.NQT_Type_Of_Request__c =='Services and Equipment' ) && i.NQT_Customer_Requested_Ship_Date__c==null) {
            i.NQT_Customer_Requested_Ship_Date__c.addError('Customer Requested ship date is required');
            }       
    
                      
    /*****Account Manager Validation*****/  
        if (i.NQT_Account_Manager__c == NULL) {
            i.NQT_Account_Manager__c.addError('Account Manager is required');
            }
        /*else {
            Id AM = [SELECT Id FROM User WHERE Name =: i.NQT_Account_manager_Picklist__c LIMIT 1].Id;
            i.NQT_Account_manager__c = AM;
            }*/

                      
    /*****Program Manager Validation*****/              
        if (i.NQT_Program_Manager__c == NULL) {
            i.NQT_Program_Manager__c.addError('Program Manager is required');
            }
        /*else {
            Id PM = [SELECT Id FROM User WHERE Name =: i.NQT_Program_manager_Picklist__c LIMIT 1].Id;
            i.NQT_Program_manager__c = PM;
            }*/
    
    /*****Busineess Operation Validation********/
        Id Bus_OpDK, Bus_OpJG;
        Bus_OpDK = [SELECT Id FROM User WHERE Name =: 'Debbie Kelly' Limit 1].Id;
        Bus_OpJG = [SELECT Id FROM User WHERE Name =: 'Jolen Godlewski' Limit 1].Id;
        if(i.NQT_Area__c == 'West') {
            //Bus_Op = [SELECT Id FROM User WHERE Name =: 'Debbie Kelly' Limit 1].Id;
            i.NQT_Business_Operations__c = Bus_OpDK;
            }
            
        if(i.NQT_Area__c == 'Mid West'){
            //Bus_Op = [SELECT Id FROM User WHERE Name =: 'Debbie Kelly' Limit 1].Id;
            i.NQT_Business_Operations__c = Bus_OpDK;
            }
               
        if(i.NQT_Area__c == 'South'){
            //Bus_Op = [SELECT Id FROM User WHERE Name =: 'Jolen Godlewski' Limit 1].Id;
            i.NQT_Business_Operations__c = Bus_OpJG;
            }
               
        if(i.NQT_Area__c == 'Nationwide'){
            //Bus_Op = [SELECT Id FROM User WHERE Name =: 'Debbie Kelly' Limit 1].Id;
            i.NQT_Business_Operations__c = Bus_OpDK;
            }
               
        if(i.NQT_Area__c == 'North East'){
            //Bus_Op = [SELECT Id FROM User WHERE Name =: 'Jolen Godlewski' Limit 1].Id;
            i.NQT_Business_Operations__c = Bus_OpJG;
            }
               
            
   
    
    /*****MTSO Validation*****/
        Boolean Other_Selected = False;
        if(i.NQT_MTSO__c == NULL){
          /*  i.NQT_MTSO__c.addError('MTSO is required');*/
            }  
        else {
            List<String> Check_MTSO = i.NQT_MTSO__c.Split(';', 0);
            if(!Check_MTSO.isEmpty()){            
                for(String Check_Other : Check_MTSO)
                    if(Check_Other == 'Other'){
                        Other_Selected = TRUE;
                        if(i.NQT_If_Other_MTSO__c == NULL)
                            i.NQT_If_Other_MTSO__c.addError('Please enter value');
                    }
                }
            }
        if(i.NQT_If_Other_MTSO__c!=NULL && i.NQT_If_Other_MTSO__c != '' && Other_Selected == FALSE)
            i.NQT_If_Other_MTSO__c.addError('\'Other\' is not selected in MTSO');
            
    
    
    /***********************************Product Validation******************************************/
        Other_Selected = False;
        if(i.NQT_Product__c != NULL){
            List<String> Check_Product = i.NQT_Product__c.split(';', 0);
            if(!Check_Product.isEmpty())
                for(String Check_Other : Check_Product)
                    if(Check_Other == 'Other'){
                        Other_Selected = TRUE;
                        if(i.NQT_If_Other_Product__c == NULL)
                            i.NQT_If_Other_Product__c.addError('Please enter value');
                        }
            }
        if(Other_Selected == FALSE && i.NQT_If_Other_Product__c != NULL && i.NQT_If_Other_Product__c != '')
            i.NQT_If_Other_Product__c.addError('\'Other\' is not selected in Product');
           
           
            
    /*************************************Switch CLLI Validation****************************************/
        Other_Selected = FALSE;
        if(i.NQT_Switch_CLLI_Code__c != NULL){
            if(i.NQT_MTX_Ericsson__c != TRUE)
                i.NQT_Switch_CLLI_Code__c.addError('MTX Ericsson is not selcted in Products');
            else{
                List<String> Check_Switch_CLLI = i.NQT_Switch_CLLI_Code__c.Split(';', 0);            
                if(!Check_Switch_CLLI.isEmpty()){            
                    for(String Check_Other_Switch_CLLI : Check_Switch_CLLI){
                        if(Check_Other_Switch_CLLI == 'Other'){
                            Other_Selected = TRUE;
                            if(i.NQT_if_other__c == NULL)
                                i.NQT_if_other__c.addError('Please enter a value');
                        }
                    }    
                }
            }
        }
        if(i.NQT_if_other__c != NULL && i.NQT_if_other__c != '' && Other_Selected == FALSE)
                i.NQT_if_other__c.addError('\'Other\' is not selected in Switch CLLI code');
    
                         
    /*************************Area, Market, Am and PM Mapping validation************************/
    /*******************************************************************************************/
      /*  if (i.NQT_Area__c =='WEST' && i.NQT_Market__c=='Eugene'){                    
            id Am=[select id from user where name=:'Ashish Patel' limit 1].id;                
            i.NQT_Account_Manager__c=Am;
            }*/
        
    
    
    /***** NSN Required to Provide cablling Validation*****/    
        if (i.NQT_Is_NSN_Required_to_Provide_cablling__c == TRUE && i.NQT_Cabling_Location__c  == null)
            i.NQT_Cabling_Location__c.adderror('Please select a cabling location');
            
            
    /***** NSN Required to Provide cablling and Cable Type and Length(in Meter's) Validation*****/ 
        if (i.NQT_Is_NSN_Required_to_Provide_cablling__c == TRUE && i.NQT_Cabling_Location__c  != null && i.NQT_Cable_Type_and_Length_in_Meter_s__c==null)
            i.NQT_Cable_Type_and_Length_in_Meter_s__c.adderror('Please select a cabling location');
     
            
    /***** Database Work Needed Validation*****/         
        
        if (i.NQT_Database_Work_Needed__c == TRUE && i.NQT_Database_Work_Description__c==null)
            i.NQT_Database_Work_Description__c.adderror('Please enter Database Work Description');
       
        if (i.NQT_Database_Work_Needed__c == FALSE && i.NQT_Database_Work_Description__c != null )
            if(i.NQT_Database_Work_Needed__c == FALSE && i.NQT_Database_Work_Description__c != '')
                i.NQT_Database_Work_Description__c.adderror('Database Work Needed is not selected');  
      
      
       
    /***** Reparentin Work Needed Validation*****/  
        if (i.NQT_Reparenting_Work_Needed__c == TRUE && i.NQT_Reparenting_Work_Description__c==null)
            i.NQT_Reparenting_Work_Description__c.adderror('Please enter Reparenting Work Description');
       
    
            
            
    /*****Customer_Requested_Ship_Date Validation*****/        
        if (i.NQT_Customer_Requested_Ship_Date__c <date.today() ) {
            i.NQT_Customer_Requested_Ship_Date__c.addError('Please enter a date in future');
            }  
            
            
    /*****Target Service Start Date Validation*****/
        if (i.NQT_Target_Service_Start_Date__c <date.today() ) {
            i.NQT_Target_Service_Start_Date__c.addError('Please enter a date in future');
            }   
            
            
    /*****Target Service Finished Date Validation*****/
        if (i.NQT_Target_Service_Finish_Date__c <date.today() ) {
            i.NQT_Target_Service_Finish_Date__c.addError('Please enter a date in future');
            } 
            
            
        if (i.NQT_Requested_Quote_Delivery_Date__c <date.today() ) {
            i.NQT_Requested_Quote_Delivery_Date__c.addError('Please enter a date in future');
            }
            
        if (i.NQT_CPR_Start_Date__c >dateTime.Now() ) {
            i.NQT_CPR_Start_Date__c.addError('Please enter a date in past');
            }
            
    /**********validation for wrong input************/ 
        /*string Msg = 'Value should not be specified while submitting CPR';
        NQT_FE(Msg, i);
        NQT_SE(Msg, i);
        NQT_SE_MSC(Msg, i);
        NQT_Review_Deadline(Msg, i);
        NQT_Team_Assignment_Complet(Msg, i);
        NQT_FE_agree_to_the_completeness_of_CPR(Msg, i);
        NQT_SEM_agree_to_the_completeness_of_CPR(Msg, i);
        NQT_SE_agree_to_the_completeness_of_CPR(Msg, i);
        NQT_FE_Review_Comments(Msg, i);
        NQT_SE_MSC_Review_Comments(Msg, i);
        NQT_SE_Review_Comments(Msg, i);
        NQT_Agree_with_Customer_Requested_Quote(Msg, i);
        NQT_Has_the_CPR_been_Reviewed(Msg, i);
        NQT_Is_the_CPR_Complete_and_Accurate(Msg, i);
        NQT_FE_Deadline(Msg, i);
        NQT_SE_Deadline(Msg, i);
        NQT_SE_MSC_Deadline(Msg, i);
        NQT_Sales_Deadline(Msg, i);
        NQT_FE_Deliverables_submit(Msg, i);
        NQT_SE_Deliverables_Submitted(Msg, i);
        NQT_SE_MSC_Deliverables_Submitted(Msg, i);
        NQT_Field_Engineering(Msg, i);
        NQT_System_Engineering(Msg, i);
        NQT_System_MSC_Engineering(Msg, i);
        NQT_Please_enter_Reason_for_FE_Rework(Msg, i);
        NQT_Please_enter_Reason_for_SEMSC_Rework(Msg, i);
        NQT_Please_enter_Reason_for_SE_Rework(Msg, i);
        NQT_FE_Services(Msg, i);
        NQT_SE_Services(Msg, i);
        NQT_Equipment(Msg, i);
        NQT_I_Agree(Msg, i);
        NQT_Sales_AM(Msg, i);
        NQT_Please_enter_Reason_for_Sales_Rework(Msg, i);
        NQT_Close_Project(Msg, i);*/
        }
        
        
 
        
if(trigger.isUpdate)
        for(CPR__c wf: trigger.new){
        CPRfreeze(wf);
        section_validations(wf);
        teamChange(wf);
        customerCheck(wf);
        //CPRfreeze(wf);
        if(wf.NQT_Class_Access_Before__c != TRUE){
        if(wf.NQT_Class_Access_After__c != TRUE){
        if(wf.NQT_Project_Status__c != 'Customer Hold'&& wf.NQT_Project_Status__c != 'Cancelled' && wf.NQT_Project_Status__c != 'Quote Closed'){
                
        if(wf.NQT_Account_Manager__c == trigger.old[0].NQT_Account_Manager__c &&
            wf.NQT_Program_Manager__c == trigger.old[0].NQT_Program_Manager__c &&
            wf.NQT_Project_Manager__c == trigger.old[0].NQT_Project_Manager__c &&
            wf.NQT_FE__c == trigger.old[0].NQT_FE__c &&
            wf.NQT_SE__c == trigger.old[0].NQT_SE__c &&
            wf.NQT_SE_MSC__c == trigger.old[0].NQT_SE_MSC__c)
            {//section_validations(wf);
            //teamChange(wf);
            Validations(wf);
            }
        else    
            if(trigger.old[0].NQT_Project_Manager__c == NULL &&
                trigger.old[0].NQT_FE__c == NULL &&
                trigger.old[0].NQT_SE__c == NULL &&
                trigger.old[0].NQT_SE_MSC__c == NULL)
                {
                //section_validations(wf);
                //teamChange(wf);
                Validations(wf);}
        
           wf.NQT_CPR_Lock__c = TRUE;
           ///teamChange(wf);
               
           }
           else{
               wf.NQT_CPR_Lock__c = FALSE;
               }
           
            section_validations(wf);
           }
           else
               wf.NQT_Class_Access_After__c = FALSE;
           }
           else
               wf.NQT_Class_Access_Before__c = FALSE;
    }
    
    
public void Validations(CPR__c wf){
    
        if(wf.NQT_CPR_Lock__c == TRUE){
            Profile Profile_Name = [SELECT Name FROM Profile WHERE Id =: Userinfo.getProfileId() LIMIT 1];
            system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+Profile_Name);
 
            /*if(wf.NQT_Project_Manager__c == NULL &&
               wf.NQT_FE__c == NULL &&
               wf.NQT_SE__c == NULL &&
               wf.NQT_SE_MSC__c == NULL){
                wf.NQT_Project_Manager__c.adderror('Atleast 1 team member has to be selected.');
                wf.NQT_FE__c.adderror('Atleast 1 team member has to be selected.');
                wf.NQT_SE__c.adderror('Atleast 1 team member has to be selected.');
                wf.NQT_SE_MSC__c.adderror('Atleast 1 team member has to be selected.');
                }
            if(wf.SE_FE_SEMSC_Check__c == NULL)
                wf.SE_FE_SEMSC_Check__c = 0;*/
            if(wf.NQT_Review_Deadline__c == NULL &&(wf.NQT_FE__c != NULL ||
               wf.NQT_SE__c != NULL || wf.NQT_SE_MSC__c != NULL))
                wf.NQT_Review_Deadline__c.adderror('Enter a Review Deadline');
            /*if(wf.NQT_Team_Assignment_Completed__c == FALSE)*/
            if(wf.NQT_Review_Deadline__c<date.today() && wf.NQT_Review_Deadline__c!=NULL 
            && (wf.NQT_Project_Status__c=='Request Submitted'))
                wf.NQT_Review_Deadline__c.adderror('Enter a date in Future');

            if(wf.NQT_Please_enter_Reason_for_SE_Rework__c != NULL)
                wf.NQT_SE_Rework_Backup__c = wf.NQT_Please_enter_Reason_for_SE_Rework__c; 
            if(wf.NQT_Please_enter_Reason_for_SEMSC_Rework__c != NULL)            
                wf.NQT_SE_MSC_Rework_Backup__c = wf.NQT_Please_enter_Reason_for_SEMSC_Rework__c;
            if(wf.NQT_Please_enter_Reason_for_FE_Rework__c != NULL)
                wf.NQT_FE_Rework_Backup__c = wf.NQT_Please_enter_Reason_for_FE_Rework__c;
            if(wf.NQT_Please_enter_Reason_for_Sales_Rework__c != NULL)
                wf.NQT_Sales_Rework_Backup__c = wf.NQT_Please_enter_Reason_for_Sales_Rework__c;
                
    /****************Following lines are calculating the number of assigned engineers********************/
            if(wf.NQT_Team_Assignment_Complet__c == FALSE || wf.NQT_Team_Assignment_Completed__c == FALSE){
            if(wf.NQT_FE__c != NULL && wf.NQT_FE_Assigned__c == FALSE){
                wf.SE_FE_SEMSC_Check__c = wf.SE_FE_SEMSC_Check__c + 1;
                wf.NQT_FE_Assigned__c = TRUE;
                wf.FE_Assigned_Date__c = date.today();
                }
            if(wf.NQT_SE__c != NULL && wf.NQT_SE_Assigned__c == FALSE){
                wf.SE_FE_SEMSC_Check__c = wf.SE_FE_SEMSC_Check__c + 1;
                wf.NQT_SE_Assigned__c = TRUE;
                wf.SE_Assigned_Date__c = date.today();
                }
            if(wf.NQT_SE_MSC__c != NULL && wf.NQT_SE_MSC_Assigned__c == FALSE){
                wf.SE_FE_SEMSC_Check__c = wf.SE_FE_SEMSC_Check__c + 1;
                wf.NQT_SE_MSC_Assigned__c = TRUE;
                wf.SEMSC_Assigned_Date__c = date.today();
                }
            }
            
            if(wf.NQT_Project_Deliverable_Start__c == FALSE && wf.NQT_CPR_Review_Completed__c == TRUE){
            if(wf.NQT_SE_Rework_Backup__c == NULL &&
               wf.NQT_FE_Rework_Backup__c == NULL &&
               wf.NQT_SE_MSC_Rework_Backup__c == NULL){
            if(wf.NQT_FE__c != NULL){
                wf.NQT_SE_FE_SEMSC_Deliverable_Check__c = wf.NQT_SE_FE_SEMSC_Deliverable_Check__c + 1;
                wf.NQT_FE_Assigned__c = TRUE;
                }
            System.Debug('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+ wf.NQT_SE_FE_SEMSC_Deliverable_Check__c);
            if(wf.NQT_SE__c != NULL){
                wf.NQT_SE_FE_SEMSC_Deliverable_Check__c = wf.NQT_SE_FE_SEMSC_Deliverable_Check__c + 1;
                wf.NQT_SE_Assigned__c = TRUE;
                }
            if(wf.NQT_SE_MSC__c != NULL){
                wf.NQT_SE_FE_SEMSC_Deliverable_Check__c = wf.NQT_SE_FE_SEMSC_Deliverable_Check__c + 1;
                wf.NQT_SE_MSC_Assigned__c = TRUE;
                }
            wf.NQT_Project_Deliverable_Start__c = TRUE;
            }
            else {
                if(wf.NQT_FE__c != NULL && wf.NQT_FE_Rework_Backup__c != NULL){
                    wf.NQT_SE_FE_SEMSC_Deliverable_Check__c = wf.NQT_SE_FE_SEMSC_Deliverable_Check__c + 1;
                    wf.NQT_FE_Assigned__c = TRUE;
                    //wf.NQT_FE_Rework_Backup__c = NULL;
                    }
                    System.Debug('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+ wf.NQT_SE_FE_SEMSC_Deliverable_Check__c);
                if(wf.NQT_SE__c != NULL && wf.NQT_SE_Rework_Backup__c != NULL){
                    wf.NQT_SE_FE_SEMSC_Deliverable_Check__c = wf.NQT_SE_FE_SEMSC_Deliverable_Check__c + 1;
                    wf.NQT_SE_Assigned__c = TRUE;
                    //wf.NQT_SE_Rework_Backup__c = NULL;
                    }
                if(wf.NQT_SE_MSC__c != NULL && wf.NQT_SE_MSC_Rework_Backup__c != NULL){
                    wf.NQT_SE_FE_SEMSC_Deliverable_Check__c = wf.NQT_SE_FE_SEMSC_Deliverable_Check__c + 1;
                    wf.NQT_SE_MSC_Assigned__c = TRUE;
                    //wf.NQT_SE_MSC_Rework_Backup__c = NULL;
                    }
                wf.NQT_Project_Deliverable_Start__c = TRUE;
                }
            }
            
            
/****************************************Review Section Validation******************************************/       
            if(wf.NQT_FE_agree_to_the_completeness_of_CPR__c != NULL && wf.NQT_FE_Review_Comments__c == NULL)
                wf.NQT_FE_Review_Comments__c.addError('Please enter value');
            if(wf.NQT_FE_agree_to_the_completeness_of_CPR__c == NULL && wf.NQT_FE_Review_Comments__c != NULL)
                wf.NQT_FE_Review_Comments__c.addError('Please select I agree to the completeness of CPR');
            if(wf.NQT_FE__c == NULL && wf.NQT_FE_agree_to_the_completeness_of_CPR__c != NULL)
                wf.NQT_FE_agree_to_the_completeness_of_CPR__c.addError('FE is not assigned in team');
            if((wf.NQT_FE_agree_to_the_completeness_of_CPR__c != trigger.old[0].NQT_FE_agree_to_the_completeness_of_CPR__c
            || wf.NQT_FE_Review_Comments__c != trigger.old[0].NQT_FE_Review_Comments__c) && UserInfo.getUserId() != wf.NQT_FE__c)
                wf.NQT_FE_Review__c.addError('Insufficient Privilege to change FE Review');
            /*if(wf.NQT_FE__c == NULL && wf.NQT_FE_agree_to_the_completeness_of_CPR__c != NULL)
                wf.NQT_FE_agree_to_the_completeness_of_CPR__c.addError('FE is not assigned in team');*/
               
            if(wf.NQT_SE_agree_to_the_completeness_of_CPR__c != NULL && wf.NQT_SE_Review_Comments__c == NULL)
                wf.NQT_SE_Review_Comments__c.addError('Please enter value');
            if(wf.NQT_SE_agree_to_the_completeness_of_CPR__c == NULL && wf.NQT_SE_Review_Comments__c != NULL)
                wf.NQT_SE_Review_Comments__c.addError('Please select I agree to the completeness of CPR');
            if(wf.NQT_SE__c == NULL && wf.NQT_SE_agree_to_the_completeness_of_CPR__c != NULL)
                wf.NQT_SE_agree_to_the_completeness_of_CPR__c.addError('SE is not assigned in team');
            if((wf.NQT_SE_agree_to_the_completeness_of_CPR__c != trigger.old[0].NQT_SE_agree_to_the_completeness_of_CPR__c
            || wf.NQT_SE_Review_Comments__c != trigger.old[0].NQT_SE_Review_Comments__c) && UserInfo.getUserId() != wf.NQT_SE__c)
                wf.NQT_SE_Review__c.addError('Insufficient Privilege to change SE Review');
                    
            if(wf.NQT_SEM_agree_to_the_completeness_of_CPR__c != NULL && wf.NQT_SE_MSC_Review_Comments__c == NULL)
                wf.NQT_SE_MSC_Review_Comments__c.addError('Please enter value');
            if(wf.NQT_SEM_agree_to_the_completeness_of_CPR__c == NULL && wf.NQT_SE_MSC_Review_Comments__c != NULL)
                wf.NQT_SE_MSC_Review_Comments__c.addError('Please select I agree to the completeness of CPR');
            if(wf.NQT_SE_MSC__c == NULL && wf.NQT_SEM_agree_to_the_completeness_of_CPR__c != NULL)
                wf.NQT_SEM_agree_to_the_completeness_of_CPR__c.addError('SE MSC is not assigned in team');
            if((wf.NQT_SEM_agree_to_the_completeness_of_CPR__c != trigger.old[0].NQT_SEM_agree_to_the_completeness_of_CPR__c
            || wf.NQT_SE_MSC_Review_Comments__c != trigger.old[0].NQT_SE_MSC_Review_Comments__c) && UserInfo.getUserId() != wf.NQT_SE_MSC__c)
                wf.NQT_SE_MSC_Review__c.addError('Insufficient Privilege to change SE MSC Review');    
           
           
           /*******************TEST PART 2***********************************/
           
           if(wf.NQT_SE_Assigned__c == TRUE && wf.NQT_SE__c == NULL){
               wf.NQT_SE_Assigned__c = FALSE;
               wf.SE_FE_SEMSC_Check__c = wf.SE_FE_SEMSC_Check__c - 1;
               }
           if(wf.NQT_FE_Assigned__c == TRUE && wf.NQT_FE__c == NULL){
               wf.NQT_FE_Assigned__c = FALSE;
               wf.SE_FE_SEMSC_Check__c = wf.SE_FE_SEMSC_Check__c - 1;
               }
           if(wf.NQT_SE_MSC_Assigned__c == TRUE && wf.NQT_SE_MSC__c == NULL){
               wf.NQT_SE_MSC_Assigned__c = FALSE;
               wf.SE_FE_SEMSC_Check__c = wf.SE_FE_SEMSC_Check__c - 1;
               }
           
           if(wf.NQT_Team_Assignment_Completed__c == TRUE && wf.NQT_Team_Assignment_Complet__c == TRUE)
           if(wf.NQT_CPR_Review_Completed__c == false){
               if(wf.NQT_FE_Assigned__c == TRUE && wf.FE_Review_Completed__c == TRUE){
                   wf.SE_FE_SEMSC_Check__c = wf.SE_FE_SEMSC_Check__c - 1;
                   wf.NQT_FE_Assigned__c = FALSE;
                   }
               
               if(wf.NQT_SE_Assigned__c == TRUE && wf.SE_Review_Completed__c == TRUE){
                   wf.SE_FE_SEMSC_Check__c = wf.SE_FE_SEMSC_Check__c - 1;
                   wf.NQT_SE_Assigned__c = FALSE;
                   }
               
               if(wf.NQT_SE_MSC_Assigned__c == TRUE && wf.SE_MSC_Review_Completed__c == TRUE){
                   wf.SE_FE_SEMSC_Check__c = wf.SE_FE_SEMSC_Check__c - 1;
                   wf.NQT_SE_MSC_Assigned__c = FALSE;
                   }
               
               if(wf.SE_FE_SEMSC_Check__c == 0){
                   wf.NQT_CPR_Review_Completed__c = TRUE;
                   
                   
                   }
               }
          
           
           
/***********************PM Review and Assign Project Milestones Section Validation*************************/            
           
           if(wf.NQT_Team_Assignment_Completed__c == TRUE && wf.NQT_CPR_Review_Completed__c == TRUE){
               if(wf.NQT_Project_Milestone_Start__c == TRUE){
                   if(wf.NQT_Is_the_CPR_Complete_and_Accurate__c != 'NO'){
                       if(wf.NQT_FE__c != NULL && wf.NQT_FE_Deadline__c == NULL)
                           wf.NQT_FE_Deadline__c.addError('Please enter FE Deadline');
                            if(wf.NQT_FE_Deadline__c<date.today() && wf.NQT_FE_Deadline__c!=NULL
                            && (wf.NQT_Deliverable_Status__c=='Determine Deadline'))
                              wf.NQT_FE_Deadline__c.adderror('Enter a date in Future');
                       if(wf.NQT_FE__c == NULL && wf.NQT_FE_Deadline__c != NULL)
                           wf.NQT_FE_Deadline__c.addError('FE is not selected in Assign Project Team section');
                        
                       if(wf.NQT_SE__c != NULL && wf.NQT_SE_Deadline__c == NULL)
                           wf.NQT_SE_Deadline__c.addError('Please enter SE Deadline');
                       if(wf.NQT_SE_Deadline__c<date.today() &&  wf.NQT_SE_Deadline__c!=NULL
                       && (wf.NQT_Deliverable_Status__c=='Determine Deadline'))
                           wf.NQT_SE_Deadline__c.adderror('Enter a date in Future');
                       if(wf.NQT_SE__c == NULL && wf.NQT_SE_Deadline__c != NULL)
                           wf.NQT_SE_Deadline__c.addError('SE is not selected in Assign Project Team section');
                        
                       if(wf.NQT_SE_MSC__c != NULL && wf.NQT_SE_MSC_Deadline__c == NULL)
                           wf.NQT_SE_MSC_Deadline__c.addError('Please enter SE MSC Deadline');
                       if(wf.NQT_SE_MSC_Deadline__c<date.today() &&  wf.NQT_SE_MSC_Deadline__c!=NULL
                       && (wf.NQT_Deliverable_Status__c=='Determine Deadline'))
                           wf.NQT_SE_MSC_Deadline__c.adderror('Enter a date in Future');
                       if(wf.NQT_SE_MSC__c == NULL && wf.NQT_SE_MSC_Deadline__c != NULL)
                           wf.NQT_SE_MSC_Deadline__c.addError('SE MSC is not selected in Assign Project Team section');
                           
                       if(wf.NQT_Sales_Deadline__c == NULL)
                           wf.NQT_Sales_Deadline__c.addError('Please enter Sales Deadline');
                           if(wf.NQT_Sales_Deadline__c<date.today() &&  wf.NQT_Sales_Deadline__c!=NULL
                           && (wf.NQT_Deliverable_Status__c=='Determine Deadline'))
                              wf.NQT_Sales_Deadline__c.adderror('Enter a date in Future');
                       }
                   else {
                       if(wf.NQT_FE_Deadline__c != NULL)
                           wf.NQT_FE_Deadline__c.addError('Value shoudn\'t be specified if \'NO\'is selected in \'Is the CPR Complete and Accurate?\'');
                       if(wf.NQT_SE_Deadline__c != NULL)
                           wf.NQT_SE_Deadline__c.addError('Value shoudn\'t be specified if \'NO\'is selected in \'Is the CPR Complete and Accurate?\'');
                       if(wf.NQT_SE_MSC_Deadline__c != NULL)
                           wf.NQT_SE_MSC_Deadline__c.addError('Value shoudn\'t be specified if \'NO\'is selected in \'Is the CPR Complete and Accurate?\'');
                       if(wf.NQT_Sales_Deadline__c != NULL)
                           wf.NQT_Sales_Deadline__c.addError('Value shoudn\'t be specified if \'NO\'is selected in \'Is the CPR Complete and Accurate?\'');
                       }
                
                if(wf.NQT_Agree_with_Customer_Requested_Quote__c == '' || wf.NQT_Agree_with_Customer_Requested_Quote__c == NULL)
                    wf.NQT_Agree_with_Customer_Requested_Quote__c.addError('Please select a value');
               /* if(wf.NQT_Is_the_CPR_Complete_and_Accurate__c == '' || wf.NQT_Is_the_CPR_Complete_and_Accurate__c == NULL)
                    wf.NQT_Is_the_CPR_Complete_and_Accurate__c.addError('Please enter a value'); */
                if(wf.NQT_Has_the_CPR_been_Reviewed__c == '' || wf.NQT_Has_the_CPR_been_Reviewed__c == NULL)
                    wf.NQT_Has_the_CPR_been_Reviewed__c.addError('Please select a value');
            }
            else{
                /*if(wf.NQT_FE_agree_to_the_completeness_of_CPR__c != 'NO' &&
                wf.NQT_SEM_agree_to_the_completeness_of_CPR__c != 'NO' &&
                wf.NQT_SE_agree_to_the_completeness_of_CPR__c != 'NO'){*/
                    wf.NQT_Project_Milestone_Start__c = TRUE;
                    if(wf.NQT_Program_Manager__c != null){
                        EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'NQT_VF_template'];
                        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                        list<String> EmailAddr = new list<String>();
                        //if(wf.NQT_Program_Manager__c != null)
                        EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_Account_Manager__c LIMIT 1].Email); 
                        EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_Program_Manager__c LIMIT 1].Email);
                        email.setToAddresses(EmailAddr);    
                        email.setTargetObjectId(wf.NQT_Program_Manager__c);
                        email.setWhatId(wf.id);     
                        email.setSaveAsActivity(false);            
                        email.setTemplateId(et.id);            
                        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
                        }
                    wf.NQT_Deliverable_Status__c = 'Determine Deadline'; 
                    //}
                }
           }
           if(wf.NQT_Team_Assignment_Completed__c == TRUE && wf.NQT_CPR_Review_Completed__c == TRUE)
           {
               if(wf.NQT_Project_Milestone_End__c == TRUE){
                   if(wf.NQT_Project_Deliverable_Complete__c == TRUE){
                       if(wf.NQT_Sales_Deliverable_Start__c == TRUE){
                           
                           if(wf.NQT_System_Engineering__c == NULL &&
                              wf.NQT_System_MSC_Engineering__c == NULL &&
                              wf.NQT_Field_Engineering__c == NULL){
                               if(wf.NQT_FE_Services__c == NULL)
                                   wf.NQT_FE_Services__c.addError('Please enter value');
                               if(wf.NQT_Equipment__c == NULL)
                                   wf.NQT_Equipment__c.addError('Please enter value');
                               if(wf.NQT_SE_Services__c == NULL)
                                   wf.NQT_SE_Services__c.addError('Please enter Value');
                               if(wf.NQT_I_Agree__c == FALSE)
                                   wf.NQT_I_Agree__c.addError('Please select the box');
                               }
                               }
                           else
                               wf.NQT_Sales_Deliverable_Start__c = TRUE;
                           }
                   }       
                
           if(wf.NQT_Project_Milestone_End__c == TRUE)
               if(wf.NQT_Project_Deliverable_Complete__c == false){
                   if(wf.NQT_FE_Assigned__c == TRUE && wf.NQT_FE_Deliverables_submit__c == TRUE){
                       wf.NQT_SE_FE_SEMSC_Deliverable_Check__c = wf.NQT_SE_FE_SEMSC_Deliverable_Check__c - 1;
                       wf.FE_Submitted_Date__c = date.today();
                       wf.NQT_FE_Assigned__c = FALSE;
                       }
                   
                   if(wf.NQT_SE_Assigned__c == TRUE && wf.NQT_SE_Deliverables_Submitted__c == TRUE){
                       wf.NQT_SE_FE_SEMSC_Deliverable_Check__c = wf.NQT_SE_FE_SEMSC_Deliverable_Check__c - 1;
                       wf.SE_Submitted_Date__c = date.today();
                       wf.NQT_SE_Assigned__c = FALSE;
                       }
                   
                   if(wf.NQT_SE_MSC_Assigned__c == TRUE && wf.NQT_SE_MSC_Deliverables_Submitted__c == TRUE){
                       wf.NQT_SE_FE_SEMSC_Deliverable_Check__c = wf.NQT_SE_FE_SEMSC_Deliverable_Check__c - 1;
                       wf.SEMSC_Submitted_Date__c = date.today();
                       wf.NQT_SE_MSC_Assigned__c = FALSE;
                       }
                   
                   if(wf.NQT_SE_FE_SEMSC_Deliverable_Check__c == 0){
                       wf.NQT_Project_Deliverable_Complete__c = TRUE;
                       //wf.NQT_Sales_Deliverable_Start__c = TRUE;
                       wf.NQT_Deliverable_Status__c = 'Sales Deliverable';
                       wf.NQT_Project_Status__c = 'Quote Generation';
                       wf.Quote_Generation_Date__c = datetime.now();
                       if(wf.NQT_Program_Manager__c != null){ 
                           EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'NQT_ENGINEERING_Deliverable_Completed'];
                           Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                           list<String> EmailAddr = new list<String>();
                           
                           EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_Account_Manager__c LIMIT 1].Email); 
                           EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_Program_Manager__c LIMIT 1].Email);
                           
                           
                           email.setToAddresses(EmailAddr);    
                           email.setTargetObjectId(wf.NQT_Program_Manager__c);
                           email.setTargetObjectId(wf.NQT_Account_Manager__c);
                           email.setWhatId(wf.id);     
                           email.setSaveAsActivity(false);            
                           email.setTemplateId(et.id);            
                           Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
                           
                           /*et = [SELECT id FROM EmailTemplate WHERE developerName = 'NQT_ENGINEERING_Deliverable_Completed'];
                           email = new Messaging.SingleEmailMessage();
                           EmailAddr = new list<String>();
                           EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_Account_Manager__c LIMIT 1].Email); 
                           EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_Program_Manager__c LIMIT 1].Email); 
                           
                           email.setToAddresses(EmailAddr);    
                           email.setTargetObjectId(wf.NQT_Program_Manager__c);
                           email.setTargetObjectId(wf.NQT_Account_Manager__c);
                           email.setWhatId(wf.id);     
                           email.setSaveAsActivity(false);            
                           email.setTemplateId(et.id);            
                           Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});*/
                           
                          } 
                       }
                   }
                }
           }      
    }
    
    public void CPRfreeze(CPR__c wf){if(wf.NQT_Class_Access_Before__c != TRUE && wf.NQT_Class_Access_After__c != TRUE){
        /*if(wf.NQT_Project_Status__c == 'Cancelled'){
            string Msg = 'This CPR is Cancelled. Value can\'t be changed';
            NQT_CPR_Name(Msg, wf); 
            NQT_Type_Of_Request(Msg, wf); 
            NQT_Customer_contact_Name(Msg, wf); 
            NQT_CPR_Start_Date(Msg, wf); 
            NQT_Customer_Contact_Phone(Msg, wf); 
            NQT_Customer_Email_Address(Msg, wf); 
            NQT_Area(Msg, wf); 
            NQT_Market(Msg, wf); 
            NQT_MTSO(Msg, wf); 
            NQT_Account_manager_Picklist(Msg, wf); 
            NQT_If_Other_MTSO(Msg, wf); 
            NQT_Program_Manager_Picklist(Msg, wf); 
            NQT_Product(Msg, wf); 
            NQT_Switch_CLLI_Code(Msg, wf); 
            NQT_MTX_Ericsson(Msg, wf); 
            NQT_if_other(Msg, wf); 
            NQT_If_Other_Product(Msg, wf); 
            NQT_Is_NSN_Required_to_Provide_cablling(Msg, wf); 
            NQT_Database_Work_Needed(Msg, wf); 
            NQT_Cabling_Location(Msg, wf); 
            NQT_Database_Work_Description(Msg, wf); 
            NQT_Cable_Type_and_Length_in_Meter_s(Msg, wf); 
            NQT_Reparenting_Work_Needed(Msg, wf); 
            NQT_Installation_and_Additional_Details(Msg, wf); 
            NQT_Reparenting_Work_Description(Msg, wf); 
            NQT_Requested_Quote_Delivery_Date(Msg, wf); 
            NQT_Target_Service_Start_Date(Msg, wf); 
            NQT_Customer_Requested_Ship_Date(Msg, wf);
            NQT_Target_Service_Finish_Date(Msg, wf);
            NQT_FE_agree_to_the_completeness_of_CPR1(Msg, wf);
            NQT_SEM_agree_to_the_completeness_of_CPR1(Msg, wf);
            NQT_SE_agree_to_the_completeness_of_CPR1(Msg, wf);
            NQT_FE_Review_Comments1(Msg, wf);
            NQT_SE_MSC_Review_Comments1(Msg, wf);
            NQT_SE_Review_Comments1(Msg, wf);
            NQT_Agree_with_Customer_Requested_Quote1(Msg, wf);
            NQT_Has_the_CPR_been_Reviewed1(Msg, wf);
            NQT_Is_the_CPR_Complete_and_Accurate1(Msg, wf);
            NQT_FE_Deadline1(Msg, wf);
            NQT_SE_Deadline1(Msg, wf);
            NQT_SE_MSC_Deadline1(Msg, wf);
            NQT_Sales_Deadline1(Msg, wf);
            NQT_FE_Deliverables_submit1(Msg, wf);
            NQT_SE_Deliverables_Submitted1(Msg, wf);
            NQT_SE_MSC_Deliverables_Submitted1(Msg, wf);
            NQT_Field_Engineering1(Msg, wf);
            NQT_System_Engineering1(Msg, wf);
            NQT_System_MSC_Engineering1(Msg, wf);
            NQT_Please_enter_Reason_for_FE_Rework1(Msg, wf);
            NQT_Please_enter_Reason_for_SEMSC_Rework1(Msg, wf);
            NQT_Please_enter_Reason_for_SE_Rework1(Msg, wf);
            NQT_FE_Services1(Msg, wf);
            NQT_SE_Services1(Msg, wf);
            NQT_Equipment1(Msg, wf);
            NQT_I_Agree1(Msg, wf);
            NQT_Sales_AM1(Msg, wf);
            NQT_Please_enter_Reason_for_Sales_Rework1(Msg, wf);
            NQT_Close_Project1(Msg, wf);
            NQT_FE1(Msg, wf);
            NQT_SE1(Msg, wf);
            NQT_SE_MSC1(Msg, wf);
            NQT_Review_Deadline1(Msg, wf);
            NQT_Team_Assignment_Complet1(Msg, wf);
            }*/
            
        if(wf.NQT_Project_Status__c == 'Customer Hold'){
            id profileId = UserInfo.getProfileId();
            String profileName = [SELECT Name FROM Profile WHERE Id =: profileId LIMIT 1].Name;
            /*if((profileName == 'Nokia NQT Customer' || profileName == 'Nokia NQT Account Manager'
                || profileName == 'Nokia NQT Program Manager') && wf.NQT_Project_Status__c != 'Customer Hold')*/
            if(wf.Customer_Hold__c == TRUE && wf.Workflow_Run__c != TRUE){
               //Changed profile names from Old to New by Sunanda on 05-MARCH-2014
                if((profileName == ' Nokia - NQT Customer ' || profileName == 'Nokia - NQT Account Manager'
                || profileName == ' Nokia - NQT Program Manager' || profileName == 'System Administrator') && wf.Customer_Hold__c == TRUE 
                && wf.Workflow_Run__c != TRUE){
                    wf.Customer_Hold__c = FALSE;
                    wf.NQT_Project_Status__c = wf.Project_Status_Backup__c;
                    System.Debug('project status ' + wf.Project_Status_Backup__c );
                    wf.NQT_Deliverable_Status__c = wf.Deliverable_Status_Backup__c;
                     System.Debug('Deliverable status ' + wf.Deliverable_Status_Backup__c );
                    wf.RecordTypeId = [SELECT Id FROM RecordType WHERE developerName = 'CPR_Open' LIMIT 1].Id;
                    
                    User Customer = [SELECT ProfileId, Email FROM User WHERE Id =: wf.OwnerId LIMIT 1];
                    String Profile = [SELECT Name FROM Profile WHERE Id =: Customer.ProfileId LIMIT 1].Name;
                    EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'NQT_Customer_Hold_Release'];
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    list<String> EmailAddr = new list<String>();
                   
                    //if(wf.NQT_Account_Manager__r.Email != NULL)
                        EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_Account_Manager__c LIMIT 1].Email); 
                    //if(wf.NQT_Program_Manager__r.Email != NULL)
                        EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_Program_Manager__c LIMIT 1].Email);
                    if(wf.NQT_SE__c != NULL)
                        EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_SE__c LIMIT 1].Email);
                    if(wf.NQT_FE__c != NULL)
                        EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_FE__c LIMIT 1].Email);
                    if(wf.NQT_SE_MSC__c != NULL)
                        EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_SE_MSC__c LIMIT 1].Email);
                    if(Profile.contains('Customer'))
                        EmailAddr.add(Customer.Email);
                    
                    email.setToAddresses(EmailAddr);    
                    email.setTargetObjectId(wf.NQT_Account_Manager__c);
                    email.setWhatId(wf.id);     
                    email.setSaveAsActivity(false);            
                    email.setTemplateId(et.id);  
                    if(wf.NQT_Account_Manager__c != NULL)          
                        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
                    }
                else
                    wf.addError('Insufficient privilege to save CPR');
                }
            /*string Msg = 'CPR is in Customer Hold';
            NQT_FE_agree_to_the_completeness_of_CPR1(Msg, wf);
            NQT_SEM_agree_to_the_completeness_of_CPR1(Msg, wf);
            NQT_SE_agree_to_the_completeness_of_CPR1(Msg, wf);
            NQT_FE_Review_Comments1(Msg, wf);
            NQT_SE_MSC_Review_Comments1(Msg, wf);
            NQT_SE_Review_Comments1(Msg, wf);
            NQT_Agree_with_Customer_Requested_Quote1(Msg, wf);
            NQT_Has_the_CPR_been_Reviewed1(Msg, wf);
            NQT_Is_the_CPR_Complete_and_Accurate1(Msg, wf);
            NQT_FE_Deadline1(Msg, wf);
            NQT_SE_Deadline1(Msg, wf);
            NQT_SE_MSC_Deadline1(Msg, wf);
            NQT_Sales_Deadline1(Msg, wf);
            NQT_FE_Deliverables_submit1(Msg, wf);
            NQT_SE_Deliverables_Submitted1(Msg, wf);
            NQT_SE_MSC_Deliverables_Submitted1(Msg, wf);
            NQT_Field_Engineering1(Msg, wf);
            NQT_System_Engineering1(Msg, wf);
            NQT_System_MSC_Engineering1(Msg, wf);
            NQT_Please_enter_Reason_for_FE_Rework1(Msg, wf);
            NQT_Please_enter_Reason_for_SEMSC_Rework1(Msg, wf);
            NQT_Please_enter_Reason_for_SE_Rework1(Msg, wf);
            NQT_FE_Services1(Msg, wf);
            NQT_SE_Services1(Msg, wf);
            NQT_Equipment1(Msg, wf);
            NQT_I_Agree1(Msg, wf);
            NQT_Sales_AM1(Msg, wf);
            NQT_Please_enter_Reason_for_Sales_Rework1(Msg, wf);
            NQT_Close_Project1(Msg, wf);
            NQT_FE1(Msg, wf);
            NQT_SE1(Msg, wf);
            NQT_SE_MSC1(Msg, wf);
            NQT_Review_Deadline1(Msg, wf);
            NQT_Team_Assignment_Complet1(Msg, wf);*/
            }
        
        /*if(wf.NQT_Project_Status__c == 'Quote Closed'){
            string Msg = 'This CPR is in Quote Closed status. Value can\'t be changed';
            NQT_CPR_Name(Msg, wf); 
            NQT_Type_Of_Request(Msg, wf); 
            NQT_Customer_contact_Name(Msg, wf); 
            NQT_CPR_Start_Date(Msg, wf); 
            NQT_Customer_Contact_Phone(Msg, wf); 
            NQT_Customer_Email_Address(Msg, wf); 
            NQT_Area(Msg, wf); 
            NQT_Market(Msg, wf); 
            NQT_MTSO(Msg, wf); 
            NQT_Account_manager_Picklist(Msg, wf); 
            NQT_If_Other_MTSO(Msg, wf); 
            NQT_Program_Manager_Picklist(Msg, wf); 
            NQT_Product(Msg, wf); 
            NQT_Switch_CLLI_Code(Msg, wf); 
            NQT_MTX_Ericsson(Msg, wf); 
            NQT_if_other(Msg, wf); 
            NQT_If_Other_Product(Msg, wf); 
            NQT_Is_NSN_Required_to_Provide_cablling(Msg, wf); 
            NQT_Database_Work_Needed(Msg, wf); 
            NQT_Cabling_Location(Msg, wf); 
            NQT_Database_Work_Description(Msg, wf); 
            NQT_Cable_Type_and_Length_in_Meter_s(Msg, wf); 
            NQT_Reparenting_Work_Needed(Msg, wf); 
            NQT_Installation_and_Additional_Details(Msg, wf); 
            NQT_Reparenting_Work_Description(Msg, wf); 
            NQT_Requested_Quote_Delivery_Date(Msg, wf); 
            NQT_Target_Service_Start_Date(Msg, wf); 
            NQT_Customer_Requested_Ship_Date(Msg, wf);
            NQT_Target_Service_Finish_Date(Msg, wf);
            NQT_FE_agree_to_the_completeness_of_CPR1(Msg, wf);
            NQT_SEM_agree_to_the_completeness_of_CPR1(Msg, wf);
            NQT_SE_agree_to_the_completeness_of_CPR1(Msg, wf);
            NQT_FE_Review_Comments1(Msg, wf);
            NQT_SE_MSC_Review_Comments1(Msg, wf);
            NQT_SE_Review_Comments1(Msg, wf);
            NQT_Agree_with_Customer_Requested_Quote1(Msg, wf);
            NQT_Has_the_CPR_been_Reviewed1(Msg, wf);
            NQT_Is_the_CPR_Complete_and_Accurate1(Msg, wf);
            NQT_FE_Deadline1(Msg, wf);
            NQT_SE_Deadline1(Msg, wf);
            NQT_SE_MSC_Deadline1(Msg, wf);
            NQT_Sales_Deadline1(Msg, wf);
            NQT_FE_Deliverables_submit1(Msg, wf);
            NQT_SE_Deliverables_Submitted1(Msg, wf);
            NQT_SE_MSC_Deliverables_Submitted1(Msg, wf);
            NQT_Field_Engineering1(Msg, wf);
            NQT_System_Engineering1(Msg, wf);
            NQT_System_MSC_Engineering1(Msg, wf);
            NQT_Please_enter_Reason_for_FE_Rework1(Msg, wf);
            NQT_Please_enter_Reason_for_SEMSC_Rework1(Msg, wf);
            NQT_Please_enter_Reason_for_SE_Rework1(Msg, wf);
            NQT_FE_Services1(Msg, wf);
            NQT_SE_Services1(Msg, wf);
            NQT_Equipment1(Msg, wf);
            NQT_I_Agree1(Msg, wf);
            NQT_Sales_AM1(Msg, wf);
            NQT_Please_enter_Reason_for_Sales_Rework1(Msg, wf);
            NQT_Close_Project1(Msg, wf);
            NQT_FE1(Msg, wf);
            NQT_SE1(Msg, wf);
            NQT_SE_MSC1(Msg, wf);
            NQT_Review_Deadline1(Msg, wf);
            NQT_Team_Assignment_Complet1(Msg, wf);
            }*/
        }}
    
    public void section_validations(CPR__c wf){if(wf.NQT_Class_Access_Before__c != TRUE && wf.NQT_Class_Access_After__c != TRUE){
        system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:'+wf.NQT_Deliverable_Status__c);
        if(wf.NQT_Project_Status__c == 'Request Submitted' && wf.NQT_Deliverable_Status__c == 'Assign'){
            string Msg = 'Value should not be specified while Assigning Team';
            wf.RecordTypeId = [SELECT Id FROM RecordType WHERE developerName = 'CPR_Team_Assignment' LIMIT 1].Id;
            /*NQT_FE_agree_to_the_completeness_of_CPR(Msg, wf);
            NQT_SEM_agree_to_the_completeness_of_CPR(Msg, wf);
            NQT_SE_agree_to_the_completeness_of_CPR(Msg, wf);
            NQT_FE_Review_Comments(Msg, wf);
            NQT_SE_MSC_Review_Comments(Msg, wf);
            NQT_SE_Review_Comments(Msg, wf);
            NQT_Agree_with_Customer_Requested_Quote(Msg, wf);
            NQT_Has_the_CPR_been_Reviewed(Msg, wf);
            NQT_Is_the_CPR_Complete_and_Accurate(Msg, wf);
            NQT_FE_Deadline(Msg, wf);
            NQT_SE_Deadline(Msg, wf);
            NQT_SE_MSC_Deadline(Msg, wf);
            NQT_Sales_Deadline(Msg, wf);
            NQT_FE_Deliverables_submit(Msg, wf);
            NQT_SE_Deliverables_Submitted(Msg, wf);
            NQT_SE_MSC_Deliverables_Submitted(Msg, wf);
            NQT_Field_Engineering(Msg, wf);
            NQT_System_Engineering(Msg, wf);
            NQT_System_MSC_Engineering(Msg, wf);
            NQT_Please_enter_Reason_for_FE_Rework(Msg, wf);
            NQT_Please_enter_Reason_for_SEMSC_Rework(Msg, wf);
            NQT_Please_enter_Reason_for_SE_Rework(Msg, wf);
            NQT_FE_Services(Msg, wf);
            NQT_SE_Services(Msg, wf);
            NQT_Equipment(Msg, wf);
            NQT_I_Agree(Msg, wf);
            NQT_Sales_AM(Msg, wf);
            NQT_Please_enter_Reason_for_Sales_Rework(Msg, wf);
            NQT_Close_Project(Msg, wf);*/
            }
            
        if(wf.NQT_Project_Status__c == 'Request In-Review' && wf.NQT_Deliverable_Status__c == 'In Review'){
            string Msg = 'Value should not be specified while Reviewing CPR';
            wf.RecordTypeId = [SELECT Id FROM RecordType WHERE developerName = 'CPR_Review' LIMIT 1].Id;
            /*NQT_Agree_with_Customer_Requested_Quote(Msg, wf);
            NQT_Has_the_CPR_been_Reviewed(Msg, wf);
            NQT_Is_the_CPR_Complete_and_Accurate(Msg, wf);
            NQT_FE_Deadline(Msg, wf);
            NQT_SE_Deadline(Msg, wf);
            NQT_SE_MSC_Deadline(Msg, wf);
            NQT_Sales_Deadline(Msg, wf);
            NQT_FE_Deliverables_submit(Msg, wf);
            NQT_SE_Deliverables_Submitted(Msg, wf);
            NQT_SE_MSC_Deliverables_Submitted(Msg, wf);
            NQT_Field_Engineering(Msg, wf);
            NQT_System_Engineering(Msg, wf);
            NQT_System_MSC_Engineering(Msg, wf);
            NQT_Please_enter_Reason_for_FE_Rework(Msg, wf);
            NQT_Please_enter_Reason_for_SEMSC_Rework(Msg, wf);
            NQT_Please_enter_Reason_for_SE_Rework(Msg, wf);
            NQT_FE_Services(Msg, wf);
            NQT_SE_Services(Msg, wf);
            NQT_Equipment(Msg, wf);
            NQT_I_Agree(Msg, wf);
            NQT_Sales_AM(Msg, wf);
            NQT_Please_enter_Reason_for_Sales_Rework(Msg, wf);
            NQT_Close_Project(Msg, wf);*/
            }
            
        if(wf.NQT_Project_Status__c == 'Request In-Review' && wf.NQT_Deliverable_Status__c == 'Determine Deadline'){
            string Msg = 'Value should not be specified while Determining Deadline';
            wf.RecordTypeId = [SELECT Id FROM RecordType WHERE developerName = 'CPR_Milestone' LIMIT 1].Id;
            /*NQT_FE_Deliverables_submit(Msg, wf);
            NQT_SE_Deliverables_Submitted(Msg, wf);
            NQT_SE_MSC_Deliverables_Submitted(Msg, wf);
            NQT_Field_Engineering(Msg, wf);
            NQT_System_Engineering(Msg, wf);
            NQT_System_MSC_Engineering(Msg, wf);
            NQT_Please_enter_Reason_for_FE_Rework(Msg, wf);
            NQT_Please_enter_Reason_for_SEMSC_Rework(Msg, wf);
            NQT_Please_enter_Reason_for_SE_Rework(Msg, wf);
            NQT_FE_Services(Msg, wf);
            NQT_SE_Services(Msg, wf);
            NQT_Equipment(Msg, wf);
            NQT_I_Agree(Msg, wf);
            NQT_Sales_AM(Msg, wf);
            NQT_Please_enter_Reason_for_Sales_Rework(Msg, wf);
            NQT_Close_Project(Msg, wf);*/
            }
            
        if(wf.NQT_Project_Status__c == 'Engineering Assigned' && wf.NQT_Deliverable_Status__c == 'Engineering Deliverable'){
            string Msg = 'Value should not be specified while Submitting Deliverables';
            wf.RecordTypeId = [SELECT Id FROM RecordType WHERE developerName = 'CPR_Project_Deliverables' LIMIT 1].Id;
            /*NQT_Field_Engineering(Msg, wf);
            NQT_System_Engineering(Msg, wf);
            NQT_System_MSC_Engineering(Msg, wf);
            NQT_Please_enter_Reason_for_FE_Rework(Msg, wf);
            NQT_Please_enter_Reason_for_SEMSC_Rework(Msg, wf);
            NQT_Please_enter_Reason_for_SE_Rework(Msg, wf);
            NQT_FE_Services(Msg, wf);
            NQT_SE_Services(Msg, wf);
            NQT_Equipment(Msg, wf);
            NQT_I_Agree(Msg, wf);
            NQT_Sales_AM(Msg, wf);
            NQT_Please_enter_Reason_for_Sales_Rework(Msg, wf);
            NQT_Close_Project(Msg, wf);*/
            }
            
        if(wf.NQT_Project_Status__c == 'Quote Generation' && wf.NQT_Deliverable_Status__c == 'Sales Deliverable'){
            string Msg = 'Value should not be specified while Submitting Deliverables';
            wf.RecordTypeId = [SELECT Id FROM RecordType WHERE developerName = 'CPR_Sales_Deliverables' LIMIT 1].Id;
            /*NQT_Sales_AM(Msg, wf);
            NQT_Please_enter_Reason_for_Sales_Rework(Msg, wf);
            NQT_Close_Project(Msg, wf);*/
            }
        
        if(wf.NQT_Project_Status__c == 'Quote Submitted'){
            wf.RecordTypeId = [SELECT Id FROM RecordType WHERE developerName = 'CPR_Update_Project' LIMIT 1].Id;
            }
                
        if(wf.NQT_Project_Status__c == 'Quote Closed'){
            wf.RecordTypeId = [SELECT Id FROM RecordType WHERE developerName = 'CPR_Closed_Cancelled' LIMIT 1].Id;
            }
 if(wf.NQT_Project_Status__c == 'Cancelled'){
            wf.RecordTypeId = [SELECT Id FROM RecordType WHERE developerName = 'CPR_Closed_Cancelled' LIMIT 1].Id;
            }
    }}
    
    public void teamChange(CPR__c wf){if(wf.NQT_Class_Access_Before__c != TRUE && wf.NQT_Class_Access_After__c != TRUE){
        if(wf.NQT_SE_Assigned__c == TRUE && wf.NQT_SE__c == NULL){
            wf.NQT_SE_Assigned__c = FALSE;
            wf.SE_FE_SEMSC_Check__c = wf.SE_FE_SEMSC_Check__c - 1;
            }
        if(wf.NQT_FE_Assigned__c == TRUE && wf.NQT_FE__c == NULL){
            wf.NQT_FE_Assigned__c = FALSE;
            wf.SE_FE_SEMSC_Check__c = wf.SE_FE_SEMSC_Check__c - 1;
            }
        if(wf.NQT_SE_MSC_Assigned__c == TRUE && wf.NQT_SE_MSC__c == NULL){
            wf.NQT_SE_MSC_Assigned__c = FALSE;
            wf.SE_FE_SEMSC_Check__c = wf.SE_FE_SEMSC_Check__c - 1;
            }
               
        if(wf.NQT_Account_manager__c != trigger.old[0].NQT_Account_manager__c)
            if(trigger.old[0].NQT_Account_Manager__c != NULL && wf.NQT_Account_manager__c != NULL){
                //Id AM = [SELECT Id FROM User WHERE Name =: wf.NQT_Account_manager_Picklist__c LIMIT 1].Id;
                //wf.NQT_Account_manager__c = AM;
                
                wf.NQT_Class_Access_Before__c = TRUE;
            
                EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'Reassigning_Team'];
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                list<String> EmailAddr = new list<String>();
               
                EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_Account_Manager__c LIMIT 1].Email); 
                //EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_Program_Manager__c LIMIT 1].Email); 
                
                
                email.setToAddresses(EmailAddr);    
                email.setTargetObjectId(wf.NQT_Account_Manager__c);
                email.setWhatId(wf.id);     
                email.setSaveAsActivity(false);            
                email.setTemplateId(et.id);  
                if(wf.NQT_Account_Manager__c != NULL)          
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
            }
        
        if(wf.NQT_Program_Manager__c != trigger.old[0].NQT_Program_Manager__c)
            if(trigger.old[0].NQT_Program_Manager__c != NULL && wf.NQT_Program_Manager__c != NULL){
                //Id PM = [SELECT Id FROM User WHERE Name =: wf.NQT_Program_manager_Picklist__c LIMIT 1].Id;
                //wf.NQT_Program_manager__c = PM;
            
                wf.NQT_Class_Access_Before__c = TRUE;
            
                EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'Reassigning_Team'];
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                list<String> EmailAddr = new list<String>();
               
                EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_Program_Manager__c LIMIT 1].Email); 
                
                
                email.setToAddresses(EmailAddr);    
                email.setTargetObjectId(wf.NQT_Program_Manager__c);
                email.setWhatId(wf.id);     
                email.setSaveAsActivity(false);            
                email.setTemplateId(et.id); 
                if(wf.NQT_Program_Manager__c != NULL)           
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
            }
        
        if(wf.NQT_FE__c != trigger.old[0].NQT_FE__c)
            if(trigger.old[0].NQT_FE__c != NULL && wf.NQT_FE__c != NULL){
            
                wf.NQT_Class_Access_Before__c = TRUE;
            
                EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'Reassigning_Team'];
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                list<String> EmailAddr = new list<String>();
               
                EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_FE__c LIMIT 1].Email); 
                
                email.setToAddresses(EmailAddr);    
                email.setTargetObjectId(wf.NQT_FE__c);
                email.setWhatId(wf.id);     
                email.setSaveAsActivity(false);            
                email.setTemplateId(et.id); 
                if(wf.NQT_FE__c != NULL)           
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
            }
        
        if(wf.NQT_SE__c != trigger.old[0].NQT_SE__c)
            if(trigger.old[0].NQT_SE__c != NULL && wf.NQT_SE__c != NULL){
            
                wf.NQT_Class_Access_Before__c = TRUE;
            
                EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'Reassigning_Team'];
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                list<String> EmailAddr = new list<String>();
               
                EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_SE__c LIMIT 1].Email); 
                
                email.setToAddresses(EmailAddr);    
                email.setTargetObjectId(wf.NQT_SE__c);
                email.setWhatId(wf.id);     
                email.setSaveAsActivity(false);            
                email.setTemplateId(et.id);
                if(wf.NQT_SE__c != NULL)            
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
            }
        
        if(wf.NQT_SE_MSC__c != trigger.old[0].NQT_SE_MSC__c)
            if(trigger.old[0].NQT_SE_MSC__c != NULL && wf.NQT_SE_MSC__c != NULL){
            
                wf.NQT_Class_Access_Before__c = TRUE;
            
                EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'Reassigning_Team'];
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                list<String> EmailAddr = new list<String>();
               
                EmailAddr.add([SELECT Email FROM User WHERE Id =: wf.NQT_SE_MSC__c LIMIT 1].Email); 
                
                email.setToAddresses(EmailAddr);    
                email.setTargetObjectId(wf.NQT_SE_MSC__c);
                email.setWhatId(wf.id);     
                email.setSaveAsActivity(false);            
                email.setTemplateId(et.id); 
                if(wf.NQT_SE_MSC__c != NULL)           
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
            }
        }}        
    
    public void customerCheck(CPR__c wf){if(wf.NQT_Class_Access_Before__c != TRUE && wf.NQT_Class_Access_After__c != TRUE){
        id profileId = UserInfo.getProfileId();
        String profileName = [SELECT Name FROM Profile WHERE Id =: profileId LIMIT 1].Name;
        
            

        /*if(wf.Customer_Hold__c != FALSE && wf.Reason_for_Customer_Hold__c == NULL)
            wf.Reason_for_Customer_Hold__c.addError('Please enter value.');
        if(wf.Customer_Hold__c != TRUE && wf.Reason_for_Customer_Hold__c != NULL)
            wf.Reason_for_Customer_Hold__c.addError('Customer Hold checkbox is not selected.');
        if(wf.Reason_for_Customer_Hold__c != NULL){
            if(wf.NQT_Project_Status__c == 'Customer Hold' || wf.NQT_Project_Status__c == 'Cancelled' ||
               wf.NQT_Project_Status__c == 'Quote Closed'){
                   wf.addError('Cannot put project on Customer Hold From this Project Status');
                   }
            else{
                /*wf.NQT_CPR_Review_Completed__c = FALSE;
                wf.FE_Review_Completed__c = FALSE;
                wf.NQT_Project_Deliverable_Start__c = FALSE;
                wf.NQT_Project_Milestone_Start__c = FALSE;
                wf.NQT_Project_Milestone_End__c = FALSE;
                wf.SE_MSC_Review_Completed__c = FALSE;
                wf.NQT_SE_MSC_Review_Comments__c = NULL;
                wf.NQT_Team_Assignment_Completed__c = FALSE;
                wf.NQT_Team_Assignment_Complet__c = FALSE;
                wf.NQT_FE_Review_Comments__c = NULL;
                wf.NQT_FE_agree_to_the_completeness_of_CPR__c = NULL;
                wf.NQT_SEM_agree_to_the_completeness_of_CPR__c = NULL;
                wf.NQT_SE_agree_to_the_completeness_of_CPR__c = NULL;
                wf.NQT_FE__c = NULL;
                wf.NQT_FE_Assigned__c = FALSE;
                wf.NQT_Review_Deadline__c = NULL;
                wf.NQT_SE__c = NULL;
                wf.NQT_SE_Assigned__c = FALSE;
                wf.NQT_SE_MSC__c = NULL;
                wf.NQT_SE_MSC_Assigned__c = FALSE;
                wf.NQT_SE_Review_Comments__c = NULL;
                wf.SE_Review_Completed__c = FALSE;
                wf.NQT_CPR_Lock__c = FALSE;
                wf.NQT_Agree_with_Customer_Requested_Quote__c = NULL;
                wf.NQT_FE_Deadline__c = NULL;
                wf.NQT_Is_the_CPR_Complete_and_Accurate__c = NULL;
                wf.NQT_Has_the_CPR_been_Reviewed__c = NULL;
                wf.NQT_SE_Deadline__c = NULL;
                wf.NQT_SE_MSC_Deadline__c = NULL;
                wf.NQT_Sales_Deadline__c = NULL;
                wf.NQT_SE_FE_SEMSC_Deliverable_Check__c = 0;
                wf.NQT_SE_Deliverables_Completed__c = FALSE;
                wf.NQT_SE_Deliverables_Submitted__c = FALSE;
                wf.NQT_SE_MSC_Deliverables_Completed_Flag__c = FALSE;
                wf.NQT_SE_MSC_Deliverables_Submitted__c = FALSE;
                wf.NQT_FE_Deliverables_Completed__c = FALSE;
                wf.NQT_FE_Deliverables_submit__c = FALSE;
                wf.NQT_Sales_Deliverable_Start__c = FALSE;
                wf.NQT_Project_Deliverable_Start__c = FALSE;
                wf.NQT_Project_Deliverable_Complete__c = FALSE;
                wf.Reason_for_Customer_Hold__c = NULL;
                wf.SE_FE_SEMSC_Check__c = 0;
                wf.NQT_Project_Status__c = 'Customer Hold';
                wf.NQT_Deliverable_Status__c = 'Customer Hold';
                }
            }*/
        }}
    
  /*  
    public void NQT_FE(String Msg, CPR__c i){
        if(i.NQT_FE__c != NULL)
            i.NQT_FE__c.addError(Msg);//'Field not available while submitting CPR'
        }
        
    public void NQT_SE(String Msg, CPR__c i){
        if(i.NQT_SE__c != NULL)
            i.NQT_SE__c.addError(Msg);
        }
        
    public void NQT_SE_MSC(String Msg, CPR__c i){
        if(i.NQT_SE_MSC__c != NULL)
            i.NQT_SE_MSC__c.addError(Msg);
        }
        
    public void NQT_Review_Deadline(String Msg, CPR__c i){
        if(i.NQT_Review_Deadline__c != NULL)
            i.NQT_Review_Deadline__c.addError(Msg);
        }
        
    public void NQT_Team_Assignment_Complet(String Msg, CPR__c i){
        if(i.NQT_Team_Assignment_Complet__c != FALSE)
            i.NQT_Team_Assignment_Complet__c.addError(Msg);
        }
      
    public void NQT_FE_agree_to_the_completeness_of_CPR(String Msg, CPR__c i){
        if(i.NQT_FE_agree_to_the_completeness_of_CPR__c != NULL)
            i.NQT_FE_agree_to_the_completeness_of_CPR__c.addError(Msg); 
        }
        
    public void NQT_SEM_agree_to_the_completeness_of_CPR(String Msg, CPR__c i){
        if(i.NQT_SEM_agree_to_the_completeness_of_CPR__c != NULL)
            i.NQT_SEM_agree_to_the_completeness_of_CPR__c.addError(Msg); 
        }
        
    public void NQT_SE_agree_to_the_completeness_of_CPR(String Msg, CPR__c i){
        if(i.NQT_SE_agree_to_the_completeness_of_CPR__c != NULL)
            i.NQT_SE_agree_to_the_completeness_of_CPR__c.addError(Msg); 
        }
        
    public void NQT_FE_Review_Comments(String Msg, CPR__c i){
        if(i.NQT_FE_Review_Comments__c != NULL)
            i.NQT_FE_Review_Comments__c.addError(Msg);
        }
        
    public void NQT_SE_MSC_Review_Comments(String Msg, CPR__c i){
        if(i.NQT_SE_MSC_Review_Comments__c != NULL)
            i.NQT_SE_MSC_Review_Comments__c.addError(Msg);
        }
        
    public void NQT_SE_Review_Comments(String Msg, CPR__c i){
        if(i.NQT_SE_Review_Comments__c != NULL)
            i.NQT_SE_Review_Comments__c.addError(Msg);
        }
    
    public void NQT_Has_the_CPR_been_Reviewed(String Msg, CPR__c i){
        if(i.NQT_Has_the_CPR_been_Reviewed__c != NULL)
            i.NQT_Has_the_CPR_been_Reviewed__c.addError(Msg);
        }
    
    public void NQT_Is_the_CPR_Complete_and_Accurate(String Msg, CPR__c i){
        if(i.NQT_Is_the_CPR_Complete_and_Accurate__c != NULL)
            i.NQT_Is_the_CPR_Complete_and_Accurate__c.addError(Msg);
        }
    
    public void NQT_FE_Deadline(String Msg, CPR__c i){
        if(i.NQT_FE_Deadline__c != NULL)
            i.NQT_FE_Deadline__c.addError(Msg);
        }
        
    public void NQT_SE_Deadline(String Msg, CPR__c i){
        if(i.NQT_SE_Deadline__c != NULL)
            i.NQT_SE_Deadline__c.addError(Msg);
        }
        
    public void NQT_SE_MSC_Deadline(String Msg, CPR__c i){
        if(i.NQT_SE_MSC_Deadline__c != NULL)
            i.NQT_SE_MSC_Deadline__c.addError(Msg);
        }
        
    public void NQT_Sales_Deadline(String Msg, CPR__c i){
        if(i.NQT_Sales_Deadline__c != NULL)
            i.NQT_Sales_Deadline__c.addError(Msg);
        }
    
    public void NQT_FE_Deliverables_submit(String Msg, CPR__c i){
        if(i.NQT_FE_Deliverables_submit__c != FALSE)
            i.NQT_FE_Deliverables_submit__c.addError(Msg);
        }
        
    public void NQT_SE_Deliverables_Submitted(String Msg, CPR__c i){
        if(i.NQT_SE_Deliverables_Submitted__c != FALSE)
            i.NQT_SE_Deliverables_Submitted__c.addError(Msg);
        }
        
    public void NQT_SE_MSC_Deliverables_Submitted(String Msg, CPR__c i){
        if(i.NQT_SE_MSC_Deliverables_Submitted__c != FALSE)
            i.NQT_SE_MSC_Deliverables_Submitted__c.addError(Msg);
        }
    
    public void NQT_Field_Engineering(String Msg, CPR__c i){
        if(i.NQT_Field_Engineering__c != NULL)
            i.NQT_Field_Engineering__c.addError(Msg);
        }
        
    public void NQT_System_Engineering(String Msg, CPR__c i){
        if(i.NQT_System_Engineering__c != NULL)
            i.NQT_System_Engineering__c.addError(Msg);
        }
        
    public void NQT_System_MSC_Engineering(String Msg, CPR__c i){
        if(i.NQT_System_MSC_Engineering__c != NULL)
            i.NQT_System_MSC_Engineering__c.addError(Msg);
        }
        
    public void NQT_Please_enter_Reason_for_FE_Rework(String Msg, CPR__c i){
        if(i.NQT_Please_enter_Reason_for_FE_Rework__c != NULL)
            i.NQT_Please_enter_Reason_for_FE_Rework__c.addError(Msg);
        }
        
    public void NQT_Please_enter_Reason_for_SEMSC_Rework(String Msg, CPR__c i){
        if(i.NQT_Please_enter_Reason_for_SEMSC_Rework__c != NULL)
            i.NQT_Please_enter_Reason_for_SEMSC_Rework__c.addError(Msg);
        }
        
    public void NQT_Please_enter_Reason_for_SE_Rework(String Msg, CPR__c i){
        if(i.NQT_Please_enter_Reason_for_SE_Rework__c != NULL)
            i.NQT_Please_enter_Reason_for_SE_Rework__c.addError(Msg);
        }
    
    public void NQT_FE_Services(String Msg, CPR__c i){
        if(i.NQT_FE_Services__c != NULL)
            i.NQT_FE_Services__c.addError(Msg);
        }
        
    public void NQT_SE_Services(String Msg, CPR__c i){
        if(i.NQT_SE_Services__c != NULL)
            i.NQT_SE_Services__c.addError(Msg);
        }
    
    public void NQT_Equipment(String Msg, CPR__c i){
        if(i.NQT_Equipment__c != NULL)
            i.NQT_Equipment__c.addError(Msg);
        }
    
    public void NQT_I_Agree(String Msg, CPR__c i){
        if(i.NQT_I_Agree__c != FALSE)
            i.NQT_I_Agree__c.addError(Msg); 
        }
        
    public void NQT_Sales_AM(String Msg, CPR__c i){
        if(i.NQT_Sales_AM__c != NULL)
            i.NQT_Sales_AM__c.addError(Msg); 
        }
        
    public void NQT_Please_enter_Reason_for_Sales_Rework(String Msg, CPR__c i){
        if(i.NQT_Please_enter_Reason_for_Sales_Rework__c != NULL)
            i.NQT_Please_enter_Reason_for_Sales_Rework__c.addError(Msg);
        }
        
    public void NQT_Close_Project(String Msg, CPR__c i){
        if(i.NQT_Close_Project__c != FALSE)
            i.NQT_Close_Project__c.addError(Msg);
        }
    
    public void NQT_Agree_with_Customer_Requested_Quote(String Msg, CPR__c i){
        if(i.NQT_Agree_with_Customer_Requested_Quote__c != NULL)
            i.NQT_Agree_with_Customer_Requested_Quote__c.addError(Msg);
        }
        
    public void NQT_CPR_Name(String Msg, CPR__c i){
        if(i.NQT_CPR_Name__c != trigger.old[0].NQT_CPR_Name__c)
            i.NQT_CPR_Name__c.addError(Msg);
        }
    
    public void NQT_Type_Of_Request(String Msg, CPR__c i){
        if(i.NQT_Type_Of_Request__c != trigger.old[0].NQT_Type_Of_Request__c)
            i.NQT_Type_Of_Request__c.addError(Msg);
        }
    
    public void NQT_Customer_contact_Name(String Msg, CPR__c i){
        if(i.NQT_Customer_contact_Name__c != trigger.old[0].NQT_Customer_contact_Name__c)
            i.NQT_Customer_contact_Name__c.addError(Msg);
        }
    
    public void NQT_CPR_Start_Date(String Msg, CPR__c i){
        if(i.NQT_CPR_Start_Date__c != trigger.old[0].NQT_CPR_Start_Date__c)
            i.NQT_CPR_Start_Date__c.addError(Msg);
        }
    
    public void NQT_Customer_Contact_Phone(String Msg, CPR__c i){
        if(i.NQT_Customer_Contact_Phone__c != trigger.old[0].NQT_Customer_Contact_Phone__c)
            i.NQT_Customer_Contact_Phone__c.addError(Msg);
        }
    
    public void NQT_Customer_Email_Address(String Msg, CPR__c i){
        if(i.NQT_Customer_Email_Address__c != trigger.old[0].NQT_Customer_Email_Address__c)
            i.NQT_Customer_Email_Address__c.addError(Msg);
        }
    
    public void NQT_Area(String Msg, CPR__c i){
        if(i.NQT_Area__c != trigger.old[0].NQT_Area__c)
            i.NQT_Area__c.addError(Msg);
        }
    
    public void NQT_Market(String Msg, CPR__c i){
        if(i.NQT_Market__c != trigger.old[0].NQT_Market__c)
            i.NQT_Market__c.addError(Msg);
        }
    
    public void NQT_MTSO(String Msg, CPR__c i){
        if(i.NQT_MTSO__c != trigger.old[0].NQT_MTSO__c)
            i.NQT_MTSO__c.addError(Msg);
        }
    
    public void NQT_Account_manager_Picklist(String Msg, CPR__c i){
        if(i.NQT_Account_manager_Picklist__c != trigger.old[0].NQT_Account_manager_Picklist__c)
            i.NQT_Account_manager_Picklist__c.addError(Msg);
        }
    
    public void NQT_If_Other_MTSO(String Msg, CPR__c i){
        if(i.NQT_If_Other_MTSO__c != trigger.old[0].NQT_If_Other_MTSO__c)
            i.NQT_If_Other_MTSO__c.addError(Msg);
        }
    
    public void NQT_Program_Manager_Picklist(String Msg, CPR__c i){
        if(i.NQT_Program_Manager_Picklist__c != trigger.old[0].NQT_Program_Manager_Picklist__c)
            i.NQT_Program_Manager_Picklist__c.addError(Msg);
        }
    
    public void NQT_Product(String Msg, CPR__c i){
        if(i.NQT_Product__c != trigger.old[0].NQT_Product__c)
            i.NQT_Product__c.addError(Msg);
        }
    
    public void NQT_Switch_CLLI_Code(String Msg, CPR__c i){
        if(i.NQT_Switch_CLLI_Code__c != trigger.old[0].NQT_Switch_CLLI_Code__c)
            i.NQT_Switch_CLLI_Code__c.addError(Msg);
        }
    
    public void NQT_MTX_Ericsson(String Msg, CPR__c i){
        if(i.NQT_MTX_Ericsson__c != trigger.old[0].NQT_MTX_Ericsson__c)
            i.NQT_MTX_Ericsson__c.addError(Msg);
        }
    
    public void NQT_if_other(String Msg, CPR__c i){
        if(i.NQT_if_other__c != trigger.old[0].NQT_if_other__c)
            i.NQT_if_other__c.addError(Msg);
        }
    
    public void NQT_If_Other_Product(String Msg, CPR__c i){
        if(i.NQT_If_Other_Product__c != trigger.old[0].NQT_If_Other_Product__c)
            i.NQT_If_Other_Product__c.addError(Msg);
        }
    
    public void NQT_Is_NSN_Required_to_Provide_cablling(String Msg, CPR__c i){
        if(i.NQT_Is_NSN_Required_to_Provide_cablling__c != trigger.old[0].NQT_Is_NSN_Required_to_Provide_cablling__c)
            i.NQT_Is_NSN_Required_to_Provide_cablling__c.addError(Msg);
        }
    
    public void NQT_Database_Work_Needed(String Msg, CPR__c i){
        if(i.NQT_Database_Work_Needed__c != trigger.old[0].NQT_Database_Work_Needed__c)
            i.NQT_Database_Work_Needed__c.addError(Msg);
        }
    
    public void NQT_Cabling_Location(String Msg, CPR__c i){
        if(i.NQT_Cabling_Location__c != trigger.old[0].NQT_Cabling_Location__c)
            i.NQT_Cabling_Location__c.addError(Msg);
        }
    
    public void NQT_Database_Work_Description(String Msg, CPR__c i){
        if(i.NQT_Database_Work_Description__c != trigger.old[0].NQT_Database_Work_Description__c)
            i.NQT_Database_Work_Description__c.addError(Msg);
        }
    
    public void NQT_Cable_Type_and_Length_in_Meter_s(String Msg, CPR__c i){
        if(i.NQT_Cable_Type_and_Length_in_Meter_s__c != trigger.old[0].NQT_Cable_Type_and_Length_in_Meter_s__c)
            i.NQT_Cable_Type_and_Length_in_Meter_s__c.addError(Msg);
        }
    
    public void NQT_Reparenting_Work_Needed(String Msg, CPR__c i){
        if(i.NQT_Reparenting_Work_Needed__c != trigger.old[0].NQT_Reparenting_Work_Needed__c)
            i.NQT_Reparenting_Work_Needed__c.addError(Msg);
        }
    
    public void NQT_Installation_and_Additional_Details(String Msg, CPR__c i){
        if(i.NQT_Installation_and_Additional_Details__c != trigger.old[0].NQT_Installation_and_Additional_Details__c)
            i.NQT_Installation_and_Additional_Details__c.addError(Msg);
        }
    
    public void NQT_Reparenting_Work_Description(String Msg, CPR__c i){
        if(i.NQT_Reparenting_Work_Description__c != trigger.old[0].NQT_Reparenting_Work_Description__c)
            i.NQT_Reparenting_Work_Description__c.addError(Msg);
        }
    
    public void NQT_Requested_Quote_Delivery_Date(String Msg, CPR__c i){
        if(i.NQT_Requested_Quote_Delivery_Date__c != trigger.old[0].NQT_Requested_Quote_Delivery_Date__c)
            i.NQT_Requested_Quote_Delivery_Date__c.addError(Msg);
        }
    
    public void NQT_Target_Service_Start_Date(String Msg, CPR__c i){
        if(i.NQT_Target_Service_Start_Date__c != trigger.old[0].NQT_Target_Service_Start_Date__c)
            i.NQT_Target_Service_Start_Date__c.addError(Msg);
        }
    
    public void NQT_Customer_Requested_Ship_Date(String Msg, CPR__c i){
        if(i.NQT_Customer_Requested_Ship_Date__c != trigger.old[0].NQT_Customer_Requested_Ship_Date__c)
            i.NQT_Customer_Requested_Ship_Date__c.addError(Msg);
        }
    
    public void NQT_Target_Service_Finish_Date(String Msg, CPR__c i){
        if(i.NQT_Target_Service_Finish_Date__c != trigger.old[0].NQT_Target_Service_Finish_Date__c)
            i.NQT_Target_Service_Finish_Date__c.addError(Msg);
        }
        
    public void NQT_FE1(String Msg, CPR__c i){
        if(i.NQT_FE__c != trigger.old[0].NQT_FE__c)
            i.NQT_FE__c.addError(Msg);//'Field not available while submitting CPR'
        }
        
    public void NQT_SE1(String Msg, CPR__c i){
        if(i.NQT_SE__c != trigger.old[0].NQT_SE__c)
            i.NQT_SE__c.addError(Msg);
        }
        
    public void NQT_SE_MSC1(String Msg, CPR__c i){
        if(i.NQT_SE_MSC__c != trigger.old[0].NQT_SE_MSC__c)
            i.NQT_SE_MSC__c.addError(Msg);
        }
        
    public void NQT_Review_Deadline1(String Msg, CPR__c i){
        if(i.NQT_Review_Deadline__c != trigger.old[0].NQT_Review_Deadline__c)
            i.NQT_Review_Deadline__c.addError(Msg);
        }
        
    public void NQT_Team_Assignment_Complet1(String Msg, CPR__c i){
        if(i.NQT_Team_Assignment_Complet__c != trigger.old[0].NQT_Team_Assignment_Complet__c)
            i.NQT_Team_Assignment_Complet__c.addError(Msg);
        }
      
    public void NQT_FE_agree_to_the_completeness_of_CPR1(String Msg, CPR__c i){
        if(i.NQT_FE_agree_to_the_completeness_of_CPR__c != trigger.old[0].NQT_FE_agree_to_the_completeness_of_CPR__c)
            i.NQT_FE_agree_to_the_completeness_of_CPR__c.addError(Msg); 
        }
        
    public void NQT_SEM_agree_to_the_completeness_of_CPR1(String Msg, CPR__c i){
        if(i.NQT_SEM_agree_to_the_completeness_of_CPR__c != trigger.old[0].NQT_SEM_agree_to_the_completeness_of_CPR__c)
            i.NQT_SEM_agree_to_the_completeness_of_CPR__c.addError(Msg); 
        }
        
    public void NQT_SE_agree_to_the_completeness_of_CPR1(String Msg, CPR__c i){
        if(i.NQT_SE_agree_to_the_completeness_of_CPR__c != trigger.old[0].NQT_SE_agree_to_the_completeness_of_CPR__c)
            i.NQT_SE_agree_to_the_completeness_of_CPR__c.addError(Msg); 
        }
        
    public void NQT_FE_Review_Comments1(String Msg, CPR__c i){
        if(i.NQT_FE_Review_Comments__c != trigger.old[0].NQT_FE_Review_Comments__c)
            i.NQT_FE_Review_Comments__c.addError(Msg);
        }
        
    public void NQT_SE_MSC_Review_Comments1(String Msg, CPR__c i){
        if(i.NQT_SE_MSC_Review_Comments__c != trigger.old[0].NQT_SE_MSC_Review_Comments__c)
            i.NQT_SE_MSC_Review_Comments__c.addError(Msg);
        }
        
    public void NQT_SE_Review_Comments1(String Msg, CPR__c i){
        if(i.NQT_SE_Review_Comments__c != trigger.old[0].NQT_SE_Review_Comments__c)
            i.NQT_SE_Review_Comments__c.addError(Msg);
        }
    
    public void NQT_Has_the_CPR_been_Reviewed1(String Msg, CPR__c i){
        if(i.NQT_Has_the_CPR_been_Reviewed__c != trigger.old[0].NQT_Has_the_CPR_been_Reviewed__c)
            i.NQT_Has_the_CPR_been_Reviewed__c.addError(Msg);
        }
    
    public void NQT_Is_the_CPR_Complete_and_Accurate1(String Msg, CPR__c i){
        if(i.NQT_Is_the_CPR_Complete_and_Accurate__c != trigger.old[0].NQT_Is_the_CPR_Complete_and_Accurate__c)
            i.NQT_Is_the_CPR_Complete_and_Accurate__c.addError(Msg);
        }
    
    public void NQT_FE_Deadline1(String Msg, CPR__c i){
        if(i.NQT_FE_Deadline__c != trigger.old[0].NQT_FE_Deadline__c)
            i.NQT_FE_Deadline__c.addError(Msg);
        }
        
    public void NQT_SE_Deadline1(String Msg, CPR__c i){
        if(i.NQT_SE_Deadline__c != trigger.old[0].NQT_SE_Deadline__c)
            i.NQT_SE_Deadline__c.addError(Msg);
        }
        
    public void NQT_SE_MSC_Deadline1(String Msg, CPR__c i){
        if(i.NQT_SE_MSC_Deadline__c != trigger.old[0].NQT_SE_MSC_Deadline__c)
            i.NQT_SE_MSC_Deadline__c.addError(Msg);
        }
        
    public void NQT_Sales_Deadline1(String Msg, CPR__c i){
        if(i.NQT_Sales_Deadline__c != trigger.old[0].NQT_Sales_Deadline__c)
            i.NQT_Sales_Deadline__c.addError(Msg);
        }
    
    public void NQT_FE_Deliverables_submit1(String Msg, CPR__c i){
        if(i.NQT_FE_Deliverables_submit__c != trigger.old[0].NQT_FE_Deliverables_submit__c)
            i.NQT_FE_Deliverables_submit__c.addError(Msg);
        }
        
    public void NQT_SE_Deliverables_Submitted1(String Msg, CPR__c i){
        if(i.NQT_SE_Deliverables_Submitted__c != trigger.old[0].NQT_SE_Deliverables_Submitted__c)
            i.NQT_SE_Deliverables_Submitted__c.addError(Msg);
        }
        
    public void NQT_SE_MSC_Deliverables_Submitted1(String Msg, CPR__c i){
        if(i.NQT_SE_MSC_Deliverables_Submitted__c != trigger.old[0].NQT_SE_MSC_Deliverables_Submitted__c)
            i.NQT_SE_MSC_Deliverables_Submitted__c.addError(Msg);
        }
    
    public void NQT_Field_Engineering1(String Msg, CPR__c i){
        if(i.NQT_Field_Engineering__c != trigger.old[0].NQT_Field_Engineering__c)
            i.NQT_Field_Engineering__c.addError(Msg);
        }
        
    public void NQT_System_Engineering1(String Msg, CPR__c i){
        if(i.NQT_System_Engineering__c != trigger.old[0].NQT_System_Engineering__c)
            i.NQT_System_Engineering__c.addError(Msg);
        }
        
    public void NQT_System_MSC_Engineering1(String Msg, CPR__c i){
        if(i.NQT_System_MSC_Engineering__c != trigger.old[0].NQT_System_MSC_Engineering__c)
            i.NQT_System_MSC_Engineering__c.addError(Msg);
        }
        
    public void NQT_Please_enter_Reason_for_FE_Rework1(String Msg, CPR__c i){
        if(i.NQT_Please_enter_Reason_for_FE_Rework__c != trigger.old[0].NQT_Please_enter_Reason_for_FE_Rework__c)
            i.NQT_Please_enter_Reason_for_FE_Rework__c.addError(Msg);
        }
        
    public void NQT_Please_enter_Reason_for_SEMSC_Rework1(String Msg, CPR__c i){
        if(i.NQT_Please_enter_Reason_for_SEMSC_Rework__c != trigger.old[0].NQT_Please_enter_Reason_for_SEMSC_Rework__c)
            i.NQT_Please_enter_Reason_for_SEMSC_Rework__c.addError(Msg);
        }
        
    public void NQT_Please_enter_Reason_for_SE_Rework1(String Msg, CPR__c i){
        if(i.NQT_Please_enter_Reason_for_SE_Rework__c != trigger.old[0].NQT_Please_enter_Reason_for_SE_Rework__c)
            i.NQT_Please_enter_Reason_for_SE_Rework__c.addError(Msg);
        }
    
    public void NQT_FE_Services1(String Msg, CPR__c i){
        if(i.NQT_FE_Services__c != trigger.old[0].NQT_FE_Services__c)
            i.NQT_FE_Services__c.addError(Msg);
        }
        
    public void NQT_SE_Services1(String Msg, CPR__c i){
        if(i.NQT_SE_Services__c != trigger.old[0].NQT_SE_Services__c)
            i.NQT_SE_Services__c.addError(Msg);
        }
    
    public void NQT_Equipment1(String Msg, CPR__c i){
        if(i.NQT_Equipment__c != trigger.old[0].NQT_Equipment__c)
            i.NQT_Equipment__c.addError(Msg);
        }
    
    public void NQT_I_Agree1(String Msg, CPR__c i){
        if(i.NQT_I_Agree__c != trigger.old[0].NQT_I_Agree__c)
            i.NQT_I_Agree__c.addError(Msg); 
        }
        
    public void NQT_Sales_AM1(String Msg, CPR__c i){
        if(i.NQT_Sales_AM__c != trigger.old[0].NQT_Sales_AM__c)
            i.NQT_Sales_AM__c.addError(Msg); 
        }
        
    public void NQT_Please_enter_Reason_for_Sales_Rework1(String Msg, CPR__c i){
        if(i.NQT_Please_enter_Reason_for_Sales_Rework__c != trigger.old[0].NQT_Please_enter_Reason_for_Sales_Rework__c)
            i.NQT_Please_enter_Reason_for_Sales_Rework__c.addError(Msg);
        }
        
    public void NQT_Close_Project1(String Msg, CPR__c i){
        if(i.NQT_Close_Project__c != trigger.old[0].NQT_Close_Project__c)
            i.NQT_Close_Project__c.addError(Msg);
        }
    
    public void NQT_Agree_with_Customer_Requested_Quote1(String Msg, CPR__c i){
        if(i.NQT_Agree_with_Customer_Requested_Quote__c != trigger.old[0].NQT_Agree_with_Customer_Requested_Quote__c)
            i.NQT_Agree_with_Customer_Requested_Quote__c.addError(Msg);
        }*/
}