public class NQT_Cancel_CPR_Request {

    public NQT_Cancel_CPR_Request(ApexPages.StandardController controller) {
        cpr = new CPR__c();
    }
    
    
    public CPR__c cpr { get; set; }
    
    
    public PageReference on_load() {
        List<String> check_CPR = ApexPages.currentPage().getURL().split('id=', 0);
        List<String> get_id = check_CPR[1].split('&', 0);
        Id CPRid = get_id[0];
        if(cpr.Reason_cancel__c == NULL){
            cpr.Reason_cancel__c.addError('Please enter a Reason.');
            return NULL;
            }
            
        CPR__c CPR1 = [SELECT NQT_Class_Access_After__c, NQT_Class_Access_Before__c, NQT_Project_Status__c, NQT_Deliverable_Status__c FROM CPR__c WHERE id =: CPRid];
        CPR1.NQT_Class_Access_After__c = TRUE;
        CPR1.NQT_Class_Access_Before__c = TRUE;
        CPR1.NQT_Project_Status__c = 'Cancelled';
        CPR1.NQT_Deliverable_Status__c = 'Cancelled';
        CPR1.Reason_cancel__c = cpr.Reason_cancel__c;
        CPR1.Comment_cancel__c = cpr.Comment_cancel__c;   
        CPR1.RecordTypeId = [SELECT Id FROM RecordType WHERE developerName = 'CPR_Closed_Cancelled' LIMIT 1].Id;
        
        Update CPR1;
        //The below line commented by Kishore on 12-Apr-2012
        //PageReference pgref = new PageReference('https://c.cs50.visual.force.com/'+CPRid);
        PageReference pgref = new PageReference('https://c.cs50.visual.force.com/'+CPRid);

        return pgref;
        }
    
    
    static testMethod void testNQT_Cancel_CPR_Request(){
        CPR__c cpr1 = new CPR__c();//[SELECT id, NQT_Project_Status__c FROM CPR__c WHERE NQT_Project_Status__c !=: 'Quote Closed' LIMIT 1];
        ApexPages.StandardController controller = new ApexPages.StandardController(cpr1);
        NQT_Cancel_CPR_Request canreq = new NQT_Cancel_CPR_Request(controller);
        PageReference pageRef = Page.NQT_Cancel_CPR;
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
        CPR.NQT_Switch_CLLI_Code__c = 'AGSTGABMCM2';*/
        /*CPR.NQT_SE__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_FE__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_SE_MSC__c = DummyUser.id;//'005Z0000000Hnsp';//[SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_Project_Manager__c = [SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;*/
        
        insert CPR;//}catch(exception e){}
    
        ApexPages.currentPage().getParameters().put('id',CPR.Id);
        ApexPages.currentPage().getParameters().put('scontrolCaching', '1');
        canreq.cpr.Reason_cancel__c ='aa';
        canreq.on_load();
    }  

}