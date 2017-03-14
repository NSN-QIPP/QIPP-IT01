public class SPE2_AuditNC_CMExt{
    public SPE_ConsequenceManagement__c cmObj{get;set;}
    public SPE_ConsequenceManagement__c cmObjClone{get;set;}
    public string selectedValue{get;set;}
     //--------------------------Initialization of Variables for Custom Picklist Starts---------------------
    public Set<String> lstTemp{get;set;}
    public string marketVal{get;set;} 
    public string marketUnitVal{get;set;}
    public string countryVal{get;set;} 
    public string projectVal{get;set;}
    public string buVal {get;set;}
    public string blVal{get;set;}
    public string prdVal{get;set;}
    public string caVal{get;set;}
    public string cgVal{get;set;}
    public string ctVal{get;set;}
    public string speTrackerSelectedVal{get;set;}
    public string kpiFieldVal{get;set;}
    public boolean displayNotifyButton{get;set;}
    List<SelectOption>  mkoptions;
    List<SelectOption> countryOptions;
    List<SelectOption> projectOptions;
    List<SelectOption> BusinessLineOptions;
    List<SelectOption> ProductOptions;
    List<SelectOption> CatGroupOptions;
    List<SelectOption> CategoryOptions;
    Set<String> setMarkets;
    Set<String> setBusinessUnits;
    Set<String> setCategoryArea;
    Set<String> setMarketUnit;
    map<String,Set<String>> mapHierarchyDetails1;
    public map<String,Set<String>> mapHierarchyDetails  {get;set;}
    public ApexPages.StandardController standardController { get; set; }
    public List<NC_Item__c> ncItems{get;set;}
    public String isClone{get;set;}
    private Apexpages.Standardcontroller stdCon;
    //-----------------Initialization of Variables for Custom Picklist Ends-----------------------
    
    public SPE2_AuditNC_CMExt(ApexPages.StandardController controller) {
        cmObj = new  SPE_ConsequenceManagement__c();
        cmObjClone = new  SPE_ConsequenceManagement__c();
        ncItems = new List<NC_Item__c>();
          //----------------Code for Custom picklist starts------------------------
       
        //--------------remove the separator ~Market,~BusinessUnit,~Category-----
            
        lstTemp = new Set<String>();
        setMarkets = new Set<String>();
        setBusinessUnits = new Set<String>();
        setCategoryArea = new Set<String>();
        
        mapHierarchyDetails1 = new map<String,Set<String>>();
        mapHierarchyDetails = SPE_MapUtility.returnMapValues();
       
        
        for(String s : mapHierarchyDetails.keyset()){
            if(s.contains('~Market')){
                setMarkets.add(s.split('~')[0]);
                
            }
            if(s.contains('~BusinessUnit')){
                setBusinessUnits.add(s.split('~')[0]);
                system.debug('setBusinessUnits'+setBusinessUnits);
            }
            if(s.contains('~CategoryArea')){
                setCategoryArea.add(s.split('~')[0]);
            }
        }
        for(String s : mapHierarchyDetails.keyset()){
            if(s.contains('~Market')){
                String s1 = s.replace('~Market','');
                mapHierarchyDetails1.put(s1,mapHierarchyDetails.get(s));
            }
            else{
                mapHierarchyDetails1.put(s,mapHierarchyDetails.get(s));
            }
            if(s.contains('~BusinessUnit')){
                String s1 = s.replace('~BusinessUnit','');
                mapHierarchyDetails1.put(s1,mapHierarchyDetails.get(s));
             }
            else{
                mapHierarchyDetails1.put(s,mapHierarchyDetails.get(s));
            }
            if(s.contains('~CategoryArea')){
                String s1 = s.replace('~CategoryArea','');
                mapHierarchyDetails1.put(s1,mapHierarchyDetails.get(s));
            }
            else{
                mapHierarchyDetails1.put(s,mapHierarchyDetails.get(s));
            }
        }
        
        //----------------Code for Custom picklist ends------------------------
        if(controller.getId() == null){
            marketVal = 'All Markets';
            marketUnitVal = 'All Market Units';
            countryVal = 'All Countries';
            projectVal = 'All Projects';
            buVal = 'All Business Units';
            blVal = 'All Business Lines';
            prdVal = 'All Products';
            caVal = 'All Category Areas';
            cgVal = 'All Category Groups';
            ctVal = 'All Categories';
            for(integer i = 1; i<=11 ; i++){
                NC_Item__c nc = new NC_Item__c(NC_Item_No__c= 'NC Item'+i);
                ncItems.add(nc);
                
            }
            selectedValue = ApexPages.currentPage().getParameters().get('recordTypeId');
            String auditId = [SELECT id from RecordType where Name =: selectedValue].Id;
            cmObj.RecordTypeId = auditId;
            displayNotifyButton = selectedValue.equalsIgnoreCase('Phase out')||selectedValue.equalsIgnoreCase('Audit') ? true :false;
        } 
        String isEdit = ApexPages.currentPage().getParameters().get('isEdit');
        String cmId = ApexPages.currentPage().getParameters().get('id');
        if(controller.getId() != null && isEdit =='true' && cmId != null){
            stdCon = controller;
            if(!test.isRunningTest())
            controller.addFields(SPE_SectionUtilityGenerator.getFieldsAPINames());
            this.cmObj= (SPE_ConsequenceManagement__c)controller.getRecord();            
            marketVal = cmObj.Market__c;
            marketUnitVal =cmObj.MarketUnit__c;
            countryVal = cmObj.Country__c;
            projectVal = cmObj.Project__c;
            buVal = cmObj.BusinessUnit__c;
            blVal = cmObj.BusinessLine__c;
            prdVal = cmObj.Product__c;
            caVal = cmObj.CategoryArea__c;
            cgVal = cmObj.CategoryGroup__c;
            ctVal = cmObj.Category__c;
            ncItems = [Select Id,Consequence_Management__c,NC_Item__c,NC_Item_No__c,Preferred_Month__c,Preferred_Year__c
                      From NC_Item__c Where Consequence_Management__c =:cmObj.Id order by Name];
            selectedValue = [SELECT Name FROM RecordType WHERE Id =: cmObj.RecordTypeId].Name;
            displayNotifyButton = selectedValue.equalsIgnoreCase('Audit Nc') ? true :false;
        }
        isClone = ApexPages.currentPage().getParameters().get('isClone');
        system.debug('Isclone:::'+isClone);
        system.debug('Isclone12456:::'+isEdit);
        if(isEdit =='false' && isClone != null){
            cmObj = [SELECT Title__c,Supplier__c,Supplier_name__c,Supplier_Address__c,Audit_Type__c,Audit_Date__c,Preferred_Month__c,Preferred_Year__c,
                         BusinessLine__c,BusinessUnit__c,Product__c,Market__c,MarketUnit__c,Country__c,Project__c,Category__c,
                         CategoryArea__c,CategoryCluster__c,CategoryGroup__c,CategoryManager__c,X3DOwnerApproveReject__c,
                         ProblemDescriptionDetails__c,AnalysisFindings__c,Datefailurefirstobserved__c,Contributor__c,Problem_Analysis_Completed__c,
                         X3DOwnerResponse__c,X3DDueDate__c,X4DDueDate__c,X5DDueDate__c,OwnerApproval__c,OwnerComments__c,ManufacturerComments__c,
                         X4DOwnerApproveReject__c,X5DOwnerApproveReject__c,X4DOwnerResponse__c,X5DOwnerResponse__c,X3DManufacturerResponse__c,
                         X3DSupplierContributors__c,X4DSupplierContributors__c,X5DSupplierContributors__c,X3DSupplierResponseComplete__c,
                         X3DDaysAllowed__c,ManufactureAcceptsFault__c,SupplierFaultAssumptionComplete__c,X4DSupplierResponse__c,X4DSupplierResponseComplete__c,
                         X4DDaysAllowed__c,X5DSupplierResponse__c,X5DSupplierResponseComplete__c,X5DDaysAllowed__c,Date_of_Expected_Closure__c,NC_Request__c,
                         CancelledNTFStatusExplanation__c,Lead_Auditor__c,Audit_Team__c,RecordTypeId
                         FROM SPE_ConsequenceManagement__c Where Id = :isClone];          
            marketVal = cmObj.Market__c;
            marketUnitVal =cmObj.MarketUnit__c;
            countryVal = cmObj.Country__c;
            projectVal = cmObj.Project__c;
            buVal = cmObj.BusinessUnit__c;
            blVal = cmObj.BusinessLine__c;
            prdVal = cmObj.Product__c;
            caVal = cmObj.CategoryArea__c;
            cgVal = cmObj.CategoryGroup__c;
            ctVal = cmObj.Category__c;
            cmObj.TicketStatus__c = 'Draft';
            cmObj.X3DManufacturerResponse__c = '';
            cmObj.X4DSupplierResponse__c = '';
            cmObj.X5DSupplierResponse__c = '';
            cmObj.OwnerComments__c = '';
            cmObj.X3DOwnerResponse__c = '';
            cmObj.X4DOwnerResponse__c = '';
            cmObj.X5DOwnerResponse__c = '';
            cmObj.X3DSupplierContributors__c = '';
            cmObj.X4DSupplierContributors__c = '';
            cmObj.X5DSupplierContributors__c = '';
            cmObj.OwnerApproval__c = '';
            cmObj.X3DOwnerApproveReject__c = '';
            cmObj.X4DOwnerApproveReject__c = '';
            cmObj.X5DOwnerApproveReject__c = '';
            cmObj.X3DSupplierResponseComplete__c = false;
            cmObj.DetailsDueDate__c = null;
            cmObj.X2DDueDate__c = null;
            cmObj.X3DDueDate__c = null;
            cmObj.X4DDueDate__c = null;
            cmObj.X5DDueDate__c = null;
            cmObj.ManufactureAcceptsFault__c = '';
            cmObj.ManufacturerComments__c = '';
            cmObj.SupplierComments__c = '';
            cmObj.OwnerIsMfrInvolvedinSPECase__c = '';
            cmObj.DevelopmentExpectation__c = '';
            cmObj.SupplierFaultAssumptionComplete__c = false;
            cmObj.X4DSupplierResponseComplete__c = false;
            cmObj.X5DSupplierResponseComplete__c = false;
            cmObj.Problem_Analysis_Completed__c = false;
            cmObj.ProblemDescriptionDetails__c = '';
            cmObj.Datefailurefirstobserved__c = null;
            ncItems = [Select Id,Consequence_Management__c,NC_Item__c,NC_Item_No__c,Preferred_Month__c,Preferred_Year__c
                      From NC_Item__c Where Consequence_Management__c =:cmObj.Id order by Name];
            selectedValue = [SELECT Name FROM RecordType WHERE Id =: cmObj.RecordTypeId].Name;
            displayNotifyButton = selectedValue.equalsIgnoreCase('Audit Nc') ? true :false;
        }
    }
      public pageReference cancel(){
        PageReference pageRef;
        if(isClone != '' && isClone != null){
            pageRef = new PageReference('/'+isClone);
            pageRef.setRedirect(true);
            return pageRef ;
        }
        if(ApexPages.currentPage().getParameters().get('isEdit') == 'true'){
            pageRef = new PageReference('/'+ApexPages.currentPage().getParameters().get('id'));
            pageRef.setRedirect(true);
            return pageRef ;
        }
        else{
            pageRef = new PageReference('/apex/SPE_ConsequencesRecordType');
            pageRef.setredirect(true);
            return pageRef ;
        }
        return null;
    }
    public void createNCitems(){
        NC_Item__c nc = new NC_Item__c();
        ncItems.add(nc);
    }
    public pagereference save(){
        createAuditTicket();
        Pagereference pg;
        if(isClone == null){
            pg = new Pagereference('/'+cmObj.id);
        }else{
            pg = new Pagereference('/'+cmObjClone.id);
        }
        return pg;
    }
    public PageReference saveNotifyTicket(){
        createAuditTicket();
        Pagereference pg;
        if(isClone == null){
            cmObj.TicketStatus__c = 'Open'; 
            update cmObj;        
            pg = new Pagereference('/'+cmObj.id);
        }else{
            cmObjClone.TicketStatus__c = 'Open'; 
            update cmObjClone;        
            pg = new Pagereference('/'+cmObjClone.id);
        }        
        return pg;
    }
    public void removeNCItem(){
        Integer index = integer.valueOf(ApexPages.currentPage().getParameters().get('indexVal'));
        ncItems.remove(index);
    }
    public void createAuditTicket(){
        cmObj.Category__c = ctVal;
        cmObj.CategoryArea__c = caval;
        cmObj.CategoryGroup__c = cgval;
        cmObj.BusinessLine__c = blval;
        cmObj.BusinessUnit__c = buval;
        cmObj.Product__c = prdval;
        cmObj.Market__c = marketval;
        cmObj.MarketUnit__c = marketUnitVal;
        cmObj.Country__c = countryVal;
        cmObj.Project__c = projectVal;
        cmObj.recordTypeId = [SELECT DeveloperName,Id,Name FROM RecordType WHERE SobjectType = 'SPE_ConsequenceManagement__c' AND DeveloperName = 'Audit_NC'].id;
        if(isClone == null){
            upsert cmObj;
        }
        else{
            cmObjClone = cmObj.clone();
            insert cmObjClone;
            
        }
        cmObj = [SELECT Id,Title__c,Supplier__c,Supplier_Address__c,Audit_Type__c,Audit_Date__c,Preferred_Month__c,Preferred_Year__c,
                     BusinessLine__c,BusinessUnit__c,Product__c,Market__c,MarketUnit__c,Country__c,Project__c,Category__c,
                     CategoryArea__c,CategoryCluster__c,CategoryGroup__c,CategoryManager__c,Supplier_name__c,Lead_Auditor__c,Audit_Team__c
                     FROM SPE_ConsequenceManagement__c Where Id = :cmObj.Id];
        
        string ExecutionPeriod = cmObj.Preferred_Month__c +' - '+cmObj.Preferred_Year__c;        
        for(NC_Item__c nc :ncItems){
            nc.Consequence_Management__c = cmObj.Id;
        }
        try{
            if(isClone == null){
                upsert ncItems;
            }
            else{
                List<NC_Item__c> ncItemsToClone = [Select Consequence_Management__c,NC_Item__c,NC_Item_No__c,Audit_Type__c,Preferred_Month__c,Preferred_Year__c
                                                  From NC_Item__c Where Consequence_Management__c =:isClone];
                List<NC_Item__c> ncItemsToInsert = new List<NC_Item__c>();
                for(NC_Item__c nc :ncItemsToClone){
                    NC_Item__c nc1 = new NC_Item__c();
                    nc1.Consequence_Management__c = cmObjClone.Id;
                    nc1.NC_Item__c = nc.NC_Item__c;
                    nc1.NC_Item_No__c = nc.NC_Item_No__c;
                    nc1.Audit_Type__c = nc.Audit_Type__c;
                    nc1.Preferred_Month__c = nc.Preferred_Month__c;
                    nc1.Preferred_Year__c = nc.Preferred_Year__c;
                    ncItemsToInsert.add(nc1);
                }
                insert ncItemsToInsert;
            }           
            Set<String> kpiIds = new Set<String>();
            Set<String> executionperiods = new Set<String>();            
            
            for(NC_Item__c nc2 :[Select Id,NC_Item__c,Preferred_Month__c,Preferred_Year__c From NC_Item__c Where Consequence_Management__c =: cmObj.Id]){
                if(nc2.NC_Item__c != null){
                    kpiIds.add(nc2.NC_Item__c);
                }
                if(nc2.Preferred_Month__c != null && nc2.Preferred_Year__c != null && nc2.Preferred_Month__c != '' && nc2.Preferred_Year__c != ''){
                    executionperiods.add(nc2.Preferred_Month__c +' - '+nc2.Preferred_Year__c);
                }
            }
            
            List<SPE_KPIValue__c> kpiValList = new List<SPE_KPIValue__c>();
            kpiValList = [select id,KPI_Text_Value__c,KPIDefinition__c From  SPE_KPIValue__c 
                          where EnterpriseIDEncrypted__c =:cmObj.Supplier__c and ExecutionPeriod__c =:ExecutionPeriod and
                          KPIDefinition__c IN:kpiIds and CategoryGroup__c ='All Category Groups' and Cluster__c ='All Category Areas' and
                          Category__c ='All Categories' and Region__c ='All Markets' and SubRegion__c ='All Market Units' and
                          Project__c ='All Projects' and Country__c ='All Countries' and BusinessLine__c ='All Business Lines' and
                          BusinessUnit__c ='All Business Units' and Product__c ='All Products'];
            
            
            Map<String,String> kpiToNcAuditType = new Map<String,String>();
            for(SPE_KPIValue__c kp :kpiValList){
                kpiToNcAuditType.put(kp.KPIDefinition__c,kp.KPI_Text_Value__c);
            }
            
            for(NC_Item__c nc1 :ncItems){
                nc1.Audit_Type__c = string.valueOf(kpiToNcAuditType.get(nc1.NC_Item__c));
            }
            update ncItems;
        }
        catch(Exception e){
            system.debug('msg::'+e.getMessage());
        }
        SPE_KPIValue__c kpiVal = new SPE_KPIValue__c();
        try{
            kpiVal = [select id,KPI_Text_Value__c from  SPE_KPIValue__c 
                      where EnterpriseIDEncrypted__c =:cmObj.Supplier__c and ExecutionPeriod__c =:ExecutionPeriod and
                      KPIDefinition__c =:cmObj.Audit_Type__c And CategoryGroup__c ='All Category Groups' and Cluster__c ='All Category Areas' and
                          Category__c ='All Categories' and Region__c ='All Markets' and SubRegion__c ='All Market Units' and
                          Project__c ='All Projects' and Country__c ='All Countries' and BusinessLine__c ='All Business Lines' and
                          BusinessUnit__c ='All Business Units' and Product__c ='All Products' limit 1];
        }catch(exception e){}
        SPE_KPIValue__c kpiVal1 = new SPE_KPIValue__c();
        try{
            kpiVal1 = [select id,KPI_Text_Value__c from  SPE_KPIValue__c 
                      where EnterpriseIDEncrypted__c =:cmObj.Supplier__c and ExecutionPeriod__c =:ExecutionPeriod and
                      KPIDefinition__c =:cmObj.Audit_Date__c and CategoryGroup__c ='All Category Groups' and Cluster__c ='All Category Areas' and
                      Category__c ='All Categories' and Region__c ='All Markets' and SubRegion__c ='All Market Units' and
                      Project__c ='All Projects' and Country__c ='All Countries' and BusinessLine__c ='All Business Lines' and
                      BusinessUnit__c ='All Business Units' and Product__c ='All Products' limit 1]; 
            
            system.debug('Audit Value'+kpiVal1);
        }catch(exception e){}
        SPE_KPIValue__c kpiVal2 = new SPE_KPIValue__c();
        try{
            kpiVal2 = [select id,KPI_Text_Value__c from  SPE_KPIValue__c 
                      where EnterpriseIDEncrypted__c =:cmObj.Supplier__c and ExecutionPeriod__c =:ExecutionPeriod and
                      KPIDefinition__c =:cmObj.Supplier_Address__c and CategoryGroup__c ='All Category Groups' and Cluster__c ='All Category Areas' and
                      Category__c ='All Categories' and Region__c ='All Markets' and SubRegion__c ='All Market Units' and
                      Project__c ='All Projects' and Country__c ='All Countries' and BusinessLine__c ='All Business Lines' and
                      BusinessUnit__c ='All Business Units' and Product__c ='All Products' limit 1]; 
            
            system.debug('Audit Value'+kpiVal2);
        }catch(exception e){}
        SPE_KPIValue__c kpiVal3 = new SPE_KPIValue__c();
        try{
            system.debug('ExecutionPeriod::'+ExecutionPeriod+'::'+cmObj.Supplier_name__c);
            kpiVal3 = [select id,KPI_Text_Value__c from  SPE_KPIValue__c 
                      where EnterpriseIDEncrypted__c =:cmObj.Supplier__c and ExecutionPeriod__c =:ExecutionPeriod and
                      KPIDefinition__c =:cmObj.Supplier_name__c and CategoryGroup__c ='All Category Groups' and Cluster__c ='All Category Areas' and
                      Category__c ='All Categories' and Region__c ='All Markets' and SubRegion__c ='All Market Units' and
                      Project__c ='All Projects' and Country__c ='All Countries' and BusinessLine__c ='All Business Lines' and
                      BusinessUnit__c ='All Business Units' and Product__c ='All Products' limit 1]; 
            
            system.debug('Audit Value::'+kpiVal3);
        }catch(exception e){}
        SPE_KPIValue__c kpiVal4 = new SPE_KPIValue__c();
        try{
            system.debug('ExecutionPeriod::'+ExecutionPeriod+'::'+cmObj.Supplier_name__c);
            kpiVal4 = [select id,KPI_Text_Value__c from  SPE_KPIValue__c 
                      where EnterpriseIDEncrypted__c =:cmObj.Supplier__c and ExecutionPeriod__c =:ExecutionPeriod and
                      KPIDefinition__c =:cmObj.Lead_Auditor__c and CategoryGroup__c ='All Category Groups' and Cluster__c ='All Category Areas' and
                      Category__c ='All Categories' and Region__c ='All Markets' and SubRegion__c ='All Market Units' and
                      Project__c ='All Projects' and Country__c ='All Countries' and BusinessLine__c ='All Business Lines' and
                      BusinessUnit__c ='All Business Units' and Product__c ='All Products' limit 1]; 
            
            system.debug('Audit Value:123:'+kpiVal4);
        }catch(exception e){}
        SPE_KPIValue__c kpiVal5 = new SPE_KPIValue__c();
        try{
            system.debug('ExecutionPeriod::'+ExecutionPeriod+'::'+cmObj.Supplier_name__c);
            kpiVal5 = [select id,KPI_Text_Value__c from  SPE_KPIValue__c 
                      where EnterpriseIDEncrypted__c =:cmObj.Supplier__c and ExecutionPeriod__c =:ExecutionPeriod and
                      KPIDefinition__c =:cmObj.Audit_Team__c and CategoryGroup__c ='All Category Groups' and Cluster__c ='All Category Areas' and
                      Category__c ='All Categories' and Region__c ='All Markets' and SubRegion__c ='All Market Units' and
                      Project__c ='All Projects' and Country__c ='All Countries' and BusinessLine__c ='All Business Lines' and
                      BusinessUnit__c ='All Business Units' and Product__c ='All Products' limit 1]; 
            
            system.debug('Audit Value:asdfg:'+kpiVal5);
        }catch(exception e){}
        if(kpiVal != null){
            if(isClone == null){
                cmObj.Audit_Value__c =  string.valueOf(kpiVal.KPI_Text_Value__c);  
            }else{
                cmObjClone.Audit_Value__c =  string.valueOf(kpiVal.KPI_Text_Value__c);
            }           
        }
        if(kpiVal1 != null){
            if(isClone == null){
                cmObj.Audit_Value1__c = string.valueOf(kpiVal1.KPI_Text_Value__c);   
            }else{
                cmObjClone.Audit_Value1__c = string.valueOf(kpiVal1.KPI_Text_Value__c); 
            }           
        }
        if(kpiVal2 != null){
            if(isClone == null){
                cmObj.Supplier_Address_Value__c = string.valueOf(kpiVal2.KPI_Text_Value__c); 
            }else{
                cmObjClone.Supplier_Address_Value__c = string.valueOf(kpiVal2.KPI_Text_Value__c); 
            }
            
        }
        if(kpiVal3 != null){
            if(isClone == null){
                cmObj.Supplier_Val__c = string.valueOf(kpiVal3.KPI_Text_Value__c);    
            }else{
                cmObjClone.Supplier_Val__c = string.valueOf(kpiVal3.KPI_Text_Value__c);
            }         
        } 
        if(kpiVal4 != null){
            if(isClone == null){
                cmObj.Lead_Auditor_Value__c = string.valueOf(kpiVal4.KPI_Text_Value__c);    
            }else{
                cmObjClone.Lead_Auditor_Value__c = string.valueOf(kpiVal4.KPI_Text_Value__c);
            }         
        } 
        if(kpiVal5 != null){
            if(isClone == null){
                cmObj.Audit_Team_Value__c = string.valueOf(kpiVal5.KPI_Text_Value__c);    
            }else{
                cmObjClone.Audit_Team_Value__c = string.valueOf(kpiVal5.KPI_Text_Value__c);
            }         
        }
        //cmObj.CategoryManager__c = UserInfo.getUserId();
        try{    
            if(isClone == null){
                update cmObj;
            }else{
                update cmObjClone;
            }
        }catch(exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
    }
    
    //----------------Code for Custom picklist starts------------------------
  
   //-----------------Fetch dropdown values of Market-------------
  
    public List<SelectOption> getMarketValues() {
        List<SelectOption> options = new List<SelectOption>();
        system.debug('SetmarketsValues'+setMarkets);
       
        if(!setMarkets.contains(PicklistDefaultValues__c.getall().values()[0].Market__c)){
            options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Market__c,PicklistDefaultValues__c.getall().values()[0].Market__c));
        }
        for(String s : setMarkets){
            options.add(new SelectOption(s,s));
        }
        system.debug('market is'+marketVal);
        
        return options;
    }
   
    //------- Fetch dropdown values of Market Unit ---------------
    
    public List<SelectOption> getMarketUnitValues(){   
        fillMarketUnit();
        return mkoptions;
    }
    
    public void fillMarketUnit(){
        if(Apexpages.currentPage().getParameters().get('marketVal')!= null){
            marketVal = Apexpages.currentPage().getParameters().get('marketVal');
       }
            mkoptions = new List<SelectOption>();
            Set<String> setMUVal = new Set<String>();
            
            system.debug('marketVal----' + marketVal);
            system.debug('mapHierarchyDetails1.get(marketVal)----' + mapHierarchyDetails1);
            setMUVal = mapHierarchyDetails1.get(marketVal);
            system.debug('setMUVal----' + setMUVal);
            if(!setMUVal.contains(PicklistDefaultValues__c.getall().values()[0].Market_Unit__c))
            mkoptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Market_Unit__c,PicklistDefaultValues__c.getall().values()[0].Market_Unit__c));
            
            system.debug('marketVal---' + marketVal); 
            for(String s : mapHierarchyDetails1.get(marketVal)){
                mkoptions.add(new SelectOption(s,s));
            }
        
    }
    //----------------Fetch Dropdown Values for Country -----------------
        
    public List<SelectOption> getCountryValues(){   
        fillCountry();
        return countryOptions;
    }
        
    public void fillCountry(){
        if(Apexpages.currentPage().getParameters().get('marketUnitVal')!= null)
            
            marketUnitVal = Apexpages.currentPage().getParameters().get('marketUnitVal');
            countryOptions = new List<SelectOption>();
            
            if((marketVal == PicklistDefaultValues__c.getall().values()[0].Market__c) || !(mapHierarchyDetails1.containsKey(marketVal+marketUnitVal))){
                countryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Country__c,PicklistDefaultValues__c.getall().values()[0].Country__c));
            }
            else if(marketUnitVal != PicklistDefaultValues__c.getall().values()[0].Market_Unit__c){
                Set<String> setCVal = new Set<String>();
                setCVal = mapHierarchyDetails1.get(marketVal+marketUnitVal);
                if(!setCVal.contains(PicklistDefaultValues__c.getall().values()[0].Country__c)){
                    countryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Country__c,PicklistDefaultValues__c.getall().values()[0].Country__c));
                }
                system.debug('marketUnitVal---' + marketUnitVal); 
                for(String s : mapHierarchyDetails1.get(marketVal+marketUnitVal)){
                    countryOptions.add(new SelectOption(s,s));
                }
            }
            else{
                countryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Country__c,PicklistDefaultValues__c.getall().values()[0].Country__c));
            }
        
    }
        
     //------------------Fetch dropdown values of Project------------------
    
    public List<SelectOption> getProjectValues(){   
        fillProject();
        return projectOptions;
    }
        
    public void fillProject(){
        if(Apexpages.currentPage().getParameters().get('countryVal')!= null)
            countryVal = Apexpages.currentPage().getParameters().get('countryVal');
            projectOptions = new List<SelectOption>();
            
            if((marketVal == PicklistDefaultValues__c.getall().values()[0].Market__c) || 
                (marketUnitVal == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c) || 
                (countryVal == PicklistDefaultValues__c.getall().values()[0].Country__c) || 
                !(mapHierarchyDetails1.containsKey(marketVal+marketUnitVal+countryVal)) ){
                    
                    projectOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Project__c,PicklistDefaultValues__c.getall().values()[0].Project__c));
            }
        
            else if(countryVal != PicklistDefaultValues__c.getall().values()[0].Country__c){
                Set<String> setCVal = new Set<String>();
                setCVal = mapHierarchyDetails1.get(marketVal+marketUnitVal+countryVal);
                 if(!setCVal.contains(PicklistDefaultValues__c.getall().values()[0].Project__c)){
                    projectOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Project__c,PicklistDefaultValues__c.getall().values()[0].Project__c));
                 }
                system.debug('marketUnitVal---' + marketUnitVal); 
                for(String s : mapHierarchyDetails1.get(marketVal+marketUnitVal+countryVal)){
                    projectOptions.add(new SelectOption(s,s));
                }
            }
            else{
                projectOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Project__c,PicklistDefaultValues__c.getall().values()[0].Project__c));
            }
        
    }
        
    //--------------Fetch dropdown values of Business Units------------------------------
        
    public List<SelectOption> getBusinessUnitValues(){
        List<SelectOption> options = new List<SelectOption>();
        if(!setBusinessUnits.contains(PicklistDefaultValues__c.getall().values()[0].Business_Unit__c))
            options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Business_Unit__c,PicklistDefaultValues__c.getall().values()[0].Business_Unit__c));
        for(String s : setBusinessUnits){
            options.add(new SelectOption(s,s));
        }
        
        return options;
    }
     
    //--------------------Fetch dropdown values for Business Line-------------------
     
    public List<SelectOption> getBusinesLineValues(){   
        fillBusinessLine();
        return BusinessLineOptions;
    }
        
   public void fillBusinessLine(){
        if(Apexpages.currentPage().getParameters().get('buVal')!= null)
            buVal= Apexpages.currentPage().getParameters().get('buVal');
            BusinessLineOptions= new List<SelectOption>();
            Set<String> setBUVal = new Set<String>();
            setBUVal = mapHierarchyDetails1.get(buVal);
             if(!setBUVal.contains(PicklistDefaultValues__c.getall().values()[0].Business_Line__c)){
                BusinessLineOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Business_Line__c,PicklistDefaultValues__c.getall().values()[0].Business_Line__c));
             }
       
            for(String s : mapHierarchyDetails1.get(buVal)){
                BusinessLineOptions.add(new SelectOption(s,s));
            }
        
    }
    //----------------Fetch dropdown values for Product------------------------------
    
    public List<SelectOption> getProductValues(){   
        fillProduct();
        return ProductOptions;
    }
        
    public void showProdVals(){
        fillProduct();
    }
        
    public void fillProduct(){
        
        if(Apexpages.currentPage().getParameters().get('blVal')!= null)
            blVal= Apexpages.currentPage().getParameters().get('blVal');
            system.debug('I am here-blVal--' + blVal);
            system.debug('I am here-buVal--' + buVal);
            ProductOptions= new List<SelectOption>();
            lstTemp = new Set<String>();
            Set<String> setProductVal = new Set<String>();
            setProductVal = mapHierarchyDetails1.get(buVal+blVal);
            
             if((buVal == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c) || !(mapHierarchyDetails1.containsKey(buVal+blVal))){
              system.debug('I am here---');
              ProductOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Product__c,PicklistDefaultValues__c.getall().values()[0].Product__c));
              lstTemp.add(PicklistDefaultValues__c.getall().values()[0].Product__c);
            }
            else if(!setProductVal .contains(PicklistDefaultValues__c.getall().values()[0].Product__c)){
                ProductOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Product__c,PicklistDefaultValues__c.getall().values()[0].Product__c));
                lstTemp.add(PicklistDefaultValues__c.getall().values()[0].Product__c);   
                for(String s : mapHierarchyDetails1.get(buVal+blVal)){
                    ProductOptions.add(new SelectOption(s,s));
                    lstTemp.add(s);  
                }
            }
            else{
             ProductOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Product__c,PicklistDefaultValues__c.getall().values()[0].Product__c));
             lstTemp.add(PicklistDefaultValues__c.getall().values()[0].Product__c);
            }
        
    }
    //--------------Fetch dropdown values for Category Area--------------------
    
      
    public List<SelectOption> getCategoryAreaValues(){
        List<SelectOption> options = new List<SelectOption>();
        if(!setCategoryArea.contains(PicklistDefaultValues__c.getall().values()[0].Category_Area__c))
            options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category_Area__c,PicklistDefaultValues__c.getall().values()[0].Category_Area__c));
             for(String s : setCategoryArea ){
                options.add(new SelectOption(s,s));
            }
        
        return options;
    }
     
    //-----------------Fetch dropdown values for Category Group---------------------------
    
    public List<SelectOption> getCategoryGroupValues(){   
            fillCategoryGroup();
            return CatGroupOptions;
    }
        
   public void fillCategoryGroup(){
        if(Apexpages.currentPage().getParameters().get('caVal')!= null){
            blVal= Apexpages.currentPage().getParameters().get('caVal');
        }
            CatGroupOptions= new List<SelectOption>();
            Set<String> setCatGroupVal = new Set<String>();
            system.debug('caVal'+caVal);
            system.debug('setCatGroupVal'+mapHierarchyDetails1.get(caVal));
            setCatGroupVal = mapHierarchyDetails1.get(caVal);
            if(!setCatGroupVal .contains(PicklistDefaultValues__c.getall().values()[0].Category_Group__c)){
                CatGroupOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category_Group__c,PicklistDefaultValues__c.getall().values()[0].Category_Group__c));
            }
            for(String s : mapHierarchyDetails1.get(caVal)){
                CatGroupOptions.add(new SelectOption(s,s));
            }
        
            
    }
    
    //----------------------Fetch drop down values for Category----------------------------
    
    public List<SelectOption> getCategoryValues(){   
        fillCategory();
        return CategoryOptions;
    }
        
    public void fillCategory(){
        if(Apexpages.currentPage().getParameters().get('cgVal')!= null)
             blVal= Apexpages.currentPage().getParameters().get('cgVal');
            CategoryOptions= new List<SelectOption>();
            Set<String> setCatVal = new Set<String>();
            setCatVal = mapHierarchyDetails1.get(caVal+cgVal);
            if((caVal== PicklistDefaultValues__c.getall().values()[0].Category_Area__c) || !(mapHierarchyDetails1.containsKey(caVal+cgVal))){
                CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
            }
            
            else  if(!setCatVal .contains(PicklistDefaultValues__c.getall().values()[0].Category__c)){
                CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
                for(String s : mapHierarchyDetails1.get(caVal+cgVal)){
                    CategoryOptions.add(new SelectOption(s,s));
                }
            }
            else{
                CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
            }
        
    }
        
    public void blankMethod(){
         if(Apexpages.currentPage().getParameters().get('rerenderForm11')!= null)
            prdVal= Apexpages.currentPage().getParameters().get('rerenderForm11');
     }
 //----------------Code for Custom picklist ends------------------------
   
   public Component.Apex.PageBlock getDynamicForm() 
   {
    Set<String> requiredFields = SPE_SectionUtilityGenerator.getRequiredFields();
    Component.Apex.PageBlock outerPageBlock = new Component.Apex.PageBlock();
    outerPageBlock.Id = 'conmgmt';
    for (String secTitle: SPE_SectionUtilityGenerator.getPageSectionValueMap().get(selectedValue))
    {
        Component.Apex.pageBlockSection pbSection = new Component.Apex.pageBlockSection();
        pbSection.title= secTitle ;
        pbSection.Id = secTitle.replaceAll( '\\s+', '').replaceAll('[/&]', '');
        pbSection.collapsible= false;
        pbSection.columns= 2 ;
        map<String,Boolean> fieldsApiMap = SPE_SectionUtilityGenerator.getSectionFieldvalueMap().get(secTitle);
        for (String secField1 : fieldsApiMap.KeySet())
        {
            if ((secField1 != 'BLANK' && !secField1.equalsIgnoreCase('SPETracker__c')) || (secField1 != 'BLANK' && secField1.equalsIgnoreCase('SPETracker__c') && cmObj.SPETracker__c != null))
            {
                String  secField = 'cmObj.' + secField1;
                Boolean isInputField = fieldsApiMap.get(secField1);  
                system.debug('isInputField value@@@@@@@@'+isInputField+'SecField Value**'+secField);
                if(isInputField)
                {
                    Component.Apex.inputField inputField = new Component.Apex.inputField(); 
                    inputField.expressions.value = '{!'+secField+'}' ;
                    inputField.required = requiredFields.contains(secField1);
                    if (secField1.equalsIgnoreCase('KPIName__c')){
                        inputField.id = 'KPIFieldvalue';
                    }
                    if (secField1.equalsIgnoreCase('SPETracker__c')){
                        inputField.id = 'speTrackerFieldValue';
                        inputField.onselect = 'callActionMethod()'; 
                    }
                     system.debug('inputField********'+inputField);
                    pbSection.childComponents.add(inputField);
                }
                else
                {
                    if (!secField1.equalsIgnoreCase('OpenDate__c') || (secField1.equalsIgnoreCase('OpenDate__c') && cmObj.TicketStatus__c != 'Draft' && cmObj.TicketStatus__c !=  null) )
                    {
                        Component.Apex.outputField outputField = new Component.Apex.outputField();
                        outputField.expressions.value = '{!'+secField+'}' ;
                        pbSection.childComponents.add(outputField);
                    }
                }
            }
            else if (secField1 == 'BLANK')
            {
                Component.Apex.inputHidden inputHidden = new Component.Apex.inputHidden();
                string test = 'Title__c';
                inputHidden.expressions.value = '{!'+test+'}' ;
                pbSection.childComponents.add(inputHidden);
            }
        }   
            outerPageBlock.childComponents.add(pbSection); 
    }
    return outerPageBlock;
    }
    
}