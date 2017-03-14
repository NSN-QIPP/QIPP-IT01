@isTest
public class SPE_DeletePITempDataTest{
public static testmethod void SPE_DeletePITempDataTest(){

Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u;     
        
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'Deep.Banerjee@atos.net';
        insert con;
        
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<10;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        //**********************Changes For Encryption******************//  
        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
        //PIDefObj.Name = 'Test PI Definition'+i;
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        //update lifecycle stage
        
        for(Integer i=0;i<10;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj[i].PIUploadDuedate__c = Date.newInstance(2016,10,10);
        }
        
        update lstPIDefObj;
        
        
       List<SPE_PiValueTemp__c> piValTmp = new List<SPE_PiValueTemp__c>();
       SPE_PiValueTemp__c pival = new SPE_PiValueTemp__c ();
       pival.PIDefination__c=lstPIDefObj[1].id;
       piValTmp.add(pival);
       insert piValTmp;
       
       Database.BatchableContext BC;
       SchedulableContext sc;
       
       SPE_DeletePITempData bat=new SPE_DeletePITempData();
        bat.start(BC);
        bat.execute(sc);
        bat.execute(BC,piValTmp);
        bat.finish(BC);
       
} 

}