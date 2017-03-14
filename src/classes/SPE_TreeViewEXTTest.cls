@isTest(seeAllData=false)
public with sharing class SPE_TreeViewEXTTest{

static testmethod void SPE_TreeViewEXTTest1(){


    List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
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

 List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
 List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
 List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
 Set<Id> idUsers = new Set<Id>();
 
 for(Integer i=0;i<1;i++){
                 SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                //*********************Changes For Encryption******************//  
                    //PIDefObj.Name = 'Test PI Definition'+i;
                    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************// 
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
                
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
                   
            SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
                insert kpidef;
                 kpi.add(kpidef);

      SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                //kpiDefinition1.Name = 'Test KPI Definition 1236';
                kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
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
            kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
        insert kpiDefinition1;

        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        }
        
        update lstPIDefObj;

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
    
    //-------------SPE Template created------
    speTemp.Stage__c ='Pilot';
    update speTemp; 

    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 

 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Published');
 ApexPages.currentPage().getParameters().put('id',kpiDefinition1.Id);
  
        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        controller.cascade();
}


// ***************************************************************************

static testmethod void SPE_TreeViewEXTTest2(){

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

 List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
 List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
 List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
Set<Id> idUsers = new Set<Id>();
 
 for(Integer i=0;i<1;i++){
                SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
                //*********************Changes For Encryption******************//  
                     //PIDefObj.Name = 'Test PI Definition'+i;
                     PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************// 
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
                
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
                   
            SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
                insert kpidef;
                 kpi.add(kpidef);
    
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        }
        
        update lstPIDefObj;

     SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                     //kpiDefinition1.Name = 'Test KPI Definition 1236';
                     kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
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
            // kpiDefinition1.FrequencyinMonth__c = '2';
           // kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
            kpiDefinition1.PI_Data__c= lstPIDefObj[0].id;
            //kpiDefinition1.ActualCalculation__c = 'A+B';
            kpiDefinition1.FrequencyinMonth__c=null;
            kpiDefinition1.Buffer_Days__c =null;
        insert kpiDefinition1;
        
        
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
    
    //-------------SPE Template created------
    speTemp.Stage__c ='Pilot';
    update speTemp; 

    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 
    
    kpiDefinition1.LifecycleStage__c = 'Pilot';
    update kpiDefinition1;
    
 
    SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
        spekpi.KPIDefinition__c = kpiDefinition1.Id;
        spekpi.SPETemplate__c = speTemp.Id;
        spekpi.Weight__c = 100;
    insert spekpi;
    
 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Published');
 ApexPages.currentPage().getParameters().put('id',speTemp.Id);
        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        controller.cascade();
        //controller.sendMail();
}

// ***************************************************************************

static testmethod void SPE_TreeViewEXTTest3(){

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

 List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
 List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
 List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
Set<Id> idUsers = new Set<Id>();
 
 for(Integer i=0;i<1;i++){
                SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
                //*********************Changes For Encryption******************//  
                    //PIDefObj.Name = 'Test PI Definition'+i;
                    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************//
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
                
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
                   
            SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
                insert kpidef;
                 kpi.add(kpidef);
    
     SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                 //kpiDefinition1.Name = 'Test KPI Definition 1236';
                 kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
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
            kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
        insert kpiDefinition1;

        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        }
        
        update lstPIDefObj;

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
                
        lstKPICalc=[select id,Aggregation__c,ConstantValue__c,Filter1__c,filter10__c,Filter2__c,Filter3__c,Filter4__c,
                                    Filter5__c,Filter6__c,Filter7__c,Filter8__c,filter9__c,flag__c,Index__c,IndexName__c,KPIDefinition__c,
                                    PIDefination__c,PrevKPIDefination__c,QuestionName__c,SurveyQuestion__c,TimeFrame__c
                             From SPE_KPICalculation__c where KPIDefinition__c =: kpidef.id ];                           
   //----------create SPE Template------------ 
   
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
    //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
    insert speTemp;
    
    //-------------SPE Template created------
    speTemp.Stage__c ='Pilot';
    update speTemp; 

    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 

 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Published');
 ApexPages.currentPage().getParameters().put('id',scoringTemplate.Id);

        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        controller.cascade();
        //controller.sendMail();
}


// ***************************************************************************

static testmethod void SPE_TreeViewEXTTest4(){

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

 List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
 List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
 List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
Set<Id> idUsers = new Set<Id>();
 
 for(Integer i=0;i<1;i++){
                SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
                //*********************Changes For Encryption******************//  
                    //PIDefObj.Name = 'Test PI Definition'+i;
                    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************//
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
                
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
                   
            SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
                insert kpidef;
                 kpi.add(kpidef);
    
     SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                 //kpiDefinition1.Name = 'Test KPI Definition 1236';
                 kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
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
            kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
        insert kpiDefinition1;

        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        }
        
        update lstPIDefObj;

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
                
        lstKPICalc=[select id,Aggregation__c,ConstantValue__c,Filter1__c,filter10__c,Filter2__c,Filter3__c,Filter4__c,
                                    Filter5__c,Filter6__c,Filter7__c,Filter8__c,filter9__c,flag__c,Index__c,IndexName__c,KPIDefinition__c,
                                    PIDefination__c,PrevKPIDefination__c,QuestionName__c,SurveyQuestion__c,TimeFrame__c
                             From SPE_KPICalculation__c where KPIDefinition__c =: kpidef.id ];                           
   //----------create SPE Template------------ 
   
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
    //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
    insert speTemp;
    
    //-------------SPE Template created------
    speTemp.Stage__c ='Pilot';
    update speTemp; 

    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 

 
 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Obsolete');
 ApexPages.currentPage().getParameters().put('id',lstPIDefObj[0].Id);

        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        controller.cascade();
        //controller.sendMail();
}

// ***************************************************************************

static testmethod void SPE_TreeViewEXTTest5(){


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

 List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
 List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
 List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
Set<Id> idUsers = new Set<Id>();
 
 for(Integer i=0;i<1;i++){
                SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
                //*********************Changes For Encryption******************//  
                        //PIDefObj.Name = 'Test PI Definition'+i;
                        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************/
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
                
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
                   
            SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
                insert kpidef;
                 kpi.add(kpidef);
 
     SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                 //kpiDefinition1.Name = 'Test KPI Definition 1236';
                 kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
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
            kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
        insert kpiDefinition1;

        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        }
        
        update lstPIDefObj;

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
    //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
    insert speTemp;
    
    //-------------SPE Template created------
    speTemp.Stage__c ='Pilot';
    update speTemp; 

    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 

 
 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Obsolete');
 ApexPages.currentPage().getParameters().put('id',kpiDefinition1.Id);
 
        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        controller.cascade();
        //controller.sendMail();
}

// ***************************************************************************

static testmethod void SPE_TreeViewEXTTest6(){


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

 List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
 List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
 List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
Set<Id> idUsers = new Set<Id>();
 
 for(Integer i=0;i<1;i++){
                SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
                //*********************Changes For Encryption******************//  
                        //PIDefObj.Name = 'Test PI Definition'+i;
                        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************/
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
                
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
                   
            SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
                insert kpidef;
                 kpi.add(kpidef);
    
     SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                 //kpiDefinition1.Name = 'Test KPI Definition 1236';
                 kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
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
            kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
        insert kpiDefinition1;

        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        }
        
        update lstPIDefObj;

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
    //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
    insert speTemp;
    
    //-------------SPE Template created------
    speTemp.Stage__c ='Pilot';
    update speTemp; 

    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 

 
 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Obsolete');
 ApexPages.currentPage().getParameters().put('id',speTemp.Id);

        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        controller.cascade();
        //controller.sendMail();
}

// ***************************************************************************

static testmethod void SPE_TreeViewEXTTest7(){

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

 List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
 List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
 List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();

 Set<Id> idUsers = new Set<Id>();
 for(Integer i=0;i<1;i++){
                SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
                //*********************Changes For Encryption******************//  
                        //PIDefObj.Name = 'Test PI Definition'+i;
                        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************//
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
                
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
                   
            SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
                insert kpidef;
                 kpi.add(kpidef);

     SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                 //kpiDefinition1.Name = 'Test KPI Definition 1236';
                 kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
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
            kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
        insert kpiDefinition1;
    
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        }
        
        update lstPIDefObj;

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
    //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
    insert speTemp;
    
    //-------------SPE Template created------
    speTemp.Stage__c ='Pilot';
    update speTemp; 
    
    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 
    
    scoringTemplate.stage__c = 'Pilot';
    update scoringTemplate;
    
    SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
    spePlan.SPEPlanName__c = 'Test plan';
        spePlan.Region__c = 'All Markets';
        spePlan.SubRegion__c = 'All Market Units';
        spePlan.Country__c = 'All Countries';
        spePlan.Project__c = 'All Projects';
        
        spePlan.CategoryCluster__c = 'All Category Areas';
        spePlan.CategoryGroup__c = 'All Category Groups';
        spePlan.Category__c = 'All Categories';
        
        spePlan.BusinessLine__c ='All Business Units';
        spePlan.BusinessUnit__c ='All Business Lines';
        spePlan.Product__c = 'All Products';
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
    insert spePlan ;
 
 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Obsolete');
 ApexPages.currentPage().getParameters().put('id',scoringTemplate.Id);

        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        controller.cascade();
        //controller.sendMail();
 
}

static testmethod void SPE_TreeViewEXTTest10(){

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

 List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
 List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
 List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
 Set<Id> idUsers = new Set<Id>();
 
 for(Integer i=0;i<1;i++){
                SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
                //*********************Changes For Encryption******************//  
                        //PIDefObj.Name = 'Test PI Definition'+i;
                        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************//
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);        
                PIDefObj.GeoScope__c = 'All Markets';
                PIDefObj.CategoryScope__c = 'All Categories';
                PIDefObj.BUScope__c = 'All Products';
                PIDefObj.ValuesType__c='Number';
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
        
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        }
        update   lstPIDefObj;
                
        SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert kpidef;
        kpi.add(kpidef);

     SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                 //kpiDefinition1.Name = 'Test KPI Definition 1236';
                 kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
            kpiDefinition1.Level__c = '1';
            kpiDefinition1.LifecycleStage__c = 'Published';
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
           // kpiDefinition1.FrequencyinMonth__c = '2';
           // kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
            kpiDefinition1.PI_Data__c= lstPIDefObj[0].id;
            kpiDefinition1.FrequencyinMonth__c=null;
            kpiDefinition1.Buffer_Days__c =null;
        insert kpiDefinition1;

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
    //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
    insert speTemp;
    
    //-------------SPE Template created------
    speTemp.Stage__c ='Pilot';
    update speTemp; 

    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 

 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Published');
 ApexPages.currentPage().getParameters().put('id',kpiDefinition1.Id);

        
        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        controller.cascade();
}

