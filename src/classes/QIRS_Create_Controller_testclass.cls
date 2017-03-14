@isTest(seeallData=false)
public class QIRS_Create_Controller_testclass {
    static testmethod void test1(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS'];
         /*User u = new User(Alias = 'standt', Email='priyaburghate@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11@testorg.com');*/
        //User u = [SELECT Id From User WHERE Id =:UserInfo.getUserID()];
        User u = [SELECT Id From User WHERE Profile.Id =:p.Id  AND IsActive=true limit 1];
        system.debug('=====@@@@===='+u);
        system.runAs(u){
            
        QIRS__c qirsRec = new QIRS__c();
        qirsRec.Case_Name__c='test';
        qirsRec.Access_Stop_Ship_Code__c='test access code';
        qirsRec.Exposed_Base__c='test base';
        qirsRec.Factory_DC__c='test';
        qirsRec.Customer__c='test';
        qirsRec.Customer_Impact__c='High';
        qirsRec.Expected_Number_of_return__c='100';
        qirsRec.NSN_Part_Number__c='121';
        qirsRec.Product_Safety__c=false;
        qirsRec.Supplier_Pn__c='test Supplier Pn';
        qirsRec.Core_ID__c='test';
        qirsRec.Approval_Comments__c='test comments';
        qirsRec.IsDefaultReleased__c=true;
        qirsRec.Process_Owner1__c=u.Id;
        qirsRec.Business__c='zzGlobal Services';
        qirsRec.Business_Group__c='3G Core';
        qirsRec.Problem_Description1__c='test description';
        qirsRec.Alert_Type__c='Quality Alert';
        qirsRec.Projected_Lift_Date__c=system.today();
        qirsRec.Estimated_close_date__c=system.today()+5;
        qirsRec.Impacted_Region_Customer__c='test';
        qirsRec.Factory__c='OMP, Italy';
        qirsRec.Defective_Part__c='Design';
        qirsRec.Symptom__c='Software';
        qirsRec.Group_to_Notify__c='test group';
        qirsRec.Countries__c='India';
        qirsRec.Impacted_Region__c='All';
        qirsRec.Lifted_Date__c=date.today();
        qirsRec.Issue_Level__c='Medium';
        qirsRec.Master_Approver__c= u.Id;
        qirsRec.Master_Approver1__c=u.Id;
        qirsRec.Master_Approver2__c=u.Id;
        qirsRec.Master_Approver3__c=u.Id;
        qirsRec.Master_Approver4__c=u.Id;
        qirsRec.Master_Approver5__c=u.Id;
        qirsRec.Master_Approver6__c=u.Id;
        qirsRec.Master_Approver7__c=u.Id;
        qirsRec.Master_Approver8__c=u.Id;
        qirsRec.Master_Approver9__c=u.Id;
        qirsRec.Master_Approver10__c=u.Id;
        qirsRec.Approver_Contacted1__c=true;
        qirsRec.Approver_Contacted2__c=true;
        qirsRec.Approver_Contacted3__c=true;
        qirsRec.Approver_Contacted4__c=true;
        qirsRec.Approver_Contacted5__c=true;
        qirsRec.Approver_Contacted6__c=true;
        qirsRec.Approver_Contacted7__c=true;
        qirsRec.Approver_Contacted8__c=true;
        qirsRec.Approver_Contacted9__c=true;
        qirsRec.Approver_Contacted10__c=true;
        qirsRec.MCAR__c='test mcar';
        qirsRec.Next_CRSD__c=date.today();
        qirsRec.Watchlist__c=true;
        qirsRec.Closed_Date1__c=date.today()+4;
        qirsRec.Operator_Warning_Message__c='warning1';
        qirsRec.Orders_backlog__c='test order backlog';
        qirsRec.Orders_Impact__c='test impact';
        qirsRec.Last_Approved_Program_Milestone__c='P1';
        qirsRec.View_Product_Name__c='test product name';
        qirsRec.Revenue_Backlog__c='test';
        qirsRec.Status__c='Open';
        qirsRec.WatchListComment__c='test commment';
        qirsRec.WatchListType__c='test';
        qirsRec.Revenue_Impact__c='test';
        qirsRec.Serial_Numbers__c='0001';
        qirsRec.Lock_Points_SH_Shipping__c=true;
        qirsRec.Site1__c='Alsdorf';
        qirsRec.Supplier__c='test Supplier';
        qirsRec.Total_Quality_Spills_Cost__c='1000';
        qirsRec.Units_Backlog__c='100';
        qirsRec.Units_Impact__c='100';
        qirsRec.View_AP_Color__c='yellow';
        qirsRec.View_Release_Product__c='test release';
        qirsRec.Yes__c=true; 
        qirsRec.MCAR_Supplier_Claim__c='test claim';
        qirsRec.Pronto__c='test pronto';
        qirsRec.Resolve__c='yes';
        qirsRec.RCA_EDA__c='test';
        qirsRec.Line_Stop__c='test';
        qirsRec.Affected_Unit_at_Customer_Action__c='N/A';
        qirsRec.Affected_Unit_at_Hubs_Action__c='N/A';
        qirsRec.Affected_Unit_at_Factories_Action__c='N/A';
        qirsRec.Affected_Units_at_HWS_Action__c='N/A';
        qirsRec.Affected_Units_at_Suppliers_Action__c='N/A';
        qirsRec.Additional_Email__c='priyaburghate@yahoo.in';
        qirsRec.Affected_Units_at_HWS__c=10;
        qirsRec.Affected_Units_at_Suppliers__c=10;
        insert qirsRec;
          
           
       /* QIRS_Action_Plan_Approver_List__c aplanlist = new QIRS_Action_Plan_Approver_List__c();
         aplanlist.Email__c='priyaburghate@yahoo.in';
         aplanlist.Business__c='';
         aplanlist.Phone__c=123445;
         aplanlist.Approver_Contacted__c=true;
         aplanlist.User__c='';
      */
            
         test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(qirsRec);
        ApexPages.CurrentPage().getparameters().put('id', qirsRec.id);
        QIRS_Create_Controller obj1 = new QIRS_Create_Controller(sc);
       obj1.Save();
        obj1.Cancel();
        obj1.AssignContactedApp();
        obj1.getTEST();
        obj1.getAlertType();
        //obj1.AssignContactedApp();
        test.stopTest();
        
    }
    }
        
