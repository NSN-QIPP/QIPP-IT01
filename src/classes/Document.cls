public with sharing class Document {

    public Document(ApexPages.StandardController controller) {
        ds1 = new NQT_Document__c();
        ds2 = new NQT_Document__c();
        ds3 = new NQT_Document__c();
        ds4 = new NQT_Document__c();
        id ProfileIdAM = [SELECT Id FROM Profile WHERE Name = 'Nokia - NQT Account Manager' LIMIT 1].id;
        id ProfileIdNQTAdmin = [SELECT Id FROM Profile WHERE Name = 'Nokia NQT Admin' LIMIT 1].id;
        id ProfileIdSysAdmin = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].id;
        if(ProfileIdAM == UserInfo.getProfileId() || ProfileIdNQTAdmin == UserInfo.getProfileId() || ProfileIdSysAdmin == UserInfo.getProfileId())
            profile = TRUE;
        else
            profile = FALSE;
        id DocId = ApexPages.currentPage().getParameters().get('id');
        //if(DocId != NULL)
            //try{ds1 = [SELECT NQT_File_Description__c, NQT_Document_Type__c FROM NQT_Document__c WHERE id =: DocId];}catch(exception e){}
        }

    public NQT_Document__c ds1 { get; set; }
    public NQT_Document__c ds2 { get; set; }
    public NQT_Document__c ds3 { get; set; }
    public NQT_Document__c ds4 { get; set; }

    public Blob File { get; set; }
    public Blob File1 { get; set; }
    public Blob File2 { get; set; }
    public Blob File3 { get; set; }
    public String fileName { get; set; }
    public String fileName1 { get; set; }
    public String fileName2 { get; set; }
    public String fileName3 { get; set; }
    public Boolean profile { get; set; }
    
    
    public PageReference Cancel1(){
        List<String> check_CPRid = ApexPages.CurrentPage().getURL().split('id=', 0);
        List<String> get_id= check_CPRid[1].split('&', 0);
        Id CPRid = get_id[0];
        PageReference pgref = new PageReference('/'+CPRid);
        return pgref;
        }
        
    public PageReference on_load(){
        List<String> check_CPRid = ApexPages.CurrentPage().getURL().split('id=', 0);
        List<String> get_id= check_CPRid[1].split('&', 0);
        Id CPRid = get_id[0];
        CPR__c CPR = new CPR__c();
        try{
            CPR = [SELECT Document_PO__c, Document_PO_Date__c, Document_Quote__c, Document_Quote_Date__c FROM CPR__c WHERE Id =: CPRid];
            }catch(exception e){}
        
        if((File == NULL && ds1.NQT_Document_Type__c != NULL) || (File1 == NULL && ds2.NQT_Document_Type__c != NULL) || (File2 == NULL && ds3.NQT_Document_Type__c != NULL) || (File3 == NULL && ds4.NQT_Document_Type__c != NULL)){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error : Please Choose File');
            ApexPages.addMessage(myMsg);
            return NULL;
            }
        if(File == NULL && File1 == NULL && File2 == NULL && File3 == NULL){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error : Please Choose File');
            ApexPages.addMessage(myMsg);
            return NULL;
            }
        if((File != NULL && ds1.NQT_Document_Type__c == NULL) || (File1 != NULL && ds2.NQT_Document_Type__c == NULL) || (File2 != NULL && ds3.NQT_Document_Type__c == NULL) || (File3 != NULL && ds4.NQT_Document_Type__c == NULL)){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error : Please select Document Type');
            ApexPages.addMessage(myMsg);
            return NULL;
            }
            
        if(ds1.NQT_Document_Type__c != NULL)
        if(ds1.NQT_Document_Type__c.contains('PO')){
            CPR.Document_PO__c = fileName;
            CPR.Document_PO_Date__c = date.today();
            CPR.NQT_Deliverable_Status__c = 'PO Received';
            }
        if(ds2.NQT_Document_Type__c != NULL)
        if(ds2.NQT_Document_Type__c.contains('PO')){
            CPR.Document_PO__c = fileName;
            CPR.Document_PO_Date__c = date.today();
            CPR.NQT_Deliverable_Status__c = 'PO Received';
            }
        if(ds3.NQT_Document_Type__c != NULL)
        if(ds3.NQT_Document_Type__c.contains('PO')){
            CPR.Document_PO__c = fileName;
            CPR.Document_PO_Date__c = date.today();
            CPR.NQT_Deliverable_Status__c = 'PO Received';
            }
        if(ds4.NQT_Document_Type__c != NULL)
        if(ds4.NQT_Document_Type__c.contains('PO')){
            CPR.Document_PO__c = fileName;
            CPR.Document_PO_Date__c = date.today();
            CPR.NQT_Deliverable_Status__c = 'PO Received';
            }
        
        if(ds1.NQT_Document_Type__c != NULL)    
        if(ds1.NQT_Document_Type__c.contains('Quote')){
            CPR.Document_Quote__c = fileName;
            CPR.Document_Quote_Date__c = date.today();
            }
        if(ds2.NQT_Document_Type__c != NULL)
        if(ds2.NQT_Document_Type__c.contains('Quote')){
            CPR.Document_Quote__c = fileName;
            CPR.Document_Quote_Date__c = date.today();
            }
        if(ds3.NQT_Document_Type__c != NULL)
        if(ds3.NQT_Document_Type__c.contains('Quote')){
            CPR.Document_Quote__c = fileName;
            CPR.Document_Quote_Date__c = date.today();
            }
        if(ds4.NQT_Document_Type__c != NULL)
        if(ds4.NQT_Document_Type__c.contains('Quote')){
            CPR.Document_Quote__c = fileName;
            CPR.Document_Quote_Date__c = date.today();
            }
            
        //CPR.NQT_Class_Access_After__c = TRUE;
        CPR.NQT_Class_Access_Before__c = TRUE;
        try{Update CPR;}catch(exception e){}
        Attachment ex = new Attachment();
        Boolean errcheck = FALSE;
        if(File != NULL){
            ex.Body = File;
            ex.name = string.valueOf(fileName);
            ex.parentId = CPRid;
            try{insert ex;}catch(exception e){ds1.adderror('no privilege to attachment');errcheck = TRUE;}
            }
        if(File1 != NULL){
            ex = new Attachment();
            ex.Body = File1;
            ex.name = string.valueOf(fileName1);
            ex.parentId = CPRid;
            try{insert ex;}catch(exception e){ds1.adderror('no privilege to attachment');errcheck = TRUE;}
            }
        if(File2 != NULL){
            ex = new Attachment();
            ex.Body = File2;
            ex.name = string.valueOf(fileName2);
            ex.parentId = CPRid;
            try{insert ex;}catch(exception e){ds1.adderror('no privilege to attachment');errcheck = TRUE;}
            }
        if(File3 != NULL){
            ex = new Attachment();
            ex.Body = File3;
            ex.name = string.valueOf(fileName3);
            ex.parentId = CPRid;
            try{insert ex;}catch(exception e){ds1.adderror('no privilege to attachment');errcheck = TRUE;}
            }
        if(filename != NULL){
            ds1.Name = fileName;
            ds1.NQT_CPR__c = CPRid;
            try{insert ds1;}catch(exception e){ds1.adderror('no privilege to document:'+e);errcheck = TRUE;}
        }
        if(filename1 != NULL){
            ds2.Name = fileName1;
            ds2.NQT_CPR__c = CPRid;
            try{insert ds2;}catch(exception e){ds1.adderror('no privilege to document');errcheck = TRUE;}
            }
        if(filename2 != NULL){
            ds3.Name = fileName2;
            ds3.NQT_CPR__c = CPRid;
            try{insert ds3;}catch(exception e){ds1.adderror('no privilege to document');errcheck = TRUE;}
            }
        if(filename3 != NULL){
            ds4.Name = fileName3;
            ds4.NQT_CPR__c = CPRid;
            try{insert ds4;}catch(exception e){ds1.adderror('no privilege to document');errcheck = TRUE;}
            }
        if(errcheck == TRUE)
            return NULL;
        PageReference pgref = new PageReference('/'+CPRid);
        return pgref;
        }


    static testMethod void testDocument(){
        NQT_Document__c ds1 = new NQT_Document__c();
        ApexPages.StandardController con = new ApexPages.StandardController(ds1);
        PageReference pageRef = Page.NQT_Document;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', '005Z0000000Hnsp');
        Document d = new Document(con);
        Document d1 = new Document(con);
        try{d.on_load();}catch(exception e){}
        d.ds1 = new NQT_Document__c();
        Blob aa = [SELECT Body FROM Attachment LIMIT 1].Body;
        Blob bb;
        d.File = aa;
        d.ds1.NQT_Document_Type__c = NULL;
        //d.on_load();//}catch(exception e){}
        d.fileName = 'test';
        d.on_load();//}catch(exception e){}
        
        d.File1 = aa;
        d.File = bb;
        d.fileName1 = 'test';
        d.on_load();//}catch(exception e){}
        
        d.File2 = aa;
        d.File1 = bb;
        d.fileName2 = 'test';
        d.on_load();//}catch(exception e){}
        
        d.File3 = aa;
        d.fileName3 = 'test';
        d.File2 = bb;
        d.on_load();//}catch(exception e){}
        
        d.File = aa;
        try{d.on_load();}catch(exception e){}
        
        d.File1 = aa;
        try{d.on_load();}catch(exception e){}
        
        d.File2 = aa;
        d.ds1.NQT_Document_Type__c = 'PO';
        try{d.on_load();}catch(exception e){}
        d.ds1.NQT_Document_Type__c = 'Quote';
        d.ds2.NQT_Document_Type__c = 'Quote';
        d.ds3.NQT_Document_Type__c = 'Quote';
        d.ds4.NQT_Document_Type__c = 'Quote';
        d.on_load();//}catch(exception e){}
        d.Cancel1();
        }
    }