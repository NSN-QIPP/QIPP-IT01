@isTest(seeAllData = false)
private class SPE2_kpiIntermediateComputeTest 
{
   static testMethod void kpiIntermediateComputeTest1() 
    {
      
        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'library', Email='libraryuser@testorg.com', 
                           EmailEncodingKey='UTF-8', LastName='Test', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles', UserName='testinguser@testinguser.com.spe2');
        insert u; 
        System.runAs(u){ 
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Market__c = 'All Markets';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Project__c = 'All Projects';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Product__c = 'All Products';   
        picklistObj.Name = 'Picklist Default Values';
    
        lstpicklistObj.add(picklistObj);        
        insert lstpicklistObj;        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
            
        Account a = new Account();
        a.Name = 'COSCOM';
        a.enterpriseId__c='COSCOM';
        insert a;
        system.debug('account ::'+a);

        SPE_PIDefinition__c pidef = SPE_TestObjectCreator.CreatePIDefinition();
        piDef.ValuesType__c = 'Number';
        pidef.PIUploadDuedate__c = Date.newInstance(2016,6,24);       
        insert pidef;
        
        pidef.LifecycleStage__c = 'Pilot';
        update pidef;
        System.debug('pidef ::'+pidef);
        
        SPE_PIValues__c piVal = SPE_TestObjectCreator.CreatePIValues(pidef.id,a.id,a.enterpriseId__c);
        piVal.PIDefination__c =pidef.id;
        piVal.EnterpriseID__c = 'COSCOM';
        piVal.Period__c = Date.newInstance(2016,6,14);
        piVal.StringValue__c ='';
        piVal.NumberValue__c =10;
        piVal.DateValue__c = NULL;
        insert piVal;
        System.debug('piVal::'+piVal);
        
        SPE_KPIDefinition__c masterkpi = new SPE_KPIDefinition__c();
        masterkpi = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert masterKpi;
        
        List<SPE_KPIDefinition__c> kpiList= new List<SPE_KPIDefinition__c >();
        for(integer i=0;i<1;i++){
            SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(i);
            kpiDefinition1.Master_KPI__c = masterKpi.id;
            kpiDefinition1.LifecycleStage__c ='Pilot';            
            kpiList.add(kpiDefinition1);
        }
        insert kpiList[0];

        SPE_KPICalculation__c kpiCal = SPE_TestObjectCreator.createKPICalculation();
        kpiCal.Aggregation__c = 'Max';
        kpiCal.pidefination__c=pidef.id;
        kpical.KPIDefinition__c =kpiList[0].id;
        kpical.Index__c ='A';
        insert kpiCal;
        system.debug('kpiCal::'+kpiCal); 
             
        KPI_Calculation_Formula__c kpiform = new KPI_Calculation_Formula__c();
        kpiform.Name = 'Condition 1';
        kpiform.KPI__c =kpiList[0].id;
        kpiform.KPI_Expression__c = 'A';
        kpiform.KPI_Formula__c = 'A';
        insert kpiform;
 
        KPI_Calulation_Condition__c kpicondtn =new KPI_Calulation_Condition__c();
        kpicondtn.Name ='A';
        kpicondtn.Formula__c =kpiform.id;
        kpicondtn.Operator__c = '>';
        kpicondtn.Value__c = 0;                     
        insert kpicondtn;
    
        system.debug('kpicondtn ::'+kpicondtn);
        
        string idStr =a.id;
        id idVal=idStr;
        idStr =idVal;
        system.debug('18char::'+idstr);
        
        String identifierparam = System.Now()+';'+UserInfo.getuserID();       

        SPE_PITempValue__c tempval = SPE_TestObjectCreator.createPITempValue();
        tempval.PIValue__c = String.Valueof(10);
        tempval.enterpriseId__c='COSCOM';
        tempval.ValueType__c = 'Number';
        tempval.ExecutionPeriod__c ='June - 2016';
        tempval.EnterpriseIDEncrypted__c =idstr;
        tempval.KPICalculation__c=kpiCal.id;
        tempval.KPIDefinition__c=kpiList[0].id;
        tempval.isconstant__c=false;
        tempval.Region__c ='All Markets';
        tempval.SubRegion__c = 'All Market Units';
        tempval.Country__c= 'All Countries';
        tempval.Project__c= 'All Projects';
        tempval.Cluster__c ='All Category Areas';
        tempval.CategoryGroup__c = 'All Category Groups';
        tempval.Category__c= 'All Categories';
        tempval.BusinessUnit__c= 'All Business Units';
        tempval.BusinessLine__c= 'All Business Lines';
        tempval.Product__c= 'All Products';   
        insert tempval;
        System.debug('tempval::'+tempval);
        list<SPE_PITempValue__c> tempvalist = [Select id,Region__c,SubRegion__c,Country__c,
                                               EnterpriseIDEncrypted__c,Project__c,Cluster__c,
                                               CategoryGroup__c,Category__c,
                                               BusinessUnit__c,BusinessLine__c,Product__c,
                                               MappingScope__c from SPE_PITempValue__c Where id =:tempval.id];
        System.debug('tempvalist::'+tempvalist);
                        
      /*  for(SPE_KPIDefinition__c kp :kpiList){
            kp.LifecycleStage__c ='Pilot';            
            kp.ScheduledDate__c = kp.ScheduledDate__c.addDays(1);            
        }
        update kpilist;*/
        string mapscope =tempval.Mappingscope__c;
        system.debug('mapscope::'+mapscope );
        List<KPI_IntermediateComputation__c> lstkpiInterComp = new List<KPI_IntermediateComputation__c>();
        for(SPE_PITempValue__c pitemp :tempvalist){
            KPI_IntermediateComputation__c kpiInterComp = new KPI_IntermediateComputation__c();
            kpiInterComp.IdentifierParam__c = identifierparam ;
            kpiInterComp.KPI__c =kpiList[0].ID;
            kpiInterComp.KPI_MappingScope__c  = pitemp.Mappingscope__c;
            lstkpiInterComp.add(kpiInterComp);
        }
        insert lstkpiInterComp;
        system.debug('lstkpiInterComp::'+lstkpiInterComp);
        //List<KPI_IntermediateComputation__c> lstkpiInterComp = new List<KPI_IntermediateComputation__c>();
        KPI_IntermediateComputation__c kpiInterComp = new KPI_IntermediateComputation__c();
        kpiInterComp.IdentifierParam__c = identifierparam ;
        kpiInterComp.KPI__c =kpiList[0].ID;
        kpiInterComp.KPI_MappingScope__c  = tempval.Mappingscope__c;
        
        /*kpiInterComp.KPI_Mappingscope__c = '';//lstAcc[0].Id +';All Business Lines;All Business Units;All Categories;All Category Groups;All Category Areas;All Countries;All Markets;All Market Units;All Projects;All Products;June - 2020'; 
        //lstAcc[0].Id +';All Business Lines;All Business Units;All Categories;All Category Groups;All Category Areas;All Countries;All Markets;All Market Units;All Projects;All Products;June - 2020';
        kpiInterComp.KPI__c = kpiDefinition2.Id;*/
        
        insert kpiInterComp;        
       // lstkpiInterComp.add(kpiInterComp);
        
        system.debug('kpiInterComp ::'+kpiInterComp);
        
        System.debug('kpiInterComp.KPI_Mappingscope__c'+kpiInterComp.KPI_Mappingscope__c);
        
        
        System.debug('value each'+ tempval.EnterpriseIDEncrypted__c + ';' + tempval.BusinessLine__c + ';' + tempval.BusinessUnit__c + ';' + tempval.Category__c + ';' + tempval.CategoryGroup__c + ';'+ tempval.Cluster__c + ';' + tempval.Country__c + ';' + tempval.Region__c+ ';' + tempval.SubRegion__c+ ';' + tempval.Project__c + ';' + tempval.Product__c + ';'+ tempval.ExecutionPeriod__c);
        System.debug('tempval.Mappingscope__c '+tempval.Mappingscope__c );
      
        
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiList[0].Id;
        kpiValue.IdentifierParam__c = identifierparam ;
        kpiValue.KPIValue__c = 10;
        kpiValue.EnterpriseId__c=a.id;
        kpiValue.ExecutionPeriod__c='June - 2016';
        insert kpiValue;
        System.debug('kpiValue::'+kpiValue); 
        
        

        SPE_KPIComments__c kpicomment = new SPE_KPIComments__c();
        kpicomment.KPI__c = kpiList[0].id;
        kpicomment.PIData__c =pidef.id;
        kpicomment.SurveyComments__c = 'test comments';
        kpicomment.EnterpriseId__c = a.id;
        insert kpicomment;
        system.debug('kpicomment ::'+kpicomment);       
       
        
        
        Map<Id, Map<String, String>> kpiEnterpriseComMap = new Map<Id, Map<String, String>>();
        Map<String, String> enterpriseCommentsMap = new Map<String, String>();
        String surveyComments = '';
        if (kpicomment.EnterpriseId__c != null)
        {
          surveyComments = kpicomment.EnterpriseId__c;
        }
        
        surveyComments = surveyComments == ''?  kpicomment.SurveyComments__c : surveyComments + ' | ' + kpicomment.SurveyComments__c;
        enterpriseCommentsMap.put(''+kpicomment.EnterpriseId__c, surveyComments);
        kpiEnterpriseComMap.put(kpicomment.KPI__c, +enterpriseCommentsMap);
        
        string kpidefId = kpiList[0].id;
        Id kpidef =kpidefId;
        kpidefId =kpidef;
        string Idenf = kpiValue.IdentifierParam__c; 
        Test.startTest();
        SPE2_kpiIntermediateCompute obj = new SPE2_kpiIntermediateCompute(identifierparam, kpidefId, kpiEnterpriseComMap);
        Database.executeBatch(obj);
        }
        Test.stopTest();   
        
   }
   static testMethod void kpiIntermediateComputeTest2() 
    {
      
        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'library', Email='libraryuser@testorg.com', 
                           EmailEncodingKey='UTF-8', LastName='Test', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles', UserName='testinguser@testinguser.com.spe2');
        insert u; 
        System.runAs(u){ 
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Market__c = 'All Markets';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Project__c = 'All Projects';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Product__c = 'All Products';   
        picklistObj.Name = 'Picklist Default Values';
    
        lstpicklistObj.add(picklistObj);        
        insert lstpicklistObj;        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
            
        Account a = new Account();
        a.Name = 'COSCOM';
        a.enterpriseId__c='COSCOM';
        insert a;
        system.debug('account ::'+a);

        SPE_PIDefinition__c pidef = SPE_TestObjectCreator.CreatePIDefinition();
        piDef.ValuesType__c = 'Date';
        pidef.PIUploadDuedate__c = Date.newInstance(2016,6,24);       
        insert pidef;
        
        pidef.LifecycleStage__c = 'Pilot';
        update pidef;
        System.debug('pidef ::'+pidef);
        
        SPE_PIValues__c piVal = SPE_TestObjectCreator.CreatePIValues(pidef.id,a.id,a.enterpriseId__c);
        piVal.PIDefination__c =pidef.id;
        piVal.EnterpriseID__c = 'COSCOM';
        piVal.Period__c = Date.newInstance(2016,6,14);
        piVal.StringValue__c ='';
        piVal.NumberValue__c =NULL;
        piVal.DateValue__c = Date.newInstance(2016,6,14);
        insert piVal;
        System.debug('piVal::'+piVal);
        
        SPE_KPIDefinition__c masterkpi = new SPE_KPIDefinition__c();
        masterkpi = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert masterKpi;
        
        List<SPE_KPIDefinition__c> kpiList= new List<SPE_KPIDefinition__c >();
        for(integer i=0;i<1;i++){
            SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(i);
            kpiDefinition1.Master_KPI__c = masterKpi.id;
            kpiDefinition1.LifecycleStage__c ='Pilot';            
            kpiList.add(kpiDefinition1);
        }
        insert kpiList[0];

        SPE_KPICalculation__c kpiCal = SPE_TestObjectCreator.createKPICalculation();
        kpiCal.Aggregation__c = 'Max';
        kpiCal.pidefination__c=pidef.id;
        kpical.KPIDefinition__c =kpiList[0].id;
        kpical.Index__c ='A';
        insert kpiCal;
        system.debug('kpiCal::'+kpiCal); 
             
        KPI_Calculation_Formula__c kpiform = new KPI_Calculation_Formula__c();
        kpiform.Name = 'Condition 1';
        kpiform.KPI__c =kpiList[0].id;
        kpiform.KPI_Expression__c = 'A';
        kpiform.KPI_Formula__c = 'A';
        insert kpiform;
        
        KPI_Calulation_Condition__c kpicondtn =new KPI_Calulation_Condition__c();
        kpicondtn.Name ='A';
        kpicondtn.Formula__c =kpiform.id;
        kpicondtn.Operator__c = '>';
        kpicondtn.Value__c = 0;                     
        insert kpicondtn;
    
        system.debug('kpicondtn ::'+kpicondtn);
        
        KPI_Calulation_Condition__c kpicondtn1 =new KPI_Calulation_Condition__c();
        kpicondtn1.Name ='A';
        kpicondtn1.Formula__c =kpiform.id;
        kpicondtn1.Operator__c = '<';
        kpicondtn1.Value__c = 0;                     
        insert kpicondtn1;
        
        string idStr =a.id;
        id idVal=idStr;
        idStr =idVal;
        system.debug('18char::'+idstr);
        
        String identifierparam = System.Now()+';'+UserInfo.getuserID();       

        SPE_PITempValue__c tempval = SPE_TestObjectCreator.createPITempValue();
        tempval.PIValue__c = String.Valueof(Date.newInstance(2016,6,14));
        tempval.enterpriseId__c='COSCOM';
        tempval.ValueType__c = 'Date';
        tempval.ExecutionPeriod__c ='June - 2016';
        tempval.EnterpriseIDEncrypted__c =idstr;
        tempval.KPICalculation__c=kpiCal.id;
        tempval.KPIDefinition__c=kpiList[0].id;
        tempval.isconstant__c=false;
        tempval.Region__c ='All Markets';
        tempval.SubRegion__c = 'All Market Units';
        tempval.Country__c= 'All Countries';
        tempval.Project__c= 'All Projects';
        tempval.Cluster__c ='All Category Areas';
        tempval.CategoryGroup__c = 'All Category Groups';
        tempval.Category__c= 'All Categories';
        tempval.BusinessUnit__c= 'All Business Units';
        tempval.BusinessLine__c= 'All Business Lines';
        tempval.Product__c= 'All Products';   
        insert tempval;
        System.debug('tempval::'+tempval);
        list<SPE_PITempValue__c> tempvalist = [Select id,Region__c,SubRegion__c,Country__c,
                                               EnterpriseIDEncrypted__c,Project__c,Cluster__c,
                                               CategoryGroup__c,Category__c,
                                               BusinessUnit__c,BusinessLine__c,Product__c,
                                               MappingScope__c from SPE_PITempValue__c Where id =:tempval.id];
        System.debug('tempvalist::'+tempvalist);
                        
      /*  for(SPE_KPIDefinition__c kp :kpiList){
            kp.LifecycleStage__c ='Pilot';            
            kp.ScheduledDate__c = kp.ScheduledDate__c.addDays(1);            
        }
        update kpilist;*/
        string mapscope =tempval.Mappingscope__c;
        system.debug('mapscope::'+mapscope );
        List<KPI_IntermediateComputation__c> lstkpiInterComp = new List<KPI_IntermediateComputation__c>();
        for(SPE_PITempValue__c pitemp :tempvalist){
            KPI_IntermediateComputation__c kpiInterComp = new KPI_IntermediateComputation__c();
            kpiInterComp.IdentifierParam__c = identifierparam ;
            kpiInterComp.KPI__c =kpiList[0].ID;
            kpiInterComp.KPI_MappingScope__c  = pitemp.Mappingscope__c;
            lstkpiInterComp.add(kpiInterComp);
        }
        insert lstkpiInterComp;
        system.debug('lstkpiInterComp::'+lstkpiInterComp);
        //List<KPI_IntermediateComputation__c> lstkpiInterComp = new List<KPI_IntermediateComputation__c>();
        KPI_IntermediateComputation__c kpiInterComp = new KPI_IntermediateComputation__c();
        kpiInterComp.IdentifierParam__c = identifierparam ;
        kpiInterComp.KPI__c =kpiList[0].ID;
        kpiInterComp.KPI_MappingScope__c  = tempval.Mappingscope__c;
        
        /*kpiInterComp.KPI_Mappingscope__c = '';//lstAcc[0].Id +';All Business Lines;All Business Units;All Categories;All Category Groups;All Category Areas;All Countries;All Markets;All Market Units;All Projects;All Products;June - 2020'; 
        //lstAcc[0].Id +';All Business Lines;All Business Units;All Categories;All Category Groups;All Category Areas;All Countries;All Markets;All Market Units;All Projects;All Products;June - 2020';
        kpiInterComp.KPI__c = kpiDefinition2.Id;*/
        
        insert kpiInterComp;        
       // lstkpiInterComp.add(kpiInterComp);
        
        system.debug('kpiInterComp ::'+kpiInterComp);
        
        System.debug('kpiInterComp.KPI_Mappingscope__c'+kpiInterComp.KPI_Mappingscope__c);
        
        
        System.debug('value each'+ tempval.EnterpriseIDEncrypted__c + ';' + tempval.BusinessLine__c + ';' + tempval.BusinessUnit__c + ';' + tempval.Category__c + ';' + tempval.CategoryGroup__c + ';'+ tempval.Cluster__c + ';' + tempval.Country__c + ';' + tempval.Region__c+ ';' + tempval.SubRegion__c+ ';' + tempval.Project__c + ';' + tempval.Product__c + ';'+ tempval.ExecutionPeriod__c);
        System.debug('tempval.Mappingscope__c '+tempval.Mappingscope__c );
      
        
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiList[0].Id;
        kpiValue.IdentifierParam__c = identifierparam ;
        kpiValue.KPIValue__c = NULL;
        kpiValue.EnterpriseId__c=a.id;
        kpiValue.ExecutionPeriod__c='June - 2016';
        insert kpiValue;
        System.debug('kpiValue::'+kpiValue); 
        
        

        SPE_KPIComments__c kpicomment = new SPE_KPIComments__c();
        kpicomment.KPI__c = kpiList[0].id;
        kpicomment.PIData__c =pidef.id;
        kpicomment.SurveyComments__c = 'test comments';
        kpicomment.EnterpriseId__c = a.id;
        insert kpicomment;
        system.debug('kpicomment ::'+kpicomment);       
       
        
        
        Map<Id, Map<String, String>> kpiEnterpriseComMap = new Map<Id, Map<String, String>>();
        Map<String, String> enterpriseCommentsMap = new Map<String, String>();
        String surveyComments = '';
        if (kpicomment.EnterpriseId__c != null)
        {
          surveyComments = kpicomment.EnterpriseId__c;
        }
        
        surveyComments = surveyComments == ''?  kpicomment.SurveyComments__c : surveyComments + ' | ' + kpicomment.SurveyComments__c;
        enterpriseCommentsMap.put(''+kpicomment.EnterpriseId__c, surveyComments);
        kpiEnterpriseComMap.put(kpicomment.KPI__c, +enterpriseCommentsMap);
        
        string kpidefId = kpiList[0].id;
        Id kpidef =kpidefId;
        kpidefId =kpidef;
       // string Idenf = kpiValue.IdentifierParam__c; 
        Test.startTest();
        SPE2_kpiIntermediateCompute obj = new SPE2_kpiIntermediateCompute(identifierparam, kpidefId, kpiEnterpriseComMap);
        Database.executeBatch(obj);
        }
        Test.stopTest();   
        
   }
   static testMethod void kpiIntermediateComputeTest3() 
    {
      
        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'library', Email='libraryuser@testorg.com', 
                           EmailEncodingKey='UTF-8', LastName='Test', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles', UserName='testinguser@testinguser.com.spe2');
        insert u; 
        System.runAs(u){ 
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Market__c = 'All Markets';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Project__c = 'All Projects';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Product__c = 'All Products';   
        picklistObj.Name = 'Picklist Default Values';
    
        lstpicklistObj.add(picklistObj);        
        insert lstpicklistObj;        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
            
        Account a = new Account();
        a.Name = 'COSCOM';
        a.enterpriseId__c='COSCOM';
        insert a;
        system.debug('account ::'+a);

        SPE_PIDefinition__c pidef = SPE_TestObjectCreator.CreatePIDefinition();
        piDef.ValuesType__c = 'Number';
        pidef.PIUploadDuedate__c = Date.newInstance(2016,6,24);       
        insert pidef;
        
        pidef.LifecycleStage__c = 'Pilot';
        update pidef;
        System.debug('pidef ::'+pidef);
        
        SPE_PIValues__c piVal = SPE_TestObjectCreator.CreatePIValues(pidef.id,a.id,a.enterpriseId__c);
        piVal.PIDefination__c =pidef.id;
        piVal.EnterpriseID__c = 'COSCOM';
        piVal.Period__c = Date.newInstance(2016,6,14);
        piVal.StringValue__c ='';
        piVal.NumberValue__c =10;
        piVal.DateValue__c = NULL;
        insert piVal;
        System.debug('piVal::'+piVal);
        
        SPE_KPIDefinition__c masterkpi = new SPE_KPIDefinition__c();
        masterkpi = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert masterKpi;
        
        List<SPE_KPIDefinition__c> kpiList= new List<SPE_KPIDefinition__c >();
        for(integer i=0;i<1;i++){
            SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(i);
            kpiDefinition1.Master_KPI__c = masterKpi.id;
            kpiDefinition1.LifecycleStage__c ='Pilot';            
            kpiList.add(kpiDefinition1);
        }
        insert kpiList[0];

        SPE_KPICalculation__c kpiCal = SPE_TestObjectCreator.createKPICalculation();
        kpiCal.Aggregation__c = 'Max';
        kpiCal.pidefination__c=pidef.id;
        kpical.KPIDefinition__c =kpiList[0].id;
        kpical.Index__c ='A';
        insert kpiCal;
        system.debug('kpiCal::'+kpiCal); 
             
        KPI_Calculation_Formula__c kpiform = new KPI_Calculation_Formula__c();
        kpiform.Name = 'Condition 1';
        kpiform.KPI__c =kpiList[0].id;
        kpiform.KPI_Expression__c = 'A';
        kpiform.KPI_Formula__c = 'A';
        insert kpiform;
        
        KPI_Calulation_Condition__c kpicondtn1 =new KPI_Calulation_Condition__c();
        kpicondtn1.Name ='A';
        kpicondtn1.Formula__c =kpiform.id;
        kpicondtn1.Operator__c = '<';
        kpicondtn1.Value__c = 0;                     
        insert kpicondtn1;
        
        string idStr =a.id;
        id idVal=idStr;
        idStr =idVal;
        system.debug('18char::'+idstr);
        
        String identifierparam = System.Now()+';'+UserInfo.getuserID();       

        SPE_PITempValue__c tempval = SPE_TestObjectCreator.createPITempValue();
        tempval.PIValue__c = String.Valueof(10);
        tempval.enterpriseId__c='COSCOM';
        tempval.ValueType__c = 'Number';
        tempval.ExecutionPeriod__c ='June - 2016';
        tempval.EnterpriseIDEncrypted__c =idstr;
        tempval.KPICalculation__c=kpiCal.id;
        tempval.KPIDefinition__c=kpiList[0].id;
        tempval.isconstant__c=false;
        tempval.Region__c ='All Markets';
        tempval.SubRegion__c = 'All Market Units';
        tempval.Country__c= 'All Countries';
        tempval.Project__c= 'All Projects';
        tempval.Cluster__c ='All Category Areas';
        tempval.CategoryGroup__c = 'All Category Groups';
        tempval.Category__c= 'All Categories';
        tempval.BusinessUnit__c= 'All Business Units';
        tempval.BusinessLine__c= 'All Business Lines';
        tempval.Product__c= 'All Products';   
        insert tempval;
        System.debug('tempval::'+tempval);
        list<SPE_PITempValue__c> tempvalist = [Select id,Region__c,SubRegion__c,Country__c,
                                               EnterpriseIDEncrypted__c,Project__c,Cluster__c,
                                               CategoryGroup__c,Category__c,
                                               BusinessUnit__c,BusinessLine__c,Product__c,
                                               MappingScope__c from SPE_PITempValue__c Where id =:tempval.id];
        System.debug('tempvalist::'+tempvalist);
                        
      /*  for(SPE_KPIDefinition__c kp :kpiList){
            kp.LifecycleStage__c ='Pilot';            
            kp.ScheduledDate__c = kp.ScheduledDate__c.addDays(1);            
        }
        update kpilist;*/
        string mapscope =tempval.Mappingscope__c;
        system.debug('mapscope::'+mapscope );
        List<KPI_IntermediateComputation__c> lstkpiInterComp = new List<KPI_IntermediateComputation__c>();
        for(SPE_PITempValue__c pitemp :tempvalist){
            KPI_IntermediateComputation__c kpiInterComp = new KPI_IntermediateComputation__c();
            kpiInterComp.IdentifierParam__c = identifierparam ;
            kpiInterComp.KPI__c =kpiList[0].ID;
            kpiInterComp.KPI_MappingScope__c  = pitemp.Mappingscope__c;
            lstkpiInterComp.add(kpiInterComp);
        }
        insert lstkpiInterComp;
        system.debug('lstkpiInterComp::'+lstkpiInterComp);
        //List<KPI_IntermediateComputation__c> lstkpiInterComp = new List<KPI_IntermediateComputation__c>();
        KPI_IntermediateComputation__c kpiInterComp = new KPI_IntermediateComputation__c();
        kpiInterComp.IdentifierParam__c = identifierparam ;
        kpiInterComp.KPI__c =kpiList[0].ID;
        kpiInterComp.KPI_MappingScope__c  = tempval.Mappingscope__c;
        
        /*kpiInterComp.KPI_Mappingscope__c = '';//lstAcc[0].Id +';All Business Lines;All Business Units;All Categories;All Category Groups;All Category Areas;All Countries;All Markets;All Market Units;All Projects;All Products;June - 2020'; 
        //lstAcc[0].Id +';All Business Lines;All Business Units;All Categories;All Category Groups;All Category Areas;All Countries;All Markets;All Market Units;All Projects;All Products;June - 2020';
        kpiInterComp.KPI__c = kpiDefinition2.Id;*/
        
        insert kpiInterComp;        
       // lstkpiInterComp.add(kpiInterComp);
        
        system.debug('kpiInterComp ::'+kpiInterComp);
        
        System.debug('kpiInterComp.KPI_Mappingscope__c'+kpiInterComp.KPI_Mappingscope__c);
        
        
        System.debug('value each'+ tempval.EnterpriseIDEncrypted__c + ';' + tempval.BusinessLine__c + ';' + tempval.BusinessUnit__c + ';' + tempval.Category__c + ';' + tempval.CategoryGroup__c + ';'+ tempval.Cluster__c + ';' + tempval.Country__c + ';' + tempval.Region__c+ ';' + tempval.SubRegion__c+ ';' + tempval.Project__c + ';' + tempval.Product__c + ';'+ tempval.ExecutionPeriod__c);
        System.debug('tempval.Mappingscope__c '+tempval.Mappingscope__c );
      
        
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiList[0].Id;
        kpiValue.IdentifierParam__c = identifierparam ;
        kpiValue.KPIValue__c = 10;
        kpiValue.EnterpriseId__c=a.id;
        kpiValue.ExecutionPeriod__c='June - 2016';
        insert kpiValue;
        System.debug('kpiValue::'+kpiValue); 
        
        

        SPE_KPIComments__c kpicomment = new SPE_KPIComments__c();
        kpicomment.KPI__c = kpiList[0].id;
        kpicomment.PIData__c =pidef.id;
        kpicomment.SurveyComments__c = 'test comments';
        kpicomment.EnterpriseId__c = a.id;
        insert kpicomment;
        system.debug('kpicomment ::'+kpicomment);       
       
        
        
        Map<Id, Map<String, String>> kpiEnterpriseComMap = new Map<Id, Map<String, String>>();
        Map<String, String> enterpriseCommentsMap = new Map<String, String>();
        String surveyComments = '';
        if (kpicomment.EnterpriseId__c != null)
        {
          surveyComments = kpicomment.EnterpriseId__c;
        }
        
        surveyComments = surveyComments == ''?  kpicomment.SurveyComments__c : surveyComments + ' | ' + kpicomment.SurveyComments__c;
        enterpriseCommentsMap.put(''+kpicomment.EnterpriseId__c, surveyComments);
        kpiEnterpriseComMap.put(kpicomment.KPI__c, +enterpriseCommentsMap);
        
        string kpidefId = kpiList[0].id;
        Id kpidef =kpidefId;
        kpidefId =kpidef;
        string Idenf = kpiValue.IdentifierParam__c; 
        Test.startTest();
        SPE2_kpiIntermediateCompute obj = new SPE2_kpiIntermediateCompute(identifierparam, kpidefId, kpiEnterpriseComMap);
        Database.executeBatch(obj);
        }
        Test.stopTest();   
        
   }
   static testMethod void kpiIntermediateComputeTest4() 
    {
      
        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'library', Email='libraryuser@testorg.com', 
                           EmailEncodingKey='UTF-8', LastName='Test', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles', UserName='testinguser@testinguser.com.spe2');
        insert u; 
        System.runAs(u){ 
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Market__c = 'All Markets';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Country__c = 'All Countries';
        picklistObj.Project__c = 'All Projects';
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Business_Line__c = 'All Business Lines';
        picklistObj.Product__c = 'All Products';   
        picklistObj.Name = 'Picklist Default Values';
    
        lstpicklistObj.add(picklistObj);        
        insert lstpicklistObj;        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
            
        Account a = new Account();
        a.Name = 'COSCOM';
        a.enterpriseId__c='COSCOM';
        insert a;
        system.debug('account ::'+a);

        SPE_PIDefinition__c pidef = SPE_TestObjectCreator.CreatePIDefinition();
        piDef.ValuesType__c = 'Date';
        pidef.PIUploadDuedate__c = Date.newInstance(2016,6,24);       
        insert pidef;
        
        pidef.LifecycleStage__c = 'Pilot';
        update pidef;
        System.debug('pidef ::'+pidef);
        
        SPE_PIValues__c piVal = SPE_TestObjectCreator.CreatePIValues(pidef.id,a.id,a.enterpriseId__c);
        piVal.PIDefination__c =pidef.id;
        piVal.EnterpriseID__c = 'COSCOM';
        piVal.Period__c = Date.newInstance(2016,6,14);
        piVal.StringValue__c ='';
        piVal.NumberValue__c =NULL;
        piVal.DateValue__c = Date.newInstance(2016,6,14);
        insert piVal;
        System.debug('piVal::'+piVal);
        
        SPE_KPIDefinition__c masterkpi = new SPE_KPIDefinition__c();
        masterkpi = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert masterKpi;
        
        List<SPE_KPIDefinition__c> kpiList= new List<SPE_KPIDefinition__c >();
        for(integer i=0;i<1;i++){
            SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(i);
            kpiDefinition1.Master_KPI__c = masterKpi.id;
            kpiDefinition1.LifecycleStage__c ='Pilot';            
            kpiList.add(kpiDefinition1);
        }
        insert kpiList[0];

        SPE_KPICalculation__c kpiCal = SPE_TestObjectCreator.createKPICalculation();
        kpiCal.Aggregation__c = 'Max';
        kpiCal.pidefination__c=pidef.id;
        kpical.KPIDefinition__c =kpiList[0].id;
        kpical.Index__c ='A';
        insert kpiCal;
        system.debug('kpiCal::'+kpiCal); 
             
        KPI_Calculation_Formula__c kpiform = new KPI_Calculation_Formula__c();
        kpiform.Name = 'Condition 1';
        kpiform.KPI__c =kpiList[0].id;
        kpiform.KPI_Expression__c = 'A';
        kpiform.KPI_Formula__c = 'A';
        insert kpiform;
        
        KPI_Calulation_Condition__c kpicondtn =new KPI_Calulation_Condition__c();
        kpicondtn.Name ='A';
        kpicondtn.Formula__c =kpiform.id;
        kpicondtn.Operator__c = '<';
        kpicondtn.Value__c = 0;                     
        insert kpicondtn;
    
        system.debug('kpicondtn ::'+kpicondtn);
        
        string idStr =a.id;
        id idVal=idStr;
        idStr =idVal;
        system.debug('18char::'+idstr);
        
        String identifierparam = System.Now()+';'+UserInfo.getuserID();       

        SPE_PITempValue__c tempval = SPE_TestObjectCreator.createPITempValue();
        tempval.PIValue__c = String.Valueof(Date.newInstance(2016,6,14));
        tempval.enterpriseId__c='COSCOM';
        tempval.ValueType__c = 'Date';
        tempval.ExecutionPeriod__c ='June - 2016';
        tempval.EnterpriseIDEncrypted__c =idstr;
        tempval.KPICalculation__c=kpiCal.id;
        tempval.KPIDefinition__c=kpiList[0].id;
        tempval.isconstant__c=false;
        tempval.Region__c ='All Markets';
        tempval.SubRegion__c = 'All Market Units';
        tempval.Country__c= 'All Countries';
        tempval.Project__c= 'All Projects';
        tempval.Cluster__c ='All Category Areas';
        tempval.CategoryGroup__c = 'All Category Groups';
        tempval.Category__c= 'All Categories';
        tempval.BusinessUnit__c= 'All Business Units';
        tempval.BusinessLine__c= 'All Business Lines';
        tempval.Product__c= 'All Products';   
        insert tempval;
        System.debug('tempval::'+tempval);
        list<SPE_PITempValue__c> tempvalist = [Select id,Region__c,SubRegion__c,Country__c,
                                               EnterpriseIDEncrypted__c,Project__c,Cluster__c,
                                               CategoryGroup__c,Category__c,
                                               BusinessUnit__c,BusinessLine__c,Product__c,
                                               MappingScope__c from SPE_PITempValue__c Where id =:tempval.id];
        System.debug('tempvalist::'+tempvalist);
                        
      /*  for(SPE_KPIDefinition__c kp :kpiList){
            kp.LifecycleStage__c ='Pilot';            
            kp.ScheduledDate__c = kp.ScheduledDate__c.addDays(1);            
        }
        update kpilist;*/
        string mapscope =tempval.Mappingscope__c;
        system.debug('mapscope::'+mapscope );
        List<KPI_IntermediateComputation__c> lstkpiInterComp = new List<KPI_IntermediateComputation__c>();
        for(SPE_PITempValue__c pitemp :tempvalist){
            KPI_IntermediateComputation__c kpiInterComp = new KPI_IntermediateComputation__c();
            kpiInterComp.IdentifierParam__c = identifierparam ;
            kpiInterComp.KPI__c =kpiList[0].ID;
            kpiInterComp.KPI_MappingScope__c  = pitemp.Mappingscope__c;
            lstkpiInterComp.add(kpiInterComp);
        }
        insert lstkpiInterComp;
        system.debug('lstkpiInterComp::'+lstkpiInterComp);
        //List<KPI_IntermediateComputation__c> lstkpiInterComp = new List<KPI_IntermediateComputation__c>();
        KPI_IntermediateComputation__c kpiInterComp = new KPI_IntermediateComputation__c();
        kpiInterComp.IdentifierParam__c = identifierparam ;
        kpiInterComp.KPI__c =kpiList[0].ID;
        kpiInterComp.KPI_MappingScope__c  = tempval.Mappingscope__c;
        
        /*kpiInterComp.KPI_Mappingscope__c = '';//lstAcc[0].Id +';All Business Lines;All Business Units;All Categories;All Category Groups;All Category Areas;All Countries;All Markets;All Market Units;All Projects;All Products;June - 2020'; 
        //lstAcc[0].Id +';All Business Lines;All Business Units;All Categories;All Category Groups;All Category Areas;All Countries;All Markets;All Market Units;All Projects;All Products;June - 2020';
        kpiInterComp.KPI__c = kpiDefinition2.Id;*/
        
        insert kpiInterComp;        
       // lstkpiInterComp.add(kpiInterComp);
        
        system.debug('kpiInterComp ::'+kpiInterComp);
        
        System.debug('kpiInterComp.KPI_Mappingscope__c'+kpiInterComp.KPI_Mappingscope__c);
        
        
        System.debug('value each'+ tempval.EnterpriseIDEncrypted__c + ';' + tempval.BusinessLine__c + ';' + tempval.BusinessUnit__c + ';' + tempval.Category__c + ';' + tempval.CategoryGroup__c + ';'+ tempval.Cluster__c + ';' + tempval.Country__c + ';' + tempval.Region__c+ ';' + tempval.SubRegion__c+ ';' + tempval.Project__c + ';' + tempval.Product__c + ';'+ tempval.ExecutionPeriod__c);
        System.debug('tempval.Mappingscope__c '+tempval.Mappingscope__c );
      
        
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiList[0].Id;
        kpiValue.IdentifierParam__c = identifierparam ;
        kpiValue.KPIValue__c = NULL;
        kpiValue.EnterpriseId__c=a.id;
        kpiValue.ExecutionPeriod__c='June - 2016';
        insert kpiValue;
        System.debug('kpiValue::'+kpiValue); 
        
        

        SPE_KPIComments__c kpicomment = new SPE_KPIComments__c();
        kpicomment.KPI__c = kpiList[0].id;
        kpicomment.PIData__c =pidef.id;
        kpicomment.SurveyComments__c = 'test comments';
        kpicomment.EnterpriseId__c = a.id;
        insert kpicomment;
        system.debug('kpicomment ::'+kpicomment);       
       
        
        
        Map<Id, Map<String, String>> kpiEnterpriseComMap = new Map<Id, Map<String, String>>();
        Map<String, String> enterpriseCommentsMap = new Map<String, String>();
        String surveyComments = '';
        if (kpicomment.EnterpriseId__c != null)
        {
          surveyComments = kpicomment.EnterpriseId__c;
        }
        
        surveyComments = surveyComments == ''?  kpicomment.SurveyComments__c : surveyComments + ' | ' + kpicomment.SurveyComments__c;
        enterpriseCommentsMap.put(''+kpicomment.EnterpriseId__c, surveyComments);
        kpiEnterpriseComMap.put(kpicomment.KPI__c, +enterpriseCommentsMap);
        
        string kpidefId = kpiList[0].id;
        Id kpidef =kpidefId;
        kpidefId =kpidef;
       // string Idenf = kpiValue.IdentifierParam__c; 
        Test.startTest();
        SPE2_kpiIntermediateCompute obj = new SPE2_kpiIntermediateCompute(identifierparam, kpidefId, kpiEnterpriseComMap);
        Database.executeBatch(obj);
        }
        Test.stopTest();   
        
   }
}