   static testmethod void test2(){
       
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS'];
       List<User> uList= new List<User>();
        User u = new User(Alias = 'standt', Email='priyaburghate@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11k@testorg.com');
       uList.add(u);
       User u1 = new User(Alias = 'standt1', Email='priyaburghate1@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11j@testorg.com');
       uList.add(u1);
       User u2 = new User(Alias = 'standt2', Email='priyaburghate2@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11i@testorg.com');
       uList.add(u2);
       User u3 = new User(Alias = 'standt3', Email='priyaburghate3@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11h@testorg.com');
      uList.add(u3);
       User u4 = new User(Alias = 'stand4t', Email='priyaburghate4@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11g@testorg.com');
       uList.add(u4);
       User u5 = new User(Alias = 'stand5t', Email='priyaburghate5@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11f@testorg.com');
       uList.add(u5);
       User u6 = new User(Alias = 'standt6', Email='priyaburghate6@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11e@testorg.com');
       uList.add(u6);
       User u7 = new User(Alias = 'standt7', Email='priyaburghate7@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11d@testorg.com');
       uList.add(u7);
       User u8 = new User(Alias = 'standt8', Email='priyaburghate8@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11c@testorg.com');
       uList.add(u8);
       User u9 = new User(Alias = 'standt9', Email='priyaburghate9@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11b@testorg.com');
       uList.add(u9);
       User u10 = new User(Alias = 'standt9', Email='priyaburghate10@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11a@testorg.com');
       uList.add(u10);
       
       insert uList; 
//User u = [SELECT Id From User WHERE Id =:UserInfo.getUserID()];
       system.runAs(u){
            
        QIRS__c qirsRec = new QIRS__c();
        qirsRec.Case_Name__c='test';
        qirsRec.Access_Stop_Ship_Code__c='test access code';
        qirsRec.Exposed_Base__c='test base';
        qirsRec.Factory_DC__c='test';
        qirsRec.Customer__c='test';
        qirsRec.Customer_Impact__c='High';
        qirsRec.Expected_Number_of_return__c='100';
        qirsRec.NSN_Part_Number__c='121';
        qirsRec.Product_Safety__c=false;
        qirsRec.Supplier_Pn__c='test Supplier Pn';
        qirsRec.Core_ID__c='test';
        qirsRec.Approval_Comments__c='test comments';
        qirsRec.IsDefaultReleased__c=true;
        qirsRec.Process_Owner1__c=u.Id;
        qirsRec.Business__c='zzGlobal Services';
        qirsRec.Business_Group__c='3G Core';
        qirsRec.Problem_Description1__c='test description';
        qirsRec.Alert_Type__c='Quality Alert';
        qirsRec.Projected_Lift_Date__c=system.today();
        qirsRec.Estimated_close_date__c=system.today()+5;
        qirsRec.Impacted_Region_Customer__c='test';
        qirsRec.Factory__c='OMP, Italy';
        qirsRec.Defective_Part__c='Design';
        qirsRec.Symptom__c='Software';
        qirsRec.Group_to_Notify__c='test group';
        qirsRec.Countries__c='India';
        qirsRec.Impacted_Region__c='All';
        qirsRec.Lifted_Date__c=date.today();
        qirsRec.Issue_Level__c='Medium';
        qirsRec.Master_Approver__c= u.Id;
        qirsRec.Master_Approver1__c=u.Id;
        qirsRec.Master_Approver2__c=u.Id;
        qirsRec.Master_Approver3__c=u.Id;
        qirsRec.Master_Approver4__c=u.Id;
        qirsRec.Master_Approver5__c=u.Id;
        qirsRec.Master_Approver6__c=u.Id;
        qirsRec.Master_Approver7__c=u.Id;
        qirsRec.Master_Approver8__c=u.Id;
        qirsRec.Master_Approver9__c=u.Id;
        qirsRec.Master_Approver10__c=u.Id;
        qirsRec.Approver_Contacted1__c=true;
        qirsRec.Approver_Contacted2__c=true;
        qirsRec.Approver_Contacted3__c=true;
        qirsRec.Approver_Contacted4__c=true;
        qirsRec.Approver_Contacted5__c=true;
        qirsRec.Approver_Contacted6__c=true;
        qirsRec.Approver_Contacted7__c=true;
        qirsRec.Approver_Contacted8__c=true;
        qirsRec.Approver_Contacted9__c=true;
        qirsRec.Approver_Contacted10__c=true;
        qirsRec.MCAR__c='test mcar';
        qirsRec.Next_CRSD__c=date.today();
        qirsRec.Watchlist__c=true;
        qirsRec.Closed_Date1__c=date.today()+4;
        qirsRec.Operator_Warning_Message__c='warning1';
        qirsRec.Orders_backlog__c='test order backlog';
        qirsRec.Orders_Impact__c='test impact';
        qirsRec.Last_Approved_Program_Milestone__c='P1';
        qirsRec.View_Product_Name__c='test product name';
        qirsRec.Revenue_Backlog__c='test';
        qirsRec.Status__c='Open';
        qirsRec.WatchListComment__c='test commment';
        qirsRec.WatchListType__c='test';
        qirsRec.Revenue_Impact__c='test';
        qirsRec.Serial_Numbers__c='0001';
        qirsRec.Lock_Points_SH_Shipping__c=true;
        qirsRec.Site1__c='Alsdorf';
        qirsRec.Supplier__c='test Supplier';
        qirsRec.Total_Quality_Spills_Cost__c='1000';
        qirsRec.Units_Backlog__c='100';
        qirsRec.Units_Impact__c='100';
        qirsRec.View_AP_Color__c='yellow';
        qirsRec.View_Release_Product__c='test release';
        qirsRec.Yes__c=true; 
        qirsRec.MCAR_Supplier_Claim__c='test claim';
        qirsRec.Pronto__c='test pronto';
        qirsRec.Resolve__c='yes';
        qirsRec.RCA_EDA__c='test';
        qirsRec.Line_Stop__c='test';
        qirsRec.Affected_Unit_at_Customer_Action__c='N/A';
        qirsRec.Affected_Unit_at_Hubs_Action__c='N/A';
        qirsRec.Affected_Unit_at_Factories_Action__c='N/A';
        qirsRec.Affected_Units_at_HWS_Action__c='N/A';
        qirsRec.Affected_Units_at_Suppliers_Action__c='N/A';
        qirsRec.Additional_Email__c='priyaburghate@yahoo.in';
        qirsRec.Affected_Units_at_HWS__c=10;
        qirsRec.Affected_Units_at_Suppliers__c=10;
        insert qirsRec;
        System.assert(qirsRec !=  Null);
        //system.assert(uList.size()>0);   
       // List<QIRS_Action_Plan_Approver_List__c> aplan = new List<QIRS_Action_Plan_Approver_List__c>();
        //integer i=1;
            //for(User us : uList ){
             QIRS_Action_Plan_Approver_List__c aplanlist = new QIRS_Action_Plan_Approver_List__c();
             aplanlist.Email__c='priyaburghate@yahoo.in';
             aplanlist.Business__c=qirsRec.Business__c;
             aplanlist.Phone__c='123445123';
             aplanlist.Approver_Contacted__c=true;
             aplanlist.User__c=u.Id; 
             
             QIRS_Action_Plan_Approver_List__c aplanlist1 = new QIRS_Action_Plan_Approver_List__c();
             aplanlist1.Email__c='priyaburghate@yahoo.in';
             aplanlist1.Business__c=qirsRec.Business__c;
             aplanlist1.Phone__c='123445123';
             aplanlist1.Approver_Contacted__c=true;
             aplanlist1.User__c=u1.Id;
             
             QIRS_Action_Plan_Approver_List__c aplanlist2 = new QIRS_Action_Plan_Approver_List__c();
             aplanlist2.Email__c='priyaburghate@yahoo.in';
             aplanlist2.Business__c=qirsRec.Business__c;
             aplanlist2.Phone__c='123445123';
             aplanlist2.Approver_Contacted__c=true;
             aplanlist2.User__c=u2.Id;
             
             QIRS_Action_Plan_Approver_List__c aplanlist3 = new QIRS_Action_Plan_Approver_List__c();
             aplanlist3.Email__c='priyaburghate@yahoo.in';
             aplanlist3.Business__c=qirsRec.Business__c;
             aplanlist3.Phone__c='123445123';
             aplanlist3.Approver_Contacted__c=true;
             aplanlist3.User__c=u3.Id;
             
             QIRS_Action_Plan_Approver_List__c aplanlist4 = new QIRS_Action_Plan_Approver_List__c();
             aplanlist4.Email__c='priyaburghate@yahoo.in';
             aplanlist4.Business__c=qirsRec.Business__c;
             aplanlist4.Phone__c='123445123';
             aplanlist4.Approver_Contacted__c=true;
             aplanlist4.User__c=u4.Id;
             
             insert new List<QIRS_Action_Plan_Approver_List__c>{aplanlist,aplanlist1,aplanlist2,aplanlist3};
                //i++;
            // aplan.add(aplanlist);   
            
        // insert aplan
         
        test.startTest();
          
        
        ApexPages.StandardController sc = new ApexPages.standardController(qirsRec);
        ApexPages.CurrentPage().getparameters().put('id', qirsRec.id);
        QIRS_Create_Controller obj1 = new QIRS_Create_Controller(sc);
        obj1.strMode='ADD';
        obj1.AssignContactedApp();   
        obj1.getMultiApprover();
        obj1.Save();
        obj1.Cancel();
       
        obj1.getSite();
        obj1.getBusiness();
        obj1.getStatus();
        obj1.getApprover();
        
        obj1.getTEST();
        obj1.getAlertType();
        obj1.AssignContactedApp();
        test.stopTest();
       
        
    }
   }   
    
    
    static testmethod void test3(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS'];
        List<User> uList = new List<User>();
        User u = new User(Alias = 'standt', Email='priyaburghate@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11@testorg.com');
        uList.add(u);
        User u1 = new User(Alias = 'standt1', Email='priyaburghate1@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11j@testorg.com');
       uList.add(u1);
       User u2 = new User(Alias = 'standt2', Email='priyaburghate2@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11i@testorg.com');
       uList.add(u2);
       User u3 = new User(Alias = 'standt3', Email='priyaburghate3@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11h@testorg.com');
      uList.add(u3);
       User u4 = new User(Alias = 'stand4t', Email='priyaburghate4@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11g@testorg.com');
       uList.add(u4);
       User u5 = new User(Alias = 'stand5t', Email='priyaburghate5@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11f@testorg.com');
       uList.add(u5);
       User u6 = new User(Alias = 'standt6', Email='priyaburghate6@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11e@testorg.com');
       uList.add(u6);
       User u7 = new User(Alias = 'standt7', Email='priyaburghate7@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11d@testorg.com');
       uList.add(u7);
       User u8 = new User(Alias = 'standt8', Email='priyaburghate8@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11c@testorg.com');
       uList.add(u8);
       User u9 = new User(Alias = 'standt9', Email='priyaburghate9@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11b@testorg.com');
       uList.add(u9);
       User u10 = new User(Alias = 'standt9', Email='priyaburghate10@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11a@testorg.com');
       uList.add(u10);
        list<User> userlist1 = new list<User>();
        userlist1 = [select id,name from user where id in:ulist];
        
          
        system.runAs(u)
        {
         
        QIRS__c qirsRec = new QIRS__c();
        qirsRec.Case_Name__c='test';
        qirsRec.Access_Stop_Ship_Code__c='test access code';
        qirsRec.Exposed_Base__c='test base';
        qirsRec.Factory_DC__c='test';
        qirsRec.Customer__c='test';
        qirsRec.Customer_Impact__c='High';
        qirsRec.Expected_Number_of_return__c='100';
        qirsRec.NSN_Part_Number__c='121';
        qirsRec.Product_Safety__c=false;
        qirsRec.Supplier_Pn__c='test Supplier Pn';
        qirsRec.Core_ID__c='test';
        qirsRec.Approval_Comments__c='test comments';
        qirsRec.IsDefaultReleased__c=true;
        qirsRec.Process_Owner1__c=u.Id;
        qirsRec.Business__c='zzGlobal Services';
        qirsRec.Business_Group__c='3G Core';
        qirsRec.Problem_Description1__c='test description';
        qirsRec.Alert_Type__c='Quality Alert';
        qirsRec.Projected_Lift_Date__c=system.today();
        qirsRec.Estimated_close_date__c=system.today()+5;
        qirsRec.Impacted_Region_Customer__c='test';
        qirsRec.Factory__c='OMP, Italy';
        qirsRec.Defective_Part__c='Design';
        qirsRec.Symptom__c='Software';
        qirsRec.Group_to_Notify__c='test group';
        qirsRec.Countries__c='India';
        qirsRec.Impacted_Region__c='All';
        qirsRec.Lifted_Date__c=date.today();
        qirsRec.Issue_Level__c='Medium';
        qirsRec.Master_Approver__c= u.Id;
        qirsRec.Master_Approver1__c=u.Id;
  /*      qirsRec.Master_Approver2__c=u.Id;
        qirsRec.Master_Approver3__c=u3.Id;
        qirsRec.Master_Approver4__c=u4.Id;
        qirsRec.Master_Approver5__c=u5.Id;
        qirsRec.Master_Approver6__c=u6.Id;
        qirsRec.Master_Approver7__c=u7.Id;
        qirsRec.Master_Approver8__c=u8.Id;
        qirsRec.Master_Approver9__c=u9.Id;
        qirsRec.Master_Approver10__c=u10.Id;*/
        qirsRec.Approver_Contacted1__c=true;
        qirsRec.Approver_Contacted2__c=true;
        qirsRec.Approver_Contacted3__c=true;
        qirsRec.Approver_Contacted4__c=true;
        qirsRec.Approver_Contacted5__c=true;
        qirsRec.Approver_Contacted6__c=true;
        qirsRec.Approver_Contacted7__c=true;
        qirsRec.Approver_Contacted8__c=true;
        qirsRec.Approver_Contacted9__c=true;
        qirsRec.Approver_Contacted10__c=true;
        qirsRec.MCAR__c='test mcar';
        qirsRec.Next_CRSD__c=date.today();
        qirsRec.Watchlist__c=true;
        qirsRec.Closed_Date1__c=date.today()+4;
        qirsRec.Operator_Warning_Message__c='warning1';
        qirsRec.Orders_backlog__c='test order backlog';
        qirsRec.Orders_Impact__c='test impact';
        qirsRec.Last_Approved_Program_Milestone__c='P1';
        qirsRec.View_Product_Name__c='test product name';
        qirsRec.Revenue_Backlog__c='test';
        qirsRec.Status__c='Open';
        qirsRec.WatchListComment__c='test commment';
        qirsRec.WatchListType__c='test';
        qirsRec.Revenue_Impact__c='test';
        qirsRec.Serial_Numbers__c='0001';
        qirsRec.Lock_Points_SH_Shipping__c=true;
        qirsRec.Site1__c='Alsdorf';
        qirsRec.Supplier__c='test Supplier';
        qirsRec.Total_Quality_Spills_Cost__c='1000';
        qirsRec.Units_Backlog__c='100';
        qirsRec.Units_Impact__c='100';
        qirsRec.View_AP_Color__c='yellow';
        qirsRec.View_Release_Product__c='test release';
        qirsRec.Yes__c=true; 
        qirsRec.MCAR_Supplier_Claim__c='test claim';
        qirsRec.Pronto__c='test pronto';
        qirsRec.Resolve__c='yes';
        qirsRec.RCA_EDA__c='test';
        qirsRec.Line_Stop__c='test';
        qirsRec.Affected_Unit_at_Customer_Action__c='N/A';
        qirsRec.Affected_Unit_at_Hubs_Action__c='N/A';
        qirsRec.Affected_Unit_at_Factories_Action__c='N/A';
        qirsRec.Affected_Units_at_HWS_Action__c='N/A';
        qirsRec.Affected_Units_at_Suppliers_Action__c='N/A';
        qirsRec.Additional_Email__c='priyaburghate@yahoo.in';
        qirsRec.Affected_Units_at_HWS__c=10;
        qirsRec.Affected_Units_at_Suppliers__c=10;
        //qirsRec.Process_Owner1__c=u.id;
        insert qirsRec;
     //  List<QIRS_Action_Plan_Approver_List__c> aplan = new List<QIRS_Action_Plan_Approver_List__c>(); 
            //for(User user1:uList)
       // for(integer i=0; i<uList.size(); i++){
        
         QIRS_Action_Plan_Approver_List__c aplanlist = new QIRS_Action_Plan_Approver_List__c();
         aplanlist.Email__c='priyaburghate@yahoo.in';
         aplanlist.Business__c=qirsRec.Business__c;
         aplanlist.Phone__c='123445123';
         //aplanlist.Approver_Contacted__c=true;
         aplanlist.User__c= u.Id;
          insert aplanlist;      
           
         test.startTest();
       
        ApexPages.StandardController sc = new ApexPages.standardController(qirsRec);
         ApexPages.CurrentPage().getparameters().put('id',null);
        QIRS_Create_Controller obj2 = new QIRS_Create_Controller(sc);
        ApexPages.CurrentPage().getparameters().put('id', qirsRec.id);
        QIRS_Create_Controller obj1 = new QIRS_Create_Controller(sc);
        for(integer i=0; i<userlist1.size(); i++){
            
        }   
            //List<String> userList = new List<String>();
            
            //userList.add(u.Id);
            //obj1.MasterApprlist=userList;
            
           
                
                //obj1.MasterApprlist=userList[i];
                
            
        //obj1.MasterApprlist= new List<User> {u};
        
        obj1.strMode='EDIT';
        obj1.getMultiApprover();
        obj1.Save();
        obj1.Cancel();
        obj1.AssignContactedApp();
        obj1.getSite();
        obj1.getBusiness();
        obj1.getStatus();
        obj1.getApprover();
        obj1.getTEST();
        obj1.getAlertType();
        obj1.AssignContactedApp();
        test.stopTest();
        
        }
    }

    
    static testmethod void test5(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS'];
        User u = new User(Alias = 'standt', Email='priyaburghate@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11@testorg.com');
       User u2= new User(Alias = 'standt', Email='priyaburghat@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUsrr11@testorg.com');
        system.runas(u2){
            
        QIRS__c qirsRec = new QIRS__c();
        qirsRec.Case_Name__c='test';
        qirsRec.Access_Stop_Ship_Code__c='test access code';
        qirsRec.Exposed_Base__c='test base';
        qirsRec.Factory_DC__c='test';
        qirsRec.Customer__c='test';
        qirsRec.Customer_Impact__c='High';
        qirsRec.Expected_Number_of_return__c='100';
        qirsRec.NSN_Part_Number__c='121';
        qirsRec.Product_Safety__c=false;
        qirsRec.Supplier_Pn__c='test Supplier Pn';
        qirsRec.Core_ID__c='test';
        qirsRec.Approval_Comments__c='test comments';
        qirsRec.IsDefaultReleased__c=true;
        qirsRec.Process_Owner1__c=u2.Id;
        qirsRec.Business__c='zzGlobal Services';
        qirsRec.Business_Group__c='3G Core';
        qirsRec.Problem_Description1__c='test description';
        qirsRec.Alert_Type__c='Quality Alert';
        qirsRec.Projected_Lift_Date__c=system.today();
        qirsRec.Estimated_close_date__c=system.today()+5;
        qirsRec.Impacted_Region_Customer__c='test';
        qirsRec.Factory__c='OMP, Italy';
        qirsRec.Defective_Part__c='Design';
        qirsRec.Symptom__c='Software';
        qirsRec.Group_to_Notify__c='test group';
        qirsRec.Countries__c='India';
        qirsRec.Impacted_Region__c='All';
        qirsRec.Lifted_Date__c=date.today();
        qirsRec.Issue_Level__c='Medium';
        qirsRec.Master_Approver__c= u.Id;
       //irsRec.Master_Approver1__c=u.Id;
      //qirsRec.Master_Approver2__c=u.Id;
       qirsRec.Master_Approver3__c=u2.Id;
      /*qirsRec.Master_Approver4__c=u.Id;
        qirsRec.Master_Approver5__c=u.Id;
        qirsRec.Master_Approver6__c=u.Id;
        qirsRec.Master_Approver7__c=u.Id;
        qirsRec.Master_Approver8__c=u.Id;
        qirsRec.Master_Approver9__c=u.Id;
        qirsRec.Master_Approver10__c=u.Id;*/
        qirsRec.Approver_Contacted1__c=true;
        qirsRec.Approver_Contacted2__c=true;
        qirsRec.Approver_Contacted3__c=true;
        qirsRec.Approver_Contacted4__c=true;
        qirsRec.Approver_Contacted5__c=true;
        qirsRec.Approver_Contacted6__c=true;
        qirsRec.Approver_Contacted7__c=true;
        qirsRec.Approver_Contacted8__c=true;
        qirsRec.Approver_Contacted9__c=true;
        qirsRec.Approver_Contacted10__c=true;
        qirsRec.MCAR__c='test mcar';
        qirsRec.Next_CRSD__c=date.today();
        qirsRec.Watchlist__c=true;
        qirsRec.Closed_Date1__c=date.today()+4;
        qirsRec.Operator_Warning_Message__c='warning1';
        qirsRec.Orders_backlog__c='test order backlog';
        qirsRec.Orders_Impact__c='test impact';
        qirsRec.Last_Approved_Program_Milestone__c='P1';
        qirsRec.View_Product_Name__c='test product name';
        qirsRec.Revenue_Backlog__c='test';
        qirsRec.Status__c='Open';
        qirsRec.WatchListComment__c='test commment';
        qirsRec.WatchListType__c='test';
        qirsRec.Revenue_Impact__c='test';
        qirsRec.Serial_Numbers__c='0001';
        qirsRec.Lock_Points_SH_Shipping__c=true;
        qirsRec.Site1__c='Alsdorf';
        qirsRec.Supplier__c='test Supplier';
        qirsRec.Total_Quality_Spills_Cost__c='1000';
        qirsRec.Units_Backlog__c='100';
        qirsRec.Units_Impact__c='100';
        qirsRec.View_AP_Color__c='yellow';
        qirsRec.View_Release_Product__c='test release';
        qirsRec.Yes__c=true; 
        qirsRec.MCAR_Supplier_Claim__c='test claim';
        qirsRec.Pronto__c='test pronto';
        qirsRec.Resolve__c='yes';
        qirsRec.RCA_EDA__c='test';
        qirsRec.Line_Stop__c='test';
        qirsRec.Affected_Unit_at_Customer_Action__c='N/A';
        qirsRec.Affected_Unit_at_Hubs_Action__c='N/A';
        qirsRec.Affected_Unit_at_Factories_Action__c='N/A';
        qirsRec.Affected_Units_at_HWS_Action__c='N/A';
        qirsRec.Affected_Units_at_Suppliers_Action__c='N/A';
        qirsRec.Additional_Email__c='priyaburghate@yahoo.in';
        qirsRec.Affected_Units_at_HWS__c=10;
        qirsRec.Affected_Units_at_Suppliers__c=10;
        insert qirsRec;
        
        List<QIRS_Action_Plan_Approver_List__c> applist = new List<QIRS_Action_Plan_Approver_List__c>();
        
        QIRS_Action_Plan_Approver_List__c aplanlist = new QIRS_Action_Plan_Approver_List__c();
         aplanlist.Email__c='priyaburghate@yahoo.in';
         aplanlist.Business__c=qirsRec.Business__c;
         aplanlist.Phone__c='123445';
         aplanlist.Approver_Contacted__c=true;
         aplanlist.User__c=u2.Id;
            insert aplanlist;
            
           
        
            
         test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(qirsRec);
        ApexPages.CurrentPage().getparameters().put('id', qirsRec.id);
        QIRS_Create_Controller obj1 = new QIRS_Create_Controller(sc);  
        obj1.strMode='EDIT';
        obj1.getMultiApprover();
        obj1.Save();
        obj1.Cancel();
        obj1.AssignContactedApp();
        obj1.getSite();
        obj1.getBusiness();
        obj1.getStatus();
        obj1.getApprover();
        obj1.getTEST();
        obj1.getAlertType();
        obj1.AssignContactedApp();
        test.stopTest();
        
    
    }
    }

    
    static testmethod void test6(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS'];
        User u = new User(Alias = 'standt', Email='priyaburghate@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11@testorg.com');
       User u2= new User(Alias = 'standt', Email='priyaburghat@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUsrr11@testorg.com');
        system.runas(u2){
            
        QIRS__c qirsRec = new QIRS__c();
        qirsRec.Case_Name__c='test';
        qirsRec.Access_Stop_Ship_Code__c='test access code';
        qirsRec.Exposed_Base__c='test base';
        qirsRec.Factory_DC__c='test';
        qirsRec.Customer__c='test';
        qirsRec.Customer_Impact__c='High';
        qirsRec.Expected_Number_of_return__c='100';
        qirsRec.NSN_Part_Number__c='121';
        qirsRec.Product_Safety__c=false;
        qirsRec.Supplier_Pn__c='test Supplier Pn';
        qirsRec.Core_ID__c='test';
        qirsRec.Approval_Comments__c='test comments';
        qirsRec.IsDefaultReleased__c=true;
        qirsRec.Process_Owner1__c=u2.Id;
        qirsRec.Business__c='zzGlobal Services';
        qirsRec.Business_Group__c='3G Core';
        qirsRec.Problem_Description1__c='test description';
        qirsRec.Alert_Type__c='Quality Alert';
        qirsRec.Projected_Lift_Date__c=system.today();
        qirsRec.Estimated_close_date__c=system.today()+5;
        qirsRec.Impacted_Region_Customer__c='test';
        qirsRec.Factory__c='OMP, Italy';
        qirsRec.Defective_Part__c='Design';
        qirsRec.Symptom__c='Software';
        qirsRec.Group_to_Notify__c='test group';
        qirsRec.Countries__c='India';
        qirsRec.Impacted_Region__c='All';
        qirsRec.Lifted_Date__c=date.today();
        qirsRec.Issue_Level__c='Medium';
        qirsRec.Master_Approver__c= u.Id;
       //irsRec.Master_Approver1__c=u.Id;
      //qirsRec.Master_Approver2__c=u.Id;
      //irsRec.Master_Approver3__c=u2.Id;
      qirsRec.Master_Approver4__c=u2.Id;
      /*qirsRec.Master_Approver5__c=u.Id;
        qirsRec.Master_Approver6__c=u.Id;
        qirsRec.Master_Approver7__c=u.Id;
        qirsRec.Master_Approver8__c=u.Id;
        qirsRec.Master_Approver9__c=u.Id;
        qirsRec.Master_Approver10__c=u.Id;*/
        qirsRec.Approver_Contacted1__c=true;
        qirsRec.Approver_Contacted2__c=true;
        qirsRec.Approver_Contacted3__c=true;
        qirsRec.Approver_Contacted4__c=true;
        qirsRec.Approver_Contacted5__c=true;
        qirsRec.Approver_Contacted6__c=true;
        qirsRec.Approver_Contacted7__c=true;
        qirsRec.Approver_Contacted8__c=true;
        qirsRec.Approver_Contacted9__c=true;
        qirsRec.Approver_Contacted10__c=true;
        qirsRec.MCAR__c='test mcar';
        qirsRec.Next_CRSD__c=date.today();
        qirsRec.Watchlist__c=true;
        qirsRec.Closed_Date1__c=date.today()+4;
        qirsRec.Operator_Warning_Message__c='warning1';
        qirsRec.Orders_backlog__c='test order backlog';
        qirsRec.Orders_Impact__c='test impact';
        qirsRec.Last_Approved_Program_Milestone__c='P1';
        qirsRec.View_Product_Name__c='test product name';
        qirsRec.Revenue_Backlog__c='test';
        qirsRec.Status__c='Open';
        qirsRec.WatchListComment__c='test commment';
        qirsRec.WatchListType__c='test';
        qirsRec.Revenue_Impact__c='test';
        qirsRec.Serial_Numbers__c='0001';
        qirsRec.Lock_Points_SH_Shipping__c=true;
        qirsRec.Site1__c='Alsdorf';
        qirsRec.Supplier__c='test Supplier';
        qirsRec.Total_Quality_Spills_Cost__c='1000';
        qirsRec.Units_Backlog__c='100';
        qirsRec.Units_Impact__c='100';
        qirsRec.View_AP_Color__c='yellow';
        qirsRec.View_Release_Product__c='test release';
        qirsRec.Yes__c=true; 
        qirsRec.MCAR_Supplier_Claim__c='test claim';
        qirsRec.Pronto__c='test pronto';
        qirsRec.Resolve__c='yes';
        qirsRec.RCA_EDA__c='test';
        qirsRec.Line_Stop__c='test';
        qirsRec.Affected_Unit_at_Customer_Action__c='N/A';
        qirsRec.Affected_Unit_at_Hubs_Action__c='N/A';
        qirsRec.Affected_Unit_at_Factories_Action__c='N/A';
        qirsRec.Affected_Units_at_HWS_Action__c='N/A';
        qirsRec.Affected_Units_at_Suppliers_Action__c='N/A';
        qirsRec.Additional_Email__c='priyaburghate@yahoo.in';
        qirsRec.Affected_Units_at_HWS__c=10;
        qirsRec.Affected_Units_at_Suppliers__c=10;
        insert qirsRec;
        
        List<QIRS_Action_Plan_Approver_List__c> applist = new List<QIRS_Action_Plan_Approver_List__c>();
        
        QIRS_Action_Plan_Approver_List__c aplanlist = new QIRS_Action_Plan_Approver_List__c();
         aplanlist.Email__c='priyaburghate@yahoo.in';
         aplanlist.Business__c=qirsRec.Business__c;
         aplanlist.Phone__c='123445';
         aplanlist.Approver_Contacted__c=true;
         aplanlist.User__c=u2.Id;
            insert aplanlist;
            
           
        
            
         test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(qirsRec);
        ApexPages.CurrentPage().getparameters().put('id', qirsRec.id);
        QIRS_Create_Controller obj1 = new QIRS_Create_Controller(sc);  
        obj1.strMode='EDIT';
        obj1.getMultiApprover();
        obj1.Save();
        obj1.Cancel();
        obj1.AssignContactedApp();
        obj1.getSite();
        obj1.getBusiness();
        obj1.getStatus();
        obj1.getApprover();
        obj1.getTEST();
        obj1.getAlertType();
        obj1.AssignContactedApp();
        test.stopTest();
        
    
    }
    }
    
