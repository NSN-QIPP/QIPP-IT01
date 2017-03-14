trigger AssignQLTFunctionHead on QIPP_Project__c (before insert , before update) 
{
       List<QIPP_Project__c> newproject = Trigger.New;
    
       QIPP_Project__c project = newproject[0];        
       if(project.Project_Completion_Date_Target__c != NULL)
       {        
       if(project.Primary_QLT_Function__c == 'CO')
         project.Primary_QLT_Function_Head__c = 'tom.gaynor@nokia.com';//'abhishekj25@gmail.com'
       if(project.Primary_QLT_Function__c == 'Comms')
       {  
         project.Primary_QLT_Function_Head__c = 'susan.schramm@nokia.com';//'thiresh.allam@atos.net';
         project.Secondary_QLT_Function_Head__c = 'susan.schramm@nokia.com';//
       }  
       if(project.Primary_QLT_Function__c == 'F&C')            
         project.Primary_QLT_Function_Head__c = 'oliver.simon@nokia.com';//'oliver.simon@nokia.com';
       if(project.Primary_QLT_Function__c == 'GS')            
         project.Primary_QLT_Function_Head__c = 'rakesh.godayal@nokia.com';//'rakesh.godayal@nokia.com';
       if(project.Primary_QLT_Function__c == 'HR')            
         project.Primary_QLT_Function_Head__c = 'sandra.holder@nokia.com';//'sandra.holder@nokia.com';
       if(project.Primary_QLT_Function__c == 'IT')            
         project.Primary_QLT_Function_Head__c = 'tim.todorow@nokia.com';//'tim.todorow@nokia.com';
       if(project.Primary_QLT_Function__c == 'MBB')            
         project.Primary_QLT_Function_Head__c = 'bob.kierzyk@nokia.com';//'bob.kierzyk@nokia.com'; 
       if(project.Primary_QLT_Function__c == 'Ops')            
         project.Primary_QLT_Function_Head__c = 'clinton.hoover@nokia.com';//'clinton.hoover@nokia.com';
       if(project.Primary_QLT_Function__c == 'QMS & Capability')
         project.Primary_QLT_Function_Head__c = 'hannu.jarvelin@nokia.com';//'hannu.jarvelin@nokia.com';
       if(project.Primary_QLT_Function__c == 'Strategy & Planning')
         project.Primary_QLT_Function_Head__c = 'rob.sherwood@nokia.com';//'rob.sherwood@nokia.com';
       if(project.Primary_QLT_Function__c == 'To Be Determined')
         project.Primary_QLT_Function_Head__c = 'mike.patel@nokia.com';//'mike.patel@nokia.com';
                   
         QIPP_Contacts__c EmailForProjectLead = null;
         QIPP_Portfolio__c portfoliodetails = null;
         QIPP_Contacts__c EmailForPortfolioOwner = null;
         
         if(project.Project_Lead__c != null)
         {          
             EmailForProjectLead = [select Email__c from QIPP_Contacts__c where Id =: project.Project_Lead__c ];
             project.Project_Lead_Email_ID__c = EmailForProjectLead.Email__c;
             System.Debug(' ***** EmailForProjectLead***** ' + EmailForProjectLead);
         }
         
         if(project.Portfolio_Name__c != null)
         {
             portfoliodetails = [select Portfolio_Owner__c from QIPP_Portfolio__c where Id =: project.Portfolio_Name__c ];
             System.Debug(' ***** portfoliodetails ***** ' + portfoliodetails );
         }
         
         if(portfoliodetails.Portfolio_Owner__c != null)
         {   
             EmailForPortfolioOwner = [select Email__c from QIPP_Contacts__c where Id =: portfoliodetails.Portfolio_Owner__c ];
             project.Portfolio_Owner_EmailID__c = EmailForPortfolioOwner.Email__c;
             System.Debug(' ***** EmailForPortfolioOwner ***** ' + EmailForPortfolioOwner );
         }
         
                            
         System.Debug(' ***** ELSE project ***** ' + project);
     }
}