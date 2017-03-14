@isTest(seeAllData=false)
public class SPE2_ScorecardSpendCalc_Test {
    Public static testMethod void Method1(){
       
      
      // supportConfig.Users_outside_of_support_for_assists__c = String.valueOf(nonSupportUser.Id);
       SPE_Report_Configs__c Rconfig = new SPE_Report_Configs__c();
       Rconfig.Name= 'Filter for Spend and Volume';
       Rconfig.Market_Filter_For_Volume__c = true;
       Rconfig.Product_Filter_For_Spend__c= true;
       Rconfig.Product_Filter_For_Volume__c= true;
       insert Rconfig;
       // SPE_Report_Configs__c reportConfig = SPE_Report_Configs__c.getInstance('Filter for Spend and Volume'); 
        
        
       List<Account> acclist =new List<Account>();
       for(integer i =0;i<=11;i++){
            Account acc = new Account();
            acc.Name ='ABC'+i;
            acc.EnterpriseId__c='COSCOM'+i;
            acc.SupplierId__c='Test1';
           acclist.add(acc);
        }
        insert acclist;
        
       List<Contact> conlist =new List<Contact>();
       for(integer i =0;i<=11;i++){
            Contact CCcon3 = new Contact();
            CCcon3.LastName = 'Test Contact' +i ;
            CCcon3.AccountId = acclist[0].Id;
            CCcon3.Email = 'Deep.Banerjee3@atos.net';
            conlist.add(CCcon3);
        }
        insert conlist;
          
        SPE_Report_Parameter__c screport = new SPE_Report_Parameter__c();
        screport.Region__c = 'INDIA';
        screport.SubRegion__c = 'INDIA-IND';
        screport.Country__c = 'India';
        screport.Project__c = 'All Project';
        screport.CategoryCluster__c = 'All Category Areas';
        screport.Category_Group__c = 'All Category Groups';
        screport.Category__c = 'All Categories';
        screport.Business_Unit__c ='All Business Units';
        screport.Business_Line__c ='All Business Lines';      
        screport.Product__c = 'All Products';
        screport.Aggregation_Type__c='Simple Average';
        screport.IsEmailSent__c= true;
        screport.useCacheReport__c= true;
        screport.Start_Date__c= Date.newInstance(2020,1,15);
        screport.End_Date__c= Date.newInstance(2020,12,15);
        screport.Scorecard_Identifier__c = 'abcd';
        insert screport;
        
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
        
        SPE_ScoringTemplate__c scoringTemplate = SPE_TestObjectCreator.CreateScoringTemplate(speTemp);
        scoringTemplate.Name = 'Test Template 1122'; 
        insert scoringTemplate;
        
        scoringTemplate.Stage__c = 'Published';
        update scoringTemplate;
        
        SPE_SPEPlan__c spePlan = new SPE_SPEPlan__c();
        spePlan.SPEPlanName__c='aAtos11';
        spePlan.Additional_Days__c  = 5;
        spePlan.Next_Computed_Day__c = Date.newinstance(2016,01,01);
        spePlan.FrequencyInMonths__c = '1';
        spePlan.AggregationDuration__c = '1';
        spePlan.SPETemplate__c = speTemp.Id;
        spePlan.SPEScoringTemplate__c = scoringTemplate.Id;
        spePlan.Stage__c = 'Draft';
        spePlan.BusinessLine__c='--None--';
        spePlan.BusinessUnit__c='--None--';
        spePlan.Category__c='--None--';
        spePlan.CategoryCluster__c= '--None--';
        spePlan.CategoryGroup__c= '--None--';
        spePlan.CM__c= conlist[0].id;
        spePlan.CompletedTracker__c= 2;
        spePlan.Country__c='--None--';
        spePlan.EndDate__c= Date.newinstance(2020,06,20);
        spePlan.FrequencyInMonths__c='1';
        spePlan.Region__c='--None--';
        spePlan.SubRegion__c= '--None--';
        spePlan.Organization_Group__c='Indirect Procurement';
        spePlan.PPM1__c= conlist[0].id;
        spePlan.Product__c='All Product';
        spePlan.Project__c='All Project';
        spePlan.StartDate__c= Date.newinstance(2020,01,20);
        spePlan.SurveyReminderBeforeExecutionDate__c=1;
        insert spePlan;
        
        spePlan.Stage__c = 'Published';
        update spePlan;
        
        list<SPE_SPEPlan__c> speList = new list<SPE_SPEPlan__c>();
        speList.add(spePlan);

        SPE_SPETracker__c speTracker1 = new SPE_SPETracker__c();
        speTracker1.Name = 'April - 2020'; 
        speTracker1.SPETemplate__c = speTemp.Id; 
        speTracker1.SPEPlan__c = spePlan.Id;
        speTracker1.DateOfExecution__c = System.Today();
        speTracker1.Region__c = 'All Markets';
        speTracker1.SubRegion__c = 'All Market Units';
        speTracker1.Country__c = 'All Countries';
        speTracker1.Project__c = 'All Projects';
        speTracker1.CategoryCluster__c = 'All Category Areas';
        speTracker1.CategoryGroup__c = 'All Category Groups';
        speTracker1.Category__c = 'All Categories';
        speTracker1.BusinessUnit__c ='All Business Units';
        speTracker1.BusinessLine__c ='All Business Line';      
        speTracker1.Product__c = 'All Products';
        speTracker1.Status__c='Pending';
        speTracker1.Contact__c= conlist[0].id;
        speTracker1.ForceSurvey__c =true;
        speTracker1.isContainsSurveyBasedPI__c = true;
        speTracker1.PilotTestDataCheck__c = true;
        speTracker1.SendSurveyLink__c= true;
        insert speTracker1;
        
        SPE_SPETracker__c speTracker2 = new SPE_SPETracker__c();
        speTracker2.Name = 'January - 2020'; 
        speTracker2.SPETemplate__c = speTemp.Id; 
        speTracker2.SPEPlan__c = spePlan.Id;
        speTracker2.DateOfExecution__c = System.Today();
        speTracker2.Region__c = 'INDIA';
        speTracker2.SubRegion__c = 'INDIA BHARTI';
        speTracker2.Country__c = 'India';
        speTracker2.Project__c = 'IN Bharti 3G';
        speTracker2.CategoryCluster__c = 'Services procurement';
        speTracker2.CategoryGroup__c = 'Subcontracting NI Services';
        speTracker2.Category__c = 'Telecom Implementation';
        speTracker2.BusinessUnit__c ='Global Services';
        speTracker2.BusinessLine__c ='Global Services';      
        speTracker2.Product__c = 'My Product';
        speTracker2.Status__c='Pending';
        speTracker2.Contact__c= conlist[0].id;
        speTracker2.ForceSurvey__c =true;
        speTracker2.isContainsSurveyBasedPI__c = true;
        speTracker2.PilotTestDataCheck__c = true;
        speTracker2.SendSurveyLink__c= true;
        insert speTracker2;
               
        SPE_Scorecard_Report__c scRpt1 = new SPE_Scorecard_Report__c();
        scRpt1.Business_Line__c='All Business Lines'; 
        scRpt1.Business_Unit__c='All Business Units';
        scRpt1.Category__c='All Categories'; 
        scRpt1.Category_Area__c='All Category Areas';
        scRpt1.Category_Group__c='All Category Groups';
        scRpt1.Country__c='All Countries'; 
        scRpt1.Market__c='All Markets';
        scRpt1.Market_Unit__c= 'All Market Units';
        scRpt1.Period__c= Date.newInstance(2016,10,20);
        scRpt1.Product__c='All Products';
        scRpt1.Project__c = 'All Projects';
        scRpt1.Score__c = 10;
        scRpt1.SPE_Report_Parameter__c = screport.id;
        scRpt1.SPE_Score__c = true;
        scRpt1.SPE_Tracker__c = speTracker1.id;
        scRpt1.Supplier__c = Acclist[0].id;
        scRpt1.Weight__c = 2;
        insert scRpt1;
        
        SPE_Scorecard_Report__c scRpt2 = new SPE_Scorecard_Report__c();
        scRpt2.Business_Line__c='All Business Lines'; 
        scRpt2.Business_Unit__c='All Business Units';
        scRpt2.Category__c='All Categories'; 
        scRpt2.Category_Area__c='All Category Areas';
        scRpt2.Category_Group__c='All Category Groups';
        scRpt2.Country__c='All Countries'; 
        scRpt2.Market__c='All Markets';
        scRpt2.Market_Unit__c= 'All Market Units';
        scRpt2.Period__c= Date.newInstance(2016,10,20);
        scRpt2.Product__c='All Products';
        scRpt2.Project__c = 'All Projects';
        scRpt2.Score__c = 10;
        scRpt2.SPE_Report_Parameter__c = screport.id;
        scRpt2.SPE_Score__c = true;
        scRpt2.SPE_Tracker__c = speTracker2.id;
        scRpt2.Supplier__c = Acclist[0].id;
        scRpt2.Weight__c = 2;
        insert scRpt2;
        
        List<SPE_Scorecard_Report__c>  listScRpt= new  List<SPE_Scorecard_Report__c>();
        listScRpt.add(scRpt1);
        listScRpt.add(scRpt2);
        
       // insert listScRpt;
        
        System.assert(listScRpt != Null);
        SPE2_ScorecardSpendCalc cal= new SPE2_ScorecardSpendCalc(screport.Scorecard_Identifier__c);
    }
}