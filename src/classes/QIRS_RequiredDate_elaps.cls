Global class QIRS_RequiredDate_elaps implements Schedulable
{
     
  
    global void execute (SchedulableContext SC)
     {
            date myDate = date.today();
            date newDate = mydate.addDays(-1);
           List<QIRS_Action_Plan__c> APlist= new List<QIRS_Action_Plan__c>();
           APlist = [Select id from QIRS_Action_Plan__c where Status__c =: 'Pending for Champion'
           and Required_date__c =: newDate];
           if(APlist.size()>0)
           {
           
               for (Integer j=0;j<APlist.size();j++)
               { 
                   APlist[j].Expired_Date_Flag__c=true;
               }
                update APlist;
           }
           date newDate1 = mydate.addDays(-8);
            //date newDate1 = mydate.addDays(-2);
   List<QIRS_Action_Plan__c> APlist1= new List<QIRS_Action_Plan__c>();
           APlist1 = [Select id from QIRS_Action_Plan__c where Status__c =: 'Pending for Champion'
           and Required_date__c =: newDate1];
           if(APlist1.size()>0)
           {
               for (Integer j=0;j<APlist1.size();j++)
               { 
                   APlist1[j].Expired_Date_Flag__c=true;
               }
                update APlist1;
           }

           date newDate2 = mydate.addDays(-3);
           List<QIRS_Action_Plan__c> APlist2= new List<QIRS_Action_Plan__c>();
           APlist2 = [Select id from QIRS_Action_Plan__c where Status__c =: 'Pending for Champion'
           and Required_date__c =: newDate2];
           if(APlist2.size()>0)
           {
               for (Integer j=0;j<APlist2.size();j++)
               { 
                   APlist2[j].Expired_Date_Flag__c=true;
               }
                update APlist2;
           }

            
    }
      static testMethod void testQIRS_RequiredDate_elaps()
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
           
           objqirs.Impacted_Region__c = 'Asia';           
           objqirs.Countries__c = 'China';           
             insert objqirs;   
                List<QIRS__c> lstQirs = new List<QIRS__c>();             
             lstQirs.add(objqirs);      
        date myDate = date.today();
      date newDate = mydate.addDays(-1);
         QIRS_Action_Plan__c objAP1 = new QIRS_Action_Plan__c();
         objAP1.Action_Plan_Counter__c = 1;
         objAP1.Action_Type__c = 'Containment';
         objAP1.Approver__c = 'TestApp';
         objAP1.Approver1__c = UserInfo.getUserId();
         objAP1.Approver10__c = UserInfo.getUserId();
         objAP1.Approver2__c = UserInfo.getUserId();
         objAP1.Approver3__c = UserInfo.getUserId();
         objAP1.Approver4__c = UserInfo.getUserId();
         objAP1.Approver5__c =UserInfo.getUserId();
         objAP1.Approver6__c =UserInfo.getUserId();
         objAP1.Approver7__c =UserInfo.getUserId();
         objAP1.Approver8__c =UserInfo.getUserId();
         objAP1.Approver9__c =UserInfo.getUserId();
         objAP1.Champion__c = 'TestChamp';
         objAP1.Champion1__c = UserInfo.getUserId();
         objAP1.Champion10__c = UserInfo.getUserId();
         objAP1.Champion2__c = UserInfo.getUserId();
         objAP1.Champion3__c = UserInfo.getUserId();
         objAP1.Champion4__c = UserInfo.getUserId();
         objAP1.Champion5__c =UserInfo.getUserId();
         objAP1.Champion6__c =UserInfo.getUserId();
         objAP1.Champion7__c =UserInfo.getUserId();
         objAP1.Champion8__c =UserInfo.getUserId();
         objAP1.Champion9__c =UserInfo.getUserId();
         objAP1.QIRS__c =objqirs.ID;         
         objAP1.Task__c ='Test Task';
         objAP1.Status__c ='Pending for Champion';
         objAP1.Required_date__c  = newDate;  
         objAP1.Implementation_Date__c = Date.Today();  
         insert objAP1;
         
          date myDate1 = date.today();
      date newDate1 = mydate.addDays(-3);
         QIRS_Action_Plan__c objAP2 = new QIRS_Action_Plan__c();
         objAP2.Action_Plan_Counter__c = 1;
         objAP2.Action_Type__c = 'Containment';
         objAP2.Approver__c = 'TestApp';
         objAP2.Approver1__c = UserInfo.getUserId();
         objAP2.Approver10__c = UserInfo.getUserId();
         objAP2.Approver2__c = UserInfo.getUserId();
         objAP2.Approver3__c = UserInfo.getUserId();
         objAP2.Approver4__c = UserInfo.getUserId();
         objAP2.Approver5__c =UserInfo.getUserId();
         objAP2.Approver6__c =UserInfo.getUserId();
         objAP2.Approver7__c =UserInfo.getUserId();
         objAP2.Approver8__c =UserInfo.getUserId();
         objAP2.Approver9__c =UserInfo.getUserId();
         objAP2.Champion__c = 'TestChamp';
         objAP2.Champion1__c = UserInfo.getUserId();
         objAP2.Champion10__c = UserInfo.getUserId();
         objAP2.Champion2__c = UserInfo.getUserId();
         objAP2.Champion3__c = UserInfo.getUserId();
         objAP2.Champion4__c = UserInfo.getUserId();
         objAP2.Champion5__c =UserInfo.getUserId();
         objAP2.Champion6__c =UserInfo.getUserId();
         objAP2.Champion7__c =UserInfo.getUserId();
         objAP2.Champion8__c =UserInfo.getUserId();
         objAP2.Champion9__c =UserInfo.getUserId();
         objAP2.QIRS__c =objqirs.ID;         
         objAP2.Task__c ='Test Task';
         objAP2.Status__c ='Pending for Champion';
         objAP2.Required_date__c  = newDate1;  
         objAP2.Implementation_Date__c = Date.Today();  
         insert objAP2;
         
         QIRS_RequiredDate_elaps controller = new QIRS_RequiredDate_elaps(); 
          SchedulableContext sc;
          List<QIRS_Action_Plan__c> APlist1= new List<QIRS_Action_Plan__c>();
          APlist1.Add(objAP1);
          controller.execute(sc);  
          List<QIRS_Action_Plan__c> APlist2= new List<QIRS_Action_Plan__c>();
          APlist2.Add(objAP2);
          controller.execute(sc);  
          
          //controller.APlist=APlist1; 
          
     }
}