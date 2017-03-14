public with sharing class QuoteGeneration {

    public QuoteGeneration(ApexPages.StandardController controller) {
        PanelTest = TRUE;
        PanelTest1 = False;
        ContentTypeTest = '';
        FieldTest = TRUE;
        String temp = ApexPages.CurrentPage().getURL().Split('id=',0)[1];
        CPR_Id = temp.Split('&', 0)[0];
        CPR_Name = [SELECT Name FROM CPR__c WHERE Id =: CPR_Id].Name;
        SelectAll = new CPR__c();
        EqDetail = new list<NQT_Eq_Detail__c>();
        //SOWs = new List<NQT_SOW_Pricing__c>();
    }
    
    //public List<NQT_SOW_Pricing__c> SOWs { get; set; }
    public List<NQT_Equipment_List__c> EL { get; set; }
    public Boolean PanelTest { get; set; }
    public Boolean PanelTest1 { get; set; }
    public String ContentTypeTest { get; set; }
    public Boolean FieldTest { get; set; }
    public Blob ImageTest { get; set; }
    //public NQT_SOW_Pricing__c CPR { get; set; }
    public List<NQT_Quote_Notes__c> Inst { get; set;}
    public Id CPR_Id { get; set; }
    public String CPR_Name { get; set; }
    public CPR__c SelectAll { get; set; }
    public String ProjectId { get; set; }
    public String CPRName { get; set; }
    public String ContactName { get; set; }
    public String Market { get; set; }
    public String CLLI { get; set; }
    public String AMName { get; set; }
    public String AMEmail { get; set; }
    public String MTSO { get; set; }
    public list<NQT_Eq_Detail__c> EqDetail { get; set; }
    
     public List<NQT_Quote_Notes__c> getnotes() {
        Inst = [SELECT NQTSelect__c, NQT_Notes__c FROM NQT_Quote_Notes__c LIMIT 14];
        Return inst;
        }
    
    /*public List<NQT_SOW_Pricing__c> getSOWResult() {
       /* SOWs = [SELECT Name, NQT_Select__c, NQT_Description__c, NQT_Engineering_Notes__c, NQT_Extended_Price__c, NQT_Part_Number__c, NQT_Quantity__c, NQT_Unit_Price__c, NQT_CPR__r.Name, NQT_CPR__r.NQT_CPR_Name__c,NQT_CPR__r.NQT_Customer_contact_Name__c,NQT_CPR__r.NQT_Market__c,NQT_CPR__r.NQT_MTSO__c,NQT_CPR__r.NQT_Switch_CLLI_Code__c,NQT_CPR__r.NQT_Account_Manager__r.Name, NQT_CPR__r.NQT_Account_Manager__r.Email  FROM NQT_SOW_Pricing__c WHERE NQT_CPR__r.id =: CPR_Id];
        if(SOWs.isEmpty())
            return NULL;
        return SOWs;
        return NULL;
    }*/
    
    public List<NQT_Eq_Detail__c> getEquipmentResult() {
        list<NQT_Eq_Detail__c> EqDetailTemp = new list<NQT_Eq_Detail__c>();

        EL = [SELECT Name, NQT_Select__c, NQT_Description__c, Engineering_Notes__c, NQT_Extended_Price__c, NQT_In_Group__c, NQT_In_Kit__c, NQT_Kit_Part_Number_lookup__c, Quantity__c, NQT_Unit_Price__c, NQT_CPR__r.Name, NQT_CPR__r.NQT_CPR_Name__c,NQT_CPR__r.NQT_Customer_contact_Name__c,NQT_CPR__r.NQT_Market__c,NQT_CPR__r.NQT_MTSO__c,NQT_CPR__r.NQT_Switch_CLLI_Code__c,NQT_CPR__r.NQT_Account_Manager__r.Name, NQT_CPR__r.NQT_Account_Manager__r.Email  FROM NQT_Equipment_List__c WHERE NQT_CPR__r.id =: CPR_Id];
        if(EL.isEmpty())
            return NULL;        
        
        ProjectId = EL[0].NQT_CPR__r.Name;
        CPRName = EL[0].NQT_CPR__r.NQT_CPR_Name__c;
        ContactName = EL[0].NQT_CPR__r.NQT_Customer_contact_Name__c;
        Market = EL[0].NQT_CPR__r.NQT_Market__c;
        CLLI = EL[0].NQT_CPR__r.NQT_Switch_CLLI_Code__c;
        AMName = EL[0].NQT_CPR__r.NQT_Account_Manager__r.Name; 
        AMEmail = EL[0].NQT_CPR__r.NQT_Account_Manager__r.Email;
        MTSO = EL[0].NQT_CPR__r.NQT_MTSO__c;
        for(NQT_Equipment_List__c ELs : EL){
            EqDetailTemp = [SELECT NQT_Description__c, NQT_Engineering_Notes__c, NQT_Equipment_List__c, NQT_Extended_Price__c, In_Group__c, In_Kit__c, NQT_Part_Number__c, Kit_Part_Number__c, NQT_Quantity__c, NQT_Select__c, Unit_Price__c FROM NQT_Eq_Detail__c WHERE NQT_Equipment_List__c =: ELs.Id];
            if(!EqDetailTemp.isEmpty())
                EqDetail.addAll(EqDetailTemp);
            }
        return EqDetail;
        }
    
    /*public List<NQT_SOW_Pricing__c> getSOWResult1() {
       /* List<NQT_SOW_Pricing__c> SOWs1 = new List<NQT_SOW_Pricing__c>();
        for(NQT_SOW_Pricing__c SOW : SOWs)
        if(SOW.NQT_Select__c == TRUE)
            SOWs1.add(SOW);
        return SOWs1;
        return NULL;
    }*/
    
    public List<NQT_Eq_Detail__c> getEquipmentResult1() {
        List<NQT_Eq_Detail__c> ELD = new List<NQT_Eq_Detail__c>();
        for(NQT_Eq_Detail__c ELDTemp : EqDetail)
        if(ELDTemp.NQT_Select__c == TRUE)
            ELD.add(ELDTemp);
        return ELD;
    }
    
    public List<String> getnotes1() {
        List<String> Notes = new List<String>(); 
        for(NQT_Quote_Notes__c Check : Inst)
            if(Check.NQTSelect__c == TRUE)
                Notes.add(Check.NQT_Notes__c);
            else
                if(SelectAll.NQT_Class_Access_After__c == TRUE)
                    Notes.add(Check.NQT_Notes__c);
        return Notes;
        }
    
    
    public void save_it() {
        PanelTest = FALSE;
        PanelTest1 = TRUE;
        FieldTest = FALSE;
        ContentTypeTest = 'application/vnd.ms-excel#Quote-'+CPR_Name+'-'+date.today()+'.xls';
        
    }
    
    public PageReference Redirect(){
        PageReference Pageref = new PageReference('https://c.cs11.visual.force.com/'+CPR_Id);
        Return Pageref;
        }
    
    public Pagereference Select_All() {
        getNotes();
        if(!Inst.isEmpty())
            for(NQT_Quote_Notes__c Notes : Inst)
                Notes.NQTSelect__c = TRUE;
        Return Null;
        }
        
        
    static testMethod void testQuoteGeneration(){
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
        
        NQT_Equipment_List__c eq = new NQT_Equipment_List__c();
        eq.Name = 'a';
        eq.NQT_CPR__c = cpr.id;
        insert eq;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(cpr);
        PageReference pagref = page.NQT_Quote_Generation;
        Test.setCurrentPage(pagref);
        ApexPages.currentPage().getParameters().put('id', cpr.id);
        QuoteGeneration q = new QuoteGeneration(controller);
        
        q.CPR_Id = cpr.id; 
        q.getnotes();
        //q.getSOWResult();
        q.getEquipmentResult();
        //q.getSOWResult1();
        q.getEquipmentResult1();
        q.getnotes1();
        q.Redirect();
        q.Select_All();
        q.save_it();
        
        }
}