static testmethod void SPE_TreeViewEXTTest11(){

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

 List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
 List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
 List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
 Set<Id> idUsers = new Set<Id>();
 
 for(Integer i=0;i<1;i++){
                 SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
                //*********************Changes For Encryption******************//  
                        //PIDefObj.Name = 'Test PI Definition'+i;
                        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************//
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
                
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
                   
            SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
                insert kpidef;
                 kpi.add(kpidef);

      SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                 //kpiDefinition1.Name = 'Test KPI Definition 1236';
                 kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
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
            kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
        insert kpiDefinition1;
        
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        }
        
        update lstPIDefObj;
        
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
    //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
    insert speTemp;
    
    //-------------SPE Template created------
    speTemp.Stage__c ='Pilot';
    update speTemp; 

    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 
    
 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Published');
 ApexPages.currentPage().getParameters().put('id',kpiDefinition1.Id);
  
        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        controller.cascade();
}



static testmethod void SPE_TreeViewEXTTest12(){

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

     List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
     List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
     List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
     Set<Id> idUsers = new Set<Id>();
 
     for(Integer i=0;i<1;i++){
                 SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
                //*********************Changes For Encryption******************//  
                        //PIDefObj.Name = 'Test PI Definition'+i;
                        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************//
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
                
                lstPIDefObj.add(PIDefObj);
            }
     insert lstPIDefObj;
     
     for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Obsolete';
     }
    
    update lstPIDefObj;
     
                  
      SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
                insert kpidef;
                 kpi.add(kpidef);

      SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                 //kpiDefinition1.Name = 'Test KPI Definition 1236';
                 kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
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
            kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
        insert kpiDefinition1;
 
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        }
        
        update lstPIDefObj;
        

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
    //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
    insert speTemp;
    
    //-------------SPE Template created------
    speTemp.Stage__c ='Pilot';
    update speTemp; 

    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 
 
 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Obsolete');
 ApexPages.currentPage().getParameters().put('id',lstPIDefObj[0].Id);
     
        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        controller.cascade();
        
}

    
    
    static testmethod void SPE_TreeViewEXTTest13(){

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

 List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
 List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
 List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
 Set<Id> idUsers = new Set<Id>();
 
 for(Integer i=0;i<1;i++){
                SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
                //*********************Changes For Encryption******************//  
                        //PIDefObj.Name = 'Test PI Definition'+i;
                        PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************//
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);        
                PIDefObj.GeoScope__c = 'All Markets';
                PIDefObj.CategoryScope__c = 'All Categories';
                PIDefObj.BUScope__c = 'All Products';
                PIDefObj.ValuesType__c='Number';
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
        
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        }
        update   lstPIDefObj;
                
        SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert kpidef;
        kpi.add(kpidef);

     SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                //kpiDefinition1.Name = 'Test KPI Definition 1236';
                kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
            kpiDefinition1.Level__c = '1';
            kpiDefinition1.LifecycleStage__c = 'Published';
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
           // kpiDefinition1.FrequencyinMonth__c = '2';
           // kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
            kpiDefinition1.PI_Data__c= lstPIDefObj[0].id;
            kpiDefinition1.FrequencyinMonth__c=null;
            kpiDefinition1.Buffer_Days__c =null;
        insert kpiDefinition1;

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
    //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
    insert speTemp;
    
    //-------------SPE Template created------
    speTemp.Stage__c ='Pilot';
    update speTemp; 
 
    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 
    

 
 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Published');
 ApexPages.currentPage().getParameters().put('id',kpiDefinition1.Id);
      
 //ApexPages.currentPage().getParameters().put('ParentId',scoringTemplate.Id);
 //ApexPages.currentPage().getParameters().put('ObjectType','PI');
        
        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        controller.cascade();
        controller.sendMail();
}

    // ***************************************************************************

