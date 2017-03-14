public class QIRSRecordsController {
  public QIRSRecordsController()
     {
            
             
     }
    public QIRSRecordsController(ApexPages.StandardController controller) {

    }
    
    
    
    public String Stop_Ship_Code {get; set;}
    public date myDate = date.today();
    public date newDate = mydate.addDays(-14);
    public String Status {get; set;} 
         
    public List<SelectOption> getItem() 
    {
        return QIRSBasecontroller.getStatusList(true);
    }
    List<User> users = new List<User>();
            
    
    public PageReference getPageDetails() 
    {
        List<QIRS__c> lstQirs = new List<QIRS__c>();
        if(Stop_Ship_Code == '' || Stop_Ship_Code == null)
        {
            if(Status == 'All' )
             {
                  lstQirs = [select Product_PN__c,MCAR__c,View_Product_Name__c,View_Release_Product__c, (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where CreatedBy.ManagerID  =:  UserInfo.getUserId() AND (Status__c != 'Closed' OR Closed_Date1__c >:newDate) order by CreatedDate desc];                                     
             }
           else
             {
                if(Status == 'Closed')
                    lstQirs = [select Product_PN__c,MCAR__c, View_Product_Name__c ,View_Release_Product__c, (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate ,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where Closed_Date1__c >:newDate and CreatedBy.ManagerID  =:  UserInfo.getUserId() order by CreatedDate desc];
                else
                    lstQirs = [select Product_PN__c,MCAR__c, View_Product_Name__c ,View_Release_Product__c, (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate ,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where Status__c =: Status and CreatedBy.ManagerID  =:  UserInfo.getUserId() order by CreatedDate desc];
             }
        }
        else
        {
            lstQirs = [select Product_PN__c,MCAR__c, View_Product_Name__c ,View_Release_Product__c,(Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate ,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c 
            from QIRS__c where CreatedBy.ManagerID  =:  UserInfo.getUserId() and Name =: Stop_Ship_Code AND (Status__c != 'Closed' OR Closed_Date1__c >:newDate)]; 
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
                                         lstQirs = [select Product_PN__c,View_AP_Color__c, MCAR__c, View_Product_Name__c ,View_Release_Product__c, (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where CreatedBy.ManagerID  =:  UserInfo.getUserId() AND (Status__c != 'Closed' OR Closed_Date1__c >:newDate) order by CreatedDate desc];                                     
                                    }
                                    else
                                    {
                                         lstQirs = [select Product_PN__c,View_AP_Color__c, MCAR__c, View_Product_Name__c ,View_Release_Product__c, (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where CreatedBy.ManagerID  =:  UserInfo.getUserId() and Name =: Stop_Ship_Code AND (Status__c != 'Closed' OR Closed_Date1__c >:newDate) order by CreatedDate desc];                                                                         
                                    }
                             }
                           else
                             {
                                if(st == 'Closed')
                                {
                                    if(Stop_Ship_Code == '' ||  Stop_Ship_Code == null)
                                    {
                                        lstQirs = [select Product_PN__c,View_AP_Color__c, MCAR__c, View_Product_Name__c ,View_Release_Product__c, (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate ,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where Closed_Date1__c >:newDate and CreatedBy.ManagerID  =:  UserInfo.getUserId() order by CreatedDate desc];
                                    }
                                    else
                                    {
                                        lstQirs = [select Product_PN__c,View_AP_Color__c, MCAR__c, View_Product_Name__c ,View_Release_Product__c, (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate ,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where Closed_Date1__c >:newDate and CreatedBy.ManagerID  =:  UserInfo.getUserId() and Name =: Stop_Ship_Code order by CreatedDate desc];                                    
                                    }
                                }
                                else
                                {
                                    if(Stop_Ship_Code == '' ||  Stop_Ship_Code == null)
                                    {
                                        lstQirs = [select Product_PN__c,View_AP_Color__c, MCAR__c, View_Product_Name__c ,View_Release_Product__c, (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate ,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where Status__c =: st and CreatedBy.ManagerID  =:  UserInfo.getUserId() order by CreatedDate desc];
                                    }
                                    else
                                    {
                                        lstQirs = [select Product_PN__c,View_AP_Color__c, MCAR__c, View_Product_Name__c ,View_Release_Product__c, (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,CreatedDate ,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where Status__c =: st and CreatedBy.ManagerID  =:  UserInfo.getUserId() and Name =: Stop_Ship_Code order by CreatedDate desc];                                    
                                    }
                                }
                             }
                   }
        
               else
                 {
                     st = 'All';
                      if(Stop_Ship_Code == '' ||  Stop_Ship_Code == null)
                      {
                             lstQirs = [select Product_PN__c,View_AP_Color__c, CreatedDate ,MCAR__c, View_Product_Name__c ,View_Release_Product__c, (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where (Status__c != 'Closed' OR Closed_Date1__c >:newDate) and CreatedBy.ManagerID  =:  UserInfo.getUserId() order by CreatedDate desc];     
                      }
                      else
                      {
                             lstQirs = [select Product_PN__c,View_AP_Color__c,CreatedDate ,MCAR__c,View_Product_Name__c ,  (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r), Closed_Date1__c, Process_to_Stop__c, Estimated_close_date__c, CreatedBy.Name, Problem_Description1__c, Lock_Points_SH_Shipping__c,Name, Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,Process_Owner1__c from QIRS__c where CreatedBy.ManagerID  =:  UserInfo.getUserId() and Name =: Stop_Ship_Code AND (Status__c != 'Closed' OR Closed_Date1__c >:newDate) order by CreatedDate desc];                                   
                      }
                 }
                  lstQirs= QIRSBasecontroller.getAPColorCode(lstQirs);
                  return  lstQirs;// QIRSBasecontroller.getProductName(lstQirs);
               }
}