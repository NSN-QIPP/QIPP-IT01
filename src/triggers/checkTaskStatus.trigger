// Modified by Srikanth_V on 22-july-2016: applied Trigger Best Practices
// Modified by Manish Tyagi on 16-Aug-2016: Added code for Organization Benefitting Change

trigger checkTaskStatus on QIPP_Project__c (before update){
    if(TriggerHelper.checkRecursive()){    
        if(Trigger.isBefore){   
            Trigger_Control__c s = Trigger_Control__c.getInstance(UserInfo.getUserId());
            //system.debug('Run_Triggers__c :::'+s.Run_Triggers__c);
            if(s.Run_Triggers__c){
                map<id,list<QIPP_Task__c>> maptasks = new map<id,list<QIPP_Task__c>>();
                map<id,user> mapuser = new map<id,user>(); 
                Set<ID> ids = Trigger.newMap.keySet();
                List<QIPP_Task__c> listOfTasks = [select  Project_ID__c , Task_State__c,Project_ID__r.Project_State__c from QIPP_Task__c where Project_ID__c in :ids];
                 if(UserInfo.getUserRoleId()!= null){
                     mapuser.putAll([SELECT Id, UserRole.Name FROM User WHERE Id=:UserInfo.getUserId() LIMIT 1]);
                 }
                 //system.debug('mapuser'+mapuser);
                    //var rolename = rolenames.Name;}
                //system.debug('rolename'+rolenames.Name);
                for(QIPP_Task__c tsk : listOfTasks){
                    if (maptasks.containsKey(tsk.Project_ID__c)){
                        maptasks.get(tsk.Project_ID__c).add(tsk);
                    }else{
                        maptasks.put(tsk.Project_ID__c,new list<QIPP_Task__c>{tsk});
                    }
                }
                
                for(QIPP_Project__c prj : Trigger.new){
                    //system.debug('Project_State__c_old**'+Trigger.oldMap.get(prj.Id).Project_State__c);
                    //system.debug('Project_State__c_New**'+Trigger.NewMap.get(prj.Id).Project_State__c);
                    //system.debug('DI_State__c****'+prj.DI_State__c);    
                    //system.debug('oldnmapvalue' + Trigger.oldMap.get(prj.Id).Total_Project_Validation_Amount__c);
                    //system.debug('oldnmapvalue' + Trigger.newMap.get(prj.Id).Total_Project_Validation_Amount__c);
                    //system.debug('Total_Project_Validation_Amount__c'+prj.Total_Project_Validation_Amount__c);
                    //system.debug('UserInfo.getUserRoleId()****'+UserInfo.getUserRoleId());
                    User u = mapuser.get(UserInfo.getUserId());
                    //system.debug('rolename'+u.UserRole.name);   
                    if(Trigger.oldMap.get(prj.Id).Project_State__c != Trigger.NewMap.get(prj.Id).Project_State__c){
                        prj.Old_Project_State__c = Trigger.oldMap.get(prj.Id).Project_State__c; // Added by Manish for R16.6 Progress Bar condition
                        //prj.Project_State__c = Trigger.NewMap.get(prj.Id).Project_State__c; // Added by Manish for R16.6 Progress Bar condition
                        //system.debug('prj.Old_Project_State__c :' + prj.Old_Project_State__c);
                        //system.debug('prj.Project_State__c :'+prj.Project_State__c);
                        if(prj.Project_Number__c.contains ('Lean') || prj.Project_Number__c.contains ('DMAIC') || prj.Project_Number__c.contains ('CIF') || prj.Project_Number__c.contains ('DMADV') || prj.Project_Number__c.contains ('DI(COPQ)')){
                            if((Trigger.oldMap.get(prj.Id).Project_State__c == 'Complete') && Trigger.NewMap.get(prj.Id).Project_State__c == 'In Progress')
                            {
                                //system.debug('DI_State__c '+prj.DI_State__c);                                                
                                prj.DI_State__c = 'DI 2 - Concept existing, business case analyzed';
                            }
                            //End of the code - Manish
                            else if(Trigger.NewMap.get(prj.Id).Project_State__c == 'Complete'){
                            list<QIPP_Task__c> tsk = new list<QIPP_Task__c>();
                            tsk = maptasks.get(prj.id);
                            //system.debug('tsk '+tsk );
                            //if( tsk.size()>0 || !tsk.isEmpty()){
                               if(tsk != null){
                                //system.debug('tsk yes '+tsk );
                                    for(QIPP_Task__c a : tsk) {
                                        if(a.Task_State__c == 'Not started' || a.Task_State__c == 'On hold' || a.Task_State__c == 'In Progress' ){
                                            prj.Project_State__c.addError('All Tasks must be either closed or canceled before project status considered as Complete.');
                                            break;
                                        }
                                    }
                                } 
                            }
                        }
                        else if((Trigger.NewMap.get(prj.Id).Project_State__c == 'Closed') && u != null && (u.UserRole.name == 'QIPP Project Lead') && (u.UserRole.name !='')){
                            //system.debug('Project_State__c_New!!!!**'+Trigger.NewMap.get(prj.Id).Project_State__c);
                            //system.debug('UserInfo.getUserRoleId()****'+UserInfo.getUserRoleId());
                                prj.addError('As a Project Lead, You are NOT allowed to close the Project. Contact QIPP Admin, Portfolio Owner or Portfolio Manager to close the Project.');
                        }
                    }   
                    
                    //Requirement# - E#048
                    //Start of the code - Added by Manish on 16th Aug
                    //Purpose: To store the old and New values of Organization Benefitting related field Change
                    else if(prj.Portfolio_Name__c != Trigger.oldMap.get(prj.Id).Portfolio_Name__c)
                    {
                        try{
                            List<QIPP_Portfolio__c> fetchChild = [select name from QIPP_Portfolio__c where Id =: Trigger.oldMap.get(prj.Id).Portfolio_name__c];
                            List<QIPP_Portfolio__c> fetchChild1 = [select name from QIPP_Portfolio__c where Id=: Trigger.newMap.get(prj.Id).Portfolio_name__c];
                            prj.Old_Portfolio_Name__c = fetchChild[0].name;
                            prj.Old_Benefitting_Business_Grp__c = Trigger.oldMap.get(prj.Id).Portfolio_BU__c;
                            prj.Old_Benefitting_Business_Unit__c = Trigger.oldMap.get(prj.Id).Project_BL__c;
                            prj.Old_Benefitting_Business_Line__c = Trigger.oldMap.get(prj.Id).Benefitting_Project_BL_Level_4_Org__c;
                            //prj.Old_Portfolio_Owner_Email__c = Trigger.oldMap.get(prj.Id).Portfolio_Owner_EmailID__c;
                            prj.Old_Portfolio_Owner_Email__c = Trigger.oldMap.get(prj.Id).Approver_Protfolio_Owner_Email_1__c;
                            prj.Old_Portfolio_Owner_Email2__c = Trigger.oldMap.get(prj.Id).Approver_Protfolio_Owner_Email_2__c;
                            prj.Old_Portfolio_Owner_Email3__c = Trigger.oldMap.get(prj.Id).Approver_Protfolio_Owner_Email_3__c;
                            prj.Old_Portfolio_Owner_Email4__c = Trigger.oldMap.get(prj.Id).Approver_Protfolio_Owner_Email_4__c;
                            
                            if((Trigger.oldMap.get(prj.Id).Business_Unit_Master_Black_Belt__c!= null) && (prj.Business_Unit_Master_Black_Belt__c != Trigger.oldMap.get(prj.Id).Business_Unit_Master_Black_Belt__c))
                            {
                            List<QIPP_Contacts__c> fetchChildBUMBB = [select name from QIPP_Contacts__c where Id =: Trigger.oldMap.get(prj.Id).Business_Unit_Master_Black_Belt__c];
                            List<QIPP_Contacts__c> fetchChild1BUMBB = [select name from QIPP_Contacts__c where Id=: Trigger.newMap.get(prj.Id).Business_Unit_Master_Black_Belt__c];
                            prj.Old_Business_Group_Master_Black_Belt__c = fetchChildBUMBB[0].name;
                            prj.Old_Business_Group_MBB_Email__c = Trigger.oldMap.get(prj.Id).Email_BU_MBB__c;
                            }
                            else{
                                List<QIPP_Contacts__c> fetchBUMBB = [select name from QIPP_Contacts__c where Id =: prj.Business_Unit_Master_Black_Belt__c];
                                prj.Old_Business_Group_Master_Black_Belt__c = fetchBUMBB[0].name;
                                prj.Old_Business_Group_MBB_Email__c = prj.Email_BU_MBB__c;
                            }
                        }
                        catch(Exception exe){
                           //system.debug('---Exception Message BUMBB---'+exe.getMessage());
                        }
                        
                        
                    }//End of the code - Manish  
                    //Requirement# - E073
                    //Start of the code - Added by Manish on 7th Sep 2016
                    //upadated by srikanth on 14thNOV2016
                    //Purpose: To store the old and New values of Benefit fields for Non Lean Certificate and DI workflows >15k 
                    system.debug('Old Map'+Trigger.Old);
                    system.debug('New Map'+prj.Total_Project_Validation_Amount__c);
                    system.debug('FieldForControlVerifyPhase__c'+prj.FieldForControlVerifyPhase__c);
                    if((prj.Check_Approval_Process_Status__c == 'L6S Recall_Reject'|| prj.Check_DI_Approval_State__c == 'DI Reject/Recall' || prj.Check_Approval_Process_Status__c == 'CIF Recall/Reject' || prj.FieldForControlVerifyPhase__c=='RecordUnLock') && (prj.WorkflowPortfolioReject__c == true) && (prj.Total_Project_Validation_Amount__c != Trigger.oldMap.get(prj.Id).Total_Project_Validation_Amount__c))
                    {
                        prj.WorkflowN6SBenefit__c = True;
                        system.debug('WorkflowN6SBenefit__c'+prj.WorkflowN6SBenefit__c);
                    }//End of the code - Manish 
                }
            }
        }
    }  
}
    