static testmethod void SPE_TreeViewEXTTest14(){

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

 List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
 List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
 List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
 Set<Id> idUsers = new Set<Id>();
 
 for(Integer i=0;i<1;i++){
                SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
                //*********************Changes For Encryption******************//  
                    //PIDefObj.Name = 'Test PI Definition'+i;
                    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************//  
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);        
                PIDefObj.GeoScope__c = 'All Markets';
                PIDefObj.CategoryScope__c = 'All Categories';
                PIDefObj.BUScope__c = 'All Products';
                PIDefObj.ValuesType__c='Number';
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
        
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        }
        update   lstPIDefObj;
                
        SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert kpidef;
        kpi.add(kpidef);
 
     SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                //kpiDefinition1.Name = 'Test KPI Definition 1236';
                kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
            kpiDefinition1.Level__c = '1';
            kpiDefinition1.LifecycleStage__c = 'Published';
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
           // kpiDefinition1.FrequencyinMonth__c = '2';
           // kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
            kpiDefinition1.PI_Data__c= lstPIDefObj[0].id;
            //kpiDefinition1.ActualCalculation__c = 'A+B';
            kpiDefinition1.FrequencyinMonth__c=null;
            kpiDefinition1.Buffer_Days__c =null;
        insert kpiDefinition1;

        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        }
        
        update lstPIDefObj;

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
    //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
    insert speTemp;

    kpiDefinition1.LifecycleStage__c = 'Pilot';
    Update kpiDefinition1;
    
    
    speTemp.Stage__c ='Published';
    update speTemp; 
    
    SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
        spekpi.KPIDefinition__c = kpiDefinition1.Id;
        spekpi.SPETemplate__c = speTemp.Id;
        spekpi.Weight__c = 100;
    insert spekpi;
    
    
    //-------------KPIMap created----------------
    
    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 
    
    
    scoringTemplate.stage__c = 'Pilot';
    update scoringTemplate;
    
    SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
    spePlan.SPEPlanName__c = 'Test plan';
        spePlan.Region__c = 'All Markets';
        spePlan.SubRegion__c = 'All Market Units';
        spePlan.Country__c = 'All Countries';
        spePlan.Project__c = 'All Projects';
        
        spePlan.CategoryCluster__c = 'All Category Areas';
        spePlan.CategoryGroup__c = 'All Category Groups';
        spePlan.Category__c = 'All Categories';
        
        spePlan.BusinessLine__c ='All Business Units';
        spePlan.BusinessUnit__c ='All Business Lines';
        spePlan.Product__c = 'All Products';
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
    insert spePlan ;
    
 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Published');
 ApexPages.currentPage().getParameters().put('id',speTemp.Id);

       
        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        //controller.cascade();
        //controller.sendMail();
}

