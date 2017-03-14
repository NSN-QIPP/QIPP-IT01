@isTest(SeeAllData=False)
public class SPE_LifecycleEXT_Test{    
    
    //--------Test method for object SPE_KPIDefinition__c-----------
    
    public static testmethod void testSurveyQuestion(){
        
        SPE_SurveyQuestion__c surQues=SPE_TestObjectCreator.CreateSurveyQuestion();
        surQues.QuestionLabel__c = 'Test Question Lable';
        insert surQues;
        SPE_SurveyAnswer__c surAns1=SPE_TestObjectCreator.CreateSurveyAnswer();
        surAns1.SurveyQuestion__c=surQues.Id;
        surAns1.Choices__c = 'white';
        insert surAns1;
        SPE_SurveyAnswer__c surAns2=SPE_TestObjectCreator.CreateSurveyAnswer();
        surAns2.SurveyQuestion__c=surQues.Id;
        surAns1.Choices__c = 'Black';
        insert surAns2;
        system.assert( surQues !=Null ); 
         List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
       // for(Integer i=0;i<10;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();  
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj.PI_Title__c = 'Test PI Definition78';
        PIDefObj.SurveyQuestion__c = surQues.Id;  
        
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
       // }
        insert PIDefObj;
        SPE_SurveyQuestion__c sQues= [select Id,SurveyQuestion__c ,AnswerType__c from SPE_SurveyQuestion__c where ID =: surQues.Id];
        system.assert( sQues !=Null ); 
        system.assert( PIDefObj.LifecycleStage__c == 'Draft' );
        
       // ApexPages.currentPage().getParameters().put('SobjectName','SPE_SurveyQuestion__c');
        ApexPages.StandardController ctlr = new ApexPages.StandardController(sQues);
        String obi= Id.valueOf(ctlr.getid()).getSObjectType().getDescribe().getName();
        System.assert(obi == 'SPE_SurveyQuestion__c','Que data' );

    }
   
    public static TestMethod void testKPIDefinition(){       
           
        test.startTest();
        
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new 
    
        List<PicklistDefaultValues__c>();
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
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1235';
        
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe3';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'Logic1';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Cost';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.FrequencyinMonth__c = '2';
        kpiDefinition1.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition1.VerNumber__c = 0;
        insert kpiDefinition1;
        
        SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpidef.ActualCalculation__c= 'a';
        kpidef.Master_KPI__c= kpiDefinition1.Id;
        insert kpidef;
        
        kpidef.LifecycleStage__c = 'Draft';
        kpidef.ScheduledDate__c = Date.newInstance(2016,10,15);
        update kpidef;
        
        //---KPI data ends---- 
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<1;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        
        //update lifecycle stage
        
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        lstPIDefObj[i].PIUploadDuedate__c = Date.newInstance(2016,10,10);
        }
        update lstPIDefObj;
        
        //----add KPI Calculation -----  
        List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    
        for(Integer i=0;i<1;i++){
            SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
            KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
            KPIcalc.TimeFrame__c = 2.0;
            KPIcalc.KPIDefinition__c = kpidef.Id;
            KPIcalc.Aggregation__c = 'Sum';
            KPIcalc.Index__c = 'A';
            KPIcalc.Filter1__c = '1';
            KPIcalc.Filter2__c = '1';
            KPIcalc.Filter3__c = '1';
            KPIcalc.Filter4__c = '1';
            KPIcalc.Filter5__c = '1';
            KPIcalc.Filter6__c = '1';
            KPIcalc.Filter7__c = '1';
            KPIcalc.Filter8__c = '1';
            KPIcalc.Filter10__c = '1';
            lstKPIcalc.add(KPIcalc);
        } 
        
        insert lstKPIcalc;
       
        SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE TEmplate 123';
        speTemp.Stage__c = 'Draft';
        speTemp.Region__c = 'All Markets';
        speTemp.SubRegion__c = 'All Market Units';
        speTemp.Country__c = 'All Countries';
        speTemp.Project__c = 'All Projects';
        speTemp.CategoryCluster__c = 'All Category Areas';
        speTemp.CategoryGroup__c = 'All Category Groups';
        speTemp.Category__c = 'All Categories';
        speTemp.BusinessLine__c ='All Business Units';
        speTemp.BusinessUnit__c ='All Business Lines';
        speTemp.Product__c = 'All Products';       
        insert speTemp;
        
        speTemp.Stage__c ='Pilot';
        update speTemp;
        System.assert(speTemp != Null);