    static testmethod void test7(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS'];
        User u = new User(Alias = 'standt', Email='priyaburghate@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11@testorg.com');
       User u2= new User(Alias = 'standt', Email='priyaburghat@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUsrr11@testorg.com');
        system.runas(u2){
            
        QIRS__c qirsRec = new QIRS__c();
        qirsRec.Case_Name__c='test';
        qirsRec.Access_Stop_Ship_Code__c='test access code';
        qirsRec.Exposed_Base__c='test base';
        qirsRec.Factory_DC__c='test';
        qirsRec.Customer__c='test';
        qirsRec.Customer_Impact__c='High';
        qirsRec.Expected_Number_of_return__c='100';
        qirsRec.NSN_Part_Number__c='121';
        qirsRec.Product_Safety__c=false;
        qirsRec.Supplier_Pn__c='test Supplier Pn';
        qirsRec.Core_ID__c='test';
        qirsRec.Approval_Comments__c='test comments';
        qirsRec.IsDefaultReleased__c=true;
        qirsRec.Process_Owner1__c=u2.Id;
        qirsRec.Business__c='zzGlobal Services';
        qirsRec.Business_Group__c='3G Core';
        qirsRec.Problem_Description1__c='test description';
        qirsRec.Alert_Type__c='Quality Alert';
        qirsRec.Projected_Lift_Date__c=system.today();
        qirsRec.Estimated_close_date__c=system.today()+5;
        qirsRec.Impacted_Region_Customer__c='test';
        qirsRec.Factory__c='OMP, Italy';
        qirsRec.Defective_Part__c='Design';
        qirsRec.Symptom__c='Software';
        qirsRec.Group_to_Notify__c='test group';
        qirsRec.Countries__c='India';
        qirsRec.Impacted_Region__c='All';
        qirsRec.Lifted_Date__c=date.today();
        qirsRec.Issue_Level__c='Medium';
        qirsRec.Master_Approver__c= u.Id;
       //irsRec.Master_Approver1__c=u.Id;
      //qirsRec.Master_Approver2__c=u.Id;
     //qirsRec.Master_Approver3__c=u2.Id;
      //irsRec.Master_Approver4__c=u.Id;
        qirsRec.Master_Approver5__c=u2.Id;
      /*qirsRec.Master_Approver6__c=u.Id;
        qirsRec.Master_Approver7__c=u.Id;
        qirsRec.Master_Approver8__c=u.Id;
        qirsRec.Master_Approver9__c=u.Id;
        qirsRec.Master_Approver10__c=u.Id;*/
        qirsRec.Approver_Contacted1__c=true;
        qirsRec.Approver_Contacted2__c=true;
        qirsRec.Approver_Contacted3__c=true;
        qirsRec.Approver_Contacted4__c=true;
        qirsRec.Approver_Contacted5__c=true;
        qirsRec.Approver_Contacted6__c=true;
        qirsRec.Approver_Contacted7__c=true;
        qirsRec.Approver_Contacted8__c=true;
        qirsRec.Approver_Contacted9__c=true;
        qirsRec.Approver_Contacted10__c=true;
        qirsRec.MCAR__c='test mcar';
        qirsRec.Next_CRSD__c=date.today();
        qirsRec.Watchlist__c=true;
        qirsRec.Closed_Date1__c=date.today()+4;
        qirsRec.Operator_Warning_Message__c='warning1';
        qirsRec.Orders_backlog__c='test order backlog';
        qirsRec.Orders_Impact__c='test impact';
        qirsRec.Last_Approved_Program_Milestone__c='P1';
        qirsRec.View_Product_Name__c='test product name';
        qirsRec.Revenue_Backlog__c='test';
        qirsRec.Status__c='Open';
        qirsRec.WatchListComment__c='test commment';
        qirsRec.WatchListType__c='test';
        qirsRec.Revenue_Impact__c='test';
        qirsRec.Serial_Numbers__c='0001';
        qirsRec.Lock_Points_SH_Shipping__c=true;
        qirsRec.Site1__c='Alsdorf';
        qirsRec.Supplier__c='test Supplier';
        qirsRec.Total_Quality_Spills_Cost__c='1000';
        qirsRec.Units_Backlog__c='100';
        qirsRec.Units_Impact__c='100';
        qirsRec.View_AP_Color__c='yellow';
        qirsRec.View_Release_Product__c='test release';
        qirsRec.Yes__c=true; 
        qirsRec.MCAR_Supplier_Claim__c='test claim';
        qirsRec.Pronto__c='test pronto';
        qirsRec.Resolve__c='yes';
        qirsRec.RCA_EDA__c='test';
        qirsRec.Line_Stop__c='test';
        qirsRec.Affected_Unit_at_Customer_Action__c='N/A';
        qirsRec.Affected_Unit_at_Hubs_Action__c='N/A';
        qirsRec.Affected_Unit_at_Factories_Action__c='N/A';
        qirsRec.Affected_Units_at_HWS_Action__c='N/A';
        qirsRec.Affected_Units_at_Suppliers_Action__c='N/A';
        qirsRec.Additional_Email__c='priyaburghate@yahoo.in';
        qirsRec.Affected_Units_at_HWS__c=10;
        qirsRec.Affected_Units_at_Suppliers__c=10;
        insert qirsRec;
        
        List<QIRS_Action_Plan_Approver_List__c> applist = new List<QIRS_Action_Plan_Approver_List__c>();
        
        QIRS_Action_Plan_Approver_List__c aplanlist = new QIRS_Action_Plan_Approver_List__c();
         aplanlist.Email__c='priyaburghate@yahoo.in';
         aplanlist.Business__c=qirsRec.Business__c;
         aplanlist.Phone__c='123445';
         aplanlist.Approver_Contacted__c=true;
         aplanlist.User__c=u2.Id;
            insert aplanlist;
            
           
        
            
         test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(qirsRec);
        ApexPages.CurrentPage().getparameters().put('id', qirsRec.id);
        QIRS_Create_Controller obj1 = new QIRS_Create_Controller(sc);  
        obj1.strMode='EDIT';
        obj1.getMultiApprover();
        obj1.Save();
        obj1.Cancel();
        obj1.AssignContactedApp();
        obj1.getSite();
        obj1.getBusiness();
        obj1.getStatus();
        obj1.getApprover();
        obj1.getTEST();
        obj1.getAlertType();
        obj1.AssignContactedApp();
        test.stopTest();
        
    
    }
    }

