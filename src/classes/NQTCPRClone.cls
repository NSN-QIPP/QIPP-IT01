public class NQTCPRClone {

    public NQTCPRClone(ApexPages.StandardController controller) {
        cpr = new CPR__c();
        String temp = ApexPages.CurrentPage().getURL().Split('id=',0)[1];
        id CPR_Id = temp.Split('&', 0)[0];
        cpr = [SELECT id, NQT_CPR_Name__c, NQT_Type_Of_Request__c, NQT_Customer_contact_Name__c, NQT_CPR_Start_Date__c, NQT_Customer_Contact_Phone__c, NQT_Project_Status__c, NQT_Customer_Email_Address__c, NQT_Deliverable_Status__c, NQT_Area__c, NQT_Market__c, NQT_MTSO__c, NQT_Account_manager__c, NQT_If_Other_MTSO__c, NQT_Program_Manager__c, NQT_Product__c, NQT_Switch_CLLI_Code__c, NQT_MTX_Ericsson__c, NQT_if_other__c, NQT_If_Other_Product__c, NQT_Is_NSN_Required_to_Provide_cablling__c, NQT_Database_Work_Needed__c, NQT_Cabling_Location__c, NQT_Database_Work_Description__c, NQT_Cable_Type_and_Length_in_Meter_s__c, NQT_Reparenting_Work_Needed__c, NQT_Installation_and_Additional_Details__c, NQT_Reparenting_Work_Description__c, NQT_Requested_Quote_Delivery_Date__c, NQT_Target_Service_Start_Date__c, NQT_Customer_Requested_Ship_Date__c, NQT_Target_Service_Finish_Date__c FROM CPR__c WHERE Id =: CPR_Id];
    }
    
    public pagereference save1(){
        CPR__c cpr1 = new CPR__c();
        
        cpr1.NQT_CPR_Name__c  = cpr.NQT_CPR_Name__c;
        cpr1.NQT_Type_Of_Request__c = cpr.NQT_Type_Of_Request__c;
        cpr1.NQT_Customer_contact_Name__c = cpr.NQT_Customer_contact_Name__c;
        cpr1.NQT_CPR_Start_Date__c = cpr.NQT_CPR_Start_Date__c;
        cpr1.NQT_Customer_Contact_Phone__c = cpr.NQT_Customer_Contact_Phone__c;
        cpr1.NQT_Customer_Email_Address__c = cpr.NQT_Customer_Email_Address__c;
        cpr1.NQT_Area__c = cpr.NQT_Area__c;
        cpr1.NQT_Market__c = cpr.NQT_Market__c;
        cpr1.NQT_MTSO__c = cpr.NQT_MTSO__c;
        cpr1.NQT_Account_manager__c = cpr.NQT_Account_manager__c;
        cpr1.NQT_If_Other_MTSO__c = cpr.NQT_If_Other_MTSO__c;
        cpr1.NQT_Program_Manager__c = cpr.NQT_Program_Manager__c;
        cpr1.NQT_Product__c = cpr.NQT_Product__c;
        cpr1.NQT_Switch_CLLI_Code__c = cpr.NQT_Switch_CLLI_Code__c;
        cpr1.NQT_MTX_Ericsson__c = cpr.NQT_MTX_Ericsson__c;
        cpr1.NQT_if_other__c = cpr.NQT_if_other__c;
        cpr1.NQT_If_Other_Product__c =  cpr.NQT_If_Other_Product__c;
        cpr1.NQT_Is_NSN_Required_to_Provide_cablling__c = cpr.NQT_Is_NSN_Required_to_Provide_cablling__c;
        cpr1.NQT_Database_Work_Needed__c = cpr.NQT_Database_Work_Needed__c;
        cpr1.NQT_Cabling_Location__c = cpr.NQT_Cabling_Location__c;
        cpr1.NQT_Database_Work_Description__c = cpr.NQT_Database_Work_Description__c;
        cpr1.NQT_Cable_Type_and_Length_in_Meter_s__c = cpr.NQT_Cable_Type_and_Length_in_Meter_s__c;
        cpr1.NQT_Reparenting_Work_Needed__c = cpr.NQT_Reparenting_Work_Needed__c;
        cpr1.NQT_Installation_and_Additional_Details__c = cpr.NQT_Installation_and_Additional_Details__c;
        cpr1.NQT_Reparenting_Work_Description__c = cpr.NQT_Reparenting_Work_Description__c;
        cpr1.NQT_Requested_Quote_Delivery_Date__c = cpr.NQT_Requested_Quote_Delivery_Date__c;
        cpr1.NQT_Target_Service_Start_Date__c = cpr.NQT_Target_Service_Start_Date__c;
        cpr1.NQT_Customer_Requested_Ship_Date__c = cpr.NQT_Customer_Requested_Ship_Date__c;
        cpr1.NQT_Target_Service_Finish_Date__c = cpr.NQT_Target_Service_Finish_Date__c;
        
        try{insert cpr1;}catch(exception e){cpr.addError(e); return null;}
        pagereference pagref =  new pagereference('/'+cpr1.id);
        return pagref;
        }
    
    public CPR__c cpr { get; set; } 




static testMethod void testDocument(){
    CPR__c ds1 = new CPR__c();
    ApexPages.StandardController con = new ApexPages.StandardController(ds1);
    PageReference pageRef = Page.NQT_CPR_Clone;
    Test.setCurrentPage(pageRef);
    
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
    
    //Id cprid = [SELECT Id FROM CPR__c LIMIT 1].id;
    ApexPages.currentPage().getParameters().put('id', CPR.Id);
    NQTCPRClone c = new NQTCPRClone(con);
    
    try{c.save1();}catch(exception e){}
    }
        
}