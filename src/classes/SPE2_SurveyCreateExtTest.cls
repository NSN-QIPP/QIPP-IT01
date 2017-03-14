@IsTest(SeeAllData=False)

public class SPE2_SurveyCreateExtTest

{

    static testmethod void TestSPE2_SurveyCreateExt1()
    {
        
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
        
        SPE2Survey__c SurDefObj = new SPE2Survey__c();
        SurDefObj.Additional_Days__c = 2;
        SurDefObj.Additional_Days_for_week__c = 2;
        SurDefObj.BusinessLine__c = 'All Business Lines';
        SurDefObj.BusinessUnit__c = 'All Business Units';
        SurDefObj.Category__c = 'All Categories';
        SurDefObj.CategoryArea__c = 'All Category Areas';
        SurDefObj.CategoryGroup__c = 'All Category Groups';
        SurDefObj.Country__c = 'All Countries';
        SurDefObj.Day_name_of_upload_week__c = 'Sunday';
        SurDefObj.EndDate__c = Date.newInstance(2017, 8, 17);
        SurDefObj.FrequencyInMonths__c = '1';
        SurDefObj.Is_One_Time_Survey__c = True; 
        SurDefObj.Market__c = 'All Markets';
        SurDefObj.MarketUnit__c = 'All Market Units';
        SurDefObj.Month_Upload_Day__c = null;
        SurDefObj.Product__c = 'All Products';
        SurDefObj.Project__c = 'All Projects';
        SurDefObj.Recurrence_frequency_type__c = 'Monthly';
        SurDefObj.Recurrence_Pattern__c = 'DayPerMonth';
        SurDefObj.Stage__c = 'Draft';
        SurDefObj.SurveyReminderBeforeExecutionDate__c = 1;
        SurDefObj.SurveyExecutionBeforeIndays__c = 1;
        SurDefObj.StartDate__c = Date.newInstance(2017, 8, 15);
        SurDefObj.Survey_Shut_Down__c = 1;
        SurDefObj.Upload_Day__c = 2;
        SurDefObj.Week_Count__c = 'First';
        SurDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
        SurDefObj.Yearly_Week_Count__c = 'Second';
        
        insert SurDefObj;
        
        PageReference pageRef = Page.SPE2_SurveyCreate;
        Test.setCurrentPage(pageRef);  
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(SurDefObj);
        SPE2_SurveyCreateExt surRec = new SPE2_SurveyCreateExt(stcon);
        surRec.getFrequencyTypes();
        surRec.getWeekCountList();
        surRec.getweekDays();
        surRec.getMonthList();
        surRec.displayRecurrence();
        surRec.closePopup();
        surRec.SaveCustom();
        surRec.getMarketValues();
        surRec.getMarketUnitValues();
        surRec.fillMarketUnit();
        surRec.getCountryValues();
        surRec.fillCountry();
        surRec.getProjectValues();
        surRec.fillProject();
        surRec.getBusinessUnitValues();
        surRec.getBusinesLineValues();
        surRec.fillBusinessLine();
        surRec.getProductValues();
        surRec.showProdVals();
        surRec.fillProduct();
        surRec.getCategoryAreaValues();
        surRec.getCategoryGroupValues();
        surRec.fillCategoryGroup();
        surRec.getCategoryValues();
        surRec.fillCategory();
        surRec.blankMethod();
        surRec.save();
        //surRec.createSPETracker(SurDefObj, True);
        surRec.generateTracker();
        
    }
      static testmethod void TestSPE2_SurveyCreateExt2()
    {
        
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
        
        SPE2Survey__c SurDefObj = new SPE2Survey__c();
        SurDefObj.Additional_Days__c = 2;
        SurDefObj.Additional_Days_for_week__c = 2;
        SurDefObj.BusinessLine__c = 'All Business Lines';
        SurDefObj.BusinessUnit__c = 'All Business Units';
        SurDefObj.Category__c = 'All Categories';
        SurDefObj.CategoryArea__c = 'All Category Areas';
        SurDefObj.CategoryGroup__c = 'All Category Groups';
        SurDefObj.Country__c = 'All Countries';
        SurDefObj.Day_name_of_upload_week__c = 'Sunday';
        SurDefObj.EndDate__c = Date.newInstance(2017, 8, 17);
        SurDefObj.FrequencyInMonths__c = '';
        SurDefObj.Is_One_Time_Survey__c = False; 
        SurDefObj.Market__c = 'All Markets';
        SurDefObj.MarketUnit__c = 'All Market Units';
        SurDefObj.Month_Upload_Day__c = 7;
        SurDefObj.Product__c = 'All Products';
        SurDefObj.Project__c = 'All Projects';
        SurDefObj.Recurrence_frequency_type__c = 'Monthly';
        SurDefObj.Recurrence_Pattern__c = 'WeekPerMonth';
        SurDefObj.Stage__c = 'Draft';
        SurDefObj.SurveyReminderBeforeExecutionDate__c = 1;
        SurDefObj.SurveyExecutionBeforeIndays__c = 1;
        SurDefObj.StartDate__c = Date.newInstance(2017, 8, 15);
        SurDefObj.Survey_Shut_Down__c = 1;
        SurDefObj.Upload_Day__c = 2;
        SurDefObj.Week_Count__c = 'First';
        SurDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
        SurDefObj.Yearly_Week_Count__c = 'Second';
        
        insert SurDefObj;
        
        PageReference pageRef = Page.SPE2_SurveyCreate;
        Test.setCurrentPage(pageRef);  
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(SurDefObj);
        SPE2_SurveyCreateExt surRec = new SPE2_SurveyCreateExt(stcon);
        surRec.getFrequencyTypes();
        surRec.getWeekCountList();
        surRec.getweekDays();
        surRec.getMonthList();
        surRec.displayRecurrence();
        surRec.closePopup();
        surRec.SaveCustom();
        surRec.getMarketValues();
        surRec.getMarketUnitValues();
        surRec.fillMarketUnit();
        surRec.getCountryValues();
        surRec.fillCountry();
        surRec.getProjectValues();
        surRec.fillProject();
        surRec.getBusinessUnitValues();
        surRec.getBusinesLineValues();
        surRec.fillBusinessLine();
        surRec.getProductValues();
        surRec.showProdVals();
        surRec.fillProduct();
        surRec.getCategoryAreaValues();
        surRec.getCategoryGroupValues();
        surRec.fillCategoryGroup();
        surRec.getCategoryValues();
        surRec.fillCategory();
        surRec.blankMethod();
        //surRec.save();
        //surRec.createSPETracker(SurDefObj, True);
        //surRec.generateTracker();
        
    }  
        
