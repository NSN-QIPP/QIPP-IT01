public with sharing class QIRS_TestClassReports
{
    public static testmethod void test1() 
    {   
        List<Profile> tempprofile = new List<Profile>(); 
        String[] Profile = new String[] {'Nokia QIRS','Nokia QIRS Admin'};
        tempprofile=[SELECT Id,Name from Profile where Name In : Profile];
        List<String> strNSNQIRS =new List<String>();
        for (Integer j=0;j<tempprofile.size();j++)
        {
            strNSNQIRS.add(tempprofile[j].Id); 
        }
        List<User> userlist= new List<User>();
        userlist= [select Id,Name from User where  IsActive = true and ProfileId In : strNSNQIRS order by Name]; 
                
        QIRS__c objqirs = new QIRS__c();
        objqirs.Site1__c = 'Alsdorf'; 
        objqirs.Process_Owner1__c = userlist[0].Id;           
        objqirs.Business__c = 'Networks Systems';           
        objqirs.Business_Group__c = 'CDMA';           
        objqirs.Alert_Type__c = 'NPI Launch Impact';           
        objqirs.Issue_Level__c = 'Launch Delay'; 
        objqirs.Problem_Description1__c = 'Networks Systems';           
        objqirs.Customer__c = 'CDMA';           
        objqirs.Defective_Part__c = 'Design';           
        objqirs.Symptom__c = 'Hardware';                                            
        objqirs.Projected_Lift_Date__c  = Date.today();  
        objqirs.Impacted_Region__c = 'Asia';           
        objqirs.Countries__c = 'China'; 
        objqirs.Factory__c = 'Tianjin';  
        //objqirs.Name = '';           
        insert objqirs;     
        
       
        
        
        
        QIRS_Change_Request__c objQIRS_Change_Request = new QIRS_Change_Request__c();
        objQIRS_Change_Request.First_Name__c = 'aaaa';
        objQIRS_Change_Request.Last_Name__c = 'aaaa';
        objQIRS_Change_Request.Email_ID__c = 'abc.zz@xyz.com';
        objQIRS_Change_Request.QIRS_Number__c = '111';
        objQIRS_Change_Request.Admin_Comments__c = 'aaaaa';
        insert objQIRS_Change_Request;
        
        String StrId = [select Id from QIRS_Change_Request__c limit 1].Id;
        
        ApexPages.currentPage().getParameters().put('id', objQIRS_Change_Request.id);
        ApexPages.currentPage().getParameters().get('id');
        
       
    }
    
    public static testmethod void test2()  
    {
       
        
        String Type='';
       List<Profile> tempprofile = new List<Profile>(); 
        String[] Profile = new String[] {'Nokia QIRS','Nokia QIRS Admin'};
         tempprofile=[SELECT Id,Name from Profile where Name In : Profile];
         List<String> strNSNQIRS =new List<String>();
         for (Integer j=0;j<tempprofile.size();j++)
            {
              strNSNQIRS.add(tempprofile[j].Id);
            }
             List<User> userlist= new List<User>();
             userlist= [select Id,Name from User where  IsActive = true and ProfileId In : strNSNQIRS order by Name]; 
           QIRS__c objqirs = new QIRS__c();
           objqirs.Site1__c = 'Alsdorf';
           objqirs.Process_Owner1__c = userlist[0].Id;           
           objqirs.Business__c = 'Networks Systems';           
           objqirs.Business_Group__c = 'CDMA';           
           objqirs.Alert_Type__c = 'NPI Launch Impact';           
           objqirs.Issue_Level__c = 'Launch Delay';                                            
             objqirs.Factory__c ='Berlin';
           objqirs.Problem_Description1__c = 'Networks Systems';           
           objqirs.Customer__c = 'CDMA';           
           objqirs.Defective_Part__c = 'Design';           
           objqirs.Symptom__c = 'Hardware';                                            
           objqirs.Projected_Lift_Date__c  =Date.today();        
           
           objqirs.Impacted_Region__c = 'Asia';           
           objqirs.Countries__c = 'China';           
             insert objqirs;   
                List<QIRS__c> lstQirs = new List<QIRS__c>();             
             lstQirs.add(objqirs);     
        
      
                
    }
    
    public static testmethod void test3()  
    {
        List<Profile> tempprofile = new List<Profile>(); 
        String[] Profile = new String[] {'Nokia QIRS','Nokia QIRS Admin'};
        tempprofile=[SELECT Id,Name from Profile where Name In : Profile];
        List<String> strNSNQIRS =new List<String>();
        for (Integer j=0;j<tempprofile.size();j++)
        {
            strNSNQIRS.add(tempprofile[j].Id); 
        }
        List<User> userlist= new List<User>();
        userlist= [select Id,Name from User where  IsActive = true and ProfileId In : strNSNQIRS order by Name]; 
                
        QIRS__c objqirs = new QIRS__c();
        objqirs.Site1__c = 'Alsdorf'; 
        objqirs.Process_Owner1__c = userlist[0].Id;           
        objqirs.Business__c = 'Networks Systems';           
        objqirs.Business_Group__c = 'CDMA';           
        objqirs.Alert_Type__c = 'NPI Launch Impact';           
        objqirs.Issue_Level__c = 'Launch Delay'; 
        objqirs.Problem_Description1__c = 'Networks Systems';           
        objqirs.Customer__c = 'CDMA';           
        objqirs.Defective_Part__c = 'Design';           
        objqirs.Symptom__c = 'Hardware';                                            
        objqirs.Projected_Lift_Date__c = Date.today();  
        objqirs.Impacted_Region__c = 'Asia';           
        objqirs.Countries__c = 'China'; 
        objqirs.Factory__c = 'Tianjin';  
        //objqirs.Name = '';           
        insert objqirs;   
        
        QIRS_Action_Plan__c objQIRS_Action_Plan = new QIRS_Action_Plan__c();
        objQIRS_Action_Plan.QIRS__c = objqirs.Id;
        objQIRS_Action_Plan.Required_date__c = system.today();
        objQIRS_Action_Plan.Status__c = 'Open' ;
        objQIRS_Action_Plan.Action_Type__c = 'Containment';
        objQIRS_Action_Plan.Name = 'AAA';
        insert objQIRS_Action_Plan;
        
        ApexPages.StandardController con = new ApexPages.StandardController(objQIRS_Action_Plan);
        
        QIRS_AP_HistroyController objQIRS_AP_HistroyController = new QIRS_AP_HistroyController(con);
        QIRS_AP_HistroyController objQIRS_AP_HistroyController1 = new QIRS_AP_HistroyController();
        objQIRS_AP_HistroyController1.getHistory();
        
        QIRS_Product_Identification__c objQIRS_Product_Identification = new QIRS_Product_Identification__c();
        objQIRS_Product_Identification.QIRS__c = objqirs.Id;
        objQIRS_Product_Identification.Technology__c = 'aaaa';
        objQIRS_Product_Identification.Product_Name__c = 'aaaa';
        objQIRS_Product_Identification.Name = 'aaaa';
              objQIRS_Product_Identification.Name__c = 'test';
        insert objQIRS_Product_Identification;
        

    }
}