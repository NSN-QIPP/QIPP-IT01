@IsTest(SeeAllData=false)
public class SPE_PIUploadBatch_Test {
    static testmethod void testSPE_PIUploadBatch(){
    
        //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
    PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
    picklistObj.Business_Line__c = 'All Business Lines';
    picklistObj.Business_Unit__c = 'All Business Units';
    picklistObj.Category_Area__c = 'All Category Areas';
    picklistObj.Category_Group__c = 'All Category Groups';
    picklistObj.Category__c = 'All Categories';
    picklistObj.Country__c = 'All Countries';
    picklistObj.Market_Unit__c = 'All Market Units';
    picklistObj.Market__c = 'All Markets';
    picklistObj.Name = 'Picklist Default Values';
    picklistObj.Product__c = 'All Products';
    picklistObj.Project__c = 'All Projects';
    
    lstpicklistObj.add(picklistObj);
    
    insert lstpicklistObj;
    
    insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
    
        List<SPE_KPIDefinition__c> lstSPE = new List<SPE_KPIDefinition__c>();
        SPE_KPIDefinition__c speObj1 = new SPE_KPIDefinition__c();
        
     //**********************Changes For Encryption*******************//   
        //speObj1.Name = 'test1';
        speObj1.KPI_Title__c = 'test1';
     //**************************END*************************//   
        speObj1.ScheduledDate__c =  Date.newInstance(2099, 07, 02); 
        speObj1.FrequencyinMonth__c = '1';
        
        system.debug('date for obj1'+speObj1.ScheduledDate__c);
        lstSPE.add(speObj1);
        
        SPE_KPIDefinition__c speObj2 = new SPE_KPIDefinition__c();
        
    //**********************Changes For Encryption*******************//    
        //speObj2.Name = 'test2';
        speObj2.KPI_Title__c = 'test2';
    //**************************END*************************//
        
        speObj2.ScheduledDate__c = Date.newInstance(2099, 07, 02); 
        speObj2.FrequencyinMonth__c = '1';
        
        lstSPE.add(speObj2);
        insert lstSPE;
        
        
        SPE_PIDefinition__c PIData = new SPE_PIDefinition__c();
        
    //**********************Changes For Encryption*******************//
        //PIData.Name='Test it 2015';
        PIData.PI_Title__c ='Test it 2015';
    //**************************END*************************//    
        
        PIData.PIAbbreviation__c='123456';
        PIData.ValuesType__c='Number';
        PIData.UoM__c='3';
        PIData.DataAcquisitionMethod__c='Data Load';
        PIData.GeoScope__c='All Markets';
        PIData.CategoryScope__c='All Categories';
        PIData.BUScope__c='All Products';
        PIData.PIUploadDuedate__c=Date.newInstance(2016,10,10);
        
        insert PIData;
        
        List<SPE_PiValueTemp__c> lstSPEValTemp = new List<SPE_PiValueTemp__c>();
        
        SPE_PiValueTemp__c PIvalTemp = new SPE_PiValueTemp__c();
        
        PIvalTemp.CurrencyIsoCode='EUR';
        PIvalTemp.PIDefination__c=PIData.Id;
        
        
        lstSPEValTemp.add(PIvalTemp);

        
                        SPE_PiValueTemp__c PIvalTemp2 = new SPE_PiValueTemp__c();
        
        PIvalTemp2.CurrencyIsoCode='EUR';
        PIvalTemp2.PIDefination__c=PIData.Id;
        PIvalTemp2.ErrorReason__c = 'Period is missing';
            lstSPEValTemp.add(PIvalTemp2);
        
        Insert lstSPEValTemp;
        
        test.startTest();
        
        //String query='select id,ScheduledDate__c,FrequencyinMonth__c from SPE_KPIDefinition__c where ScheduledDate__c=/'2015-07-01'/';
        String tempstring='ABCD';
        
        SPE_PIUploadBatch batchObj = new SPE_PIUploadBatch(tempstring);
        Database.QueryLocator QL;
        Database.BatchableContext BC;
        QL = batchObj.start(BC);
        batchObj.execute(BC,lstSPEValTemp);
        SchedulableContext sc = null;
        //batchObj.execute(sc);
        batchObj.finish(BC);
        test.stopTest();
        //Integer month = lstSPE[0].ScheduledDate__c.month();
        //system.assertEquals(8,month);
      }
        
        
        
}