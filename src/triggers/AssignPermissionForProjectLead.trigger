trigger AssignPermissionForProjectLead on QIPP_Project__c (after insert , after update , before delete)
{
    List<QIPP_Project__c>  project  = Trigger.New;
    List<QIPP_Project__c>  oldproject  = Trigger.old;
    
    List<QIPP_Project__Share> sharing = new List<QIPP_Project__Share>();
    List<QIPP_Project__Share> sharing1 = new List<QIPP_Project__Share>();
    
    QIPP_Contacts__c ContactName = null;
    List<User> userpresence = null;
    List<User> userpresence1 = null;
    List<QIPP_Contacts__c> portfolioOwnerName =  null;
    
    Trigger_Control__c s = Trigger_Control__c.getInstance(UserInfo.getUserId());
    //system.debug('Run_Triggers__c :::'+s.Run_Triggers__c);
    if(s.Run_Triggers__c)
    {
        if(TriggerHelper.checkRecursive3())
        {
        if(!Trigger.isDelete &&  !Trigger.isUpdate)
        {
            
            try
            {
            
                if(project[0].Project_Lead__c != null)
                   ContactName = [Select Name FROM QIPP_Contacts__c where Id =: project[0].Project_Lead__c];
                //System.Debug('************* Project_Lead ************ ' +ContactName );
                
                if(ContactName.Name != null) 
                   userpresence = [select Id , Name , Profile.Name FROM User where Name  =: ContactName.Name] ;
                //System.Debug('************* userpresence************ ' + userpresence.size());

                QIPP_Portfolio__c portfolioOwnerID =  [select  Portfolio_Owner__c from QIPP_Portfolio__c where Id =: project[0].Portfolio_Name__c ];
                //System.Debug('************* portfolioOwnerID ************ ' +portfolioOwnerID );

                if(portfolioOwnerID != null)
                {
                   portfolioOwnerName = [SELECT Name from QIPP_Contacts__c where Id =: portfolioOwnerID.Portfolio_Owner__c];
                   //System.Debug('************* portfolioOwnerName ************ ' +portfolioOwnerName );
                }    

                if( portfolioOwnerName!= null) 
                {
                   if(portfolioOwnerName[0].Name != null)
                     userpresence1 = [select Id , Name , Profile.Name FROM User where Name  =:  portfolioOwnerName[0].Name] ;
                     //System.Debug('************* userpresence1 ************ ' + userpresence1.size());
                }
                
                
                
                for(QIPP_Project__c p : project) 
                {
                   
                   if(userpresence != null)
                   {
                       if(userpresence.size() > 0)
                       {
                       
                            //System.Debug('************* project lead ID ************ ' + userpresence[0].Id);
                            //System.Debug('************* project ID ************ ' + project[0].ownerid);
                            
                            if(userpresence[0].Id == project[0].ownerid)
                            continue;
                                    
                            QIPP_Project__Share shar = new QIPP_Project__Share();
                            shar.ParentId = project[0].Id;
                            Id assignId = userpresence[0].Id;
                            shar.UserorGroupId = assignId;
                            shar.AccessLevel = 'Edit';
                            shar.RowCause = Schema.QIPP_Project__Share.RowCause.Project_Lead__c;
                            if(shar != null)
                            sharing.add(shar);
                       }
                   }
                  
                   if(userpresence1 != null)
                   {
                       if(userpresence1.size() > 0)
                       {
                            //System.Debug('************* portfolioOwner ID ************ ' + userpresence1[0].Id);
                            //System.Debug('************* project ownwr ID ************ ' + project[0].ownerid);
                          
                          if(userpresence1[0].Id == project[0].ownerid)
                          continue;
                               
                          QIPP_Project__Share shar1 = new QIPP_Project__Share();
                          
                          shar1.ParentId = project[0].Id;     // record id
                          Id assignId = userpresence1[0].Id;    
                          shar1.UserorGroupId = assignId;   // Project lead (user id)
                          shar1.AccessLevel = 'Edit';       // Access level 
                          shar1.RowCause = Schema.QIPP_Project__Share.RowCause.Project_Lead__c; // Sharing Rule Reason
                          if(shar1 != null)                          
                          sharing1.add(shar1);
                       }
                   }
                }
                
                If(sharing != null & sharing.size() > 0)
                {
                    insert sharing;
                }
                If(sharing1 != null & sharing1.size() > 0)
                {
                    insert sharing1;
                }
                
            

            } 
            catch(Exception exe)
            {
                //System.Debug(' ****************************EXCEPTION OCCURES ****************************' + exe.getMessage());
                //System.Debug(' ****************************EXCEPTION OCCURES @ Line Number ****************************' + exe.getLineNumber());
            }

            
            
        }  
       
       
        if(Trigger.isUpdate)
        {   
            //******** start update Apex Managed Sharing rule
             //System.Debug(project[0].Project_Lead__c+'***Yes ****'+oldproject[0].Project_Lead__c);
            try
            { 
                //if(project[0].Project_Lead__c != oldproject[0].Project_Lead__c)
                if(project[0].Project_Lead__c != null)
                {
                  //System.Debug('****Yes = NotEqual **** ');
                  
                    if(project[0].Project_Lead__c != null)
                       ContactName = [Select Name FROM QIPP_Contacts__c where Id =: project[0].Project_Lead__c];
                    //System.Debug('************* Project_Lead ************ ' +ContactName );
                    
                    if(ContactName.Name != null) 
                       userpresence = [select Id , Name , Profile.Name FROM User where Name  =: ContactName.Name] ;
                    //System.Debug('************* userpresence************ ' + userpresence.size());

                    QIPP_Portfolio__c portfolioOwnerID =  [select  Portfolio_Owner__c from QIPP_Portfolio__c where Id =: project[0].Portfolio_Name__c ];
                    //System.Debug('************* portfolioOwnerID ************ ' +portfolioOwnerID );

                    if(portfolioOwnerID != null)
                    {
                       portfolioOwnerName = [SELECT Name from QIPP_Contacts__c where Id =: portfolioOwnerID.Portfolio_Owner__c];
                       //System.Debug('************* portfolioOwnerName ************ ' +portfolioOwnerName );
                    }    

                    if( portfolioOwnerName!= null) 
                    {
                       if(portfolioOwnerName[0].Name != null)
                         userpresence1 = [select Id , Name , Profile.Name FROM User where Name  =:  portfolioOwnerName[0].Name] ;
                         //System.Debug('************* userpresence1 ************ ' + userpresence1.size());
                    }
                    
                    
                    List<QIPP_Project__Share> sharesToDelete = [SELECT Id,ParentId  FROM QIPP_Project__Share WHERE ParentId =: project[0].id AND RowCause = 'Project_Lead__c'];
                    
                    if(!sharesToDelete.isEmpty()){
                        Delete sharesToDelete;
                    }
                            
                    for(QIPP_Project__c p : project) 
                    {
                       
                       if(userpresence != null)
                       {
                           if(userpresence.size() > 0)
                           {
                           
                                //System.Debug('************* project lead ID ************ ' + userpresence[0].Id);
                                //System.Debug('************* project ID ************ ' + project[0].ownerid);
                                
                                if(userpresence[0].Id == project[0].ownerid)
                                continue;
                                        
                                QIPP_Project__Share shar = new QIPP_Project__Share();
                                shar.ParentId = project[0].Id;
                                Id assignId = userpresence[0].Id;
                                shar.UserorGroupId = assignId;
                                shar.AccessLevel = 'Edit';
                                shar.RowCause = Schema.QIPP_Project__Share.RowCause.Project_Lead__c;
                                if(shar != null)
                                sharing.add(shar);
                           }
                       }
                      
                       if(userpresence1 != null)
                       {
                           if(userpresence1.size() > 0)
                           {
                                //System.Debug('************* portfolioOwner ID ************ ' + userpresence1[0].Id);
                                //System.Debug('************* project ownwr ID ************ ' + project[0].ownerid);
                              
                              if(userpresence1[0].Id == project[0].ownerid)
                              continue;
                                   
                              QIPP_Project__Share shar1 = new QIPP_Project__Share();
                              
                              shar1.ParentId = project[0].Id;     // record id
                              Id assignId = userpresence1[0].Id;    
                              shar1.UserorGroupId = assignId;   // Project lead (user id)
                              shar1.AccessLevel = 'Edit';       // Access level 
                              shar1.RowCause = Schema.QIPP_Project__Share.RowCause.Project_Lead__c; // Sharing Rule Reason
                              if(shar1 != null)                          
                              sharing1.add(shar1);
                           }
                       }
                    }
                    
                    If(sharing != null & sharing.size() > 0)
                    {
                        insert sharing;
                    }
                    If(sharing1 != null & sharing1.size() > 0)
                    {
                        insert sharing1;
                    }
                  
                }
            } 
            catch(Exception exe)
            {
                //System.Debug(' ****************************EXCEPTION OCCURES ****************************' + exe.getMessage());
                //System.Debug(' ****************************EXCEPTION OCCURES @ Line Number ****************************' + exe.getLineNumber());
            }

            //******** End update Apex Managed Sharing rule
            
            //System.Debug('$$$$$$$$$$$$$ in Updated Trigger $$$$$$$$$$$$$ '); 

            Integer BU_Report_Count = [select Count() from QIPP_BU_Reporting__c];

            List<QIPP_BU_Reporting__c>  BUReporting = [select Benefitting_Project_BL_Level_4_Org__c , Project_Lead_BU__c , Project_Lead_BL_Level_3_Org__c , Project_Lead_BL_Level_4_Org__c , DI_State__c , Project_Number__c , Project_Name__c , Portfolio_Name__c ,  Benefitting_BL__c  
                                                       from QIPP_BU_Reporting__c where  Project_ID__c =: project[0].Id  
                                                       Limit : BU_Report_Count];
                                                       
            List<QIPP_BU_Reporting__c>  UpdateBU = new  List<QIPP_BU_Reporting__c>();   
            List<QIPP_Project__c> pro = [select Belt_Project_Type__c , Benefitting_Project_BL_Level_4_Org__c ,Project_Lead_Business_Grp__c,Project_Lead_Business_Unit__c,Project_Lead_Business_Line__c, Project_Lead_BU__c , Project_Lead_BL_Level_3_Org__c , Project_Lead_BL_Level_4_Org__c , DI_State__c , Project_Number__c  , Portfolio_Name__c from QIPP_Project__c where Id =: project[0].Id];
            List<QIPP_Portfolio__c> pronew = [select Portfolio_Business_Unit__c , Name from QIPP_Portfolio__c where Id =: pro[0].Portfolio_Name__c];

            for(QIPP_BU_Reporting__c bu : BUReporting )
            {
            
                if(project[0].Project_Name_Succinct__c != oldproject[0].Project_Name_Succinct__c)
                    bu.Project_Name__c = project[0].Project_Name_Succinct__c;
                
                if(project[0].Project_BL__c != oldproject[0].Project_BL__c)    
                   bu.Benefitting_BL__c = project[0].Project_BL__c;

                if(project[0].Benefitting_Project_BL_Level_4_Org__c != oldproject[0].Benefitting_Project_BL_Level_4_Org__c)    
                   bu.Benefitting_Project_BL_Level_4_Org__c = project[0].Benefitting_Project_BL_Level_4_Org__c;
                
                if(project[0].Project_Lead_Business_Grp__c != oldproject[0].Project_Lead_Business_Grp__c)    
                   bu.Project_Lead_BU__c = project[0].Project_Lead_Business_Grp__c;

                if(project[0].Project_Lead_Business_Unit__c != oldproject[0].Project_Lead_Business_Unit__c)    
                   bu.Project_Lead_BL_Level_3_Org__c = project[0].Project_Lead_Business_Unit__c;

                if(project[0].Project_Lead_Business_Line__c != oldproject[0].Project_Lead_Business_Line__c)    
                   bu.Project_Lead_BL_Level_4_Org__c = project[0].Project_Lead_Business_Line__c;
                
                /*
                if(project[0].Project_Lead_BU__c != oldproject[0].Project_Lead_BU__c)    
                   bu.Project_Lead_BU__c = project[0].Project_Lead_BU__c;

                if(project[0].Project_Lead_BL_Level_3_Org__c != oldproject[0].Project_Lead_BL_Level_3_Org__c)    
                   bu.Project_Lead_BL_Level_3_Org__c = project[0].Project_Lead_BL_Level_3_Org__c;

                if(project[0].Project_Lead_BL_Level_4_Org__c != oldproject[0].Project_Lead_BL_Level_4_Org__c)    
                   bu.Project_Lead_BL_Level_4_Org__c = project[0].Project_Lead_BL_Level_4_Org__c;
                */
                if(project[0].DI_State__c != oldproject[0].DI_State__c)    
                   bu.DI_State__c = project[0].DI_State__c;

                if(project[0].Project_Number__c != oldproject[0].Project_Number__c)    
                   bu.Project_Number__c = project[0].Project_Number__c;

                if(project[0].Project_Type__c != oldproject[0].Project_Type__c)    
                   bu.QI_Methodology__c = project[0].Project_Type__c;

                if(project[0].Belt_Project_Type__c != oldproject[0].Belt_Project_Type__c)    
                   bu.Belt_Project_Type__c = project[0].Belt_Project_Type__c;


                bu.Portfolio_Name__c = pronew[0].Name;
                bu.Benefitting_BU__c = pronew[0].Portfolio_Business_Unit__c ;
                //System.Debug(' ****************************BU****************************' +  BU);
                UpdateBU.add(bu);
            }    
             update UpdateBU;    
        } 

        if(Trigger.isDelete)
        {
            try
            {
                //System.Debug(' ****************************Trigger.isDelete****************************' +  oldproject[0].Id); 
                Integer Limit_DelBen = [select count() from QIPP_Benefit__c where Project_ID__c =: oldproject[0].Id];
                List<QIPP_Benefit__c> delBen = [select ID from QIPP_Benefit__c where Project_ID__c =: oldproject[0].Id  Limit : Limit_DelBen ];
                List<QIPP_BU_Reporting__c> delBU = new List<QIPP_BU_Reporting__c>();
                for(QIPP_Benefit__c db : delBen)
                {
                delBU = [select ID from QIPP_BU_Reporting__c where  Benefit_ID__c =: db.Id ];
                if(delBU != null && delBU.size() > 0)
                    delete delBU ;
                }
                //System.Debug(' ****************************delBU ****************************' +  delBU.size()); 
                //System.Debug(' ****************************delben****************************' +  delben.size()); 

                if(delben != null && delben.size() > 0)
                delete delben;
            }
            catch(Exception exe)
            {
              //System.Debug(' ****************************Exception occured in AssignPermissionForProjectLead ****************************' +  exe.getMessage()); 
              //System.Debug(' ****************************Exception occured in AssignPermissionForProjectLead ****************************' +  exe.getLineNumber()); 
            }  
        }
        }

    }   
}