     static testmethod void test8(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS'];
        User u = new User(Alias = 'standt', Email='priyaburghate@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11@testorg.com');
       User u2= new User(Alias = 'standt', Email='priyaburghat@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUsrr11@testorg.com');
        system.runas(u2){
            
        QIRS__c qirsRec = new QIRS__c();
        qirsRec.Case_Name__c='test';
        qirsRec.Access_Stop_Ship_Code__c='test access code';
        qirsRec.Exposed_Base__c='test base';
        qirsRec.Factory_DC__c='test';
        qirsRec.Customer__c='test';
        qirsRec.Customer_Impact__c='High';
        qirsRec.Expected_Number_of_return__c='100';
        qirsRec.NSN_Part_Number__c='121';
        qirsRec.Product_Safety__c=false;
        qirsRec.Supplier_Pn__c='test Supplier Pn';
        qirsRec.Core_ID__c='test';
        qirsRec.Approval_Comments__c='test comments';
        qirsRec.IsDefaultReleased__c=true;
        qirsRec.Process_Owner1__c=u2.Id;
        qirsRec.Business__c='zzGlobal Services';
        qirsRec.Business_Group__c='3G Core';
        qirsRec.Problem_Description1__c='test description';
        qirsRec.Alert_Type__c='Quality Alert';
        qirsRec.Projected_Lift_Date__c=system.today();
        qirsRec.Estimated_close_date__c=system.today()+5;
        qirsRec.Impacted_Region_Customer__c='test';
        qirsRec.Factory__c='OMP, Italy';
        qirsRec.Defective_Part__c='Design';
        qirsRec.Symptom__c='Software';
        qirsRec.Group_to_Notify__c='test group';
        qirsRec.Countries__c='India';
        qirsRec.Impacted_Region__c='All';
        qirsRec.Lifted_Date__c=date.today();
        qirsRec.Issue_Level__c='Medium';
        qirsRec.Master_Approver__c= u.Id;
       //irsRec.Master_Approver1__c=u.Id;
      //qirsRec.Master_Approver2__c=u.Id;
     //qirsRec.Master_Approver3__c=u2.Id;
      //irsRec.Master_Approver4__c=u.Id;
     // qirsRec.Master_Approver5__c=u.Id;
      qirsRec.Master_Approver6__c=u2.Id;
      /*qirsRec.Master_Approver7__c=u.Id;
        qirsRec.Master_Approver8__c=u.Id;
        qirsRec.Master_Approver9__c=u.Id;
        qirsRec.Master_Approver10__c=u.Id;*/
        qirsRec.Approver_Contacted1__c=true;
        qirsRec.Approver_Contacted2__c=true;
        qirsRec.Approver_Contacted3__c=true;
        qirsRec.Approver_Contacted4__c=true;
        qirsRec.Approver_Contacted5__c=true;
        qirsRec.Approver_Contacted6__c=true;
        qirsRec.Approver_Contacted7__c=true;
        qirsRec.Approver_Contacted8__c=true;
        qirsRec.Approver_Contacted9__c=true;
        qirsRec.Approver_Contacted10__c=true;
        qirsRec.MCAR__c='test mcar';
        qirsRec.Next_CRSD__c=date.today();
        qirsRec.Watchlist__c=true;
        qirsRec.Closed_Date1__c=date.today()+4;
        qirsRec.Operator_Warning_Message__c='warning1';
        qirsRec.Orders_backlog__c='test order backlog';
        qirsRec.Orders_Impact__c='test impact';
        qirsRec.Last_Approved_Program_Milestone__c='P1';
        qirsRec.View_Product_Name__c='test product name';
        qirsRec.Revenue_Backlog__c='test';
        qirsRec.Status__c='Open';
        qirsRec.WatchListComment__c='test commment';
        qirsRec.WatchListType__c='test';
        qirsRec.Revenue_Impact__c='test';
        qirsRec.Serial_Numbers__c='0001';
        qirsRec.Lock_Points_SH_Shipping__c=true;
        qirsRec.Site1__c='Alsdorf';
        qirsRec.Supplier__c='test Supplier';
        qirsRec.Total_Quality_Spills_Cost__c='1000';
        qirsRec.Units_Backlog__c='100';
        qirsRec.Units_Impact__c='100';
        qirsRec.View_AP_Color__c='yellow';
        qirsRec.View_Release_Product__c='test release';
        qirsRec.Yes__c=true; 
        qirsRec.MCAR_Supplier_Claim__c='test claim';
        qirsRec.Pronto__c='test pronto';
        qirsRec.Resolve__c='yes';
        qirsRec.RCA_EDA__c='test';
        qirsRec.Line_Stop__c='test';
        qirsRec.Affected_Unit_at_Customer_Action__c='N/A';
        qirsRec.Affected_Unit_at_Hubs_Action__c='N/A';
        qirsRec.Affected_Unit_at_Factories_Action__c='N/A';
        qirsRec.Affected_Units_at_HWS_Action__c='N/A';
        qirsRec.Affected_Units_at_Suppliers_Action__c='N/A';
        qirsRec.Additional_Email__c='priyaburghate@yahoo.in';
        qirsRec.Affected_Units_at_HWS__c=10;
        qirsRec.Affected_Units_at_Suppliers__c=10;
        insert qirsRec;
        
        List<QIRS_Action_Plan_Approver_List__c> applist = new List<QIRS_Action_Plan_Approver_List__c>();
        
        QIRS_Action_Plan_Approver_List__c aplanlist = new QIRS_Action_Plan_Approver_List__c();
         aplanlist.Email__c='priyaburghate@yahoo.in';
         aplanlist.Business__c=qirsRec.Business__c;
         aplanlist.Phone__c='123445';
         aplanlist.Approver_Contacted__c=true;
         aplanlist.User__c=u2.Id;
            insert aplanlist;
            
           
        
            
         test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(qirsRec);
        ApexPages.CurrentPage().getparameters().put('id', qirsRec.id);
        QIRS_Create_Controller obj1 = new QIRS_Create_Controller(sc);  
        obj1.strMode='EDIT';
        obj1.getMultiApprover();
        obj1.Save();
        obj1.Cancel();
        obj1.AssignContactedApp();
        obj1.getSite();
        obj1.getBusiness();
        obj1.getStatus();
        obj1.getApprover();
        obj1.getTEST();
        obj1.getAlertType();
        obj1.AssignContactedApp();
        test.stopTest();
        
    
    }
    }
    