// ***************************************************************************

static testmethod void SPE_TreeViewEXTTest15(){

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

 List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
 List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
 List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
 Set<Id> idUsers = new Set<Id>();
 
 for(Integer i=0;i<1;i++){
                SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
                //*********************Changes For Encryption******************//  
                    //PIDefObj.Name = 'Test PI Definition'+i;
                    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************//  
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);        
                PIDefObj.GeoScope__c = 'All Markets';
                PIDefObj.CategoryScope__c = 'All Categories';
                PIDefObj.BUScope__c = 'All Products';
                PIDefObj.ValuesType__c='Number';
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
        
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        }
        update   lstPIDefObj;
                
        SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert kpidef;
        kpi.add(kpidef);
 
     SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                //kpiDefinition1.Name = 'Test KPI Definition 1236';
                kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
            kpiDefinition1.Level__c = '1';
            kpiDefinition1.LifecycleStage__c = 'Published';
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
           // kpiDefinition1.FrequencyinMonth__c = '2';
           // kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
            kpiDefinition1.PI_Data__c= lstPIDefObj[0].id;
            //kpiDefinition1.ActualCalculation__c = 'A+B';
            kpiDefinition1.FrequencyinMonth__c=null;
            kpiDefinition1.Buffer_Days__c =null;
        insert kpiDefinition1;
        
        //update lifecycle stage
    
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Pilot';
        }
        
        update lstPIDefObj;
        

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
    //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
    insert speTemp;
    

    
    kpiDefinition1.LifecycleStage__c = 'Pilot';
    Update kpiDefinition1;
    
    
    speTemp.Stage__c ='Published';
    update speTemp; 
    
    SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
        spekpi.KPIDefinition__c = kpiDefinition1.Id;
        spekpi.SPETemplate__c = speTemp.Id;
        spekpi.Weight__c = 100;
    insert spekpi;
    
    
    //-------------KPIMap created----------------
    
    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 
    
    scoringTemplate.stage__c = 'Pilot';
    update scoringTemplate;
    
    SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
    spePlan.SPEPlanName__c = 'Test plan';
        spePlan.Region__c = 'All Markets';
        spePlan.SubRegion__c = 'All Market Units';
        spePlan.Country__c = 'All Countries';
        spePlan.Project__c = 'All Projects';
        
        spePlan.CategoryCluster__c = 'All Category Areas';
        spePlan.CategoryGroup__c = 'All Category Groups';
        spePlan.Category__c = 'All Categories';
        
        spePlan.BusinessLine__c ='All Business Units';
        spePlan.BusinessUnit__c ='All Business Lines';
        spePlan.Product__c = 'All Products';
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
    insert spePlan ;
    
    
    
 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Obsolete');
 ApexPages.currentPage().getParameters().put('id',speTemp.Id);

        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        controller.cascade();
}