        static testmethod void TestSPE2_SurveyCreateExt3()
    {
        
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
        
        SPE2Survey__c SurDefObj = new SPE2Survey__c();
        SurDefObj.Additional_Days__c = 2;
        SurDefObj.Additional_Days_for_week__c = 2;
        SurDefObj.BusinessLine__c = 'All Business Lines';
        SurDefObj.BusinessUnit__c = 'All Business Units';
        SurDefObj.Category__c = 'All Categories';
        SurDefObj.CategoryArea__c = 'All Category Areas';
        SurDefObj.CategoryGroup__c = 'All Category Groups';
        SurDefObj.Country__c = 'All Countries';
        SurDefObj.Day_name_of_upload_week__c = 'Sunday';
        SurDefObj.EndDate__c = Date.newInstance(2017, 8, 17);
        SurDefObj.FrequencyInMonths__c = '1';
        SurDefObj.Is_One_Time_Survey__c = True; 
        SurDefObj.Market__c = 'All Markets';
        SurDefObj.MarketUnit__c = 'All Market Units';
        SurDefObj.Month_Upload_Day__c = 7;
        SurDefObj.Product__c = 'All Products';
        SurDefObj.Project__c = 'All Projects';
        SurDefObj.Recurrence_frequency_type__c = 'Monthly';
        SurDefObj.Recurrence_Pattern__c = 'DayPerYear';
        SurDefObj.Stage__c = 'Draft';
        SurDefObj.SurveyReminderBeforeExecutionDate__c = 1;
        SurDefObj.SurveyExecutionBeforeIndays__c = 1;
        SurDefObj.StartDate__c = Date.newInstance(2017, 8, 15);
        SurDefObj.Survey_Shut_Down__c = 1;
        SurDefObj.Upload_Day__c = 2;
        SurDefObj.Week_Count__c = 'First';
        SurDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
        SurDefObj.Yearly_Week_Count__c = 'Second';
        
        insert SurDefObj;
        
        PageReference pageRef = Page.SPE2_SurveyCreate;
        Test.setCurrentPage(pageRef);  
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(SurDefObj);
        SPE2_SurveyCreateExt surRec = new SPE2_SurveyCreateExt(stcon);
        surRec.getFrequencyTypes();
        surRec.getWeekCountList();
        surRec.getweekDays();
        surRec.getMonthList();
        surRec.displayRecurrence();
        surRec.closePopup();
        surRec.SaveCustom();
        surRec.getMarketValues();
        surRec.getMarketUnitValues();
        surRec.fillMarketUnit();
        surRec.getCountryValues();
        surRec.fillCountry();
        surRec.getProjectValues();
        surRec.fillProject();
        surRec.getBusinessUnitValues();
        surRec.getBusinesLineValues();
        surRec.fillBusinessLine();
        surRec.getProductValues();
        surRec.showProdVals();
        surRec.fillProduct();
        surRec.getCategoryAreaValues();
        surRec.getCategoryGroupValues();
        surRec.fillCategoryGroup();
        surRec.getCategoryValues();
        surRec.fillCategory();
        surRec.blankMethod();
        surRec.save();
        //surRec.createSPETracker(SurDefObj, True);
        surRec.generateTracker();
        
    }  
        static testmethod void TestSPE2_SurveyCreateExt4()
    {
        
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
        
        SPE2Survey__c SurDefObj = new SPE2Survey__c();
        SurDefObj.Additional_Days__c = 2;
        SurDefObj.Additional_Days_for_week__c = 2;
        SurDefObj.BusinessLine__c = 'All Business Lines';
        SurDefObj.BusinessUnit__c = 'All Business Units';
        SurDefObj.Category__c = 'All Categories';
        SurDefObj.CategoryArea__c = 'All Category Areas';
        SurDefObj.CategoryGroup__c = 'All Category Groups';
        SurDefObj.Country__c = 'All Countries';
        SurDefObj.Day_name_of_upload_week__c = 'Sunday';
        SurDefObj.EndDate__c = Date.newInstance(2017, 8, 17);
        SurDefObj.FrequencyInMonths__c = '1';
        SurDefObj.Is_One_Time_Survey__c = false; 
        SurDefObj.Market__c = 'All Markets';
        SurDefObj.MarketUnit__c = 'All Market Units';
        SurDefObj.Month_Upload_Day__c = 7;
        SurDefObj.Product__c = 'All Products';
        SurDefObj.Project__c = 'All Projects';
        SurDefObj.Recurrence_frequency_type__c = 'Monthly';
        SurDefObj.Recurrence_Pattern__c = 'WeekPerYear';
        SurDefObj.Stage__c = 'Published';
        SurDefObj.SurveyReminderBeforeExecutionDate__c = 1;
        SurDefObj.SurveyExecutionBeforeIndays__c = 1;
        SurDefObj.StartDate__c = Date.newInstance(2017, 8, 15);
        SurDefObj.Survey_Shut_Down__c = 1;
        SurDefObj.Upload_Day__c = 2;
        SurDefObj.Week_Count__c = 'First';
        SurDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
        SurDefObj.Yearly_Week_Count__c = 'Second';
        
        insert SurDefObj;
        
        ApexPages.currentPage().getParameters().put('countryVal','countryVal');
        ApexPages.currentPage().getParameters().put('isClone','abcd');
        //ApexPages.currentPage().getParameters().put('Clone',true);
        //Apexpages.currentPage().getParameters().get('countryVal');
        PageReference pageRef = Page.SPE2_SurveyCreate;
        Test.setCurrentPage(pageRef);  
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(SurDefObj);
        SPE2_SurveyCreateExt surRec = new SPE2_SurveyCreateExt(stcon);
        surRec.getFrequencyTypes();
        surRec.getWeekCountList();
        surRec.getweekDays();
        surRec.getMonthList();
        surRec.displayRecurrence();
        surRec.closePopup();
        surRec.SaveCustom();
        surRec.getMarketValues();
        surRec.getMarketUnitValues();
        surRec.fillMarketUnit();
        surRec.getCountryValues();
        surRec.fillCountry();
        surRec.getProjectValues();
        surRec.fillProject();
        surRec.getBusinessUnitValues();
        surRec.getBusinesLineValues();
        surRec.fillBusinessLine();
        surRec.getProductValues();
        surRec.showProdVals();
        surRec.fillProduct();
        surRec.getCategoryAreaValues();
        surRec.getCategoryGroupValues();
        surRec.fillCategoryGroup();
        surRec.getCategoryValues();
        surRec.fillCategory();
        surRec.blankMethod();
        surRec.save();
        //surRec.createSPETracker(SurDefObj, True);
        surRec.generateTracker();
        surRec.DatePattern();
        surRec.DisplaySaveCancelButton();
        
    }
        
