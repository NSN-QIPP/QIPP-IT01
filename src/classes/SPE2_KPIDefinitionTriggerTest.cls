@isTest(SeeAllData=false)
public class SPE2_KPIDefinitionTriggerTest
{
    static testMethod void testSPE2_KPIDefinitionTriggerMethod1(){
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
            
        Account a = new Account();
        a.Name = 'COSCOM';
        a.enterpriseId__c='COSCOM';
        insert a;
        system.debug('account ::'+a);
                 
        
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
        
        SPE_KPIDefinition__c masterkpi = new SPE_KPIDefinition__c();
        masterkpi = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert masterKpi;
        List<SPE_KPIDefinition__c> kpiList= new List<SPE_KPIDefinition__c >();
        for(integer i=0;i<1;i++){
            SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(i);
            kpiDefinition1.Master_KPI__c = masterKpi.id;
           // kpiDefinition1.Buffer_Days__c =null;
            kpiList.add(kpiDefinition1);
        }
        insert kpiList[0];
        for(SPE_KPIDefinition__c kp :kpiList){
            kp.LifecycleStage__c ='Pilot';
            kp.FrequencyinMonth__c = '';
            kp.ScheduledDate__c = null;
            kp.Buffer_Days__c =null;
            kp.PI_Data__c =pidef.id;
        }
      //  update kpilist;                                                                              
    }  
     public static testMethod void testSPE2_KPIDefinitionTriggerMethod2(){
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
            
        Account a = new Account();
        a.Name = 'COSCOM';
        a.enterpriseId__c='COSCOM';
        insert a;
        system.debug('account ::'+a);
                 
        
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
        
        SPE_KPIDefinition__c masterkpi = new SPE_KPIDefinition__c();
        masterkpi = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert masterKpi;
        List<SPE_KPIDefinition__c> kpiList= new List<SPE_KPIDefinition__c >();
        for(integer i=0;i<1;i++){
            SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(i);
            kpiDefinition1.Master_KPI__c = masterKpi.id;           
            kpiList.add(kpiDefinition1);
        }
        insert kpiList[0];
        
        SPE_KPIComments__c kpicomment = new SPE_KPIComments__c();
        kpicomment.KPI__c = kpiList[0].id;
        kpicomment.PIData__c =pidef.id;
        kpicomment.SurveyComments__c = 'test comments';
        kpicomment.EnterpriseId__c = 'COSCOM';
        insert kpicomment;
        
        SPE_KPICalculation__c kpiCal = SPE_TestObjectCreator.createKPICalculation();
        kpiCal.pidefination__c=pidef.id;
        kpical.KPIDefinition__c =kpiList[0].id;      
        insert kpiCal;

        KPI_Calculation_Formula__c kpiform = new KPI_Calculation_Formula__c();
        kpiform.Name = 'Condition 1';
        kpiform.KPI__c =kpiList[0].id;
        kpiform.KPI_Expression__c = 'A';
        kpiform.KPI_Formula__c = 'A';
        insert kpiform;
        
        KPI_Calulation_Condition__c kpicondtn =new KPI_Calulation_Condition__c();
        kpicondtn.Name ='A';
        kpicondtn.Formula__c =kpiform.id;
        kpicondtn.Operator__c = '>=';
        kpicondtn.Value__c = 10;                     
        insert kpicondtn;

        SPE_PITempValue__c tempval = SPE_TestObjectCreator.createPITempValue();
        tempval.PIValue__c = '10';
        tempval.enterpriseId__c='COSCOM';
        tempval.ValueType__c ='Number';
       // tempval.Index__c = 'A';
        tempval.ExecutionPeriod__c ='June - 2016' ;
        tempval.EnterpriseIDEncrypted__c =a.id;
        tempval.KPICalculation__c=kpiCal.id;
        tempval.KPIDefinition__c=kpiList[0].id;
        tempval.isconstant__c=false;
        insert tempval;
                                
        for(SPE_KPIDefinition__c kp :kpiList){
            kp.LifecycleStage__c ='Pilot';            
            kp.ScheduledDate__c = kp.ScheduledDate__c.addDays(1);            
        }
        update kpilist;        
                                                                                            
    }  
    public static testMethod void testSPE2_KPIDefinitionTriggerMethod3(){
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
            
        Account a = new Account();
        a.Name = 'COSCOM';
        a.enterpriseId__c='COSCOM';
        insert a;
        system.debug('account ::'+a);
                 
        
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
        piVal.NumberValue__c =12;
        insert piVal;
        
        SPE_KPIDefinition__c masterkpi = new SPE_KPIDefinition__c();
        masterkpi = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert masterKpi;
        List<SPE_KPIDefinition__c> kpiList= new List<SPE_KPIDefinition__c >();
        for(integer i=0;i<1;i++){
            SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(i);
            kpiDefinition1.Master_KPI__c = masterKpi.id;
            
            kpiList.add(kpiDefinition1);
        }
        insert kpiList[0];  
        
        SPE_KPIComments__c kpicomment = new SPE_KPIComments__c();
        kpicomment.KPI__c = kpiList[0].id;
        kpicomment.PIData__c =pidef.id;
        kpicomment.SurveyComments__c = 'test comments';
        kpicomment.EnterpriseId__c = 'COSCOM';
        insert kpicomment;     
        
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
        kpicondtn.Value__c = 10;                     
        insert kpicondtn;      
        
        SPE_PITempValue__c tempval = SPE_TestObjectCreator.createPITempValue();
        tempval.PIValue__c = '11';
        tempval.enterpriseId__c='COSCOM';
        tempval.ValueType__c ='Number';
       // tempval.Index__c = 'A';
        tempval.ExecutionPeriod__c ='June - 2016' ;
        tempval.EnterpriseIDEncrypted__c =a.id;
        //tempval.KPICalculation__c=kpiCal.id;
        tempval.KPIDefinition__c=kpiList[0].id;
        tempval.isconstant__c=false;
        insert tempval;
        
        for(SPE_KPIDefinition__c kp :kpiList){
            kp.LifecycleStage__c ='Pilot';            
            kp.ScheduledDate__c = kp.ScheduledDate__c.addDays(1);            
        }
        update kpilist;  
        List<String> strList = new List<String>();
        strList.add('abcd@gmail.com');
        Map<ID,SPE_KPIDefinition__c> oldkpiMap = new  Map<ID,SPE_KPIDefinition__c>();
        oldkpiMap.put(masterkpi.Id, masterkpi);
        
        //SPE2_KPIDefinitionTrigger clsx = new SPE2_KPIDefinitionTrigger();
       // SPE2_KPIDefinitionTrigger.UpdatePIDefinition(kpiList,oldkpiMap);
        SPE2_KPIDefinitionTrigger.sendEmail(strList,kpiList);
       
                                                                                    
    } 
    public static testMethod void testSPE2_KPIDefinitionTriggerMethod4(){
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
            
        Account a = new Account();
        a.Name = 'COSCOM';
        a.enterpriseId__c='COSCOM';
        insert a;
        system.debug('account ::'+a);
                 
        
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
        
        SPE_KPIDefinition__c masterkpi = new SPE_KPIDefinition__c();
        masterkpi = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert masterKpi;
       
        
        List<SPE_KPIDefinition__c> kpiList= new List<SPE_KPIDefinition__c >();
        for(integer i=0;i<1;i++){
            SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(i);
            kpiDefinition1.Master_KPI__c = masterKpi.id;
            
            kpiList.add(kpiDefinition1);
        }
        insert kpiList[0]; 
        
        SPE_KPIComments__c kpicomment = new SPE_KPIComments__c();
        kpicomment.KPI__c = kpiList[0].id;
        kpicomment.PIData__c =pidef.id;
        kpicomment.SurveyComments__c = 'test comments';
        kpicomment.EnterpriseId__c = 'COSCOM';
        insert kpicomment;     
        
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
        kpicondtn.Value__c = 10;                     
        insert kpicondtn;      
        
        SPE_PITempValue__c tempval = SPE_TestObjectCreator.createPITempValue();
        tempval.PIValue__c = '11';
        tempval.enterpriseId__c='COSCOM';
        tempval.ValueType__c ='Number';
        tempval.ExecutionPeriod__c ='June - 2016' ;
        tempval.EnterpriseIDEncrypted__c =a.id;
        tempval.KPIDefinition__c=kpiList[0].id;
        tempval.isconstant__c=false;
        insert tempval;
        
        for(SPE_KPIDefinition__c kp :kpiList){
            kp.LifecycleStage__c ='Pilot';            
            kp.ScheduledDate__c = kp.ScheduledDate__c.addDays(1);            
        }
        update kpilist;  
        List<String> strList = new List<String>();
        strList.add('abcd@gmail.com');     
        
        SPE2_KPIDefinitionTrigger.sendEmail(strList,kpiList);                                                                                          
    }           
    public static testMethod void testSPE2_KPIDefinitionTriggerMethod5(){
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
        
        SPE_KPIDefinition__c masterkpi = new SPE_KPIDefinition__c();
        masterkpi = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert masterKpi;
        
        List<SPE_KPIDefinition__c> kpiList= new List<SPE_KPIDefinition__c >();
        for(integer i=0;i<1;i++){
            SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(i);
            kpiDefinition1.Master_KPI__c = masterKpi.id;            
            kpiList.add(kpiDefinition1);
        }
        insert kpiList[0];

        SPE_KPICalculation__c kpiCal = SPE_TestObjectCreator.createKPICalculation();
        kpiCal.Aggregation__c = 'Max';
        kpiCal.pidefination__c=pidef.id;
        kpical.KPIDefinition__c =kpiList[0].id;
        insert kpiCal;
        
        SPE_KPICalculation__c kpiCal1 = SPE_TestObjectCreator.createKPICalculation();
        kpiCal1.Aggregation__c = 'Min';
        kpiCal1.pidefination__c=pidef.id;
        kpical1.KPIDefinition__c = kpiList[0].id;
        insert kpiCal1;
        
        SPE_KPICalculation__c kpiCal2 = SPE_TestObjectCreator.createKPICalculation();
        kpiCal2.Aggregation__c = 'Min';
        kpiCal2.pidefination__c=pidef.id;
        kpical2.KPIDefinition__c =kpiList[0].id;
        insert kpiCal2;
        
        SPE_KPICalculation__c kpiCal3 = SPE_TestObjectCreator.createKPICalculation();
        kpiCal3.Aggregation__c = 'Min';
        kpiCal3.pidefination__c=pidef.id;
        kpical3.KPIDefinition__c =kpiList[0].id;
        insert kpiCal3;
                        
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
        
        KPI_Calulation_Condition__c kpicondtn1 =new KPI_Calulation_Condition__c();
        kpicondtn1.Name ='B';
        kpicondtn1.Formula__c =kpiform.id;
        kpicondtn1.Operator__c = 'Not Null';
        kpicondtn1.Value__c =Null;                     
        insert kpicondtn1;
        
        KPI_Calulation_Condition__c kpicondtn2 =new KPI_Calulation_Condition__c();
        kpicondtn2.Name ='C';
        kpicondtn2.Formula__c =kpiform.id;
        kpicondtn2.Operator__c = '>';
        kpicondtn2.Value__c = 0;                     
        insert kpicondtn2;
        
        KPI_Calulation_Condition__c kpicondtn3 =new KPI_Calulation_Condition__c();
        kpicondtn3.Name ='D';
        kpicondtn3.Formula__c =kpiform.id;
        kpicondtn3.Operator__c = '>';
        kpicondtn3.Value__c = 0;                     
        insert kpicondtn3;
            
        system.debug('kpicondtn ::'+kpicondtn);

        SPE_PITempValue__c tempval = SPE_TestObjectCreator.createPITempValue();
        tempval.PIValue__c = String.ValueOf(Date.newInstance(2016,6,14));
        tempval.enterpriseId__c='COSCOM';
        tempval.ValueType__c = SPE_Constants.PI_DATEVALUETYPE;
        tempval.ExecutionPeriod__c ='June - 2016';
        tempval.EnterpriseIDEncrypted__c =a.id;
        tempval.KPICalculation__c=kpiCal.id;
        tempval.KPIDefinition__c=kpiList[0].id;
        tempval.isconstant__c=false;
        insert tempval;
        
        SPE_PITempValue__c tempval1 = SPE_TestObjectCreator.createPITempValue();
        tempval1.PIValue__c = String.ValueOf(Date.newInstance(2016,6,14));
        tempval1.enterpriseId__c='COSCOM';
        tempval1.ValueType__c = SPE_Constants.PI_DATEVALUETYPE;
        tempval1.ExecutionPeriod__c ='June - 2016';
        tempval1.EnterpriseIDEncrypted__c =a.id;
        tempval1.KPICalculation__c=kpiCal1.id;
        tempval1.KPIDefinition__c=kpiList[0].id;
        tempval1.isconstant__c=false;
        insert tempval1;
        
        SPE_PITempValue__c tempval2 = SPE_TestObjectCreator.createPITempValue();
        tempval2.PIValue__c = String.ValueOf(Date.newInstance(2016,6,14));
        tempval2.enterpriseId__c='COSCOM';
        tempval2.ValueType__c = SPE_Constants.PI_DATEVALUETYPE;
        tempval2.ExecutionPeriod__c ='June - 2016';
        tempval2.EnterpriseIDEncrypted__c =a.id;
        tempval2.KPICalculation__c=kpiCal2.id;
        tempval2.KPIDefinition__c=kpiList[0].id;
        tempval2.isconstant__c=false;
        insert tempval2;
        
        SPE_PITempValue__c tempval3 = SPE_TestObjectCreator.createPITempValue();
        tempval3.PIValue__c = String.ValueOf(Date.newInstance(2016,6,14));
        tempval3.enterpriseId__c='COSCOM';
        tempval3.ValueType__c = SPE_Constants.PI_DATEVALUETYPE;
        tempval3.ExecutionPeriod__c ='June - 2016';
        tempval3.EnterpriseIDEncrypted__c =a.id;
        tempval3.KPICalculation__c=kpiCal3.id;
        tempval3.KPIDefinition__c=kpiList[0].id;
        tempval3.isconstant__c=false;
        insert tempval3;
                        
        for(SPE_KPIDefinition__c kp :kpiList){
            kp.LifecycleStage__c ='Pilot';            
            kp.ScheduledDate__c = kp.ScheduledDate__c.addDays(1);            
        }
        update kpilist;
                                                                                       
    }  
    public static testMethod void testSPE2_KPIDefinitionTriggerMethod6(){
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
        
        SPE_KPIDefinition__c masterkpi = new SPE_KPIDefinition__c();
        masterkpi = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert masterKpi;
        
        List<SPE_KPIDefinition__c> kpiList= new List<SPE_KPIDefinition__c >();
        for(integer i=0;i<1;i++){
            SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(i);
            kpiDefinition1.Master_KPI__c = masterKpi.id;            
            kpiList.add(kpiDefinition1);
        }
        insert kpiList[0];
        
        SPE_KPICalculation__c kpiCal = SPE_TestObjectCreator.createKPICalculation();
        kpiCal.Aggregation__c = 'Min';
        kpiCal.pidefination__c=pidef.id;
        kpical.KPIDefinition__c =kpiList[0].id;      
        insert kpiCal;        
        
        KPI_Calculation_Formula__c kpiform = new KPI_Calculation_Formula__c();
        kpiform.Name = 'Condition 1';
        kpiform.KPI__c =kpiList[0].id;
        kpiform.KPI_Expression__c = 'A';
        kpiform.KPI_Formula__c = 'A';
        insert kpiform;
        
        KPI_Calulation_Condition__c kpicondtn =new KPI_Calulation_Condition__c();
        kpicondtn.Name ='A';
        kpicondtn.Formula__c =kpiform.id;
        kpicondtn.Operator__c = 'Not Null';
        kpicondtn.Value__c = Null;                     
        insert kpicondtn; 
        system.debug('kpicondtn ::'+kpicondtn);
                
        SPE_PITempValue__c tempval = SPE_TestObjectCreator.createPITempValue();
        tempval.PIValue__c = String.ValueOf(Date.newInstance(2016,6,14));
        tempval.enterpriseId__c='COSCOM';
        tempval.ValueType__c = SPE_Constants.PI_DATEVALUETYPE;
       // tempval.Index__c = 'A';
        tempval.ExecutionPeriod__c ='June - 2016' ;
        tempval.EnterpriseIDEncrypted__c =a.id;
        tempval.KPICalculation__c=kpiCal.id;
        tempval.KPIDefinition__c=kpiList[0].id;
        tempval.isconstant__c=false;
        insert tempval;
        
        for(SPE_KPIDefinition__c kp :kpiList){
            kp.LifecycleStage__c ='Pilot';            
            kp.ScheduledDate__c = kp.ScheduledDate__c.addDays(1);            
        }
        update kpilist;                                                                                 
    }      
   public static testMethod void testSPE2_KPIDefinitionTriggerMethod7(){
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
            
        Account a = new Account();
        a.Name = 'COSCOM';
        a.enterpriseId__c='COSCOM';
        insert a;
        system.debug('account ::'+a);
                 
        
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
        
        SPE_KPIDefinition__c masterkpi = new SPE_KPIDefinition__c();
        masterkpi = SPE_TestObjectCreator.CreateKPIDefinition(1);
        masterkpi.LifecycleStage__c  ='Published';
        insert masterKpi;
        List<SPE_KPIDefinition__c> kpiList= new List<SPE_KPIDefinition__c >();
        for(integer i=0;i<1;i++){
            SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(i);
            kpiDefinition1.Master_KPI__c = masterKpi.id;
            kpiDefinition1.LifecycleStage__c  ='Pilot';
            kpiList.add(kpiDefinition1);
        }
        insert kpiList[0];   
        
        system.assertEquals(kpiList[0].LifecycleStage__c,'Pilot');    
        
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
        kpicondtn.Value__c = 10;                     
        insert kpicondtn;      
        
        SPE_PITempValue__c tempval = SPE_TestObjectCreator.createPITempValue();
        tempval.PIValue__c = '11';
        tempval.enterpriseId__c='COSCOM';
        tempval.ValueType__c ='Number';
       // tempval.Index__c = 'A';
        tempval.ExecutionPeriod__c ='June - 2016' ;
        tempval.EnterpriseIDEncrypted__c =a.id;
       // tempval.KPICalculation__c=kpiCal.id;
        tempval.KPIDefinition__c=kpiList[0].id;
        tempval.isconstant__c=false;
        insert tempval;

        for(SPE_KPIDefinition__c kp :kpiList){
            kp.LifecycleStage__c ='Published';            
            kp.ScheduledDate__c = kp.ScheduledDate__c.addDays(1);            
        }
        update kpilist;
        
        SPE_SPETemplate__c spetemp = SPE_TestObjectCreator.CreateSPETemplate();
        spetemp.Stage__c ='Pilot';
        insert spetemp;
        
        system.assertEquals(spetemp.Stage__c,'Pilot');
        
        SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        spekpi.KPIDefinition__c =kpiList[0].id;
        spekpi.SPETemplate__c =spetemp.id;
        spekpi.UseLatestKPIVersion__c =True;
        spekpi.Weight__c =100.00;         
        insert spekpi;                                                                                           
    }
    
