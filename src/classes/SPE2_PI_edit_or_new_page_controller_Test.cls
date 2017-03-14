@isTest(SeeAllData=False)
private class SPE2_PI_edit_or_new_page_controller_Test{

 static testmethod void SPE2_PI_edit_or_new_page_controller1(){
    
    
     //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    PIDefObj.PI_Title__c = 'Test PI Definition';  
    PIDefObj.PIAbbreviation__c = 'testPI';
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.UoM__c = 'Number';
    PIDefObj.ValuesType__c = 'Number';
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2050,2,3);
    PIDefObj.Day_name_of_upload_week__c= 'Sunday';
    PIDefObj.End_Date__c = Date.newInstance(2050,5,3);
    PIDefObj.Recurrence_frequency_type__c = 'Monthly';
    PIDefObj.Recurrence_Pattern__c = 'DayPerMonth';
    PIDefObj.Frequency__c = '1';
    PIDefObj.Week_Count__c = 'First';
    PIDefObj.Additional_Days_for_week__c = 3;
    PIDefObj.Upload_Day__c = 5;
    
    PIDefObj.Additional_Days__c = 2;
    PIDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
    PIDefObj.Yearly_Week_Count__c = 'First';
    PIDefObj.Month_Upload_Day__c = 8;
    PIDefObj.Month_Value__c = 'March';
    
    insert PIDefObj;
    
    ApexPages.currentPage().getParameters().put('Id',PIDefObj.Id);  
    //update lifecycle stage
    
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    PIDefObj.OperationalType__c= 'Leading KPI'; 
    update PIDefObj;
    
    Test.StartTest();     
    
    ApexPages.StandardController ctlr = new ApexPages.StandardController(PIDefObj);    
    SPE2_PI_edit_or_new_page_controller piObj = new SPE2_PI_edit_or_new_page_controller(ctlr);
    PageReference pageRef = Page.SPE2_PI_edit_or_new_page;
    Test.setCurrentPage(pageRef);  
    pageRef.getParameters().put('Id',PIDefObj.Id);
    piObj.DisplaySaveCancelButton();
    piObj.getFrequencyTypes();
    piObj.getWeekCountList();
    piObj.getweekDays();
    piObj.getMonthList();
    piObj.DatePattern();
    piObj.pageredir();
    piObj.displayRecurrence();
    piObj.CountinueCustom();
    piObj.SaveCustom();
   
