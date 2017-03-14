trigger QIPP_UpdateProjectFieldValues on QIPP_Benefit__c (after insert,after update) 
{
List<QIPP_Benefit__C> newben = Trigger.new;
List<QIPP_Benefit__C> oldben = Trigger.Old;
QIPP_Project__c projectinfo;
Decimal actual , remain , planned ;

Integer countForCheck = 0;
String ImprovmentName = '';

if(newben[0].Project_ID__c != null)    
{
   projectinfo = [select ID   , Belt_Project_Type__c , Name , Project_Name_Succinct__c , Portfolio_Name__r.Portfolio_Name_Unique__c , Portfolio_Name__r.Portfolio_Business_Unit__c , Project_BL__c , Benefitting_Project_BL_Level_4_Org__c , Project_Lead_BU__c , Project_Lead_BL_Level_3_Org__c , Project_Lead_BL_Level_4_Org__c , DI_State__c , Project_Number__c ,  Project_Type__c from QIPP_Project__c where id =: newben[0].Project_ID__c];
}  

       List<QIPP_Benefit_Conversion_Table__c> strImprovmentMeasure = [ select Name from  QIPP_Benefit_Conversion_Table__c where Id =: newben[0].Improvement_Measure_KPI__c];
       if(strImprovmentMeasure.size() > 0 &&  strImprovmentMeasure != null)
           ImprovmentName = strImprovmentMeasure[0].Name;
       
if(Trigger.isInsert)
{
    System.Debug('********** Inside insert *********** ');
    try
    {

               
    // logic for creation of quarterwise result......
        Decimal PlannedFinancialOperationlValue  = 0.0;
        Decimal AchievedFinancialOperationlValue  = 0.0;
        Decimal FutureFinancialOperationlValue   = 0.0;                
        Boolean FlagForValue = null;
        
      
      
         List<QIPP_BU_Reporting__c> BUData = [select ID from QIPP_BU_Reporting__c where Benefit_ID__c =: newben[0].ID];
         delete BUData  ;
         
              
            if(newben[0].Planned_Financial_Automatic_Amount__c != null)
            {
                PlannedFinancialOperationlValue = newben[0].Planned_Financial_Automatic_Amount__c  ;
            }    
            else if(newben[0].Planned_Financial_Manual_Amount__c != null)
            {
                PlannedFinancialOperationlValue = newben[0].Planned_Financial_Manual_Amount__c ;
            }
            else if(newben[0].Planned_Operational_Manual_Amount__c != null)
            {
                 PlannedFinancialOperationlValue = newben[0].Planned_Operational_Manual_Amount__c;
            }
            else if(newben[0].Planned_Operational_Automatic_Amount__c != null)
            {
                PlannedFinancialOperationlValue = newben[0].Planned_Operational_Automatic_Amount__c;
            }
            
            List<QIPP_BU_Reporting__c> insertDatainObjectPlanned = QIPP_GenerateQuarterWiseReport.CreateRC(newben[0].ID ,PlannedFinancialOperationlValue , newben[0].Planned_Start_Date__c , newben[0].Planned_End_Date__c , projectinfo.Portfolio_Name__r.Portfolio_Business_Unit__c , newben[0].Financial_Type__c , projectinfo.Project_Name_Succinct__c , projectinfo.Portfolio_Name__r.Portfolio_Name_Unique__c , newben[0].Benefit_Type__c , newben[0].Business_Line__c , ImprovmentName ,  projectinfo.id , 'Planned'  , projectinfo.Project_BL__c , projectinfo.Benefitting_Project_BL_Level_4_Org__c , projectinfo.Project_Lead_BU__c , projectinfo.Project_Lead_BL_Level_3_Org__c , projectinfo.Project_Lead_BL_Level_4_Org__c , projectinfo.DI_State__c , projectinfo.Project_Number__c , projectinfo.Project_Type__c , projectinfo.Belt_Project_Type__c);
            System.Debug('********** In Insert Trigger *********** ' + insertDatainObjectPlanned );            
            QIPP_GenerateQuarterWiseReport.UpdateAmount(insertDatainObjectPlanned);
            

            if(newben[0].Achieved_Financial_Automatic_Amount__c != null)
            {
                AchievedFinancialOperationlValue  = newben[0].Achieved_Financial_Automatic_Amount__c  ;
            }    
            else if(newben[0].Achieved_Financial_Manual_Amount__c  != null)
            {
                AchievedFinancialOperationlValue  = newben[0].Achieved_Financial_Manual_Amount__c  ;
            }
            else if(newben[0].Achieved_Operational_Automatic_Amount__c != null)
            {
                AchievedFinancialOperationlValue = newben[0].Achieved_Operational_Automatic_Amount__c;
            }
            else if(newben[0].Achieved_Operational_Manual_Amount__c != null)
            {
                AchievedFinancialOperationlValue = newben[0].Achieved_Operational_Manual_Amount__c;
            }
            
            List<QIPP_BU_Reporting__c> insertDatainObjectAchieved = QIPP_GenerateQuarterWiseReport.CreateRC(newben[0].ID , AchievedFinancialOperationlValue , newben[0].Achieved_Start_Date__c , newben[0].Achieved_End_Date__c , projectinfo.Portfolio_Name__r.Portfolio_Business_Unit__c , newben[0].Financial_Type__c , projectinfo.Project_Name_Succinct__c , projectinfo.Portfolio_Name__r.Portfolio_Name_Unique__c , newben[0].Benefit_Type__c , newben[0].Business_Line__c , ImprovmentName ,  projectinfo.id ,'Achieved' , projectinfo.Project_BL__c , projectinfo.Benefitting_Project_BL_Level_4_Org__c , projectinfo.Project_Lead_BU__c , projectinfo.Project_Lead_BL_Level_3_Org__c , projectinfo.Project_Lead_BL_Level_4_Org__c , projectinfo.DI_State__c , projectinfo.Project_Number__c , projectinfo.Project_Type__c  , projectinfo.Belt_Project_Type__c);
            System.Debug('********** In Insert Trigger *********** ' + insertDatainObjectAchieved);            
            QIPP_GenerateQuarterWiseReport.UpdateAmount(insertDatainObjectAchieved);
            
            
            
            if(newben[0].Future_Financial_Automatic_Amount__c != null)
            {
                FutureFinancialOperationlValue  = newben[0].Future_Financial_Automatic_Amount__c  ;
            }    
            else if(newben[0].Future_Financial_Manual_Amount__c  != null)
            {
                FutureFinancialOperationlValue  = newben[0].Future_Financial_Manual_Amount__c  ;
            }
            else if(newben[0].Future_Operational_Automatic_Amount__c != null)
            { 
                FutureFinancialOperationlValue  = newben[0].Future_Operational_Automatic_Amount__c;
            }
            else if(newben[0].Future_Operational_Manual_Amount__c != null)
            { 
                FutureFinancialOperationlValue  = newben[0].Future_Operational_Manual_Amount__c;
            }
            
            List<QIPP_BU_Reporting__c> insertDatainObjectFuture  = QIPP_GenerateQuarterWiseReport.CreateRC(newben[0].ID ,FutureFinancialOperationlValue  , newben[0].Future_Start_Date__c , newben[0].Future_End_Date__c , projectinfo.Portfolio_Name__r.Portfolio_Business_Unit__c , newben[0].Financial_Type__c , projectinfo.Project_Name_Succinct__c , projectinfo.Portfolio_Name__r.Portfolio_Name_Unique__c , newben[0].Benefit_Type__c , newben[0].Business_Line__c , ImprovmentName ,  projectinfo.id , 'Future' , projectinfo.Project_BL__c , projectinfo.Benefitting_Project_BL_Level_4_Org__c , projectinfo.Project_Lead_BU__c , projectinfo.Project_Lead_BL_Level_3_Org__c , projectinfo.Project_Lead_BL_Level_4_Org__c , projectinfo.DI_State__c , projectinfo.Project_Number__c , projectinfo.Project_Type__c  , projectinfo.Belt_Project_Type__c);
            System.Debug('********** In Insert Trigger *********** ' + insertDatainObjectFuture );            
            QIPP_GenerateQuarterWiseReport.UpdateAmount(insertDatainObjectFuture );

                
     }
     catch(Exception exe)
     {
         System.Debug('************ Exception Occured in Trigger ************** ' + exe.getMessage());
         System.Debug('************ Exception Occured in Trigger ************** ' + exe.getLineNumber());         
     }       
}

if(Trigger.isUpdate)
{
    // logic for creation of quarterwise result......
    System.Debug('********** Inside upsert*********** ');
    Decimal PlannedFinancialOperationlValue  = 0.0;
    Decimal AchievedFinancialOperationlValue  = 0.0;
    Decimal FutureFinancialOperationlValue   = 0.0;   
    List<QIPP_BU_Reporting__c> insertDatainObjectPlanned = null ;
    List<QIPP_BU_Reporting__c> insertDatainObjectAchieved = null;
    List<QIPP_BU_Reporting__c> insertDatainObjectFuture = null;
   
    

    if((newben[0].Planned_Financial_Automatic_Amount__c != oldben[0].Planned_Financial_Automatic_Amount__c)||(newben[0].Planned_Financial_Manual_Amount__c != oldben[0].Planned_Financial_Manual_Amount__c)||(newben[0].Planned_Operational_Manual_Amount__c != oldben[0].Planned_Operational_Manual_Amount__c)||(newben[0].Planned_Operational_Automatic_Amount__c != oldben[0].Planned_Operational_Automatic_Amount__c)||(newben[0].Planned_Start_Date__c != oldben[0].Planned_Start_Date__c) || (newben[0].Planned_End_Date__c != oldben[0].Planned_End_Date__c))
    {
        List<QIPP_BU_Reporting__c> BUData = [select ID from QIPP_BU_Reporting__c where Benefit_ID__c =: newben[0].ID and    Benefit_Phase__c =: 'Planned'];  
        delete BUData  ;   

        System.Debug('********** inside update 1 *********** ' );

            if(newben[0].Planned_Financial_Automatic_Amount__c != null)
            {
                PlannedFinancialOperationlValue = newben[0].Planned_Financial_Automatic_Amount__c  ;
            }    
            else if(newben[0].Planned_Financial_Manual_Amount__c != null)
            {
                PlannedFinancialOperationlValue = newben[0].Planned_Financial_Manual_Amount__c ;
            }
            else if(newben[0].Planned_Operational_Manual_Amount__c != null)
            {
                 PlannedFinancialOperationlValue = newben[0].Planned_Operational_Manual_Amount__c;
            }
            else if(newben[0].Planned_Operational_Automatic_Amount__c != null)
            {
                 PlannedFinancialOperationlValue = newben[0].Planned_Operational_Automatic_Amount__c;
            }
            insertDatainObjectPlanned = QIPP_GenerateQuarterWiseReport.CreateRC(newben[0].ID ,PlannedFinancialOperationlValue , newben[0].Planned_Start_Date__c , newben[0].Planned_End_Date__c , projectinfo.Portfolio_Name__r.Portfolio_Business_Unit__c , newben[0].Financial_Type__c , projectinfo.Project_Name_Succinct__c , projectinfo.Portfolio_Name__r.Portfolio_Name_Unique__c , newben[0].Benefit_Type__c , newben[0].Business_Line__c , ImprovmentName ,  projectinfo.id , 'Planned' ,  projectinfo.Project_BL__c  , projectinfo.Benefitting_Project_BL_Level_4_Org__c , projectinfo.Project_Lead_BU__c , projectinfo.Project_Lead_BL_Level_3_Org__c , projectinfo.Project_Lead_BL_Level_4_Org__c , projectinfo.DI_State__c , projectinfo.Project_Number__c, projectinfo.Project_Type__c  , projectinfo.Belt_Project_Type__c);
            System.Debug('********** PlannedFinancialOperationlValue  *********** ' + PlannedFinancialOperationlValue );
            System.Debug('********** insertDatainObjectPlanned.size() *********** ' + insertDatainObjectPlanned.size());
            QIPP_GenerateQuarterWiseReport.UpdateAmount(insertDatainObjectPlanned);            
    }
    
    if((newben[0].Achieved_Financial_Automatic_Amount__c != oldben[0].Achieved_Financial_Automatic_Amount__c)||(newben[0].Achieved_Financial_Manual_Amount__c  != oldben[0].Achieved_Financial_Manual_Amount__c )||(newben[0].Achieved_Operational_Automatic_Amount__c != oldben[0].Achieved_Operational_Automatic_Amount__c)||(newben[0].Achieved_Operational_Manual_Amount__c != oldben[0].Achieved_Operational_Manual_Amount__c)||(newben[0].Achieved_Start_Date__c != oldben[0].Achieved_Start_Date__c) || (newben[0].Achieved_End_Date__c != oldben[0].Achieved_End_Date__c))
    {
    
        List<QIPP_BU_Reporting__c> BUData = [select ID from QIPP_BU_Reporting__c where Benefit_ID__c =: newben[0].ID and    Benefit_Phase__c =: 'Achieved'];  
        delete BUData  ;   
    
        System.Debug('********** inside update 2 *********** ' );
            
            if(newben[0].Achieved_Financial_Automatic_Amount__c != null)
            {
                AchievedFinancialOperationlValue = newben[0].Achieved_Financial_Automatic_Amount__c  ;
            }    
            else if(newben[0].Achieved_Financial_Manual_Amount__c  != null)
            {
                AchievedFinancialOperationlValue = newben[0].Achieved_Financial_Manual_Amount__c  ;
            }
            else if(newben[0].Achieved_Operational_Automatic_Amount__c != null)
            {
                AchievedFinancialOperationlValue = newben[0].Achieved_Operational_Automatic_Amount__c;
            }
            else if(newben[0].Achieved_Operational_Manual_Amount__c != null)
            {
                AchievedFinancialOperationlValue = newben[0].Achieved_Operational_Manual_Amount__c;
            }
            
            insertDatainObjectAchieved  = QIPP_GenerateQuarterWiseReport.CreateRC(newben[0].ID ,AchievedFinancialOperationlValue, newben[0].Achieved_Start_Date__c , newben[0].Achieved_End_Date__c , projectinfo.Portfolio_Name__r.Portfolio_Business_Unit__c , newben[0].Financial_Type__c , projectinfo.Project_Name_Succinct__c , projectinfo.Portfolio_Name__r.Portfolio_Name_Unique__c , newben[0].Benefit_Type__c , newben[0].Business_Line__c , ImprovmentName ,  projectinfo.id , 'Achieved' ,  projectinfo.Project_BL__c  , projectinfo.Benefitting_Project_BL_Level_4_Org__c , projectinfo.Project_Lead_BU__c , projectinfo.Project_Lead_BL_Level_3_Org__c , projectinfo.Project_Lead_BL_Level_4_Org__c , projectinfo.DI_State__c , projectinfo.Project_Number__c , projectinfo.Project_Type__c , projectinfo.Belt_Project_Type__c);
            System.Debug('********** AchievedFinancialOperationlValue *********** ' + AchievedFinancialOperationlValue );
            System.Debug('********** insertDatainObjectAchieved.size() *********** ' + insertDatainObjectAchieved.size());
            QIPP_GenerateQuarterWiseReport.UpdateAmount(insertDatainObjectAchieved  );
    }
 
    if((newben[0].Future_Financial_Automatic_Amount__c != oldben[0].Future_Financial_Automatic_Amount__c)||(newben[0].Future_Financial_Manual_Amount__c  != oldben[0].Future_Financial_Manual_Amount__c )||(newben[0].Future_Operational_Automatic_Amount__c != oldben[0].Future_Operational_Automatic_Amount__c)||(newben[0].Future_Operational_Manual_Amount__c != oldben[0].Future_Operational_Manual_Amount__c)||(newben[0].Future_Start_Date__c != oldben[0].Future_Start_Date__c ) || (newben[0].Future_End_Date__c != oldben[0].Future_End_Date__c))
    {

        List<QIPP_BU_Reporting__c> BUData = [select ID from QIPP_BU_Reporting__c where Benefit_ID__c =: newben[0].ID and    Benefit_Phase__c =: 'Future'];  
        delete BUData  ;       
     
        System.Debug('********** inside update 3*********** ' );
            
            if(newben[0].Future_Financial_Automatic_Amount__c != null)
            {
                FutureFinancialOperationlValue  = newben[0].Future_Financial_Automatic_Amount__c  ;
            }    
            else if(newben[0].Future_Financial_Manual_Amount__c  != null)
            {
                FutureFinancialOperationlValue  = newben[0].Future_Financial_Manual_Amount__c  ;
            }
            else if(newben[0].Future_Operational_Automatic_Amount__c != null)
            {
                FutureFinancialOperationlValue  = newben[0].Future_Operational_Automatic_Amount__c;
            }
            else if(newben[0].Future_Operational_Manual_Amount__c != null)
            {
                FutureFinancialOperationlValue  = newben[0].Future_Operational_Manual_Amount__c;
            }
            insertDatainObjectFuture  = QIPP_GenerateQuarterWiseReport.CreateRC(newben[0].ID ,FutureFinancialOperationlValue  , newben[0].Future_Start_Date__c , newben[0].Future_End_Date__c ,projectinfo.Portfolio_Name__r.Portfolio_Business_Unit__c , newben[0].Financial_Type__c , projectinfo.Project_Name_Succinct__c , projectinfo.Portfolio_Name__r.Portfolio_Name_Unique__c , newben[0].Benefit_Type__c , newben[0].Business_Line__c , ImprovmentName ,  projectinfo.id ,'Future' , projectinfo.Project_BL__c  , projectinfo.Benefitting_Project_BL_Level_4_Org__c , projectinfo.Project_Lead_BU__c , projectinfo.Project_Lead_BL_Level_3_Org__c , projectinfo.Project_Lead_BL_Level_4_Org__c , projectinfo.DI_State__c , projectinfo.Project_Number__c , projectinfo.Project_Type__c , projectinfo.Belt_Project_Type__c);
            System.Debug('********** FutureFinancialOperationlValue  *********** ' + FutureFinancialOperationlValue  );
            System.Debug('********** insertDatainObjectFuture.size() *********** ' + insertDatainObjectFuture.size());
            QIPP_GenerateQuarterWiseReport.UpdateAmount(insertDatainObjectFuture );
    }
}
update  projectinfo;
}