public class QIRS_AP_DelegateTask_Controller 
{ 
   public PageReference GetData() 
    {
         UserID = objAP.Employee_User_ID__c;
         bdesable = false;
        return null;
    }

 
    public String CurrentID1 {get; set;} 
    public List<QIRS_Action_Plan__c> accpetedactionplanQirs  {get; set;} 
    public String Type {get; set;} 
    public String UserID {get; set;} 
    public String QIRS_Action_plan_Tag {get; set;}
    public QIRS_Action_Plan__c objAP{get;set;}
    public boolean bvisible {get; set;}
    public boolean bdesable {get; set;}    
    public boolean Approve_Flag {get; set;}
    public boolean Reassign_Flag {get; set;}
    public QIRS_AP_DelegateTask_Controller() 
        {
                Type = System.currentPagereference().getParameters().get('type');
                objAP = new QIRS_Action_Plan__c();
                Approve_Flag = false;
                Reassign_Flag = true;
                 
                if(Type == 'dmtask')
                {
                    QIRS_Action_plan_Tag = 'Delegate My Actions';
                    UserID = UserInfo.getUserId();
                    bvisible = false;
                    bdesable = false;                   
                }
                else
                {
                    QIRS_Action_plan_Tag = 'Delegate employees actions';
                    bvisible = true;
                    bdesable = true;
                }
                
        }
    public PageReference cancel() 
    {
        PageReference pageRef = new PageReference('/apex/QIRS_HomePage?save_new=1&sfdc.override=1');
        pageRef.setRedirect(true);
        return pageRef;
    }

public boolean ValidateChampApprover(String strValidateID, String StrID1,String StrID2,String StrID3,String StrID4,
    String StrID5,String StrID6,String StrID7,String StrID8,String StrID9,String StrID10,
    String StrAppID11,String StrAppID12,String StrAppID13,String StrAppID14,
    String StrAppID15,String StrAppID16,String StrAppID17,String StrAppID18,String StrAppID19,String StrAppID20)
    {
        boolean result = false;
        if(strValidateID  ==  StrID1)
        {
            result = true;
        }
        else if(!result)
        { 
            if(strValidateID  ==  StrID2)
            {
                result = true;
            }
            else if(!result)
            {    
                if(strValidateID  == StrID3)
                {
                    result = true;
                }
                else if(!result)
                {
                    if(strValidateID  == StrID4)
                    {
                        result = true;
                    }
                    else if(!result)
                    {
                        if(strValidateID  ==  StrID5)
                        {
                            result = true;
                        }
                        else if(!result)
                        {
                            if(strValidateID  ==  StrID6)
                            {
                                result = true;
                            }
                            else if(!result)
                            {
                                if(strValidateID  ==  StrID7)
                                {
                                    result = true;
                                }
                                else if(!result)
                                {
                                    if(strValidateID  ==  StrID8)
                                    {
                                        result = true;
                                    }
                                    else if(!result)
                                    {
                                          if(strValidateID  ==  StrID9)
                                          {
                                              result = true;
                                          }
                                          else if(!result)
                                          {
                                             if(strValidateID  ==  StrID10)
                                              {
                                                  result = true;
                                              }
                                          }
                                    }
                                 }
                             }
                            }
                        
                        }
                    }
            }
        }
        
        if(strValidateID  ==  StrAppID11)
        {
            result = true;
        }
        else if(!result)
        { 
            if(strValidateID  ==  StrAppID12)
            {
                result = true;
            }
            else if(!result)
            {    
                if(strValidateID  == StrAppID13)
                {
                    result = true;
                }
                else if(!result)
                {
                    if(strValidateID  == StrAppID14)
                    {
                        result = true;
                    }
                    else if(!result)
                    {
                        if(strValidateID  ==  StrAppID15)
                        {
                            result = true;
                        }
                        else if(!result)
                        {
                            if(strValidateID  ==  StrAppID16)
                            {
                                result = true;
                            }
                            else if(!result)
                            {
                                if(strValidateID  ==  StrAppID17)
                                {
                                    result = true;
                                }
                                else if(!result)
                                {
                                    if(strValidateID  ==  StrAppID18)
                                    {
                                        result = true;
                                    }
                                    else if(!result)
                                    {
                                          if(strValidateID  ==  StrAppID19)
                                          {
                                              result = true;
                                          }
                                          else if(!result)
                                          {
                                             if(strValidateID  ==  StrAppID20)
                                              {
                                                  result = true;
                                              }
                                          }
                                    }
                                 }
                             }
                            }
                        
                        }
                    }
            }
        }
        return result;
    }
    public PageReference Save() {
         try
        {
            boolean berror = false;
            String partialURL = '';
            String strChampion = '';
            String strApprover = '';             
            for (Integer j=0;j<accpetedactionplanQirs.size();j++)
              {
                  if(accpetedactionplanQirs[j].Reassign__c != UserID)
                  {
                       if(!ValidateChampApprover(accpetedactionplanQirs[j].Reassign__c,accpetedactionplanQirs[j].Champion1__c,accpetedactionplanQirs[j].Champion2__c,accpetedactionplanQirs[j].Champion3__c,accpetedactionplanQirs[j].Champion4__c,accpetedactionplanQirs[j].Champion5__c,
                        accpetedactionplanQirs[j].Champion6__c,accpetedactionplanQirs[j].Champion7__c,accpetedactionplanQirs[j].Champion8__c,accpetedactionplanQirs[j].Champion9__c,accpetedactionplanQirs[j].Champion10__c,
                        accpetedactionplanQirs[j].Approver1__c,accpetedactionplanQirs[j].Approver2__c,accpetedactionplanQirs[j].Approver3__c,accpetedactionplanQirs[j].Approver4__c,accpetedactionplanQirs[j].Approver5__c,
                        accpetedactionplanQirs[j].Approver6__c,accpetedactionplanQirs[j].Approver7__c,accpetedactionplanQirs[j].Approver8__c,accpetedactionplanQirs[j].Approver9__c,accpetedactionplanQirs[j].Approver10__c))
                        {
                           berror  = false;
                        }  
                        else
                        {
                           berror  = true;
                           break;
                        }
                  }
               }
               if(!berror) 
               {
                   for (Integer j=0;j<accpetedactionplanQirs.size();j++)
                  {
                   
                   if(accpetedactionplanQirs[j].Reassign__c != UserID)
                    { 
                      if(UserID == accpetedactionplanQirs[j].Champion1__c)
                    {
                        accpetedactionplanQirs[j].Champion1__c = accpetedactionplanQirs[j].Reassign__c;
                    }
                    if(UserID == accpetedactionplanQirs[j].Champion2__c)
                    {
                        accpetedactionplanQirs[j].Champion2__c =accpetedactionplanQirs[j].Reassign__c;
                    
                    }
                    if(UserID == accpetedactionplanQirs[j].Champion3__c)
                    {
                        accpetedactionplanQirs[j].Champion3__c =accpetedactionplanQirs[j].Reassign__c;
                    }
                
                    if(UserID == accpetedactionplanQirs[j].Champion4__c)
                    {
                    accpetedactionplanQirs[j].Champion4__c =accpetedactionplanQirs[j].Reassign__c;
                    }
                    if(UserID == accpetedactionplanQirs[j].Champion5__c)
                    {
                        accpetedactionplanQirs[j].Champion5__c =accpetedactionplanQirs[j].Reassign__c;
                    }
                    if(UserID == accpetedactionplanQirs[j].Champion6__c)
                    {
                        accpetedactionplanQirs[j].Champion6__c =accpetedactionplanQirs[j].Reassign__c;
                    
                    }
                
                    if(UserID == accpetedactionplanQirs[j].Champion7__c)
                    {
                        accpetedactionplanQirs[j].Champion7__c =accpetedactionplanQirs[j].Reassign__c;
                    
                    }
                    if(UserID == accpetedactionplanQirs[j].Champion8__c)
                    {
                        accpetedactionplanQirs[j].Champion8__c =accpetedactionplanQirs[j].Reassign__c;
                    
                    }
                    if(UserID == accpetedactionplanQirs[j].Champion9__c)
                    {
                        accpetedactionplanQirs[j].Champion9__c =accpetedactionplanQirs[j].Reassign__c;
                    
                    }
                    if(UserID == accpetedactionplanQirs[j].Champion10__c)
                    {
                        accpetedactionplanQirs[j].Champion10__c =accpetedactionplanQirs[j].Reassign__c;
                    
                    }
                    strChampion = UserName(accpetedactionplanQirs[j].Champion1__c);
                    if(accpetedactionplanQirs[j].Champion1__c != accpetedactionplanQirs[j].Champion2__c)
                    {
                        strChampion =strChampion + '; ' + UserName(accpetedactionplanQirs[j].Champion2__c);
                    }
                    if(accpetedactionplanQirs[j].Champion2__c != accpetedactionplanQirs[j].Champion3__c)
                    {
                        strChampion =strChampion + '; ' +  UserName(accpetedactionplanQirs[j].Champion3__c);
                    }
                    if(accpetedactionplanQirs[j].Champion3__c != accpetedactionplanQirs[j].Champion4__c)
                    {
                        strChampion =strChampion + '; ' +  UserName(accpetedactionplanQirs[j].Champion4__c);
                    }
                    if(accpetedactionplanQirs[j].Champion4__c != accpetedactionplanQirs[j].Champion5__c)
                    {
                        strChampion =strChampion + '; ' +  UserName(accpetedactionplanQirs[j].Champion5__c);
                    }
                    if(accpetedactionplanQirs[j].Champion5__c != accpetedactionplanQirs[j].Champion6__c)
                    {
                        strChampion =strChampion + '; ' +  UserName(accpetedactionplanQirs[j].Champion6__c);
                    }
                    if(accpetedactionplanQirs[j].Champion6__c != accpetedactionplanQirs[j].Champion7__c)
                    {
                        strChampion =strChampion + '; ' +  UserName(accpetedactionplanQirs[j].Champion7__c);
                    }
                    if(accpetedactionplanQirs[j].Champion7__c != accpetedactionplanQirs[j].Champion8__c)
                    {
                        strChampion =strChampion + '; ' +  UserName(accpetedactionplanQirs[j].Champion8__c);
                    }
                    if(accpetedactionplanQirs[j].Champion8__c != accpetedactionplanQirs[j].Champion9__c)
                    {
                        strChampion =strChampion + '; ' +  UserName(accpetedactionplanQirs[j].Champion9__c);
                    }
                    if(accpetedactionplanQirs[j].Champion9__c != accpetedactionplanQirs[j].Champion10__c)
                    {
                        strChampion =strChampion + '; ' +  UserName(accpetedactionplanQirs[j].Champion10__c);
                    }                             
                    accpetedactionplanQirs[j].Champion__c =strChampion;           
                  
                   
                   
                   
                   
                   boolean IsApproverUpdate = false;
                   
                   if(accpetedactionplanQirs[j].Reassign__c != UserID)
                    { 
                      if(UserID == accpetedactionplanQirs[j].Approver1__c)
                    {
                        accpetedactionplanQirs[j].Approver1__c = accpetedactionplanQirs[j].Reassign__c;
                        IsApproverUpdate =true;
                    }
                    if(UserID == accpetedactionplanQirs[j].Approver2__c)
                    {
                        accpetedactionplanQirs[j].Approver2__c =accpetedactionplanQirs[j].Reassign__c;
                        IsApproverUpdate =true;
                    }
                    if(UserID == accpetedactionplanQirs[j].Approver3__c)
                    {
                        accpetedactionplanQirs[j].Approver3__c =accpetedactionplanQirs[j].Reassign__c;
                        IsApproverUpdate =true;
                    }
                
                    if(UserID == accpetedactionplanQirs[j].Approver4__c)
                    {
                    accpetedactionplanQirs[j].Approver4__c =accpetedactionplanQirs[j].Reassign__c;
                    IsApproverUpdate =true;
                    }
                    if(UserID == accpetedactionplanQirs[j].Approver5__c)
                    {
                        accpetedactionplanQirs[j].Approver5__c =accpetedactionplanQirs[j].Reassign__c;
                        IsApproverUpdate =true;
                    }
                    if(UserID == accpetedactionplanQirs[j].Approver6__c)
                    {
                        accpetedactionplanQirs[j].Approver6__c =accpetedactionplanQirs[j].Reassign__c;
                        IsApproverUpdate =true;
                    
                    }
                
                    if(UserID == accpetedactionplanQirs[j].Approver7__c)
                    {
                        accpetedactionplanQirs[j].Approver7__c =accpetedactionplanQirs[j].Reassign__c;
                        IsApproverUpdate =true;
                    
                    }
                    if(UserID == accpetedactionplanQirs[j].Approver8__c)
                    {
                        accpetedactionplanQirs[j].Approver8__c =accpetedactionplanQirs[j].Reassign__c;
                        IsApproverUpdate =true;
                    }
                    if(UserID == accpetedactionplanQirs[j].Approver9__c)
                    {
                        accpetedactionplanQirs[j].Approver9__c =accpetedactionplanQirs[j].Reassign__c;
                        IsApproverUpdate =true;
                    
                    }
                    if(UserID == accpetedactionplanQirs[j].Approver10__c)
                    {
                        accpetedactionplanQirs[j].Approver10__c =accpetedactionplanQirs[j].Reassign__c;
                        IsApproverUpdate =true;
                    
                    }
                    strApprover = UserName(accpetedactionplanQirs[j].Approver1__c);
                    if(accpetedactionplanQirs[j].Approver1__c != accpetedactionplanQirs[j].Approver2__c)
                    {
                        strApprover =strApprover + '; ' + UserName(accpetedactionplanQirs[j].Approver2__c);
                    }
                    if(accpetedactionplanQirs[j].Approver2__c != accpetedactionplanQirs[j].Approver3__c)
                    {
                        strApprover =strApprover + '; ' +  UserName(accpetedactionplanQirs[j].Approver3__c);
                    }
                    if(accpetedactionplanQirs[j].Approver3__c != accpetedactionplanQirs[j].Approver4__c)
                    {
                        strApprover =strApprover + '; ' +  UserName(accpetedactionplanQirs[j].Approver4__c);
                    }
                    if(accpetedactionplanQirs[j].Approver4__c != accpetedactionplanQirs[j].Approver5__c)
                    {
                        strApprover =strApprover + '; ' +  UserName(accpetedactionplanQirs[j].Approver5__c);
                    }
                    if(accpetedactionplanQirs[j].Approver5__c != accpetedactionplanQirs[j].Approver6__c)
                    {
                        strApprover =strApprover + '; ' +  UserName(accpetedactionplanQirs[j].Approver6__c);
                    }
                    if(accpetedactionplanQirs[j].Approver6__c != accpetedactionplanQirs[j].Approver7__c)
                    {
                        strApprover =strApprover + '; ' +  UserName(accpetedactionplanQirs[j].Approver7__c);
                    }
                    if(accpetedactionplanQirs[j].Approver7__c != accpetedactionplanQirs[j].Approver8__c)
                    {
                        strApprover =strApprover + '; ' +  UserName(accpetedactionplanQirs[j].Approver8__c);
                    }
                    if(accpetedactionplanQirs[j].Approver8__c != accpetedactionplanQirs[j].Approver9__c)
                    {
                        strApprover =strApprover + '; ' +  UserName(accpetedactionplanQirs[j].Approver9__c);
                    }
                    if(accpetedactionplanQirs[j].Approver9__c != accpetedactionplanQirs[j].Approver10__c)
                    {
                        strApprover =strApprover + '; ' +  UserName(accpetedactionplanQirs[j].Approver10__c);
                    }                             
                    accpetedactionplanQirs[j].Approver__c =strApprover;           
                    if(IsApproverUpdate)
                    {
                         List<ProcessInstanceWorkItem> workItemList1 =
                         [Select p.ProcessInstance.Status, p.ProcessInstance.TargetObjectId,p.ProcessInstanceId
                         ,p.OriginalActorId,p.Id,p.ActorId From ProcessInstanceWorkitem p
                          where p.ProcessInstance.TargetObjectId = :accpetedactionplanQirs[j].ID 
                          and (p.OriginalActorId =: UserID or p.ActorId =: UserID ) ];
                       if(workItemList1.size()>0)
                       {
                           workItemList1[0].ActorId = accpetedactionplanQirs[j].Reassign__c;
                           update workItemList1;
                       }
                    }
                   }
                   update accpetedactionplanQirs[j];
                    }
                  }
                  
               }
               else
               {
                    
                     ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,'Action plan approver and champion cannot be same.')); 
               }
        }
        catch(System.DmlException ex)
        {
            ApexPages.addMessages(ex); 
        }
        return null;
    }

  public string UserName(string id)
    {
        string TempName ='';
        List<User> a = new List<User>();
        a = [select Id, Name from User WHERE User.id =: id];
        if(a.size()>0)
        TempName = a[0].Name;
        return TempName;
    }
 

 public List<QIRS_Action_Plan__c> getPendingTask() 
      {
              if(Type == 'dmtask')
                {
                    UserID = UserInfo.getUserId();
                }
                
                  accpetedactionplanQirs = [select Employee_User_ID__c,CreatedById,Reassign__c,Delegate_task__c,Name, Implementation_Comment__c,Implementation_Date__c,CreatedBy.Name,Action_Type__c,Approver__c,Champion__c
            ,QIRS__c,Reason1__c,Required_date__c,Status__c,
            Champion1__c,Champion2__c,Champion3__c,Champion4__c,Champion5__c,Champion6__c,Champion7__c,Champion8__c,Champion9__c,Champion10__c,
            Champion1__r.Name,Champion2__r.Name,Champion3__r.Name,Champion4__r.Name,Champion5__r.Name,Champion6__r.Name,Champion7__r.Name,Champion8__r.Name,Champion9__r.Name,Champion10__r.Name,
            Approver1__c,Approver2__c,Approver3__c,Approver4__c,Approver5__c,Approver6__c,Approver7__c,Approver8__c,Approver9__c,Approver10__c,
            Approver1__r.Name,Approver2__r.Name,Approver3__r.Name,Approver4__r.Name,Approver5__r.Name,Approver6__r.Name,Approver7__r.Name,Approver8__r.Name,Approver9__r.Name,Approver10__r.Name                                       
                from QIRS_Action_Plan__c where 
                (( Champion1__c =: UserID or Champion2__c =: UserID or
                Champion3__c =: UserID or Champion4__c =: UserID or
                Champion5__c =: UserID or Champion6__c =: UserID or
                Champion7__c =: UserID or Champion8__c =: UserID or
                Champion9__c =: UserID or Champion10__c =: UserID ) 
                and Status__c =: QIRSBasecontroller.BaseVarPendingforChampion) or 
                (( Approver1__c =: UserID or Approver2__c =: UserID or
                    Approver3__c =: UserID or Approver4__c =: UserID or
                    Approver5__c =: UserID or Approver6__c =: UserID or
                    Approver7__c =: UserID or Approver8__c =: UserID or
                    Approver9__c =: UserID or Approver10__c =: UserID ) 
                and Status__c =: QIRSBasecontroller.BaseVarImplementedbyChampion)
                order by Name desc];
                
                for (Integer j=0;j<accpetedactionplanQirs.size();j++)
                  {
                    if(UserID == accpetedactionplanQirs[j].Champion1__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = true;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Champion1__c;
                        //accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Champion1__r.Name;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Champion2__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = true;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Champion2__c;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Champion3__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = true;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Champion3__c;                        
                    }
                
                    if(UserID == accpetedactionplanQirs[j].Champion4__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = true;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Champion4__c;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Champion5__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = true;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Champion5__c;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Champion6__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = true;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Champion6__c;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Champion7__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = true;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Champion7__c;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Champion8__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = true;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Champion8__c;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Champion9__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = true;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Champion9__c;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Champion10__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = true;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Champion10__c;                        
                    }
                    
                    
                    if(UserID == accpetedactionplanQirs[j].Approver1__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = false;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Approver1__c;
                        //accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Approver1__r.Name;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Approver2__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = false;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Approver2__c;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Approver3__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = false;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Approver3__c;                        
                    }
                
                    if(UserID == accpetedactionplanQirs[j].Approver4__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = false;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Approver4__c;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Approver5__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = false;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Approver5__c;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Approver6__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = false;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Approver6__c;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Approver7__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = false;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Approver7__c;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Approver8__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = false;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Approver8__c;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Approver9__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = false;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Approver9__c;                        
                    }
                    if(UserID == accpetedactionplanQirs[j].Approver10__c)
                    {
                        accpetedactionplanQirs[j].Delegate_task__c = false;
                        accpetedactionplanQirs[j].Reassign__c =accpetedactionplanQirs[j].Approver10__c;                        
                    }
                    
                    
                  }

                    
                return accpetedactionplanQirs ;
      }
     static testMethod void testQIRS_AP_DelegateTask_Controller()
     { List<String> strNSNQIRS =new List<String>();
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
         objAP1.Required_date__c  = Date.Today();  
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
         objAP2.Required_date__c  = Date.Today();  
         objAP2.Implementation_Date__c = Date.Today();  
            insert objAP2;   
              List<QIRS_Action_Plan__c> objAP11= new List<QIRS_Action_Plan__c>();             
             objAP11.add(objAP1);   
          List<QIRS_Action_Plan__c> objAP12= new List<QIRS_Action_Plan__c>();             
             objAP12.add(objAP2);               
         QIRS_AP_DelegateTask_Controller controller = new QIRS_AP_DelegateTask_Controller();
         
         controller.CurrentID1 = objAP1.Id;
         controller.accpetedactionplanQirs= objAP11;
         controller.Type= 'dmtask';
         controller.UserID =UserInfo.getUserId();
         controller.QIRS_Action_plan_Tag='Delegate My Actions';
         controller.objAP=objAP1;
         controller.bvisible=true;
         controller.bdesable=true;
         controller.Approve_Flag=true;
         controller.Reassign_Flag=true;
    controller.GetData();
   String userid = UserInfo.getUserId();
    boolean testresult = controller.ValidateChampApprover(userid, userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid,
     userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid);
     boolean testresult1 = controller.ValidateChampApprover(userlist[0].Id, userid,userlist[0].Id,userid,userid,
     userid,userid,userid,userid,userid,userid,
     userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid);
      boolean testresult2 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userlist[0].Id,userid,
     userid,userid,userid,userid,userid,userid,
     userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid);
      boolean testresult3 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userlist[0].Id,
     userid,userid,userid,userid,userid,userid,
     userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid);
     
     boolean testresult4 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userlist[0].Id,userid,userid,userid,userid,userid,
     userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid);
     
     boolean testresult5 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userid,userlist[0].Id,userid,userid,userid,userid,
     userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid);
     
     boolean testresult6 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userid,userid,userlist[0].Id,userid,userid,userid,
     userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid);
     
          boolean testresult7 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userid,userid,userid,userlist[0].Id,userid,userid,
     userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid);
     
          boolean testresult8 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userid,userid,userid,userid,userlist[0].Id,userid,
     userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid);
     
          boolean testresult9 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userlist[0].Id,
     userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid);
          boolean testresult10 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid,
     userlist[0].Id,userid,userid,userid,
     userid,userid,userid,userid,userid,userid);
          boolean testresult11 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid,
     userid,userlist[0].Id,userid,userid,
     userid,userid,userid,userid,userid,userid);
          boolean testresult12= controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid,
     userid,userid,userlist[0].Id,userid,
     userid,userid,userid,userid,userid,userid);     
          boolean testresult13 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid,
     userid,userid,userid,userlist[0].Id,
     userid,userid,userid,userid,userid,userid);  
               boolean testresult14 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid,
     userid,userid,userid,userid,
     userlist[0].Id,userid,userid,userid,userid,userid); 
               boolean testresult15 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid,
     userid,userid,userid,userid,
     userid,userlist[0].Id,userid,userid,userid,userid); 
               boolean testresult16 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid,
     userid,userid,userid,userid,
     userid,userid,userlist[0].Id,userid,userid,userid); 
               boolean testresult17 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid,
     userid,userid,userid,userid,
     userid,userid,userid,userlist[0].Id,userid,userid); 
               boolean testresult18 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid,
     userid,userid,userid,userid,
     userid,userid,userid,userid,userlist[0].Id,userid); 
               boolean testresult19 = controller.ValidateChampApprover(userlist[0].Id, userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userid,
     userid,userid,userid,userid,
     userid,userid,userid,userid,userid,userlist[0].Id);  
     
     string str = controller.UserName(userid);
     controller.Type= 'dmtask';
     controller.getPendingTask();             
     controller.accpetedactionplanQirs= objAP12;
     controller.Save();
     }
}