     static testmethod void test9(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS'];
        User u = new User(Alias = 'standt', Email='priyaburghate@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11@testorg.com');
       User u2= new User(Alias = 'standt', Email='priyaburghat@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUsrr11@testorg.com');
        system.runas(u2){
            
        QIRS__c qirsRec = new QIRS__c();
        qirsRec.Case_Name__c='test';
        qirsRec.Access_Stop_Ship_Code__c='test access code';
        qirsRec.Exposed_Base__c='test base';
        qirsRec.Factory_DC__c='test';
        qirsRec.Customer__c='test';
        qirsRec.Customer_Impact__c='High';
        qirsRec.Expected_Number_of_return__c='100';
        qirsRec.NSN_Part_Number__c='121';
        qirsRec.Product_Safety__c=false;
        qirsRec.Supplier_Pn__c='test Supplier Pn';
        qirsRec.Core_ID__c='test';
        qirsRec.Approval_Comments__c='test comments';
        qirsRec.IsDefaultReleased__c=true;
        qirsRec.Process_Owner1__c=u2.Id;
        qirsRec.Business__c='zzGlobal Services';
        qirsRec.Business_Group__c='3G Core';
        qirsRec.Problem_Description1__c='test description';
        qirsRec.Alert_Type__c='Quality Alert';
        qirsRec.Projected_Lift_Date__c=system.today();
        qirsRec.Estimated_close_date__c=system.today()+5;
        qirsRec.Impacted_Region_Customer__c='test';
        qirsRec.Factory__c='OMP, Italy';
        qirsRec.Defective_Part__c='Design';
        qirsRec.Symptom__c='Software';
        qirsRec.Group_to_Notify__c='test group';
        qirsRec.Countries__c='India';
        qirsRec.Impacted_Region__c='All';
        qirsRec.Lifted_Date__c=date.today();
        qirsRec.Issue_Level__c='Medium';
        qirsRec.Master_Approver__c= u.Id;
       //irsRec.Master_Approver1__c=u.Id;
      //qirsRec.Master_Approver2__c=u.Id;
     //qirsRec.Master_Approver3__c=u2.Id;
      //irsRec.Master_Approver4__c=u.Id;
       //irsRec.Master_Approver5__c=u.Id;
      //irsRec.Master_Approver6__c=u.Id;
        qirsRec.Master_Approver7__c=u2.Id;
      /*qirsRec.Master_Approver8__c=u.Id;
        qirsRec.Master_Approver9__c=u.Id;
        qirsRec.Master_Approver10__c=u.Id;*/
        qirsRec.Approver_Contacted1__c=true;
        qirsRec.Approver_Contacted2__c=true;
        qirsRec.Approver_Contacted3__c=true;
        qirsRec.Approver_Contacted4__c=true;
        qirsRec.Approver_Contacted5__c=true;
        qirsRec.Approver_Contacted6__c=true;
        qirsRec.Approver_Contacted7__c=true;
        qirsRec.Approver_Contacted8__c=true;
        qirsRec.Approver_Contacted9__c=true;
        qirsRec.Approver_Contacted10__c=true;
        qirsRec.MCAR__c='test mcar';
        qirsRec.Next_CRSD__c=date.today();
        qirsRec.Watchlist__c=true;
        qirsRec.Closed_Date1__c=date.today()+4;
        qirsRec.Operator_Warning_Message__c='warning1';
        qirsRec.Orders_backlog__c='test order backlog';
        qirsRec.Orders_Impact__c='test impact';
        qirsRec.Last_Approved_Program_Milestone__c='P1';
        qirsRec.View_Product_Name__c='test product name';
        qirsRec.Revenue_Backlog__c='test';
        qirsRec.Status__c='Open';
        qirsRec.WatchListComment__c='test commment';
        qirsRec.WatchListType__c='test';
        qirsRec.Revenue_Impact__c='test';
        qirsRec.Serial_Numbers__c='0001';
        qirsRec.Lock_Points_SH_Shipping__c=true;
        qirsRec.Site1__c='Alsdorf';
        qirsRec.Supplier__c='test Supplier';
        qirsRec.Total_Quality_Spills_Cost__c='1000';
        qirsRec.Units_Backlog__c='100';
        qirsRec.Units_Impact__c='100';
        qirsRec.View_AP_Color__c='yellow';
        qirsRec.View_Release_Product__c='test release';
        qirsRec.Yes__c=true; 
        qirsRec.MCAR_Supplier_Claim__c='test claim';
        qirsRec.Pronto__c='test pronto';
        qirsRec.Resolve__c='yes';
        qirsRec.RCA_EDA__c='test';
        qirsRec.Line_Stop__c='test';
        qirsRec.Affected_Unit_at_Customer_Action__c='N/A';
        qirsRec.Affected_Unit_at_Hubs_Action__c='N/A';
        qirsRec.Affected_Unit_at_Factories_Action__c='N/A';
        qirsRec.Affected_Units_at_HWS_Action__c='N/A';
        qirsRec.Affected_Units_at_Suppliers_Action__c='N/A';
        qirsRec.Additional_Email__c='priyaburghate@yahoo.in';
        qirsRec.Affected_Units_at_HWS__c=10;
        qirsRec.Affected_Units_at_Suppliers__c=10;
        insert qirsRec;
        
        List<QIRS_Action_Plan_Approver_List__c> applist = new List<QIRS_Action_Plan_Approver_List__c>();
        
        QIRS_Action_Plan_Approver_List__c aplanlist = new QIRS_Action_Plan_Approver_List__c();
         aplanlist.Email__c='priyaburghate@yahoo.in';
         aplanlist.Business__c=qirsRec.Business__c;
         aplanlist.Phone__c='123445';
         aplanlist.Approver_Contacted__c=true;
         aplanlist.User__c=u2.Id;
            insert aplanlist;
            
           
        
            
         test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(qirsRec);
        ApexPages.CurrentPage().getparameters().put('id', qirsRec.id);
        QIRS_Create_Controller obj1 = new QIRS_Create_Controller(sc);  
        obj1.strMode='EDIT';
        obj1.getMultiApprover();
        obj1.Save();
        obj1.Cancel();
        obj1.AssignContactedApp();
        obj1.getSite();
        obj1.getBusiness();
        obj1.getStatus();
        obj1.getApprover();
        obj1.getTEST();
        obj1.getAlertType();
        obj1.AssignContactedApp();
        test.stopTest();
        
    
    }
    }
    
