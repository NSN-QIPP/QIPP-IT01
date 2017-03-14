public class NQTDocDetail {

    public NQTDocDetail(ApexPages.StandardController controller) {
        try{cprid = ApexPages.currentPage().getParameters().get('cprid'); 
        doc = ApexPages.currentPage().getParameters().get('doc');  
        attachment1 = [SELECT Name, Id, BodyLength FROM Attachment WHERE ParentId =: cprid AND Name =: doc LIMIT 1];}catch(exception e){}
    }
    
    
    public Attachment attachment1{ get; set; }
    public id cprid{ get; set; }
    public string doc{ get; set; }
    
    static testMethod void NQTDocDetailTest(){
        CPR__c c = new CPR__c();
        ApexPages.StandardController con = new ApexPages.StandardController(c);
        NQTDocDetail ch = new NQTDocDetail(con);
        PageReference pageRef = Page.NQT_Doc_Detail;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', 'a0UZ0000000Eydy');
        ch = new NQTDocDetail(con);
    }
}