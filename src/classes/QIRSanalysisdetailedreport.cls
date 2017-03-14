public class QIRSanalysisdetailedreport{

   public QIRSanalysisdetailedreport() {
            Business = 'ALL';
    }


    public QIRSanalysisdetailedreport(ApexPages.StandardController controller) {

    }
 public list<QIRS__c> nsn;
 Public String Business{ get; set;} 
 

 
 public List<SelectOption> getItems() {
            return QIRSBasecontroller.getBusinessList(true);
        }

    public list<QIRS__c> getQuery_Analysis_Report_Detailed()
    {        
        List<QIRS__c> Global_Report = new list<QIRS__c>();
                        
        if(Business == 'ALL' )
        {
           Global_Report=[SELECT Name,Status__c,Business__c,Site1__c,CreatedDate,Problem_Description1__c,Alert_Type__c,Closed_Date1__c,CreatedBy.Name,Lifted_Date__c,View_Product_Name__c FROM QIRS__c Where Status__c != 'Closed'];  
        }
        else
        {
            Global_Report=[SELECT Name,Status__c,Business__c,Site1__c,CreatedDate,Problem_Description1__c,Alert_Type__c,Closed_Date1__c,CreatedBy.Name,Lifted_Date__c,View_Product_Name__c FROM QIRS__c Where Business__c =: Business AND Status__c != 'Closed'];  
        }    
        return Global_Report; 
    } 
    static testMethod void testQIRSanalysisdetailedreport()
     {
         QIRSanalysisdetailedreport controller = new QIRSanalysisdetailedreport();
         controller.getQuery_Analysis_Report_Detailed();
         controller.getItems();
     }
}