// ***************************************************************************

static testmethod void SPE_TreeViewEXTTest16(){

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

 List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
 List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
 List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();

 Set<Id> idUsers = new Set<Id>();
 for(Integer i=0;i<1;i++){
                SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
                //*********************Changes For Encryption******************//  
                    //PIDefObj.Name = 'Test PI Definition'+i;
                    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************//  
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
                
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
                   
            SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
                insert kpidef;
                 kpi.add(kpidef);
     
     
     for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        }
        
     update lstPIDefObj;
     
     
     SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                //kpiDefinition1.Name = 'Test KPI Definition 1236';
                kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
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
            //kpiDefinition1.FrequencyinMonth__c = '2';
            //kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
            kpiDefinition1.PI_Data__c= lstPIDefObj[0].id;
            //kpiDefinition1.ActualCalculation__c = 'A+B';
            kpiDefinition1.FrequencyinMonth__c=null;
            kpiDefinition1.Buffer_Days__c =null;
        insert kpiDefinition1;
    
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        }
        
        update lstPIDefObj;

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
    //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
    insert speTemp;
    
    //-------------SPE Template created------
    speTemp.Stage__c ='Pilot';
    update speTemp; 
    
    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 
    
    scoringTemplate.stage__c = 'Pilot';
    update scoringTemplate;
    
    SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
    spePlan.SPEPlanName__c = 'Test plan';
        spePlan.Region__c = 'All Markets';
        spePlan.SubRegion__c = 'All Market Units';
        spePlan.Country__c = 'All Countries';
        spePlan.Project__c = 'All Projects';
        
        spePlan.CategoryCluster__c = 'All Category Areas';
        spePlan.CategoryGroup__c = 'All Category Groups';
        spePlan.Category__c = 'All Categories';
        
        spePlan.BusinessLine__c ='All Business Units';
        spePlan.BusinessUnit__c ='All Business Lines';
        spePlan.Product__c = 'All Products';
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
    insert spePlan ;
     
    kpiDefinition1.LifecycleStage__c = 'Pilot';
    update kpiDefinition1;
    
 
    SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
        spekpi.KPIDefinition__c = kpiDefinition1.Id;
        spekpi.SPETemplate__c = speTemp.Id;
        spekpi.Weight__c = 100;
    insert spekpi; 
     
     
 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Published');
 ApexPages.currentPage().getParameters().put('id',scoringTemplate.Id);

        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        controller.cascade();
        //controller.sendMail();

     
}

