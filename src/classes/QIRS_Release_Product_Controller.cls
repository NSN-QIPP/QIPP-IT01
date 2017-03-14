global class QIRS_Release_Product_Controller
{
 
 WebService Static Boolean CanceledAP1(String AP_id){
     Boolean result = false;
          List<QIRS_Action_Plan__c> objAP = new List<QIRS_Action_Plan__c>(); 
           objAP = [select ID from QIRS_Action_Plan__c where Id =: AP_id 
           and  ( Champion1__c =: UserInfo.getUserId() or Champion2__c =: UserInfo.getUserId() or
                    Champion3__c =: UserInfo.getUserId() or Champion4__c =: UserInfo.getUserId() or
                    Champion5__c =: UserInfo.getUserId() or Champion6__c =: UserInfo.getUserId() or
                    Champion7__c =: UserInfo.getUserId() or Champion8__c =: UserInfo.getUserId() or
                    Champion9__c =: UserInfo.getUserId() or Champion10__c =: UserInfo.getUserId() )];
                    if(objAP.size() > 0)
                      return result; 
                    else{
                        result = true;
                        return result;
                    }   
                    
                
 }
 
 Public Boolean CanceledAP(string AP_id)
      {
          Boolean result = false;
          List<QIRS_Action_Plan__c> objAP = new List<QIRS_Action_Plan__c>(); 
           objAP = [select ID from QIRS_Action_Plan__c where Id =: AP_id 
           and  ( Champion1__c =: UserInfo.getUserId() or Champion2__c =: UserInfo.getUserId() or
                    Champion3__c =: UserInfo.getUserId() or Champion4__c =: UserInfo.getUserId() or
                    Champion5__c =: UserInfo.getUserId() or Champion6__c =: UserInfo.getUserId() or
                    Champion7__c =: UserInfo.getUserId() or Champion8__c =: UserInfo.getUserId() or
                    Champion9__c =: UserInfo.getUserId() or Champion10__c =: UserInfo.getUserId() or
                    Approver1__c =: UserInfo.getUserId() or Approver2__c =: UserInfo.getUserId() or
                    Approver3__c =: UserInfo.getUserId() or Approver4__c =: UserInfo.getUserId() or
                    Approver5__c =: UserInfo.getUserId() or Approver6__c =: UserInfo.getUserId() or
                    Approver7__c =: UserInfo.getUserId() or Approver8__c =: UserInfo.getUserId() or
                    Approver9__c =: UserInfo.getUserId() or Approver10__c =: UserInfo.getUserId()  )];
                    if(objAP.size() > 0)
                    {
                      result =false; 
                       //return result;    
                    }
                
                 objAP = [select IsRecall__c,IsChampChange__c,IsApproverChange__c, ActionPlanDelayedFlag__c, ActionPlanExpiredFlag__c, ManagerEsclationFlag__c, Action_Plan_Counter__c,Implementation_Comment__c,Core_ID__c,ID, Name, Task__c,Action_Type__c,Implementation_Date__c, Approver__c,Champion__c,
                 QIRS__c,Reason1__c,Required_date__c,Status__c, 
                 Approver1__c,Approver2__c,Approver3__c,Approver4__c,Approver5__c,Approver6__c,Approver7__c,Approver8__c,Approver9__c,Approver10__c,
                 Champion1__c,Champion2__c,Champion3__c,Champion4__c,Champion5__c,Champion6__c,Champion7__c,Champion8__c,Champion9__c,Champion10__c,
                 CreatedByID,QIRS__r.Process_Owner1__c
                 from QIRS_Action_Plan__c where Id =: AP_id];
                   if(objAP.size() > 0)
                    {
                      String AdminProfileID ='';
                      List<Profile> tprofile = [SELECT id FROM Profile p WHERE p.name = 'Nokia QIRS Admin'];
                      if(tprofile.size()>0)
                      {
                          AdminProfileID =tprofile[0].id;
                            if(UserInfo.getProfileId() == AdminProfileID)
                            {
                                 result =true;
                                 
                            }
                      }
                     if(UserInfo.getUserId() == objAP[0].CreatedByID) 
                      {
                         result =true;                        
                      }
                       id caseowner = [select Process_Owner1__c from QIRS__c where id =:  objAP[0].QIRS__c].Process_Owner1__c;
                       system.debug('**************'+UserInfo.getUserId()+'*********'+caseowner);
                       
                      if(UserInfo.getUserId() == caseowner)
                      {
                          result =true;
                      }                       
                      system.debug('************result*********'+result);
                      if(result)
                      {
                        //objAP[0].RecordTypeId = [select Id from RecordType 
                        //where SObjectType='QIRS_Action_Plan__c' 
                        //and Name='QIRS_Action_Plan_witout_Cancel' limit 1].id;
                        
                        objAP[0].Status__c  = 'Canceled';
                        objAP[0].Status_Date1__c = Date.Today();
                        objAP[0].IsAPCanceled__c = true;
                        //objAP[0].RecordTypeId = [SELECT Id FROM RecordType WHERE Name =: 'QIRS_Action_Plan_without_Cancel'].id;
                        //objAP[0].RecordTypeId = rcdType.id;
                        update objAP;
                        string email = [select email from user where id =: caseowner].email;
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(objAP[0].CreatedByID);
                        mail.setTemplateId([select id from EmailTemplate where Name =: 'QIRS_AP_status_Canceled_caseowner' ].id);
                        mail.setToAddresses(new string[]{email});
                        mail.saveAsActivity = false;
                        mail.setWhatId(objAP[0].id);
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                      }      
                    }       
                  
                     /*   objAP[0].Re_Submit__c = true;
                        objAP[0].Status__c  = 'Implemented by champion';
                        objAP[0].Status_Date1__c = Date.Today();
                        objAP[0].IsSenttoAPP__c = true;
                        update objAP;
                  
                        */
                      system.debug('********objAP[0]**************'+objAP);  
                      return result;       
                  
                    
          
      }
      
  WebService static Boolean ReSubmited(string AP_id)
      {
          Boolean result = false;
          List<QIRS_Action_Plan__c> objAP = new List<QIRS_Action_Plan__c>(); 
           objAP = [select IsSenttoAPP__c,Status_Date1__c,Re_Submit__c,Status__c from QIRS_Action_Plan__c where Id =: AP_id 
           and Status__c =: 'Rejected' 
           and  ( Champion1__c =: UserInfo.getUserId() or Champion2__c =: UserInfo.getUserId() or
                    Champion3__c =: UserInfo.getUserId() or Champion4__c =: UserInfo.getUserId() or
                    Champion5__c =: UserInfo.getUserId() or Champion6__c =: UserInfo.getUserId() or
                    Champion7__c =: UserInfo.getUserId() or Champion8__c =: UserInfo.getUserId() or
                    Champion9__c =: UserInfo.getUserId() or Champion10__c =: UserInfo.getUserId() )];
                    if(objAP.size() > 0)
                    {
                        objAP[0].Re_Submit__c = true;
                        objAP[0].Status__c  = 'Implemented by champion';
                        objAP[0].Status_Date1__c = Date.Today();
                        objAP[0].IsSenttoAPP__c = true;
                        update objAP;
                  
                        
                        result =true;                        
                    }
                    else
                    {
                        result =false;
                    }
          return result;
      }
      
     WebService static String ReleaseProduct(string QIRS_id)
      {
          String result = '0';
            List<QIRS_Action_Plan__c> qirsAP = new List<QIRS_Action_Plan__c>();
            qirsAP =  [select ID, Name, Action_Type__c,Approver__c,Champion__c
                  ,QIRS__c,Reason1__c,Required_date__c,Status__c from QIRS_Action_Plan__c
                    where QIRS__r.Id =: QIRS_id and Action_Type__c =: QIRSBasecontroller.BaseVarContainmentActionType
                    and Status__c =: QIRSBasecontroller.BaseVarQIRSAPClosed];
                    if(qirsAP.size() > 0)
                    {
                     List<QIRS_Product_Identification__c> 
                     qirsproduct = new List<QIRS_Product_Identification__c>();
                     
                       qirsproduct= [select QIRS__c,Release_Product__c,Name,Product_Name__c,
                       Technology__c from QIRS_Product_Identification__c where QIRS__c =: QIRS_id];   
                        if(qirsproduct.size() == 0)           
                        {
                            result = '2';
                        }
                        // Update QIRS status Open to lifted
                       
                       // result =true;
                    }
                    else
                    {
                        result ='1';
                        //alert
                    }
        return result;
      }
      
      WebService static Boolean Reopen(string QIRS_id)
      {
          Boolean result = false;
          List<QIRS__c> qirs = new List<QIRS__c>();
          qirs =  [select ID,Business__c,Site1__c, Reopen__c,Name, Alert_Type__c,Business_Group__c,Status__c from QIRS__c where Id =: QIRS_id];
                    if(qirs.size() > 0)
                    {
                        qirs[0].Status__c = QIRSBasecontroller.BaseVarQIRSOpen; //'Open';
                        qirs[0].Reopen__c = true;
                        update qirs;
                        result =true;                        
                    }
                    else
                    {
                        result =false;
                    }
                       
                       List<String> SiteList = new List<String>();
                       SiteList.add(qirs[0].Site1__c);
                       Boolean bresult = QIRSBasecontroller.SendEmail(SiteList, qirs[0].Business__c, qirs[0].Alert_Type__c,qirs[0].Business_Group__c, 'ReOpen',qirs[0].Id);

          return result;
      }
      
      WebService static Boolean StopProduct(string QIRS_id)
      {
          Boolean result = false;
           List<QIRS_Product_Identification__c> objQIRSReleaseProduct = new List<QIRS_Product_Identification__c>();
                           objQIRSReleaseProduct = [select QIRS__r.Name,QIRS__c,ClassAccess__c,
                         Release_Product__c,Name,Product_Name__c,Technology__c
                         from QIRS_Product_Identification__c where QIRS__c =: QIRS_id ];
                         string updateReleaseProduct ='';
                        for(Integer i = 0; i < objQIRSReleaseProduct.size(); i++)
                        {
                            objQIRSReleaseProduct[i].Release_Product__c=false;
                            objQIRSReleaseProduct[i].ClassAccess__c=true;
                            
                             if(i == 0)
                             {
                                 updateReleaseProduct = objQIRSReleaseProduct[i].Name;
                             }
                             else
                             {
                                updateReleaseProduct = updateReleaseProduct + '; ' + objQIRSReleaseProduct[i].Name;
                             }
                        }
                             update objQIRSReleaseProduct;
          List<QIRS__c> qirs = new List<QIRS__c>();
          qirs =  [select ID, Product_PN__c,View_Product_Name__c,View_Release_Product__c,Lock_Points_SH_Shipping__c,Reopen__c, Name, Alert_Type__c,Status__c from QIRS__c
                    where Id =: QIRS_id and Status__c =: QIRSBasecontroller.BaseVarQIRSLifted];
                    if(qirs.size() > 0)
                    {
                        qirs[0].Status__c = QIRSBasecontroller.BaseVarQIRSOpen; //'Open';
                        qirs[0].Alert_Type__c = QIRSBasecontroller.BaseVarSSAlertType;
                        qirs[0].Issue_Level__c = QIRSBasecontroller.BaseVarStopBuildIL;
                        qirs[0].Lock_Points_SH_Shipping__c = false;
                        qirs[0].View_Release_Product__c = ''; 
                        qirs[0].Product_PN__c =updateReleaseProduct; 
                        if(qirs[0].Reopen__c)
                        qirs[0].Reopen__c = false;                        
                        update qirs;
                       
                         
                         
                    
                        result =true;                        
                    }
                    else
                    {
                        result =false;
                    }

          return result;
      }
      
//       WebService static Boolean SendCreateEmail(String Business,String BusinessGroup, String Targetid)
       WebService static Boolean SendCreateEmail(String Business,String BusinessGroup,String Targetid)
      {
       //Boolean result = false;
       //return result; 
          QIRS__c q = [SELECT Id FROM QIRS__c WHERE Id =: Targetid];
          RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Master Record' LIMIT 1];
          q.RecordTypeId = rt.Id;
          q.New_Record_Notification__c = 'Email notification has been sent for this QIRS record';            
          update q;
          return  QIRSBasecontroller.SendEmail(null, Business,null, BusinessGroup,'Create',Targetid);
      }
 static testMethod void testQIRS_Release_Product_Controller()
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
            //objqirs.Status__c = 'Lifted';  
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
         objAP1.Status__c ='Rejected';
         objAP1.Required_date__c  = newDate;  
         objAP1.Implementation_Date__c = Date.Today();  
         insert objAP1;
         
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
         objAP2.Status__c ='Pending For Champion';
         objAP2.Required_date__c  = newDate;  
         objAP2.Implementation_Date__c = Date.Today();  
         insert objAP2;
         
         
         
         QIRS_Product_Identification__c objpi = new QIRS_Product_Identification__c();
             objpi.ClassAccess__c = true;
             objpi.Product_Name__c = 'Test';
             objpi.Release_Product__c =true;
             objpi.Technology__c = 'test';
             objpi.QIRS__c = objqirs.Id;
             objpi.Name__c = 'test';
             insert objpi;
              QIRS_Product_Identification__c objpi1 = new QIRS_Product_Identification__c();
             objpi1.ClassAccess__c = true;
             objpi1.Product_Name__c = 'Test';
             objpi1.Release_Product__c =true;
             objpi1.Technology__c = 'test';
               objpi1.Name__c = 'test';
             objpi1.QIRS__c = objqirs.Id;
             insert objpi1;
             List<QIRS_Product_Identification__c> lstPI = new List<QIRS_Product_Identification__c>();             
             lstPI.add(objpi1); 
              lstPI.add(objpi); 
         //Boolean result;
        
        QIRS_Release_Product_Controller obj = new QIRS_Release_Product_Controller();
        obj.CanceledAP(objAP1.id);

         Boolean TempResub = ReSubmited(objAP1.Id);
         String TempRelease = ReleaseProduct(objqirs.ID);
         Boolean TempReopen = Reopen(objqirs.ID);
         Boolean TempStopPro = StopProduct(objqirs.ID);
         Boolean TempSend = SendCreateEmail('Network System','CDMA',objqirs.ID);
         
     }
 }