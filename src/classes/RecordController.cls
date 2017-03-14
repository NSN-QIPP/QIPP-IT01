public class RecordController{

   public PageReference getPageDetails() 
    {
        List<QIRS__c> lstQirs = new List<QIRS__c>();
        if(Stop_Ship_Code == '' || Stop_Ship_Code == null)
        {
            if(Status == 'All' )
             {
                  lstQirs = [select MCAR__c, View_Product_Name__c , (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where CreatedDate >: newDate];                                     
             }
           else
             {
                    lstQirs = [select MCAR__c, View_Product_Name__c , (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate ,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where Status__c =: Status and CreatedDate >: newDate ];
             }
        }
        else
        {
            lstQirs = [select MCAR__c, View_Product_Name__c ,(Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate ,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c 
            from QIRS__c where Name =: Stop_Ship_Code]; 
        }
        if(lstQirs.size()>0)        
        {
           PageReference pageRef = new PageReference('/' + lstQirs[0].id);
             pageRef.setRedirect(true);
             return pageRef; 
        }
        else
        {
            return null;
        }
    }
    


    

    public RecordController() {

    }





 



    public RecordController(ApexPages.StandardController controller) 
    {

    }

    public String Status {get; set;}
    public String Stop_Ship_Code {get; set;}
    public  date myDate = date.today();
     public date newDate = mydate.addDays(-180);
   Public String Type = System.currentPagereference().getParameters().get('type');
            public List<SelectOption> getItem() 
            {
                return QIRSBasecontroller.getStatusList(true);
            }

                
               
                public List<QIRS__c> getshowQIRS() 
                {
        
                string st = Status ;
               
                List<QIRS__c> lstQirs = new List<QIRS__c>();
               
                   if(st != null )
                   {
                           if(st == 'All' )
                             {
                                    if( Stop_Ship_Code == '' ||  Stop_Ship_Code == null)
                                    {
                                         lstQirs = [select MCAR__c, View_Product_Name__c , (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where CreatedDate >: newDate];                                     
                                    }
                                    else
                                    {
                                         lstQirs = [select MCAR__c, View_Product_Name__c , (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where CreatedDate >: newDate and Name =: Stop_Ship_Code];                                                                         
                                    }
                             }
                           else
                             {
                                if(Stop_Ship_Code == '' ||  Stop_Ship_Code == null)
                                {
                                    lstQirs = [select MCAR__c, View_Product_Name__c , (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate ,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where Status__c =: st and CreatedDate >: newDate];
                                }
                                else
                                {
                                    lstQirs = [select MCAR__c, View_Product_Name__c , (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate ,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where Status__c =: st and CreatedDate >: newDate and Name =: Stop_Ship_Code];                                    
                                }
                             }
                   }
        
               else
                 {
                     st = 'All';
                      if(Stop_Ship_Code == '' ||  Stop_Ship_Code == null)
                      {
                             lstQirs = [select CreatedDate ,MCAR__c, View_Product_Name__c , (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where CreatedDate >: newDate];     
                      }
                      else
                      {
                             lstQirs = [select CreatedDate ,MCAR__c,View_Product_Name__c ,  (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where CreatedDate >: newDate  and Name =: Stop_Ship_Code];                                   
                      }
                 }
       
                  return  QIRSBasecontroller.getProductName(lstQirs);
               }
               
               public List<QIRS__c> getGo()
               {
                 string rn = Stop_Ship_Code ;
                 system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' + Stop_Ship_Code);
                 List<QIRS__c> lstform = new List<QIRS__c>();
                 if(Type == 'myrecd')  
                 {
                     lstForm = [select CreatedDate ,MCAR__c, (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where Name =: rn and CreatedDate >: newDate];                 
                 }
                 else
                 { 
                     lstForm = [select CreatedDate ,MCAR__c, (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where Name =: rn and CreatedDate >: newDate];
                 }
                 Stop_Ship_Code = '';
                 return lstForm ;
               }
                
                public List<QIRS__c> getWatchlistRecord()
               {
                 List<QIRS__c> lstform = new List<QIRS__c>();
                 lstForm = [select CreatedDate ,MCAR__c, (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c
                  from QIRS__c where Watchlist__c = true];
                 return lstForm ;
               }
            

}