global class SPE_intermediateTempUploadBatch implements Database.Batchable<SObject>,Schedulable{
     
    global String UIdentifier;
    global String isExecuteinFinish;
    global SPE_intermediateTempUploadBatch(String s)
    {
        UIdentifier = s;
        
    }
    //************New Constructor for Skip All Validation Part*****************// 
    global SPE_intermediateTempUploadBatch(String s, String isExecutable){
        UIdentifier = s;
        isExecuteinFinish = isExecutable;
    }  
    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,integer.valueOf(100));
        /*if(!Test.isRunningTest()){
            system.abortJob(sc.getTriggerId());
        }*/
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        id p=userinfo.getuserId();
        return Database.getQueryLocator('select TempValue__c,DateFormat__c,PIData__c from SPEIntermediateTempvalue__c where createdbyid =:p AND UniqueIdentifier__c = : UIdentifier limit 49999');
    }
 
     global void execute(Database.BatchableContext BC, List <SPEIntermediateTempvalue__c> scope) {
         List<SPE_PiValueTemp__c> lstPiTempValsToInsert = new List<SPE_PiValueTemp__c>();
         for(SPEIntermediateTempvalue__c f : scope){
            if(f.TempValue__c !='' && f.TempValue__c != null){
                system.debug('f.TempValue__c---' + f.TempValue__c);
                List<String> tempRows = new List<String>();
                tempRows = f.TempValue__c.split('###');
                for(integer i =0;i < tempRows.size(); i ++){
                    SPE_PiValueTemp__c p = new SPE_PiValueTemp__c();
                    List<String> tempFields = tempRows[i].split('@@@');
                    for(integer j = 0;j < tempFields.size();j++){
                        if(tempFields[j].substringBefore('$$$')!='' && tempFields[j].substringBefore('$$$').equalsIgnoreCase('numbervalue__c')){
                           if(tempFields[j].substringAfter('$$$') != '')
                          
                            {
                                String tempDec = tempFields[j].substringAfter('$$$');
                                if(tempDec.contains(','))
                                    tempDec = tempDec.replace(',','');
                                //p.put(tempFields[j].substringBefore('$$$'),decimal.valueOf(tempFields[j].substringAfter('$$$')));
                                p.put(tempFields[j].substringBefore('$$$'),decimal.valueOf(tempDec));
                            }
                        }
                        else if(tempFields[j].substringBefore('$$$')!=''){
                            p.put(tempFields[j].substringBefore('$$$'),tempFields[j].substringAfter('$$$'));
                        }
                        p.put('DateFormat__c',f.DateFormat__c);
                        p.put('PIDefination__c',f.PIData__c);
                        p.put('UniqueIdentifier__c',UIdentifier);
                    }
                    lstPiTempValsToInsert.add(p);
                }
            }
        }
        system.debug(lstPiTempValsToInsert.size() + 'lstPiTempValsToInsert---' + lstPiTempValsToInsert);
        if(!lstPiTempValsToInsert.isEmpty()){
            try{
                insert lstPiTempValsToInsert;
            }
            catch(exception ex){
                system.debug('Exception :: ' + ex.getMessage());
            }
        }
    }
 
    global void finish(Database.BatchableContext bc){
    //************New Addition Part for Skip All Validation Functionality*****************//
        if(!Test.isRunningTest() && isExecuteinFinish == 'AsynchExecution'){
            SPE_intermediateUploadBatch  dtBatch1 = new SPE_intermediateUploadBatch (UIdentifier,'AsynchExecution'); 
            database.executebatch(dtBatch1,150);
        }
    }
}