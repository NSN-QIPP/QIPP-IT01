@istest
public class QIRS_Create_Controller_test 
{
	static testmethod void test()
    {
       List<String> strNSNQIRS =new List<String>();
         List<Profile> tempprofile = new List<Profile>(); 
         String[] Profile = new String[] {'Nokia QIRS Admin','Nokia QIRS'};
         tempprofile=[SELECT Id,Name from Profile where Name In : Profile];          
           for (Integer j=0;j<tempprofile.size();j++)
            {
              strNSNQIRS.add(tempprofile[j].Id);
            }
          
          List<User> userlist= new List<User>();
          userlist= [select Id,Name from User where 
           ProfileId In: strNSNQIRS and IsActive = true order by Name];   
        
        
                   QIRS__c objqirs = new QIRS__c();
        	objqirs.Case_Name__c = 'case 1';
           objqirs.Site1__c = 'Alsdorf';
           objqirs.Process_Owner1__c = userlist[0].Id;           
           objqirs.Business__c = 'zzGlobal Services';           
           objqirs.Business_Group__c = 'zzBBA';           
           objqirs.Alert_Type__c = 'Quality Alert';           
           objqirs.Issue_Level__c = 'Medium';                                            
             objqirs.Factory__c ='Nokia Berlin, Germany';
           objqirs.Problem_Description1__c = 'Networks Systems';           
           objqirs.Customer__c = 'CDMA';           
           objqirs.Defective_Part__c = 'Design';           
           objqirs.Symptom__c = 'Hardware';                                            
           objqirs.Projected_Lift_Date__c  =Date.today(); 
           objqirs.Estimated_close_date__c = Date.today();
                   objqirs.Impacted_Region__c = 'Asia Pacific';           
           objqirs.Countries__c = 'China';           
             insert objqirs;
         test.startTest();
         ApexPages.StandardController sc = new ApexPages.StandardController(objqirs);
         QIRS_Create_Controller controller = new  QIRS_Create_Controller(sc);
        test.stopTest();
        

        
    }
    static testmethod void test1()
    {
       List<String> strNSNQIRS =new List<String>();
         List<Profile> tempprofile = new List<Profile>(); 
         String[] Profile = new String[] {'Nokia QIRS Admin','Nokia QIRS'};
         tempprofile=[SELECT Id,Name from Profile where Name In : Profile];          
           for (Integer j=0;j<tempprofile.size();j++)
            {
              strNSNQIRS.add(tempprofile[j].Id);
            }
          
          List<User> userlist= new List<User>();
          userlist= [select Id,Name from User where 
           ProfileId In: strNSNQIRS and IsActive = true order by Name];   
        
        
                   QIRS__c objqirs = new QIRS__c();
        	objqirs.Case_Name__c = 'case 1';
          objqirs.Site1__c = 'Alsdorf';
           objqirs.Process_Owner1__c = userlist[0].Id;           
           objqirs.Business__c = 'zzGlobal Services';           
           objqirs.Business_Group__c = 'zzBBA';           
           objqirs.Alert_Type__c = 'Quality Alert';           
           objqirs.Issue_Level__c = 'Medium';                                            
             objqirs.Factory__c ='Nokia Berlin, Germany';
           objqirs.Problem_Description1__c = 'Networks Systems';           
           objqirs.Customer__c = 'CDMA';           
           objqirs.Defective_Part__c = 'Design';           
           objqirs.Symptom__c = 'Hardware';                                            
           objqirs.Projected_Lift_Date__c  =Date.today(); 
           objqirs.Estimated_close_date__c = Date.today();
                   objqirs.Impacted_Region__c = 'Asia Pacific';           
           objqirs.Countries__c = 'China';           
             //insert objqirs;
         test.startTest();
         ApexPages.StandardController sc = new ApexPages.StandardController(objqirs);
         QIRS_Create_Controller controller = new  QIRS_Create_Controller(sc);
        test.stopTest();        
    }
}