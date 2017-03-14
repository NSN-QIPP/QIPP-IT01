public class NQTCustomerHold{

    public NQTCustomerHold(ApexPages.StandardController controller) {
        cpr = new CPR__c();
    }
    
    public CPR__c cpr { get; set; }
    
    public pagereference confirm(){
        if(cpr.Reason_for_Customer_Hold__c == NULL){
            cpr.Reason_for_Customer_Hold__c.addError('Please enter a value');
            return NULL;
            }
        List<String> check_CPR = ApexPages.currentPage().getURL().split('id=', 0);
        List<String> get_id = check_CPR[1].split('&', 0);
        Id CPRid = get_id[0];
        CPR__c CPR1 = [SELECT OwnerId, RecordTypeId, NQT_Class_Access_After__c, NQT_Class_Access_Before__c, NQT_Project_Status__c, NQT_Deliverable_Status__c, NQT_Program_Manager__c, NQT_Account_Manager__c, NQT_FE__c, NQT_SE__c, NQT_SE_MSC__c FROM CPR__c WHERE id =: CPRid];
        CPR1.NQT_Class_Access_After__c = TRUE;
        CPR1.NQT_Class_Access_Before__c = TRUE;
        CPR1.Project_Status_Backup__c = CPR1.NQT_Project_Status__c;
        CPR1.Deliverable_Status_Backup__c = CPR1.NQT_Deliverable_Status__c;
        CPR1.NQT_Project_Status__c = 'Customer Hold';
        CPR1.NQT_Deliverable_Status__c = 'Customer Hold';
        CPR1.Reason_for_Customer_Hold__c = cpr.Reason_for_Customer_Hold__c;   
        CPR1.RecordTypeId = [SELECT Id FROM RecordType WHERE developerName = 'CPR_Customer_Hold' LIMIT 1].Id;     
        //CPR1.Customer_Hold__c = TRUE;
        Update CPR1;
        
        User Customer = [SELECT ProfileId, Email FROM User WHERE Id =: CPR1.OwnerId LIMIT 1];
        String Profile = [SELECT Name FROM Profile WHERE Id =: Customer.ProfileId LIMIT 1].Name;
        
        EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'NQT_Customer_Hold_VF'];
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        list<String> EmailAddr = new list<String>();
        //[SELECT Email FROM User WHERE Id =: CPR1.NQT_Project_Manager__c LIMIT 1]
        //if(CPR1.NQT_Program_Manager__r.Email != null)
           EmailAddr.add([SELECT Email FROM User WHERE Id =: CPR1.NQT_Program_Manager__c LIMIT 1].Email); 
        //if(CPR1.NQT_Account_Manager__r.Email != null)
           EmailAddr.add([SELECT Email FROM User WHERE Id =: CPR1.NQT_Account_Manager__c LIMIT 1].Email);
        if(CPR1.NQT_FE__c != null)
            EmailAddr.add([SELECT Email FROM User WHERE Id =: CPR1.NQT_FE__c LIMIT 1].Email);
        if(CPR1.NQT_SE__c != null)
            EmailAddr.add([SELECT Email FROM User WHERE Id =: CPR1.NQT_SE__c LIMIT 1].Email);
        if(CPR1.NQT_SE_MSC__c != null)
            EmailAddr.add([SELECT Email FROM User WHERE Id =: CPR1.NQT_SE_MSC__c LIMIT 1].Email);
        if(Profile.contains('Customer'))
            EmailAddr.add(Customer.Email);
        
        email.setToAddresses(EmailAddr);    
        email.setTargetObjectId(CPR1.NQT_Program_Manager__c);
        email.setWhatId(CPR1.id);     
        email.setSaveAsActivity(false);            
        email.setTemplateId(et.id);            
        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
        
        PageReference pgref = new PageReference('/'+CPRid);
        return pgref;
        }
    static testMethod void NQTCustomerHold (){
        CPR__c c = new CPR__c();
        ApexPages.StandardController con = new ApexPages.StandardController(c);
        NQTCustomerHold ch = new NQTCustomerHold(con);
        PageReference pageRef = Page.NQT_Customer_Hold;
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
        
        ApexPages.currentPage().getParameters().put('id', CPR.Id);
        ch.cpr.Reason_for_Customer_Hold__c = 'aa';
        ch.confirm();
        
    }        
}