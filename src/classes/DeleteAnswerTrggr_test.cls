@isTest(seeAllData=false)
public class DeleteAnswerTrggr_test{
    public static testmethod void DeleteAnswerTrggr_test_tst1(){
        List<PicklistDefaultValues__c> lstpicklistObj = new List<PicklistDefaultValues__c>();
        PicklistDefaultValues__c picklistObj = new PicklistDefaultValues__c();
        picklistObj.Name = 'Picklist Default Values';
        
        picklistObj.Business_Unit__c = 'ffff';
        picklistObj.Business_Line__c = 'nnnn';        
        picklistObj.Project__c = 'bbbb';
        
        picklistObj.Category_Area__c = 'rrrrr';
        picklistObj.Category_Group__c = 'ppppp';
        picklistObj.Category__c = 'qqqqq';               
        
        picklistObj.Market__c = 'sssssAts';
        picklistObj.Market_Unit__c = ' Market Units';
        picklistObj.Country__c = ' Countries';       
        picklistObj.Product__c = 'Products';
        
        
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
        list<Account> Acclist = new list<Account>();
            Account acc1 = new Account();
            acc1.Name = '3M';
            acc1.EnterpriseId__c = '3M';
            
        insert acc1;
        Acclist.add(acc1);
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.AccountId = acc1.Id;
        con.Email = 'Deep.Banerjee@atos.net';
        insert con;
        
        Contact CCcon1 = new Contact();
        CCcon1.LastName = 'Test Contact1';
        CCcon1.AccountId = acc1.Id;
        CCcon1.Email = 'Deep.Banerjee1@atos.net';
        insert CCcon1;
        
        Contact CCcon2 = new Contact();
        CCcon2.LastName = 'Test Contact2';
        CCcon2.AccountId = acc1.Id;
        CCcon2.Email = 'Deep.Banerjee2@atos.net';
        insert CCcon2;
        
        Contact CCcon3 = new Contact();
        CCcon3.LastName = 'Test Contact3';
        CCcon3.AccountId = acc1.Id;
        CCcon3.Email = 'Deep.Banerjee3@atos.net';
        insert CCcon3;
        
        
        
        SPE_SurveyQuestion__c surQue = new SPE_SurveyQuestion__c();
        surQue.Name = 'SPE_Test Question';
        surQue.SurveyQuestion__c = 'What color is your hair?';
        surQue.AnswerType__c = 'Picklist';
        surQue.IsActive__c = true;
        surQue.QuestionAbbreviation__c = 'SPE_Que';
        insert surQue;
        
        SPE_SurveyAnswer__c surAns = new SPE_SurveyAnswer__c();
        surAns.Choices__c = 'ffff';
        surAns.OrderNumber__c = 12;
        surAns.PrimarySurvey_Answer__c = surAns.id;
        surAns.Secondary_Language__c = 'ffff';
        surAns.SurveyQuestion__c = surQue.id;
        surAns.Score__c = 1;
        insert surAns;
        
        delete surAns;
        
    }
    
    }
   }