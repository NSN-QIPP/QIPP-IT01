global class SPE_PIUploadBatch implements Database.Batchable<sObject>, Database.Stateful,Schedulable {

/***************************************************************************************************
Apex Class Name      :  SPE_PIUploadBatch
Version              :  1.0 
Created Date         :  10/06/2015
Function             :  This batch is used to upload PI Values from the wizard
              
Modification Log     :
* ------------------------------------------------------------------------------------
* Developer                   Date                   Description
* ------------------------------------------------------------------------------------                  
* Kaushik Ganguly             10/06/2015                      Original Version
* Kaushik Ganguly             02/11/2015                      Modifications in the mail body
*****************************************************************************************************/   
    
    String query;
    List<SPE_PIValues__c> lstErrorRecords = new List<SPE_PIValues__c>();
    List<SPE_PIValues__c> lstPIValuesToInsert;
    List<SPE_PiValueTemp__c> lstPITempValuesToUpdate;
    Schema.SObjectType sobjType;
    String strPIId;
    List<String> lstSuccessCount = new List<String>();
    public String uniqID;
    
    global SPE_PIUploadBatch(String unID){
    uniqID = unID;
    
    }
    
    // Start Method
    global Database.QueryLocator start(Database.BatchableContext BC){
     
         /********************************************************
                        ALGORITHM
            1. Query from the temporary object SPE_PiValueTemp__c

         **********************************************************/
         String strUserId = UserInfo.getUserId();
         query = 'Select'
                    + ' Id,BooleanValue__c,BusinessLine__c,BusinessUnit__c,Category__c,Cluster__c,CategoryGroup__c,Country__c,DateValue__c, '
                    + ' EnterpriseID__c,Filter1__c,Filter10__c,Filter2__c,Filter4__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Market__c,MarketUnit__c, '
                    + ' NumberValue__c,Period1__c,PIDefination__c,Product__c,Project__c,StringValue__c,ValidateCategory__c, '
                    + ' Verified__c,Verified_BU__c,Verified_Geo__c,VerrifiedEnterpriseID__c,ErrorReason__c '
                    + ' from SPE_PiValueTemp__c Where createdById =: strUserId AND Verified__c = true AND UniqueIdentifier__c =: uniqID';

         return Database.getQueryLocator(query);
    }
    
   global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,integer.valueOf(9999));
          if(!Test.isRunningTest()){
        system.abortJob(sc.getTriggerId());
        }
    }
    
    // Execute Logic
   global void execute(Database.BatchableContext BC, List<SPE_PiValueTemp__c>scope){
      lstPIValuesToInsert = new List<SPE_PIValues__c>();
      lstPITempValuesToUpdate = new List<SPE_PiValueTemp__c>();
      for(SPE_PiValueTemp__c objS : scope){
        SPE_PIValues__c objPIV = new SPE_PIValues__c();
        objPIV.BooleanValue__c = objS.BooleanValue__c;
        objPIV.BusinessLine__c = objS.BusinessLine__c;
        objPIV.BusinessUnit__c = objS.BusinessUnit__c;
        objPIV.Category__c = objS.Category__c;
        objPIV.Cluster__c = objS.Cluster__c;
        objPIV.CategoryGroup__c = objS.CategoryGroup__c;
        objPIV.Country__c = objS.Country__c;
        objPIV.DateValue__c = objS.DateValue__c;
        objPIV.EnterpriseID__c = objS.EnterpriseID__c;
        objPIV.Filter1__c = objS.Filter1__c;
        objPIV.Filter10__c = objS.Filter10__c;
        objPIV.Filter2__c = objS.Filter2__c;
        objPIV.Filter4__c = objS.Filter4__c;
        objPIV.Filter6__c = objS.Filter6__c;
        objPIV.Filter7__c = objS.Filter7__c;
        objPIV.Filter8__c = objS.Filter8__c;
        objPIV.Filter9_del__c = objS.Filter9__c;
        objPIV.Market__c = objS.Market__c;
        objPIV.MarketUnit__c = objS.MarketUnit__c;

            
        if(objS.NumberValue__c != null)
           objPIV.NumberValue__c = objS.NumberValue__c;
               
        objPIV.Period__c = objS.Period1__c;
        objPIV.PIDefination__c = objS.PIDefination__c;
        
        system.debug('$$$$ PI defination'+objS.PIDefination__c);
        
        if(objS.PIDefination__c != null){
            strPIId = objS.PIDefination__c;
        }
        
        system.debug('$$$$ STRING'+strPIId);
        
        objPIV.Product__c = objS.Product__c;
        objPIV.Project__c = objS.Project__c;
        objPIV.StringValue__c = objS.StringValue__c;
        
        lstPIValuesToInsert.add(objPIV);
      }  
      List<Database.SaveResult> lstDMLOperationResults = new List<Database.SaveResult>();
      lstDMLOperationResults = Database.insert(lstPIValuesToInsert, false);
      for(Integer i=0;i<lstDMLOperationResults.size();i++){

            if (lstDMLOperationResults.get(i).isSuccess()){
                lstDMLOperationResults.get(i).getId();
                lstSuccessCount.add(lstDMLOperationResults.get(i).getId()+'');
                system.debug('Results success-----');
            }
            else if (!lstDMLOperationResults.get(i).isSuccess()){
                // DML operation failed
                SPE_PiValueTemp__c objTemp = new SPE_PiValueTemp__c();
                Database.Error error = lstDMLOperationResults.get(i).getErrors().get(0);
                String failedDML = error.getMessage();
                objTemp = scope.get(i);
                objTemp.Id = scope.get(i).Id;
                objTemp.ErrorReason__c = failedDML;
                lstPITempValuesToUpdate.add(objTemp);
                system.debug('Failed ID'+scope.get(i).Id);
            }
            
        }
        try{
            if(!lstPITempValuesToUpdate.isEmpty())
                update lstPITempValuesToUpdate;
        }
        catch(Exception ex){
            system.debug('Exception :: ' + ex.getMessage());
        }
        system.debug('Errorneous records'+lstErrorRecords);
        system.debug('lstPITempValuesToUpdate records'+lstPITempValuesToUpdate);
   }
   
   // Finish Logic
   global void finish(Database.BatchableContext BC){
   
      system.debug('lstPITempValuesToUpdate records Final'+lstPITempValuesToUpdate);
      SPE_PIDefinition__c objPI = new SPE_PIDefinition__c();
      
      system.debug('$$$$ STRING'+strPIId);
      
      if(strPIId !=''){
          objPI = [select Id,Name from SPE_PIDefinition__c where id =: strPIId];
      }
      List<SPE_PiValueTemp__c> lstErrorRec = new List<SPE_PiValueTemp__c>();
      lstErrorRec = [Select
                        Id,BooleanValue__c,BusinessLine__c,BusinessUnit__c,Category__c,Cluster__c,CategoryGroup__c,Country__c,DateValue__c,
                        EnterpriseID__c,Filter1__c,Filter10__c,Filter2__c,Filter4__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Market__c,MarketUnit__c, 
                        NumberValue__c,Period1__c,Period__c,PIDefination__c,Product__c,Project__c,StringValue__c,ErrorReason__c,ValidateCategory__c,
                        Verified_BU__c,Verified_Geo__c,VerrifiedEnterpriseID__c
                    from 
                        SPE_PiValueTemp__c 
                    Where 
                        createdById =:UserInfo.getUserId() AND UniqueIdentifier__c =: uniqID
                                              
                    AND (( 
                        ErrorReason__c != ''
                    AND 
                        ErrorReason__c != null)
                   OR
                       Verified__c = false)
                        ];
        
            if(Test.isRunningTest())
            {
                lstErrorRec = [select id,ErrorReason__c,Period1__c,VerrifiedEnterpriseID__c,Verified_Geo__c,Verified_BU__c from SPE_PiValueTemp__c limit 100];
            }
       
        for(SPE_PiValueTemp__c spePIValTemp : lstErrorRec){
            if(spePIValTemp.Period1__c == null && spePIValTemp.ErrorReason__c == ''){
                spePIValTemp.ErrorReason__c = 'Period is missing ';
            }
            
            if(spePIValTemp.VerrifiedEnterpriseID__c == false && spePIValTemp.ErrorReason__c == ''){
                spePIValTemp.ErrorReason__c = 'EID is Faulty ';
            }
            else if(spePIValTemp.VerrifiedEnterpriseID__c == false && spePIValTemp.ErrorReason__c != ''){
                spePIValTemp.ErrorReason__c += '& EID is Faulty ';
            }
            if(spePIValTemp.Verified_Geo__c == false && spePIValTemp.ErrorReason__c == ''){
                spePIValTemp.ErrorReason__c = 'Geo Scope attribute values are Faulty ';
            }
            else if(spePIValTemp.Verified_Geo__c == false && spePIValTemp.ErrorReason__c != ''){
                spePIValTemp.ErrorReason__c += '& Geo Scope attribute values are Faulty ';
            }
            if(spePIValTemp.Verified_BU__c == false && spePIValTemp.ErrorReason__c == ''){
                spePIValTemp.ErrorReason__c = 'Product Scope attribute values are Faulty ';
            }
            else if(spePIValTemp.Verified_BU__c == false && spePIValTemp.ErrorReason__c != ''){
                spePIValTemp.ErrorReason__c += '& Product Scope attribute values are Faulty ';
            }
            if(spePIValTemp.ValidateCategory__c == false && spePIValTemp.ErrorReason__c == ''){
                spePIValTemp.ErrorReason__c = 'Category Scope attribute values are Faulty ';
            }
            else if(spePIValTemp.ValidateCategory__c == false && spePIValTemp.ErrorReason__c != ''){
                spePIValTemp.ErrorReason__c += '& Category Scope attribute values are Faulty ';
            }
        }
                            
        String header = 'BooleanValue__c,BusinessLine__c,BusinessUnit__c,Category__c,Cluster__c,CategoryGroup__c,Country__c,DateValue__c, ' +
                      'EnterpriseID__c,Filter1__c,Filter10__c,Filter2__c,Filter4__c,Filter6__c,Filter7__c,Filter8__c,Filter9__c,Market__c,MarketUnit__c, '+
                      'NumberValue__c,Period__c,PIDefination__c,Product__c,Project__c,StringValue__c,ErrorReason__c \n';
                      
        String finalstr = header ;
      
        for(SPE_PiValueTemp__c spePIVal : lstErrorRec){
           string recordString = '"'+spePIVal.BooleanValue__c + '","' + spePIVal.BusinessLine__c + '","' + spePIVal.BusinessUnit__c+ '","' + spePIVal.Category__c+ '","' + 
                                spePIVal.Cluster__c+ '","' + spePIVal.CategoryGroup__c+ '","' + spePIVal.Country__c+ '","' + spePIVal.DateValue__c+ '","' + 
                                spePIVal.EnterpriseID__c+ '","' + spePIVal.Filter1__c+ '","' + spePIVal.Filter10__c+ '","' + spePIVal.Filter2__c+ '","' + 
                                spePIVal.Filter4__c+ '","' + spePIVal.Filter6__c+ '","' + spePIVal.Filter7__c+ '","' + spePIVal.Filter8__c+ '","' + 
                                spePIVal.Filter9__c+ '","' + spePIVal.Market__c+ '","' + spePIVal.MarketUnit__c + '","' + spePIVal.NumberValue__c+ '","' + 
                                spePIVal.Period__c+ '","' + spePIVal.PIDefination__c+ '","' + spePIVal.Product__c+ '","' + spePIVal.Project__c+ '","' + 
                                spePIVal.StringValue__c+ '","' + spePIVal.ErrorReason__c +'"'+'\n';
          finalstr = finalstr +recordString; 
        }  
        finalstr = finalstr.replace('null','');
        finalstr = finalstr.replace('  00:00:00','');
      // Sending completion mail to the owner if there are any error records
       
      Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
      blob csvBlob = Blob.valueOf(finalstr);
      string csvname= 'ErrorLogs.csv';
      csvAttc.setFileName(csvname);
      csvAttc.setBody(csvBlob);
      Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
      String[] toAddresses = new list<string> {UserInfo.getUserEmail()};
      String subject ='Upload Completed';
      email.setSubject(subject);
      email.setToAddresses( toAddresses );
      String strMailBody = 'The PI Values have been uploaded for PI named <b>' + objPI.Name + '</b>.<br/> There were <b><i>' + lstErrorRec.size() + ' records</i></b> which got dropped off and <b><i>' + lstSuccessCount.size() + ' records</i></b> have been successfully inserted. Please find the attached error file.' ; 
      email.setHtmlBody(strMailBody);
      email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
      Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
      
      delete [select id from 
                        SPE_PiValueTemp__c 
                    Where 
                        createdById =:UserInfo.getUserId() AND UniqueIdentifier__c =: uniqID limit 9999];
   
   }
   
}