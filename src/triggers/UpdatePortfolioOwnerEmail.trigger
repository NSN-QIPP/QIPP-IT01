/*
    Class/Triger Name : UpdatePortfolioOwnerEmail
    Test Class Name   : UpdatePortfolioOwnerEmail_Test
    Author            : XXXX-XXXXXX
    Created Date      : 08.MAY.2013
    Purpose/Overview  : 
        ********************************************************************************************************************         
        01) Updateing email fields based on related QIPP_Contact record
        02) Updateing the fields( 'Project State Dates' section) based on project state value when ever changes
        03) 
    
        ********************************************************************************************************************  
    Change History    : 
        ********************************************************************************************************************         
        SNo : Modified Date :  Developer Name(Company Name)  : Method/Section Modified/Added : Purpose/Overview of Change
        ********************************************************************************************************************  
        01  : 08.MAY.2013   :  XXX-XXX(XXXX)  :   Trigger Created  :
        02  : 06.JULY.2015  :  Srikanth V(IGATE) : Trigger Modified : Updateing the fields( 'Project State Dates' section) based on project state value when ever changes
        03  : 
        
    Notes :
        ********************************************************************************************************************         
        01) 
        02)
    
*/

trigger UpdatePortfolioOwnerEmail on QIPP_Project__c(After insert,After update){

    if(Trigger.isAfter){
        if(TriggerHelper.checkRecursive2()){
            Trigger_Control__c s = Trigger_Control__c.getInstance(UserInfo.getUserId());
            //system.debug('Run_Triggers__c :::'+s.Run_Triggers__c);
            if(s.Run_Triggers__c){  
                list<QIPP_Project__c> newvalues = [select id,Project_State__c,Workflow_Updated__c,Workflow_Updated2__c,Workflow_Update3__c,Project_Number__c,Project_Lead__c,Project_Lead__r.Full_Name__c,Project_Lead__r.Email__c,Project_Lead_Email_ID__c,Portfolio_Name__c,Portfolio_Name__r.Portfolio_Owner__c,Portfolio_Name__r.Portfolio_Owner__r.Email__c,Portfolio_Owner_EmailID__c,Belt_Assigned__c,Belt_Assigned_Email_ID__c,Belt_Assigned__r.Email__c,Project_Member1__c,Project_Member_1_Email_ID__c,Project_Member1__r.Email__c,Project_Member2__c,Project_Member_2_Email_ID__c,Project_Member2__r.Email__c,Canceled_Date__c,Closed_Date__c,In_Progress_Date__c,Not_Started_Date__c,On_Hold_Date__c, (select id,Project_ID__c,Project_Lead__c,Email_Project_Lead__c  from Benefits__r) from QIPP_Project__c where id in :Trigger.NewMap.keyset()];
                
                list<QIPP_Project__c> updatevalues = new list<QIPP_Project__c>();
                list<QIPP_Benefit__c> Updatebenefits = new list<QIPP_Benefit__c>();

                for(QIPP_Project__c newproject : newvalues){
                    //For global search
                    newproject.ProjectIdGlobalSearch__c = newproject.Project_Number__c;
                    //Project Lead Email
                    if(newproject.Project_Lead__c != null){          
                        newproject.Project_Lead_Email_ID__c = newproject.Project_Lead__r.Email__c;
                    }else
                        newproject.Project_Lead_Email_ID__c = null;
                    //Project Portfolio Email
                    if(newproject.Portfolio_Name__c != null){
                        If(newproject.Portfolio_Name__r.Portfolio_Owner__c != null)
                        newproject.Portfolio_Owner_EmailID__c = newproject.Portfolio_Name__r.Portfolio_Owner__r.Email__c;
                    }else
                    newproject.Portfolio_Owner_EmailID__c = null;
                    //Project L6S Belt Assigned Email
                    if(newproject.Belt_Assigned__c != null){
                        newproject.Belt_Assigned_Email_ID__c = newproject.Belt_Assigned__r.Email__c;
                    }else
                        newproject.Belt_Assigned_Email_ID__c = null;                   
                    //Project Project_Member_1 Email
                    if(newproject.Project_Member1__c != null){          
                        newproject.Project_Member_1_Email_ID__c = newproject.Project_Member1__r.Email__c;
                    }else
                        newproject.Project_Member_1_Email_ID__c = null;
                    //Project Project_Member_2 Email
                    if(newproject.Project_Member2__c != null){          
                        newproject.Project_Member_2_Email_ID__c = newproject.Project_Member2__r.Email__c;
                    }else
                        newproject.Project_Member_2_Email_ID__c = null;
                    
                    //Added by Srikanth to control workflow email alert (R16.4 = E039, E040 and E035)
                    if(Trigger.isupdate){
                        //R16.4 = E039, E040 : to control On-hold and Cancele workflow rules.
                        if(newproject.Project_State__c == 'On Hold' && newproject.Workflow_Updated__c == true && newproject.Project_State__c != Trigger.oldMap.get(newproject.Id).Project_State__c){ 
                            
                        }else {
                            newproject.Workflow_Updated__c = false;
                        }
                        if(newproject.Project_State__c == 'Canceled' && newproject.Workflow_Updated2__c == true && newproject.Project_State__c != Trigger.oldMap.get(newproject.Id).Project_State__c){ 
                            
                        }else {
                            newproject.Workflow_Updated2__c = false;
                        }
                        // R16.4 E035
                        //System.debug('Workflow_Update3__c = '+newproject.Workflow_Update3__c+'Project_State__c = '+newproject.Project_State__c);
                        if(newproject.Project_State__c != Trigger.oldMap.get(newproject.Id).Project_State__c ){
                            if(newproject.Workflow_Update3__c == true && newproject.Project_State__c != 'Complete'){
                                newproject.Workflow_Update3__c = false; 
                                //System.debug('Workflow_Update3__c = '+newproject.Workflow_Update3__c+'Project_State__c = '+newproject.Project_State__c);
                            }                            
                        }
                        
                    }

                   //**** captures the date of when project state changed ****
                    //String.IsBlank(Datefield) 
                    Boolean priorvalue = true;
                    if (Trigger.isUpdate && Trigger.isAfter) { 
                        //if((newproject.In_Progress_Date__c == null && newproject.On_Hold_Date__c == null && newproject.Canceled_Date__c == null && newproject.Not_Started_Date__c == null && newproject.Closed_Date__c == null) || newproject.Project_State__c != Trigger.oldMap.get(newproject.Id).Project_State__c ){ 
                        if(newproject.Project_State__c != Trigger.oldMap.get(newproject.Id).Project_State__c ){ 
                            priorvalue = true;
                        }
                        else                        
                            priorvalue = false;
                    }
                    if(priorvalue){
                        date today = system.today();
                        if(newproject.Project_State__c == 'In Progress'){
                            newproject.In_Progress_Date__c = today;
                        }
                        if(newproject.Project_State__c == 'On Hold'){
                            newproject.On_Hold_Date__c = today;
                        }
                        if(newproject.Project_State__c == 'Canceled'){
                            newproject.Canceled_Date__c = today;
                        }
                        if(newproject.Project_State__c == 'Not Started'){
                            newproject.Not_Started_Date__c = today;
                        }
                        if(newproject.Project_State__c == 'Closed'){
                            newproject.Closed_Date__c = today;
                        }
                    }                    
                    updatevalues.add(newproject);
                    
                    if(Trigger.isUpdate && Trigger.isAfter){ 
                        QIPP_Benefit__c[] benefits = newproject.Benefits__r;
                        if(newproject.Project_Lead__c != null && !benefits.isempty() ){     
                            for(QIPP_Benefit__c benf:benefits ){
                                if(benf.Project_Lead__c != newproject.Project_Lead__r.Full_Name__c){
                                    benf.Project_Lead__c = newproject.Project_Lead__r.Full_Name__c;
                                    benf.Email_Project_Lead__c = newproject.Project_Lead__r.Email__c;
                                    Updatebenefits.add(benf);
                                }
                                //Updatebenefits.add(benf);
                            }
                        }
                    }   
                }
                //update updatevalues;
                if(updatevalues.size() >0){ update updatevalues;}           
                if(Updatebenefits.size() >0){ update Updatebenefits;}
            }        
        }
    }
}





