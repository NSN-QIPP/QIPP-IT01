@isTest(seeAllData=false)

public class SPE_NewScorecardTemplateExtTest{

    public static testMethod void TestSPE_NewScorecardTemplateExt(){
        
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
        
        SPE_ProjectMaster__c projectMaster = new SPE_ProjectMaster__c();                  
        projectMaster.Market__c = 'INDIA'; 
        projectMaster.MarketUnit__c = 'INDIA BHARTI';          
        projectMaster.Country__c = 'India';
        projectMaster.Project__c = 'In Bharti 4G';
        insert projectMaster;
        
        SPE_BUBL__c BUBL = new SPE_BUBL__c();
        BUBL.BusinessUnit__c = 'Global Services';
        BUBL.BusinessLine__c = 'Network Implementation';
        BUBL.Product__c = 'WinPower Silver';
        insert BUBL;
        
        SPE_CategoryMaster__c categoryMaster = new SPE_CategoryMaster__c();
        categoryMaster.Cluster__c = 'Indirect Procurement';
        categoryMaster.Group__c = 'Facility';
        categoryMaster.Category__c = 'Facility Services';
        insert categoryMaster;
        
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
        
        speTemp.BusinessUnit__c ='All Business Units';
        speTemp.BusinessLine__c ='All Business Lines';      
        speTemp.Product__c = 'All Products'; 
        insert speTemp;
        
        speTemp.Stage__c ='Pilot';
        update speTemp;
        
        SPE_SPETemplate__c speTemp1 = new SPE_SPETemplate__c();
        speTemp1.Name = 'Test SPE TEmplate 12344';
        speTemp1.Stage__c = 'Draft';
        
        speTemp1.Region__c = 'All Markets';
        speTemp1.SubRegion__c = 'All Market Units';
        speTemp1.Country__c = 'All Countries';
        speTemp1.Project__c = 'All Projects';
        
        speTemp1.CategoryCluster__c = 'All Category Areas';
        speTemp1.CategoryGroup__c = 'All Category Groups';
        speTemp1.Category__c = 'All Categories';
        
        speTemp1.BusinessUnit__c ='All Business Units';
        speTemp1.BusinessLine__c ='All Business Lines';      
        speTemp1.Product__c = 'All Products'; 
        insert speTemp1;
        
        speTemp1.Stage__c ='Pilot';
        update speTemp1;
        
        SPE_ScorecardTemplate__c sc = new SPE_ScorecardTemplate__c();
        sc.Name = 'Test ScoreTemplate';
        sc.Stage__c = 'Draft';
        
        sc.Region__c = 'INDIA';
        sc.SubRegion__c = 'INDIA BHARTI';
        sc.Country__c = 'India';
        sc.Project__c = 'In Bharti 4G';
        
        sc.CategoryCluster__c = 'Indirect Procurement';
        sc.CategoryGroup__c = 'Facility';
        sc.Category__c = 'Facility Services';
        
        sc.BusinessUnit__c = 'Global Services';
        sc.BusinessLine__c = 'Network Implementation';
        sc.Product__c = 'WinPower Silver';
        
        insert sc;
        
        SPE_ScorecardSPETemplateMap__c sct = new SPE_ScorecardSPETemplateMap__c();
        sct.ScorecardTemplate__c = sc.Id;
        sct.SPETemplate__c = speTemp.Id;
        sct.Weight__c = 100;
        insert sct;       
      
        sc.Stage__c = 'Published';
        update sc;
    
        test.startTest();
        
        Integer index = 2;
        
        PageReference pageRef = Page.SPE_NewScorecardTemplate;
        pageRef.getParameters().put('rowIndex',String.valueOf(index));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController standa = new ApexPages.StandardController(sc);
        SPE_NewScorecardTemplateExt batchObj2 = new SPE_NewScorecardTemplateExt(standa);            
        batchObj2.addSPETemplate();
        batchObj2.removeSPETemplate();
        batchObj2.save();
        batchObj2.cancel();
                
        SPE_ScorecardTemplate__c sc1 = sc.Clone();
        sc1.Name = 'Test ScoreTemplate123';
        sc1.Stage__c = 'Draft';
        
        
        /*SPE_ScorecardSPETemplateMap__c sct1 = sct.Clone(); 
        sct1.ScorecardTemplate__c = sc1.Id;
        sct1.SPETemplate__c = speTemp.Id;
        sct1.Weight__c = 100;*/
        
        //insert sc1;
        //insert sct1;   
                              
        PageReference pageRef1 = Page.SPE_NewScorecardTemplate;
        pageRef1.getParameters().put('rowIndex',String.valueOf(index));
        Test.setCurrentPage(pageRef1);
        
        ApexPages.StandardController standa1 = new ApexPages.StandardController(sc1);
        SPE_NewScorecardTemplateExt batchObj3 = new SPE_NewScorecardTemplateExt(standa1);            
        
        batchObj3.addSPETemplate();
        batchObj3.removeSPETemplate();
        batchObj3.save();
        batchObj3.cancel();
        
        test.stopTest();
    }   
}