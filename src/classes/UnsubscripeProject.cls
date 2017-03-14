public class UnsubscripeProject {
public String ObjectId {get;set;}
public List <QIPP_Project__c> projectlist{get;set;}
    public UnsubscripeProject () {
        ObjectId = ApexPages.currentPage().getParameters().get('ObjectId');
    }
    public PageReference unsubscripePage() {
        projectlist = [SELECT Id, project_number__c, Unsubscribe_Project_Record__c from QIPP_Project__c WHERE Id =: ObjectId Limit 1];
        if(!projectlist.IsEmpty()) {
            projectlist[0].Unsubscribe_Project_Record__c = True;
            UPDATE projectlist;
        }
        return null;
    }
}