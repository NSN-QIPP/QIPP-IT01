public class QIRSchangerecord
{

    public QIRSchangerecord(ApexPages.StandardController controller) 
    {
    }
    public QIRSchangerecord() 
    {
    }
        public Boolean trackID{ get; set;}
        public Boolean trackID1{ get; set;}
        Public String get_id{get; set;}
        public String FirstName{ get; set;}
        public Boolean FirstName1{ get; set;}
        public Boolean FirstName2{ get; set;}
        Public String LastName{get; set;}
        public String Email{ get; set;}
        public String Status{ get; set;}
        public String QIRSNumber{ get; set;}
        public String ActionPlanNumber{ get; set;}
        Public String Comments{get; set;}
        Public Boolean Save1{get; set;}
        public String new_id;

    public pagereference temp()
    {
        if(ApexPages.currentPage().getParameters().get('id')!=null)
        {   
            trackID1 = true;
            trackID = false;
            Save();
            FirstName1 = true;
            FirstName2 = false;
            Save1 = true;        
        }
        else
        {
            FirstName1 = true;
            Save1 = true;
            trackID = false;
            trackID1 = false;            
        }
        return null;
    } 

    public ID temp {get; set;}
    
    public Pagereference Save()
    {
        temp = ApexPages.currentPage().getParameters().get('id');
      
        if(FirstName == '' || FirstName ==null )
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Kindly fill the correct First Name.');
            ApexPages.addMessage(myMsg);
            System.debug('myMsg&&&&&&&&&&&&&&&&&&&&'+myMsg);
            return null;
        }
            
        if(LastName == '' || LastName ==null )
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Kindly fill the correct Last Name.');
            ApexPages.addMessage(myMsg);
            System.debug('myMsg&&&&&&&&&&&&&&&&&&&&'+myMsg);
            return null;
        }
            
        if(Email == '' || Email ==null )
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Kindly fill the correct Email ID.');
            ApexPages.addMessage(myMsg);
            System.debug('myMsg&&&&&&&&&&&&&&&&&&&&'+myMsg);
            return null;
        }
            
        if(QIRSNumber == '' || QIRSNumber==null )
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Kindly fill the correct QIRS Number.');
            ApexPages.addMessage(myMsg);
            System.debug('myMsg&&&&&&&&&&&&&&&&&&&&'+myMsg);
            return null;
        }  
               
        if(Comments == '' || Comments ==null )
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Kindly fill the correct Comments.');
            ApexPages.addMessage(myMsg);
            System.debug('myMsg&&&&&&&&&&&&&&&&&&&&'+myMsg);
            return null;
        }
            
        if(temp==null)
        {
            QIRS_Change_Request__c q = new QIRS_Change_Request__c();
            q.First_Name__c = FirstName;
            q.Last_Name__c = LastName;
            q.Email_ID__c = Email;
            q.QIRS_Number__c = QIRSNumber;
            q.Action_Plan_Number__c = ActionPlanNumber;
            q.Comment__c =  Comments;
            q.Status__c = 'Open';
            q.RecordTypeId = [SELECT Id FROM RecordType WHERE Name =: 'QIRS Change Request'].id;
            try
            {
                insert q; 
            } 
            catch 
            (
            System.DmlException e
            ) 
            {ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Kindly fill the correct Email. (E.g.Firstname.Lastname@nokia.com)');
            ApexPages.addMessage(myMsg);
            System.debug('myMsg&&&&&&&&&&&&&&&&&&&&'+myMsg);
            return null;}
            
            get_id = [SELECT Name FROM QIRS_Change_Request__c ORDER BY CreatedDate DESC LIMIT 1].Name;
            FirstName1 = false;
            FirstName2 = true;
            trackID = true;
            Save1 = false;
            return null;
        }
    
        else
            {
            list<QIRS_Change_Request__c> q = new list<QIRS_Change_Request__c>();
            if(temp!=null )
            {
                q = [SELECT Name, First_Name__c, Last_Name__c, Email_ID__c, QIRS_Number__c, Action_Plan_Number__c, Comment__c,Status__c  FROM QIRS_Change_Request__c where id =: temp];
                           
                FirstName = q[0].First_Name__c;
                LastName = q[0].Last_Name__c;
                Email = q[0].Email_ID__c;
                QIRSNumber = q[0].QIRS_Number__c;
                ActionPlanNumber = q[0].Action_Plan_Number__c;
                Comments = q[0].Comment__c;
                get_id = q[0].Name;
                return null;
            }
            return null;
            }
        }    
    public pagereference cancel()
    {
        pagereference c = new pagereference('/apex/QIRS_HomePage_site');
        return c;
    }
    static testMethod void testQIRSchangerecord()
     {
         List<String> strNSNQIRS =new List<String>();
         List<Profile> tempprofile = new List<Profile>(); 
         String[] Profile = new String[] {'Nokia QIRS Admin','Nokia QIRS'};
         tempprofile=[SELECT Id,Name from Profile where Name In : Profile];          
           for (Integer j=0;j<tempprofile.size();j++)
            {
              strNSNQIRS.add(tempprofile[j].Id);
            }
          
          List<User> userlist= new List<User>();
          userlist= [select Id,Name from User where 
           ProfileId In: strNSNQIRS and IsActive = true order by Name];        
      QIRS__c objqirs = new QIRS__c();
           objqirs.Site1__c = 'Alsdorf';
           objqirs.Process_Owner1__c = userlist[0].Id;           
           objqirs.Business__c = 'Networks Systems';           
           objqirs.Business_Group__c = 'CDMA';           
           objqirs.Alert_Type__c = 'NPI Launch Impact';           
           objqirs.Issue_Level__c = 'Launch Delay';                                            
             objqirs.Factory__c ='Berlin';
           objqirs.Problem_Description1__c = 'Networks Systems';           
           objqirs.Customer__c = 'CDMA';           
           objqirs.Defective_Part__c = 'Design';           
           objqirs.Symptom__c = 'Hardware';                                            
           objqirs.Projected_Lift_Date__c  =Date.today();        
            objqirs.Master_Approver1__c =userlist[0].Id;
           objqirs.Master_Approver2__c =userlist[1].Id;
           objqirs.Master_Approver3__c =userlist[2].Id;
           objqirs.Master_Approver4__c =userlist[3].Id;
           objqirs.Master_Approver5__c =userlist[4].Id;
           objqirs.Master_Approver6__c =userlist[5].Id;
           objqirs.Master_Approver7__c =userlist[6].Id;
           objqirs.Master_Approver8__c =userlist[7].Id;                                                                  
           objqirs.Master_Approver9__c =userlist[8].Id;
           objqirs.Master_Approver10__c =userlist[9].Id;           
            objqirs.Approver_Contacted1__c = true;
            objqirs.Approver_Contacted2__c = true;
            objqirs.Approver_Contacted3__c = true;
            objqirs.Approver_Contacted4__c = true;
            objqirs.Approver_Contacted5__c = true;
            objqirs.Approver_Contacted6__c = true;
            objqirs.Approver_Contacted7__c = true;
            objqirs.Approver_Contacted8__c = true;                                                                                    
            objqirs.Approver_Contacted9__c = true;            
            objqirs.Approver_Contacted10__c = true;   
           objqirs.Impacted_Region__c = 'Asia';           
           objqirs.Countries__c = 'China';           
             insert objqirs;   
             List<QIRS__c> lstQirs = new List<QIRS__c>();             
             lstQirs.add(objqirs); 
              
              QIRS_Change_Request__c objqcr = new QIRS_Change_Request__c();
              objqcr.Action_Plan_Number__c = '';
              objqcr.Admin_Comments__c = '';
              objqcr.Email_ID__c = 'tejas.kardile1984@gmail.com';
              objqcr.First_Name__c ='Test Name';
              objqcr.Comment__c='test';
              objqcr.Last_Name__c='test';
              objqcr.QIRS_Number__c='test';
              objqcr.Status__c='Open';
              insert objqcr;
              list<QIRS_Change_Request__c> q = new list<QIRS_Change_Request__c>();
              q.add(objqcr);
              ApexPages.CurrentPage().getParameters().put('id', objqirs.Id); 
              
         QIRSchangerecord controller = new QIRSchangerecord();
         ApexPages.CurrentPage().getParameters().put('id', objqcr.Id); 
         
        //controller.temp =objqirs.Id;
        controller.Save();
        
        controller.FirstName ='';
        controller.LastName ='Test';
        controller.Save();

        controller.FirstName ='Test';
        controller.LastName ='';
        controller.Save();
        
        controller.FirstName ='Test';
        controller.LastName ='Test';
        controller.Email ='';
        controller.Save();   

        controller.FirstName ='Test';
        controller.LastName ='Test';
        controller.Email ='tejas.kardile1984@gmail.com';
        controller.QIRSNumber = '';
        controller.Save();                    

        controller.FirstName ='Test';
        controller.LastName ='Test';
        controller.Email ='tejas.kardile1984@gmail.com';
        controller.QIRSNumber = 'Test';
        controller.Comments ='';
        controller.Save();      
        
        controller.FirstName ='Test';
        controller.LastName ='Test';
        controller.Email ='tejas.kardile1984@gmail.com';
        controller.QIRSNumber = 'QIRS1';
        controller.Comments ='test';
        //controller.temp=objqcr.Id;
        controller.Save();      
      
      
       controller.FirstName ='Test';
        controller.LastName ='Test';
        controller.Email ='tejas.kardile1984@gmail.com';
        controller.QIRSNumber = 'QIRS1';
        controller.Comments ='test';
        ApexPages.CurrentPage().getParameters().put('id', null); 
        controller.Save();   
           
           controller.temp();
              ApexPages.CurrentPage().getParameters().put('id', NULL); 
         controller.temp();             
       

         controller.cancel();              

           
     }
}