/*  
trigger checkTaskStatus on QIPP_Project__c (before update){ 
 if(TriggerHelper.checkRecursive())
 {    
    List<QIPP_Project__c> oldproject = Trigger.Old;

    if(Trigger.isBefore)
    {   
        Trigger_Control__c s = Trigger_Control__c.getInstance(UserInfo.getUserId());
        system.debug('Run_Triggers__c :::'+s.Run_Triggers__c);
        if(s.Run_Triggers__c)
        {
            for(QIPP_Project__c project : Trigger.new)
            {
                List<QIPP_Task__c> listOfTasks = [select  Project_ID__c , Task_State__c from QIPP_Task__c where Project_ID__c =: project.Id];
                
                Boolean checkTaskStatus = true;
                
                if(listOfTasks.size() > 0)
                {
                    for(QIPP_Task__c a : listOfTasks) 
                    {
                        if(a.Task_State__c == 'Not started' || a.Task_State__c == 'On hold' || a.Task_State__c == 'In Progress')
                        {
                            checkTaskStatus = false; 
                            break;
                        }
                    }
                }
                
                String loggedinusername = UserInfo.getName();
                String loggedinuseremail = UserInfo.getuserEmail();
                // Line no 26 and 27 added by Sasya Ravi on 08-05-2014
                String loggedinuserid = UserInfo.getUserId();
                User username = null;
                QIPP_Contacts__c leadinfo = null;
                QIPP_Contacts__c globalMBBinfo = null;
                Boolean result2 = false;    
                Boolean result = false;
                QIPP_Portfolio__c portfolio = null;
                Boolean result1 = false;
                Boolean result3 = false;
                QIPP_Contacts__c portfolioownerinfo = null;
                
                System.Debug('********* project ************** ' + project);
                System.Debug('********* loggedinuseremail ************** ' + loggedinuseremail);
                System.Debug('********* loggedinusername ************** ' + loggedinusername );
                
                if(project.Project_Lead__c != null)
                {     
                    leadinfo = [select Email__c , Name  from QIPP_Contacts__c where Id =: project.Project_Lead__c];
                     System.Debug('********* leadinfo.Email__c ************** ' + leadinfo.Email__c);
                    result = leadinfo.Email__c.equalsIgnoreCase(loggedinuseremail);
                }
                
               
                
                if(project.Portfolio_Name__c != null)
                {
                    portfolio = [select Portfolio_Owner__c from QIPP_Portfolio__c where ID =: project.Portfolio_Name__c];
                }   
                    // Line no 59 and 60 added by Sasya Ravi on 08-05-2014
                    username = [select name,email from user where  id = :loggedinuserid];
                    system.debug('************sysadmin********' +  username);
 
                    if(portfolio  != null && portfolio.Portfolio_Owner__c != null)    
                    {
                     portfolioownerinfo = [select Name , Email__c from QIPP_Contacts__c where Id =: portfolio.Portfolio_Owner__c];
                     result1 = portfolioownerinfo.Email__c.equalsIgnoreCase(loggedinuseremail);
             
                    // Line no 71 and 72 added by Sasya Ravi on 08-05-2014
                    
                    result3 = username.Email.equalsIgnoreCase(loggedinuseremail);
                    system.debug('*******result3**********' + result3 );
                    // Line no 74 Result3 Part added by Sasya Ravi on 08-05-2014
                    if((result1 == false && project.Project_State__c == 'Closed') && (result3 == false && project.Project_State__c == 'Closed') )
                    {
                        if((oldproject[0].Project_State__c != project.Project_State__c) && (project.Project_State__c == 'Closed'))
                            trigger.new[0].Project_State__c.addError(' Portfolio Owner  can make project status Closed');
                    }
                    
                    }

                    // Line no 84 to 90 Result3 Part added by Sasya Ravi on 08-05-2014     
               
                
                if(checkTaskStatus == false && project.Project_State__c == 'Complete')
                {
                      trigger.new[0].Project_State__c.addError('All Tasks must be either closed or canceled before project status considered as Complete.');
                }
            }
        }
        
        
    }
  } */
