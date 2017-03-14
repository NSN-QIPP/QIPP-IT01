public class QIRSanalysisreportsummary
{

   public QIRSanalysisreportsummary() {
            Business = 'ALL';
    }


    public QIRSanalysisreportsummary(ApexPages.StandardController controller) {

    }
 public list<QIRS__c> nsn;
 Public String Business{ get; set;} 
 

 
 public List<SelectOption> getItems() {
            return QIRSBasecontroller.getBusinessList(true);
        }

    public list<QIRS__c> getQuery_Analysis_Report_Summary()
    {        
        List<QIRS__c> Analysis_List = new list<QIRS__c>();
        
        if(Business == 'ALL' )
        {
           Analysis_List=[SELECT Name,Status__c,Business__c,Site1__c,CreatedDate,Problem_Description1__c,Alert_Type__c,Closed_Date1__c,CreatedBy.Name,Lifted_Date__c,View_Product_Name__c FROM QIRS__c Where Status__c != 'Closed' order by Name desc];  
        }    
        else
        {
            Analysis_List=[SELECT Name,Status__c,Business__c,Site1__c,CreatedDate,Problem_Description1__c,Alert_Type__c,Closed_Date1__c,CreatedBy.Name,Lifted_Date__c,View_Product_Name__c FROM QIRS__c Where Business__c =: Business AND Status__c != 'Closed' order by Name desc];  
        }
        return Analysis_List; 
    } 
     static testMethod void testQIRSanalysisreportsummary()
     {
      QIRSanalysisreportsummary controller = new QIRSanalysisreportsummary();
      controller.getItems();
      ApexPages.currentPage().getParameters().put('Business','Business Solutions');
      controller.getQuery_Analysis_Report_Summary();
      ApexPages.currentPage().getParameters().put('Business','ALL');
      controller.getQuery_Analysis_Report_Summary();
     }

}