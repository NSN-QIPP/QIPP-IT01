@isTest(seeAllData=false)
public class SPE2_UpdateKPIScheduleDateFromPITest{
    public static testmethod void UpdateKPIScheduleDateFromPI_test1(){
    Test.startTest();
    
       List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj.PI_Title__c = 'Test PI Definition';
        PIDefObj.LifecycleStage__c = 'Draft';
        PIDefObj.DataAcquisitionMethod__c = 'Data Load';
        PIDefObj.PIUploadDuedate__c = Date.newInstance(2016,3,10);
        lstPIDefObj.add(PIDefObj);
                
        SPE_PIDefinition__c PIDefObj1 = new SPE_PIDefinition__c();
        PIDefObj1 = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj1.PI_Title__c = 'Test PI Definition';
        PIDefObj1.LifecycleStage__c = 'Draft';
        PIDefObj1.DataAcquisitionMethod__c = 'Data Load';
        PIDefObj1.PIUploadDuedate__c = Date.newInstance(2018,10,10);
        lstPIDefObj.add(PIDefObj1);
        
        insert lstPIDefObj;
        
        for(SPE_PIDefinition__c pi : lstPIDefObj){
            pi.LifecycleStage__c= 'Pilot';
        }
        update lstPIDefObj;
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
       //**********************Changes For Encryption******************// 
        //kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
       //**********************END******************// 
        kpiDefinition1.PI_Data__c = lstPIDefObj[0].Id;
        kpiDefinition1.Buffer_Days__c = null;
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'SPE Invalid';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Cost';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.ActualCalculation__c='A';
       // kpiDefinition1.FrequencyinMonth__c = '2';
       // kpiDefinition1.ScheduledDate__c = date.newInstance(2020,01,20);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.Aggregation__c = 'AVG';        
        kpiDefinition1.IsHighBetter__c=true;
        insert kpiDefinition1;
        
     //   kpiDefinition1.LifecycleStage__c = 'Pilot';
     //   update kpiDefinition1;
        
        SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
       //**********************Changes For Encryption******************// 
        //kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition2.KPI_Title__c = 'Test KPI Definition 123';
       //**********************END******************// 
        kpiDefinition2.PI_Data__c = lstPIDefObj[1].Id;
        kpiDefinition2.Buffer_Days__c = null;
        kpiDefinition2.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition2.Level__c = '1';
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        kpiDefinition2.Description__c = 'Test';
        kpiDefinition2.MissingDatalogic__c = 'SPE Invalid';
        kpiDefinition2.OperationalType__c = 'Leading PI';
        kpiDefinition2.GeoScope__c = 'All Markets';
        kpiDefinition2.categoryscope__c = 'All Categories';
        kpiDefinition2.BUScope__c = 'All Products';
        kpiDefinition2.UoM__c = 'max';
        kpiDefinition2.Group1__c = 'Cost';
        kpiDefinition2.Group2__c = 'Hard';
        kpiDefinition2.Type__c = 'Operational';
        kpiDefinition2.ActualCalculation__c='A';
        //kpiDefinition2.FrequencyinMonth__c = '2';
        //kpiDefinition2.ScheduledDate__c = date.newInstance(2020,01,20);
        kpiDefinition2.VerNumber__c = 0;
        kpiDefinition2.Aggregation__c = 'AVG';        
        kpiDefinition2.IsHighBetter__c=true;
        insert kpiDefinition2;
        
  
        list<SPE_KPIDefinition__c>  lstKPI=[Select Id,ScheduledDate__c,Buffer_Days__c ,PI_Data__c,PI_Data__r.PIUploadDuedate__c From SPE_KPIDefinition__c 
                  Where PI_Data__c != null And PI_Data__r.PIUploadDuedate__c != null];
        
        for(SPE_KPIDefinition__c kpi : lstKPI ){
            kpi.LifecycleStage__c = 'Pilot';           
        }
        update lstKPI;
        update  lstPIDefObj;   
        
                    
    Test.stopTest();     
    }
}