// ***************************************************************************

static testmethod void SPE_TreeViewEXTTest8(){

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

 List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
 List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
 List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
Set<Id> idUsers = new Set<Id>();
 
 for(Integer i=0;i<1;i++){
                SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
                //*********************Changes For Encryption******************//  
                    //PIDefObj.Name = 'Test PI Definition'+i;
                    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************//  
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
                
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
                   
            SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
                insert kpidef;
                 kpi.add(kpidef);
 
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        }
        
        update lstPIDefObj;
          
                             
  //******************************************
  
     SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                //kpiDefinition1.Name = 'Test KPI Definition 1236';
                kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
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
            // kpiDefinition1.FrequencyinMonth__c = '2';
           // kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
            kpiDefinition1.PI_Data__c= lstPIDefObj[0].id;
            //kpiDefinition1.ActualCalculation__c = 'A+B';
            kpiDefinition1.FrequencyinMonth__c=null;
            kpiDefinition1.Buffer_Days__c =null;
        insert kpiDefinition1;
        
        
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
    //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
    insert speTemp;
    
    //-------------SPE Template created------
    speTemp.Stage__c ='Pilot';
    update speTemp; 

    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 
    
    scoringTemplate.stage__c = 'Pilot';
    Update scoringTemplate;
    
    kpiDefinition1.LifecycleStage__c = 'Pilot';
    update kpiDefinition1;
    
 
    SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
        spekpi.KPIDefinition__c = kpiDefinition1.Id;
        spekpi.SPETemplate__c = speTemp.Id;
        spekpi.Weight__c = 100;
    insert spekpi;
    
    SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
    spePlan.SPEPlanName__c = 'Test plan';
        spePlan.Region__c = 'All Markets';
        spePlan.SubRegion__c = 'All Market Units';
        spePlan.Country__c = 'All Countries';
        spePlan.Project__c = 'All Projects';
        
        spePlan.CategoryCluster__c = 'All Category Areas';
        spePlan.CategoryGroup__c = 'All Category Groups';
        spePlan.Category__c = 'All Categories';
        
        spePlan.BusinessLine__c ='All Business Units';
        spePlan.BusinessUnit__c ='All Business Lines';
        spePlan.Product__c = 'All Products';
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Pilot';
    insert spePlan ;
    
 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Obsolete');
 ApexPages.currentPage().getParameters().put('id',lstPIDefObj[0].Id);

       
        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        controller.cascade();
        //controller.sendMail();
}

