@isTest(SeeAllData = false)
Public class SPE2_scorecardEXT_Test{
  
    public static testmethod void scorecardEXTTest1(){
      test.startTest();
      
        User u;
        Account acc1;      
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
     System.runAs ( thisUser ) {
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');       
        insert u;
         
        Group grp = new Group();
        grp.Name = 'SPE2.0 User Group';
        insert grp;
        
        GroupMember grpMem = new GroupMember();
        grpMem.GroupId = grp.id;
        grpMem.UserOrGroupId = u.Id;
        insert grpMem;  
       
        acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
      }        
        acc1.EnterpriseId__c = 'Test Enterprise';
        update acc1;
       
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'Dharani@atos.net';
        insert con;
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'Dharani1@atos.net';
        insert CCcon1;
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'Dharani2@atos.net';
        insert CCcon2;
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'Dharani3@atos.net';
        insert CCcon3;
        
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
        for(Integer i=0;i<1;i++){
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
        PIDefObj.LifecycleStage__c = 'Draft';
        lstPIDefObj.add(PIDefObj);
        }
        insert lstPIDefObj;
               
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        lstPIDefObj[i].PIUploadDuedate__c = Date.newInstance(2016,10,10);
        }
        
        update lstPIDefObj;
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'Logic1';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Quality';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.Confidential__c =false;
        kpiDefinition1.FrequencyinMonth__c = '2';
        kpiDefinition1.IsHighBetter__c = true;
        kpiDefinition1.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;

        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiDefinition1.Id;
        kpiValue.KPIValue__c = 3;
        kpiValue.EnterpriseId__c='Test Enterprise1';
        kpiValue.ExecutionPeriod__c = 'February-2016';
        
        kpiValue.Region__c = 'All Markets';
        kpiValue.SubRegion__c = 'All Market Units';
        kpiValue.Country__c = 'All Countries';
        kpiValue.Project__c = 'All Projects';
        
        kpiValue.Cluster__c = 'All Category Areas';
        kpiValue.CategoryGroup__c = 'All Category Groups';
        kpiValue.Category__c = 'All Categories';
        
        kpiValue.BusinessUnit__c ='All Business Units';
        kpiValue.BusinessLine__c ='All Business Lines';       
        kpiValue.Product__c = 'All Products';
        insert kpiValue; 
        
        SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE Template 1';
        speTemp.Stage__c = 'Draft';
        
        speTemp.Region__c = 'All Markets';
        speTemp.SubRegion__c = 'All Market Units';
        speTemp.Country__c = 'All Countries';
        speTemp.Project__c = 'All Projects';
        
        speTemp.CategoryCluster__c = 'All Category Areas';
        speTemp.CategoryGroup__c = 'All Category Groups';
        speTemp.Category__c = 'All Categories';
        
        speTemp.BusinessUnit__c ='All Business Units';
        speTemp.BusinessLine__c ='All Business Lines';      
        speTemp.Product__c = 'All Products'; 
        insert speTemp;
        
        speTemp.Stage__c ='Pilot';
        update speTemp;
        
        SPE_SPEKPIMap__c KPIMapobj = new SPE_SPEKPIMap__c();
        KPIMapobj = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemp);
        insert KPIMapobj;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Name = 'Test Template 1122';         
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate; 
        
        SPE_ScoringCalculation__c scal = SPE_TestObjectCreator.createScoringCalc(KPIMapobj ,scoringTemplate );
        insert scal;
                
        //-----------SPEPLan Creation--------------------
        List<SPE_SPEPlan__c> lstPlan = new List<SPE_SPEPlan__c>(); 
        for(Integer i=0;i<1;i++){
             SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
             spePlan.SPEPlanName__c='Atos plan'+(i+100)+i;
             spePlan.FrequencyInMonths__c = '1';
             spePlan.AggregationDuration__c = '1';
             spePlan.SPETemplate__c = speTemp.Id;
             spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
             spePlan.Stage__c = 'Draft';
             
           lstPlan.add(spePlan);
         }
        insert lstPlan;  
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop'); 
        
        for(Integer i=0 ;i<1;i++){
        lstPlan[i].Stage__c ='Published';
        }
        update lstPlan;
        
        //-------Supplier Plan Map creation-----------------
        List<SPE_SPEPlanSupplierMap__c> lstplanmap = new List<SPE_SPEPlanSupplierMap__c>();
        for(SPE_SPEPlan__c plan : lstPlan){ 
            SPE_SPEPlanSupplierMap__c planSuppMap = new SPE_SPEPlanSupplierMap__c();
            planSuppMap.SPEPlan__c = plan.ID;
            planSuppMap.Supplier__c = acc1.ID;
            lstplanmap.add(planSuppMap);
        }
        insert lstplanmap;
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        //------------SPE Tracker Creation----------------------
        List<SPE_SPETracker__c> lstTracker = new List<SPE_SPETracker__c>();
        for(SPE_SPEPlan__c spePln : lstPlan){
            SPE_SPETracker__c  speTracker= new SPE_SPETracker__c();
            speTracker= SPE_TestObjectCreator.createSPETracker();
            speTracker.Name = 'January - 2016'; 
            speTracker.SPETemplate__c = speTemp.Id; 
            speTracker.SPEPlan__c = spePln.Id;
            speTracker.DateOfExecution__c = System.Today();
            
            speTracker.Region__c = 'All Markets';
            speTracker.SubRegion__c = 'All Market Units';
            speTracker.Country__c = 'All Countries';
            speTracker.Project__c = 'All Projects';
            
            speTracker.CategoryCluster__c = 'All Category Areas';
            speTracker.CategoryGroup__c = 'All Category Groups';
            speTracker.Category__c = 'All Categories';
            
            speTracker.BusinessUnit__c ='All Business Units';
            speTracker.BusinessLine__c ='All Business Lines';      
            speTracker.Product__c = 'All Products';
            lstTracker.add(speTracker);
         }  insert lstTracker; 
           
       insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
       for(SPE_SPETracker__c  tracker :lstTracker){
        List<SPE_TrackerValues__c> lsttrackerValues = new List<SPE_TrackerValues__c>();
        for(Integer i=0;i<1;i++){ 
           SPE_TrackerValues__c trackervAL = SPE_TestObjectCreator.createTrackerValue();
           trackervAL.SPETracker__c = tracker.ID; 
           trackervAL.Supplier__c = acc1.ID;
           trackervAL.KPIDefinition__c = kpidefinition1.ID;
           trackervAL.DataLogic__c = 'Assumed';
           trackervAL.Value__c = 3;
           trackervAL.Score__c = 3;
           trackervAL.Score1__c = 4;
           trackervAL.Weight__c=3;
           trackervAL.MissingDatalogic__c = 'Past Data or Category Average';
           lsttrackerValues.add(trackervAL);
        }
        insert  lsttrackerValues;
       } 
       insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop'); 
        
        SPE_scorecardTemplate__c sc = new SPE_scorecardTemplate__c();
        sc.Name = 'Test ScoreTemplate';
        sc.Stage__c = 'Draft';
        insert sc;
        sc.Stage__c = 'Published';
        update sc;
        System.assert(sc != null);
        
        List<SPE_scorecardSPETemplateMap__c> scTempMapList = new List<SPE_scorecardSPETemplateMap__c>();
        SPE_scorecardSPETemplateMap__c sct = new SPE_scorecardSPETemplateMap__c();
        sct.ScorecardTemplate__c = sc.Id;
        sct.SPETemplate__c = speTemp.Id;
        sct.Weight__c = 100;
        insert sct;                
        scTempMapList.add(sct);
                
        SPE_scorecardGenerator__c scg = new SPE_scorecardGenerator__c();
        scg.Name = 'Test Scorecard Generator';
        scg.Aggregation_Period_Adhoc__c = 'Half Yearly';
        scg.Stage__c = 'Draft';
        scg.ScorecardTemplate__c = sc.Id;
        scg.StartDate__c = Date.newInstance(2016,2,15);
        scg.EndDate__c = Date.newInstance(2016,12,15);
        scg.FrequencyInMonths__c = '1';
        scg.TimeFrame__c = '1';
        
        scg.Region__c = 'All Markets';
        scg.SubRegion__c = 'All Market Units';
        scg.Country__c = 'All Countries';
        scg.Project__c = 'All Projects';
        
        scg.CategoryCluster__c = 'All Category Areas';
        scg.CategoryGroup__c = 'All Category Groups';
        scg.Category__c = 'All Categories';
        
        scg.BusinessUnit__c = 'All Business Units';
        scg.BusinessLine__c = 'All Business Lines';
        scg.Product__c = 'All Products';        
        insert scg;
        
        scg.Stage__c = 'Published';
        update scg;
        
        SPE_scorecardSupplierMap__c ss = new SPE_scorecardSupplierMap__c();
        ss.ScorecardGenerator__c = scg.Id;
        ss.Supplier__c = acc1.Id;
        ss.SupplierContact__c = con.Id;
        ss.Approver__c = u.Id;
        insert ss;
        
        SPE_scorecardTracker__c stt = new SPE_scorecardTracker__c();
        stt.ScorecardGenerator__c = scg.Id; 
        stt.Name = 'H1 - 2016';
        stt.DateOfExecution__c = Date.newInstance(2016,2,15);
        stt.EndDate__c = Date.newInstance(2016,3,14);
        stt.Status__c = 'Pending';
        insert stt;
        
        stt.Status__c = 'Completed';
        update stt;
        
        List<SPE_scorecardTracker__c> strack = new List<SPE_scorecardTracker__c>();
        strack.add(stt); 
                                
        SPE_scoreCard__c score = new SPE_scoreCard__c();
        score.Name = 'Test Scorecard Name';
        score.Password__c = 'password';
        score.Approver__c = u.Id;
        score.Approver_Title__c = 'Project Procurement Manager (PPM)';
        score.Supplier__c = acc1.Id;
        score.ScorecardTemplate__c = sc.Id;
        score.Stage__c = 'Pending';
        score.ScorecardTracker__c = stt.Id;
        
        score.Region__c = 'INDIA';
        score.SubRegion__c = 'INDIA BHARTI';
        score.Country__c = 'INDIA';
        score.Project__c = 'All Project';
        
        score.CategoryCluster__c = 'All Category Area';
        score.CategoryGroup__c = 'All Category Group';
        score.Category__c = 'All Category';
        
        score.BusinessUnit__c = 'All Business Unit';
        score.BusinessLine__c = 'All Business Line';
        score.Product__c = 'Charging Gateway CG'; 
        
        score.CCContact1__c= CCcon1.id;
        score.CCContact2__c= CCcon2.id;
        score.CCContact3__c= CCcon3.id;
        score.Comments__c = 'Sample comments';

        insert score;
        
        List<ScorecardKPIMap__c> scMapLst= new List<ScorecardKPIMap__c>();
        ScorecardKPIMap__c scKpiMap = new ScorecardKPIMap__c();
        scKpiMap.KPI__c= kpiDefinition1.id;
        scKpiMap.KPITarget__c=1;
        scKpiMap.KPIValue__c=1;
        scKpiMap.Score__c=1.0;
        scKpiMap.ScoreCard__c= score.id;
        scKpiMap.SPETemplate__c = speTemp.id;
        scKpiMap.SPETemplateWeight__c = 10;
        insert scKpiMap ;
        scMapLst.add(scKpiMap); 
        
        Attachment a = new Attachment(ParentId=score.Id, Name='Test', Body=Blob.valueOf('Test'), ContentType='pdf');
        insert a;
        String name= 'abc';
        
        List<SPE_scorecardValues__c> scrcardVallst = new   List<SPE_scorecardValues__c>();
        for(integer i=0; i<1; i++){
            SPE_scorecardValues__c scvl = new SPE_scorecardValues__c();
            scvl.KPI__c= kpiDefinition1.id;
            scvl.Score__c= 3;
         //   scvl.Group__c= 'sampleGroup';
            scvl.ScoreCard__c= score.id;
            scvl.SPE_Template_Name__c= speTemp.Name ;
            scrcardVallst.add(scvl);
        }
        insert scrcardVallst;
        system.assert(scrcardVallst.size() != null);
         
        SPE2_Language_KPI__c Lang = new SPE2_Language_KPI__c();
        Lang.Language__c= 'Francois';
        Lang.English_Version__c= 'French';
        Lang.KPI__c= kpiDefinition1.id;
        Lang.Language_Version__c='1';
        insert Lang;
      
      
       System.runAs(u) {
        PageReference pageRef = Page.SPE2_scorecard;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id',score.id);
       Apexpages.currentPage().getParameters().put('Language','None');
        ApexPages.StandardController controller = new ApexPages.StandardController(score);
        SPE2_scorecardEXT scard= new SPE2_scorecardEXT(controller);
        scard.fetchspeTrackers(stt.Name,scg.Aggregation_Period_Adhoc__c);
        scard.providePassword = 'password';
        scard.updateField();
        scard.CreatePDF();
         scard.showScorecard();
       
        scard.saveChanges();
        scard.getLanguageValues();
       // scard.updateField();
        scard.refreshLanguage();
        scard.getValues(); 
        test.stopTest();
       }
    }
     public static testmethod void scorecardEXTTest2(){
      test.startTest();
      
        User u;
        Account acc1;      
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
     System.runAs ( thisUser ) {
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u;
         
        Group grp = new Group();
        grp.Name = 'SPE2.0 User Group';
        insert grp;
        
        GroupMember grpMem = new GroupMember();
        grpMem.GroupId = grp.id;
        grpMem.UserOrGroupId = u.Id;
        insert grpMem;  
       
        acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
      }  
      
        acc1.EnterpriseId__c = 'Test Enterprise';
        update acc1;
       
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'Dharani@atos.net';
        insert con;
         Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'Dharani1@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'Dharani2@atos.net';
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'Dharani3@atos.net';
        insert CCcon3;
        
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
 
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        //**********************Changes For Encryption******************// 
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1';
        //kpiDefinition1.Name = 'Test KPI Definition 12334';
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'Logic1';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Commercial';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.Confidential__c =false;
        kpiDefinition1.FrequencyinMonth__c = '2';
        kpiDefinition1.IsHighBetter__c = true;
      //  kpiDefinition1.Master_KPI__c = kpiDefinition2.Id;
        kpiDefinition1.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
        
         SPE_KPIDefinition__c kpiDefinition2 = new SPE_KPIDefinition__c();
        kpiDefinition2.KPI_Title__c = 'Test KPI Definition 2';
      //  kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition2.AbbreviatedName__c = 'TKPIDe2';
        kpiDefinition2.Level__c = '1';
        kpiDefinition2.LifecycleStage__c = 'Pilot';
        kpiDefinition2.Description__c = 'Test';
        kpiDefinition2.MissingDatalogic__c = 'SPE Invalid';
        kpiDefinition2.OperationalType__c = 'Leading PI';
        kpiDefinition2.GeoScope__c = 'All Markets';
        kpiDefinition2.categoryscope__c = 'All Categories';
        kpiDefinition2.BUScope__c = 'All Products';
        kpiDefinition2.UoM__c = 'max';
        kpiDefinition2.Group1__c = 'Delivery';
        kpiDefinition2.Group2__c = 'Hard';
        kpiDefinition2.Type__c = 'Operational';
        kpiDefinition2.ActualCalculation__c='A';
        kpiDefinition2.FrequencyinMonth__c = '2';
        kpiDefinition2.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition2.VerNumber__c = 0;
        kpiDefinition2.Aggregation__c = 'AVG';        
        kpiDefinition2.IsHighBetter__c=true;
        insert kpiDefinition2;
        
         SPE_KPIDefinition__c kpiDefinition3 = new SPE_KPIDefinition__c();
        kpiDefinition3.KPI_Title__c = 'Test KPI Definition 3';
      //  kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition3.AbbreviatedName__c = 'TKPIDe3';
        kpiDefinition3.Level__c = '1';
        kpiDefinition3.LifecycleStage__c = 'Pilot';
        kpiDefinition3.Description__c = 'Test';
        kpiDefinition3.MissingDatalogic__c = 'SPE Invalid';
        kpiDefinition3.OperationalType__c = 'Leading PI';
        kpiDefinition3.GeoScope__c = 'All Markets';
        kpiDefinition3.categoryscope__c = 'All Categories';
        kpiDefinition3.BUScope__c = 'All Products';
        kpiDefinition3.UoM__c = 'max';
        kpiDefinition3.Group1__c = 'Quality';
        kpiDefinition3.Group2__c = 'Hard';
        kpiDefinition3.Type__c = 'Operational';
        kpiDefinition3.ActualCalculation__c='A';
        kpiDefinition3.FrequencyinMonth__c = '2';
        kpiDefinition3.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition3.VerNumber__c = 0;
        kpiDefinition3.Aggregation__c = 'AVG';        
        kpiDefinition3.IsHighBetter__c=true;
        insert kpiDefinition3;
        
         SPE_KPIDefinition__c kpiDefinition4 = new SPE_KPIDefinition__c();
        kpiDefinition4.KPI_Title__c = 'Test KPI Definition 4';
      //  kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition4.AbbreviatedName__c = 'TKPIDe2';
        kpiDefinition4.Level__c = '1';
        kpiDefinition4.LifecycleStage__c = 'Pilot';
        kpiDefinition4.Description__c = 'Test';
        kpiDefinition4.MissingDatalogic__c = 'SPE Invalid';
        kpiDefinition4.OperationalType__c = 'Leading PI';
        kpiDefinition4.GeoScope__c = 'All Markets';
        kpiDefinition4.categoryscope__c = 'All Categories';
        kpiDefinition4.BUScope__c = 'All Products';
        kpiDefinition4.UoM__c = 'max';
        kpiDefinition4.Group1__c = 'Relationship';
        kpiDefinition4.Group2__c = 'Hard';
        kpiDefinition4.Type__c = 'Operational';
        kpiDefinition4.ActualCalculation__c='A';
        kpiDefinition4.FrequencyinMonth__c = '2';
        kpiDefinition4.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition4.VerNumber__c = 0;
        kpiDefinition4.Aggregation__c = 'AVG';        
        kpiDefinition4.IsHighBetter__c=true;
        insert kpiDefinition4;
        
         SPE_KPIDefinition__c kpiDefinition5 = new SPE_KPIDefinition__c();
        kpiDefinition5.KPI_Title__c = 'Test KPI Definition 5';
      //  kpiDefinition2.Name = 'Test KPI Definition 123';
        kpiDefinition5.AbbreviatedName__c = 'TKPIDe5';
        kpiDefinition5.Level__c = '1';
        kpiDefinition5.LifecycleStage__c = 'Pilot';
        kpiDefinition5.Description__c = 'Test';
        kpiDefinition5.MissingDatalogic__c = 'SPE Invalid';
        kpiDefinition5.OperationalType__c = 'Leading PI';
        kpiDefinition5.GeoScope__c = 'All Markets';
        kpiDefinition5.categoryscope__c = 'All Categories';
        kpiDefinition5.BUScope__c = 'All Products';
        kpiDefinition5.UoM__c = 'max';
        kpiDefinition5.Group1__c = 'Innovation';
        kpiDefinition5.Group2__c = 'Hard';
        kpiDefinition5.Type__c = 'Operational';
        kpiDefinition5.ActualCalculation__c='A';
        kpiDefinition5.FrequencyinMonth__c = '2';
        kpiDefinition5.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition5.VerNumber__c = 0;
        kpiDefinition5.Aggregation__c = 'AVG';        
        kpiDefinition5.IsHighBetter__c=true;
        insert kpiDefinition5;
        
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiDefinition1.Id;
        kpiValue.KPIValue__c = 3;
        kpiValue.EnterpriseId__c='Test Enterprise1';
        kpiValue.ExecutionPeriod__c = 'February-2016';
        
        kpiValue.Region__c = 'All Markets';
        kpiValue.SubRegion__c = 'All Market Units';
        kpiValue.Country__c = 'All Countries';
        kpiValue.Project__c = 'All Projects';
        
        kpiValue.Cluster__c = 'All Category Areas';
        kpiValue.CategoryGroup__c = 'All Category Groups';
        kpiValue.Category__c = 'All Categories';
        
        kpiValue.BusinessUnit__c ='All Business Units';
        kpiValue.BusinessLine__c ='All Business Lines';       
        kpiValue.Product__c = 'All Products';
        insert kpiValue; 
               
        SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE Template 1';
        speTemp.Stage__c = 'Draft';
        
        speTemp.Region__c = 'All Markets';
        speTemp.SubRegion__c = 'All Market Units';
        speTemp.Country__c = 'All Countries';
        speTemp.Project__c = 'All Projects';
        
        speTemp.CategoryCluster__c = 'All Category Areas';
        speTemp.CategoryGroup__c = 'All Category Groups';
        speTemp.Category__c = 'All Categories';
        
        speTemp.BusinessUnit__c ='All Business Units';
        speTemp.BusinessLine__c ='All Business Lines';      
        speTemp.Product__c = 'All Products'; 
        insert speTemp;
        
        speTemp.Stage__c ='Pilot';
        update speTemp;
        
        SPE_SPEKPIMap__c KPIMapobj = new SPE_SPEKPIMap__c();
        KPIMapobj = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemp);
        insert KPIMapobj;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Name = 'Test Template 1122';         
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate; 
        
        SPE_ScoringCalculation__c scal = SPE_TestObjectCreator.createScoringCalc(KPIMapobj ,scoringTemplate );
        insert scal;
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEPlanName__c='aAtos11wertest';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemp.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Draft';
        insert spePlan;
        
        spePlan.Stage__c = 'Published';
        update spePlan;
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlan.Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        speTracker.Name = 'January - 2016'; 
        speTracker.SPETemplate__c = speTemp.Id; 
        speTracker.SPEPlan__c = spePlan.Id;
        speTracker.DateOfExecution__c = System.Today();
        
        speTracker.Region__c = 'All Markets';
        speTracker.SubRegion__c = 'All Market Units';
        speTracker.Country__c = 'All Countries';
        speTracker.Project__c = 'All Projects';
        
        speTracker.CategoryCluster__c = 'All Category Areas';
        speTracker.CategoryGroup__c = 'All Category Groups';
        speTracker.Category__c = 'All Categories';
        
        speTracker.BusinessUnit__c ='All Business Units';
        speTracker.BusinessLine__c ='All Business Lines';      
        speTracker.Product__c = 'All Products';
        
        insert speTracker;
        
        List<SPE_TrackerValues__c> tvList = new List<SPE_TrackerValues__c>();
        SPE_TrackerValues__c trackerValue = new SPE_TrackerValues__c();
        trackerValue.KPIDefinition__c = kpiDefinition1.Id;
        trackerValue.SPETracker__c = speTracker.Id;
        trackerValue.DataLogic__c='Actual';
        trackerValue.Score__c=3;
        trackerValue.Value__c=3;
        trackerValue.Score1__c=4;
        trackerValue.MissingDatalogic__c='Logic1';
        trackerValue.Supplier__c = acc1.Id;
        trackerValue.Weight__c=3;
        tvList.add(trackerValue); 
        insert tvList;
        
        SPE_scorecardTemplate__c sc = new SPE_scorecardTemplate__c();
        sc.Name = 'Test ScoreTemplate';
        sc.Stage__c = 'Draft';
        insert sc;
        sc.Stage__c = 'Published';
        update sc;
        System.debug('sc.Name '+sc.Name );
        
        List<SPE_scorecardSPETemplateMap__c> scTempMapList = new List<SPE_scorecardSPETemplateMap__c>();
        SPE_scorecardSPETemplateMap__c sct = new SPE_scorecardSPETemplateMap__c();
        sct.ScorecardTemplate__c = sc.Id;
        sct.SPETemplate__c = speTemp.Id;
        sct.Weight__c = 100;
        insert sct;
               
        scTempMapList.add(sct);
        
        SPE_scorecardGenerator__c scg = new SPE_scorecardGenerator__c();
        scg.Name = 'Test Scorecard Generator';
        scg.Aggregation_Period_Adhoc__c = 'Monthly';
        scg.Stage__c = 'Approved';
        scg.ScorecardTemplate__c = sc.Id;
        scg.StartDate__c = Date.newInstance(2016,1,15);
        scg.EndDate__c = Date.newInstance(2016,12,15);
        scg.FrequencyInMonths__c = '1';
        scg.TimeFrame__c = '1';
        
        scg.Region__c = 'All Markets';
        scg.SubRegion__c = 'All Market Units';
        scg.Country__c = 'All Countries';
        scg.Project__c = 'All Projects';
        
        scg.CategoryCluster__c = 'All Category Areas';
        scg.CategoryGroup__c = 'All Category Groups';
        scg.Category__c = 'All Categories';
        
        scg.BusinessUnit__c = 'All Business Units';
        scg.BusinessLine__c = 'All Business Lines';
        scg.Product__c = 'All Products';
        
        insert scg;
        
        scg.Stage__c = 'Published';
        update scg;
        
        SPE_scorecardSupplierMap__c ss = new SPE_scorecardSupplierMap__c();
        ss.ScorecardGenerator__c = scg.Id;
        ss.Supplier__c = acc1.Id;
        ss.SupplierContact__c = con.Id;
        ss.Approver__c = u.Id;
        insert ss;
        
        SPE_scorecardTracker__c stt = new SPE_scorecardTracker__c();
        stt.ScorecardGenerator__c = scg.Id; 
        stt.Name = 'P - 01 2016';
        stt.DateOfExecution__c = Date.newInstance(2016,1,15);
        stt.EndDate__c = Date.newInstance(2016,2,14);
        stt.Status__c = 'Pending';
        insert stt;
        
        stt.Status__c = 'Completed';
        update stt;
        
        List<SPE_scorecardTracker__c> strack = new List<SPE_scorecardTracker__c>();
        strack.add(stt); 
                        
        
        SPE_scoreCard__c score = new SPE_scoreCard__c();
        score.Name = 'Test Scorecard Name';
        score.Password__c = 'password';
        score.Approver__c = u.Id;
        score.Approver_Title__c = 'Project Procurement Manager (PPM)';
        score.Supplier__c = acc1.Id;
        score.ScorecardTemplate__c = sc.Id;
        score.Stage__c = 'Approved';
        score.ScorecardTracker__c = stt.Id;
        
        score.Region__c = 'INDIA';
        score.SubRegion__c = 'INDIA BHARTI';
        score.Country__c = 'INDIA';
        score.Project__c = 'All Project';
        
        score.CategoryCluster__c = 'All Category Area';
        score.CategoryGroup__c = 'All Category Group';
        score.Category__c = 'All Category';
        
        score.BusinessUnit__c = 'All Business Unit';
        score.BusinessLine__c = 'All Business Line';
        score.Product__c = 'Charging Gateway CG'; 
        
        score.CCContact1__c= CCcon1.id;
        score.CCContact2__c= CCcon2.id;
        score.CCContact3__c= CCcon3.id;
        score.Comments__c = 'Sample comments';

        insert score;
        
        List<SPE_scoreCard__c> scoreList = new List<SPE_scoreCard__c>();
        scoreList.add(score);
        
        List<ScorecardKPIMap__c> scMapLst= new List<ScorecardKPIMap__c>();
        ScorecardKPIMap__c scKpiMap = new ScorecardKPIMap__c();
        scKpiMap.KPI__c= kpiDefinition1.id;
        scKpiMap.KPITarget__c=1;
        scKpiMap.KPIValue__c=1;
        scKpiMap.Score__c=1.0;
        scKpiMap.ScoreCard__c= score.id;
        scKpiMap.SPETemplate__c = speTemp.id;
        scKpiMap.SPETemplateWeight__c = 10;
        insert scKpiMap ;
        scMapLst.add(scKpiMap); 
        
        Attachment a = new Attachment(ParentId=score.Id, Name='Test', Body=Blob.valueOf('Test'), ContentType='pdf');
        insert a;
        String name= 'abc';
        
        List<SPE_scorecardValues__c> scrcardVallst = new   List<SPE_scorecardValues__c>();
            SPE_scorecardValues__c scvl = new SPE_scorecardValues__c();
          //  scvl.KPI__c= kpiDefinition1.id;
            scvl.Score__c= 3;
         //   scvl.Group__c= 'sampleGroup';
            scvl.ScoreCard__c= score.id;
            scvl.SPE_Template_Name__c = speTemp.Name;
            scrcardVallst.add(scvl);
            
            SPE_scorecardValues__c scv2 = new SPE_scorecardValues__c();
            scv2.KPI__c= kpiDefinition2.id;
            scv2.Score__c= 3;
            scv2.Group__c= 'Quality';
            scv2.ScoreCard__c= score.id;
            scv2.SPE_Template_Name__c = speTemp.Name;
            scrcardVallst.add(scv2);
            
            SPE_scorecardValues__c scv3 = new SPE_scorecardValues__c();
            scv3.KPI__c= kpiDefinition1.id;
            scv3.Score__c= 3;
            scv3.Group__c= 'Commercial';
            scv3.ScoreCard__c= score.id;
            scv3.SPE_Template_Name__c = speTemp.Name;
            scrcardVallst.add(scv3);
            
            SPE_scorecardValues__c scv4 = new SPE_scorecardValues__c();
            scv4.KPI__c= kpiDefinition4.id;
            scv4.Score__c= 3;
            scv4.Group__c= 'Relationship';
            scv4.ScoreCard__c= score.id;
            scv4.SPE_Template_Name__c = speTemp.Name;
            scrcardVallst.add(scv4);
            
            SPE_scorecardValues__c scv5 = new SPE_scorecardValues__c();
            scv5.KPI__c= kpiDefinition5.id;
            scv5.Score__c= 3;
            scv5.Group__c= 'Innovation';
            scv5.ScoreCard__c= score.id;
            scv5.SPE_Template_Name__c = speTemp.Name;
            scrcardVallst.add(scv5);
            
            SPE_scorecardValues__c scv6 = new SPE_scorecardValues__c();
            scv6.KPI__c= kpiDefinition3.id;
            scv6.Score__c= 3;
            scv6.Group__c= 'Delivery';
            scv6.ScoreCard__c= score.id;
            scv6.SPE_Template_Name__c = speTemp.Name;
            scrcardVallst.add(scv6);
        insert scrcardVallst;
        system.debug('scrcardVallst[0].SPE_Template_Name__c= '+ scrcardVallst[0].SPE_Template_Name__c + '     scrcardVallst[1].SPE_Template_Name__c'+scrcardVallst[1].SPE_Template_Name__c );
         
        SPE2_Language_KPI__c Lang = new SPE2_Language_KPI__c();
        Lang.Language__c= 'Francois';
        Lang.English_Version__c= 'French';
        Lang.KPI__c= kpiDefinition1.id;
        Lang.Language_Version__c='1';
        insert Lang;
           
       System.runAs(u) {
       
        PageReference pageRef = Page.SPE2_scorecard;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id',score.id);
        Apexpages.currentPage().getParameters().put('Language',Lang.Language__c);
        ApexPages.StandardController controller = new ApexPages.StandardController(score);
        SPE2_scorecardEXT scard= new SPE2_scorecardEXT(controller);
        //scard.showScorecard();
       // scard.providePassword = 'password'; //score.Password__c
        //scard.updateField();
        scard.refreshLanguage();
        scard.fetchspeTrackers(stt.Name,scg.Aggregation_Period_Adhoc__c);

        //SPE2_scorecardEXT scard= new SPE2_scorecardEXT(controller);
        scard.refreshLanguage();
        
        scard.selectedValue = 'Approve';
        scard.saveChanges();
        scard.CreatePDF();
        test.stopTest();
       }
    }
    
    public static testmethod void scorecardEXTTest3(){
      test.startTest();
      
        User u;
        Account acc1;      
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
     System.runAs ( thisUser ) {
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u;
         
        Group grp = new Group();
        grp.Name = 'SPE2.0 User Group';
        insert grp;
        
        GroupMember grpMem = new GroupMember();
        grpMem.GroupId = grp.id;
        grpMem.UserOrGroupId = u.Id;
        insert grpMem;  
       
        acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
      }  
      
        acc1.EnterpriseId__c = 'Test Enterprise';
        update acc1;
       
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'Dharani@atos.net';
        insert con;
         Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'Dharani1@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'Dharani2@atos.net';
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'Dharani3@atos.net';
        insert CCcon3;
        
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
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        //**********************Changes For Encryption******************// 
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
        //kpiDefinition1.Name = 'Test KPI Definition 12334';
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'Logic1';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Delivery';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.Confidential__c =false;
        kpiDefinition1.FrequencyinMonth__c = '2';
        kpiDefinition1.IsHighBetter__c = true;
      //  kpiDefinition1.Master_KPI__c = kpiDefinition2.Id;
        kpiDefinition1.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
                
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiDefinition1.Id;
        kpiValue.KPIValue__c = 3;
        kpiValue.EnterpriseId__c='Test Enterprise1';
        kpiValue.ExecutionPeriod__c = 'February-2016';
        
        kpiValue.Region__c = 'All Markets';
        kpiValue.SubRegion__c = 'All Market Units';
        kpiValue.Country__c = 'All Countries';
        kpiValue.Project__c = 'All Projects';
        
        kpiValue.Cluster__c = 'All Category Areas';
        kpiValue.CategoryGroup__c = 'All Category Groups';
        kpiValue.Category__c = 'All Categories';
        
        kpiValue.BusinessUnit__c ='All Business Units';
        kpiValue.BusinessLine__c ='All Business Lines';       
        kpiValue.Product__c = 'All Products';
        insert kpiValue; 
  
        SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE Template 1';
        speTemp.Stage__c = 'Draft';
        
        speTemp.Region__c = 'All Markets';
        speTemp.SubRegion__c = 'All Market Units';
        speTemp.Country__c = 'All Countries';
        speTemp.Project__c = 'All Projects';
        
        speTemp.CategoryCluster__c = 'All Category Areas';
        speTemp.CategoryGroup__c = 'All Category Groups';
        speTemp.Category__c = 'All Categories';
        
        speTemp.BusinessUnit__c ='All Business Units';
        speTemp.BusinessLine__c ='All Business Lines';      
        speTemp.Product__c = 'All Products'; 
        insert speTemp;
        
        speTemp.Stage__c ='Pilot';
        update speTemp;
        
        SPE_SPEKPIMap__c KPIMapobj = new SPE_SPEKPIMap__c();
        KPIMapobj = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemp);
        insert KPIMapobj;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Name = 'Test Template 1122';         
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate; 
        
        SPE_ScoringCalculation__c scal = SPE_TestObjectCreator.createScoringCalc(KPIMapobj ,scoringTemplate );
        insert scal;
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEPlanName__c='aAtos11test123';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemp.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Draft';
        insert spePlan;
        
        spePlan.Stage__c = 'Published';
        update spePlan;
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlan.Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        speTracker.Name = 'January - 2016'; 
        speTracker.SPETemplate__c = speTemp.Id; 
        speTracker.SPEPlan__c = spePlan.Id;
        speTracker.DateOfExecution__c = System.Today();
        
        speTracker.Region__c = 'All Markets';
        speTracker.SubRegion__c = 'All Market Units';
        speTracker.Country__c = 'All Countries';
        speTracker.Project__c = 'All Projects';
        
        speTracker.CategoryCluster__c = 'All Category Areas';
        speTracker.CategoryGroup__c = 'All Category Groups';
        speTracker.Category__c = 'All Categories';
        
        speTracker.BusinessUnit__c ='All Business Units';
        speTracker.BusinessLine__c ='All Business Lines';      
        speTracker.Product__c = 'All Products';
        
        insert speTracker;
        
        List<SPE_TrackerValues__c> tvList = new List<SPE_TrackerValues__c>();
        SPE_TrackerValues__c trackerValue = new SPE_TrackerValues__c();
        trackerValue.KPIDefinition__c = kpiDefinition1.Id;
        trackerValue.SPETracker__c = speTracker.Id;
        trackerValue.DataLogic__c='Actual';
        trackerValue.Score__c=3;
        trackerValue.Value__c=3;
        trackerValue.Score1__c=4;
        trackerValue.MissingDatalogic__c='Logic1';
        trackerValue.Supplier__c = acc1.Id;
        trackerValue.Weight__c=3;
        tvList.add(trackerValue); 
        insert tvList;
        
        SPE_scorecardTemplate__c sc = new SPE_scorecardTemplate__c();
        sc.Name = 'Test ScoreTemplate';
        sc.Stage__c = 'Draft';
        insert sc;
        sc.Stage__c = 'Published';
        update sc;
        System.debug('sc.Name '+sc.Name );
        
        List<SPE_scorecardSPETemplateMap__c> scTempMapList = new List<SPE_scorecardSPETemplateMap__c>();
        SPE_scorecardSPETemplateMap__c sct = new SPE_scorecardSPETemplateMap__c();
        sct.ScorecardTemplate__c = sc.Id;
        sct.SPETemplate__c = speTemp.Id;
        sct.Weight__c = 100;
        insert sct;
               
        scTempMapList.add(sct);
        
        SPE_scorecardGenerator__c scg = new SPE_scorecardGenerator__c();
        scg.Name = 'Test Scorecard Generator';
        scg.Aggregation_Period_Adhoc__c = 'Annual';
        scg.Stage__c = 'Approved';
        scg.ScorecardTemplate__c = sc.Id;
        scg.StartDate__c = Date.newInstance(2016,2,15);
        scg.EndDate__c = Date.newInstance(2016,12,15);
        scg.FrequencyInMonths__c = '1';
        scg.TimeFrame__c = '1';
        
        scg.Region__c = 'All Markets';
        scg.SubRegion__c = 'All Market Units';
        scg.Country__c = 'All Countries';
        scg.Project__c = 'All Projects';
        
        scg.CategoryCluster__c = 'All Category Areas';
        scg.CategoryGroup__c = 'All Category Groups';
        scg.Category__c = 'All Categories';
        
        scg.BusinessUnit__c = 'All Business Units';
        scg.BusinessLine__c = 'All Business Lines';
        scg.Product__c = 'All Products';
        
        insert scg;
        
        scg.Stage__c = 'Published';
        update scg;
        
        SPE_scorecardSupplierMap__c ss = new SPE_scorecardSupplierMap__c();
        ss.ScorecardGenerator__c = scg.Id;
        ss.Supplier__c = acc1.Id;
        ss.SupplierContact__c = con.Id;
        ss.Approver__c = u.Id;
        insert ss;
        
        SPE_scorecardTracker__c stt = new SPE_scorecardTracker__c();
        stt.ScorecardGenerator__c = scg.Id; 
        stt.Name = 'February - 2016';
        stt.DateOfExecution__c = Date.newInstance(2016,2,15);
        stt.EndDate__c = Date.newInstance(2016,3,14);
        stt.Status__c = 'Pending';
        insert stt;
        
        stt.Status__c = 'Completed';
        update stt;
        
        List<SPE_scorecardTracker__c> strack = new List<SPE_scorecardTracker__c>();
        strack.add(stt); 
                        
        
        SPE_scoreCard__c score = new SPE_scoreCard__c();
        score.Name = 'Test Scorecard Name';
        score.Password__c = 'password';
        score.Approver__c = u.Id;
        score.Approver_Title__c = 'Project Procurement Manager (PPM)';
        score.Supplier__c = acc1.Id;
        score.ScorecardTemplate__c = sc.Id;
        score.Stage__c = 'Approved';
        score.ScorecardTracker__c = stt.Id;
        
        score.Region__c = 'INDIA';
        score.SubRegion__c = 'INDIA BHARTI';
        score.Country__c = 'INDIA';
        score.Project__c = 'All Project';
        
        score.CategoryCluster__c = 'All Category Area';
        score.CategoryGroup__c = 'All Category Group';
        score.Category__c = 'All Category';
        
        score.BusinessUnit__c = 'All Business Unit';
        score.BusinessLine__c = 'All Business Line';
        score.Product__c = 'Charging Gateway CG'; 
        
        score.CCContact1__c= CCcon1.id;
        score.CCContact2__c= CCcon2.id;
        score.CCContact3__c= CCcon3.id;
        score.Comments__c = 'Sample comments';

        insert score;
        
        List<SPE_scoreCard__c> scoreList = new List<SPE_scoreCard__c>();
        scoreList.add(score);
        
        List<ScorecardKPIMap__c> scMapLst= new List<ScorecardKPIMap__c>();
        ScorecardKPIMap__c scKpiMap = new ScorecardKPIMap__c();
        scKpiMap.KPI__c= kpiDefinition1.id;
        scKpiMap.KPITarget__c=1;
        scKpiMap.KPIValue__c=1;
        scKpiMap.Score__c=1.0;
        scKpiMap.ScoreCard__c= score.id;
        scKpiMap.SPETemplate__c = speTemp.id;
        scKpiMap.SPETemplateWeight__c = 10;
        insert scKpiMap ;
        scMapLst.add(scKpiMap); 
        
        Attachment a = new Attachment(ParentId=score.Id, Name='Test', Body=Blob.valueOf('Test'), ContentType='pdf');
        insert a;
        String name= 'abc';
        
        List<SPE_scorecardValues__c> scrcardVallst = new   List<SPE_scorecardValues__c>();
        for(integer i=0; i<2; i++){
            SPE_scorecardValues__c scvl = new SPE_scorecardValues__c();
           // scvl.KPI__c= kpiDefinition1.id;
            scvl.Score__c= 3;
            scvl.Group__c= 'sampleGroup';
            scvl.ScoreCard__c= score.id;
            scvl.SPE_Template_Name__c = speTemp.Name;
            scrcardVallst.add(scvl);
        }
        insert scrcardVallst;
           
        SPE2_Language_KPI__c Lang = new SPE2_Language_KPI__c();
        Lang.Language__c= 'Francois';
        Lang.English_Version__c= 'French';
        Lang.KPI__c= kpiDefinition1.id;
        Lang.Language_Version__c='1';
        insert Lang;
           
       System.runAs(u) {
       
       PageReference pageRef = Page.SPE2_scorecard;
       Test.setCurrentPage(pageRef);
       ApexPages.currentPage().getParameters().put('id',score.id);
       ApexPages.StandardController controller1 = new ApexPages.StandardController(score);
       SPE2_scorecardEXT scard= new SPE2_scorecardEXT(controller1);
       scard.getValues();
       scard.providePassword = 'paword'; //score.Password__c
       scard.updateField();
       scard.showScorecard();
       scard.refreshLanguage();
       Apexpages.currentPage().getParameters().put('Language',Lang.Language__c);
       scard.getLanguageValues();
       //SPE2_scorecardEXT scard= new SPE2_scorecardEXT(controller);
       scard.refreshLanguage();
       scard.fetchspeTrackers(stt.Name,scg.Aggregation_Period_Adhoc__c);
       scard.selectedValue = 'Approve';
       scard.saveChanges();
       scard.CreatePDF();

       scard.providePassword = 'password'; //score.Password__c
       scard.updateField();  
        test.stopTest();
       }
    }
    
    public static testmethod void scorecardEXTTest5(){
      test.startTest();
      
        User u;
        Account acc1;      
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
     System.runAs ( thisUser ) {
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u;
         
        Group grp = new Group();
        grp.Name = 'SPE2.0 User Group';
        insert grp;
        
        GroupMember grpMem = new GroupMember();
        grpMem.GroupId = grp.id;
        grpMem.UserOrGroupId = u.Id;
        insert grpMem;  
       
        acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
      }  
      
        acc1.EnterpriseId__c = 'Test Enterprise';
        update acc1;
       
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'Dharani@atos.net';
        insert con;
         Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'Dharani1@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'Dharani2@atos.net';
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'Dharani3@atos.net';
        insert CCcon3;
        
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
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        //**********************Changes For Encryption******************// 
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
        //kpiDefinition1.Name = 'Test KPI Definition 12334';
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'Logic1';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Delivery';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.Confidential__c =false;
        kpiDefinition1.FrequencyinMonth__c = '2';
        kpiDefinition1.IsHighBetter__c = true;
      //  kpiDefinition1.Master_KPI__c = kpiDefinition2.Id;
        kpiDefinition1.ScheduledDate__c = Date.newInstance(2016,10,15);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
                
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiDefinition1.Id;
        kpiValue.KPIValue__c = 3;
        kpiValue.EnterpriseId__c='Test Enterprise1';
        kpiValue.ExecutionPeriod__c = 'February-2016';
        
        kpiValue.Region__c = 'All Markets';
        kpiValue.SubRegion__c = 'All Market Units';
        kpiValue.Country__c = 'All Countries';
        kpiValue.Project__c = 'All Projects';
        
        kpiValue.Cluster__c = 'All Category Areas';
        kpiValue.CategoryGroup__c = 'All Category Groups';
        kpiValue.Category__c = 'All Categories';
        
        kpiValue.BusinessUnit__c ='All Business Units';
        kpiValue.BusinessLine__c ='All Business Lines';       
        kpiValue.Product__c = 'All Products';
        insert kpiValue; 
      
        SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE Template 1';
        speTemp.Stage__c = 'Draft';
        
        speTemp.Region__c = 'All Markets';
        speTemp.SubRegion__c = 'All Market Units';
        speTemp.Country__c = 'All Countries';
        speTemp.Project__c = 'All Projects';
        
        speTemp.CategoryCluster__c = 'All Category Areas';
        speTemp.CategoryGroup__c = 'All Category Groups';
        speTemp.Category__c = 'All Categories';
        
        speTemp.BusinessUnit__c ='All Business Units';
        speTemp.BusinessLine__c ='All Business Lines';      
        speTemp.Product__c = 'All Products'; 
        insert speTemp;
        
        speTemp.Stage__c ='Pilot';
        update speTemp;
        
        SPE_SPEKPIMap__c KPIMapobj = new SPE_SPEKPIMap__c();
        KPIMapobj = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemp);
        insert KPIMapobj;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Name = 'Test Template 1122';         
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate; 
        
        SPE_ScoringCalculation__c scal = SPE_TestObjectCreator.createScoringCalc(KPIMapobj ,scoringTemplate );
        insert scal;
        
        SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
        spePlan.SPEPlanName__c='aAtos11test123456';
        spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemp.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Draft';
        insert spePlan;
        
        spePlan.Stage__c = 'Published';
        update spePlan;
        
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlan.Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        speTracker.Name = 'January - 2016'; 
        speTracker.SPETemplate__c = speTemp.Id; 
        speTracker.SPEPlan__c = spePlan.Id;
        speTracker.DateOfExecution__c = System.Today();
        
        speTracker.Region__c = 'All Markets';
        speTracker.SubRegion__c = 'All Market Units';
        speTracker.Country__c = 'All Countries';
        speTracker.Project__c = 'All Projects';
        
        speTracker.CategoryCluster__c = 'All Category Areas';
        speTracker.CategoryGroup__c = 'All Category Groups';
        speTracker.Category__c = 'All Categories';
        
        speTracker.BusinessUnit__c ='All Business Units';
        speTracker.BusinessLine__c ='All Business Lines';      
        speTracker.Product__c = 'All Products';
        
        insert speTracker;
        
        List<SPE_TrackerValues__c> tvList = new List<SPE_TrackerValues__c>();
        SPE_TrackerValues__c trackerValue = new SPE_TrackerValues__c();
        trackerValue.KPIDefinition__c = kpiDefinition1.Id;
        trackerValue.SPETracker__c = speTracker.Id;
        trackerValue.DataLogic__c='Actual';
        trackerValue.Score__c=3;
        trackerValue.Value__c=3;
        trackerValue.Score1__c=4;
        trackerValue.MissingDatalogic__c='Logic1';
        trackerValue.Supplier__c = acc1.Id;
        trackerValue.Weight__c=3;
        tvList.add(trackerValue); 
        insert tvList;
        
        SPE_scorecardTemplate__c sc = new SPE_scorecardTemplate__c();
        sc.Name = 'Test ScoreTemplate';
        sc.Stage__c = 'Draft';
        insert sc;
        sc.Stage__c = 'Published';
        update sc;
        System.debug('sc.Name '+sc.Name );
        
        List<SPE_scorecardSPETemplateMap__c> scTempMapList = new List<SPE_scorecardSPETemplateMap__c>();
        SPE_scorecardSPETemplateMap__c sct = new SPE_scorecardSPETemplateMap__c();
        sct.ScorecardTemplate__c = sc.Id;
        sct.SPETemplate__c = speTemp.Id;
        sct.Weight__c = 100;
        insert sct;
               
        scTempMapList.add(sct);
        
        SPE_scorecardGenerator__c scg2 = new SPE_scorecardGenerator__c();
        scg2.Name = 'Test Scorecard Generator';
        scg2.Aggregation_Period_Adhoc__c = 'Quarterly';
        scg2.Stage__c = 'Approved';
        scg2.ScorecardTemplate__c = sc.Id;
        scg2.StartDate__c = Date.newInstance(2016,2,15);
        scg2.EndDate__c = Date.newInstance(2016,12,15);
        scg2.FrequencyInMonths__c = '1';
        scg2.TimeFrame__c = '1';
        scg2.isAdhoc__c =true;
        scg2.DisplayValues__c =true;
        scg2.Region__c = 'All Markets';
        scg2.SubRegion__c = 'All Market Units';
        scg2.Country__c = 'All Countries';
        scg2.Project__c = 'All Projects';
        
        scg2.CategoryCluster__c = 'All Category Areas';
        scg2.CategoryGroup__c = 'All Category Groups';
        scg2.Category__c = 'All Categories';
        
        scg2.BusinessUnit__c = 'All Business Units';
        scg2.BusinessLine__c = 'All Business Lines';
        scg2.Product__c = 'All Products';
        
        insert scg2;
        
        scg2.Stage__c = 'Published';
        update scg2;
        
        SPE_scorecardSupplierMap__c ss2 = new SPE_scorecardSupplierMap__c();
        ss2.ScorecardGenerator__c = scg2.Id;
        ss2.Supplier__c = acc1.Id;
        ss2.SupplierContact__c = con.Id;
        ss2.Approver__c = u.Id;
        insert ss2;
        
        SPE_scorecardTracker__c stt2 = new SPE_scorecardTracker__c();
        stt2.ScorecardGenerator__c = scg2.Id; 
        stt2.Name = 'Q1 - 2016';
        stt2.DateOfExecution__c = Date.newInstance(2016,2,15);
        stt2.EndDate__c = Date.newInstance(2016,3,14);
        stt2.Status__c = 'Pending';
        insert stt2;
        
        stt2.Status__c = 'Completed';
        update stt2;
        
        List<SPE_scorecardTracker__c> strack2 = new List<SPE_scorecardTracker__c>();
        strack2.add(stt2);
        
        SPE_Scorecard_Plan__c scorecardplan = new SPE_Scorecard_Plan__c(); 
        scorecardplan.Scorecard_Generator__c =scg2.id;
        scorecardplan.SPE_Plan__c =spePlan.id;
        insert scorecardplan;                
        
        SPE_scoreCard__c score2 = new SPE_scoreCard__c();
        score2.Name = 'Test Scorecard Name';
        score2.Password__c = 'password';
        score2.Approver__c = u.Id;
        score2.Approver_Title__c = 'Project Procurement Manager (PPM)';
        score2.Supplier__c = acc1.Id;
        score2.ScorecardTemplate__c = sc.Id;
        score2.Stage__c = 'Approved';
        score2.ScorecardTracker__c = stt2.Id;
        
        score2.Region__c = 'INDIA';
        score2.SubRegion__c = 'INDIA BHARTI';
        score2.Country__c = 'INDIA';
        score2.Project__c = 'All Project';
        
        score2.CategoryCluster__c = 'All Category Area';
        score2.CategoryGroup__c = 'All Category Group';
        score2.Category__c = 'All Category';
        
        score2.BusinessUnit__c = 'All Business Unit';
        score2.BusinessLine__c = 'All Business Line';
        score2.Product__c = 'Charging Gateway CG'; 
        
        score2.CCContact1__c= CCcon1.id;
        score2.CCContact2__c= CCcon2.id;
        score2.CCContact3__c= CCcon3.id;
        score2.Comments__c = 'Sample comments';

        insert score2;
        
        List<SPE_scoreCard__c> scoreList2 = new List<SPE_scoreCard__c>();
        scoreList2.add(score2);
        
        List<ScorecardKPIMap__c> scMapLst2= new List<ScorecardKPIMap__c>();
        ScorecardKPIMap__c scKpiMap2 = new ScorecardKPIMap__c();
        scKpiMap2.KPI__c= kpiDefinition1.id;
        scKpiMap2.KPITarget__c=1;
        scKpiMap2.KPIValue__c=1;
        scKpiMap2.Score__c=1.0;
        scKpiMap2.ScoreCard__c= score2.id;
        scKpiMap2.SPETemplate__c = speTemp.id;
        scKpiMap2.SPETemplateWeight__c = 10;
        insert scKpiMap2 ;
        scMapLst2.add(scKpiMap2); 
        
        Attachment att = new Attachment(ParentId=score2.Id, Name='Test', Body=Blob.valueOf('Test'), ContentType='pdf');
        insert att;
        String name1= 'abc';
        
        List<SPE_scorecardValues__c> scrcardVallst2 = new   List<SPE_scorecardValues__c>();
        for(integer i=0; i<2; i++){
            SPE_scorecardValues__c scv = new SPE_scorecardValues__c();
           // scvl.KPI__c= kpiDefinition1.id;
            scv.Score__c= 3;
            scv.Group__c= 'sampleGroup';
            scv.ScoreCard__c= score2.id;
            scv.SPE_Template_Name__c = speTemp.Name;
            scrcardVallst2.add(scv);
        }
        insert scrcardVallst2;
         
        SPE2_Language_KPI__c Lang = new SPE2_Language_KPI__c();
        Lang.Language__c= 'Francois';
        Lang.English_Version__c= 'French';
        Lang.KPI__c= kpiDefinition1.id;
        Lang.Language_Version__c='1';
        insert Lang;
           
       System.runAs(u) {
       
        PageReference pageRef = Page.SPE2_scorecard;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id',score2.id);
        ApexPages.StandardController controller2 = new ApexPages.StandardController(score2);
        SPE2_scorecardEXT scard1= new SPE2_scorecardEXT(controller2);
        scard1.getValues();
        scard1.providePassword = 'paword'; //score.Password__c
        scard1.updateField();
        scard1.showScorecard();
        scard1.refreshLanguage();
        Apexpages.currentPage().getParameters().put('Language',Lang.Language__c);
        scard1.getLanguageValues();
        //SPE2_scorecardEXT scard= new SPE2_scorecardEXT(controller);
        scard1.refreshLanguage();
        scard1.fetchspeTrackers(stt2.Name,scg2.Aggregation_Period_Adhoc__c);
        scard1.selectedValue = 'Approve';
        scard1.saveChanges();
        scard1.CreatePDF();
        scard1.providePassword = 'password'; //score.Password__c
        test.stopTest();
       }
    }
      static testmethod void scorecardEXTTest4(){
      
      
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Name = 'Picklist Default Values';       
        picklistObj.Business_Unit__c = 'All Business Units';
        picklistObj.Business_Line__c = 'All Business Lines';        
        picklistObj.Project__c = 'All Projects';        
        picklistObj.Category_Area__c = 'All Category Areas';
        picklistObj.Category_Group__c = 'All Category Groups';
        picklistObj.Category__c = 'All Categories';                       
        picklistObj.Market__c = 'All Markets';
        picklistObj.Market_Unit__c = 'All Market Units';
        picklistObj.Country__c = 'All Countries';       
        picklistObj.Product__c = 'All Products';
 
        lstpicklistObj.add(picklistObj);       
        insert lstpicklistObj;
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u; 
       /* Group grp = new Group();
        grp.Name = 'SPE2.0 User Group';
        insert grp;
        
        GroupMember grpMem = new GroupMember();
        grpMem.GroupId = grp.id;
        grpMem.UserOrGroupId = u.Id;
        insert grpMem;  */
       
        Account acc1 = new Account();
        acc1.Name = 'Test Account1';
        acc1.EnterpriseId__c = 'Test Enterprise1';
        insert acc1;
       
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'Dharani@atos.net';
        insert con;
        
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'Dharani1@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'Dharani2@atos.net';
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'Dharani3@atos.net';
        insert CCcon3;
        
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
        lstPIDefObj[i].PIUploadDuedate__c = System.today();
        }
        
        update lstPIDefObj;
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        //**********************Changes For Encryption******************// 
        kpiDefinition1.KPI_Title__c = 'Test KPI Definition 123';
        //kpiDefinition1.Name = 'Test KPI Definition 12334';
        kpiDefinition1.AbbreviatedName__c = 'TKPIDe1';
        kpiDefinition1.Level__c = '1';
        kpiDefinition1.LifecycleStage__c = 'Draft';
        kpiDefinition1.Description__c = 'Test';
        kpiDefinition1.MissingDatalogic__c = 'Logic1';
        kpiDefinition1.OperationalType__c = 'Leading PI';
        kpiDefinition1.GeoScope__c = 'All Markets';
        kpiDefinition1.categoryscope__c = 'All Categories';
        kpiDefinition1.BUScope__c = 'All Products';
        kpiDefinition1.UoM__c = 'max';
        kpiDefinition1.Group1__c = 'Delivery';
        kpiDefinition1.Group2__c = 'Hard';
        kpiDefinition1.Type__c = 'Operational';
        kpiDefinition1.Confidential__c =false;
        kpiDefinition1.FrequencyinMonth__c = '2';
        kpiDefinition1.IsHighBetter__c = true;
      //  kpiDefinition1.Master_KPI__c = kpiDefinition2.Id;
        kpiDefinition1.ScheduledDate__c = System.today().addDays(1);
        kpiDefinition1.VerNumber__c = 0;
        kpiDefinition1.ActualCalculation__c= 'A'; 
        insert kpiDefinition1;
        
        kpiDefinition1.LifecycleStage__c = 'Pilot';
        update kpiDefinition1;
                
        SPE_KPIValue__c kpiValue = new SPE_KPIValue__c();
        kpiValue.KPIDefinition__c = kpiDefinition1.Id;
        kpiValue.KPIValue__c = 3;
        kpiValue.EnterpriseId__c='Test Enterprise1';
        kpiValue.ExecutionPeriod__c = 'February-2016';
        
        kpiValue.Region__c = 'All Markets';
        kpiValue.SubRegion__c = 'All Market Units';
        kpiValue.Country__c = 'All Countries';
        kpiValue.Project__c = 'All Projects';
        
        kpiValue.Cluster__c = 'All Category Areas';
        kpiValue.CategoryGroup__c = 'All Category Groups';
        kpiValue.Category__c = 'All Categories';
        
        kpiValue.BusinessUnit__c ='All Business Units';
        kpiValue.BusinessLine__c ='All Business Lines';       
        kpiValue.Product__c = 'All Products';
        insert kpiValue; 
      
        SPE_SPETemplate__c speTemp = new SPE_SPETemplate__c();
        speTemp.Name = 'Test SPE Template 1';
        speTemp.Stage__c = 'Draft';
        
        speTemp.Region__c = 'All Markets';
        speTemp.SubRegion__c = 'All Market Units';
        speTemp.Country__c = 'All Countries';
        speTemp.Project__c = 'All Projects';
        
        speTemp.CategoryCluster__c = 'All Category Areas';
        speTemp.CategoryGroup__c = 'All Category Groups';
        speTemp.Category__c = 'All Categories';
        
        speTemp.BusinessUnit__c ='All Business Units';
        speTemp.BusinessLine__c ='All Business Lines';      
        speTemp.Product__c = 'All Products'; 
        insert speTemp;
        
        speTemp.Stage__c ='Pilot';
        update speTemp;
        
        SPE_SPEKPIMap__c KPIMapobj = new SPE_SPEKPIMap__c();
        KPIMapobj = SPE_TestObjectCreator.CreateSPEKPI(kpiDefinition1,speTemp);
        insert KPIMapobj;
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Name = 'Test Template 1122';         
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Pilot';
        update scoringTemplate; 
        
        SPE_ScoringCalculation__c scal = SPE_TestObjectCreator.createScoringCalc(KPIMapobj ,scoringTemplate );
        insert scal;
        
        List<SPE_SPEPlan__c> spePlanlist = new List<SPE_SPEPlan__c>();
        for(integer i=0; i<2;i++){
            SPE_SPEPlan__c spePlan = SPE_TestObjectCreator.CreateSPEPlan();
            spePlan.SPEPlanName__c='aAtos11TestAtosTest' +i;
            spePlan.FrequencyInMonths__c = '1';
            spePlan.AggregationDuration__c = '1';
            spePlan.SPETemplate__c = speTemp.Id;
            spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
            spePlan.Stage__c = 'Draft';
            spePlan.Ad_Hoc_Plan__c = true;
            //spePlan.EndDate__c = System.today().addMonths(3);   
            //spePlan.StartDate__c = System.today().addDays(1);
            //spePlan.Additional_Days__c = 1;
            spePlanlist.add(speplan);
        }    
        insert spePlanlist;
        system.debug('spePlanlist ::'+spePlanlist);
        for(integer i=0; i<2;i++){
            spePlanlist[i].Stage__c ='Published';
        }
        update spePlanlist;
        system.debug('spePlanlist ::'+spePlanlist);
        SPE_SPEPlanSupplierMap__c spePlanSupMap = new SPE_SPEPlanSupplierMap__c();
        spePlanSupMap.SPEPlan__c = spePlanlist[0].Id;
        spePlanSupMap.Supplier__c = acc1.id;
        insert spePlanSupMap;
        
        SPE_SPETracker__c speTracker = SPE_TestObjectCreator.createSPETracker();
        speTracker.Name = 'July - 2016'; 
        speTracker.SPETemplate__c = speTemp.Id; 
        speTracker.SPEPlan__c = spePlanlist[0].id;
        speTracker.DateOfExecution__c = System.today().addDays(1);
        
        speTracker.Region__c = 'All Markets';
        speTracker.SubRegion__c = 'All Market Units';
        speTracker.Country__c = 'All Countries';
        speTracker.Project__c = 'All Projects';
        
        speTracker.CategoryCluster__c = 'All Category Areas';
        speTracker.CategoryGroup__c = 'All Category Groups';
        speTracker.Category__c = 'All Categories';
        
        speTracker.BusinessUnit__c ='All Business Units';
        speTracker.BusinessLine__c ='All Business Lines';      
        speTracker.Product__c = 'All Products';
        
        insert speTracker;
        
        List<SPE_TrackerValues__c> tvList = new List<SPE_TrackerValues__c>();
        SPE_TrackerValues__c trackerValue = new SPE_TrackerValues__c();
        trackerValue.KPIDefinition__c = kpiDefinition1.Id;
        trackerValue.SPETracker__c = speTracker.Id;
        trackerValue.DataLogic__c='Actual';
        trackerValue.Score__c=3;
        trackerValue.Value__c=3;
        trackerValue.Score1__c=4;
        trackerValue.MissingDatalogic__c='Logic1';
        trackerValue.Supplier__c = acc1.Id;
        trackerValue.Weight__c=3;
        tvList.add(trackerValue); 
        insert tvList;
        
        SPE_scorecardTemplate__c sc = new SPE_scorecardTemplate__c();
        sc.Name = 'Test ScoreTemplate';
        sc.Stage__c = 'Draft';
        insert sc;
        sc.Stage__c = 'Published';
        update sc;
        System.debug('sc.Name '+sc.Name );
        
        List<SPE_scorecardSPETemplateMap__c> scTempMapList = new List<SPE_scorecardSPETemplateMap__c>();
        SPE_scorecardSPETemplateMap__c sct = new SPE_scorecardSPETemplateMap__c();
        sct.ScorecardTemplate__c = sc.Id;
        sct.SPETemplate__c = speTemp.Id;
        sct.Weight__c = 100;
        insert sct;
               
        scTempMapList.add(sct);
        
        SPE_scorecardGenerator__c scg2 = new SPE_scorecardGenerator__c();
        scg2.Name = 'Test Scorecard Generator';
        scg2.Aggregation_Period_Adhoc__c = 'Quarterly';
        scg2.Stage__c = 'Approved';
        scg2.ScorecardTemplate__c = sc.Id;
        scg2.StartDate__c = Date.newInstance(2016,2,15);
        scg2.EndDate__c = Date.newInstance(2016,12,15);
        scg2.FrequencyInMonths__c = '1';
        scg2.TimeFrame__c = '1';
        scg2.isAdhoc__c =true;
       // scg2.DisplayValues__c =true;
        scg2.Region__c = 'All Markets';
        scg2.SubRegion__c = 'All Market Units';
        scg2.Country__c = 'All Countries';
        scg2.Project__c = 'All Projects';
        
        scg2.CategoryCluster__c = 'All Category Areas';
        scg2.CategoryGroup__c = 'All Category Groups';
        scg2.Category__c = 'All Categories';
        
        scg2.BusinessUnit__c = 'All Business Units';
        scg2.BusinessLine__c = 'All Business Lines';
        scg2.Product__c = 'All Products';
        
        insert scg2;
        
        scg2.Stage__c = 'Published';
        update scg2;
        
        SPE_scorecardSupplierMap__c ss2 = new SPE_scorecardSupplierMap__c();
        ss2.ScorecardGenerator__c = scg2.Id;
        ss2.Supplier__c = acc1.Id;
        ss2.SupplierContact__c = con.Id;
        ss2.Approver__c = u.Id;
        insert ss2;
        
        SPE_scorecardTracker__c stt2 = new SPE_scorecardTracker__c();
        stt2.ScorecardGenerator__c = scg2.Id; 
        stt2.Name = 'Q1 - 2016';
        stt2.DateOfExecution__c = Date.newInstance(2016,2,15);
        stt2.EndDate__c = Date.newInstance(2016,3,14);
        stt2.Status__c = 'Pending';
        insert stt2;
        
        stt2.Status__c = 'Completed';
        update stt2;
        
        List<SPE_scorecardTracker__c> strack2 = new List<SPE_scorecardTracker__c>();
        strack2.add(stt2);
        
        List<SPE_Scorecard_Plan__c> scorecardplanList = new List<SPE_Scorecard_Plan__c>();
        for(integer i=0;i<2;i++){
            SPE_Scorecard_Plan__c scorecardplan = new SPE_Scorecard_Plan__c(); 
            scorecardplan.Scorecard_Generator__c =scg2.id;
            scorecardplan.SPE_Plan__c =spePlanlist[i].id;
        }
        insert scorecardplanList;                
        
        SPE_scoreCard__c score2 = new SPE_scoreCard__c();
        score2.Name = 'Test Scorecard Name';
        score2.Password__c = 'password';
        score2.Approver__c = u.Id;
        score2.Approver_Title__c = 'Project Procurement Manager (PPM)';
        score2.Supplier__c = acc1.Id;
        score2.ScorecardTemplate__c = sc.Id;
        score2.Stage__c = 'Approved';
        score2.ScorecardTracker__c = stt2.Id;
        
        score2.Region__c = 'INDIA';
        score2.SubRegion__c = 'INDIA BHARTI';
        score2.Country__c = 'INDIA';
        score2.Project__c = 'All Project';
        
        score2.CategoryCluster__c = 'All Category Area';
        score2.CategoryGroup__c = 'All Category Group';
        score2.Category__c = 'All Category';
        
        score2.BusinessUnit__c = 'All Business Unit';
        score2.BusinessLine__c = 'All Business Line';
        score2.Product__c = 'Charging Gateway CG'; 
        
        score2.CCContact1__c= CCcon1.id;
        score2.CCContact2__c= CCcon2.id;
        score2.CCContact3__c= CCcon3.id;
        score2.Comments__c = 'Sample comments';

        insert score2;
        
        List<SPE_scoreCard__c> scoreList2 = new List<SPE_scoreCard__c>();
        scoreList2.add(score2);
        
        List<ScorecardKPIMap__c> scMapLst2= new List<ScorecardKPIMap__c>();
        ScorecardKPIMap__c scKpiMap2 = new ScorecardKPIMap__c();
        scKpiMap2.KPI__c= kpiDefinition1.id;
        scKpiMap2.KPITarget__c=1;
        scKpiMap2.KPIValue__c=1;
        scKpiMap2.Score__c=1.0;
        scKpiMap2.ScoreCard__c= score2.id;
        scKpiMap2.SPETemplate__c = speTemp.id;
        scKpiMap2.SPETemplateWeight__c = 10;
        insert scKpiMap2 ;
        scMapLst2.add(scKpiMap2); 
        
        Attachment att = new Attachment(ParentId=score2.Id, Name='Test', Body=Blob.valueOf('Test'), ContentType='pdf');
        insert att;
        String name1= 'abc';
        
        List<SPE_scorecardValues__c> scrcardVallst2 = new   List<SPE_scorecardValues__c>();
        for(integer i=0; i<2; i++){
            SPE_scorecardValues__c scv = new SPE_scorecardValues__c();
           // scvl.KPI__c= kpiDefinition1.id;
            scv.Score__c= 3;
            scv.Group__c= 'sampleGroup';
            scv.ScoreCard__c= score2.id;
            scv.SPE_Template_Name__c = speTemp.Name;
            scrcardVallst2.add(scv);
        }
        insert scrcardVallst2;
         
        SPE2_Language_KPI__c Lang = new SPE2_Language_KPI__c();
        Lang.Language__c= 'Francois';
        Lang.English_Version__c= 'French';
        Lang.KPI__c= kpiDefinition1.id;
        Lang.Language_Version__c='1';
        insert Lang;
           Test.startTest();
      // System.runAs(u) {
       
        PageReference pageRef = Page.SPE2_scorecard;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id',score2.id);
        ApexPages.StandardController controller2 = new ApexPages.StandardController(score2);
        SPE2_scorecardEXT scard1= new SPE2_scorecardEXT(controller2);
        scard1.getValues();
        scard1.providePassword = 'paword'; //score.Password__c
        scard1.updateField();
        scard1.showScorecard();
        scard1.refreshLanguage();
        Apexpages.currentPage().getParameters().put('Language',Lang.Language__c);
        scard1.getLanguageValues();
        //SPE2_scorecardEXT scard= new SPE2_scorecardEXT(controller);
        scard1.refreshLanguage();
        scard1.fetchspeTrackers(stt2.Name,scg2.Aggregation_Period_Adhoc__c);
        scard1.selectedValue = 'Approve';
        scard1.saveChanges();
        scard1.CreatePDF();
        scard1.providePassword = 'password'; //score.Password__c
        Test.stopTest();
     //  }
    }
}