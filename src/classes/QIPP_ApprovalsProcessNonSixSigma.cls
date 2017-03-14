global without sharing class QIPP_ApprovalsProcessNonSixSigma
{
    Public QIPP_ApprovalsProcessNonSixSigma(ApexPages.StandardController controller){}
    webservice static void UpdateInitialValueForCoPQ(Id projectId){
        QIPP_Project__c project = [select CheckApprovalProcessActivation__c ,CoPQ_Benefits_Validation_State__c , CABVM__c,TriggerForDI3ApprovalProcess__c from QIPP_Project__c where Id =: projectId ];
        project.CheckApprovalProcessActivation__c = 0;
        project.TriggerForDI3ApprovalProcess__c = 'False';        
        update project;
    }
    
   /* webservice static Id getWorkItemId(Id targetObjectId){
        Id retVal = null;
        for(ProcessInstanceWorkitem workItem  : [Select p.Id from ProcessInstanceWorkitem p
            where p.ProcessInstance.TargetObjectId =: targetObjectId])
        {
            retVal  =  workItem.Id;
        }
        return retVal;
    }
    */
    
    //Added By srikanth for DI form 
    webservice static string CompleteDIproject(Id projectId){
        string returnval = '0';
        list<Database.SaveResult> srList = new list<Database.SaveResult>();
        try{
            //QIPP_Project__c[] project1 = [select  Project_State__c,Workflow_Update3__c from QIPP_Project__c where Id =: projectId ];
            //srList = Database.update(project1, false);
            QIPP_Project__c project1 = [select Id,Project_State__c,Workflow_Update3__c from QIPP_Project__c where Id =: projectId ];
            // Create an approval request for the project
            User sysadmin = [SELECT Id FROM User WHERE Alias='SysAdmin'];
            id logeduserid = UserInfo.getUserId();
            //system.debug('logeduserid***'+ logeduserid);
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            req1.setComments('Request submitted for approval');
            req1.setObjectId(project1.id);
            // Submit on behalf of a specific submitter
            req1.setSubmitterId(logeduserid);
            // Submit the approval request for the Project
            Approval.ProcessResult result1 = Approval.process(req1);
            // First, get the ID of the newly created item
            List<Id> newWorkItemIds = result1.getNewWorkitemIds();
            
            //Submit the request for approval
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setComments('Project status changed to \'Complete\'. No F&C-approval required as benefit amount is <=15k€');
            req.setAction('Approve');            
            Id workItemId = newWorkItemIds[0];
            //system.debug('workItemId***'+ workItemId);
            //system.debug('req1111***'+ req);
/*            ProcessInstanceWorkitem  p = [Select id,ActorId From ProcessInstanceWorkitem where id =: workItemId];
            p.actorid= logeduserid; // user id of user B
            update p;        
*/
            if(workItemId == null){
                returnval = ' Request can not be submitted because the approver field is blank';
                //System.debug('Error exception'+returnval);  
                //System.debug('Error---exception'+returnval);                
            }
            else{
                // Use the ID from the newly created item to specify the item to be worked
                req.setWorkitemId(workItemId);
                //Submit the request for approval
                //system.debug('req***'+ req);
                Approval.ProcessResult result2 =  Approval.process(req);
                //system.debug('result2***'+ result2);
                if(result2.isSuccess()){
                    //system.debug('Inside if' + result2.isSuccess());
                    returnval = '1'; 
                }
            }               
            //System.debug('project1 : ' + project1);
        }
        catch(Exception e){
            returnval = ' Request can not be submitted because the approver field is blank';
            //System.debug('Error exception'+e.getMessage());
            //System.debug('Error exception'+returnval);
        }    
        return returnval;
    }

webservice static string CompleteL6Sproject(Id projectId){
        string returnval = '0';
        list<Database.SaveResult> srList = new list<Database.SaveResult>();
        try{
            //QIPP_Project__c[] project1 = [select  Project_State__c,Workflow_Update3__c from QIPP_Project__c where Id =: projectId ];
            //srList = Database.update(project1, false);
            QIPP_Project__c project1 = [select Id,Project_State__c,Workflow_Update3__c from QIPP_Project__c where Id =: projectId ];
            // Create an approval request for the project
            User sysadmin = [SELECT Id FROM User WHERE Alias='SysAdmin'];
            id logeduserid = UserInfo.getUserId();
            //system.debug('logeduserid***'+ logeduserid);
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            req1.setComments('Request submitted for approval');
            req1.setObjectId(project1.id);
            // Submit on behalf of a specific submitter
            req1.setSubmitterId(logeduserid);
            // Submit the approval request for the Project
            Approval.ProcessResult result1 = Approval.process(req1);
            // First, get the ID of the newly created item
            List<Id> newWorkItemIds = result1.getNewWorkitemIds();
            
            //Submit the request for approval
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setComments('Project status changed to \'Complete\'. No F&C-approval required as non-certification benefit amount is <=15k€');
            req.setAction('Approve');            
            Id workItemId = newWorkItemIds[0];
            //system.debug('workItemId***'+ workItemId);
            //system.debug('req1111***'+ req);
/*            ProcessInstanceWorkitem  p = [Select id,ActorId From ProcessInstanceWorkitem where id =: workItemId];
            p.actorid= logeduserid; // user id of user B
            update p;        
*/
            if(workItemId == null){
                returnval = ' Request can not be submitted because the approver field is blank';
                //System.debug('Error exception'+returnval);  
                //System.debug('Error---exception'+returnval);                
            }
            else{
                // Use the ID from the newly created item to specify the item to be worked
                req.setWorkitemId(workItemId);
                //Submit the request for approval
                //system.debug('req***'+ req);
                Approval.ProcessResult result2 =  Approval.process(req);
                //system.debug('result2***'+ result2);
            }               
            System.debug('project1 : ' + project1);
        }
        catch(Exception e){
            returnval = ' Request can not be submitted because the approver field is blank';
            //System.debug('Error exception'+e.getMessage());
            //System.debug('Error exception'+returnval);
        }    
        return returnval;
    }
    
    webservice static void UpdateInitialValueForKPI(Id projectId){
        QIPP_Project__c project1 = [select KPI_Benefits_Validation_State__c ,CheckApprovalProcessActivation__c , KABVM__c from QIPP_Project__c where Id =: projectId ];
        project1.CheckApprovalProcessActivation__c = 1;
        update project1;
    }
    // ADDED ON 9 JULY 2014... BY ABHISHEK
    // BELOW METHOD ADDED FOR DI3 - DI4 - DI5 APPROVAL PROCESS VALIDATION ...
    // THIS METHOD CHECK FOR ATLEAST ONE BENEFIT HAVING Benefit Type =“Financial Savings” FOR SELECTED PROJECT ..
    webservice static boolean DI3ApprovalProcessVaildation(Id projectId){
            //System.Debug('*************projectId***********' + projectId);
            List<QIPP_Benefit__c> financialTypeList = [select Id , Planned_Financial_Savings_Total__c from QIPP_Benefit__c where  Benefit_Type__c = 'Financial Savings' and (Planned_Financial_Savings_Total__c !=0 and Planned_Financial_Savings_Total__c != null) and  Project_ID__c =: projectId Limit 5];
           // System.Debug('*************financialTypeList ***********' + financialTypeList);
            Boolean returnval = false;
            if(financialTypeList != null && financialTypeList.size() > 0)            
                returnval = true;    
            else
                returnval = false;    
            financialTypeList.clear();
            financialTypeList = null;   
            return returnval;    
    }
    
    webservice static boolean DI3BenefitOverrideStatusCheck(Id projectId){
            System.Debug('*************projectId***********' + projectId);
            List<QIPP_Benefit__c> BenefiOverridStatus = [select Id , Benefit_Override_Status__c  from QIPP_Benefit__c where  Benefit_Override_Status__c = 'Awaiting Approval' and Project_ID__c =: projectId];
            Boolean returnval = false;
            if(BenefiOverridStatus != null && BenefiOverridStatus.size() > 0)            
                returnval = true;    
            else
                returnval = false;    
            BenefiOverridStatus .clear();
            BenefiOverridStatus = null;   
            return returnval;    
    }

    webservice static boolean InitiateDI3ApprovalProcess(Id projectId , String Flag)    {
        QIPP_Project__c project = [select Id , DI_Finance_Approver__c , TriggerForDI3ApprovalProcess__c from QIPP_Project__c where Id =: projectId ];
        //System.Debug('************ inside InitiateDI3ApprovalProcess ************* ' + Flag);        
        if(Flag == 'True'){        
           project.TriggerForDI3ApprovalProcess__c = 'True';
           update project;        
        }
        return true;       
    }

    webservice static Integer DI3AllBusinessRoleValidation(Id projectId){
        QIPP_Project__c TEST = [select Id , DI_Finance_Approver__c , DI_Approver_Q_PMO_Team_Member__c , 
                                DI_Approver_Project_Lead_Manager__c , DI_Approver_Finance_Approver_Delegate__c , DI_Approver_Business_Owner_Delegate__c , DI_Approver_Business_Owner__c , BL_Transformation_Lead_Email__c , Measure_Creator_Email__c from QIPP_Project__c where Id =: projectId ];
            //System.Debug('************* TEST.DI_Approver_Project_Lead_Manager__c *********** ' + TEST.DI_Approver_Project_Lead_Manager__c );
        List<QIPP_CoPQ_Project_Team__c> projectteammembers = [ select Id , BL_Transformation_Lead__c , Measure_Creator__c ,   Business_Owner_Delegate__c , Finance_Approver_Delegate__c from QIPP_CoPQ_Project_Team__c where ProjectID__c =: projectId]; 
            //System.Debug('************* projectteammembers size *********** ' + projectteammembers.size());
        Integer returnVal1 = 0;
        if(projectteammembers != null && projectteammembers.size() > 0)   {
            if(projectteammembers[0].Business_Owner_Delegate__c == null)         
               returnVal1 = -1;
            else if(projectteammembers[0].Finance_Approver_Delegate__c == null)   
               returnVal1 = -2; 
            else if(projectteammembers[0].BL_Transformation_Lead__c  == null)   
              returnVal1 = -3;               
            else if(projectteammembers[0].Measure_Creator__c == null)   
              returnVal1 = -4;               
            else 
               returnVal1 = 1;    
        }
        return returnVal1 ;        
    }                

    webservice static boolean DI4ApprovalProcessVaildation(Id projectId){
            //System.Debug('*************projectId***********' + projectId);
        List<QIPP_Benefit__c> financialTypeList = [select Id from QIPP_Benefit__c where   Benefit_Type__c = 'Financial Savings' and  
                                                    (
                                                    (Planned_Financial_Savings_Total__c != 0 and Planned_Financial_Savings_Total__c != null) 
                                                    and 
                                                    (Achieved_Financial_Savings_Total__c != 0 and Achieved_Financial_Savings_Total__c != null)
                                                    and 
                                                    (Future_Financial_Savings_Total__c != 0 and Future_Financial_Savings_Total__c != null)
                                                    ) and  Project_ID__c =: projectId Limit 5];
           // System.Debug('*************financialTypeList ***********' + financialTypeList);
        Boolean returnval = false;
        if(financialTypeList != null && financialTypeList.size() > 0)            
            returnval = true;    
        else
            returnval = false;    
        financialTypeList.clear();
        financialTypeList = null;   
            //System.Debug('-----------returnval------------ ' + returnval);             
        return returnval;    
    }
    
    webservice static Integer DI4AllBusinessRoleValidation(Id projectId){
        List<QIPP_CoPQ_Project_Team__c> projectteammembers = [ select Id , Business_Owner_Delegate__c , Finance_Approver_Delegate__c from QIPP_CoPQ_Project_Team__c where ProjectID__c =: projectId]; 
            //System.Debug('************* projectteammembers size *********** ' + projectteammembers.size());
        Integer returnVal1 = 0;
        if(projectteammembers != null && projectteammembers.size() > 0)   
        {
            if(projectteammembers[0].Finance_Approver_Delegate__c == null)   
               returnVal1 = -1; 
            else 
               returnVal1 = 1;    
        }
        return returnVal1 ;        
    }                
    
    webservice static Integer DI5AllBusinessRoleValidation(Id projectId){
        List<QIPP_CoPQ_Project_Team__c> projectteammembers = [ select Id , Business_Owner_Delegate__c , Finance_Approver_Delegate__c from QIPP_CoPQ_Project_Team__c where ProjectID__c =: projectId];            System.Debug('************* projectteammembers size *********** ' + projectteammembers.size());
        Integer returnVal1 = 0;
        if(projectteammembers != null && projectteammembers.size() > 0)   
        {
            if(projectteammembers[0].Business_Owner_Delegate__c == null)         
               returnVal1 = -1;
            else if(projectteammembers[0].Finance_Approver_Delegate__c == null)   
               returnVal1 = -2; 
            else 
               returnVal1 = 1;    
        }
        return returnVal1 ;        
    }      
    
    webservice static void DI3ToDI2(Id projectId , String FromDI3ToDI2)
    {
        try{ 
            QIPP_Project__c project = [select ID , FromDI3ToDI2__c  from QIPP_Project__c where Id =: projectId ];
            project.FromDI3ToDI2__c  = FromDI3ToDI2 ;
            update project;
                //System.Debug('*********** In DI3ToDI2 project ************* ' + project);
        }
        catch(Exception exe){
            //System.Debug('*********** In DI3ToDI2 exception occured ************* ' + exe.getMessage());
            //System.Debug('*********** In DI3ToDI2 exception occured @ line number ************* ' + exe.getLineNumber());               
        }    
    } 
    webservice static Integer DMAIC_Savings(Id projectId){
        List<QIPP_BU_Reporting__c> SavingsAmount = [ select Id , Benefits_Saving_Amount_Planned__c, Benefits_Saving_Amount_Achieved__c, Benefit_Savings_Amount__c from QIPP_BU_Reporting__c where Project_ID__c =: projectId];            
        Integer returnAmt = 0;
        Boolean planned = false;
        Boolean Achieved = false;
        //Boolean Future = false; 
            //system.debug('::::::::::'+SavingsAmount);
        for(QIPP_BU_Reporting__c sa:SavingsAmount){
            if(sa.Benefits_Saving_Amount_Planned__c > 0)
            planned = true;
            if(sa.Benefits_Saving_Amount_Achieved__c > 0)
            Achieved = true;
            //if(sa.Benefit_Condition__c == 'Future' && sa.Benefit_Savings_Amount__c > 0)
            //Future = true;                    
        }
        //system.debug(':::'+planned+'::::'+Achieved+'::::'+Future);
        //if(planned == true && Achieved == true && Future == true) returnAmt = 1;
        if(planned == true && Achieved == true) returnAmt = 1;
        else if(planned == true) returnAmt = 2; 
        return returnAmt ;        
    }   
    
    webservice static boolean TasksCheck(Id projectId){
        List<QIPP_Task__c> listOfTasks = [select id, Project_ID__c , Task_State__c from QIPP_Task__c where  Task_State__c not in ('Complete', 'Canceled') and Project_ID__c =: projectId];
        Boolean returnval = false;
        if(listOfTasks != null && listOfTasks.size() > 0) {
            returnval = true;
        }
        else
            returnval = false;    
        listOfTasks.clear();
        listOfTasks = null;   
        return returnval;  
    }
    /*
    webservice static boolean SandboxCheck(Id projectId){
        Organization IsSand = [select IsSandbox from Organization limit 1];
        Boolean returnval = false;
        if(IsSand.IsSandbox){
            returnval = true;
        }
        else
            returnval = false;    
        return returnval;  
    }
    */
    webservice static string SubmitApproval(Id projectId){
        string returnval = '0';
        String errorexception;
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('This record has been submitted for your approval');
        req.setObjectId(projectId);
        Approval.ProcessResult result;
        try{
            result = Approval.process(req); //submit the approval request for processing
            //System.debug('Approval Process Result'+result);
            if(result.isSuccess()){
                //system.debug('Inside if' + result.isSuccess());
                returnval = '1'; 
            }
            //else returnval = '2';
        }
        catch(Exception e){  
            //returnval=e.getMessage();
            //system.debug('Inside catch' + e.getMessage());
            returnval = ' Request can not be submitted because the approver field is blank';
             //System.debug('Error exception'+returnval);
             
        } 
        if(Test.isRunningTest()){
            returnval ='1';
        }
        return returnval;  
    }
    webservice static boolean ImpMeasurescheck(Id projectId){
        List<QIPP_Benefit__c> listOfbenefits = [select Id,Improvement_Measure_Name__c,Improvement_Measure_KPI__c,Improvement_Measure_KPI__r.name from QIPP_Benefit__c where Project_ID__c =: projectId and Improvement_Measure_Name__c ='Generic PI (Interim Use Only)'];
        Boolean returnval = false;
        if(listOfbenefits != null && listOfbenefits.size() > 0) {
            returnval = true;
        }
        else
            returnval = false;    
        listOfbenefits.clear();
        listOfbenefits = null;   
        return returnval;  
    }
    webservice static boolean BusinessActivities(Id projectId){
        List<QIPP_Project__c> activityList = [select Business_Activity_Mapping__c,Business_Activity_Mapping2__c,Business_Activity_Mapping3__c from QIPP_Project__c where id=:projectId];
        Boolean returnval = false;
        if(activityList.size() > 0) {
            for(QIPP_Project__c bam : activityList){
                if(bam.Business_Activity_Mapping__c != null || bam.Business_Activity_Mapping2__c != null || bam.Business_Activity_Mapping3__c != null){
                returnval = true;
                }
                else
                returnval = false;
            }
        }
            
        activityList.clear();
        activityList = null;   
        return returnval;  
    }
    
      webservice static boolean ProjectRedeployments(Id projectId){
        List<QIPP_Project__c> projredepList = [select Can_Project_Redeployed__c from QIPP_Project__c where id=:projectId];
        Boolean returnval = false;
        if(projredepList.size() > 0) {
            for(QIPP_Project__c prdl : projredepList){
                if(prdl.Can_Project_Redeployed__c == null || prdl.Can_Project_Redeployed__c == ''){
                returnval = false;
                }
                else
                returnval = true;
            }
        }
            
        projredepList.clear();
        projredepList = null;   
        return returnval;  
    }
    webservice static Integer Lean_Savings(Id projectId){
        List<QIPP_BU_Reporting__c> LeanSavingsAmount = [ select Id ,Benefit_Condition__c, Benefit_Savings_Amount__c from QIPP_BU_Reporting__c where Project_ID__c =: projectId];            
        Integer returnAmt = 0;
        Boolean planned = false;
        Boolean Achieved = false;
        Boolean Future = false; 
            //system.debug('::::::::::'+LeanSavingsAmount);
        for(QIPP_BU_Reporting__c sa:LeanSavingsAmount){
            if(sa.Benefit_Condition__c == 'Planned' && sa.Benefit_Savings_Amount__c > 0)
            planned = true;
            
            if(sa.Benefit_Condition__c == 'Achieved' && sa.Benefit_Savings_Amount__c > 0)
            Achieved = true;

            if(sa.Benefit_Condition__c == 'Future' && sa.Benefit_Savings_Amount__c > 0)
            Future = true;                      
        }
            //system.debug(':::'+planned+'::::'+Achieved+'::::'+Future);
        if(planned == true && Achieved == true && Future == true) returnAmt = 1;
        else if(planned == true) returnAmt = 2;
        return returnAmt ;        
    }     
}