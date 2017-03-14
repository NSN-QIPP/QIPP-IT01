public class QIPPCDTReport
{
    public List<QIPP_Project__c> projectrecord;
    public List<CustomList> custom {get;set;}
    
    
    public QIPPCDTReport()
    {
       projectrecord = [select ID , Project_Name_Succinct__c , KPI__c , Target__c , Actual__c ,
                            Portfolio_Name__r.Id , Portfolio_Name__r.Regional_Market__c , Portfolio_Name__r.Portfolio_Name_Unique__c , 
                            Portfolio_Name__r.CDT_Lead_Name__c , Portfolio_Name__r.CPVi_Composite__c , 
                            Portfolio_Name__r.CPV_Reference__c , Portfolio_Name__r.CPV_Interview_Date__c ,
                            Portfolio_Name__r.CPV_Trend__c ,
                            Portfolio_Name__r.CPVi_Past__c , Portfolio_Name__r.CPVi_Future__c from QIPP_Project__c 
                            where Portfolio_Name__r.Portfolio_Type__c = 'CDT' and  
                            ( Project_State__c = 'In Progress' OR Project_State__c = 'Not Started' OR Project_State__c = 'On Hold')
                            order by Portfolio_Name__r.Regional_Market__c , Portfolio_Name__r.Portfolio_Name_Unique__c ,Project_Name_Succinct__c]  ;                      
        
        Id[] projectsid = new Id[]{};
        for(QIPP_Project__c proj : projectrecord)
        {
            projectsid.add(proj.Id);
        }                            
        
        List<QIPP_Task__c> task1 =  [select Project_ID__c, Task_Name_Succinct__c ,Task_Notes__c ,Task_Percent_Complete__c from QIPP_Task__c 
                            where Project_ID__c in : projectsid];

         if(projectrecord.size() > 0)
           { 
               custom = new  List<CustomList>();
               String checkPortName = null;
               String checkRegionName = null;
               
               for(QIPP_Project__c project : projectrecord)
               {
                      List<QIPP_Task__c> MTask =  new List<QIPP_Task__c>(); 
                      FOR(QIPP_Task__c TASK : task1)
                       {
                           IF(TASK.Project_ID__c == project.ID)
                           {
                               QIPP_Task__c singletask  = new QIPP_Task__c (); 
                               singletask.Project_ID__c = TASK.Project_ID__c;
                               singletask.Task_Name_Succinct__c = TASK.Task_Name_Succinct__c ;
                               singletask.Task_Notes__c = TASK.Task_Notes__c;
                               singletask.Task_Percent_Complete__c = TASK.Task_Percent_Complete__c;
                               MTask.add(singletask);
                               singletask = null;            
                           }
                       }  
                       IF(MTask.SIZE() == 0)
                       {
                          CustomList obj = new CustomList();
                          if(checkPortName !=  project.Portfolio_Name__r.Portfolio_Name_Unique__c)
                            {
                              obj.PortRegionalMarket = project.Portfolio_Name__r.Regional_Market__c ;                              
                              obj.PortCDTLeadName  = project.Portfolio_Name__r.CDT_Lead_Name__c;
                              obj.PortCPVReference = project.Portfolio_Name__r.CPV_Reference__c ; 
                              obj.PortCPVInterviewDate = getDateFormated(project.Portfolio_Name__r.CPV_Interview_Date__c);
                              
                              if(project.Portfolio_Name__r.CPV_Trend__c != null && project.Portfolio_Name__r.CPV_Trend__c != '-None-')
                              {
                                  if(project.Portfolio_Name__r.CPV_Trend__c == 'Up')
                                  {
                                      obj.PortTrendImage = '/resource/CDTUp';
                                  }
                                  else if(project.Portfolio_Name__r.CPV_Trend__c == 'Down')
                                  {
                                      obj.PortTrendImage = '/resource/CDTDown';
                                  }
                                  else
                                  {
                                      obj.PortTrendImage = '/resource/CDTNeutral';
                                  }
                              }
                              else
                              {
                                    obj.PortTrendImage = '/resource/CDTNeutral';
                              }
                              
                              if(project.Portfolio_Name__r.CPVi_Composite__c != null)
                              {
                                  obj.PortCPViComposite = String.valueOf(project.Portfolio_Name__r.CPVi_Composite__c) ;
                                  obj.PortCPViComposite += '%';
                              }  
                              else
                              {
                                  obj.PortCPViComposite = 'N/A';
                              }  
                              
                              if(project.Portfolio_Name__r.CPVi_Past__c != null)
                               {   
                                  obj.PortCPViPast = String.valueOf(project.Portfolio_Name__r.CPVi_Past__c);
                                  obj.PortCPViPast += '%';
                               }
                               ELSE
                               {
                                   obj.PortCPViPast = 'N/A';
                               }
                               
                              if(project.Portfolio_Name__r.CPVi_Future__c != null)
                              {
                                  obj.PortCPViFuture = String.valueOf(project.Portfolio_Name__r.CPVi_Future__c);
                                  obj.PortCPViFuture += '%';
                              }    
                              else
                              {
                                   obj.PortCPViFuture = 'N/A';
                              }
                              obj.PortName = project.Portfolio_Name__r.Portfolio_Name_Unique__c ;
                              checkPortName = project.Portfolio_Name__r.Portfolio_Name_Unique__c ;
                              
                              /******************* Added Logo of Portfolio START ********************/

                                       ID portfolioID1 = project.Portfolio_Name__r.Id;
                                       QIPP_Portfolio__c notesanddocs1 = [Select p.Id , (Select Id, IsNote, Title From NotesAndAttachments) From QIPP_Portfolio__c p where p.id=: portfolioID1];
                                       List<NoteAndAttachMent> n1= notesanddocs1.NotesAndAttachments;
                                       System.Debug('****** notesandattchment1 ***********'   + n1); 
                                       List<Logo> Images = new List<Logo>();
                                       
                                       for(NoteAndAttachMent attachments : n1)
                                       {
                                           if(attachments.IsNote == false)
                                           {
                                               if(attachments.Title.contains('.jpg')||attachments.Title.contains('.jpeg')||attachments.Title.contains('.png'))
                                               {
                                                   Logo newLogo = new Logo();
                                                   newLogo.Title = attachments.Title;
                                                   newLogo.logoId = attachments.Id;
                                                   Images.add(newLogo);
                                                   newLogo = null;
                                               }
                                           }
                                       }
                                       
                                       if(Images != null)
                                        {    
                                          if(Images.size() > 0)
                                            {
                                                obj.ImagePath = '/servlet/servlet.FileDownload?file='+Images[0].logoId; 
                                            }
                                         else
                                            {
                                                obj.ImagePath = '/resource/NoImage';
                                            }
                                        }
                                       
                                       obj.ForImageDisplay = true;
                                       obj.checkForGraph = false;


                                /******************* Added Logo of Portfolio END ********************/
                            } 
                            else
                            {
                                  obj.PortRegionalMarket = '';
                                  obj.PortCDTLeadName  = '';
                                  obj.PortCPViComposite = null;
                                  obj.PortCPVReference = ''; 
                                  obj.PortCPVInterviewDate = '';
                                  obj.PortCPViPast = null;
                                  obj.PortCPViFuture =null;
                                  obj.PortName = '';
                                  obj.ImagePath ='';
                                  obj.ForImageDisplay = false;
                                  obj.checkForGraph = false;
                                  obj.PortTrendImage = '/resource/CDTNeutral';
                            }
                           obj.ProjectName = project.Project_Name_Succinct__c;
                           obj.ProjectKPI =  project.KPI__c;        
                           obj.ProjectTarget = project.Target__c;
                           obj.ProjectActual = project.Actual__c;

                           obj.ChartImageName =  '/resource/T0White' ;
                           custom.add(obj); 
                       }    
                       IF(MTask.SIZE() > 0)
                       {
                           String checkProjectName = NULL;
                           for(QIPP_Task__c taskassociated : MTask)
                           {
                              CustomList obj = new CustomList(); 
                              if(checkPortName !=  project.Portfolio_Name__r.Portfolio_Name_Unique__c)
                              {
                                  obj.PortRegionalMarket = project.Portfolio_Name__r.Regional_Market__c ;
                                  obj.PortCDTLeadName  = project.Portfolio_Name__r.CDT_Lead_Name__c;
                                  
                                  if(project.Portfolio_Name__r.CPV_Trend__c != null && project.Portfolio_Name__r.CPV_Trend__c != '-None-')
                                  {
                                      if(project.Portfolio_Name__r.CPV_Trend__c == 'Up')
                                      {
                                          obj.PortTrendImage = '/resource/CDTUp';
                                      }
                                      else if(project.Portfolio_Name__r.CPV_Trend__c == 'Down')
                                      {
                                          obj.PortTrendImage = '/resource/CDTDown';
                                      }
                                      else
                                      {
                                          obj.PortTrendImage = '/resource/CDTNeutral';
                                      }
                                  }
                                  else
                                  {
                                        obj.PortTrendImage = '/resource/CDTNeutral';
                                  }

                                  if(project.Portfolio_Name__r.CPVi_Composite__c != null)
                                  {
                                      obj.PortCPViComposite = String.valueOf(project.Portfolio_Name__r.CPVi_Composite__c) ;
                                      obj.PortCPViComposite += '%';
                                  }    
                                  else
                                  {
                                      obj.PortCPViComposite = 'N/A';
                                  }  
                                  obj.PortCPVReference = project.Portfolio_Name__r.CPV_Reference__c ; 
                                  obj.PortCPVInterviewDate = getDateFormated(project.Portfolio_Name__r.CPV_Interview_Date__c);
                                  if(project.Portfolio_Name__r.CPVi_Past__c != null)
                                   {   
                                      obj.PortCPViPast = String.valueOf(project.Portfolio_Name__r.CPVi_Past__c);
                                      obj.PortCPViPast += '%';
                                   }
                                  ELSE
                                  {
                                      obj.PortCPViPast = 'N/A';
                                  } 
                                  if(project.Portfolio_Name__r.CPVi_Future__c != null)
                                  {
                                      obj.PortCPViFuture = String.valueOf(project.Portfolio_Name__r.CPVi_Future__c);
                                      obj.PortCPViFuture += '%';
                                  }  
                                  ELSE
                                  {
                                      obj.PortCPViFuture = 'N/A';
                                  }                                  
                                  obj.PortName = project.Portfolio_Name__r.Portfolio_Name_Unique__c ;
                                  checkPortName = project.Portfolio_Name__r.Portfolio_Name_Unique__c ;
                                  
                                  /******************* Added Logo of Portfolio START ********************/
                               
                                       ID portfolioID1 = project.Portfolio_Name__r.Id;
                                       QIPP_Portfolio__c notesanddocs1 = [Select p.Id , (Select Id, IsNote, Title From NotesAndAttachments) From QIPP_Portfolio__c p where p.id=: portfolioID1];
                                       List<NoteAndAttachMent> n1= notesanddocs1.NotesAndAttachments;
                                       System.Debug('****** notesandattchment1 ***********'   + n1); 
                                       List<Logo> Images = new List<Logo>();
                                       
                                       for(NoteAndAttachMent attachments : n1)
                                       {
                                           if(attachments.IsNote == false)
                                           {
                                               if(attachments.Title.contains('.jpg')||attachments.Title.contains('.jpeg')||attachments.Title.contains('.png'))
                                               {
                                                   Logo newLogo = new Logo();
                                                   newLogo.Title = attachments.Title;
                                                   newLogo.logoId = attachments.Id;
                                                   Images.add(newLogo);
                                                   newLogo = null;
                                               }
                                           }
                                       }
                                       
                                       if(Images != null)
                                        {    
                                          if(Images.size() > 0)
                                            {
                                                obj.ImagePath = '/servlet/servlet.FileDownload?file='+Images[0].logoId;
                                            }
                                         else
                                            {
                                                obj.ImagePath = '/resource/NoImage';
                                            }
                                        }
                                       
                                       obj.ForImageDisplay = true;
                                       obj.checkForGraph = false;
                                  
                                  /******************* Added Logo of Portfolio END ********************/
                                  
                                } 
                                else
                                {
                                      obj.PortRegionalMarket = '';
                                      obj.PortCDTLeadName  = '';
                                      obj.PortCPViComposite = null;
                                      obj.PortCPVReference = ''; 
                                      obj.PortCPVInterviewDate = '';
                                      obj.PortCPViPast = null;
                                      obj.PortCPViFuture =null;
                                      obj.PortName = '';
                                      obj.PortTrendImage = '/resource/CDTNeutral';
                                      obj.ImagePath ='';
                                      obj.ForImageDisplay = false;
                                      obj.checkForGraph = false;
                                }
                               if(checkProjectName != project.Project_Name_Succinct__c)
                               {
                                   obj.ProjectName = project.Project_Name_Succinct__c;   
                                   obj.ProjectKPI =  project.KPI__c;        
                                   obj.ProjectTarget = project.Target__c;
                                   obj.ProjectActual = project.Actual__c;                                   
                                   checkProjectName = project.Project_Name_Succinct__c;
                                   obj.TaskName =  taskassociated.Task_Name_Succinct__c;
                                   obj.TaskNotes = taskassociated.Task_Notes__c;
                                   if(taskassociated.Task_Percent_Complete__c != null)
                                   {
                                       obj.TaskComplete = String.valueOf(taskassociated.Task_Percent_Complete__c); 
                                       obj.TaskComplete += '%';
                                       obj.ChartImageName = '/resource/T'+taskassociated.Task_Percent_Complete__c;     //https://cs9.salesforce.com           
                                   }
                                   else
                                   {
                                        
                                        obj.checkForGraph = false; 
                                   }
                               }
                               else
                               {    
                                   obj.TaskName =  taskassociated.Task_Name_Succinct__c;
                                   obj.TaskNotes = taskassociated.Task_Notes__c;
                                   if(taskassociated.Task_Percent_Complete__c != null)
                                   {
                                       obj.TaskComplete = String.valueOf(taskassociated.Task_Percent_Complete__c); 
                                       obj.TaskComplete += '%';
                                       obj.ChartImageName = '/resource/T'+taskassociated.Task_Percent_Complete__c;   //https://cs9.salesforce.com             
                                   }
                                   else
                                   {
                                      
                                        obj.checkForGraph = false; 
                                   }
                                   
                               }
                               custom.add(obj); 
                           }
                       } 
                    }
          }
    }
    
    public PageReference getFromCDTReport()
    {
        PageReference  fromCDT = new PageReference('/apex/QIPPCDTReportPrint');
        fromCDT.setRedirect(true);
        return fromCDT;
    }
    
    public PageReference ReturnFromCDT()
    {
        PageReference  fromCDT = new PageReference('/apex/QIPPCustomReportPage?F=CDT');
        fromCDT.setRedirect(true);
        return fromCDT;
    }
    
    String getDateFormated(Date strDate)
    {
        if(strDate != null)
            return strDate.year() + '/' + strDate.Day() + '/' + strDate.month();        
        else
            return null;    
    }
    
 
    class CustomList
    {
        public String TaskName {get;set;}
        public String TaskNotes {get;set;}
        public String TaskComplete {get;set;}
        public String ProjectName {get;set;}
        public String ProjectKPI{get;set;}
        public String ProjectTarget{get;set;}
        public String ProjectActual{get;set;}                    
        public String PortRegionalMarket {get;set;}
        public String PortCDTLeadName {get;set;}
        public String PortCPViComposite {get;set;}
        public String PortCPVReference {get;set;}
        public String PortCPVInterviewDate {get;set;}
        public String PortCPViPast {get;set;}                                
        public String PortCPViFuture {get;set;}      
        public String PortName {get;set;}      
        public String ImagePath {get;set;}
        public Boolean ForImageDisplay {get;set;}
        public String ChartImageName {get;set;}        
        public Boolean checkForGraph {get;set;}
        public String PortTrendImage {get;set;}
        //public List<PieWedgeData> graphobj {get;set;}
    }
    
    public class Logo
    {
        public String Title{get;set;}
        public ID logoId {get;set;}
    }
}