    public static testMethod void testSPE2_KPIDefinitionTriggerMethod8(){
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
            
        Account a = new Account();
        a.Name = 'COSCOM';
        a.enterpriseId__c='COSCOM';
        insert a;
        system.debug('account ::'+a);
                 
        
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
        
        SPE_KPIDefinition__c masterkpi = new SPE_KPIDefinition__c();
        masterkpi = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert masterKpi;
        List<SPE_KPIDefinition__c> kpiList= new List<SPE_KPIDefinition__c >();
        for(integer i=0;i<1;i++){
            SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(i);
            kpiDefinition1.Master_KPI__c = masterKpi.id;           
            kpiList.add(kpiDefinition1);
        }
        insert kpiList[0];
        
        SPE_KPIComments__c kpicomment = new SPE_KPIComments__c();
        kpicomment.KPI__c = kpiList[0].id;
        kpicomment.PIData__c =pidef.id;
        kpicomment.SurveyComments__c = 'test comments';
        kpicomment.EnterpriseId__c = 'COSCOM';
        insert kpicomment;
        
        SPE_KPICalculation__c kpiCal = SPE_TestObjectCreator.createKPICalculation();
        kpiCal.pidefination__c=pidef.id;
        kpical.KPIDefinition__c =kpiList[0].id;      
        insert kpiCal;
        
        SPE_KPICalculation__c kpiCal1 = SPE_TestObjectCreator.createKPICalculation();
        kpiCal1.pidefination__c=pidef.id;
        kpical1.KPIDefinition__c =kpiList[0].id;      
        insert kpiCal1;

        KPI_Calculation_Formula__c kpiform = new KPI_Calculation_Formula__c();
        kpiform.Name = 'Condition 1';
        kpiform.KPI__c =kpiList[0].id;
        kpiform.KPI_Expression__c = 'A,B,+';
        kpiform.KPI_Formula__c = 'A+B';
        insert kpiform;
        
        KPI_Calulation_Condition__c kpicondtn =new KPI_Calulation_Condition__c();
        kpicondtn.Name ='A';
        kpicondtn.Formula__c =kpiform.id;
        kpicondtn.Operator__c = 'Not Null';
        kpicondtn.Value__c = Null;                     
        insert kpicondtn;
        
        KPI_Calulation_Condition__c kpicondtn1 =new KPI_Calulation_Condition__c();
        kpicondtn1.Name ='B';
        kpicondtn1.Formula__c =kpiform.id;
        kpicondtn1.Operator__c = '>=';
        kpicondtn1.Value__c = 10;                     
        insert kpicondtn1;

        SPE_PITempValue__c tempval = SPE_TestObjectCreator.createPITempValue();
        tempval.PIValue__c = '10';
        tempval.enterpriseId__c='COSCOM';
        tempval.ValueType__c ='Number';
        tempval.ExecutionPeriod__c ='June - 2016' ;
        tempval.EnterpriseIDEncrypted__c =a.id;
        tempval.KPICalculation__c=kpiCal.id;
        tempval.KPIDefinition__c=kpiList[0].id;
        tempval.isconstant__c=false;
        insert tempval;
        
        SPE_PITempValue__c tempval1 = SPE_TestObjectCreator.createPITempValue();
        tempval1.PIValue__c = '10';
        tempval1.enterpriseId__c='COSCOM';
        tempval1.ValueType__c ='Number';
        tempval1.ExecutionPeriod__c ='June - 2016' ;
        tempval1.EnterpriseIDEncrypted__c =a.id;
        tempval1.KPICalculation__c=kpiCal1.id;
        tempval1.KPIDefinition__c=kpiList[0].id;
        tempval1.isconstant__c=false;
        insert tempval1;
        
        SPE_KPICalculation__c kpiCal2 = SPE_TestObjectCreator.createKPICalculation();
        kpiCal2.pidefination__c=pidef.id;
        kpical2.KPIDefinition__c =kpiList[0].id;      
        insert kpiCal2;

        kpiform.KPI_Expression__c = 'A,B,+,C,+';
        kpiform.KPI_Formula__c = 'A+B+C';
        update kpiform;
        
        KPI_Calulation_Condition__c kpicondtn3 =new KPI_Calulation_Condition__c();
        kpicondtn3.Name ='C';
        kpicondtn3.Formula__c =kpiform.id;
        kpicondtn3.Operator__c = 'Not Null';
        kpicondtn3.Value__c = Null;                     
        insert kpicondtn3;
        
        SPE_PITempValue__c tempval3 = SPE_TestObjectCreator.createPITempValue();
        tempval3.PIValue__c = '10';
        tempval3.enterpriseId__c='COSCOM';
        tempval3.ValueType__c ='Number';
        tempval3.ExecutionPeriod__c ='June - 2016' ;
        tempval3.EnterpriseIDEncrypted__c =a.id;
        tempval3.KPICalculation__c=kpiCal2.id;
        tempval3.KPIDefinition__c=kpiList[0].id;
        tempval3.isconstant__c=false;
        insert tempval3;
                                
        for(SPE_KPIDefinition__c kp :kpiList){
            kp.LifecycleStage__c ='Pilot';            
            kp.ScheduledDate__c = kp.ScheduledDate__c.addDays(1);            
        }
        update kpilist;                                                                                                   
    }
    public static testMethod void testSPE2_KPIDefinitionTriggerMethod9(){
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
        
        SPE_KPIDefinition__c masterkpi = new SPE_KPIDefinition__c();
        masterkpi = SPE_TestObjectCreator.CreateKPIDefinition(1);
        insert masterKpi;
        
        List<SPE_KPIDefinition__c> kpiList= new List<SPE_KPIDefinition__c >();
        for(integer i=0;i<1;i++){
            SPE_KPIDefinition__c kpiDefinition1 = new SPE_KPIDefinition__c();
            kpiDefinition1 = SPE_TestObjectCreator.CreateKPIDefinition(i);
            kpiDefinition1.Master_KPI__c = masterKpi.id;            
            kpiList.add(kpiDefinition1);
        }
        insert kpiList[0];
        
        SPE_KPICalculation__c kpiCal = SPE_TestObjectCreator.createKPICalculation();
        kpiCal.Aggregation__c = 'Min';
        kpiCal.pidefination__c=pidef.id;
        kpical.KPIDefinition__c =kpiList[0].id;      
        insert kpiCal;        
        
        KPI_Calculation_Formula__c kpiform = new KPI_Calculation_Formula__c();
        kpiform.Name = 'Condition 1';
        kpiform.KPI__c =kpiList[0].id;
        kpiform.KPI_Expression__c = 'A';
        kpiform.KPI_Formula__c = 'A';
        insert kpiform;
        
        KPI_Calulation_Condition__c kpicondtn =new KPI_Calulation_Condition__c();
        kpicondtn.Name ='A';
        kpicondtn.Formula__c =kpiform.id;
        kpicondtn.Operator__c = 'Null';
        kpicondtn.Value__c = Null;                     
        insert kpicondtn; 
        system.debug('kpicondtn ::'+kpicondtn);
                
        SPE_PITempValue__c tempval = SPE_TestObjectCreator.createPITempValue();
        tempval.PIValue__c = String.ValueOf(Date.newInstance(2016,6,14));
        tempval.enterpriseId__c='COSCOM';
        tempval.ValueType__c = SPE_Constants.PI_DATEVALUETYPE;
       // tempval.Index__c = 'A';
        tempval.ExecutionPeriod__c ='June - 2016' ;
        tempval.EnterpriseIDEncrypted__c =a.id;
        tempval.KPICalculation__c=kpiCal.id;
        tempval.KPIDefinition__c=kpiList[0].id;
        tempval.isconstant__c=false;
        insert tempval;
        
        for(SPE_KPIDefinition__c kp :kpiList){
            kp.LifecycleStage__c ='Pilot';            
            kp.ScheduledDate__c = kp.ScheduledDate__c.addDays(1);            
        }
        update kpilist;                                                                                 
    }        
}