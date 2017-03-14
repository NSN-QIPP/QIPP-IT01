trigger UpdateOwnerAndAuditorEmail on Finding__c (before insert , before update) 
{
for (Finding__c newfinding : Trigger.New)
      {
              System.Debug(' %%%%%%%%%%%%%%%%%% Before ' + newfinding  );
       
               QIPP_Contacts__c Owner = null;
              QIPP_Contacts__c Auditor =  null;  

              if (newfinding.Finding_Owner__c != null)
              {
                     Owner =   [select Email__c from QIPP_Contacts__c where Id =: newfinding.Finding_Owner__c]; 
                     newfinding.Finding_Owner_Email__c = Owner.Email__c;
              }
             
            if (newfinding.Auditor__c != null)
             {
                         Auditor =   [select Email__c from QIPP_Contacts__c where Id =: newfinding.Auditor__c];      
                         newfinding.Finding_Auditor_Email__c = Auditor.Email__c; 
             }
            
             System.Debug(' %%%%%%%%%%%%%%%%%% Later ' + newfinding  );

     }

}