/*
// *********  Old Code QIPP_R13*********
trigger UpdatePortfolioOwnerEmail on QIPP_Project__c (before insert , before update) 
{
    if(Trigger.isBefore)
    {
        Trigger_Control__c s = Trigger_Control__c.getInstance(UserInfo.getUserId());
        system.debug('Run_Triggers__c :::'+s.Run_Triggers__c);
        if(s.Run_Triggers__c)
        {
        
            for(QIPP_Project__c newproject : Trigger.New )
            {
                 QIPP_Contacts__c EmailForProjectLead = null;
                 QIPP_Portfolio__c portfoliodetails = null;
                 QIPP_Contacts__c EmailForPortfolioOwner = null;
                 QIPP_Contacts__c BeltEmail = null;
                  
                 if(newproject.Project_Lead__c != null)
                 {          
                     EmailForProjectLead = [select Email__c from QIPP_Contacts__c where Id =: newproject.Project_Lead__c ];
                     newproject.Project_Lead_Email_ID__c = EmailForProjectLead.Email__c;
                     System.Debug(' ***** EmailForProjectLead***** ' + EmailForProjectLead);
                 }
                 
                 if(newproject.Portfolio_Name__c != null)
                 {
                     portfoliodetails = [select Portfolio_Owner__c from QIPP_Portfolio__c where Id =: newproject.Portfolio_Name__c ];
                     System.Debug(' ***** portfoliodetails ***** ' + portfoliodetails );
                 }
                 
                 if(portfoliodetails.Portfolio_Owner__c != null)
                 {   
                     EmailForPortfolioOwner = [select Email__c from QIPP_Contacts__c where Id =: portfoliodetails.Portfolio_Owner__c ];
                     newproject.Portfolio_Owner_EmailID__c = EmailForPortfolioOwner.Email__c;
                     System.Debug(' ***** EmailForPortfolioOwner ***** ' + EmailForPortfolioOwner );
                 }
                 
                 IF(newproject.Belt_Assigned__c != NULL)
                 {
                     BeltEmail = [select Email__c from QIPP_Contacts__c where Id =: newproject.Belt_Assigned__c ];
                     newproject.Belt_Assigned_Email_ID__c = BeltEmail.Email__c ;
                     System.Debug(' ***** Belt_Assigned ***** ' + newproject.Belt_Assigned_Email_ID__c); 
                 }
            }
        }
    }
}
*/