// ***************************************************************************

static testmethod void SPE_TreeViewEXTTest_Final(){

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

 List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
 List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
 List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
Set<Id> idUsers = new Set<Id>();
 
 for(Integer i=0;i<1;i++){
                SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
                //*********************Changes For Encryption******************//  
                    //PIDefObj.Name = 'Test PI Definition'+i;
                    PIDefObj.PI_Title__c = 'Test PI Definition'+i;
                //*********************END******************//  
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
                
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
                   
            SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
                insert kpidef;
                 kpi.add(kpidef);

        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        }
        
        update lstPIDefObj;
          
                             
  //******************************************
  
     SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            
            //*********************Changes For Encryption******************//  
                //kpiDefinition1.Name = 'Test KPI Definition 1236';
                kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
            //*********************END******************//
            
            kpiDefinition1.AbbreviatedName__c = 'TKPIDe5';
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
            // kpiDefinition1.FrequencyinMonth__c = '2';
           // kpiDefinition1.ScheduledDate__c = system.today().addDays(20);
            kpiDefinition1.VerNumber__c = 1;
            kpiDefinition1.PI_Data__c= lstPIDefObj[0].id;
            //kpiDefinition1.ActualCalculation__c = 'A+B';
            kpiDefinition1.FrequencyinMonth__c=null;
            kpiDefinition1.Buffer_Days__c =null;
        insert kpiDefinition1;
        
        
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
    //SPE_SPETemplate__c speTemp =  SPE_TestObjectCreator.CreateSPETemplate();  
    insert speTemp;
    
    //-------------SPE Template created------
    speTemp.Stage__c ='Pilot';
    update speTemp; 

    SPE_ScoringTemplate__c  scoringTemplate = new SPE_ScoringTemplate__c();
    scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
    
    insert scoringTemplate; 
    
    scoringTemplate.stage__c = 'Pilot';
    Update scoringTemplate;
    
    kpiDefinition1.LifecycleStage__c = 'Pilot';
    update kpiDefinition1;
    
 
    SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
        spekpi.KPIDefinition__c = kpiDefinition1.Id;
        spekpi.SPETemplate__c = speTemp.Id;
        spekpi.Weight__c = 100;
    insert spekpi;
    
    SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
    spePlan.SPEPlanName__c = 'Test plan';
        spePlan.Region__c = 'All Markets';
        spePlan.SubRegion__c = 'All Market Units';
        spePlan.Country__c = 'All Countries';
        spePlan.Project__c = 'All Projects';
        
        spePlan.CategoryCluster__c = 'All Category Areas';
        spePlan.CategoryGroup__c = 'All Category Groups';
        spePlan.Category__c = 'All Categories';
        
        spePlan.BusinessLine__c ='All Business Units';
        spePlan.BusinessUnit__c ='All Business Lines';
        spePlan.Product__c = 'All Products';
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Pilot';
    insert spePlan ;
    
 PageReference pageRef = Page.SPE_TreeView; //replace with your VF page name
 Test.setCurrentPage(pageRef);
  
 ApexPages.currentPage().getParameters().put('Lifecycle', 'Obsolete');
 ApexPages.currentPage().getParameters().put('id',kpiDefinition1.Id);

       
        SPE_TreeViewEXT controller = new SPE_TreeViewEXT();
        controller.cascade();
        //controller.sendMail();
}

}