     static testmethod void tes10(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS'];
        User u = new User(Alias = 'standt', Email='priyaburghate@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11@testorg.com');
       User u2= new User(Alias = 'standt', Email='priyaburghat@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUsrr11@testorg.com');
        system.runas(u2){
            
        QIRS__c qirsRec = new QIRS__c();
        qirsRec.Case_Name__c='test';
        qirsRec.Access_Stop_Ship_Code__c='test access code';
        qirsRec.Exposed_Base__c='test base';
        qirsRec.Factory_DC__c='test';
        qirsRec.Customer__c='test';
        qirsRec.Customer_Impact__c='High';
        qirsRec.Expected_Number_of_return__c='100';
        qirsRec.NSN_Part_Number__c='121';
        qirsRec.Product_Safety__c=false;
        qirsRec.Supplier_Pn__c='test Supplier Pn';
        qirsRec.Core_ID__c='test';
        qirsRec.Approval_Comments__c='test comments';
        qirsRec.IsDefaultReleased__c=true;
        qirsRec.Process_Owner1__c=u2.Id;
        qirsRec.Business__c='zzGlobal Services';
        qirsRec.Business_Group__c='3G Core';
        qirsRec.Problem_Description1__c='test description';
        qirsRec.Alert_Type__c='Quality Alert';
        qirsRec.Projected_Lift_Date__c=system.today();
        qirsRec.Estimated_close_date__c=system.today()+5;
        qirsRec.Impacted_Region_Customer__c='test';
        qirsRec.Factory__c='OMP, Italy';
        qirsRec.Defective_Part__c='Design';
        qirsRec.Symptom__c='Software';
        qirsRec.Group_to_Notify__c='test group';
        qirsRec.Countries__c='India';
        qirsRec.Impacted_Region__c='All';
        qirsRec.Lifted_Date__c=date.today();
        qirsRec.Issue_Level__c='Medium';
        qirsRec.Master_Approver__c= u.Id;
       //irsRec.Master_Approver1__c=u.Id;
      //qirsRec.Master_Approver2__c=u.Id;
     //qirsRec.Master_Approver3__c=u2.Id;
      //irsRec.Master_Approver4__c=u.Id;
      //qirsRec.Master_Approver5__c=u.Id;
      //rsRec.Master_Approver6__c=u.Id;
        //rsRec.Master_Approver7__c=u.Id;
        qirsRec.Master_Approver8__c=u2.Id;
       /*irsRec.Master_Approver9__c=u.Id;
        qirsRec.Master_Approver10__c=u.Id;*/
        qirsRec.Approver_Contacted1__c=true;
        qirsRec.Approver_Contacted2__c=true;
        qirsRec.Approver_Contacted3__c=true;
        qirsRec.Approver_Contacted4__c=true;
        qirsRec.Approver_Contacted5__c=true;
        qirsRec.Approver_Contacted6__c=true;
        qirsRec.Approver_Contacted7__c=true;
        qirsRec.Approver_Contacted8__c=true;
        qirsRec.Approver_Contacted9__c=true;
        qirsRec.Approver_Contacted10__c=true;
        qirsRec.MCAR__c='test mcar';
        qirsRec.Next_CRSD__c=date.today();
        qirsRec.Watchlist__c=true;
        qirsRec.Closed_Date1__c=date.today()+4;
        qirsRec.Operator_Warning_Message__c='warning1';
        qirsRec.Orders_backlog__c='test order backlog';
        qirsRec.Orders_Impact__c='test impact';
        qirsRec.Last_Approved_Program_Milestone__c='P1';
        qirsRec.View_Product_Name__c='test product name';
        qirsRec.Revenue_Backlog__c='test';
        qirsRec.Status__c='Open';
        qirsRec.WatchListComment__c='test commment';
        qirsRec.WatchListType__c='test';
        qirsRec.Revenue_Impact__c='test';
        qirsRec.Serial_Numbers__c='0001';
        qirsRec.Lock_Points_SH_Shipping__c=true;
        qirsRec.Site1__c='Alsdorf';
        qirsRec.Supplier__c='test Supplier';
        qirsRec.Total_Quality_Spills_Cost__c='1000';
        qirsRec.Units_Backlog__c='100';
        qirsRec.Units_Impact__c='100';
        qirsRec.View_AP_Color__c='yellow';
        qirsRec.View_Release_Product__c='test release';
        qirsRec.Yes__c=true; 
        qirsRec.MCAR_Supplier_Claim__c='test claim';
        qirsRec.Pronto__c='test pronto';
        qirsRec.Resolve__c='yes';
        qirsRec.RCA_EDA__c='test';
        qirsRec.Line_Stop__c='test';
        qirsRec.Affected_Unit_at_Customer_Action__c='N/A';
        qirsRec.Affected_Unit_at_Hubs_Action__c='N/A';
        qirsRec.Affected_Unit_at_Factories_Action__c='N/A';
        qirsRec.Affected_Units_at_HWS_Action__c='N/A';
        qirsRec.Affected_Units_at_Suppliers_Action__c='N/A';
        qirsRec.Additional_Email__c='priyaburghate@yahoo.in';
        qirsRec.Affected_Units_at_HWS__c=10;
        qirsRec.Affected_Units_at_Suppliers__c=10;
        insert qirsRec;
        
        List<QIRS_Action_Plan_Approver_List__c> applist = new List<QIRS_Action_Plan_Approver_List__c>();
        
        QIRS_Action_Plan_Approver_List__c aplanlist = new QIRS_Action_Plan_Approver_List__c();
         aplanlist.Email__c='priyaburghate@yahoo.in';
         aplanlist.Business__c=qirsRec.Business__c;
         aplanlist.Phone__c='123445';
         aplanlist.Approver_Contacted__c=true;
         aplanlist.User__c=u2.Id;
            insert aplanlist;
            
           
        
            
         test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(qirsRec);
        ApexPages.CurrentPage().getparameters().put('id', qirsRec.id);
        QIRS_Create_Controller obj1 = new QIRS_Create_Controller(sc);  
        obj1.strMode='EDIT';
        obj1.getMultiApprover();
        obj1.Save();
        obj1.Cancel();
        obj1.AssignContactedApp();
        obj1.getSite();
        obj1.getBusiness();
        obj1.getStatus();
        obj1.getApprover();
        obj1.getTEST();
        obj1.getAlertType();
        obj1.AssignContactedApp();
        test.stopTest();
        
    
    }
    }
    
