public with sharing class SPE_intermediateUploadEXT {


public ID batchprocessid {get;set;}
public string statuss{get;set;}
public integer percentComplete {get;set;}
public Double itemsProcessed {get;set;} 
public Double totalItems {get;set;} 
public Id newId{get;set;}
public integer ch;
public string classname{get;set;}
public ID batchprocessid1 {get;set;}
public string statuss1{get;set;}
public integer percentComplete1 {get;set;}
public Double itemsProcessed1 {get;set;} 
public Double totalItems1 {get;set;} 
public Id newId1{get;set;}
public integer ch1;
public String uniqueID;

public SPE_intermediateUploadEXT(){
uniqueID = ApexPages.currentPage().getParameters().get('uID');
SPE_intermediateUploadBatch dtbatch= new SPE_intermediateUploadBatch(uniqueID);
statuss1='Starting Validation';
statuss='Queued';
ch1=0;
system.debug('uniqueID1::'+uniqueID);
}

public void startbatch() {
system.debug('uniqueID2::'+uniqueID);
//SPE_intermediateUploadBatch  dtBatch = new SPE_intermediateUploadBatch (uniqueID); 
//batchprocessid=database.executebatch(dtBatch,150);
SPE_intermediateTempUploadBatch dtbatch= new SPE_intermediateTempUploadBatch(uniqueID);

//String CronExp= Datetime.now().addMinutes(1).format('ss mm HH dd MM ? yyyy');
//System.schedule(SPE_Constants.AdhocScheduleJob+system.now(),CronExp,dtbatch);
        
batchprocessid1=database.executebatch(dtBatch,1);

}
//************New Method for Skip All Validation Part*****************//
    public void asynchBatchRun() {
        system.debug('uniqueID2::'+uniqueID);
        SPE_intermediateTempUploadBatch dtbatch= new SPE_intermediateTempUploadBatch(uniqueID,'AsynchExecution');    
        ID batchprocessidTemp = database.executebatch(dtBatch,1);                    
    }
    
    public pagereference BatchJobDetail(){
        
        //Query the Batch apex jobs
        for(AsyncApexJob a : [select TotalJobItems, Status, NumberOfErrors, MethodName, JobType, JobItemsProcessed, Id, CreatedDate, CreatedById, CompletedDate, ApexClassId, ApexClass.Name From AsyncApexJob where id=:batchprocessid1]){
            itemsProcessed1 = a.JobItemsProcessed;
            totalItems1 = a.TotalJobItems;
            newId1=a.Id; 
            classname=a.ApexClass.Name;
            statuss1=a.Status;
 
            //Determine the pecent complete based on the number of batches complete
            if(totalItems1 == 0){
                //A little check here as we don't want to divide by 0.
                percentComplete1 = 0;
            }else{
                percentComplete1 = ((itemsProcessed1  / totalItems1) * 100.0).intValue();
            }
            if(statuss1=='Completed'){
            percentComplete1 =100;
            ch1=ch1+1;   
            }
             if(ch1==2)
             {
             SPE_intermediateUploadBatch  dtBatch = new SPE_intermediateUploadBatch (uniqueID); 
             //String CronExp= Datetime.now().addMinutes(1).format('ss mm HH dd MM ? yyyy');
             //System.schedule(SPE_Constants.AdhocScheduleJob+system.now(),CronExp,dtbatch1);
             batchprocessid=database.executebatch(dtBatch,150);
             }
            
        }
        if(statuss1=='Completed' && ch1>=2) {
            for(AsyncApexJob a : [select TotalJobItems, Status, NumberOfErrors, MethodName, JobType, JobItemsProcessed, Id, CreatedDate, CreatedById, CompletedDate, ApexClassId, ApexClass.Name From AsyncApexJob where id=:batchprocessid]){
            itemsProcessed = a.JobItemsProcessed;
            totalItems = a.TotalJobItems;
            newId=a.Id; 
            classname=a.ApexClass.Name;
            statuss=a.Status;
 
            //Determine the pecent complete based on the number of batches complete
            if(totalItems == 0){
                //A little check here as we don't want to divide by 0.
                percentComplete = 0;
            }else{
                percentComplete = ((itemsProcessed  / totalItems) * 100.0).intValue();
            }
            if(statuss=='Completed'){
            percentComplete =100;
            
            }
 
            
        }
        
        
        }
        
        pagereference p;
        
         //if(statuss=='Completed')
         if(statuss=='Completed')
         {
         p= new pagereference('/apex/SPE_VerifyEnterpriseID?uID='+uniqueID);
         p.setredirect(true);
         }
        return p;
    }
 
    
 
}