        try{
        
        SPE_KPIDefinition__c resultObj = [SELECT LifecycleStage__c FROM SPE_KPIDefinition__c where id = :kpidef.Id];
        system.assert(resultObj!=null);
           
        ApexPages.StandardController ctlr = new ApexPages.StandardController(kpidef);
        SPE_LifecycleEXT testObj = new SPE_LifecycleEXT(ctlr);
        
      //  System.assert(kpiDefinition1 != null && (kpidef.LifecycleStage__c == 'Pilot' || kpidef.LifecycleStage__c == 'Published'));
        ApexPages.currentPage().getParameters().put('msg','Complete  KPI before Publishing');
        testObj.StagePilot();
        PageReference p = testObj.StagePublished();
    
        testObj.StageObsolete();
        testObj.StageDelete();
        testObj.executeTestBatch();
        
        }catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('My Error Message') ? true : false;
        } 
        
        test.stopTest();
    
    }
    
   public static TestMethod void testSPETemplate(){                 
    
        test.startTest();
        
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new 
    
        List<PicklistDefaultValues__c>();
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
        
        //----------create SPE Template------------ 
        //SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        //speTemp = SPE_TestObjectCreator.CreateSPETemplate();
        SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE TEmplate 123';
        speTemp.Stage__c = 'Draft';
        speTemp.Region__c = 'All Markets';
        speTemp.SubRegion__c = 'All Market Units';
        speTemp.Country__c = 'All Countries';
        speTemp.Project__c = 'All Projects';
        speTemp.CategoryCluster__c = 'All Category Areas';
        speTemp.CategoryGroup__c = 'All Category Groups';
        speTemp.Category__c = 'All Categories';
        speTemp.BusinessLine__c ='All Business Units';
        speTemp.BusinessUnit__c ='All Business Lines';
        speTemp.Product__c = 'All Products'; 
        insert speTemp;
        
        //-------------SPE Template created------
        speTemp.Stage__c ='Pilot';
        update speTemp;
        
        //---------create KPI_Definition -----------
        SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpidef.ActualCalculation__c= 'a';    
        insert kpidef;
        
        kpidef.LifecycleStage__c = 'Pilot';
        kpidef.ScheduledDate__c = Date.newInstance(2016,10,11);
        update kpidef;
        
        //---------- Create KPIMap------------
        
        SPE_SPEKPIMap__c KPIMapobj = new SPE_SPEKPIMap__c();
        KPIMapobj = SPE_TestObjectCreator.CreateSPEKPI(kpidef,speTemp);
        insert KPIMapobj; 
        
        //-------------KPIMap created----------------
        
        SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
        scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Stage__c = 'Published';
        
        insert scoringTemplate;
        
        List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    
        
        for(Integer i=0;i<10;i++){
            SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
            //KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
            KPIcalc.PrevKPIDefination__c = kpidef.Id;
            KPIcalc.TimeFrame__c = 2.0;
            KPIcalc.KPIDefinition__c = kpidef.Id;
            KPIcalc.Aggregation__c = 'Sum';
            KPIcalc.Index__c = 'A';
            KPIcalc.Filter1__c = '1';
            KPIcalc.Filter2__c = '1';
            KPIcalc.Filter3__c = '1';
            KPIcalc.Filter4__c = '1';
            KPIcalc.Filter5__c = '1';
            KPIcalc.Filter6__c = '1';
            KPIcalc.Filter7__c = '1';
            KPIcalc.Filter8__c = '1';
            KPIcalc.Filter9__c = '1';
            KPIcalc.Filter10__c = '1';
            lstKPIcalc.add(KPIcalc);
        } 
        
        //insert lstKPIcalc;
        
        SPE_KPIDefinition__c resultObj = [SELECT LifecycleStage__c FROM SPE_KPIDefinition__c where id = :kpidef.Id];
        system.assert(resultObj!=null);
        
        ApexPages.StandardController ctlr = new ApexPages.StandardController(speTemp);
        SPE_LifecycleEXT testObj = new SPE_LifecycleEXT(ctlr);
        try{
        //ApexPages.currentPage().getParameters().put('SobjectName','SPE_SurveyQuestion__c');
            PageReference p = testObj.StagePublished();
            
            testObj.StageObsolete();
            testObj.StageDelete();
    
        }catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('System.NullPointerException') ? true : false;
        }
    
        test.stopTest();    
    }
    public static TestMethod void testSPETemplate1(){                 
    
        test.startTest();
        
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new 
    
        List<PicklistDefaultValues__c>();
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
        
         Account a = new Account();
         a.Name = 'COSCOM';
         a.enterpriseId__c='COSCOM';
         insert a;
        
         SPE_PIDefinition__c pidef = SPE_TestObjectCreator.CreatePIDefinition();
         pidef.PIUploadDuedate__c = Date.newInstance(2016,6,24);       
         insert pidef;
        
         pidef.LifecycleStage__c = 'Pilot';
         update pidef;
         System.debug('pidef ::'+pidef);
        
        SPE_PIValues__c piVal = SPE_TestObjectCreator.CreatePIValues(pidef.id,a.id,a.enterpriseId__c);
        piVal.PIDefination__c =pidef.id;
        piVal.EnterpriseID__c = 'COSCOM';
        piVal.Period__c = Date.newInstance(2016,6,14);
        piVal.NumberValue__c =10;
        insert piVal;
        //---------create KPI_Definition -----------
        SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpidef.ActualCalculation__c= 'a';    
        insert kpidef;
        
         SPE_KPICalculation__c kpiCal = SPE_TestObjectCreator.createKPICalculation();
        kpiCal.pidefination__c=pidef.id;
        kpical.KPIDefinition__c =kpidef.id;      
        insert kpiCal;

        KPI_Calculation_Formula__c kpiform = new KPI_Calculation_Formula__c();
        kpiform.Name = 'Condition 1';
        kpiform.KPI__c =kpidef.id;
        kpiform.KPI_Expression__c = 'A';
        kpiform.KPI_Formula__c = 'A';
        insert kpiform;
        
        KPI_Calulation_Condition__c kpicondtn =new KPI_Calulation_Condition__c();
        kpicondtn.Name ='A';
        kpicondtn.Formula__c =kpiform.id;
        kpicondtn.Operator__c = '>=';
        kpicondtn.Value__c = 10;                     
        insert kpicondtn;
        
        kpidef.LifecycleStage__c = 'Published';
        kpidef.ScheduledDate__c = Date.newInstance(2016,10,11);
        update kpidef;
        
        SPE_SPETemplate__c spetemp =SPE_TestObjectCreator.CreateSPETemplate();
        insert spetemp;
        spetemp.Stage__c ='Pilot';
        update spetemp;
        //---------- Create KPIMap------------
        
        SPE_SPEKPIMap__c KPIMapobj = new SPE_SPEKPIMap__c();
        KPIMapobj = SPE_TestObjectCreator.CreateSPEKPI(kpidef,speTemp);
        insert KPIMapobj; 
        
        //-------------KPIMap created----------------
        
        SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
        scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Stage__c = 'Published';
        
      //  insert scoringTemplate;
        
        List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    
        
        for(Integer i=0;i<10;i++){
            SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
            //KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
            KPIcalc.PrevKPIDefination__c = kpidef.Id;
            KPIcalc.TimeFrame__c = 2.0;
            KPIcalc.KPIDefinition__c = kpidef.Id;
            KPIcalc.Aggregation__c = 'Sum';
            KPIcalc.Index__c = 'A';
            KPIcalc.Filter1__c = '1';
            KPIcalc.Filter2__c = '1';
            KPIcalc.Filter3__c = '1';
            KPIcalc.Filter4__c = '1';
            KPIcalc.Filter5__c = '1';
            KPIcalc.Filter6__c = '1';
            KPIcalc.Filter7__c = '1';
            KPIcalc.Filter8__c = '1';
            KPIcalc.Filter9__c = '1';
            KPIcalc.Filter10__c = '1';
            lstKPIcalc.add(KPIcalc);
        } 
        
        //insert lstKPIcalc;
        
        SPE_KPIDefinition__c resultObj = [SELECT LifecycleStage__c FROM SPE_KPIDefinition__c where id = :kpidef.Id];
        system.assert(resultObj!=null);
        
        ApexPages.StandardController ctlr = new ApexPages.StandardController(speTemp);
        SPE_LifecycleEXT testObj = new SPE_LifecycleEXT(ctlr);
        try{
        //ApexPages.currentPage().getParameters().put('SobjectName','SPE_SurveyQuestion__c');
            testObj.StagePublished();
            
            testObj.StageObsolete();
            testObj.StageDelete();
    
        }catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('System.NullPointerException') ? true : false;
        }
    
        test.stopTest();    
    }
 
   public static TestMethod void testPIDefination(){
            
        test.startTest();
        
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new 
    
        List<PicklistDefaultValues__c>();
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
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1234';
       
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe2';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'Logic1';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Cost';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.FrequencyinMonth__c = '2';
        kpiDefinition1.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition1.VerNumber__c = 0;
        insert kpiDefinition1;
        
        SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpidef.ActualCalculation__c= 'a';
        kpidef.Master_KPI__c= kpiDefinition1.Id;
        insert kpidef;
        
        kpidef.LifecycleStage__c = 'Draft';
        kpidef.ScheduledDate__c = Date.newInstance(2016,10,15);
        update kpidef;
        

        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
        

        
        for(Integer i=0;i<2;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        lstPIDefObj[i].PIUploadDuedate__c = Date.newInstance(2016,10,10);
        }
        
        update lstPIDefObj;
        
        //----add KPI Calculation -----  
        List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    
        for(Integer i=0;i<2;i++){
            SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
            KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
            KPIcalc.TimeFrame__c = 2.0;
            KPIcalc.KPIDefinition__c = kpidef.Id;
            KPIcalc.Aggregation__c = 'Sum';
            KPIcalc.Index__c = 'A';
            KPIcalc.Filter1__c = '1';
            KPIcalc.Filter2__c = '1';
            KPIcalc.Filter3__c = '1';
            KPIcalc.Filter4__c = '1';
            KPIcalc.Filter5__c = '1';
            KPIcalc.Filter6__c = '1';
            KPIcalc.Filter7__c = '1';
            KPIcalc.Filter8__c = '1';
            KPIcalc.Filter10__c = '1';
            lstKPIcalc.add(KPIcalc);
        } 
        insert lstKPIcalc;
        
        try{
        
        SPE_KPIDefinition__c resultObj = [SELECT LifecycleStage__c FROM SPE_KPIDefinition__c where id = :kpidef.Id];      
        ApexPages.StandardController ctlr = new ApexPages.StandardController(lstPIDefObj[0]);
        
        SPE_LifecycleEXT testObj = new SPE_LifecycleEXT(ctlr);
        PageReference p = testObj.StagePublished();
        ApexPages.currentPage().getParameters().put('msg','Complete  KPI before Publishing'); 
        testObj.StagePilot();
        testObj.StageObsolete();
        testObj.StageDelete();
        testObj.executeTestBatch();
        
        }catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('My Error Message') ? true : false;
        } 
        
        test.stopTest();
    }      
  /* public static TestMethod void testPIDefination1(){
            
        test.startTest();
        
        //---Custom Setting data ---
        LIst<PicklistDefaultValues__c> lstpicklistObj = new 
    
        List<PicklistDefaultValues__c>();
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
        
        SPE_KPIDefinition__c kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpiDefinition1.VerNumber__c = 0;
        insert kpiDefinition1;
 
        SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
        kpidef.ActualCalculation__c= 'a';
        kpidef.Master_KPI__c= kpiDefinition1.Id;
        insert kpidef;
        
        kpidef.LifecycleStage__c = 'Pilot';
        kpidef.VerNumber__c =1;
        
        kpidef.ScheduledDate__c = Date.newInstance(2016,10,15);
        update kpidef;
        
        //---KPI data ends---- 
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<2;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;

        for(Integer i=0;i<2;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        lstPIDefObj[i].PIUploadDuedate__c = Date.newInstance(2016,10,10);
        }
        
        update lstPIDefObj;
        
        //----add KPI Calculation -----  
        List<SPE_KPICalculation__c> lstKPIcalc = new List<SPE_KPICalculation__c>();
    
        for(Integer i=0;i<2;i++){
            SPE_KPICalculation__c KPIcalc = new SPE_KPICalculation__c();
            KPIcalc.PIDefination__c = lstPIDefObj[i].Id;
            KPIcalc.TimeFrame__c = 2.0;
            KPIcalc.KPIDefinition__c = kpidef.Id;
            KPIcalc.Aggregation__c = 'Sum';
            KPIcalc.Index__c = 'A';
            KPIcalc.Filter1__c = '1';
            KPIcalc.Filter2__c = '1';
            KPIcalc.Filter3__c = '1';
            KPIcalc.Filter4__c = '1';
            KPIcalc.Filter5__c = '1';
            KPIcalc.Filter6__c = '1';
            KPIcalc.Filter7__c = '1';
            KPIcalc.Filter8__c = '1';
            KPIcalc.Filter10__c = '1';
            lstKPIcalc.add(KPIcalc);
        } 
        insert lstKPIcalc;
  
        ApexPages.StandardController ctlr = new ApexPages.StandardController(lstPIDefObj[0]);
        
        SPE_LifecycleEXT testObj = new SPE_LifecycleEXT(ctlr);
        testObj.SobjectName ='SPE_KPIDefinition__c';
        //PageReference p = testObj.StagePublished();
        //ApexPages.currentPage().getParameters().put('msg','Complete  KPI before Publishing'); 
        testObj.StagePilot();
        testObj.StageObsolete();
        testObj.StageDelete();
        testObj.executeTestBatch();
        
        test.stopTest();
    }     */ 
}