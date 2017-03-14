/*Modify by tejas kardile on 13APR2012
changed status from open to not closed and not canceled.
*/
public class QIRSWatchListController 
{

    

   public string todays_date{ get; set;}
    public boolean IsBlank{ get; set;}
    public boolean IsOutputpanal{ get; set;}
 public QIRSWatchListController(){
        todays_date = datetime.now().format('MMMMM, dd yyyy');
        List<QIRS__c> objqirs = new List<QIRS__c>();
        objqirs = [select WatchListType_Color__c,Affected_Units_at_Suppliers_Action__c,Affected_Unit_at_Customer_Action__c,Affected_Unit_at_Hubs_Action__c,Affected_Units_at_HWS_Action__c,Affected_Unit_at_Factories_Action__c,View_Release_Product__c,Units_Backlog__c,Units_Impact__c,Revenue_Backlog__c,Revenue_Impact__c,Orders_backlog__c,Orders_Impact__c,Product_PN__c,Name,Symptom__c,Customer__c,Factory__c,
        WatchListComment__c,WatchListType__c,Projected_Lift_Date__c, View_Product_Name__c,Business__c, Alert_Type__c,CreatedDate,
        Business_Group__c,Defective_Part__c,Owner.Name,Site1__c,Status__c,Process_Owner1__r.Name,CreatedBy.Id,CreatedBy.Name,Problem_Description1__c
        from QIRS__c where Watchlist__c = true 
        and Status__c !=:'Closed' and Status__c !=:'Canceled'
        and Status__c !=:'Submited to Master Approval' order by Name desc]; 
        if(objqirs.size()>0)
        {
          IsOutputpanal = true;
          IsBlank = false;
        }
        else
        {
         IsOutputpanal = false;
           IsBlank = true;
        }
    }

    public List<QIRS__c> getWatchlistRecord() 
    {
        List<QIRS__c> objqirs = new List<QIRS__c>();
        objqirs = [select WatchListType_Color__c,Affected_Units_at_Suppliers_Action__c,Affected_Unit_at_Customer_Action__c,Affected_Unit_at_Factories_Action__c,Affected_Unit_at_Hubs_Action__c,Affected_Units_at_HWS_Action__c,View_Release_Product__c,Units_Backlog__c,Units_Impact__c,Revenue_Backlog__c,Revenue_Impact__c,Orders_backlog__c,Orders_Impact__c,Product_PN__c,Name,Symptom__c,Customer__c,Factory__c,
        WatchListComment__c,WatchListType__c,Projected_Lift_Date__c, View_Product_Name__c,Business__c, Alert_Type__c,CreatedDate,
        Business_Group__c,Defective_Part__c,Owner.Name,Site1__c,Status__c,Process_Owner1__r.Name,CreatedBy.Id,CreatedBy.Name,Problem_Description1__c
        from QIRS__c where Watchlist__c = true and Status__c !=:'Closed' and Status__c !=:'Submited to Master Approval' and Status__c !=:'Canceled' order by Name desc]; 
        return objqirs;
               
    }
     static testMethod void testQIRSWatchListController()
     {
          QIRSWatchListController controller = new QIRSWatchListController();
          controller.getWatchlistRecord(); 
     }
}