// on 21-july-2016 : above code commented and applied best practices by Haripriya to overcome "too many soql" exception also no need to check for Closed condition, as validation are available.  
/*if(TriggerHelper.checkRecursive())
 {    
    if(Trigger.isBefore)
    {   
        Trigger_Control__c s = Trigger_Control__c.getInstance(UserInfo.getUserId());
        system.debug('Run_Triggers__c :::'+s.Run_Triggers__c);
        if(s.Run_Triggers__c)
        {
                Set<ID> ids = Trigger.newMap.keySet();
                
                Set<ID> projID = new Set<ID>();
                Set<ID> projLead = new Set<ID>();
                Set<ID> portfolioName = new Set<ID>();
                Set<String> projState = new Set<String>();
                    
                for(QIPP_Project__c project : Trigger.new)
                {
                    projID.add(project.Id);
                    projLead.add(project.Project_Lead__c);
                    portfolioName.add(project.Portfolio_Name__c);
                    projState.add(project.Project_State__c);
                }
                
                List<QIPP_Task__c> listOfTasks = [select  Project_ID__c , Task_State__c,Project_ID__r.Project_State__c from QIPP_Task__c where Project_ID__c in :projID];
                
                //Boolean checkTaskStatus = true;
                for(QIPP_Project__c projError : Trigger.new)
                {
                    if(listOfTasks.size() > 0)
                    {
                        for(QIPP_Task__c a : listOfTasks) 
                        {
                            if((a.Task_State__c == 'Not started' || a.Task_State__c == 'On hold' || a.Task_State__c == 'In Progress' ) && projError.Project_State__c == 'Complete')
                            {
                                projError.Project_State__c.addError('All Tasks must be either closed or canceled before project status considered as Complete.');
                            }
                        }
                    }
                }
        }
    }
  }  
}
*/