@isTest
public with sharing class NQT_Trigger_Test {

    static testmethod void CPR_Validation(){
        
        CPR__c CPR1 = new CPR__c();
        /*CPR.NQT_Project_Status__c = 'Quote Submitted';
        try{insert CPR;}catch(exception e){}
        
        CPR.NQT_Project_Status__c = 'Quote Closed';
        try{insert CPR;}catch(exception e){}
        
        CPR.NQT_Project_Status__c = 'Cancelled';
        try{insert CPR;}catch(exception e){}
        
        CPR.NQT_Project_Status__c = 'Quote Generation';
        CPR.NQT_Deliverable_Status__c = 'Sales Deliverable';
        try{insert CPR;}catch(exception e){}
        
        CPR.NQT_Project_Status__c = 'Engineering Assigned';
        CPR.NQT_Deliverable_Status__c = 'Engineering Deliverable';
        try{insert CPR;}catch(exception e){}
        
        CPR.NQT_Project_Status__c = 'Request In-Review';
        CPR.NQT_Deliverable_Status__c = 'Determine Deadline';
        try{insert CPR;}catch(exception e){}
        
        CPR.NQT_Project_Status__c = 'Request In-Review';
        CPR.NQT_Deliverable_Status__c = 'In Review';
        try{insert CPR;}catch(exception e){}
        
        CPR.NQT_Project_Status__c = 'Request Submitted';
        CPR.NQT_Deliverable_Status__c = 'Assign';*/
        try{insert CPR1;}catch(exception e){}
        
        CPR1.NQT_Area__c = 'West';
        try{insert CPR1;}catch(exception e){}
        CPR1.NQT_Area__c = 'Mid West';
        try{insert CPR1;}catch(exception e){}
        CPR1.NQT_Area__c = 'South';
        try{insert CPR1;}catch(exception e){}
        CPR1.NQT_Area__c = 'Nationwide';
        try{insert CPR1;}catch(exception e){}
        CPR1.NQT_Area__c = 'North East';
        CPR1.NQT_If_Other_MTSO__c = 'a';
        try{insert CPR1;}catch(exception e){}
        
        CPR1.NQT_Customer_Requested_Ship_Date__c = date.Today()-1;
        CPR1.NQT_Target_Service_Start_Date__c = date.Today()-1;
        CPR1.NQT_Target_Service_Finish_Date__c = date.Today()-1;
        CPR1.NQT_Database_Work_Description__c = 'asd';
        try{insert CPR1;}catch(exception e){}
        
        /*Profile DummyProfile = new Profile();
        DummyProfile.Name = 'test';
        insert DummyProfile;*/
        CPR__c CPR = new CPR__c();
        
        User DummyUser = new User();
        DummyUser.LastName = 'adc';
        DummyUser.FirstName = 'adc';
        DummyUser.Alias = 'adc';
        DummyUser.Email = 'a@a.a';
        DummyUser.Username = 'a@a.a.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
        
        //CPR.NQT_If_Other_MTSO__c = NULL;
        //CPR.NQT_Database_Work_Description__c = NULL;
        CPR.NQT_Customer_Requested_Ship_Date__c = dateTime.now()+1;
        CPR.NQT_Target_Service_Start_Date__c = date.today()+1;
        CPR.NQT_Target_Service_Finish_Date__c = date.today()+1;
        CPR.NQT_Customer__c = 'VERIZON';
        CPR.NQT_CPR_Name__c = 'a';
        CPR.NQT_Customer_contact_Name__c = 'a';
        CPR.NQT_Customer_Contact_Phone__c = '3333';
        CPR.NQT_Customer_Email_Address__c = 'test@test.com';
        CPR.NQT_CPR_Start_Date__c = date.today();
        CPR.NQT_Account_manager__c = DummyUser.id;//'005Z0000000HsI1';
        CPR.NQT_Area__c = 'Mid West';
        CPR.NQT_Market__c = 'St. Clairesville';
        CPR.NQT_MTSO__c = 'St. Clairesville';
        CPR.NQT_Program_Manager__c = DummyUser.id;//'005Z0000000HsI2';
        CPR.NQT_Requested_Quote_Delivery_Date__c = dateTime.now()+1;
        CPR.NQT_Type_Of_Request__c = 'Services Only';
        CPR.NQT_MTX_Ericsson__c = TRUE;
        CPR.NQT_if_other__c = 'a';
        /*CPR.NQT_Product__c = 'BTS';
        CPR.NQT_SE__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_FE__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_SE_MSC__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_Project_Manager__c = [SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;*/
        
        insert CPR;//}catch(exception e){}
        
        CPR.NQT_SE__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_FE__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_SE_MSC__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        //CPR.NQT_Project_Manager__c = [SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_CPR_Review_Completed__c = TRUE; 
        CPR.NQT_Review_Deadline__c = date.today();
        
        //insert CPR;//}catch(exception e){}
        update CPR;//}catch(exception e){}
        
                       
        CPR.NQT_SE__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_FE__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_SE_MSC__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        //CPR.NQT_Project_Manager__c = [SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_Review_Deadline__c = date.today()+1;
        
        CPR.NQT_Is_the_CPR_Complete_and_Accurate__c = 'YES';
        CPR.NQT_SE_Deadline__c = date.today();
        CPR.NQT_SE_MSC_Deadline__c = date.today();
        CPR.NQT_FE_Deadline__c = date.today();
        CPR.NQT_Sales_Deadline__c = date.today();
        CPR.NQT_Team_Assignment_Complet__c  = TRUE;
        CPR.NQT_FE_agree_to_the_completeness_of_CPR__c = 'YES';
        CPR.NQT_FE_Review_Comments__c = 'Test';
        CPR.NQT_SEM_agree_to_the_completeness_of_CPR__c = 'YES';
        CPR.NQT_SE_MSC_Review_Comments__c = 'Test';
        CPR.NQT_SE_agree_to_the_completeness_of_CPR__c = 'YES';
        CPR.NQT_SE_Review_Comments__c = 'Test';
        
        CPR.NQT_CPR_Review_Completed__c = TRUE;
        
        System.RunAs(DummyUser){update CPR;}//}catch(exception e){}  
              
        CPR.NQT_CPR_Review_Completed__c = FALSE;
        CPR.NQT_Team_Assignment_Completed__c = TRUE;
        CPR.NQT_Agree_with_Customer_Requested_Quote__c = 'YES';
        CPR.NQT_Has_the_CPR_been_Reviewed__c = 'YES';
        
        
        update CPR;//}catch(exception e){}
        
        CPR.NQT_CPR_Review_Completed__c = TRUE;
        CPR.NQT_Team_Assignment_Completed__c = TRUE;
        CPR.NQT_FE_Rework_Backup__c = 'test';
        CPR.NQT_SE_Rework_Backup__c = 'test';
        CPR.NQT_SE_MSC_Rework_Backup__c = 'test';
        CPR.NQT_Sales_Deliverable_Start__c = TRUE;
        CPR.NQT_Project_Deliverable_Complete__c = TRUE;
        CPR.NQT_I_Agree__c = TRUE;
        CPR.NQT_FE_Services__c = 3;
        CPR.NQT_SE_Services__c = 3;
        CPR.NQT_Equipment__c = 3;
        CPR.NQT_Project_Deliverable_Complete__c = FALSE;
        CPR.NQT_Project_Milestone_End__c = TRUE;
        CPR.NQT_FE_Assigned__c = TRUE;
        CPR.NQT_FE_Deliverables_submit__c = TRUE;
        CPR.NQT_SE_Assigned__c = TRUE;
        CPR.NQT_SE_Deliverables_Submitted__c = TRUE;
        CPR.NQT_SE_MSC_Assigned__c = TRUE;
        CPR.NQT_SE_MSC_Deliverables_Submitted__c = TRUE;
        
        update CPR;//}catch(exception e){}
        
        CPR.NQT_Is_the_CPR_Complete_and_Accurate__c = 'NO';
        CPR.NQT_SE_FE_SEMSC_Deliverable_Check__c = 0;
        
        try{update CPR;}catch(exception e){}
        
        CPR.NQT_Is_the_CPR_Complete_and_Accurate__c = 'YES';
        
        CPR.NQT_Project_Status__c = 'Quote Submitted';
        update CPR;//}catch(exception e){}
        
        CPR.NQT_Project_Status__c = 'Quote Closed';
        update CPR;//}catch(exception e){}
        
        CPR.NQT_Project_Status__c = 'Cancelled';
        update CPR;//}catch(exception e){}
        
        CPR.NQT_Project_Status__c = 'Quote Generation';
        CPR.NQT_Deliverable_Status__c = 'Sales Deliverable';
        update CPR;//}catch(exception e){}
        
        CPR.NQT_Project_Status__c = 'Engineering Assigned';
        CPR.NQT_Deliverable_Status__c = 'Engineering Deliverable';
        update CPR;//}catch(exception e){}
        
        CPR.NQT_Project_Status__c = 'Request In-Review';
        CPR.NQT_Deliverable_Status__c = 'Determine Deadline';
        update CPR;//}catch(exception e){}
        
        CPR.NQT_Project_Status__c = 'Request In-Review';
        CPR.NQT_Deliverable_Status__c = 'In Review';
        update CPR;//}catch(exception e){}
        
        CPR.NQT_Project_Status__c = 'Request Submitted';
        CPR.NQT_Deliverable_Status__c = 'Assign';
        update CPR;//}catch(exception e){}
        
        CPR.NQT_Project_Status__c = 'Customer Hold';
        //user am = [SELECT Id FROM User WHERE Id = '005Z0000000HsI1'];
        CPR.Customer_Hold__c = TRUE;
        CPR.Workflow_Run__c = FALSE;
        CPR.NQT_Sales_Deadline__c = Date.Today()+1;
        CPR.NQT_FE_Deadline__c = Date.Today()+1;
        CPR.NQT_SE_Deadline__c = Date.Today()+1;
        CPR.NQT_SE_MSC_Deadline__c = Date.Today()+1;
        System.RunAs(DummyUser){update CPR;}
        
        User DummyUser1 = new User();
        DummyUser1.LastName = 'adc';
        DummyUser1.FirstName = 'adc';
        DummyUser1.Alias = 'adc';
        DummyUser1.Email = 'a@a.a';
        DummyUser1.Username = 'a@a.a.adcf';
        DummyUser1.CommunityNickname = 'af';
        DummyUser1.IsActive = TRUE;
        DummyUser1.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser1.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser1.LocaleSidKey = 'en_US';
        DummyUser1.EmailEncodingKey = 'ISO-8859-1';
        DummyUser1.LanguageLocaleKey = 'en_US';
        insert DummyUser1;
        
        CPR.NQT_Project_Status__c = DummyUser1.Id;//'Request Submitted';
        CPR.NQT_Account_manager__c = DummyUser1.Id;//'005Z0000000HsI2';
        //update CPR;
        CPR.NQT_Program_Manager__c = DummyUser1.Id;//'005Z0000000Hnsp';
        //update CPR;
        CPR.NQT_SE__c = DummyUser1.Id;//'005Z0000000HsI1';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        //update CPR;
        CPR.NQT_FE__c = DummyUser1.Id;//'005Z0000000HsI1';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        //update CPR;
        CPR.NQT_SE_MSC__c = DummyUser1.Id;//'005Z0000000HsI1';
        update CPR;
        
        CPR.NQT_Class_Access_Before__c = TRUE;
        update CPR;//}catch(exception e){}
                
        CPR.NQT_Class_Access_After__c = TRUE;
        update CPR;//}catch(exception e){}
        
        //CPR.
        
        }
        
        
    static testMethod void testProduct_Name(){
        NQT_Product__c product = new NQT_Product__c();
        product.Product_Name__c = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
        product.Legacy_Group__c = 'ANE';
        insert product;
        product = new NQT_Product__c();
        product.Product_Name__c = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
        product.Legacy_Group__c = 'FNE';
        insert product;
        product = new NQT_Product__c();
        product.Product_Name__c = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
        product.Legacy_Group__c = 'SPARES';
        insert product;
        } 
        
    static testMethod void testAssign_Backup_Validation(){
                
        User DummyUser1 = new User();
        DummyUser1.LastName = 'adc';
        DummyUser1.FirstName = 'adc';
        DummyUser1.Alias = 'adc';
        DummyUser1.Email = 'a@a.a';
        DummyUser1.Username = 'a@a.a.adcf';
        DummyUser1.CommunityNickname = 'af';
        DummyUser1.IsActive = TRUE;
        DummyUser1.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser1.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser1.LocaleSidKey = 'en_US';
        DummyUser1.EmailEncodingKey = 'ISO-8859-1';
        DummyUser1.LanguageLocaleKey = 'en_US';
        insert DummyUser1;
        
        NQT_Assign_Backup_Person__c abp = new NQT_Assign_Backup_Person__c();
        abp.NQT_From__c = date.today();
        abp.NQT_To__c = date.today();
        abp.NQT_Availability_Status__c = 'Out of office';
        //user am = [SELECT Id FROM User WHERE Id = '005Z0000000HsI0'];
        //System.runAs(DummyUser1){insert abp;}
        insert abp;
        //abp = new NQT_Assign_Backup_Person();
        abp.NQT_Availability_Status__c = 'Available';
        abp.NQT_Related_CPR__c = 'CPR-005241;';
        update abp;
        }
        
    static testMethod void testDocument_PO_Check(){
        NQT_Document__c doc = new NQT_Document__c();
        doc.NQT_Document_Type__c = 'PO';
        doc.Name = 'a';
        
        CPR__c CPR = new CPR__c();
        
        User DummyUser = new User();
        DummyUser.LastName = 'adc';
        DummyUser.FirstName = 'adc';
        DummyUser.Alias = 'adc';
        DummyUser.Email = 'a@a.a';
        DummyUser.Username = 'a@a.a.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
        
        //CPR.NQT_If_Other_MTSO__c = NULL;
        //CPR.NQT_Database_Work_Description__c = NULL;
        CPR.NQT_Customer_Requested_Ship_Date__c = date.Today()+1;
        CPR.NQT_Target_Service_Start_Date__c = date.Today()+1;
        CPR.NQT_Target_Service_Finish_Date__c = date.Today()+1;
        CPR.NQT_Customer__c = 'VERIZON';
        CPR.NQT_CPR_Name__c = 'a';
        CPR.NQT_Customer_contact_Name__c = 'a';
        CPR.NQT_Customer_Contact_Phone__c = '3333';
        CPR.NQT_Customer_Email_Address__c = 'test@test.com';
        CPR.NQT_CPR_Start_Date__c = date.today();
        CPR.NQT_Account_manager__c = DummyUser.id;//'005Z0000000HsI1';
        CPR.NQT_Area__c = 'Mid West';
        CPR.NQT_Market__c = 'St. Clairesville';
        CPR.NQT_MTSO__c = 'St. Clairesville';
        CPR.NQT_Program_Manager__c = DummyUser.id;//'005Z0000000HsI2';
        CPR.NQT_Requested_Quote_Delivery_Date__c = dateTime.now()+1;
        CPR.NQT_Type_Of_Request__c = 'Services Only';
        CPR.NQT_MTX_Ericsson__c = TRUE;
        CPR.NQT_if_other__c = 'a';
        /*CPR.NQT_Product__c = 'BTS';
        CPR.NQT_SE__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_FE__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_SE_MSC__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_Project_Manager__c = [SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;*/
        
        insert CPR;
        
        doc.NQT_CPR__c = CPR.Id;
        insert doc;
        }
        
    static testMethod void testkit_part_validation(){
        NQT_Eq_Detail__c kp = new NQT_Eq_Detail__c();
        
        CPR__c CPR = new CPR__c();
        
        User DummyUser = new User();
        DummyUser.LastName = 'adc';
        DummyUser.FirstName = 'adc';
        DummyUser.Alias = 'adc';
        DummyUser.Email = 'a@a.a';
        DummyUser.Username = 'a@a.a.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
        
        //CPR.NQT_If_Other_MTSO__c = NULL;
        //CPR.NQT_Database_Work_Description__c = NULL;
        CPR.NQT_Customer_Requested_Ship_Date__c = date.Today()+1;
        CPR.NQT_Target_Service_Start_Date__c = date.Today()+1;
        CPR.NQT_Target_Service_Finish_Date__c = date.Today()+1;
        CPR.NQT_Customer__c = 'VERIZON';
        CPR.NQT_CPR_Name__c = 'a';
        CPR.NQT_Customer_contact_Name__c = 'a';
        CPR.NQT_Customer_Contact_Phone__c = '3333';
        CPR.NQT_Customer_Email_Address__c = 'test@test.com';
        CPR.NQT_CPR_Start_Date__c = date.today();
        CPR.NQT_Account_manager__c = DummyUser.id;//'005Z0000000HsI1';
        CPR.NQT_Area__c = 'Mid West';
        CPR.NQT_Market__c = 'St. Clairesville';
        CPR.NQT_MTSO__c = 'St. Clairesville';
        CPR.NQT_Program_Manager__c = DummyUser.id;//'005Z0000000HsI2';
        CPR.NQT_Requested_Quote_Delivery_Date__c = dateTime.now()+1;
        CPR.NQT_Type_Of_Request__c = 'Services Only';
        CPR.NQT_MTX_Ericsson__c = TRUE;
        CPR.NQT_if_other__c = 'a';
        /*CPR.NQT_Product__c = 'BTS';
        CPR.NQT_SE__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_FE__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_SE_MSC__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_Project_Manager__c = [SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;*/
        
        insert CPR;
        
        NQT_Equipment_List__c el = new NQT_Equipment_List__c();
        el.Name = 'a';
        el.NQT_CPR__c = CPR.Id;
        insert el;
        kp.NQT_Equipment_List__c = el.Id;
        NQT_Product__c p = new NQT_Product__c();
        p.Product_Name__c = 'p';
        insert p;
        
        kp.NQT_Part_Number__c = p.Id;
        try{insert kp;}catch(exception e){}
        kp = new NQT_Eq_Detail__c();
        kp.NQT_Equipment_List__c = el.Id;
        kp.NQT_Part_Number__c = p.Id;
        try{insert kp;}catch(exception e){}
        }
    }