     static testmethod void tes11(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS'];
        User u = new User(Alias = 'standt', Email='priyaburghate@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11@testorg.com');
       User u2= new User(Alias = 'standt', Email='priyaburghat@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUsrr11@testorg.com');
        system.runas(u2){
            
        QIRS__c qirsRec = new QIRS__c();
        qirsRec.Case_Name__c='test';
        qirsRec.Access_Stop_Ship_Code__c='test access code';
        qirsRec.Exposed_Base__c='test base';
        qirsRec.Factory_DC__c='test';
        qirsRec.Customer__c='test';
        qirsRec.Customer_Impact__c='High';
        qirsRec.Expected_Number_of_return__c='100';
        qirsRec.NSN_Part_Number__c='121';
        qirsRec.Product_Safety__c=false;
        qirsRec.Supplier_Pn__c='test Supplier Pn';
        qirsRec.Core_ID__c='test';
        qirsRec.Approval_Comments__c='test comments';
        qirsRec.IsDefaultReleased__c=true;
        qirsRec.Process_Owner1__c=u2.Id;
        qirsRec.Business__c='zzGlobal Services';
        qirsRec.Business_Group__c='3G Core';
        qirsRec.Problem_Description1__c='test description';
        qirsRec.Alert_Type__c='Quality Alert';
        qirsRec.Projected_Lift_Date__c=system.today();
        qirsRec.Estimated_close_date__c=system.today()+5;
        qirsRec.Impacted_Region_Customer__c='test';
        qirsRec.Factory__c='OMP, Italy';
        qirsRec.Defective_Part__c='Design';
        qirsRec.Symptom__c='Software';
        qirsRec.Group_to_Notify__c='test group';
        qirsRec.Countries__c='India';
        qirsRec.Impacted_Region__c='All';
        qirsRec.Lifted_Date__c=date.today();
        qirsRec.Issue_Level__c='Medium';
        qirsRec.Master_Approver__c= u.Id;
        //qirsRec.Master_Approver1__c=u.Id;
      //qirsRec.Master_Approver2__c=u.Id;
     //qirsRec.Master_Approver3__c=u2.Id;
      //irsRec.Master_Approver4__c=u.Id;
      //qirsRec.Master_Approver5__c=u.Id;
      //qirsRec.Master_Approver6__c=u.Id;
       //irsRec.Master_Approver7__c=u.Id;
       //irsRec.Master_Approver8__c=u.Id;
        qirsRec.Master_Approver9__c=u2.Id;
       //irsRec.Master_Approver10__c=u.Id;
        qirsRec.Approver_Contacted1__c=true;
        qirsRec.Approver_Contacted2__c=true;
        qirsRec.Approver_Contacted3__c=true;
        qirsRec.Approver_Contacted4__c=true;
        qirsRec.Approver_Contacted5__c=true;
        qirsRec.Approver_Contacted6__c=true;
        qirsRec.Approver_Contacted7__c=true;
        qirsRec.Approver_Contacted8__c=true;
        qirsRec.Approver_Contacted9__c=true;
        qirsRec.Approver_Contacted10__c=true;
        qirsRec.MCAR__c='test mcar';
        qirsRec.Next_CRSD__c=date.today();
        qirsRec.Watchlist__c=true;
        qirsRec.Closed_Date1__c=date.today()+4;
        qirsRec.Operator_Warning_Message__c='warning1';
        qirsRec.Orders_backlog__c='test order backlog';
        qirsRec.Orders_Impact__c='test impact';
        qirsRec.Last_Approved_Program_Milestone__c='P1';
        qirsRec.View_Product_Name__c='test product name';
        qirsRec.Revenue_Backlog__c='test';
        qirsRec.Status__c='Open';
        qirsRec.WatchListComment__c='test commment';
        qirsRec.WatchListType__c='test';
        qirsRec.Revenue_Impact__c='test';
        qirsRec.Serial_Numbers__c='0001';
        qirsRec.Lock_Points_SH_Shipping__c=true;
        qirsRec.Site1__c='Alsdorf';
        qirsRec.Supplier__c='test Supplier';
        qirsRec.Total_Quality_Spills_Cost__c='1000';
        qirsRec.Units_Backlog__c='100';
        qirsRec.Units_Impact__c='100';
        qirsRec.View_AP_Color__c='yellow';
        qirsRec.View_Release_Product__c='test release';
        qirsRec.Yes__c=true; 
        qirsRec.MCAR_Supplier_Claim__c='test claim';
        qirsRec.Pronto__c='test pronto';
        qirsRec.Resolve__c='yes';
        qirsRec.RCA_EDA__c='test';
        qirsRec.Line_Stop__c='test';
        qirsRec.Affected_Unit_at_Customer_Action__c='N/A';
        qirsRec.Affected_Unit_at_Hubs_Action__c='N/A';
        qirsRec.Affected_Unit_at_Factories_Action__c='N/A';
        qirsRec.Affected_Units_at_HWS_Action__c='N/A';
        qirsRec.Affected_Units_at_Suppliers_Action__c='N/A';
        qirsRec.Additional_Email__c='priyaburghate@yahoo.in';
        qirsRec.Affected_Units_at_HWS__c=10;
        qirsRec.Affected_Units_at_Suppliers__c=10;
        insert qirsRec;
        
        List<QIRS_Action_Plan_Approver_List__c> applist = new List<QIRS_Action_Plan_Approver_List__c>();
        
        QIRS_Action_Plan_Approver_List__c aplanlist = new QIRS_Action_Plan_Approver_List__c();
         aplanlist.Email__c='priyaburghate@yahoo.in';
         aplanlist.Business__c=qirsRec.Business__c;
         aplanlist.Phone__c='123445';
         aplanlist.Approver_Contacted__c=true;
         aplanlist.User__c=u2.Id;
            insert aplanlist;
            
           
        
            
         test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(qirsRec);
        ApexPages.CurrentPage().getparameters().put('id', qirsRec.id);
        QIRS_Create_Controller obj1 = new QIRS_Create_Controller(sc);  
        obj1.strMode='EDIT';
        obj1.getMultiApprover();
        obj1.Save();
        obj1.Cancel();
        obj1.AssignContactedApp();
        obj1.getSite();
        obj1.getBusiness();
        obj1.getStatus();
        obj1.getApprover();
        obj1.getTEST();
        obj1.getAlertType();
        obj1.AssignContactedApp();
        test.stopTest();
        
    
    }
    }
    
