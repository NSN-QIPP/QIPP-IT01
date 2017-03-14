@isTest(seeAllData=False)
public class SPE2_AddLanguageKPIExt_test {
   public static testmethod void SPE2_AddLanguageKPIExtTest1 () {
    SPE_KPIDefinition__c testSPEKPIDefinition = new SPE_KPIDefinition__c ();
    testSPEKPIDefinition.KPI_Title__c='Test KPI';
    testSPEKPIDefinition.ScheduledDate__c =  Date.Today().addDays(1);
    testSPEKPIDefinition.FrequencyinMonth__c = '2';
    Insert testSPEKPIDefinition;
       SPE2_Language_KPI__c obj=new SPE2_Language_KPI__c();
       obj.English_Language_Description__c= 'Description';
       	insert obj;

      
       
    ApexPages.StandardController sc = new ApexPages.StandardController(testSPEKPIDefinition);
        SPE2_AddLanguageKPIExt controller = new SPE2_AddLanguageKPIExt(sc);
        controller.inputLanguage ='German';
        controller.showNext();
        controller.SaveChanges();
       controller.getLanguageValues();
       
        
   }   

    public static testmethod void SPE2_AddLanguageKPIExtTest2 () {
        SPE_KPIDefinition__c testSPEKPIDefinition1 = new SPE_KPIDefinition__c ();
        testSPEKPIDefinition1.KPI_Title__c='Test KPI';
        testSPEKPIDefinition1.ScheduledDate__c =  Date.Today().addDays(1);
        testSPEKPIDefinition1.FrequencyinMonth__c = '2';
        Insert testSPEKPIDefinition1;
    SPE2_Language_KPI__c  testSPE2LanguageKPI = new SPE2_Language_KPI__c ();
        testSPE2LanguageKPI.Language__c='German';
        testSPE2LanguageKPI.Language_Version__c= 'Test German';
        testSPE2LanguageKPI.KPI__c = testSPEKPIDefinition1.id;  
        testSPE2LanguageKPI.English_Version__c = testSPEKPIDefinition1.KPI_Title__c;
        insert testSPE2LanguageKPI;
    ApexPages.StandardController sc = new ApexPages.StandardController(testSPEKPIDefinition1);
        SPE2_AddLanguageKPIExt controller = new SPE2_AddLanguageKPIExt(sc);
        controller.inputLanguage ='German';
        controller.showNext();
        controller.SaveChanges();
         controller.getLanguageValues();
        
   }
}