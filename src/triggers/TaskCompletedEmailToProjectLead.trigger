trigger TaskCompletedEmailToProjectLead on QIPP_Task__c (before insert , before update) 
{
    for(QIPP_Task__c currenttask :Trigger.New)
    {

     QIPP_Project__c currprojectlead= NULL;
     QIPP_Contacts__c projectleadcontact = NULL;
     QIPP_Contacts__c TaskImplementorContact = NULL;

    System.Debug('########### currenttask : ############ ' + currenttask );
    
    IF(currenttask.Project_ID__c != NULL)
    { 
     // step 1 : select Project lead name from QIPP project
     currprojectlead= [select   Project_Name_Succinct__c , Project_Lead__c from QIPP_Project__c where Id =: currenttask.Project_ID__c];
     System.Debug('########### currprojectlead : ############ ' + currprojectlead);
     currenttask.Project_Name__c =   currprojectlead.Project_Name_Succinct__c; 
     
     // step 2 : Email from QIPP contact referring to task implementor
     projectleadcontact = [select Email__c from QIPP_Contacts__c where Id =: currprojectlead.Project_Lead__c] ;
     System.Debug('########### projectleadcontact EMAIL : ############ ' + projectleadcontact.Email__c);
     currenttask.Project_Lead_Email__c = projectleadcontact.Email__c;
    }  

    IF(currenttask.Task_Implementer__c != NULL)
    {
     // step 3 : Email from QIPP contact referring to task implementor
     TaskImplementorContact = [select Email__c from QIPP_Contacts__c where Id =: currenttask.Task_Implementer__c] ;
     currenttask.TaskImplementorEmail__c = TaskImplementorContact.Email__c;
     System.Debug('########### TaskImplementorContact EMAIL : ############ ' + TaskImplementorContact.Email__c);    
    }
  
         
     }

}