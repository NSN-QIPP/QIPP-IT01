@isTest(seeAllData=False)
public class SPE2_PIUploadDateUpdateBatchTest {
 

    
    public static testmethod void SPE2_PIUploadDateUpdateBatchTest1(){
 
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    
       
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2016,2,15);
        PIDefObj.PI_Title__c = 'Test PI Definition+i';
         PIDefObj.Additional_Days__c = 2;
          
             PIDefObj.Day_name_of_upload_week__c ='';
             PIDefObj.Frequency__c ='2';
             PIDefObj.End_Date__c =Date.newInstance(2020,3,14);
             PIDefObj.Upload_Day__c =2;
            PIDefObj.Week_Count__c = 'Second';
           PIDefObj.Yearly_Day_Name_of_Upload_Week__c ='Wednesday';
           PIDefObj.Recurrence_frequency_type__c ='Monthly';
           PIDefObj.Additional_Days_for_week__c =3;
           PIDefObj.Yearly_Week_Count__c ='Fourth';
           PIDefObj.Month_Upload_Day__c =2;
           
           
          PIDefObj.Month_Value__c = 'September';
        PIDefObj.Recurrence_Pattern__c ='DayPerMonth';
       
        
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
       }
        insert lstPIDefObj;

        for(Integer i=0;i<2;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        
        update lstPIDefObj;
          
    
        
      Test.startTest();
        
        SPE2_PIUploadDateUpdateBatch obj = new SPE2_PIUploadDateUpdateBatch();
        SchedulableContext scb = null;
        Database.BatchableContext bcb;
        obj.start(bcb);
        obj.execute(bcb,lstPIDefObj);
      
        obj.finish(bcb);
        
        Test.stopTest();    
    }
    
        
        
        public static testmethod void SPE2_PIUploadDateUpdateBatchTest2(){
 
        List<SPE_PIDefinition__c> lstPIDefObj2 = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
        SPE_PIDefinition__c PIDefObj2 = new SPE_PIDefinition__c();
    
       
    PIDefObj2.PIUploadDuedate__c = Date.newInstance(2016,2,15);
        PIDefObj2.PI_Title__c = 'Test PI Definition+i';
         PIDefObj2.Additional_Days__c = 2;
          
             PIDefObj2.Day_name_of_upload_week__c ='';
             PIDefObj2.Frequency__c ='2';
             PIDefObj2.End_Date__c =Date.newInstance(2020,3,14);
             PIDefObj2.Upload_Day__c =2;
            PIDefObj2.Week_Count__c = 'Second';
           PIDefObj2.Yearly_Day_Name_of_Upload_Week__c ='Wednesday';
           PIDefObj2.Recurrence_frequency_type__c ='Monthly';
           PIDefObj2.Additional_Days_for_week__c =3;
           PIDefObj2.Yearly_Week_Count__c ='Fourth';
           PIDefObj2.Month_Upload_Day__c =2;
           
           
          PIDefObj2.Month_Value__c = 'September';
        PIDefObj2.Recurrence_Pattern__c ='WeekPerMonth';
       
        
        PIDefObj2.LifecycleStage__c = 'Draft';
        lstPIDefObj2.add(PIDefObj2);
       }
        insert lstPIDefObj2;

        for(Integer i=0;i<2;i++){
        lstPIDefObj2[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj2[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        
        update lstPIDefObj2;
          
    
        
      Test.startTest();
        
        SPE2_PIUploadDateUpdateBatch obj = new SPE2_PIUploadDateUpdateBatch();
        SchedulableContext scb = null;
        Database.BatchableContext bcb;
        obj.start(bcb);
        obj.execute(bcb,lstPIDefObj2);
      
        obj.finish(bcb);
        
        Test.stopTest();   
        
       
    }
    
     public static testmethod void SPE2_PIUploadDateUpdateBatchTest4(){
 
        List<SPE_PIDefinition__c> lstPIDefObj3 = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
        SPE_PIDefinition__c PIDefObj3 = new SPE_PIDefinition__c();
    
       
    PIDefObj3.PIUploadDuedate__c = Date.newInstance(2016,2,15);
        PIDefObj3.PI_Title__c = 'Test PI Definition+i';
         PIDefObj3.Additional_Days__c = 2;
          
             PIDefObj3.Day_name_of_upload_week__c ='';
             PIDefObj3.Frequency__c ='2';
             PIDefObj3.End_Date__c =Date.newInstance(2020,3,14);
             PIDefObj3.Upload_Day__c =2;
            PIDefObj3.Week_Count__c = 'Second';
           PIDefObj3.Yearly_Day_Name_of_Upload_Week__c ='Wednesday';
           PIDefObj3.Recurrence_frequency_type__c ='Yearly';
           PIDefObj3.Additional_Days_for_week__c =3;
           PIDefObj3.Yearly_Week_Count__c ='Second';
           PIDefObj3.Month_Upload_Day__c =2;
           
           
          PIDefObj3.Month_Value__c = 'September';
        PIDefObj3.Recurrence_Pattern__c ='WeekPerYear';
       
        
        PIDefObj3.LifecycleStage__c = 'Draft';
        lstPIDefObj3.add(PIDefObj3);
       }
        insert lstPIDefObj3;

        for(Integer i=0;i<2;i++){
        lstPIDefObj3[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj3[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        
        update lstPIDefObj3;
          
    
        
      Test.startTest();
        
        SPE2_PIUploadDateUpdateBatch obj = new SPE2_PIUploadDateUpdateBatch();
        SchedulableContext scb = null;
        Database.BatchableContext bcb;
        obj.start(bcb);
        obj.execute(bcb,lstPIDefObj3);
      
        obj.finish(bcb);
        
        Test.stopTest();   
        
       
    } 
    public static testmethod void SPE2_PIUploadDateUpdateBatchTest3(){
 
        List<SPE_PIDefinition__c> lstPIDefObj3 = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
        SPE_PIDefinition__c PIDefObj3 = new SPE_PIDefinition__c();
    
       
    PIDefObj3.PIUploadDuedate__c = Date.newInstance(2016,2,15);
        PIDefObj3.PI_Title__c = 'Test PI Definition+i';
         PIDefObj3.Additional_Days__c = 2;
          
             PIDefObj3.Day_name_of_upload_week__c ='';
             PIDefObj3.Frequency__c ='2';
             PIDefObj3.End_Date__c =Date.newInstance(2020,3,14);
             PIDefObj3.Upload_Day__c =2;
            PIDefObj3.Week_Count__c = 'Second';
           PIDefObj3.Yearly_Day_Name_of_Upload_Week__c ='Wednesday';
           PIDefObj3.Recurrence_frequency_type__c ='Yearly';
           PIDefObj3.Additional_Days_for_week__c =3;
           PIDefObj3.Yearly_Week_Count__c ='Second';
           PIDefObj3.Month_Upload_Day__c =2;
           
           
          PIDefObj3.Month_Value__c = 'September';
        PIDefObj3.Recurrence_Pattern__c ='DayPerYear';
       
        
        PIDefObj3.LifecycleStage__c = 'Draft';
        lstPIDefObj3.add(PIDefObj3);
       }
        insert lstPIDefObj3;

        for(Integer i=0;i<2;i++){
        lstPIDefObj3[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj3[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        
        update lstPIDefObj3;
          
    
        
      Test.startTest();
        
        SPE2_PIUploadDateUpdateBatch obj = new SPE2_PIUploadDateUpdateBatch();
        SchedulableContext scb = null;
        Database.BatchableContext bcb;
        obj.start(bcb);
        obj.execute(bcb,lstPIDefObj3);
      
        obj.finish(bcb);
        
        Test.stopTest();   
        
       
    } 

}