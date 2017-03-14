@isTest(seeAllData=false)
public class SPE2_AddSurveyRespondent_new_extTest{
    static testmethod void SPE2_AddSurveyRespondent_new_ext_tst1(){
    
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
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        SPE_Report_Configs__c Rconfig = new SPE_Report_Configs__c();
        Rconfig.Name= 'Test Report COnfig';
        Rconfig.Market_Filter_For_Volume__c = true;
        Rconfig.Product_Filter_For_Spend__c= true;
        Rconfig.Product_Filter_For_Volume__c= true;
        insert Rconfig;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u;
             
        System.RunAs(u){ 
        
        Account acc1 = new Account();
        acc1.Name = 'COSCOM';
        acc1.EnterpriseId__c = 'COSCOM';
        insert acc1;
        
        List<Contact> conlist = new List<Contact>();
        for(Integer i=0;i<=51;i++){
            Contact con = new Contact();
            con.LastName = 'Test Contact'+i;
            con.AccountId = acc1.Id;
            con.Email = 'TestMail'+i+'@atos.net';
            conlist.add(con);
        }
        insert conlist;
          
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
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        update lstPIDefObj;
                              
        SPE_Spend__c spend = new SPE_Spend__c();
        spend.Business_Line__c ='All Business Lines'; 
        spend.Business_Unit__c= 'All Business Units';
        spend.Category__c='All Categories'; 
        spend.CategoryArea__c='All Category Areas';
        spend.CategoryGroup__c='All Category Groups';
        spend.Country__c='All Countries'; 
        spend.Period__c=Date.newInstance(2016,10,20);
        spend.Product__c='All Products';
        spend.Project__c= 'All Projects';
        spend.Region__c='All Region';
        spend.Spend__c= 2;
        spend.SPEPeriod__c= 'test';
        spend.Sub_Region__c='All Sub Region'; 
        spend.EnterpriseId__c= acc1.id;
        insert spend;
                  
        List<Business_System_Role__c> BusinessroleList = new List<Business_System_Role__c>(); 
        Business_System_Role__c businessystrole = new Business_System_Role__c();
        businessystrole.name = 'Standalone Survey';
        businessystrole.Object_Name__c = 'Standalone Survey';
        businessystrole.Business_Role__c ='Category Manager';
        businessystrole.System_Role__c ='Survey Respondent';
        BusinessroleList.add(businessystrole); 
        insert BusinessroleList;
                
        List<SPE_CategoryInfo__c> catInfoList = new List<SPE_CategoryInfo__c>();
        for(integer i=0 ;i<=51; i++){
            SPE_CategoryInfo__c catInfo = new SPE_CategoryInfo__c();
            catInfo.Business_Role__c ='Category Manager';
            catInfo.System_Role__c ='Survey Respondent';
            catInfo.Contact__c = conlist[i].id;
            catInfo.CategoryScopeCombination__c = 'IND'+';'+'IND MX'+';'+'IND C'+';'+'INDP'+';'+'IP'+';'+'IP GP'+';'+'IP CG'+';'+'PROD PROC'+';'+'PROD BL'+';'+'PROD RT';
            catInfo.Supplier__c =acc1.id;
            catInfo.Region__c = 'IND';
            catInfo.SubRegion__c = 'IND MX';
            catInfo.Country__c = 'IND C';
            catInfo.Project__c = 'INDP';              
            catInfo.CategoryCluster__c = 'IP';
            catInfo.CategoryGroup__c = 'IP GP';
            catInfo.Category__c = 'IP CG';                
            catInfo.BusinessLine__c ='PROD PROC';
            catInfo.BusinessUnit__c ='PROD BL';
            catInfo.Product__c = 'PROD RT';
            catInfoList.add(catInfo);
        }
        insert catInfoList;
       
        List<SPE2Survey__c> lstsurvey = new List<SPE2Survey__c>(); 
        for(Integer i=0;i<11;i++){                 
            SPE2Survey__c speSurvey = new SPE2Survey__c();
            speSurvey.Additional_Days__c = 2;
            speSurvey.Additional_Days_for_week__c = 2;
            speSurvey.BusinessLine__c = 'All Business Lines';
            speSurvey.BusinessUnit__c = 'All Business Units';
            speSurvey.Category__c = 'All Categories';
            speSurvey.CategoryArea__c =  'All Category Areas';
            speSurvey.CategoryGroup__c = 'All Category Groups';
            speSurvey.Country__c ='All Countries';
            speSurvey.Day_name_of_upload_week__c = 'Sunday';
            speSurvey.EndDate__c = Date.newInstance(2016, 8, 17);
            speSurvey.FrequencyInMonths__c = '1';
            speSurvey.Is_One_Time_Survey__c =  True;
            speSurvey.Market__c = 'All Markets';
            speSurvey.MarketUnit__c ='All Market Units';
            speSurvey.Month_Upload_Day__c = 7;
            speSurvey.Product__c = 'All Products';
            speSurvey.Project__c = 'All Projects';
            speSurvey.Recurrence_frequency_type__c = 'Monthly';
            speSurvey.Recurrence_Pattern__c = 'DayPerMonth';
            speSurvey.Stage__c = 'Draft';
            speSurvey.SurveyReminderBeforeExecutionDate__c = 1;
            speSurvey.SurveyExecutionBeforeIndays__c = 1;
            speSurvey.StartDate__c = Date.newInstance(2016,8,15);
            speSurvey.Survey_Shut_Down__c = 1;
            speSurvey.Upload_Day__c = 2;
            speSurvey.Week_Count__c = 'First';
            speSurvey.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
            speSurvey.Yearly_Week_Count__c = 'Second';  
            lstsurvey.add(speSurvey);   
           }  
         insert lstsurvey;
        
        List<SPE2_SurveySupplierMap__c> survMaplst = new  List<SPE2_SurveySupplierMap__c>();
        for(Integer i=0 ;i<=5;i++){
            SPE2_SurveySupplierMap__c survmap = new SPE2_SurveySupplierMap__c();
            survmap.SPE2_Survey__c= lstsurvey[i].id;
            survmap.Supplier__c = acc1.id;
            survMaplst.add(survmap);
          }  
        insert survMaplst; 
         
        SPE2_Survey_Respondents__c surResp = new SPE2_Survey_Respondents__c();
        surResp.Contact__c = conlist[0].Id;
        surResp.Survey__c = lstsurvey[0].Id;
        insert surResp; 
                              
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(lstsurvey[0]);
        SPE2_AddSurveyRespondent_new_ext obj = new SPE2_AddSurveyRespondent_new_ext(sc);
        SPE2_AddSurveyRespondent_new_ext.SupplierWrapper SW = new SPE2_AddSurveyRespondent_new_ext.SupplierWrapper();
        SW.isSelected = true;
        PageReference pg = Page.SPE2_AddSurveyRespondent_new;
        system.Test.setCurrentPage(pg);
        Apexpages.currentpage().getparameters().put('planIdentifier','planIdentifier');
        Apexpages.currentPage().getParameters().put('crntPageNum','2');      
        Apexpages.currentPage().getParameters().put('contactName','Test');
        obj.searchSuppliers();
        Apexpages.currentPage().getParameters().put('contactName','Test*');
        obj.searchSuppliers();
        Apexpages.currentPage().getParameters().put('contactName','*Test');
        obj.searchSuppliers();
        Apexpages.currentPage().getParameters().put('contactName','*Test*');
        obj.searchSuppliers();
       // obj.contactName = conlist[0].id;
       // obj.searchSuppliers();   
        obj.showInternalContactOnly();        
        obj.firstBtnClick();
        obj.DEFAULT_PAGE_SIZE = 0;
        obj.nextBtnClick();       
        obj.previousBtnClick();
        obj.lastBtnClick();
        obj.goToPage();
        obj.goToSearchPage();
        obj.searchInternalContact();       
        obj.returnbackToPlan();
        //obj.DEFAULT_PAGE_SIZE = 1;
       /* obj.nextBtnClick2();
        obj.firstBtnClick2();
        obj.previousBtnClick2();
        obj.lastBtnClick2();*/
        //obj.goToPage2();
        obj.AddToPlans();
        //obj.AddToPlans2();
                
        Test.stopTest(); 
        }
    } 
    static testmethod void SPE2_AddSurveyRespondent_new_ext_tst2(){
    
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
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        SPE_Report_Configs__c Rconfig = new SPE_Report_Configs__c();
        Rconfig.Name= 'Test Report COnfig';
        Rconfig.Market_Filter_For_Volume__c = true;
        Rconfig.Product_Filter_For_Spend__c= true;
        Rconfig.Product_Filter_For_Volume__c= true;
        insert Rconfig;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u;
             
        System.RunAs(u){ 
        
        Account acc1 = new Account();
        acc1.Name = 'COSCOM';
        acc1.EnterpriseId__c = 'COSCOM';
        insert acc1;
        
        List<Contact> conlist = new List<Contact>();
        for(Integer i=0;i<=51;i++){
            Contact con = new Contact();
            con.LastName = 'Test Contact'+i;
            con.AccountId = acc1.Id;
            con.isInternal__c = true;        
            con.Email = 'TestMail'+i+'@atos.net';
            conlist.add(con);
        }
        insert conlist;
        
        SPE_SurveyQuestion__c surQues = new SPE_SurveyQuestion__c();
        surQues.Name = 'Atos_QB';
        surQues.Secondary_Language__c = 'French';
        surQues.AnswerType__c = 'Good';
        surQues.Business__c = 'All Business Units';
        surQues.CategoryScope__c = 'All Categories'; 
        surQues.Frequency__c ='1';
        surQues.GeoScope__c = 'All Markets';
        surQues.IsActive__c = True; 
        surQues.Is_Translated__c = true;
        surQues.IsRequired__c = True;
      //  surQues.MaxScore__c = 1;
        surQues.OperationalType__c = 'Picklist';
      //  surQues.Question_Bank__c = 'Atos_123';
        surQues.Parent_Survey_Question__c = 'Atos_SurvQues123'; 
      //  surQues.PIData__c = lstPIDefObj[0].Id;
        surQues.PIDefinition__c = 'Atos_testPI';
        surQues.PIType__c = 'Atos_Test_PI';
        surQues.BUScope__c = 'All Products';
        surQues.QuestionAbbreviation__c = 'test123';
        surQues.QuestionLabel__c = 'Atos_test_QB123';
        surQues.SurveyQueHeaderandSurveyQue__c = 'Test@123'; 
        surQues.SurveyQuestion__c = 'SurvQues12';
       // surQues.CreatedBy = 'u.Id';
       // surQues.LastModifiedBy = 'u.Id';
        insert surQues; 
           
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
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        update lstPIDefObj;
        surQues.PIData__c = lstPIDefObj[0].Id;
        update surQues;  
                              
        List<SPE_Spend__c> spendList = new List<SPE_Spend__c>();
        for(integer i=0;i<10;i++){
            SPE_Spend__c spend =new SPE_Spend__c();
            spend.Region__c = 'IND';
            spend.Sub_Region__c= 'IND MX';
            spend.Country__c = 'IND C';
            spend.Project__c = 'INDP';             
            spend.CategoryArea__c= 'IP';
            spend.CategoryGroup__c = 'IP GP';
            spend.Category__c = 'IP CG';                
            spend.Business_Line__c ='PROD PROC';
            spend.Business_Unit__c='PROD BL';
            spend.Product__c = 'PROD RT';
            spend.Period__c=Date.newInstance(2016,10,20);
            spend.Spend__c= 2;
            spend.SPEPeriod__c= 'test';
            spend.EnterpriseId__c= acc1.id;
            spendList.add(spend);
        }
        insert spendList;   
                  
        List<Business_System_Role__c> BusinessroleList = new List<Business_System_Role__c>(); 
        Business_System_Role__c businessystrole = new Business_System_Role__c();
        businessystrole.name = 'Standalone Survey';
        businessystrole.Object_Name__c = 'Standalone Survey';
        businessystrole.Business_Role__c ='Category Manager';
        businessystrole.System_Role__c ='Survey Respondent';
        BusinessroleList.add(businessystrole); 
        insert BusinessroleList;
                
        List<SPE_CategoryInfo__c> catInfoList = new List<SPE_CategoryInfo__c>();
        for(integer i=0 ;i<=51; i++){
            SPE_CategoryInfo__c catInfo = new SPE_CategoryInfo__c();
            catInfo.Business_Role__c ='Category Manager';
            catInfo.System_Role__c ='Survey Respondent';
            catInfo.Contact__c = conlist[i].id;
            catInfo.CategoryScopeCombination__c = 'IND'+';'+'IND MX'+';'+'IND C'+';'+'INDP'+';'+'IP'+';'+'IP GP'+';'+'IP CG'+';'+'PROD PROC'+';'+'PROD BL'+';'+'PROD RT';
            catInfo.Supplier__c =acc1.id;
            catInfo.Region__c = 'IND';
            catInfo.SubRegion__c = 'IND MX';
            catInfo.Country__c = 'IND C';
            catInfo.Project__c = 'INDP';              
            catInfo.CategoryCluster__c = 'IP';
            catInfo.CategoryGroup__c = 'IP GP';
            catInfo.Category__c = 'IP CG';                
            catInfo.BusinessLine__c ='PROD PROC';
            catInfo.BusinessUnit__c ='PROD BL';
            catInfo.Product__c = 'PROD RT';
            catInfoList.add(catInfo);
        }
        insert catInfoList;
       
        List<SPE2Survey__c> lstsurvey = new List<SPE2Survey__c>(); 
        for(Integer i=0;i<10;i++){                 
            SPE2Survey__c speSurvey = new SPE2Survey__c();
            speSurvey.Market__c = 'IND';
            speSurvey.MarketUnit__c = 'IND MX';
            speSurvey.Country__c = 'IND C';
            speSurvey.Project__c = 'INDP';             
            speSurvey.CategoryArea__c= 'IP';
            speSurvey.CategoryGroup__c = 'IP GP';
            speSurvey.Category__c = 'IP CG';                
            speSurvey.BusinessLine__c ='PROD PROC';
            speSurvey.BusinessUnit__c ='PROD BL';
            speSurvey.Product__c = 'PROD RT';
            speSurvey.Additional_Days__c = 2;
            speSurvey.Additional_Days_for_week__c = 2;
            speSurvey.Day_name_of_upload_week__c = 'Sunday';
            speSurvey.EndDate__c = Date.newInstance(2016, 8, 17);
            speSurvey.FrequencyInMonths__c = '1';
            speSurvey.Is_One_Time_Survey__c =  True;
            speSurvey.Month_Upload_Day__c = 7;
            speSurvey.Recurrence_frequency_type__c = 'Monthly';
            speSurvey.Recurrence_Pattern__c = 'DayPerMonth';
            speSurvey.Stage__c = 'Draft';
            speSurvey.SurveyReminderBeforeExecutionDate__c = 1;
            speSurvey.SurveyExecutionBeforeIndays__c = 1;
            speSurvey.StartDate__c = Date.newInstance(2016,8,15);
            speSurvey.Survey_Shut_Down__c = 1;
            speSurvey.Upload_Day__c = 2;
            speSurvey.Week_Count__c = 'First';
            speSurvey.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
            speSurvey.Yearly_Week_Count__c = 'Second';  
            lstsurvey.add(speSurvey);   
           }  
         insert lstsurvey;
        
        List<SPE2_SurveySupplierMap__c> survMaplst = new  List<SPE2_SurveySupplierMap__c>();
        for(Integer i=0 ;i<=10;i++){
            SPE2_SurveySupplierMap__c survmap = new SPE2_SurveySupplierMap__c();
            survmap.SPE2_Survey__c= lstsurvey[0].id;
            survmap.Supplier__c = acc1.id;
            survMaplst.add(survmap);
          }  
        insert survMaplst; 
         
        SPE2_Survey_Respondents__c surResp = new SPE2_Survey_Respondents__c();
        surResp.Contact__c = conlist[0].Id;
        surResp.Survey__c = lstsurvey[0].Id;
        insert surResp;
        
        List<SPE2_Question_Survey_Association__c> lstquesAssoc = new List<SPE2_Question_Survey_Association__c>(); 
        for(Integer i=0;i<10;i++){        
            SPE2_Question_Survey_Association__c quesAssoc = new SPE2_Question_Survey_Association__c();
            quesAssoc.AnswerType__c = 'FreeText';
            quesAssoc.Is_Active__c = true;
            quesAssoc.Is_Required__c = true;
            quesAssoc.PIData__c = lstPIDefObj[0].Id;
            quesAssoc.PIFrequency__c = '1';
            quesAssoc.Question_Bank__c = surQues.Id;
            quesAssoc.QuestionID__c = 'Q-1234';
            quesAssoc.QuestionLabel__c = 'TestQuestion';
            quesAssoc.SurveyRespondent__c = surResp.Id;
            quesAssoc.Supplier__c = acc1.Id;
            quesAssoc.Survey__c = lstsurvey[0].Id;
            quesAssoc.SurveyQuestion__c = 'surQues';
            lstquesAssoc.add(quesAssoc);
        }
        insert lstquesAssoc; 
                              
        Test.startTest();
        PageReference pg = Page.SPE2_AddSurveyRespondent_new;
        system.Test.setCurrentPage(pg);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(lstsurvey[0]);        
        SPE2_AddSurveyRespondent_new_ext.SupplierWrapper SW = new SPE2_AddSurveyRespondent_new_ext.SupplierWrapper();
        SW.isSelected = true;
        
        SPE2_AddSurveyRespondent_new_ext obj = new SPE2_AddSurveyRespondent_new_ext(sc);
        obj.DEFAULT_PAGE_SIZE = 1;
        obj.lastBtnClick();
        obj.nextBtnClick();      
        obj.previousBtnClick();
        obj.firstBtnClick();
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        obj.goToPage();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        obj.goToPage();
        ApexPages.currentPage().getParameters().put('crntPageNum','2');
        obj.goToPage(); 
        ApexPages.currentPage().getParameters().put('crntPageNum','100');
        obj.goToPage();         
        if(obj.maxPages != null){
          obj.pageNumber = obj.maxPages-1;
          obj.nextBtnClick();
          obj.goToPage(); 
        }
        obj.firstBtnClick();
         if(obj.subwrapperList2.size() != Null){
            for(SPE2_AddSurveyRespondent_new_ext.SupplierWrapper suppWrp : obj.subwrapperList2){
                suppWrp.isSelected= true;
            }
        }
        obj.contactName = 'COSCOM*';        
        obj.searchSuppliers();
        obj.contactName = 'COSCOM*';
        obj.searchInternalContact();
        obj.contactName ='*COSCOM';
        obj.searchSuppliers();
        obj.contactName ='*COSCOM';
        obj.searchInternalContact();
        obj.contactName ='*COSCOM*';
        obj.searchSuppliers();
        obj.contactName ='*COSCOM*';
        obj.searchInternalContact();
        Apexpages.currentPage().getParameters().put('supplierName','supplierName');
        obj.contactName ='COSCOM';
        obj.searchSuppliers();
        obj.contactName ='COSCOM';
        obj.searchInternalContact();
        obj.DEFAULT_PAGE_SIZE2 = 0;
        obj.lastBtnClick2();
        obj.nextBtnClick2();      
        obj.previousBtnClick2();
        obj.firstBtnClick2();
        ApexPages.currentPage().getParameters().put('crntPageNum','0');
        obj.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','1');
        obj.goToPage2();
        ApexPages.currentPage().getParameters().put('crntPageNum','2');
        obj.goToPage2(); 
        ApexPages.currentPage().getParameters().put('crntPageNum','100');
        obj.goToPage2();         
        if(obj.maxPages2 != null){
          obj.pageNumber2 = obj.maxPages2-1;
          obj.nextBtnClick2();
          obj.goToPage2(); 
        }
        obj.firstBtnClick2();        
        obj.searchInternalContact();        
        obj.AddRespondent();
        Test.stopTest(); 
        }
    }
    static testmethod void SPE2_AddSurveyRespondent_new_ext_tst3(){
    
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
        
        insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
        
        SPE_Report_Configs__c Rconfig = new SPE_Report_Configs__c();
        Rconfig.Name= 'Test Report COnfig';
        Rconfig.Market_Filter_For_Volume__c = true;
        Rconfig.Product_Filter_For_Spend__c= true;
        Rconfig.Product_Filter_For_Volume__c= true;
        insert Rconfig;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@abctestorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testabcorg.com');
       
        insert u;
             
        System.RunAs(u){ 
        
        Account acc1 = new Account();
        acc1.Name = 'COSCOM';
        acc1.EnterpriseId__c = 'COSCOM';
        insert acc1;
        
       // List<Contact> conlist = new List<Contact>();
       // for(Integer i=0;i<=51;i++){
            Contact con = new Contact();
            con.LastName = 'Test Contact1234';
            con.AccountId = acc1.Id;
            con.isInternal__c = true;        
            con.Email = 'Test.Mail1@atos.net';
          //  conlist.add(con);
       // }
        insert con;
        
        Contact con1 = new Contact();
        con1.LastName = 'Test Contact1';
        con1.AccountId = acc1.Id;
        con1.isInternal__c = true;        
        con1.Email = 'Test.Mail2@atos.net';
        
        SPE_SurveyQuestion__c surQues = new SPE_SurveyQuestion__c();
        surQues.Name = 'Atos_QB';
        surQues.Secondary_Language__c = 'French';
        surQues.AnswerType__c = 'Good';
        surQues.Business__c = 'All Business Units';
        surQues.CategoryScope__c = 'All Categories'; 
        surQues.Frequency__c ='1';
        surQues.GeoScope__c = 'All Markets';
        surQues.IsActive__c = True; 
        surQues.Is_Translated__c = true;
        surQues.IsRequired__c = True;
      //  surQues.MaxScore__c = 1;
        surQues.OperationalType__c = 'Picklist';
      //  surQues.Question_Bank__c = 'Atos_123';
        surQues.Parent_Survey_Question__c = 'Atos_SurvQues123'; 
      //  surQues.PIData__c = lstPIDefObj[0].Id;
        surQues.PIDefinition__c = 'Atos_testPI';
        surQues.PIType__c = 'Atos_Test_PI';
        surQues.BUScope__c = 'All Products';
        surQues.QuestionAbbreviation__c = 'test123';
        surQues.QuestionLabel__c = 'Atos_test_QB123';
        surQues.SurveyQueHeaderandSurveyQue__c = 'Test@123'; 
        surQues.SurveyQuestion__c = 'SurvQues12';
       // surQues.CreatedBy = 'u.Id';
       // surQues.LastModifiedBy = 'u.Id';
        insert surQues; 
           
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
            lstPIDefObj[i].LifecycleStage__c= 'Pilot';
            lstPIDefObj[i].PIUploadDuedate__c = Date.newinstance(2020,01,15);
        }
        update lstPIDefObj;
        surQues.PIData__c = lstPIDefObj[0].Id;
        update surQues;  
                              
        List<SPE_Spend__c> spendList = new List<SPE_Spend__c>();
        for(integer i=0;i<10;i++){
            SPE_Spend__c spend =new SPE_Spend__c();
            spend.Region__c = 'IND';
            spend.Sub_Region__c= 'IND MX';
            spend.Country__c = 'IND C';
            spend.Project__c = 'INDP';             
            spend.CategoryArea__c= 'IP';
            spend.CategoryGroup__c = 'IP GP';
            spend.Category__c = 'IP CG';                
            spend.Business_Line__c ='PROD PROC';
            spend.Business_Unit__c='PROD BL';
            spend.Product__c = 'PROD RT';
            spend.Period__c=Date.newInstance(2016,10,20);
            spend.Spend__c= 2;
            spend.SPEPeriod__c= 'test';
            spend.EnterpriseId__c= acc1.id;
            spendList.add(spend);
        }
        insert spendList;   
                  
        List<Business_System_Role__c> BusinessroleList = new List<Business_System_Role__c>(); 
        Business_System_Role__c businessystrole = new Business_System_Role__c();
        businessystrole.name = 'Standalone Survey';
        businessystrole.Object_Name__c = 'Standalone Survey';
        businessystrole.Business_Role__c ='Category Manager';
        businessystrole.System_Role__c ='Survey Respondent';
        BusinessroleList.add(businessystrole); 
        insert BusinessroleList;
                
        List<SPE_CategoryInfo__c> catInfoList = new List<SPE_CategoryInfo__c>();
        for(integer i=0 ;i<=51; i++){
            SPE_CategoryInfo__c catInfo = new SPE_CategoryInfo__c();
            catInfo.Business_Role__c ='Category Manager';
            catInfo.System_Role__c ='Survey Respondent';
            catInfo.Contact__c = con.id;
            catInfo.CategoryScopeCombination__c = 'IND'+';'+'IND MX'+';'+'IND C'+';'+'INDP'+';'+'IP'+';'+'IP GP'+';'+'IP CG'+';'+'PROD PROC'+';'+'PROD BL'+';'+'PROD RT';
            catInfo.Supplier__c =acc1.id;
            catInfo.Region__c = 'IND';
            catInfo.SubRegion__c = 'IND MX';
            catInfo.Country__c = 'IND C';
            catInfo.Project__c = 'INDP';              
            catInfo.CategoryCluster__c = 'IP';
            catInfo.CategoryGroup__c = 'IP GP';
            catInfo.Category__c = 'IP CG';                
            catInfo.BusinessLine__c ='PROD PROC';
            catInfo.BusinessUnit__c ='PROD BL';
            catInfo.Product__c = 'PROD RT';
            catInfoList.add(catInfo);
        }
        insert catInfoList;
       
        List<SPE2Survey__c> lstsurvey = new List<SPE2Survey__c>(); 
        for(Integer i=0;i<10;i++){                 
            SPE2Survey__c speSurvey = new SPE2Survey__c();
            speSurvey.Market__c = 'IND';
            speSurvey.MarketUnit__c = 'IND MX';
            speSurvey.Country__c = 'IND C';
            speSurvey.Project__c = 'INDP';             
            speSurvey.CategoryArea__c= 'IP';
            speSurvey.CategoryGroup__c = 'IP GP';
            speSurvey.Category__c = 'IP CG';                
            speSurvey.BusinessLine__c ='PROD PROC';
            speSurvey.BusinessUnit__c ='PROD BL';
            speSurvey.Product__c = 'PROD RT';
            speSurvey.Additional_Days__c = 2;
            speSurvey.Additional_Days_for_week__c = 2;
            speSurvey.Day_name_of_upload_week__c = 'Sunday';
            speSurvey.EndDate__c = Date.newInstance(2016, 8, 17);
            speSurvey.FrequencyInMonths__c = '1';
            speSurvey.Is_One_Time_Survey__c =  True;
            speSurvey.Month_Upload_Day__c = 7;
            speSurvey.Recurrence_frequency_type__c = 'Monthly';
            speSurvey.Recurrence_Pattern__c = 'DayPerMonth';
            speSurvey.Stage__c = 'Draft';
            speSurvey.SurveyReminderBeforeExecutionDate__c = 1;
            speSurvey.SurveyExecutionBeforeIndays__c = 1;
            speSurvey.StartDate__c = Date.newInstance(2016,8,15);
            speSurvey.Survey_Shut_Down__c = 1;
            speSurvey.Upload_Day__c = 2;
            speSurvey.Week_Count__c = 'First';
            speSurvey.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
            speSurvey.Yearly_Week_Count__c = 'Second';  
            lstsurvey.add(speSurvey);   
           }  
         insert lstsurvey;
        
        List<SPE2_SurveySupplierMap__c> survMaplst = new  List<SPE2_SurveySupplierMap__c>();
        for(Integer i=0 ;i<=10;i++){
            SPE2_SurveySupplierMap__c survmap = new SPE2_SurveySupplierMap__c();
            survmap.SPE2_Survey__c= lstsurvey[0].id;
            survmap.Supplier__c = acc1.id;
            survMaplst.add(survmap);
          }  
        insert survMaplst; 
         
        SPE2_Survey_Respondents__c surResp = new SPE2_Survey_Respondents__c();
        surResp.Contact__c = con.Id;
        surResp.Survey__c = lstsurvey[0].Id;
        insert surResp;
        
        List<SPE2_Question_Survey_Association__c> lstquesAssoc = new List<SPE2_Question_Survey_Association__c>(); 
        for(Integer i=0;i<10;i++){        
            SPE2_Question_Survey_Association__c quesAssoc = new SPE2_Question_Survey_Association__c();
            quesAssoc.AnswerType__c = 'FreeText';
            quesAssoc.Is_Active__c = true;
            quesAssoc.Is_Required__c = true;
            quesAssoc.PIData__c = lstPIDefObj[0].Id;
            quesAssoc.PIFrequency__c = '1';
            quesAssoc.Question_Bank__c = surQues.Id;
            quesAssoc.QuestionID__c = 'Q-1234';
            quesAssoc.QuestionLabel__c = 'TestQuestion';
            quesAssoc.SurveyRespondent__c = surResp.Id;
            quesAssoc.Supplier__c = acc1.Id;
            quesAssoc.Survey__c = lstsurvey[0].Id;
            quesAssoc.SurveyQuestion__c = 'surQues';
            lstquesAssoc.add(quesAssoc);
        }
        insert lstquesAssoc; 
                              
        Test.startTest();
        PageReference pg = Page.SPE2_AddSurveyRespondent_new;
        system.Test.setCurrentPage(pg);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(lstsurvey[0]);        
        SPE2_AddSurveyRespondent_new_ext.SupplierWrapper SW = new SPE2_AddSurveyRespondent_new_ext.SupplierWrapper();
        SW.isSelected = true;
        
        SPE2_AddSurveyRespondent_new_ext obj = new SPE2_AddSurveyRespondent_new_ext(sc);
        Apexpages.currentpage().getparameters().put('planIdentifier','planIdentifier');
        Apexpages.currentPage().getParameters().put('crntPageNum','1');      
        Apexpages.currentPage().getParameters().put('contactName','Test');  
        obj.getBusinessList();
        obj.getSystemList();
        obj.closePopup();
        obj.showPopup();
        obj.savecontact();
        obj.closePopup2();
        obj.showPopup2();
        obj.savecontact2();
        obj.con = con1;
        obj.savecontact();
        obj.DEFAULT_PAGE_SIZE = 10;
        obj.pageNumber = 1;
        obj.showInternalContactOnly();        
        obj.contactName = con.lastname;   
        obj.firstBtnClick();
        obj.nextBtnClick();
        obj.previousBtnClick();
        obj.lastBtnClick();
        obj.goToPage();
        obj.goToSearchPage();
        obj.searchSuppliers();
        obj.searchInternalContact();
        obj.returnbackToPlan();
        obj.firstBtnClick2();
        obj.nextBtnClick2();
        obj.previousBtnClick2();
       // obj.lastBtnClick2();
        obj.goToPage2();
        obj.AddToPlans();
       // obj.AddToPlans2();
        Test.stopTest(); 
        }
    }
 }