     static testmethod void tes12(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS'];
        User u = new User(Alias = 'standt', Email='priyaburghate@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11@testorg.com');
       User u2= new User(Alias = 'standt', Email='priyaburghat@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUsrr11@testorg.com');
        system.runas(u2){
            
        QIRS__c qirsRec = new QIRS__c();
        qirsRec.Case_Name__c='test';
        qirsRec.Access_Stop_Ship_Code__c='test access code';
        qirsRec.Exposed_Base__c='test base';
        qirsRec.Factory_DC__c='test';
        qirsRec.Customer__c='test';
        qirsRec.Customer_Impact__c='High';
        qirsRec.Expected_Number_of_return__c='100';
        qirsRec.NSN_Part_Number__c='121';
        qirsRec.Product_Safety__c=false;
        qirsRec.Supplier_Pn__c='test Supplier Pn';
        qirsRec.Core_ID__c='test';
        qirsRec.Approval_Comments__c='test comments';
        qirsRec.IsDefaultReleased__c=true;
        qirsRec.Process_Owner1__c=u2.Id;
        qirsRec.Business__c='zzGlobal Services';
        qirsRec.Business_Group__c='3G Core';
        qirsRec.Problem_Description1__c='test description';
        qirsRec.Alert_Type__c='Quality Alert';
        qirsRec.Projected_Lift_Date__c=system.today();
        qirsRec.Estimated_close_date__c=system.today()+5;
        qirsRec.Impacted_Region_Customer__c='test';
        qirsRec.Factory__c='OMP, Italy';
        qirsRec.Defective_Part__c='Design';
        qirsRec.Symptom__c='Software';
        qirsRec.Group_to_Notify__c='test group';
        qirsRec.Countries__c='India';
        qirsRec.Impacted_Region__c='All';
        qirsRec.Lifted_Date__c=date.today();
        qirsRec.Issue_Level__c='Medium';
        qirsRec.Master_Approver__c= u.Id;
       //irsRec.Master_Approver1__c=u.Id;
      //qirsRec.Master_Approver2__c=u.Id;
     //qirsRec.Master_Approver3__c=u2.Id;
      //irsRec.Master_Approver4__c=u.Id;
      //qirsRec.Master_Approver5__c=u.Id;
      /*qirsRec.Master_Approver6__c=u.Id;
      //qirsRec.Master_Approver7__c=u.Id;
       //irsRec.Master_Approver8__c=u.Id;
       //irsRec.Master_Approver9__c=u.Id;*/
        qirsRec.Master_Approver10__c=u2.Id;
        qirsRec.Approver_Contacted1__c=true;
        qirsRec.Approver_Contacted2__c=true;
        qirsRec.Approver_Contacted3__c=true;
        qirsRec.Approver_Contacted4__c=true;
        qirsRec.Approver_Contacted5__c=true;
        qirsRec.Approver_Contacted6__c=true;
        qirsRec.Approver_Contacted7__c=true;
        qirsRec.Approver_Contacted8__c=true;
        qirsRec.Approver_Contacted9__c=true;
        qirsRec.Approver_Contacted10__c=true;
        qirsRec.MCAR__c='test mcar';
        qirsRec.Next_CRSD__c=date.today();
        qirsRec.Watchlist__c=true;
        qirsRec.Closed_Date1__c=date.today()+4;
        qirsRec.Operator_Warning_Message__c='warning1';
        qirsRec.Orders_backlog__c='test order backlog';
        qirsRec.Orders_Impact__c='test impact';
        qirsRec.Last_Approved_Program_Milestone__c='P1';
        qirsRec.View_Product_Name__c='test product name';
        qirsRec.Revenue_Backlog__c='test';
        qirsRec.Status__c='Open';
        qirsRec.WatchListComment__c='test commment';
        qirsRec.WatchListType__c='test';
        qirsRec.Revenue_Impact__c='test';
        qirsRec.Serial_Numbers__c='0001';
        qirsRec.Lock_Points_SH_Shipping__c=true;
        qirsRec.Site1__c='Alsdorf';
        qirsRec.Supplier__c='test Supplier';
        qirsRec.Total_Quality_Spills_Cost__c='1000';
        qirsRec.Units_Backlog__c='100';
        qirsRec.Units_Impact__c='100';
        qirsRec.View_AP_Color__c='yellow';
        qirsRec.View_Release_Product__c='test release';
        qirsRec.Yes__c=true; 
        qirsRec.MCAR_Supplier_Claim__c='test claim';
        qirsRec.Pronto__c='test pronto';
        qirsRec.Resolve__c='yes';
        qirsRec.RCA_EDA__c='test';
        qirsRec.Line_Stop__c='test';
        qirsRec.Affected_Unit_at_Customer_Action__c='N/A';
        qirsRec.Affected_Unit_at_Hubs_Action__c='N/A';
        qirsRec.Affected_Unit_at_Factories_Action__c='N/A';
        qirsRec.Affected_Units_at_HWS_Action__c='N/A';
        qirsRec.Affected_Units_at_Suppliers_Action__c='N/A';
        qirsRec.Additional_Email__c='priyaburghate@yahoo.in';
        qirsRec.Affected_Units_at_HWS__c=10;
        qirsRec.Affected_Units_at_Suppliers__c=10;
        insert qirsRec;
        
        List<QIRS_Action_Plan_Approver_List__c> applist = new List<QIRS_Action_Plan_Approver_List__c>();
        
        QIRS_Action_Plan_Approver_List__c aplanlist = new QIRS_Action_Plan_Approver_List__c();
         aplanlist.Email__c='priyaburghate@yahoo.in';
         aplanlist.Business__c=qirsRec.Business__c;
         aplanlist.Phone__c='123445';
         aplanlist.Approver_Contacted__c=true;
         aplanlist.User__c=u2.Id;
            insert aplanlist;
            
           
        
            
         test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(qirsRec);
        ApexPages.CurrentPage().getparameters().put('id', qirsRec.id);
        QIRS_Create_Controller obj1 = new QIRS_Create_Controller(sc);  
        obj1.strMode='EDIT';
        obj1.strsisadmin='test';
       obj1.getMultiApprover();
        obj1.Save();
        obj1.Cancel();
        obj1.AssignContactedApp();
        obj1.getSite();
        obj1.getBusiness();
        obj1.getStatus();
        obj1.getApprover();
        obj1.getTEST();
        obj1.getAlertType();
        obj1.AssignContactedApp();
        test.stopTest();
        
    
    }
    }
    
    static testmethod void tes41(){
       Profile p = [SELECT Id FROM Profile WHERE Name='Nokia QIRS'];
        User u = new User(Alias = 'standt', Email='priyaburghate@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUser11@testorg.com');
       User u2= new User(Alias = 'standt', Email='priyaburghat@yahoo.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId =p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardQirsUsrr11@testorg.com');
        system.runas(u2){
            
        QIRS__c qirsRec = new QIRS__c();
        qirsRec.Case_Name__c='test';
        qirsRec.Access_Stop_Ship_Code__c='test access code';
        qirsRec.Exposed_Base__c='test base';
        qirsRec.Factory_DC__c='test';
        qirsRec.Customer__c='test';
        qirsRec.Customer_Impact__c='High';
        qirsRec.Expected_Number_of_return__c='100';
        qirsRec.NSN_Part_Number__c='121';
        qirsRec.Product_Safety__c=false;
        qirsRec.Supplier_Pn__c='test Supplier Pn';
        qirsRec.Core_ID__c='test';
        qirsRec.Approval_Comments__c='test comments';
        qirsRec.IsDefaultReleased__c=true;
        qirsRec.Process_Owner1__c=u2.Id;
        qirsRec.Business__c='zzGlobal Services';
        qirsRec.Business_Group__c='3G Core';
        qirsRec.Problem_Description1__c='test description';
        qirsRec.Alert_Type__c='Quality Alert';
        qirsRec.Projected_Lift_Date__c=system.today();
        qirsRec.Estimated_close_date__c=system.today()+5;
        qirsRec.Impacted_Region_Customer__c='test';
        qirsRec.Factory__c='OMP, Italy';
        qirsRec.Defective_Part__c='Design';
        qirsRec.Symptom__c='Software';
        qirsRec.Group_to_Notify__c='test group';
        qirsRec.Countries__c='India';
        qirsRec.Impacted_Region__c='All';
        qirsRec.Lifted_Date__c=date.today();
        qirsRec.Issue_Level__c='Medium';
        //rsRec.Master_Approver__c= u.Id;
       //irsRec.Master_Approver1__c=u.Id;
      qirsRec.Master_Approver2__c=u2.Id;
     //qirsRec.Master_Approver3__c=u2.Id;
      //irsRec.Master_Approver4__c=u.Id;
      //qirsRec.Master_Approver5__c=u.Id;
      //qirsRec.Master_Approver6__c=u.Id;
       //irsRec.Master_Approver7__c=u.Id;
       //irsRec.Master_Approver8__c=u.Id;
      //qirsRec.Master_Approver9__c=u2.Id;
       //irsRec.Master_Approver10__c=u.Id;
        qirsRec.Approver_Contacted1__c=true;
        qirsRec.Approver_Contacted2__c=true;
        qirsRec.Approver_Contacted3__c=true;
        qirsRec.Approver_Contacted4__c=true;
        qirsRec.Approver_Contacted5__c=true;
        qirsRec.Approver_Contacted6__c=true;
        qirsRec.Approver_Contacted7__c=true;
        qirsRec.Approver_Contacted8__c=true;
        qirsRec.Approver_Contacted9__c=true;
        qirsRec.Approver_Contacted10__c=true;
        qirsRec.MCAR__c='test mcar';
        qirsRec.Next_CRSD__c=date.today();
        qirsRec.Watchlist__c=true;
        qirsRec.Closed_Date1__c=date.today()+4;
        qirsRec.Operator_Warning_Message__c='warning1';
        qirsRec.Orders_backlog__c='test order backlog';
        qirsRec.Orders_Impact__c='test impact';
        qirsRec.Last_Approved_Program_Milestone__c='P1';
        qirsRec.View_Product_Name__c='test product name';
        qirsRec.Revenue_Backlog__c='test';
        qirsRec.Status__c='Open';
        qirsRec.WatchListComment__c='test commment';
        qirsRec.WatchListType__c='test';
        qirsRec.Revenue_Impact__c='test';
        qirsRec.Serial_Numbers__c='0001';
        qirsRec.Lock_Points_SH_Shipping__c=true;
        qirsRec.Site1__c='Alsdorf';
        qirsRec.Supplier__c='test Supplier';
        qirsRec.Total_Quality_Spills_Cost__c='1000';
        qirsRec.Units_Backlog__c='100';
        qirsRec.Units_Impact__c='100';
        qirsRec.View_AP_Color__c='yellow';
        qirsRec.View_Release_Product__c='test release';
        qirsRec.Yes__c=true; 
        qirsRec.MCAR_Supplier_Claim__c='test claim';
        qirsRec.Pronto__c='test pronto';
        qirsRec.Resolve__c='yes';
        qirsRec.RCA_EDA__c='test';
        qirsRec.Line_Stop__c='test';
        qirsRec.Affected_Unit_at_Customer_Action__c='N/A';
        qirsRec.Affected_Unit_at_Hubs_Action__c='N/A';
        qirsRec.Affected_Unit_at_Factories_Action__c='N/A';
        qirsRec.Affected_Units_at_HWS_Action__c='N/A';
        qirsRec.Affected_Units_at_Suppliers_Action__c='N/A';
        qirsRec.Additional_Email__c='priyaburghate@yahoo.in';
        qirsRec.Affected_Units_at_HWS__c=10;
        qirsRec.Affected_Units_at_Suppliers__c=10;
        insert qirsRec;
        
        List<QIRS_Action_Plan_Approver_List__c> applist = new List<QIRS_Action_Plan_Approver_List__c>();
        
        QIRS_Action_Plan_Approver_List__c aplanlist = new QIRS_Action_Plan_Approver_List__c();
         aplanlist.Email__c='priyaburghate@yahoo.in';
         aplanlist.Business__c=qirsRec.Business__c;
         aplanlist.Phone__c='123445';
         aplanlist.Approver_Contacted__c=true;
         aplanlist.User__c=u2.Id;
            insert aplanlist;
            
           
        
            
         test.startTest();
        ApexPages.StandardController sc = new ApexPages.standardController(qirsRec);
        ApexPages.CurrentPage().getparameters().put('id', qirsRec.id);
        QIRS_Create_Controller obj1 = new QIRS_Create_Controller(sc);  
        obj1.strMode='EDIT';
        obj1.getMultiApprover();
        obj1.Save();
        obj1.Cancel();
        obj1.AssignContactedApp();
        obj1.getSite();
        obj1.getBusiness();
        obj1.getStatus();
        obj1.getApprover();
        obj1.getTEST();
        obj1.getAlertType();
        obj1.AssignContactedApp();
        test.stopTest();
        
    
    }
    }
    

}