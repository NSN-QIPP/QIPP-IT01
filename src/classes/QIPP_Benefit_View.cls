public with sharing  class QIPP_Benefit_View 
{
 public List<QIPP_Benefit__c> benifit_Financial{get;set;}
 public List<QIPP_Benefit__c> benifit_Operational{get;set;}
  public List<QIPP_Benefit__c> benifit{get;set;}
 public QIPP_Benefit__c projectFieldValue {get;set;}
 public String projectid {get;set;}
 public QIPP_Project__c projectinfo {get;set;}   
 String BenefitId = null;
 String ReferURL =  null;
 String currentpageURL = NULL;
 Boolean firequery = false ;
 public Boolean checkButtonVisibility {get;set;}
 public string UserRolename {get;set;}
 
public Decimal PlannedFinancialTotal {get;set;} 
public Decimal AchievedFinancialTotal {get;set;}  
public Decimal FutureFinancialTotal {get;set;} 
public Decimal PlannedOperationalTotal {get;set;} 
public Decimal AchievedOperationalTotal {get;set;} 
public Decimal FutureOperationalTotal {get;set;} 
public Decimal ACHIEVEDFUTUREFINANCIALTOTAL {get;set;} 
public Decimal ACHIEVEDFUTUREOPERATIONALTOTAL {get;set;} 
public String FinancialErrorMessage {get;set;}
public String OperationalErrorMessage {get;set;}
 
    //Subhash:start
    private ApexPages.StandardController controller {get; set;}
    public List<Account> searchResults {get;set;}
    public boolean display{get;set;}
    public string searchText {get;set;}
    public  list<QIPP_Benefit_Conversion_Table__c> con_table;
    public list<String> AlphaList {get; set;}
    public String AlphaFilter {get; set;}
    public Id improvementmeasure {get; set;}
    public List<QIPP_Benefit__c> benifit_im{get;set;}
    public QIPP_Benefit__c benefit{get;set;}  
      
    //Subhash:end
 
    public QIPP_Benefit_View(ApexPages.StandardController controller) 
    {
        
    try
    {
    benefit = new QIPP_Benefit__c();
    //Id userroleid=userinfo.getUserRoleId();
    // UserRolename =[select id,name from userrole where id = :userinfo.getUserRoleId()].Name;
    
    currentpageURL  = ApexPages.currentPage().getUrl() ;
    System.debug('*************current page URL ***************** ' + currentpageURL );
       
    ReferURL = ApexPages.currentPage().getHeaders().get('referer');
    System.debug('*************Referer URL ***************** ' + ReferURL); 
    
   if(currentpageURL == '/apex/QIPP_Benefit_View' && ReferURL != null)
    {
        projectid = ReferURL.substringBeforeLast('&');  
        projectid = projectid.substringAfterLast('=');
    } 
   else if(currentpageURL != null && !currentpageURL.contains('delete') && !currentpageURL.contains('fm') && !currentpageURL.contains('test'))
    {
         projectid = currentpageURL.substringBeforeLast('=');   
         projectid = projectid.substringAfterLast('?');   
    }
    
   else if(currentpageURL != null && currentpageURL.contains('refer') && ReferURL != null  && !currentpageURL.contains('test'))
    {
        projectId = ReferURL.substringAfterLast('=');
    }
    
    else if(currentpageURL.contains('fm')  && !currentpageURL.contains('test') )
    {
        projectId = currentpageURL.substringAfterLast('=');
    }
    else if(currentpageURL != null && currentpageURL.contains('test') )    
    {       
         if(currentpageURL.contains('%3D'))
         {
             String [] Sarray = currentpageURL.split('%3D');
             String[] SArray1 =  NULL;
             for(Integer i = 0; i <  Sarray.size() ; i++)
             {
             }
             projectid = Sarray[Sarray.size()-1];
         }    
         else
         {
             projectid = currentpageURL.substringAfterLast('=');        
         }    
    }

    else if(ReferURL.contains('delete') || currentpageURL.contains('delete'))
    {
        if(currentpageURL.contains('delete'))
        {
            BenefitId  = currentpageURL.substringBeforeLast('&');
            BenefitId  = BenefitId .substringAfterLast('=');
            projectid = currentpageURL.substringAfterLast('=');
        }
        else if(ReferURL.contains('delete'))
        {
            BenefitId  = ReferURL.substringBeforeLast('&');
            BenefitId  = BenefitId .substringAfterLast('=');
            projectid = ReferURL.substringAfterLast('=');            
        }
    }
    
        if(projectid != null)
        {
        
        System.debug('*************checking projectid  in QIPP_Benefit_View***************** ' + projectid ); 
        
        
        projectinfo = [select id, Name ,Project_Lead_Email__c,TotalKPI__c ,TotalCOPQ__c , RecordType.name,Project_State__c ,Check_Lean_Approval_State__c, Project_Type__c ,Project_Number__c , Project_Name_Succinct__c ,  Project_Lead__r.Full_Name__c ,  Project_Lead__r.Name ,  Portfolio_Name__r.Portfolio_Name_Unique__c ,
                       CoPQ_Benefits_Validation_State__c ,TriggerForDI3ApprovalProcess__c, CABVM__c , KABVM__c , KPI_Benefits_Validation_State__c , DI_State__c, Belt_Project_Phase__c , FieldForControlVerifyPhase__c ,Check_DI_Approval_State__c,Check_Approval_Process_Status__c, Belt_Project_Type__c from QIPP_Project__c where id =: projectid];
        
        
        // validating for userroles
        Id userid = userinfo.getuserid();
        string rRolename =[select id,name,userrole.name from user where id = :userid].userrole.name; 
        Id profileId=userinfo.getProfileId();
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        
        if((projectinfo.Project_State__c == 'Complete' || projectinfo.Project_State__c == 'Closed') && (rRolename == 'QIPP Portfolio Manager' || rRolename == 'QIPP Admin' || profileName == 'System Administrator') && (projectinfo.Project_Type__c =='DMAIC' || projectinfo.Project_Type__c =='DMADV' || projectinfo.Project_Type__c == 'Lean (including Kaizen)' || projectinfo.Project_Type__c =='CIF' || projectinfo.Project_Type__c =='A3' || projectinfo.Project_Type__c =='8D'|| projectinfo.Project_Type__c =='RCA/EDA' || projectinfo.Project_Type__c =='Other')){
                UserRolename = 'yes'; 
        }else UserRolename = 'no'; 
        System.debug('*************UserRolename***************** ' + UserRolename);
        
        
         
        benefit.Project_ID__c = projectid ;
        
        projectFieldValue = new QIPP_Benefit__c();
        
         projectFieldValue.Project_Number__c = projectinfo.Project_Number__c ;
         projectFieldValue.Project_Name_Display__c = projectinfo.Project_Name_Succinct__c ; 
         projectFieldValue.Project_Lead__c  = projectinfo.Project_Lead__r.Full_Name__c ; 
         projectFieldValue.Portfolio_Name__c = projectinfo.Portfolio_Name__r.Portfolio_Name_Unique__c ;
        
        /*if(projectinfo.KPI_Benefits_Validation_State__c == 'Validation Complete' && projectinfo.CoPQ_Benefits_Validation_State__c == 'Validation Complete (via Q F&C)')
            checkButtonVisibility = false;
        else if(projectinfo.KPI_Benefits_Validation_State__c == 'Validation Complete' &&   projectinfo.TotalCOPQ__c < 50000)
            checkButtonVisibility = false;    
        else if(projectinfo.CoPQ_Benefits_Validation_State__c == 'Validation Complete (via Q F&C)' && projectinfo.TotalKPI__c < 50000)
            checkButtonVisibility = false;    
        else */
            checkButtonVisibility = true;   
            if((UserRolename != 'yes') && (  ((projectinfo.Project_State__c == 'Complete' || projectinfo.Project_State__c == 'Closed')  && (projectinfo.Project_Type__c =='DMAIC' || projectinfo.Project_Type__c == 'Lean (including Kaizen)' || projectinfo.Project_Type__c =='CIF' || projectinfo.Project_Type__c =='A3' || projectinfo.Project_Type__c =='8D'|| projectinfo.Project_Type__c =='RCA/EDA' || projectinfo.Project_Type__c =='Other')) ||   projectinfo.Check_DI_Approval_State__c == 'During DI3' || projectinfo.Check_DI_Approval_State__c == 'DI3 Complete' ||projectinfo.Check_DI_Approval_State__c == 'During DI4' ||projectinfo.Check_DI_Approval_State__c == 'DI4 Complete' ||projectinfo.Check_DI_Approval_State__c == 'During DI5' ||projectinfo.Check_DI_Approval_State__c == 'DI5 Complete'
               ||(projectinfo.CoPQ_Benefits_Validation_State__c == 'Validation Complete' && projectinfo.KPI_Benefits_Validation_State__c == 'Validation Complete') ||(projectinfo.Belt_Project_Phase__c != null  && projectinfo.FieldForControlVerifyPhase__c == 'RecordLock') || (projectinfo.Recordtype.Name == 'Methodology: Lean (including Kaizen)' && projectinfo.Check_Lean_Approval_State__c == 'During Lean') || (projectinfo.Recordtype.Name == 'Methodology: CIF' && (projectinfo.Check_Approval_Process_Status__c == 'During CIF')) || ( projectinfo.Check_Approval_Process_Status__c == 'During L6S' )) )
            {                
                checkButtonVisibility = false;  
            }
            
        System.debug('*************projectid***************** ' + projectid); 
        System.debug('*************project DI State***************** ' + projectinfo.DI_State__c); 

          
           benifit_Financial   = [select ID , Name , Improvement_Measure_KPI__c ,Unit_of_Measure__c,Benefit_Type__c,Planned_Financial_Savings_Total__c,Planned_Operational_Savings_Total__c,Achieved_Financial_Savings_Total__c,Achieved_Operational_Savings_Total__c,Future_Financial_Savings_Total__c,Future_Operational_Savings_Total__c,Benefit_Amount_Achieved_Future_k__c, Benefit_Operational_Achieved_Future_k__c, Project_ID__c,Portfolio_Name__c,Project_Lead__c,Project_Name_Display__c,Project_Number__c from QIPP_Benefit__c where  Project_ID__c =: projectid and Benefit_Type__c = 'Financial Savings'];
           benifit_Operational = [select ID , Name ,Improvement_Measure_KPI__c ,Unit_of_Measure__c,Benefit_Type__c,Benefit_Amount_Achieved_Future_k__c,Benefit_Operational_Achieved_Future_k__c,Planned_Financial_Savings_Total__c,Planned_Operational_Savings_Total__c,Achieved_Financial_Savings_Total__c,Achieved_Operational_Savings_Total__c,Future_Financial_Savings_Total__c,Future_Operational_Savings_Total__c, Project_ID__c,Portfolio_Name__c,Project_Lead__c,Project_Name_Display__c,Project_Number__c from QIPP_Benefit__c where  Project_ID__c =: projectid and Benefit_Type__c = 'Operational Savings'];

     System.debug('*************benifit_Operational***************** ' + benifit_Operational); 
     System.debug('*************benifit_Financial***************** ' + benifit_Financial); 
     
     PlannedFinancialTotal = 0.0;
     FutureFinancialTotal = 0.0;
     AchievedFinancialTotal = 0.0;
     ACHIEVEDFUTUREFINANCIALTOTAL = 0.0;
     
     for(QIPP_Benefit__c ben : benifit_Financial )   
     {
         /*if(ben.Planned_Financial_Manual_Amount__c != null)
         {
             PlannedFinancialTotal = PlannedFinancialTotal + ben.Planned_Financial_Manual_Amount__c;
         }
         if(ben.Planned_Financial_Automatic_Amount__c != null)
         {
             PlannedFinancialTotal = PlannedFinancialTotal + ben.Planned_Financial_Automatic_Amount__c;
         }*/
         if(ben.Planned_Financial_Savings_Total__c != null)
         {
             PlannedFinancialTotal = PlannedFinancialTotal + ben.Planned_Financial_Savings_Total__c;
         }         
         
         /*if(ben.Achieved_Financial_Manual_Amount__c != null)
         {
             AchievedFinancialTotal = AchievedFinancialTotal  + ben.Achieved_Financial_Manual_Amount__c;
         }
         if(ben.Achieved_Financial_Automatic_Amount__c != null)
         {
             AchievedFinancialTotal = AchievedFinancialTotal  + ben.Achieved_Financial_Automatic_Amount__c;
         }*/
         if(ben.Achieved_Financial_Savings_Total__c != null)
         {
             AchievedFinancialTotal = AchievedFinancialTotal  + ben.Achieved_Financial_Savings_Total__c;
         }
         
         /*if(ben.Future_Financial_Manual_Amount__c != null)
         {
             FutureFinancialTotal = FutureFinancialTotal + ben.Future_Financial_Manual_Amount__c;
         }                  
         if(ben.Future_Financial_Automatic_Amount__c != null)
         {
             FutureFinancialTotal = FutureFinancialTotal  + ben.Future_Financial_Automatic_Amount__c;
         }*/
         if(ben.Future_Financial_Savings_Total__c != null)
         {
             FutureFinancialTotal = FutureFinancialTotal + ben.Future_Financial_Savings_Total__c;
         }                  
         
         if(ben.Benefit_Amount_Achieved_Future_k__c != null)      
         {
            ACHIEVEDFUTUREFINANCIALTOTAL = ACHIEVEDFUTUREFINANCIALTOTAL + ben.Benefit_Amount_Achieved_Future_k__c;
         }
     }


     System.debug('*************PlannedFinancialTotal ***************** ' + PlannedFinancialTotal ); 
     System.debug('*************AchievedFinancialTotal ***************** ' + AchievedFinancialTotal ); 
     System.debug('*************FutureFinancialTotal ***************** ' + FutureFinancialTotal ); 

     PlannedOperationalTotal = 0.0;
     FutureOperationalTotal = 0.0;
     AchievedOperationalTotal = 0.0;
     ACHIEVEDFUTUREOPERATIONALTOTAL = 0.0;
     
     for(QIPP_Benefit__c ben : benifit_Operational )   
     {
         /*if(ben.Planned_Operational_Manual_Amount__c != null)
         {
             PlannedOperationalTotal = PlannedOperationalTotal + ben.Planned_Operational_Manual_Amount__c;
         }
         if(ben.Planned_Operational_Automatic_Amount__c != null)
         {
             PlannedOperationalTotal = PlannedOperationalTotal + ben.Planned_Operational_Automatic_Amount__c;
         }*/
         if(ben.Planned_Operational_Savings_Total__c != null)
         {
             PlannedOperationalTotal = PlannedOperationalTotal + ben.Planned_Operational_Savings_Total__c;
         }
         
         /*if(ben.Achieved_Operational_Manual_Amount__c != null)
         {
             AchievedOperationalTotal = AchievedOperationalTotal  + ben.Achieved_Operational_Manual_Amount__c;
         }
         if(ben.Achieved_Operational_Automatic_Amount__c != null)
         {
             AchievedOperationalTotal = AchievedOperationalTotal  + ben.Achieved_Operational_Automatic_Amount__c;
         }*/
         if(ben.Achieved_Operational_Savings_Total__c != null)
         {
             AchievedOperationalTotal = AchievedOperationalTotal  + ben.Achieved_Operational_Savings_Total__c;
         }
         
         /*if(ben.Future_Operational_Manual_Amount__c != null)
         {
             FutureOperationalTotal = FutureOperationalTotal + ben.Future_Operational_Manual_Amount__c;
         }                  
         if(ben.Future_Operational_Automatic_Amount__c != null)
         {
             FutureOperationalTotal = FutureOperationalTotal  + ben.Future_Operational_Automatic_Amount__c;
         }*/
         if(ben.Future_Operational_Savings_Total__c != null)
         {
             FutureOperationalTotal = FutureOperationalTotal + ben.Future_Operational_Savings_Total__c;
         }                  
         
         if(ben.Benefit_Operational_Achieved_Future_k__c != null)
         {
             ACHIEVEDFUTUREOPERATIONALTOTAL = ACHIEVEDFUTUREOPERATIONALTOTAL  + ben.Benefit_Operational_Achieved_Future_k__c ;
         }    
         
     }

     System.debug('*************PlannedOperationalTotal ***************** ' + PlannedOperationalTotal ); 
     System.debug('*************AchievedOperationalTotal ***************** ' + AchievedOperationalTotal ); 
     System.debug('*************FutureOperationalTotal ***************** ' + FutureOperationalTotal ); 

    }

     if(projectinfo.CoPQ_Benefits_Validation_State__c != null &&  ( projectinfo.CoPQ_Benefits_Validation_State__c == 'With Finance Approver to Validate'))  
         FinancialErrorMessage = 'Note: Financial Savings cannot be added at this point, as the approvals are pending';

     if(projectinfo.CoPQ_Benefits_Validation_State__c != null && projectinfo.CoPQ_Benefits_Validation_State__c == 'Validation Complete')  
         FinancialErrorMessage = 'Note: Financial Savings cannot be added at this point, as they are already approved';

     if(projectinfo.KPI_Benefits_Validation_State__c != null &&  ( projectinfo.KPI_Benefits_Validation_State__c == 'With Operational Savings Approver to Validate' || projectinfo.KPI_Benefits_Validation_State__c == 'With Finance Approver to Validate'))  
         OperationalErrorMessage = 'Note: Operational Savings cannot be added at this point, as the approvals are pending';

     if(projectinfo.KPI_Benefits_Validation_State__c != null &&  projectinfo.KPI_Benefits_Validation_State__c == 'Validation Complete')  
         OperationalErrorMessage = 'Note: Operational Savings cannot be added at this point, as they are already approved';
     
       
       
      //Subhash:start
      AlphaList = new list<String> {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'All'};
      if (apexpages.currentpage().getparameters().get('alpha') == null) {
           AlphaFilter = '';
      } else {
           AlphaFilter = apexpages.currentpage().getparameters().get('alpha');
      }
      improvementmeasure = ApexPages.currentPage().getParameters().get('imeasure');
      con_table = new list<QIPP_Benefit_Conversion_Table__c>();
      //Subhash:end  
        
    }
     catch(Exception exe)
       {
           System.Debug(' ****************************EXCEPTION OCCURES in QIPP_Benefit_View ****************************' + exe.getMessage());
           System.Debug(' ****************************EXCEPTION OCCURES @ Line Number in QIPP_Benefit_View****************************' + exe.getLineNumber());
       } 
  }


  public PageReference DeleteBenefit()
  {
      //System.Debug('************* In DeleteBenefit() ************** ' + BenefitId);
      //System.Debug('************* projectId ************** ' + projectId);

      PageReference page =  null;
      
     try
     {
      
      if(BenefitId != null)
      {
      
      List<QIPP_BU_Reporting__c> deleteRelatedBUReporting = [select ID from QIPP_BU_Reporting__c where Benefit_ID__c =: BenefitId ];
      delete deleteRelatedBUReporting;
        string projectName = [select Name from QIPP_Project__c where id =: projectid ].name;
        
        QIPP_Project__c prj = [select Name, Project_Type__c from QIPP_Project__c where id =: projectid];
        String prjMethodology = prj.Project_Type__c;
        system.debug('@@prjMethodology:'+prjMethodology);
        
        benifit  = [select ID from QIPP_Benefit__c where  id =: BenefitId ];
            IF(benifit  != NULL)
                delete benifit ;
                
                if(prjMethodology.equalsIgnoreCase('DMAIC') || prjMethodology.equalsIgnoreCase('DMADV')){
                    page = new PageReference('/apex/qippprojectdetailview?id='+projectId);
                }else{
                    page = new PageReference('/'+projectId);
                }
                
            // page = new PageReference('https://c.na12.visual.force.com/apex/QIPP_Benefit_View?fm='+projectId);      
             //page = new PageReference('https://c.cs63.visual.force.com/apex/QIPP_Benefit_View?fm='+projectId);      
      } 
      else
      {
          page = null;
      } 
     }
          catch(Exception exe)
          {
              System.Debug('************* some error occrued ************** ' + exe.getMessage() );
              System.Debug('************* some error occrued @ line number ************** ' + exe.getLineNumber() ); 
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient Privileges to delete the benefit, click on the above link to go back to the project detail view page.Please contact your Sysytem Administrator'));
          }         
     return page;
  }
  
  public PageReference moveToBenefitePage()
  {
      PageReference obj = new PageReference('/apex/QIPP_Benefit?CF00NK0000000wDLh='+projectinfo.Name+'&CF00NK0000000wDLh_lkid='+projectinfo.Id+'&scontrolCaching=1&retURL=%2F'+projectinfo.Id+'&sfdc.override=1');
      return obj;        
  }
  public PageReference BackToProjectDetailPage()
  {
      PageReference obj = new PageReference('/'+projectid);
      return obj;        
  }

public PageReference viewFSQ()
  {
      System.Debug('*************ProjectReportPage ************** ' + projectid );  
      String str = projectinfo.Project_Number__c ;
      PageReference obj = new PageReference('/00OU0000001wMzI?pv0='+str); // QIPP-Financial Savings - Quarterly
      System.Debug('************* obj************** ' +  obj);
      return obj;        
  }
public PageReference viewFSM()
  {
      System.Debug('*************ProjectReportPage ************** ' + projectid );  
      String str = projectinfo.Project_Number__c ;
      PageReference obj = new PageReference('/00OU0000001wMzJ?pv0='+str); // QIPP-FINANCIAL Savings- Monthly
      System.Debug('************* obj************** ' +  obj);
      return obj;        
  }
public PageReference viewOSQ()
  {
      System.Debug('*************ProjectReportPage ************** ' + projectid );  
      String str = projectinfo.Project_Number__c ;
      PageReference obj = new PageReference('/00OU0000001wMzL?pv0='+str); // QIPP-Operational Savings- Quarterly
      System.Debug('************* obj************** ' +  obj);
      return obj;        
  }
public PageReference viewOSM()
  {
      System.Debug('*************ProjectReportPage ************** ' + projectid );  
      String str = projectinfo.Project_Number__c ;
      PageReference obj = new PageReference('/00OU0000001wMzK?pv0='+str); // QIPP-Operational Savings- Monthly
      System.Debug('************* obj************** ' +  obj);
      return obj;        
  }  



    //Subhash:start
    public PageReference goToBenefitLookUp()
    {
      PageReference pg = new PageReference('/apex/QIPP_Benefit_lookup_Page');
      pg.getHeaders().put('projectid', projectid);
      system.debug('ID::::::::::::::' + pg.getHeaders().get('projectid'));
      return pg;        
    }
    
    public PageReference search()  
    {
        String s = null;
        if(con_table.size()>0){con_table.clear();}
        con_table = new list<QIPP_Benefit_Conversion_Table__c>(); 
        display=true;
        
        if(searchtext != null && searchtext != ''){
        if(searchtext.substring(0,1)=='*' && searchtext.substring(searchtext.length()-1)=='*')
        {
        searchtext  = searchtext.substringBeforeLast('*');
        searchtext  = searchtext.substringAfterLast('*');
        }
        else if(searchtext.substring(0,1)=='*'){
        searchtext  = searchtext.substringAfterLast('*');
        }
        else if(searchtext.substring(searchtext.length()-1)=='*'){
        searchtext  = searchtext.substringBeforeLast('*');
        }
        s = '%'+searchtext+'%';
        }    
            
            if(String.escapeSingleQuotes(AlphaFilter) != null && (searchtext == null || searchtext == '')){
            if(String.escapeSingleQuotes(AlphaFilter)!= '' && String.escapeSingleQuotes(AlphaFilter) != 'All')
            s = String.escapeSingleQuotes(AlphaFilter)+'%';
            else if(String.escapeSingleQuotes(AlphaFilter) == 'All')
            s = searchtext+'%';
            else
            s = searchtext;    
            }
            
        list<QIPP_Benefit_Conversion_Table__c> ct_searchResults =[select id, name, Improvement_Measure_Short_Name__c, Brief_Description__c, Benefit_Type__c,CoPQ_Type__c,Unit_of_Measure__c,Examples_del__c,Improvement_Measure_Grouping__c from QIPP_Benefit_Conversion_Table__c where name LIKE: +s ];
            
            for(QIPP_Benefit_Conversion_Table__c con : ct_searchResults)
            {
                con_table.add(con);
            }
            searchtext = '';
           
        return null;
    }
    
    public list<QIPP_Benefit_Conversion_Table__c> getctlist()
    {
    return con_table;
    }
    public PageReference viewBenefitSummary()
    {
        con_table.clear();
        PageReference pgr =  new PageReference('/apex/qippprojectdetailview?id='+projectid); 
        return pgr;
    }  
    public PageReference addBenefit()
    {
        
        system.debug('**************** improvementmeasure::::'+improvementmeasure);
        //benifit = new List<QIPP_Benefit__c>();
        //benifit_im = [select id,name from QIPP_Benefit__c where  Improvement_Measure_KPI__c =: improvementmeasure ];
        //PageReference obj = new PageReference('/apex/QIPP_Benefit?convId='+improvementmeasure+'&retURL=%2F'+projectid+'&sfdc.override=1');
        PageReference obj = new PageReference('/apex/QIPP_Benefit?convId='+improvementmeasure+'&retURL=%2F'+projectinfo.Id+'&sfdc.override=1');
        system.debug('**************** Page Reference **************'+obj); 
        
        return obj; 
    }
    //Subhash:end  
}