        static testmethod void TestSPE2_SurveyCreateExt5()
    {
        
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
        
        SPE2Survey__c SurDefObj = new SPE2Survey__c();
        SurDefObj.Additional_Days__c = 2;
        SurDefObj.Additional_Days_for_week__c = 2;
        SurDefObj.BusinessLine__c = 'All Business Lines';
        SurDefObj.BusinessUnit__c = 'All Business Units';
        SurDefObj.Category__c = 'All Categories';
        SurDefObj.CategoryArea__c = 'All Category Areas';
        SurDefObj.CategoryGroup__c = 'All Category Groups';
        SurDefObj.Country__c = 'All Countries';
        SurDefObj.Day_name_of_upload_week__c = 'Sunday';
        SurDefObj.EndDate__c = Date.newInstance(2017, 8, 17);
        SurDefObj.FrequencyInMonths__c = '1';
        SurDefObj.Is_One_Time_Survey__c = True; 
        SurDefObj.Market__c = 'All Markets';
        SurDefObj.MarketUnit__c = 'All Market Units';
        SurDefObj.Month_Upload_Day__c = 7;
        SurDefObj.Product__c = 'All Products';
        SurDefObj.Project__c = 'All Projects';
        SurDefObj.Recurrence_frequency_type__c = 'Monthly';
        SurDefObj.Recurrence_Pattern__c = 'DayPerMonth';
        SurDefObj.Stage__c = 'Draft';
        SurDefObj.SurveyReminderBeforeExecutionDate__c = 1;
        SurDefObj.SurveyExecutionBeforeIndays__c = 1;
        SurDefObj.StartDate__c = Date.newInstance(2017, 8, 15);
        SurDefObj.Survey_Shut_Down__c = 1;
        SurDefObj.Upload_Day__c = 2;
        SurDefObj.Week_Count__c = 'First';
        SurDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
        SurDefObj.Yearly_Week_Count__c = 'Second';
        
        insert SurDefObj;
        
        PageReference pageRef = Page.SPE2_SurveyCreate;
        Test.setCurrentPage(pageRef);  
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(new SPE2Survey__c());
        SPE2_SurveyCreateExt surRec = new SPE2_SurveyCreateExt(stcon);
        surRec.getFrequencyTypes();
        surRec.getWeekCountList();
        surRec.getweekDays();
        surRec.getMonthList();
        surRec.displayRecurrence();
        surRec.closePopup();
        surRec.SaveCustom();
        surRec.getMarketValues();
        surRec.getMarketUnitValues();
        surRec.fillMarketUnit();
        surRec.getCountryValues();
        surRec.fillCountry();
        surRec.getProjectValues();
        surRec.fillProject();
        surRec.getBusinessUnitValues();
        surRec.getBusinesLineValues();
        surRec.fillBusinessLine();
        surRec.getProductValues();
        surRec.showProdVals();
        surRec.fillProduct();
        surRec.getCategoryAreaValues();
        surRec.getCategoryGroupValues();
        surRec.fillCategoryGroup();
        surRec.getCategoryValues();
        surRec.fillCategory();
        surRec.blankMethod();
        surRec.save();
        //surRec.createSPETracker(SurDefObj, True);
        //surRec.generateTracker();
        
    }
        static testmethod void TestSPE2_SurveyCreateExt6()
    {
        
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
        
        SPE2Survey__c SurDefObj = new SPE2Survey__c();
        SurDefObj.Additional_Days__c = 2;
        SurDefObj.Additional_Days_for_week__c = 2;
        SurDefObj.BusinessLine__c = 'All Business Lines';
        SurDefObj.BusinessUnit__c = 'All Business Units';
        SurDefObj.Category__c = 'All Categories';
        SurDefObj.CategoryArea__c = 'All Category Areas';
        SurDefObj.CategoryGroup__c = 'All Category Groups';
        SurDefObj.Country__c = 'All Countries';
        SurDefObj.Day_name_of_upload_week__c = 'Sunday';
        SurDefObj.EndDate__c = Date.newInstance(2017, 9, 17);
        SurDefObj.FrequencyInMonths__c = '1' ;
        SurDefObj.Is_One_Time_Survey__c = False; 
        SurDefObj.Market__c = 'All Markets';
        SurDefObj.MarketUnit__c = 'All Market Units';
        SurDefObj.Month_Upload_Day__c = 7;
        SurDefObj.Product__c = 'All Products';
        SurDefObj.Project__c = 'All Projects';
        SurDefObj.Recurrence_frequency_type__c = 'Monthly';
        SurDefObj.Recurrence_Pattern__c = 'DayPerMonth';
        SurDefObj.Stage__c = 'Draft';
        SurDefObj.SurveyReminderBeforeExecutionDate__c = 1;
        SurDefObj.SurveyExecutionBeforeIndays__c = 1;
        SurDefObj.StartDate__c = Date.newInstance(2017, 8, 15);
        SurDefObj.Survey_Shut_Down__c = 1;
        SurDefObj.Upload_Day__c = 2;
        SurDefObj.Week_Count__c = 'First';
        SurDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
        SurDefObj.Yearly_Week_Count__c = 'Second';
        
        insert SurDefObj;
        
        PageReference pageRef = Page.SPE2_SurveyCreate;
        Test.setCurrentPage(pageRef);  
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(SurDefObj);
        SPE2_SurveyCreateExt surRec = new SPE2_SurveyCreateExt(stcon);
        surRec.getFrequencyTypes();
        surRec.getWeekCountList();
        surRec.getweekDays();
        surRec.getMonthList();
        surRec.displayRecurrence();
        surRec.closePopup();
        surRec.SaveCustom();
        surRec.getMarketValues();
        surRec.getMarketUnitValues();
        surRec.fillMarketUnit();
        surRec.getCountryValues();
        surRec.fillCountry();
        surRec.getProjectValues();
        surRec.fillProject();
        surRec.getBusinessUnitValues();
        surRec.getBusinesLineValues();
        surRec.fillBusinessLine();
        surRec.getProductValues();
        surRec.showProdVals();
        surRec.fillProduct();
        surRec.getCategoryAreaValues();
        surRec.getCategoryGroupValues();
        surRec.fillCategoryGroup();
        surRec.getCategoryValues();
        surRec.fillCategory();
        surRec.blankMethod();
        //surRec.save();
        //surRec.createSPETracker(SurDefObj, True);
        //surRec.generateTracker();
        
    }  
    static testmethod void TestSPE2_SurveyCreateExt7()
    {
        
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
        
        SPE2Survey__c SurDefObj = new SPE2Survey__c();
        SurDefObj.Additional_Days__c = 2;
        SurDefObj.Additional_Days_for_week__c = 2;
        SurDefObj.BusinessLine__c = 'All Business Lines';
        SurDefObj.BusinessUnit__c = 'All Business Units';
        SurDefObj.Category__c = 'All Categories';
        SurDefObj.CategoryArea__c = 'All Category Areas';
        SurDefObj.CategoryGroup__c = 'All Category Groups';
        SurDefObj.Country__c = 'All Countries';
        SurDefObj.Day_name_of_upload_week__c = 'Sunday';
        SurDefObj.EndDate__c = Date.newInstance(2017, 8, 17);
        SurDefObj.FrequencyInMonths__c = '1' ;
        SurDefObj.Is_One_Time_Survey__c = False; 
        SurDefObj.Market__c = 'All Markets';
        SurDefObj.MarketUnit__c = 'All Market Units';
        SurDefObj.Month_Upload_Day__c = 7;
        SurDefObj.Product__c = 'All Products';
        SurDefObj.Project__c = 'All Projects';
        SurDefObj.Recurrence_frequency_type__c = 'Yearly';
        SurDefObj.Recurrence_Pattern__c = 'DayPerYear';
        SurDefObj.Stage__c = 'Draft';
        SurDefObj.SurveyReminderBeforeExecutionDate__c = 1;
        SurDefObj.SurveyExecutionBeforeIndays__c = 1;
        SurDefObj.StartDate__c = Date.newInstance(2017, 8, 15);
        SurDefObj.Survey_Shut_Down__c = 1;
        SurDefObj.Upload_Day__c = 2;
        SurDefObj.Week_Count__c = 'First';
        SurDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
        SurDefObj.Yearly_Week_Count__c = 'Second';
        
        insert SurDefObj;
        
        PageReference pageRef = Page.SPE2_SurveyCreate;
        Test.setCurrentPage(pageRef);  
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(SurDefObj);
        SPE2_SurveyCreateExt surRec = new SPE2_SurveyCreateExt(stcon);
        surRec.getFrequencyTypes();
        surRec.getWeekCountList();
        surRec.getweekDays();
        surRec.getMonthList();
        surRec.displayRecurrence();
        surRec.closePopup();
        //surRec.SaveCustom();
        surRec.getMarketValues();
        surRec.getMarketUnitValues();
        surRec.fillMarketUnit();
        surRec.getCountryValues();
        surRec.fillCountry();
        surRec.getProjectValues();
        surRec.fillProject();
        surRec.getBusinessUnitValues();
        surRec.getBusinesLineValues();
        surRec.fillBusinessLine();
        surRec.getProductValues();
        surRec.showProdVals();
        surRec.fillProduct();
        surRec.getCategoryAreaValues();
        surRec.getCategoryGroupValues();
        surRec.fillCategoryGroup();
        surRec.getCategoryValues();
        surRec.fillCategory();
        surRec.blankMethod();
        //surRec.save();
        //surRec.createSPETracker(SurDefObj, True);
        surRec.generateTracker();
        
    }  
    static testmethod void TestSPE2_SurveyCreateExt8()
    {
        
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
        
        SPE2Survey__c SurDefObj = new SPE2Survey__c();
        SurDefObj.Additional_Days__c = 2;
        SurDefObj.Additional_Days_for_week__c = 2;
        SurDefObj.BusinessLine__c = 'All Business Lines';
        SurDefObj.BusinessUnit__c = 'All Business Units';
        SurDefObj.Category__c = 'All Categories';
        SurDefObj.CategoryArea__c = 'All Category Areas';
        SurDefObj.CategoryGroup__c = 'All Category Groups';
        SurDefObj.Country__c = 'All Countries';
        //SurDefObj.Day_name_of_upload_week__c = 'Sunday';
        SurDefObj.EndDate__c = Date.newInstance(2017, 8, 17);
        SurDefObj.FrequencyInMonths__c = '1' ;
        SurDefObj.Is_One_Time_Survey__c = False; 
        SurDefObj.Market__c = 'All Markets';
        SurDefObj.MarketUnit__c = 'All Market Units';
        SurDefObj.Month_Upload_Day__c = 7;
        SurDefObj.Product__c = 'All Products';
        SurDefObj.Project__c = 'All Projects';
        SurDefObj.Recurrence_frequency_type__c = 'Yearly';
        SurDefObj.Recurrence_Pattern__c = 'DayPerYear';
        SurDefObj.Stage__c = 'Draft';
        SurDefObj.SurveyReminderBeforeExecutionDate__c = 1;
        SurDefObj.SurveyExecutionBeforeIndays__c = 1;

        SurDefObj.Survey_Shut_Down__c = 1;
        SurDefObj.Upload_Day__c = 2;
        //SurDefObj.Week_Count__c = 'First';
        SurDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
        SurDefObj.Yearly_Week_Count__c = 'Second';
        SurDefObj.Month_Value__c = 'January';
        
        insert SurDefObj;
        
        PageReference pageRef = Page.SPE2_SurveyCreate;
        Test.setCurrentPage(pageRef);  
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(SurDefObj);
        SPE2_SurveyCreateExt surRec = new SPE2_SurveyCreateExt(stcon);
        surRec.getFrequencyTypes();
        surRec.getWeekCountList();
        surRec.getweekDays();
        surRec.getMonthList();
        surRec.displayRecurrence();
        surRec.closePopup();
        surRec.SaveCustom();
        surRec.getMarketValues();
        surRec.getMarketUnitValues();
        surRec.fillMarketUnit();
        surRec.getCountryValues();
        surRec.fillCountry();
        surRec.getProjectValues();
        surRec.fillProject();
        surRec.getBusinessUnitValues();
        surRec.getBusinesLineValues();
        surRec.fillBusinessLine();
        surRec.getProductValues();
        surRec.showProdVals();
        surRec.fillProduct();
        surRec.getCategoryAreaValues();
        surRec.getCategoryGroupValues();
        surRec.fillCategoryGroup();
        surRec.getCategoryValues();
        surRec.fillCategory();
        surRec.blankMethod();
        //surRec.save();
        //surRec.createSPETracker(SurDefObj, True);
        surRec.generateTracker();
        
    }  
    static testmethod void TestSPE2_SurveyCreateExt9()
    {
        
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
        
        SPE2Survey__c SurDefObj = new SPE2Survey__c();
        SurDefObj.Additional_Days__c = 2;
        SurDefObj.Additional_Days_for_week__c = 2;
        SurDefObj.BusinessLine__c = 'All Business Lines';
        SurDefObj.BusinessUnit__c = 'All Business Units';
        SurDefObj.Category__c = 'All Categories';
        SurDefObj.CategoryArea__c = 'All Category Areas';
        SurDefObj.CategoryGroup__c = 'All Category Groups';
        SurDefObj.Country__c = 'All Countries';
        //SurDefObj.Day_name_of_upload_week__c = 'Sunday';
        SurDefObj.EndDate__c = Date.newInstance(2017, 8, 17);
        SurDefObj.FrequencyInMonths__c = '1' ;
        SurDefObj.Is_One_Time_Survey__c = False; 
        SurDefObj.Market__c = 'All Markets';
        SurDefObj.MarketUnit__c = 'All Market Units';
        SurDefObj.Month_Upload_Day__c = 7;
        SurDefObj.Product__c = 'All Products';
        SurDefObj.Project__c = 'All Projects';
        SurDefObj.Recurrence_frequency_type__c = 'Yearly';
        SurDefObj.Recurrence_Pattern__c = 'WeekPerYear';
        SurDefObj.Stage__c = 'Draft';
        SurDefObj.SurveyReminderBeforeExecutionDate__c = 1;
        SurDefObj.SurveyExecutionBeforeIndays__c = 1;
        SurDefObj.StartDate__c = Date.newInstance(2017, 8, 15);
        SurDefObj.Survey_Shut_Down__c = 1;
        SurDefObj.Upload_Day__c = 2;
        //SurDefObj.Week_Count__c = 'First';
        SurDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
        SurDefObj.Yearly_Week_Count__c = 'First';
        SurDefObj.Month_Value__c = 'January';
        
        insert SurDefObj;
        
        PageReference pageRef = Page.SPE2_SurveyCreate;
        Test.setCurrentPage(pageRef);  
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(SurDefObj);
        SPE2_SurveyCreateExt surRec = new SPE2_SurveyCreateExt(stcon);
        surRec.getFrequencyTypes();
        surRec.getWeekCountList();
        surRec.getweekDays();
        surRec.getMonthList();
        surRec.displayRecurrence();
        surRec.closePopup();
        surRec.SaveCustom();
        surRec.getMarketValues();
        surRec.getMarketUnitValues();
        surRec.fillMarketUnit();
        surRec.getCountryValues();
        surRec.fillCountry();
        surRec.getProjectValues();
        surRec.fillProject();
        surRec.getBusinessUnitValues();
        surRec.getBusinesLineValues();
        surRec.fillBusinessLine();
        surRec.getProductValues();
        surRec.showProdVals();
        surRec.fillProduct();
        surRec.getCategoryAreaValues();
        surRec.getCategoryGroupValues();
        surRec.fillCategoryGroup();
        surRec.getCategoryValues();
        surRec.fillCategory();
        surRec.blankMethod();
        //surRec.save();
        //surRec.createSPETracker(SurDefObj, True);
        surRec.generateTracker();
        
    }  
    static testmethod void TestSPE2_SurveyCreateExt10()
    {
        
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
        
        SPE2Survey__c SurDefObj = new SPE2Survey__c();
        SurDefObj.Additional_Days__c = 2;
        SurDefObj.Additional_Days_for_week__c = 2;
        SurDefObj.BusinessLine__c = 'All Business Lines';
        SurDefObj.BusinessUnit__c = 'All Business Units';
        SurDefObj.Category__c = 'All Categories';
        SurDefObj.CategoryArea__c = 'All Category Areas';
        SurDefObj.CategoryGroup__c = 'All Category Groups';
        SurDefObj.Country__c = 'All Countries';
        //SurDefObj.Day_name_of_upload_week__c = 'Sunday';
        SurDefObj.EndDate__c = Date.newInstance(2017, 8, 17);
        SurDefObj.FrequencyInMonths__c = '1' ;
        SurDefObj.Is_One_Time_Survey__c = False; 
        SurDefObj.Market__c = 'All Markets';
        SurDefObj.MarketUnit__c = 'All Market Units';
        SurDefObj.Month_Upload_Day__c = 7;
        SurDefObj.Product__c = 'All Products';
        SurDefObj.Project__c = 'All Projects';
        SurDefObj.Recurrence_frequency_type__c = 'Yearly';
        SurDefObj.Recurrence_Pattern__c = '';
        SurDefObj.Stage__c = 'Draft';
        SurDefObj.SurveyReminderBeforeExecutionDate__c = 1;
        SurDefObj.SurveyExecutionBeforeIndays__c = 1;
        SurDefObj.StartDate__c = Date.newInstance(2017, 8, 15);
        SurDefObj.Survey_Shut_Down__c = 1;
        SurDefObj.Upload_Day__c = 2;
        //SurDefObj.Week_Count__c = 'First';
        SurDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
        SurDefObj.Yearly_Week_Count__c = 'First';
        SurDefObj.Month_Value__c = 'January';
        
        insert SurDefObj;
        
        PageReference pageRef = Page.SPE2_SurveyCreate;
        Test.setCurrentPage(pageRef);  
        Test.StartTest();
        Apexpages.Standardcontroller stCon =  new Apexpages.Standardcontroller(SurDefObj);
        SPE2_SurveyCreateExt surRec = new SPE2_SurveyCreateExt(stcon);
        surRec.getFrequencyTypes();
        surRec.getWeekCountList();
        surRec.getweekDays();
        surRec.getMonthList();
        surRec.displayRecurrence();
        surRec.closePopup();
        surRec.SaveCustom();
        surRec.getMarketValues();
        surRec.getMarketUnitValues();
        surRec.fillMarketUnit();
        surRec.getCountryValues();
        surRec.fillCountry();
        surRec.getProjectValues();
        surRec.fillProject();
        surRec.getBusinessUnitValues();
        surRec.getBusinesLineValues();
        surRec.fillBusinessLine();
        surRec.getProductValues();
        surRec.showProdVals();
        surRec.fillProduct();
        surRec.getCategoryAreaValues();
        surRec.getCategoryGroupValues();
        surRec.fillCategoryGroup();
        surRec.getCategoryValues();
        surRec.fillCategory();
        surRec.blankMethod();
        //surRec.save();
        //surRec.createSPETracker(SurDefObj, True);
        surRec.generateTracker();
        
    } 
}