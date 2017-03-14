public class SPE_TestObjectCreator 
{
    public static SPE_SurveyQuestion__c CreateSurveyQuestion()
    {
        SPE_SurveyQuestion__c surQue = new SPE_SurveyQuestion__c();
        surQue.Name = 'SPE_Test Question';
        surQue.SurveyQuestion__c = 'What color is your hair?';
        surQue.AnswerType__c = 'Picklist';
        surQue.IsActive__c = true;
        surQue.QuestionAbbreviation__c = 'SPE_Que';
        return surQue;
    }
    
    public static SPE_SurveyAnswer__c CreateSurveyAnswer()
    {
        SPE_SurveyAnswer__c ans = new SPE_SurveyAnswer__c();
        ans.Choices__c = 'Black';
        ans.Score__c = 1;
        
        return ans;
    }
    
    public static SPE_PIDefinition__c CreatePIDefinition()
    {
        SPE_PIDefinition__c piDef = new SPE_PIDefinition__c();
        
        //************Changes Done for Encryption***********//
        
        //piDef.Name = 'Test PI Definition';
        piDef.PI_Title__c = 'Test PI Definition';
        
        //************ Changes End*******************//
        piDef.LifecycleStage__c = 'Draft';
        piDef.SourceDataOwner__c = 'testing';
        piDef.ValuesType__c = 'Number';
        piDef.OperationalType__c = 'Leading KPI';
        piDef.Type__c = 'Operational';
        piDef.DataAcquisitionMethod__c = 'Testing ';
        piDef.UoM__c = 'max';
        piDef.Business__c = 'NPP';
        piDef.GeoScope__c = 'All Markets';
        piDef.CategoryScope__c = 'All Categories';
        piDef.BUScope__c = 'All Products';
        piDef.Frequency__c = '0';
        piDef.ValuesType__c='Number';
        
        return piDef;
    }
    
    public static SPE_PIValues__c CreatePIValues(Id piDefId, Id supplierId, String enterpriseId)
    {
        SPE_PIValues__c piValue = new SPE_PIValues__c();
        piValue.PIDefination__c = piDefId;
        piValue.Supplier__c = supplierId;
        piValue.EnterpriseID__c = enterpriseId;
        
        piValue.Region__c = 'All Markets';
        piValue.SubRegion__c = 'All Market Units';
        piValue.Country__c = 'All Countries';
        piValue.Project__c = 'All Projects';
        
        piValue.Cluster__c = 'All Category Areas';
        piValue.CategoryGroup__c = 'All Category Groups';
        piValue.Category__c = 'All Categories';
        
        piValue.BusinessUnit__c = 'All Business Units';
        piValue.BusinessLine__c = 'All Business Lines';
        piValue.Product__c = 'All Products';
        
        piValue.Period__c = Date.today().addMonths(-1);
        piValue.NumberValue__c = 10;
        
        return piValue; 
    }
    
    public static Account CreateSupplier(String enterprise)
    {
        Account a = new Account();
        a.Name = enterprise;
        a.EnterpriseId__c = enterprise;
        
        return a;
    }
    
    public static Contact CreateContact(String LastName)
    {
        Contact con = new Contact();
        con.LastName = LastName;
        con.Email = 'abc@nokia.com';
        
        return con;
    }
    
    public static SPE_KPIDefinition__c CreateKPIDefinition(Integer i)
    {
        SPE_KPIDefinition__c kpiDefinition = new SPE_KPIDefinition__c();
        
        //************Changes Done for Encryption***********//
        //kpiDefinition.Name = 'Test KPI Definition' + i;
        kpiDefinition.KPI_Title__c = 'Test KPI Definition' + i;
        //************Changes End***********//
        
        kpiDefinition.AbbreviatedName__c = 'TKPIDef' + i;
        kpiDefinition.Level__c = '1';
        kpiDefinition.LifecycleStage__c = 'Draft';
        kpiDefinition.Description__c = 'Test';
        kpiDefinition.MissingDatalogic__c = 'Past Data or Category Average';
        kpiDefinition.OperationalType__c = 'Leading PI';
        kpiDefinition.GeoScope__c = 'All Markets';
        kpiDefinition.categoryscope__c = 'All Categories';
        kpiDefinition.BUScope__c = 'All Products';
        kpiDefinition.UoM__c = 'max';
        kpiDefinition.Group1__c = 'Cost';
        kpiDefinition.Group2__c = 'Hard';
        kpiDefinition.Type__c = 'Operational';
        kpiDefinition.FrequencyinMonth__c = '2';
        kpiDefinition.ScheduledDate__c = system.today().addDays(5);
        
        return kpiDefinition;
            
    }
   public static SPE_SPETemplate__c CreateSPETemplate ()
    {
        SPE_SPETemplate__c speTemplate = new SPE_SPETemplate__c();
        speTemplate.Name = 'Test SPE TEmplate';
        speTemplate.Stage__c = 'Draft';
        
        speTemplate.Region__c = 'All Markets';
        speTemplate.SubRegion__c = 'All Market Units';
        speTemplate.Country__c = 'All Countries';
        speTemplate.Project__c = 'All Projects';
        
        speTemplate.CategoryCluster__c = 'All Category Areas';
        speTemplate.CategoryGroup__c = 'All Category Groups';
        speTemplate.Category__c = 'All Categories';
        
        speTemplate.BusinessLine__c ='All Business Units';
        speTemplate.BusinessUnit__c ='All Business Lines';
        speTemplate.Product__c = 'All Products';
        
        return speTemplate;
    }
    
    public static SPE_ScoringTemplate__c CreateScoringTemplate(SPE_SPETemplate__c speTemplate)
    {
        SPE_ScoringTemplate__c scoringTemplate = new SPE_ScoringTemplate__c();
        scoringTemplate.Name = 'Test Demo scoring Template 1234';
        scoringTemplate.SPETemplate__c = speTemplate.Id;
        
        speTemplate.Region__c = 'All Markets';
        speTemplate.SubRegion__c = 'All Market Units';
        speTemplate.Country__c = 'All Countries';
        speTemplate.Project__c = 'All Projects';
        
        speTemplate.CategoryCluster__c = 'All Category Areas';
        speTemplate.CategoryGroup__c = 'All Category Groups';
        speTemplate.Category__c = 'All Categories';
        
        speTemplate.BusinessLine__c ='All Business Units';
        speTemplate.BusinessUnit__c ='All Business Lines';
        speTemplate.Product__c = 'All Products';
        speTemplate.Stage__c='Draft';
        
        return scoringTemplate;
    }
    
    public static SPE_SPEKPIMap__c CreateSPEKPI(SPE_KPIDefinition__c kpiDef, SPE_SPETemplate__c speTemp)
    {
        SPE_SPEKPIMap__c spekpi = new SPE_SPEKPIMap__c();
        
        spekpi.KPIDefinition__c = kpiDef.Id;
        spekpi.SPETemplate__c = speTemp.Id;
        spekpi.Weight__c = 100;
        
        return spekpi;
    }
    /*public static SPE_ConsequenceManagement__c CreateConsequenceMgmt(Account acc)
    {
    
        SPE_ConsequenceManagement__c conMgmt = new SPE_ConsequenceManagement__c();
        conMgmt.Title__c='Test 6'; 
        conMgmt.Supplier__c= acc.Id;
        conMgmt.CategoryGroup__c='IP Transport';
        conMgmt.CategoryArea__c='Indirect Procurement';
        conMgmt.CategoryCluster__c='Direct Procurement';
        
        return conMgmt; 
    }*/
    
    /*public static List<SPE_RegionMaster__c> CreateSPERegionMaster()
    {
        //return SPE_MasterDataTest.createMassRegionMaster();
        return null;
    }*/
    
    public static List<SPE_ProjectMaster__c> CreateSPEProjectMaster()
    {
        //return SPE_MasterDataTest.createMassProjectMaster();
        return null;
    }
    
    public static List<SPE_CategoryMaster__c> CreateCategoryMaster()
    {
        //return SPE_MasterDataTest.CreateMassCategoryMaster();
        return null;
    }
    
    public static List<SPE_BUBL__c> CreateBUBL()
    {
        //return SPE_MasterDataTest.CreateMassBUBLMaster();
        return null;
    }
    
    /*public static RecordType CreateRecordType()
    {
        RecordType rt = new RecordType();
        rt.SobjectType = 'Audit,Develop,Phase Out,Watchlist';
        rt.IsActive = True;
        
        return rt;
        
    }*/
    
    public static SPE_ScoringCalculation__c createScoringCalc(SPE_SPEKPIMap__c spekpi ,SPE_ScoringTemplate__c st )
    {
        SPE_ScoringCalculation__c sc = new SPE_ScoringCalculation__c();
        sc.KPIDefinition__c = spekpi.KPIDefinition__c;
        sc.Score__c = 1;
        sc.Lower__c = 0;
        sc.LowerTo__c = '>';
        sc.Upper__c = 50;
        sc.UpperTo__c = '<';
        sc.ScoringTemplate__c = st.Id;
        
        return sc;
    }
    
    public static SPE_KPICalculation__c createKPICalculation()
    {
        SPE_KPICalculation__c objKPICalc = new SPE_KPICalculation__c();
        objKPICalc.ConstantValue__c=1;
        objKPICalc.TimeFrame__c = 1.0;
        objKPICalc.Aggregation__c = 'Sum';
        objKPICalc.Index__c = 'A';
        objKPICalc.IndexName__c='Test Index';
        objKPICalc.Filter1__c = '1';
        objKPICalc.Filter2__c = '1';
        objKPICalc.Filter3__c = '1';
        objKPICalc.Filter4__c = '1';
        objKPICalc.Filter5__c = '1';
        objKPICalc.Filter6__c = '1';
        objKPICalc.Filter7__c = '1';
        objKPICalc.Filter8__c = '1';
        objKPICalc.Filter9__c = '1';
        objKPICalc.Filter10__c = '1';
        
        return objKPICalc;
    }
    
    public static Supplier_KPI_Callculation__c createSupplierKPICal()
    {
        Supplier_KPI_Callculation__c objSupKPICalc = new Supplier_KPI_Callculation__c();
        objSupKPICalc.IsAdhoc__c = false;
        
        return objSupKPICalc;
    }
    
    public static SPE_PITempValue__c createPITempValue()
    {
        SPE_PITempValue__c objPiTempValue = new SPE_PITempValue__c();             
        objPiTempValue.IsConstant__c = true;
        objPiTempValue.Period__c = system.today().adddays(3); 
        
        return objPiTempValue;
    }
    public static SPE_PIDefinition__c createPiBulkUpdate()
    {
       SPE_PIDefinition__c objPiDef = new SPE_PIDefinition__c();
     
     //********************Changes For Encryption***********************//
         //objPiDef.Name= 'Ajjjgd2';
         objPiDef.PI_Title__c = 'Ajjjgd2';  
     //********************END***********************//
       
       objPiDef.LifecycleStage__c='Draft';
       objPiDef.PIAbbreviation__c='TEST DEMO';
       objPiDef.DataAcquisitionMethod__c='Data Load';
       objPiDef.GeoScope__c='Project';
       objPiDef.CategoryScope__c='Category';
       objPiDef.BUScope__c='BusinessUnit';
       
       Date uploadDueDate = date.newinstance(Date.today().Year(), Date.today().Month(), 15);
       objPiDef.PIUploadDuedate__c = uploadDueDate;
       
       return objPiDef;
    }
    
    public static SPE_ProjectMaster__c CreateProjectMasterData(String Market, String MarketUnit, String Country, String Project)
    {
        SPE_ProjectMaster__c projectMaster = new SPE_ProjectMaster__c();
        projectMaster.Market__c = Market;
        projectMaster.MarketUnit__c = MarketUnit;
        projectMaster.Country__c = Country;
        projectMaster.Project__c = Project;
        
        return projectMaster;
    }
    
    public static SPE_BUBL__c CreateBUBLData(String BU, String BL, String Product)
    {
        SPE_BUBL__c BUBL = new SPE_BUBL__c();
        BUBL.BusinessUnit__c = BU;
        BUBL.BusinessLine__c = BL;
        BUBL.Product__c = Product;
        
        return BUBL;
    }
    
    public static SPE_CategoryMaster__c CreateCategoryData(String CategoryArea, String CategoryGroup, String Category)
    {
        SPE_CategoryMaster__c categoryMaster = new SPE_CategoryMaster__c();
        categoryMaster.Cluster__c = CategoryArea;
        categoryMaster.Group__c = CategoryGroup;
        categoryMaster.Category__c = Category;
        
        return categoryMaster;
    }
    
    public static PicklistDefaultValues__c CreateDefaultPicklist()
    {
        PicklistDefaultValues__c defaultValue = new PicklistDefaultValues__c();
        defaultValue.Name = 'Picklist Default Values';
        defaultValue.Market__c ='All Markets';
        defaultValue.Market_Unit__c = 'All MarketUnits';
        defaultValue.Country__c = 'All Countries';
        defaultValue.Project__c = 'All Projects';
        defaultValue.Business_Unit__c = 'All Business Units';
        defaultValue.Business_Line__c = 'All Business Lines';
        defaultValue.Product__c = 'All Products';
        defaultValue.Category_Area__c = 'All Category Areas';
        defaultValue.Category_Group__c = 'All Category Groups';
        defaultValue.Category__c = 'All Categories';
        
        return defaultValue;
    }
    
    public static SPE_SPEPlan__c CreateSPEPlan()
    {
        SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
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
        
        return spePlan;
    }
    
    public static SPE_CategoryInfo__c CreateCategoryInfo()
    {
        SPE_CategoryInfo__c categoryInfo = new SPE_CategoryInfo__c();
        
        categoryInfo.CategoryCluster__c = 'All Category Areas';
        categoryInfo.CategoryGroup__c = 'All Category Groups';
        categoryInfo.Category__c = 'All Categories';
        
        return categoryInfo;
    }
    public static SPE_SPETracker__c createSPETracker()
    {
      SPE_SPETracker__c speTracker = new SPE_SPETracker__c();
      
        speTracker.Region__c = 'All Markets';           
        speTracker.SubRegion__c = 'All Market Units';             
        speTracker.Country__c = 'All Countries';        
        speTracker.Project__c = 'All Projects';     
                
        speTracker.CategoryCluster__c = 'All Category Areas';       
        speTracker.CategoryGroup__c = 'All Category Groups';        
        speTracker.Category__c = 'All Categories';      
                
        speTracker.BusinessUnit__c = 'All Business Units';      
        speTracker.BusinessLine__c = 'All Business Lines';      
        speTracker.Product__c = 'All Products';     
                
        speTracker.Status__c='Pending';
        return speTracker;
    }
    
    public static SPE_TrackerValues__c createTrackerValue()
    {
      SPE_TrackerValues__c trackerValue = new SPE_TrackerValues__c();
      
      return trackerValue;
    }
    
    public static SPE_TrackerScore__c createTrackerScore()
    {     
    SPE_TrackerScore__c  trackerScore = new SPE_TrackerScore__c ();     
            
        trackerScore.Group__c = 'Operational';      
        trackerScore.KPIName__c='Test KPI';     
        trackerScore.Score__c=2;        
        return trackerScore;        
    }  
}