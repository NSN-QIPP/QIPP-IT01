public class QIRSqualitywatchlist
{
Public String Business{ get; set;} 
 public boolean IsBlank{ get; set;}
    public QIRSqualitywatchlist(ApexPages.StandardController controller) 
    {
        Business ='ALL';
    } 

 
 
 
 public List<SelectOption> getItems() {
          
             return QIRSBasecontroller.getBusinessList(true);
        }

    public list<QIRS__c> getQuery_Quality_List()
    {        
        List<QIRS__c> Quality_List = new list<QIRS__c>();        
               
        if(Business == 'ALL' )
        {
               Quality_List=[SELECT Process_Owner1__r.Name,View_Release_Product__c,StatusColor__c,Units_Backlog__c,Units_Impact__c,Revenue_Backlog__c,Revenue_Impact__c,Orders_backlog__c,Orders_Impact__c,Alert_Type__c, Product_PN__c,Name,Status__c,Business__c,Business_Group__c,View_Product_Name__c,Customer__c,Defective_Part__c,Symptom__c,Factory__c,CreatedDate,Projected_Lift_Date__c,CreatedBy.Name,CreatedBy.ID,WatchListComment__c,WatchListType__c,Problem_Description1__c FROM QIRS__c Where Watchlist__c = true AND Status__c !=:'Closed' and Status__c !=:'Canceled' and Status__c !=:'Submited to Master Approval'  order by Name desc]; 
        }
        else
        {
               Quality_List=[SELECT Process_Owner1__r.Name,View_Release_Product__c,StatusColor__c,Units_Backlog__c,Units_Impact__c,Revenue_Backlog__c,Revenue_Impact__c,Orders_backlog__c,Orders_Impact__c,Alert_Type__c, Product_PN__c,Name,Status__c,Business__c,Business_Group__c,View_Product_Name__c,Customer__c,Defective_Part__c,Symptom__c,Factory__c,CreatedDate,Projected_Lift_Date__c,CreatedBy.Name,CreatedBy.ID,WatchListComment__c,WatchListType__c,Problem_Description1__c FROM QIRS__c where Business__c =: Business  AND Watchlist__c = true AND Status__c !=:'Closed' and Status__c !=:'Canceled' and Status__c !=:'Submited to Master Approval'  order by Name desc]; 
        }   
        if(Quality_List.size()>0)
        {
          IsBlank = false;
        }
        else
        {
           IsBlank = true;
        }
        return Quality_List; 
    } 
    

}