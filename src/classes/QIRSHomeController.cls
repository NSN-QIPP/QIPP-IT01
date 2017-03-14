public class QIRSHomeController {


   
            
   public QIRSHomeController()
     {
         integer Count =0;
         Count= [select Count() from QIRS_Action_Plan__c where 
          ( Champion1__c =: UserInfo.getUserId() or Champion2__c =: UserInfo.getUserId() or
                    Champion3__c =: UserInfo.getUserId() or Champion4__c =: UserInfo.getUserId() or
                    Champion5__c =: UserInfo.getUserId() or Champion6__c =: UserInfo.getUserId() or
                    Champion7__c =: UserInfo.getUserId() or Champion8__c =: UserInfo.getUserId() or
                    Champion9__c =: UserInfo.getUserId() or Champion10__c =: UserInfo.getUserId() )
          and Status__c = : 'Rejected'];
         TaskReview = String.ValueOf(Count);
         
          Count= [select Count() from QIRS_Action_Plan__c where 
                    ( Champion1__c =: UserInfo.getUserId() or Champion2__c =: UserInfo.getUserId() or
                    Champion3__c =: UserInfo.getUserId() or Champion4__c =: UserInfo.getUserId() or
                    Champion5__c =: UserInfo.getUserId() or Champion6__c =: UserInfo.getUserId() or
                    Champion7__c =: UserInfo.getUserId() or Champion8__c =: UserInfo.getUserId() or
                    Champion9__c =: UserInfo.getUserId() or Champion10__c =: UserInfo.getUserId() )
                    and Status__c =: QIRSBasecontroller.BaseVarPendingforChampion];
          Pendingtask = String.ValueOf(Count); 
          
          Count = [select Count() from QIRS_Action_Plan__c where 
                    ( Approver1__c =: UserInfo.getUserId() or Approver2__c =: UserInfo.getUserId() or
                    Approver3__c =: UserInfo.getUserId() or Approver4__c =: UserInfo.getUserId() or
                    Approver5__c =: UserInfo.getUserId() or Approver6__c =: UserInfo.getUserId() or
                    Approver7__c =: UserInfo.getUserId() or Approver8__c =: UserInfo.getUserId() or
                    Approver9__c =: UserInfo.getUserId() or Approver10__c =: UserInfo.getUserId() 
                    ) 
                    and Status__c =: QIRSBasecontroller.BaseVarImplementedbyChampion];         
             TaskAnalysis = String.ValueOf(Count);
             
              Count = [select  Count() from QIRS__c where 
              Process_Owner1__c =: UserInfo.getUserId() and RejectedFlag__c = true
              and Status__c =: QIRSBasecontroller.BaseVarQIRSLifted];
             MasterRejection =String.ValueOf(Count);
             
              Count = [select  Count() from QIRS__c where 
             ( Master_Approver1__c =: UserInfo.getUserId() or Master_Approver2__c =: UserInfo.getUserId() or
                    Master_Approver3__c =: UserInfo.getUserId() or Master_Approver4__c =: UserInfo.getUserId() or
                    Master_Approver5__c =: UserInfo.getUserId() or Master_Approver6__c =: UserInfo.getUserId() or
                    Master_Approver7__c =: UserInfo.getUserId() or Master_Approver8__c =: UserInfo.getUserId() or
                    Master_Approver9__c =: UserInfo.getUserId() or Master_Approver10__c =: UserInfo.getUserId() )
             and Status__c =: QIRSBasecontroller.BaseVarQIRSSubmitForApproval];
              MasterAnalysis = String.ValueOf(Count);
              
              string[] SelectedStatus =  new String[]{'Open','Pending for Champion','Implemented by Champion','Rejected'};
               Count = [select Count() from QIRS_Action_Plan__c where CreatedById =: UserInfo.getUserId() and Status__c In : SelectedStatus];
               SubmittedTasks = String.ValueOf(Count);
               Business = 'All';
               BusinessGroup='All';
               Sites = 'All';
               Alerttype = 'All';
               Status = 'All';
               ProcessOwner = 'All';
                     
     }
   

//    public  { get; set; }
    public String Business { get; set; }
    public String BusinessGroup {get; set;}
    public String Sites {get; set;}
    public String Alerttype {get; set;} 
    public String Status {get; set;} 
    public String ProcessOwner {get; set;}
    public String RecordCode { get; set; } 
    public String TaskReview { get; set; } 
    public String Pendingtask { get; set; } 
    public String TaskAnalysis { get; set; } 
    public String MasterAnalysis { get; set; }             
    public String SubmittedTasks{ get; set; }  
    public String MasterRejection{ get; set; } 
         
    public List<QIRS__c> lstQirs = new List<QIRS__c>();

               
    public List<SelectOption> getBusinessDD() 
    {
        return QIRSBasecontroller.getBusinessList(true);
    }
    public List<SelectOption> getBusinessGrpDD()
    {
        return QIRSBasecontroller.getBusinessGrpList();
    }
  
    public List<SelectOption> getSitesDD() 
    {
        return QIRSBasecontroller.getSitesList(true);
    }
    public List<SelectOption> getAlertTypesDD() 
    {
        return QIRSBasecontroller.getAlertTypesList(true);
    }

    public List<SelectOption> getStatusDD() 
    {
        return QIRSBasecontroller.getStatusList(true);
    }
            
    public List<SelectOption> getProcessOwnersDD()
    {
        return QIRSBasecontroller.getProcessOwnersList();        
    } 

       public List<QIRS__c> getshowQIRS() 
       {
            string bs = Business ;
            string bgrp = BusinessGroup ;
            string si = Sites ;
            string al = Alerttype;
            string st = Status ;
            string po = ProcessOwner ;
            string rc = RecordCode  ;
            String Closed = 'Closed';
            String Cancelled = 'Canceled';
            //String Closed = 'All';
            date myDate = date.today();
            date newDate = mydate.addDays(-14);
            // date newDate = mydate.addDays(0);
            //  String Closed = 'Closed';                                   
           String Query ='select Name,Case_Name__c,View_AP_Color__c,Product_PN__c,(select Release_Product__c,Name From Product_Identification__r), (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r),Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,StatusColor__c,Process_Owner1__c ,Issue_Level__c, Defective_Part__c, Symptom__c, CreatedDate, IssueLevelColor__c,View_Product_Name__c, Watchlist__c, MCAR__c, Closed_Date1__c from QIRS__c where ((Status__c =:Closed and Closed_Date1__c >=:newDate) Or (Status__c !=:Closed and Status__c !=:Cancelled))'; 
           //String Query ='select Name,View_AP_Color__c,Product_PN__c,(select Release_Product__c,Name From Product_Identification__r), (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r),Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,StatusColor__c,Process_Owner1__c ,Issue_Level__c, Defective_Part__c, Symptom__c, CreatedDate, IssueLevelColor__c,View_Product_Name__c, Watchlist__c, MCAR__c, Closed_Date1__c from QIRS__c where Status__c !=:Closed';            
        if(st != 'All')
          {
               Query =Query +' AND Status__c =: st';
          }
          if(al != 'All')
           Query = Query + ' AND Alert_Type__c =: al';  
          if(bgrp != 'All')           
            Query = Query + ' AND Business_Group__c INCLUDES(:bgrp)';    
             if(bs != 'All')
            Query = Query + ' AND Business__c =: bs';   
            
            if(si != 'All')
            Query = Query + ' AND Site1__c  INCLUDES(:si)'; 
            if(po != 'All')
            Query = Query + ' AND Process_Owner1__c =:po';             
           Query = Query +' Order by CreatedDate desc,Name desc';                           
            lstQirs  = Database.query(Query); 

         /*  String Query1 ='select Name,View_AP_Color__c,Product_PN__c,(select Release_Product__c,Name From Product_Identification__r), (Select id,Name,Status__c,StatusColor__c,Action_Type__c From QIRS_Action_Plan__r),Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,StatusColor__c,Process_Owner1__c ,Issue_Level__c, Defective_Part__c, Symptom__c, CreatedDate, IssueLevelColor__c,View_Product_Name__c, Watchlist__c, MCAR__c, Closed_Date1__c from QIRS__c where Status__c !=: Closed'; 
        if(st != 'All')
          {
               Query1 =Query1 +' AND Status__c =: st';
          }
          if(al != 'All')
           Query1 = Query1 + ' AND Alert_Type__c =: al';  
          if(bgrp != 'All')           
            Query1 = Query1 + ' AND Business_Group__c =: bgrp';   
             if(bs != 'All')
            Query1 = Query1 + ' AND Business__c =: bs';   
            
            if(si != 'All')
            Query1 = Query1 + ' AND Site1__c  INCLUDES(:si)'; 
            if(po != 'All')
            Query1 = Query1 + ' AND Process_Owner1__c =:po';             
           Query1= Query1 +' Order by CreatedDate desc,Name desc';                           
            
           List<QIRS__c> lstQirs1  = Database.query(Query1); 
          for (Integer j=0;j<lstQirs1.size();j++)
          {
              lstQirs.add(lstQirs1[j]);
          }
           superSort.sortList(lstQirs,'Name','desc');*/
           
           
           
           lstQirs= QIRSBasecontroller.getAPColorCode(lstQirs);
                return  lstQirs;                      
     } 
     static testMethod void QIRSHomeController()
     {
      QIRSHomeController controller = new QIRSHomeController();
       controller.getBusinessDD();
        controller.getBusinessGrpDD();
        controller.getSitesDD();   
        controller.getAlertTypesDD();     
        controller.getStatusDD();             
        controller.getProcessOwnersDD();    

        controller.getshowQIRS();                   
                                 
     }     
        
}