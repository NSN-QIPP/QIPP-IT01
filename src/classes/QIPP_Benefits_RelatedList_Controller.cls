/*
    Class/Triger Name : QIPP_Benefits_RelatedList_Controller
    Test Class Name   : QIPP_Benefits_RelatedList_Cont_Test
    Author            : Srikanth V(IGATE)
    Created Date      : 23.AUG.2014 
    Purpose/Overview  : 
                ********************************************************************************************************************         
                01) Geting all project related benefit records to display in Project benefit related list in project detail page
                02) 
                ********************************************************************************************************************  
    Change History    : 
                ********************************************************************************************************************         
                SNo : Modified Date :  Developer Name(Company Name)  : Method/Section Modified/Added : Purpose/Overview of Change
                ********************************************************************************************************************  
                01  : 23.AUG.2014   :  Srikanth V(IGATE)  :   Class Created  :
                02  : 08.JULY.2015  :  Srikanth V(IGATE)  :   Class Modified : Removed some unnecessary fields in SOQL.
                03  : 
    Notes :
                ********************************************************************************************************************         
                01) 
                02)
*/

public with sharing class QIPP_Benefits_RelatedList_Controller {
    public QIPP_Project__c Proj; 
    //public QIPP_Project__c projectinfo {get;set;}
    public List<QIPP_Benefit__c> Benefits_RelatedList {get;set;}
    //public String projectid {get;set;}
    
    public QIPP_Benefits_RelatedList_Controller(ApexPages.StandardController controller) {
       // try{
            this.Proj= (QIPP_Project__c)controller.getRecord();
            String projectid = Proj.id;
            //projectinfo = [select Name , Project_Number__c , Project_Name_Succinct__c ,  Project_Lead__r.Full_Name__c ,  Project_Lead__r.Name ,  Portfolio_Name__r.Portfolio_Name_Unique__c ,CoPQ_Benefits_Validation_State__c ,TriggerForDI3ApprovalProcess__c, CABVM__c , KABVM__c , KPI_Benefits_Validation_State__c , DI_State__c, Belt_Project_Phase__c , FieldForControlVerifyPhase__c ,Check_DI_Approval_State__c, Belt_Project_Type__c from QIPP_Project__c where id = :Proj.id];
            Benefits_RelatedList = [select ID , Name ,Improvement_Measure_KPI__c ,
                                         Improvement_Measure_KPI__r.Name,
                                         Benefit_Type__c, 
                                         Project_ID__c,
                                         
                                         Improvement_Measure_Name__c,
                                         Planned_Financial_Savings_Total__c,
                                         Planned_Operational_Savings_Total__c,
                                         Achieved_Financial_Savings_Total__c,
                                         Achieved_Operational_Savings_Total__c,
                                         Future_Financial_Savings_Total__c,
                                         Future_Operational_Savings_Total__c,                                          
                                         Benefit_Amount_Achieved_Future_k__c, 
                                         Benefit_Operational_Achieved_Future_k__c                                      

                                         from QIPP_Benefit__c 
                                         where  Project_ID__c =:Proj.id];
            //return Benefits_RelatedList;
       /*
        }catch(Exception exe){
            System.Debug(' ****************************EXCEPTION OCCURES in QIPP_Benefit_View ****************************' + exe.getMessage());
            System.Debug(' ****************************EXCEPTION OCCURES @ Line Number in QIPP_Benefit_View****************************' + exe.getLineNumber());
            //return null;
        }
        */
    }
}