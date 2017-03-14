@isTest
public with sharing class QIRS_Action_Plan_Submition_Con_Test{
    
   static testmethod void test1()
     {    
        QIRS__c i=new QIRS__c();
         
        ApexPages.StandardController con = new ApexPages.StandardController(i);
        QIRS_Action_Plan_Submition_Controller  aaa = new QIRS_Action_Plan_Submition_Controller (con); 
        
        
        aaa.QIRS_Action_plan_Tag= 'Tasks review';
        aaa.QIRS_Action_plan_Status='Pending';
        aaa.QIRS_Action_plan_Flag=false; 
        aaa.SelectedStatus = new String[]{};
        aaa.SelectedStatus.add('Pending for Champion');
        aaa.Type ='stask';
        aaa.getshowQIRSActionPlan();
        aaa.getQIRS_Action_plan_Item();
        aaa = new QIRS_Action_Plan_Submition_Controller (con);
        
        aaa.QIRS_Action_plan_Tag='Submitted tasks';
        aaa.QIRS_Action_plan_Status='Rejected';
        aaa.QIRS_Action_plan_Flag=True;
        aaa.SelectedStatus = new String[]{};
        aaa.SelectedStatus.add('Implemented by Champion');
        aaa.Type ='rtask';
        aaa.getshowQIRSActionPlan();
        aaa.getQIRS_Action_plan_Item();
        aaa = new QIRS_Action_Plan_Submition_Controller (con);
        
        aaa.QIRS_Action_plan_Tag='Committed Plans';
        aaa.QIRS_Action_plan_Status='Pending';
        aaa.QIRS_Action_plan_Flag=false;
        aaa.SelectedStatus = new String[]{};
        aaa.SelectedStatus.add('Rejected');
        aaa.Type ='rtask';
        aaa.getshowQIRSActionPlan();
        aaa.getQIRS_Action_plan_Item();
        aaa = new QIRS_Action_Plan_Submition_Controller (con);
        
       aaa.QIRS_Action_plan_Tag = 'Submitted tasks';
       aaa.QIRS_Action_plan_Flag = true;
       aaa.getshowQIRSActionPlan();
        aaa.getQIRS_Action_plan_Item();
        aaa = new QIRS_Action_Plan_Submition_Controller (con);
        
     }
     }