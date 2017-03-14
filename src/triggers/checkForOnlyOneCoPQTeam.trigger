trigger checkForOnlyOneCoPQTeam on QIPP_CoPQ_Project_Team__c (before insert , before update, before delete) 
{

        if(Trigger.isDelete){

            List<String> Ids = new List<String>();
            for(QIPP_CoPQ_Project_Team__c triggerOld: Trigger.Old)
            {
            Ids.add(triggerOld.ProjectID__c);
            } 

                List<QIPP_Project__c> updateProject = [ select Id, Project_Lead__c, Finance_Approver__c, Approver_Financial_Approver__c from QIPP_Project__c where Id in : Ids]; 

            for(QIPP_Project__c up: updateProject){
            up.Finance_Approver__c = null;
            }
            update updateProject;
        }

        
    Trigger_Control__c s = Trigger_Control__c.getInstance(UserInfo.getUserId());
    
    system.debug('Run_Triggers__c :::'+s.Run_Triggers__c);
    
    if(s.Run_Triggers__c)
    {
        
        if(Trigger.isInsert || Trigger.isUpdate)
        {

            List<QIPP_CoPQ_Project_Team__c> newTeamMembers = Trigger.New;
            List<QIPP_CoPQ_Project_Team__c> oldTeamMembers = Trigger.Old;

            QIPP_Project__c project = [ select Id , Project_Lead__c,Approver_Financial_Approver__c from QIPP_Project__c where Id =: newTeamMembers[0].ProjectID__c limit 1]; 
            List<QIPP_CoPQ_Project_Team__c> projectteammembers = [ select Id  from QIPP_CoPQ_Project_Team__c where ProjectID__c =: newTeamMembers[0].ProjectID__c limit 1]; 
            System.Debug('************* projectteammembers size *********** ' + projectteammembers.size());

            if(Trigger.isbefore)
            {
                if(Trigger.isInsert)
                {
                    if(projectteammembers != null && projectteammembers.size() > 0)
                    {
                        trigger.new[0].Business_Role_Function__c.addError('Only one project team can be setup for each Project.');    
                    }
                }
                if(Trigger.isUpdate)
                {
                    System.Debug('************** Trigger.isUpdate *****************');
                }


            /***************************************************************************************************************************************************************************************/
                    if(newTeamMembers[0].Business_Owner__c != null)
                    {
                        try
                        {
                       
                        Set<String> BusinessOwnerSet = new Set<String>();
                        
                        for(QIPP_CoPQ_Project_Team__c team : Trigger.new)
                         {
                                    BusinessOwnerSet.add(newTeamMembers[0].Business_Owner__c);
                                    System.Debug('************* newTeamMembers[0].Business_Owner__c ************** ' + newTeamMembers[0].Business_Owner__c);  
                         }
                         
                         List<QIPP_Contacts__c> businessOwnerContact = null;
                               
                                 if(BusinessOwnerSet.size() > 0 && BusinessOwnerSet != null)
                                 {
                                     businessOwnerContact = [Select Name,Email__c from QIPP_Contacts__c where Id IN : BusinessOwnerSet];
                                     System.Debug(' ********** Inside if ********** ' + businessOwnerContact.size()); 
                                 }    

                         List<User> users = null;
                         
                         for(QIPP_CoPQ_Project_Team__c team : Trigger.new)
                                    {   
                                        System.Debug('************ Inside For loop ********** ');   
                                        System.Debug('########### team.CoPQTeamMember__c for loop ############## ' + team.CoPQTeamMember__c);  
                                        
                                        if(businessOwnerContact.size() > 0 &&  businessOwnerContact[0].Email__c != null)
                                        {   
                                            users = [Select Id,Name,Email from User where Email =: businessOwnerContact[0].Email__c];
                                            if(users.size() <= 0 )
                                                Trigger.new[0].CoPQTeamMember__c.addError('Provided Business Owner Contact is not actual Salesforce User');
                                            else
                                            {    
                                                for(User u:users)
                                                {
                                                    if(businessOwnerContact.size()>0)
                                                    {  
                                                      project.DI_Approver_Business_Owner__c = u.Id;
                                                      project.Business_Owner_Email__c = businessOwnerContact[0].Email__c;
                                                      project.Business_Owner_Name__c =  businessOwnerContact[0].Name; 
                                                      team.Business_Owner_Email__c = businessOwnerContact[0].Email__c;
                                                    }
                                                }
                                             }   
                                         }
                                       else
                                        {
                                             project.DI_Approver_Business_Owner__c = null;

                                        }
                                         System.Debug('************ project.DI_Approver_Business_Owner__c ********** ' + project.DI_Approver_Business_Owner__c);
                                         System.Debug('************ project.Business_Owner_Email__c ********** ' + project.Business_Owner_Email__c);
                                             
                                    } 
                          
                          }
                          catch(Exception exe)
                          {
                              System.Debug('************ Exception Occrued ********** ' + exe.getMessage() );
                              System.Debug('************ @ Line Number ********** ' + exe.getLineNumber());
                          }                
                    }
                    else
                    {
                         project.DI_Approver_Business_Owner__c = null;

                    }
                   
            /***************************************************************************************************************************************************************************************/
                    
                    if(newTeamMembers[0].Business_Owner_Delegate__c != null)
                    {
                        try
                        {

                        Set<String> BusinessOwnerDelegateSet = new Set<String>();
                        
                        for(QIPP_CoPQ_Project_Team__c team : Trigger.new)
                         {
                                    BusinessOwnerDelegateSet.add(newTeamMembers[0].Business_Owner_Delegate__c);
                                    System.Debug('************* newTeamMembers[0].Business_Owner_Delegate__c ************** ' + newTeamMembers[0].Business_Owner_Delegate__c);  
                         }
                         
                         List<QIPP_Contacts__c> businessOwnerDelegateContact = null;
                               
                                 if(BusinessOwnerDelegateSet.size() > 0 && BusinessOwnerDelegateSet != null)
                                 {
                                     businessOwnerDelegateContact = [Select Name,Email__c from QIPP_Contacts__c where Id IN : BusinessOwnerDelegateSet];
                                     System.Debug(' ********** Inside if BusinessOwnerDelegate ********** ' + businessOwnerDelegateContact.size()); 
                                 }    

                         List<User> users = null;
                         
                         for(QIPP_CoPQ_Project_Team__c team : Trigger.new)
                                    {   
                                        System.Debug('************ Inside For loop BusinessOwnerDelegate ********** ');   
                                        System.Debug('########### team.CoPQTeamMember__c for loop BusinessOwnerDelegate ############## ' + team.CoPQTeamMember__c);  
                                        
                                        if(businessOwnerDelegateContact.size() > 0 &&  businessOwnerDelegateContact[0].Email__c != null)
                                         {   
                                            users = [Select Id,Name,Email from User where Email =: businessOwnerDelegateContact[0].Email__c];
                                            if(users.size() <= 0 )
                                                Trigger.new[0].CoPQTeamMember__c.addError('Provided Business Owner Delegate Contact is not actual Salesforce User');
                                            else
                                            {    
                                                for(User u:users)
                                                {
                                                    if(businessOwnerDelegateContact.size()>0)
                                                    {  
                                                      project.DI_Approver_Business_Owner_Delegate__c = u.Id;
                                                      project.Business_Owner_Delegate_Email__c = businessOwnerDelegateContact[0].Email__c;
                                                      project.Business_Owner_Delegate_Name__c = businessOwnerDelegateContact[0].Name;
                                                      team.Business_Owner_Delegate_Email__c = businessOwnerDelegateContact[0].Email__c;

                                                     }
                                                }
                                             }   
                                         }
                                        else
                                        {
                                             project.DI_Approver_Business_Owner_Delegate__c = null;

                                        }
                                         System.Debug('************ project.DI_Approver_Business_Owner_Delegate__c ********** ' + project.DI_Approver_Business_Owner_Delegate__c);
                                         System.Debug('************ project.Business_Owner_Delegate_Email__c ********** ' + project.Business_Owner_Delegate_Email__c);
                                    } 
                          }
                          catch(Exception exe)
                          {
                              System.Debug('************ Exception Occrued ********** ' + exe.getMessage() );
                              System.Debug('************ @ Line Number ********** ' + exe.getLineNumber());
                          }                
                    }
                    else
                    {
                         project.DI_Approver_Business_Owner_Delegate__c = null;

                    }
                    
            /***************************************************************************************************************************************************************************************/        
                    
                    if(newTeamMembers[0].Finance_Approver__c != null)
                    {
                        try
                        {
                        project.Finance_Approver__c = newTeamMembers[0].Finance_Approver__c;

                        Set<String> FinanceApproverSet = new Set<String>();
                        
                        for(QIPP_CoPQ_Project_Team__c team : Trigger.new)
                         {
                                    FinanceApproverSet.add(newTeamMembers[0].Finance_Approver__c);
                                    System.Debug('************* newTeamMembers[0].Finance_Approver__c ************** ' + newTeamMembers[0].Finance_Approver__c);  
                         }
                         
                         List<QIPP_Contacts__c> FinanceApproverContact = null;
                               
                                 if(FinanceApproverSet.size() > 0 && FinanceApproverSet != null)
                                 {
                                     FinanceApproverContact = [Select Name,Email__c from QIPP_Contacts__c where Id IN : FinanceApproverSet];
                                     System.Debug(' ********** Inside if FinanceApprover ********** ' + FinanceApproverContact.size()); 
                                 }    

                         List<User> users = null;
                         
                         for(QIPP_CoPQ_Project_Team__c team : Trigger.new)
                                    {   
                                        System.Debug('************ Inside For loop FinanceApprover ********** ');   
                                        System.Debug('########### team.CoPQTeamMember__c for loop FinanceApprover ############## ' + team.CoPQTeamMember__c);  
                                        
                                        if(FinanceApproverContact.size() > 0 &&  FinanceApproverContact[0].Email__c != null)
                                         {   
                                            users = [Select Id,Name,Email from User where Email =: FinanceApproverContact[0].Email__c];
                                            if(users.size() <= 0 )
                                                Trigger.new[0].CoPQTeamMember__c.addError('Provided Finance Approver Contact is not actual Salesforce User');
                                            else
                                            {    
                                                for(User u:users)
                                                {
                                                    if(FinanceApproverContact.size()>0)
                                                    {  
                                                      project.DI_Finance_Approver__c = u.Id;
                                                      project.Email_Finance_Approver__c  = FinanceApproverContact[0].Email__c;
                                                      project.Finance_Approver_Name__c = FinanceApproverContact[0].Name;
                                                      team.Finance_Approver_Email__c  = FinanceApproverContact[0].Email__c;
                                                     }
                                                }
                                             }   
                                         }
                                       else
                                        {
                                             project.DI_Finance_Approver__c = null;

                                        }
                                         System.Debug('************ project.DI_Finance_Approver__c ********** ' + project.DI_Finance_Approver__c);
                                         System.Debug('************ project.Email_Finance_Approver__c ********** ' + project.Email_Finance_Approver__c);
                                    } 
                          }
                          catch(Exception exe)
                          {
                              System.Debug('************ Exception Occrued in project.DI_Finance_Approver__c ********** ' + exe.getMessage() );
                              System.Debug('************ @ Line Number in project.DI_Finance_Approver__c ********** ' + exe.getLineNumber());
                          }  
                    }
                    else
                    {
                         project.DI_Finance_Approver__c = null; //Using Finance Approver instead!!
                         //project.Approver_Financial_Approver__c = null;

                    }

            /***************************************************************************************************************************************************************************************/
                    
                    if(newTeamMembers[0].Finance_Approver_Delegate__c != null)
                    {
                        try
                        {

                        Set<String> FinanceApproverDelegateSet = new Set<String>();
                        
                        for(QIPP_CoPQ_Project_Team__c team : Trigger.new)
                         {
                                    FinanceApproverDelegateSet.add(newTeamMembers[0].Finance_Approver_Delegate__c);
                                    System.Debug('************* newTeamMembers[0].Finance_Approver_Delegate__c ************** ' + newTeamMembers[0].Finance_Approver_Delegate__c);  
                         }
                         
                         List<QIPP_Contacts__c> FinanceApproverDelegateContact = null;
                               
                                 if(FinanceApproverDelegateSet.size() > 0 && FinanceApproverDelegateSet != null)
                                 {
                                     FinanceApproverDelegateContact = [Select Name,Email__c from QIPP_Contacts__c where Id IN : FinanceApproverDelegateSet];
                                     System.Debug(' ********** Inside if FinanceApproverDelegate ********** ' + FinanceApproverDelegateContact.size()); 
                                 }    

                         List<User> users = null;
                         
                         for(QIPP_CoPQ_Project_Team__c team : Trigger.new)
                                    {   
                                        System.Debug('************ Inside For loop FinanceApproverDelegate ********** ');   
                                        System.Debug('########### newTeamMembers[0].Finance_Approver_Delegate__c ############## ' + newTeamMembers[0].Finance_Approver_Delegate__c);  
                                        
                                        if(FinanceApproverDelegateContact.size() > 0 &&  FinanceApproverDelegateContact[0].Email__c != null)
                                         {   
                                            users = [Select Id,Name,Email from User where Email =: FinanceApproverDelegateContact[0].Email__c];
                                            if(users.size() <= 0 )
                                                Trigger.new[0].CoPQTeamMember__c.addError('Provided Finance Approver Delegate Contact is not actual Salesforce User');
                                            else
                                            {    
                                                for(User u:users)
                                                {
                                                    if(FinanceApproverDelegateContact.size()>0)
                                                    {  
                                                      project.DI_Approver_Finance_Approver_Delegate__c = u.Id;
                                                      project.Finance_Approver_Delegate_Email__c  = FinanceApproverDelegateContact[0].Email__c;
                                                      project.Finance_Approver_Delegate_Name__c = FinanceApproverDelegateContact[0].Name;
                                                      team.Finance_Approver_Delegate_Email__c  = FinanceApproverDelegateContact[0].Email__c;
                                                     }
                                                }
                                             }   
                                         }
                                       else
                                        {
                                             project.DI_Approver_Finance_Approver_Delegate__c = null;
                                        }
                                         System.Debug('************ project.DI_Approver_Finance_Approver_Delegate__c ********** ' + project.DI_Approver_Finance_Approver_Delegate__c);
                                         System.Debug('************ project.Finance_Approver_Delegate_Email__c ********** ' + project.Finance_Approver_Delegate_Email__c);
                                    } 
                          }
                          catch(Exception exe)
                          {
                              System.Debug('************ Exception Occrued in DI_Approver_Finance_Approver_Delegate__c ********** ' + exe.getMessage() );
                              System.Debug('************ @ Line Number in DI_Approver_Finance_Approver_Delegate__c ********** ' + exe.getLineNumber());
                          }  
                    }
                    else
                    {
                         project.DI_Approver_Finance_Approver_Delegate__c = null;
                    }
                    

            /***************************************************************************************************************************************************************************************/
                       
                   if(newTeamMembers[0].Q_PMO_Team_Member__c != null)
                    {
                        try
                        {

                        Set<String> QPMOTeamMemberSet = new Set<String>();
                        
                        for(QIPP_CoPQ_Project_Team__c team : Trigger.new)
                         {
                                    QPMOTeamMemberSet.add(newTeamMembers[0].Q_PMO_Team_Member__c);
                                    System.Debug('************* newTeamMembers[0].Q_PMO_Team_Member__c ************** ' + newTeamMembers[0].Q_PMO_Team_Member__c);  
                         }
                         
                         List<QIPP_Contacts__c> QPMOTeamMemberContact = null;
                               
                                 if(QPMOTeamMemberSet.size() > 0 && QPMOTeamMemberSet != null)
                                 {
                                     QPMOTeamMemberContact = [Select Name,Email__c from QIPP_Contacts__c where Id IN : QPMOTeamMemberSet];
                                     System.Debug(' ********** Inside if QPMOTeamMember ********** ' + QPMOTeamMemberContact.size()); 
                                 }    

                         List<User> users = null;
                         
                         for(QIPP_CoPQ_Project_Team__c team : Trigger.new)
                                    {   
                                        System.Debug('************ Inside For loop QPMOTeamMember ********** ');   
                                        System.Debug('########### team.CoPQTeamMember__c for loop QPMOTeamMember ############## ' + team.CoPQTeamMember__c);  
                                        
                                        if(QPMOTeamMemberContact.size() > 0 &&  QPMOTeamMemberContact[0].Email__c != null)
                                         {   
                                            users = [Select Id,Name,Email from User where Email =: QPMOTeamMemberContact[0].Email__c];
                                            if(users.size() <= 0 )
                                                Trigger.new[0].CoPQTeamMember__c.addError('Provided Q PMO Team Member Contact is not actual Salesforce User');
                                            else
                                            {    
                                                for(User u:users)
                                                {
                                                    if(QPMOTeamMemberContact.size()>0)
                                                    {  
                                                      project.DI_Approver_Q_PMO_Team_Member__c = u.Id;
                                                      project.Q_PMO_Team_Member_Email__c  = QPMOTeamMemberContact[0].Email__c;
                                                      project.Q_PMO_Team_Member_Name__c = QPMOTeamMemberContact[0].Name;
                                                      team.Q_PMO_Team_Member_Email__c  = QPMOTeamMemberContact[0].Email__c;
                                                     }
                                                }
                                             }   
                                         }
                                       else
                                        {
                                             project.DI_Approver_Q_PMO_Team_Member__c = null;

                                        }
                                         System.Debug('************ project.DI_Approver_Q_PMO_Team_Member__c ********** ' + project.DI_Approver_Q_PMO_Team_Member__c);
                                         System.Debug('************ project.Q_PMO_Team_Member_Email__c ********** ' + project.Q_PMO_Team_Member_Email__c);
                                    } 
                          }
                          catch(Exception exe)
                          {
                              System.Debug('************ Exception Occrued in project.DI_Approver_Q_PMO_Team_Member__c ********** ' + exe.getMessage() );
                              System.Debug('************ @ Line Number in project.DI_Approver_Q_PMO_Team_Member__c ********** ' + exe.getLineNumber());
                          }  
                    }
                    else
                    {
                         project.DI_Approver_Q_PMO_Team_Member__c = null;

                    }

            /***************************************************************************************************************************************************************************************/
             
                    if(project.Project_Lead__c != null)
                    {
                        try
                        {

                           QIPP_Contacts__c ProjectLeadContact = [Select Name,Email__c from QIPP_Contacts__c where Id =: project.Project_Lead__c];
                           System.Debug(' ********** Inside if ProjectLeadContact ********** ' + ProjectLeadContact); 

                          List<User> users = [Select Id,Name,Email from User where Email =: ProjectLeadContact.Email__c];
                          if(users.size() <= 0 )
                                  Trigger.new[0].CoPQTeamMember__c.addError('Provided Project Lead Contact is not actual Salesforce User');
                           else
                                {    
                                   if(users.size()>0)
                                   { 
                                   for(User u:users)
                                        {  
                                            project.DI_Approver_Project_Lead_Manager__c = u.Id;
                                            project.Project_Lead_Email_ID__c = u.Email;
                                            project.Project_Lead_Name__c = u.Name;
                                            project.Project_Lead_Email_ID__c = u.Email;
                                         }
                                    }
                                }   
                              System.Debug('************ project.DI_Approver_Project_Lead_Manager__c ********** ' + project.DI_Approver_Project_Lead_Manager__c);
                              System.Debug('************ project.Project_Lead_Email_ID__c ********** ' + project.Project_Lead_Email_ID__c);
                          }
                          catch(Exception exe)
                          {
                              System.Debug('************ Exception Occrued in project.DI_Approver_Project_Lead_Manager__c ********** ' + exe.getMessage() );
                              System.Debug('************ @ Line Number in project.DI_Approver_Project_Lead_Manager__c ********** ' + exe.getLineNumber());
                          }  
                    }

            /***************************************************************************************************************************************************************************************/
             
                  if(newTeamMembers[0].Measure_Creator__c != null)
                    {
                        try
                        {

                        Set<String> MeasureCreatorTeamMemberSet = new Set<String>();
                        
                        for(QIPP_CoPQ_Project_Team__c team : Trigger.new)
                         {
                                    MeasureCreatorTeamMemberSet.add(newTeamMembers[0].Measure_Creator__c);
                                    System.Debug('************* newTeamMembers[0].Measure_Creator__c ************** ' + newTeamMembers[0].Measure_Creator__c);  
                         }
                         
                         List<QIPP_Contacts__c> MeasureCreatorTeamMemberContact = null;
                               
                                 if(MeasureCreatorTeamMemberSet.size() > 0 && MeasureCreatorTeamMemberSet != null)
                                 {
                                     MeasureCreatorTeamMemberContact = [Select Name,Email__c from QIPP_Contacts__c where Id IN : MeasureCreatorTeamMemberSet];
                                     System.Debug(' ********** Inside if MeasureCreatorTeamMemberContact ********** ' + MeasureCreatorTeamMemberContact.size()); 
                                 }    

                         //List<User> users = null;
                         
                         for(QIPP_CoPQ_Project_Team__c team : Trigger.new)
                                    {   
                                        
                                        if(MeasureCreatorTeamMemberContact.size() > 0 &&  MeasureCreatorTeamMemberContact[0].Email__c != null)
                                         {   
                                            
                                            project.Measure_Creator_Email__c  = MeasureCreatorTeamMemberContact[0].Email__c;
                                            team.Measure_Creator_Email__c  = MeasureCreatorTeamMemberContact[0].Email__c;
                                            
                                            /*
                                            users = [Select Id,Name,Email from User where Email =: MeasureCreatorTeamMemberContact[0].Email__c];
                                            if(users.size() <= 0 )
                                                Trigger.new[0].CoPQTeamMember__c.addError('Provided Measure Creator Team Member Contact is not actual Salesforce User');
                                            else
                                            {    
                                                for(User u:users)
                                                {
                                                    if(MeasureCreatorTeamMemberContact.size()>0)
                                                    {  
                                                      project.Measure_Creator_Email__c  = MeasureCreatorTeamMemberContact[0].Email__c;
                                                      team.Measure_Creator_Email__c  = MeasureCreatorTeamMemberContact[0].Email__c;
                                                    }
                                                }
                                             } 

                                            */
                                         }
                                       else
                                        {
                                             project.Measure_Creator_Email__c = null;
                                        }
                                         System.Debug('************ project.DI_Approver_Q_PMO_Team_Member__c ********** ' + project.DI_Approver_Q_PMO_Team_Member__c);
                                         System.Debug('************ project.Q_PMO_Team_Member_Email__c ********** ' + project.Q_PMO_Team_Member_Email__c);
                                    } 
                          }
                          catch(Exception exe)
                          {
                              System.Debug('************ Exception Occrued in project.DI_Approver_Q_PMO_Team_Member__c ********** ' + exe.getMessage() );
                              System.Debug('************ @ Line Number in project.DI_Approver_Q_PMO_Team_Member__c ********** ' + exe.getLineNumber());
                          }  
                    }
                    else
                    {
                         project.Measure_Creator_Email__c = null;
                    }

            /***************************************************************************************************************************************************************************************/
            /***************************************************************************************************************************************************************************************/
             
                  if(newTeamMembers[0].BL_Transformation_Lead__c != null)
                    {
                        try
                        {

                            Set<String> BLTransformationTeamMemberSet = new Set<String>();
                            
                            for(QIPP_CoPQ_Project_Team__c team : Trigger.new)
                            {
                                        BLTransformationTeamMemberSet.add(newTeamMembers[0].BL_Transformation_Lead__c);
                                        System.Debug('************* newTeamMembers[0].BL_Transformation_Lead__c ************** ' + newTeamMembers[0].BL_Transformation_Lead__c);  
                            }
                             
                            List<QIPP_Contacts__c> BLTransformationTeamMemberContact = null;
                       
                            if(BLTransformationTeamMemberSet.size() > 0 && BLTransformationTeamMemberSet != null)
                            {
                                 BLTransformationTeamMemberContact = [Select Name,Email__c from QIPP_Contacts__c where Id IN : BLTransformationTeamMemberSet];
                                 System.Debug(' ********** Inside if BLTransformationTeamMemberContact ********** ' + BLTransformationTeamMemberContact.size()); 
                            }    

                            //List<User> users = null;
                 
                            for(QIPP_CoPQ_Project_Team__c team : Trigger.new)
                            {                               
                                if(BLTransformationTeamMemberContact.size() > 0 &&  BLTransformationTeamMemberContact[0].Email__c != null)
                                {   
                                    project.BL_Transformation_Lead_Email__c  = BLTransformationTeamMemberContact[0].Email__c;
                                    team.BL_Transformation_Lead_Email__c = BLTransformationTeamMemberContact[0].Email__c;
                                    
                                    /*
                                    users = [Select Id,Name,Email from User where Email =: BLTransformationTeamMemberContact[0].Email__c];
                                    if(users.size() <= 0 )
                                        Trigger.new[0].CoPQTeamMember__c.addError('Provided BL Transformation Team Member Contact is not actual Salesforce User');
                                    else
                                    {    
                                        for(User u:users)
                                        {
                                            if(BLTransformationTeamMemberContact.size()>0)
                                            {  
                                              project.BL_Transformation_Lead_Email__c  = BLTransformationTeamMemberContact[0].Email__c;
                                              team.BL_Transformation_Lead_Email__c = BLTransformationTeamMemberContact[0].Email__c;
                                            }
                                        }
                                    } 
                                    */
                                }
                                else
                                {
                                     project.BL_Transformation_Lead_Email__c = null;
                                }
                                System.Debug('************ project.BL_Transformation_Lead_Email__c ********** ' + project.BL_Transformation_Lead_Email__c);
                               
                                System.Debug('************ team.BL_Transformation_Lead__c ********** ' + team.BL_Transformation_Lead__c);
                                  
                            } 
                        }
                        catch(Exception exe)
                        {
                          System.Debug('************ Exception Occrued in project.BL_Transformation_Lead_Email__c ********** ' + exe.getMessage() );
                          System.Debug('************ @ Line Number in project.BL_Transformation_Lead_Email__c ********** ' + exe.getLineNumber());
                        }  
                    }
                    else
                    {
                         project.BL_Transformation_Lead_Email__c = null;         
                    }
                                
            /***************************************************************************************************************************************************************************************/


                if(Trigger.isInsert)
                {
                      upsert project;
                }
               else
                      update project;
                       
                        System.Debug('************ project ********** ' + project);      


            //if(Trigger.isbefore)

                for(QIPP_CoPQ_Project_Team__c team1 : Trigger.new)
                {
                    if(team1.BL_Transformation_Lead__c == null)
                    {
                        team1.BL_Transformation_Lead_Email__c = '';
                    }
                    if(team1.Business_Owner__c == null)
                    {
                        team1.Business_Owner_Email__c = '';
                    }
                    if(team1.Business_Owner_Delegate__c == null)
                    {
                        team1.Business_Owner_Delegate_Email__c = '';
                    }
                    if(team1.Finance_Approver__c == null)
                    {
                        team1.Finance_Approver_Email__c = '';
                    }
                    if(team1.Finance_Approver_Delegate__c == null)
                    {
                        team1.Finance_Approver_Delegate_Email__c = '';
                    }
                    if(team1.Measure_Creator__c == null)
                    {
                        team1.Measure_Creator_Email__c = '';
                    }
                    if(team1.Q_PMO_Team_Member__c == null)
                    {
                        team1.Q_PMO_Team_Member_Email__c = '';
                    }
                }

            }
        }
    }

}