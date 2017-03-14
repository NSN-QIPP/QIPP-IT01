public class Sales_Deliverable {

    public Sales_Deliverable(ApexPages.StandardController controller) {
        ds1 = new NQT_Sales_Deliverable__c();
        ds2 = new NQT_Sales_Deliverable__c();
        ds3 = new NQT_Sales_Deliverable__c();
        ds4 = new NQT_Sales_Deliverable__c();   
    }
    
    public NQT_Sales_Deliverable__c ds1 { get; set; }
    public NQT_Sales_Deliverable__c ds2 { get; set; }
    public NQT_Sales_Deliverable__c ds3 { get; set; }
    public NQT_Sales_Deliverable__c ds4 { get; set; }

    public Blob File { get; set; }
    public Blob File1 { get; set; }
    public Blob File2 { get; set; }
    public Blob File3 { get; set; }
    public String fileName { get; set; }
    public String fileName1 { get; set; }
    public String fileName2 { get; set; }
    public String fileName3 { get; set; }
    
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
        
        if((File == NULL && ds1.Sales_Deliverable_Type__c != NULL) || (File1 == NULL && ds2.Sales_Deliverable_Type__c != NULL) || (File2 == NULL && ds3.Sales_Deliverable_Type__c != NULL) || (File3 == NULL && ds4.Sales_Deliverable_Type__c != NULL)){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error : Please Choose File');
            ApexPages.addMessage(myMsg);
            return NULL;
            }
        if(File == NULL && File1 == NULL && File2 == NULL && File3 == NULL){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error : Please Choose File');
            ApexPages.addMessage(myMsg);
            return NULL;
            }
        if((File != NULL && ds1.Sales_Deliverable_Type__c == NULL) || (File1 != NULL && ds2.Sales_Deliverable_Type__c == NULL) || (File2 != NULL && ds3.Sales_Deliverable_Type__c == NULL) || (File3 != NULL && ds4.Sales_Deliverable_Type__c == NULL)){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error : Please select Document Type');
            ApexPages.addMessage(myMsg);
            return NULL;
            }
            
        Attachment ex = new Attachment();
        if(File != NULL){
            ex.Body = File;
            ex.name = string.valueOf(fileName);
            ex.parentId = CPRid;
            try{insert ex;}catch(exception e){ds1.adderror('no privilege to attachment');return null;}
            }
        if(File1 != NULL){
            ex = new Attachment();
            ex.Body = File1;
            ex.name = string.valueOf(fileName1);
            ex.parentId = CPRid;
            try{insert ex;}catch(exception e){ds1.adderror('no privilege to attachment');return null;}
            }
        if(File2 != NULL){
            ex = new Attachment();
            ex.Body = File2;
            ex.name = string.valueOf(fileName2);
            ex.parentId = CPRid;
            try{insert ex;}catch(exception e){ds1.adderror('no privilege to attachment');return null;}
            }
        if(File3 != NULL){
            ex = new Attachment();
            ex.Body = File3;
            ex.name = string.valueOf(fileName3);
            ex.parentId = CPRid;
            try{insert ex;}catch(exception e){ds1.adderror('no privilege to attachment');return null;}
            }
        if(filename != NULL){
            ds1.Name = fileName;
            ds1.NQT_CPR__c = CPRid;
            try{insert ds1;}catch(exception e){ds1.adderror('no privilege to document');return null;}
            }
        if(filename1 != NULL){
            ds2.Name = fileName1;
            ds2.NQT_CPR__c = CPRid;
            try{insert ds2;}catch(exception e){ds1.adderror('no privilege to document');return null;}
            }
        if(filename2 != NULL){
            ds3.Name = fileName2;
            ds3.NQT_CPR__c = CPRid;
            try{insert ds3;}catch(exception e){ds1.adderror('no privilege to document');return null;}
            }
        if(filename3 != NULL){
            ds4.Name = fileName3;
            ds4.NQT_CPR__c = CPRid;
            try{insert ds4;}catch(exception e){ds1.adderror('no privilege to document');return null;}
            }
        PageReference pgref = new PageReference('/'+CPRid);
        return pgref;
        }
/*

    static testMethod void testSales_Deliverable(){
        NQT_Sales_Deliverable__c ds1 = new NQT_Sales_Deliverable__c();
        ApexPages.StandardController con = new ApexPages.StandardController(ds1);
        PageReference pageRef = Page.NQT_Sales_Deliverables;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', '005Z0000000Hnsp');
        Sales_Deliverable sd = new Sales_Deliverable(con);
        sd.File = 'aa';
        sd.fileName = 'test';
        try{sd.on_load();}catch(exception e){}
        }*/
}