    Test.StopTest();
    
    }
    static testmethod void SPE2_PI_edit_or_new_page_controller2(){
    
    
     //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    PIDefObj.PI_Title__c = 'Test PI Definition1'; 
    PIDefObj.PIAbbreviation__c = 'testPI';  
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.UoM__c = 'Number';
    PIDefObj.ValuesType__c = 'Number';
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2040,2,3);
    PIDefObj.Day_name_of_upload_week__c= 'Monday';
    PIDefObj.End_Date__c = Date.newInstance(2040,5,3);
    PIDefObj.Recurrence_frequency_type__c = 'Monthly';
    PIDefObj.Recurrence_Pattern__c = 'WeekPerMonth';
    PIDefObj.Frequency__c = '2';
    PIDefObj.Week_Count__c = 'First';
    PIDefObj.Additional_Days_for_week__c = 3;
    PIDefObj.Upload_Day__c = 10;
    
    PIDefObj.Additional_Days__c = 7;
    PIDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Monday';
    PIDefObj.Yearly_Week_Count__c = 'First';
    PIDefObj.Month_Upload_Day__c = 8;
    PIDefObj.Month_Value__c = 'March';
    
    insert PIDefObj;
    
    ApexPages.currentPage().getParameters().put('Id',PIDefObj.Id);  
    //update lifecycle stage
    
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    PIDefObj.OperationalType__c= 'Leading KPI'; 
    update PIDefObj;
    
    Test.StartTest();     
    
    ApexPages.StandardController ctlr = new ApexPages.StandardController(PIDefObj);  
    SPE2_PI_edit_or_new_page_controller piObj = new SPE2_PI_edit_or_new_page_controller(ctlr);
    PageReference pageRef = Page.SPE2_PI_edit_or_new_page;
    Test.setCurrentPage(pageRef);  
    pageRef.getParameters().put('Id',PIDefObj.Id);
    piObj.DisplaySaveCancelButton();
    piObj.getFrequencyTypes();
    piObj.getWeekCountList();
    piObj.getweekDays();
    piObj.getMonthList();
    piObj.DatePattern();
    piObj.pageredir();
    piObj.displayRecurrence();
    piObj.CountinueCustom();
    piObj.SaveCustom();
   
    Test.StopTest();
    
    }
     static testmethod void SPE2_PI_edit_or_new_page_controller3(){
    
    
     //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    PIDefObj.PI_Title__c = 'Test PI Definition1'; 
    PIDefObj.PIAbbreviation__c = 'testPI';  
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.UoM__c = 'Number';
    PIDefObj.ValuesType__c = 'Number';
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2030,2,3);
    PIDefObj.Day_name_of_upload_week__c= 'Tuesday';
    PIDefObj.End_Date__c = Date.newInstance(2030,5,3);
    PIDefObj.Recurrence_frequency_type__c = 'Monthly';
    PIDefObj.Recurrence_Pattern__c = 'DayPerYear';
    PIDefObj.Frequency__c = '3';
    PIDefObj.Week_Count__c = 'First';
    PIDefObj.Additional_Days_for_week__c = 3;
    PIDefObj.Upload_Day__c = 15;
    
    PIDefObj.Additional_Days__c = 1;
    PIDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Tuesday';
    PIDefObj.Yearly_Week_Count__c = 'First';
    PIDefObj.Month_Upload_Day__c = 8;
    PIDefObj.Month_Value__c = 'March';
    
    insert PIDefObj;
    
    ApexPages.currentPage().getParameters().put('Id',PIDefObj.Id);  
    //update lifecycle stage
    
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    PIDefObj.OperationalType__c= 'Leading KPI'; 
    update PIDefObj;
    
    Test.StartTest();     
    
    ApexPages.StandardController ctlr = new ApexPages.StandardController(PIDefObj);  
    SPE2_PI_edit_or_new_page_controller piObj = new SPE2_PI_edit_or_new_page_controller(ctlr);
    PageReference pageRef = Page.SPE2_PI_edit_or_new_page;
    Test.setCurrentPage(pageRef);  
    pageRef.getParameters().put('Id',PIDefObj.Id);
    piObj.DisplaySaveCancelButton();
    piObj.getFrequencyTypes();
    piObj.getWeekCountList();
    piObj.getweekDays();
    piObj.getMonthList();
    piObj.DatePattern();
    piObj.pageredir();
    piObj.displayRecurrence();
    piObj.CountinueCustom();
    piObj.SaveCustom();
   
    Test.StopTest();
    
    }
    static testmethod void SPE2_PI_edit_or_new_page_controller4(){
    
    
     //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    PIDefObj.PI_Title__c = 'Test PI Definition1'; 
    PIDefObj.PIAbbreviation__c = 'testPI';  
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.UoM__c = 'Number';
    PIDefObj.ValuesType__c = 'Number';
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2020,2,3);
    PIDefObj.Day_name_of_upload_week__c= 'Wednesday';
    PIDefObj.End_Date__c = Date.newInstance(2020,5,3);
    PIDefObj.Recurrence_frequency_type__c = 'Monthly';
    PIDefObj.Recurrence_Pattern__c = 'WeekPerYear';
    PIDefObj.Frequency__c = '1';
    PIDefObj.Week_Count__c = 'First';
    PIDefObj.Additional_Days_for_week__c = 3;
    PIDefObj.Upload_Day__c = 20;
    
    PIDefObj.Additional_Days__c = 9;
    PIDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Wednesday';
    PIDefObj.Yearly_Week_Count__c = 'First';
    PIDefObj.Month_Upload_Day__c = 8;
    PIDefObj.Month_Value__c = 'March';
    
    insert PIDefObj;
    
    ApexPages.currentPage().getParameters().put('Id',PIDefObj.Id);  
    //update lifecycle stage
    
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    PIDefObj.OperationalType__c= 'Leading KPI'; 
    update PIDefObj;
    
    Test.StartTest();     
    
    ApexPages.StandardController ctlr = new ApexPages.StandardController(PIDefObj);  
    SPE2_PI_edit_or_new_page_controller piObj = new SPE2_PI_edit_or_new_page_controller(ctlr);
    PageReference pageRef = Page.SPE2_PI_edit_or_new_page;
    Test.setCurrentPage(pageRef);  
    pageRef.getParameters().put('Id',PIDefObj.Id);
    piObj.DisplaySaveCancelButton();
    piObj.getFrequencyTypes();
    piObj.getWeekCountList();
    piObj.getweekDays();
    piObj.getMonthList();
    piObj.DatePattern();
    piObj.pageredir();
    piObj.displayRecurrence();
    piObj.CountinueCustom();
    piObj.SaveCustom();
   
    Test.StopTest();
    
    }
     static testmethod void SPE2_PI_edit_or_new_page_controller5(){
    
    
     //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
  
    Test.StartTest();     
    
    ApexPages.StandardController ctlr = new ApexPages.StandardController(new SPE_PIDefinition__c());    
    SPE2_PI_edit_or_new_page_controller piObj = new SPE2_PI_edit_or_new_page_controller(ctlr);
    PageReference pageRef = Page.SPE2_PI_edit_or_new_page;
    Test.setCurrentPage(pageRef);  
   // pageRef.getParameters().put('Id',PIDefObj.Id);
    piObj.DisplaySaveCancelButton();
    piObj.getFrequencyTypes();
    piObj.getWeekCountList();
    piObj.getweekDays();
    piObj.getMonthList();
    piObj.DatePattern();
    piObj.pageredir();
    piObj.displayRecurrence();
    piObj.CountinueCustom();
    piObj.SaveCustom();
   
    Test.StopTest();
    
    }
     static testmethod void SPE2_PI_edit_or_new_page_controller6(){
    
    
     //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    PIDefObj.PI_Title__c = 'Test PI Definition';  
    PIDefObj.PIAbbreviation__c = 'testPI';
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.UoM__c = 'Number';
    PIDefObj.ValuesType__c = 'Number';
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2050,2,3);
    PIDefObj.Day_name_of_upload_week__c= 'Sunday';
    PIDefObj.End_Date__c = Date.newInstance(2050,5,3);
    PIDefObj.Recurrence_frequency_type__c = 'Yearly';
    PIDefObj.Recurrence_Pattern__c = 'DayPerMonth';
    PIDefObj.Frequency__c = '1';
    PIDefObj.Week_Count__c = 'First';
    PIDefObj.Additional_Days_for_week__c = 3;
    PIDefObj.Upload_Day__c = 5;
    
    PIDefObj.Additional_Days__c = 2;
    PIDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
    PIDefObj.Yearly_Week_Count__c = 'First';
    PIDefObj.Month_Upload_Day__c = 8;
    PIDefObj.Month_Value__c = 'March';
    
    insert PIDefObj;
    
    ApexPages.currentPage().getParameters().put('Id',PIDefObj.Id);  
    //update lifecycle stage
    
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    PIDefObj.OperationalType__c= 'Leading KPI'; 
    update PIDefObj;
    
    Test.StartTest();     
    
    ApexPages.StandardController ctlr = new ApexPages.StandardController(PIDefObj);    
    SPE2_PI_edit_or_new_page_controller piObj = new SPE2_PI_edit_or_new_page_controller(ctlr);
    PageReference pageRef = Page.SPE2_PI_edit_or_new_page;
    Test.setCurrentPage(pageRef);  
    pageRef.getParameters().put('Id',PIDefObj.Id);
    piObj.DisplaySaveCancelButton();
    piObj.getFrequencyTypes();
    piObj.getWeekCountList();
    piObj.getweekDays();
    piObj.getMonthList();
    piObj.DatePattern();
    piObj.pageredir();
    piObj.displayRecurrence();
    piObj.CountinueCustom();
    piObj.SaveCustom();
   
    Test.StopTest();
    
    }
    static testmethod void SPE2_PI_edit_or_new_page_controller7(){
    
    
     //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    PIDefObj.PI_Title__c = 'Test PI Definition1'; 
    PIDefObj.PIAbbreviation__c = 'testPI';  
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.UoM__c = 'Number';
    PIDefObj.ValuesType__c = 'Number';
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2040,2,3);
    PIDefObj.Day_name_of_upload_week__c= 'Monday';
    PIDefObj.End_Date__c = Date.newInstance(2040,5,3);
    PIDefObj.Recurrence_frequency_type__c = 'Yearly';
    PIDefObj.Recurrence_Pattern__c = 'WeekPerMonth';
    PIDefObj.Frequency__c = '2';
    PIDefObj.Week_Count__c = 'First';
    PIDefObj.Additional_Days_for_week__c = 3;
    PIDefObj.Upload_Day__c = 10;
    
    PIDefObj.Additional_Days__c = 7;
    PIDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Monday';
    PIDefObj.Yearly_Week_Count__c = 'First';
    PIDefObj.Month_Upload_Day__c = 8;
    PIDefObj.Month_Value__c = 'March';
    
    insert PIDefObj;
    
    ApexPages.currentPage().getParameters().put('Id',PIDefObj.Id);  
    //update lifecycle stage
    
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    PIDefObj.OperationalType__c= 'Leading KPI'; 
    update PIDefObj;
    
    Test.StartTest();     
    
    ApexPages.StandardController ctlr = new ApexPages.StandardController(PIDefObj);  
    SPE2_PI_edit_or_new_page_controller piObj = new SPE2_PI_edit_or_new_page_controller(ctlr);
    PageReference pageRef = Page.SPE2_PI_edit_or_new_page;
    Test.setCurrentPage(pageRef);  
    pageRef.getParameters().put('Id',PIDefObj.Id);
    piObj.DisplaySaveCancelButton();
    piObj.getFrequencyTypes();
    piObj.getWeekCountList();
    piObj.getweekDays();
    piObj.getMonthList();
    piObj.DatePattern();
    piObj.pageredir();
    piObj.displayRecurrence();
    piObj.CountinueCustom();
    piObj.SaveCustom();
   
    Test.StopTest();
    
    }
     static testmethod void SPE2_PI_edit_or_new_page_controller8(){
    
    
     //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    PIDefObj.PI_Title__c = 'Test PI Definition1'; 
    PIDefObj.PIAbbreviation__c = 'testPI';  
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.UoM__c = 'Number';
    PIDefObj.ValuesType__c = 'Number';
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2030,2,3);
    PIDefObj.Day_name_of_upload_week__c= 'Tuesday';
    PIDefObj.End_Date__c = Date.newInstance(2030,5,3);
    PIDefObj.Recurrence_frequency_type__c = 'Yearly';
    PIDefObj.Recurrence_Pattern__c = 'DayPerYear';
    PIDefObj.Frequency__c = '3';
    PIDefObj.Week_Count__c = 'First';
    PIDefObj.Additional_Days_for_week__c = 3;
    PIDefObj.Upload_Day__c = 15;
    
    PIDefObj.Additional_Days__c = 1;
    PIDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Tuesday';
    PIDefObj.Yearly_Week_Count__c = 'First';
    PIDefObj.Month_Upload_Day__c = 8;
    PIDefObj.Month_Value__c = 'March';
    
    insert PIDefObj;
    
    ApexPages.currentPage().getParameters().put('Id',PIDefObj.Id);  
    //update lifecycle stage
    
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    PIDefObj.OperationalType__c= 'Leading KPI'; 
    update PIDefObj;
    
    Test.StartTest();     
    
    ApexPages.StandardController ctlr = new ApexPages.StandardController(PIDefObj);  
    SPE2_PI_edit_or_new_page_controller piObj = new SPE2_PI_edit_or_new_page_controller(ctlr);
    PageReference pageRef = Page.SPE2_PI_edit_or_new_page;
    Test.setCurrentPage(pageRef);  
    pageRef.getParameters().put('Id',PIDefObj.Id);
    piObj.DisplaySaveCancelButton();
    piObj.getFrequencyTypes();
    piObj.getWeekCountList();
    piObj.getweekDays();
    piObj.getMonthList();
    piObj.DatePattern();
    piObj.pageredir();
    piObj.displayRecurrence();
    piObj.CountinueCustom();
    piObj.SaveCustom();
   
    Test.StopTest();
    
    }
    static testmethod void SPE2_PI_edit_or_new_page_controller9(){
    
    
     //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    PIDefObj.PI_Title__c = 'Test PI Definition1'; 
    PIDefObj.PIAbbreviation__c = 'testPI';  
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.UoM__c = 'Number';
    PIDefObj.ValuesType__c = 'Number';
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2020,2,3);
    PIDefObj.Day_name_of_upload_week__c= 'Wednesday';
    PIDefObj.End_Date__c = Date.newInstance(2020,5,3);
    PIDefObj.Recurrence_frequency_type__c = 'Yearly';
    PIDefObj.Recurrence_Pattern__c = 'WeekPerYear';
    PIDefObj.Frequency__c = '1';
    PIDefObj.Week_Count__c = 'First';
    PIDefObj.Additional_Days_for_week__c = 3;
    PIDefObj.Upload_Day__c = 20;
    
    PIDefObj.Additional_Days__c = 9;
    PIDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Wednesday';
    PIDefObj.Yearly_Week_Count__c = 'First';
    PIDefObj.Month_Upload_Day__c = 8;
    PIDefObj.Month_Value__c = 'March';
    
    insert PIDefObj;
    
    ApexPages.currentPage().getParameters().put('Id',PIDefObj.Id);  
    //update lifecycle stage
    
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    PIDefObj.OperationalType__c= 'Leading KPI'; 
    update PIDefObj;
    
    Test.StartTest();     
    
    ApexPages.StandardController ctlr = new ApexPages.StandardController(PIDefObj);  
    SPE2_PI_edit_or_new_page_controller piObj = new SPE2_PI_edit_or_new_page_controller(ctlr);
    PageReference pageRef = Page.SPE2_PI_edit_or_new_page;
    Test.setCurrentPage(pageRef);  
    pageRef.getParameters().put('Id',PIDefObj.Id);
    piObj.DisplaySaveCancelButton();
    piObj.getFrequencyTypes();
    piObj.getWeekCountList();
    piObj.getweekDays();
    piObj.getMonthList();
    piObj.DatePattern();
    piObj.pageredir();
    piObj.displayRecurrence();
    piObj.CountinueCustom();
    piObj.SaveCustom();
   
    Test.StopTest();
    
    }
     static testmethod void SPE2_PI_edit_or_new_page_controller10(){
    
    
     //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    SPE_SurveyQuestion__c surveyqstn = new SPE_SurveyQuestion__c();
    surveyqstn =SPE_TestObjectCreator.CreateSurveyQuestion();
    insert surveyqstn;
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    PIDefObj.PI_Title__c = 'Test PI Definition1'; 
    PIDefObj.PIAbbreviation__c = 'testPI';  
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Survey';
    PIDefObj.UoM__c = 'Number';
    PIDefObj.ValuesType__c = 'Number';
    PIDefObj.PIUploadDuedate__c = null;
    PIDefObj.Day_name_of_upload_week__c= '';
    PIDefObj.End_Date__c = null;
    PIDefObj.Recurrence_frequency_type__c = '';
    PIDefObj.Recurrence_Pattern__c = '';
    PIDefObj.Frequency__c = '0';
    PIDefObj.Week_Count__c = '';
    PIDefObj.Additional_Days_for_week__c = null;
    PIDefObj.Upload_Day__c = null;
    PIDefObj.SurveyQuestion__c =surveyqstn.id;
    PIDefObj.Additional_Days__c = null;
    PIDefObj.Yearly_Day_Name_of_Upload_Week__c = '';
    PIDefObj.Yearly_Week_Count__c = '';
    PIDefObj.Month_Upload_Day__c = null;
    PIDefObj.Month_Value__c = '';
    
    insert PIDefObj;
    
    ApexPages.currentPage().getParameters().put('Id',PIDefObj.Id);  
    //update lifecycle stage
    
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    PIDefObj.OperationalType__c= 'Leading KPI'; 
    update PIDefObj;
    
    Test.StartTest();     
    
    ApexPages.StandardController ctlr = new ApexPages.StandardController(PIDefObj);  
    SPE2_PI_edit_or_new_page_controller piObj = new SPE2_PI_edit_or_new_page_controller(ctlr);
    PageReference pageRef = Page.SPE2_PI_edit_or_new_page;
    Test.setCurrentPage(pageRef);  
    pageRef.getParameters().put('Id',PIDefObj.Id);
    piObj.DisplaySaveCancelButton();
    piObj.getFrequencyTypes();
    piObj.getWeekCountList();
    piObj.getweekDays();
    piObj.getMonthList();
    piObj.DatePattern();
    piObj.pageredir();
    piObj.displayRecurrence();
    piObj.CountinueCustom();
    piObj.SaveCustom();
   
    Test.StopTest();
    
    }
    static testmethod void SPE2_PI_edit_or_new_page_controller_clone11(){
    
    
     //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    PIDefObj.PI_Title__c = 'Test PI Definition';  
    PIDefObj.PIAbbreviation__c = 'testPI';
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.UoM__c = 'Number';
    PIDefObj.ValuesType__c = 'Number';
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2050,2,3);
    PIDefObj.Day_name_of_upload_week__c= 'Sunday';
    PIDefObj.End_Date__c = Date.newInstance(2050,5,3);
    PIDefObj.Recurrence_frequency_type__c = 'Monthly';
    PIDefObj.Recurrence_Pattern__c = 'DayPerMonth';
    PIDefObj.Frequency__c = '1';
    PIDefObj.Week_Count__c = 'First';
    PIDefObj.Additional_Days_for_week__c = 3;
    PIDefObj.Upload_Day__c = 5;
    
    PIDefObj.Additional_Days__c = 2;
    PIDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
    PIDefObj.Yearly_Week_Count__c = 'First';
    PIDefObj.Month_Upload_Day__c = 8;
    PIDefObj.Month_Value__c = 'March';
    
    insert PIDefObj;
    
    ApexPages.currentPage().getParameters().put('Id',PIDefObj.Id);  
    //update lifecycle stage
    
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    PIDefObj.OperationalType__c= 'Leading KPI'; 
    update PIDefObj;
    
    Test.StartTest();     
    
    ApexPages.StandardController ctlr = new ApexPages.StandardController(PIDefObj);  
    SPE2_PI_edit_or_new_page_controller piObj = new SPE2_PI_edit_or_new_page_controller(ctlr);
    PageReference pageRef = Page.SPE2_PI_edit_or_new_page;
    Test.setCurrentPage(pageRef);  
    pageRef.getParameters().put('Id',PIDefObj.Id);
    pageRef.getParameters().put('isClone','abcd');
    piObj.DisplaySaveCancelButton();
    piObj.getFrequencyTypes();
    piObj.getWeekCountList();
    piObj.getweekDays();
    piObj.getMonthList();
    piObj.DatePattern();
    piObj.pageredir();
    piObj.displayRecurrence();
    piObj.CountinueCustom();
    piObj.SaveCustom();
   
    Test.StopTest();
    
    }
    
 static testmethod void SPE2_PI_edit_or_new_page_controller12(){
 
     //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
      User u2 = new User(Alias = 'newUser', Email='newuser@testorg.com', 
         EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
         LocaleSidKey='en_US', ProfileId = p.Id, 
         TimeZoneSidKey='America/Los_Angeles', UserName='newuser22@testorg.com');

    
    insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    PIDefObj.PI_Title__c = 'Test PI Definition';  
    PIDefObj.PIAbbreviation__c = 'testPI';
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.UoM__c = 'Number';
    PIDefObj.ValuesType__c = 'Number';
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2016,8,7);
    PIDefObj.Day_name_of_upload_week__c= 'Sunday';
   // PIDefObj.End_Date__c = Date.newInstance(2050,5,3);
    PIDefObj.Recurrence_frequency_type__c = 'Monthly';
    PIDefObj.Recurrence_Pattern__c = 'WeekPerYear';
    PIDefObj.Frequency__c = '1';
    PIDefObj.Week_Count__c = 'First';
    PIDefObj.Additional_Days_for_week__c = 3;
    PIDefObj.Upload_Day__c = 5;
    
    PIDefObj.Additional_Days__c = 2;
    PIDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Sunday';
    PIDefObj.Yearly_Week_Count__c = 'First';
    PIDefObj.Month_Upload_Day__c = 8;
    PIDefObj.Month_Value__c = 'August';
    
    insert PIDefObj;
    
    ApexPages.currentPage().getParameters().put('Id',PIDefObj.Id);  
    //update lifecycle stage
    
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    PIDefObj.OperationalType__c= 'Leading KPI'; 
    update PIDefObj;
    
    Test.StartTest();     
    System.runAs(u2) {
    ApexPages.StandardController ctlr = new ApexPages.StandardController(PIDefObj);    
    SPE2_PI_edit_or_new_page_controller piObj = new SPE2_PI_edit_or_new_page_controller(ctlr);
    PageReference pageRef = Page.SPE2_PI_edit_or_new_page;
    Test.setCurrentPage(pageRef);  
    pageRef.getParameters().put('Id',PIDefObj.Id);
    piObj.DisplaySaveCancelButton();
    piObj.getFrequencyTypes();
    piObj.getWeekCountList();
    piObj.getweekDays();
    piObj.getMonthList();
    piObj.DatePattern();
    piObj.pageredir();
    piObj.displayRecurrence();
    piObj.CountinueCustom();
    piObj.SaveCustom();
   
    Test.StopTest();
    }
    }
 static testmethod void SPE2_PI_edit_or_new_page_controller13(){
 
     //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
      User u2 = new User(Alias = 'newUser', Email='newuser@testorg.com', 
         EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
         LocaleSidKey='en_US', ProfileId = p.Id, 
         TimeZoneSidKey='America/Los_Angeles', UserName='newuser22@testorg.com');

    
    insert new SPE_Stop__c(Stop_trigger__c = true,Name ='Stop');
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    PIDefObj.PI_Title__c = 'Test PI Definition';  
    PIDefObj.PIAbbreviation__c = 'testPI';
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.UoM__c = 'Number';
    PIDefObj.ValuesType__c = 'Number';
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2016,5,7);
    PIDefObj.Day_name_of_upload_week__c= 'Sunday';
   // PIDefObj.End_Date__c = Date.newInstance(2050,3,);
    PIDefObj.Recurrence_frequency_type__c = 'Monthly';
    PIDefObj.Recurrence_Pattern__c = 'WeekPerYear';
    PIDefObj.Frequency__c = '1';
    PIDefObj.Week_Count__c = 'First';
    PIDefObj.Additional_Days_for_week__c = 3;
    PIDefObj.Upload_Day__c = 5;
    
    PIDefObj.Additional_Days__c = 2;
    PIDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Monday';
    PIDefObj.Yearly_Week_Count__c = 'First';
    PIDefObj.Month_Upload_Day__c = 8;
    PIDefObj.Month_Value__c = 'May';
    
    insert PIDefObj;
    
    ApexPages.currentPage().getParameters().put('Id',PIDefObj.Id);  
    //update lifecycle stage
    
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    PIDefObj.OperationalType__c= 'Leading KPI'; 
    update PIDefObj;
    
    Test.StartTest();     
    System.runAs(u2) {
    ApexPages.StandardController ctlr = new ApexPages.StandardController(PIDefObj);    
    SPE2_PI_edit_or_new_page_controller piObj = new SPE2_PI_edit_or_new_page_controller(ctlr);
    PageReference pageRef = Page.SPE2_PI_edit_or_new_page;
    Test.setCurrentPage(pageRef);  
    pageRef.getParameters().put('Id',PIDefObj.Id);
    piObj.DisplaySaveCancelButton();
    piObj.getFrequencyTypes();
    piObj.getWeekCountList();
    piObj.getweekDays();
    piObj.getMonthList();
    piObj.DatePattern();
    piObj.pageredir();
    piObj.displayRecurrence();
    piObj.CountinueCustom();
    piObj.SaveCustom();
   
    Test.StopTest();
    }
    }
      static testmethod void SPE2_PI_edit_or_new_page_controller14(){
    
    
     //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    PIDefObj.PI_Title__c = 'Test PI Definition1'; 
    PIDefObj.PIAbbreviation__c = 'testPI';  
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.UoM__c = 'Number';
    PIDefObj.ValuesType__c = 'Number';
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2040,2,3);
    PIDefObj.Day_name_of_upload_week__c= 'Wednesday';
    PIDefObj.End_Date__c = Date.newInstance(2040,5,3);
    PIDefObj.Recurrence_frequency_type__c = 'Monthly';
    PIDefObj.Recurrence_Pattern__c = 'WeekPerMonth';
    PIDefObj.Frequency__c = '2';
    PIDefObj.Week_Count__c = 'First';
    PIDefObj.Additional_Days_for_week__c = 0;
  //  PIDefObj.Upload_Day__c = 10;
    
    PIDefObj.Additional_Days__c = 7;
    PIDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Monday';
    PIDefObj.Yearly_Week_Count__c = 'First';
    PIDefObj.Month_Upload_Day__c = 8;
    PIDefObj.Month_Value__c = 'March';
    
    insert PIDefObj;
    
    ApexPages.currentPage().getParameters().put('Id',PIDefObj.Id);  
    //update lifecycle stage
    
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    PIDefObj.OperationalType__c= 'Leading KPI'; 
    update PIDefObj;
    
    Test.StartTest();     
    
    ApexPages.StandardController ctlr = new ApexPages.StandardController(PIDefObj);  
    SPE2_PI_edit_or_new_page_controller piObj = new SPE2_PI_edit_or_new_page_controller(ctlr);
    PageReference pageRef = Page.SPE2_PI_edit_or_new_page;
    Test.setCurrentPage(pageRef);  
    pageRef.getParameters().put('Id',PIDefObj.Id);
    piObj.DisplaySaveCancelButton();
    piObj.getFrequencyTypes();
    piObj.getWeekCountList();
    piObj.getweekDays();
    piObj.getMonthList();
    piObj.DatePattern();
    piObj.pageredir();
    piObj.displayRecurrence();
    piObj.CountinueCustom();
    piObj.SaveCustom();
   
    Test.StopTest();
    
    }
     static testmethod void SPE2_PI_edit_or_new_page_controller15(){
    
    
     //---Custom Setting data ---
    LIst<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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
    
    SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
    PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
    
    PIDefObj.PI_Title__c = 'Test PI Definition1'; 
    PIDefObj.PIAbbreviation__c = 'testPI';  
    PIDefObj.LifecycleStage__c = 'Draft';
    PIDefObj.DataAcquisitionMethod__c = 'Data Load';
    PIDefObj.UoM__c = 'Number';
    PIDefObj.ValuesType__c = 'Number';
    PIDefObj.PIUploadDuedate__c = Date.newInstance(2016,3,7);
    PIDefObj.Day_name_of_upload_week__c= 'Wednesday';
    PIDefObj.End_Date__c = Date.newInstance(2040,5,3);
    PIDefObj.Recurrence_frequency_type__c = 'Yearly';
    PIDefObj.Recurrence_Pattern__c = 'WeekPerYear';
    PIDefObj.Frequency__c = '12';
    PIDefObj.Week_Count__c = 'First';
    PIDefObj.Additional_Days_for_week__c = 0;
  //  PIDefObj.Upload_Day__c = 10;
    
    PIDefObj.Additional_Days__c = 0;
    PIDefObj.Yearly_Day_Name_of_Upload_Week__c = 'Monday';
    PIDefObj.Yearly_Week_Count__c = 'First';
  //  PIDefObj.Month_Upload_Day__c = 8;
    PIDefObj.Month_Value__c = 'March';
    
    insert PIDefObj;
    
    ApexPages.currentPage().getParameters().put('Id',PIDefObj.Id);  
    //update lifecycle stage
    
    PIDefObj.LifecycleStage__c= 'Published';
    update PIDefObj;
    
    PIDefObj.OperationalType__c= 'Leading KPI'; 
    update PIDefObj;
    
    Test.StartTest();     
    
    ApexPages.StandardController ctlr = new ApexPages.StandardController(PIDefObj);  
    SPE2_PI_edit_or_new_page_controller piObj = new SPE2_PI_edit_or_new_page_controller(ctlr);
    PageReference pageRef = Page.SPE2_PI_edit_or_new_page;
    Test.setCurrentPage(pageRef);  
    pageRef.getParameters().put('Id',PIDefObj.Id);
    piObj.DisplaySaveCancelButton();
    piObj.DisplaySaveCancelButton();
    piObj.getFrequencyTypes();
    piObj.getWeekCountList();
    piObj.getweekDays();
    piObj.getMonthList();
    piObj.DatePattern();
    piObj.pageredir();
    piObj.displayRecurrence();
    piObj.CountinueCustom();
    piObj.SaveCustom();
   
    Test.StopTest();
    
    }
}