@isTest(seeAllData=False)
public class SPE_KPIClone_Test{
    
    public static testmethod void SPE_KPICloneTest(){
    
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

        List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
        List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
            for(Integer i=0;i<1;i++){
                SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
             //**********************Changes For Encryption******************//
                //PIDefObj.Name = 'Test PI Definition'+i;
                PIDefObj.PI_Title__c = 'Test PI Definition'+i;
             //**********************END******************//   
                
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
                   
            SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
                insert kpidef;
                
          lstKPICalc=[select id,Aggregation__c,ConstantValue__c,Filter1__c,filter10__c,Filter2__c,Filter3__c,Filter4__c,
                                    Filter5__c,Filter6__c,Filter7__c,Filter8__c,filter9__c,flag__c,Index__c,IndexName__c,KPIDefinition__c,
                                    PIDefination__c,PrevKPIDefination__c,QuestionName__c,SurveyQuestion__c,TimeFrame__c
                             From SPE_KPICalculation__c where KPIDefinition__c =: kpidef.id ];
                             
        System.assertNotEquals( kpidef.id,null);      
        
        ApexPages.StandardController sc = new ApexPages.StandardController(kpidef);
        SPE_KPIClone p =new SPE_KPIClone(sc);
        p.SaveKPI();
    }
    
    // For Else Part ..
    
    public static testmethod void SPE_CreateKPIVersionTest2(){
    test.startTest();
    
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
    
        //List<SPE_KPIDefinition__c>  kpi = new List<SPE_KPIDefinition__c>();
        //List<SPE_KPICalculation__c> lstKPICalc= new List<SPE_KPICalculation__c>();
        
        SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
        
        //**********************Changes For Encryption******************//
            //kpiDefinition1.Name = 'Test KPI Definition 1236';
            kpiDefinition1.KPI_Title__c = 'Test KPI Definition 1236';
        //**********************************END****************************//       
            
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
        
        List<SPE_PIDefinition__c> lstPIDefObj = new List<SPE_PIDefinition__c>();
            for(Integer i=0;i<1;i++){
                SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
                PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
                
             //**********************Changes For Encryption******************//
                //PIDefObj.Name = 'Test PI Definition'+i;
                PIDefObj.PI_Title__c = 'Test PI Definition'+i;
             //**********************END******************//
             
                PIDefObj.LifecycleStage__c = 'Draft';
                PIDefObj.DataAcquisitionMethod__c = 'Data Load';
                PIDefObj.PIUploadDuedate__c = Date.newInstance(2099,2,3);
                lstPIDefObj.add(PIDefObj);
            }
        insert lstPIDefObj;
        
        //update lifecycle stage
    
        for(Integer i=0;i<1;i++){
        lstPIDefObj[i].LifecycleStage__c= 'Published';
        }
        
        update lstPIDefObj;
        
        SPE_KPIDefinition__c kpidef = SPE_TestObjectCreator.CreateKPIDefinition(1);
            kpidef.Master_KPI__c= kpiDefinition1.Id;
        insert kpidef;
        
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
                
        lstKPICalc=[select id,Aggregation__c,ConstantValue__c,Filter1__c,filter10__c,Filter2__c,Filter3__c,Filter4__c,
                                    Filter5__c,Filter6__c,Filter7__c,Filter8__c,filter9__c,flag__c,Index__c,IndexName__c,KPIDefinition__c,
                                    PIDefination__c,PrevKPIDefination__c,QuestionName__c,SurveyQuestion__c,TimeFrame__c
                             From SPE_KPICalculation__c where KPIDefinition__c =: kpidef.id ];
                             
        System.assertNotEquals( kpidef.id,null);      
        
        ApexPages.StandardController sc = new ApexPages.StandardController(kpidef);
        SPE_KPIClone p =new SPE_KPIClone(sc);
        p.SaveKPI();
        test.stopTest();
    }
}