trigger QIRS_MCAR_Update on QIRS_MCAR__c (before insert,before update,after delete) 
{
    if (Trigger.isDelete) 
    {

       for (QIRS_MCAR__c mcar : Trigger.old)
        {

                    List<QIRS_MCAR__c> qirsmcar = new List<QIRS_MCAR__c>();
                    List<QIRS__c> qirs = new List<QIRS__c>();
                    qirsmcar =  [select ID, Name, MCAR_Code__c from QIRS_MCAR__c
                            where QIRS__c =: mcar.QIRS__c order by Name desc];
                    qirs = [select ID, Status__c,Name,MCAR__c from QIRS__c where id =: mcar.QIRS__c];
                     if(qirs.size() > 0)                 
                     {
                        if(qirs[0].Status__c != 'Closed' && qirs[0].Status__c != 'Submited to Master Approval')
                        {
                             string strMCAR = '';
                             for(Integer i = 0; i < qirsmcar.size(); i++)
                                 {
                                     if(i == 0)
                                     {
                                         strMCAR = String.Valueof(qirsmcar[i].MCAR_Code__c);                         
                                     }
                                     else
                                     {
                                         strMCAR = strMCAR + '; ' +String.Valueof(qirsmcar[i].MCAR_Code__c);
                                     }
                                 }
                            qirs[0].MCAR__c = strMCAR;     
                            update qirs;
                        }
                     }
             
        }
    }
    else
    {
         for (QIRS_MCAR__c mcar : Trigger.new)
            {
               //        IF( ISPICKVAL( QIRS__r.Status__c , 'Closed') || 
//ISPICKVAL( QIRS__r.Status__c , 'Submited to Master Approval') , true, false)
             
                    List<QIRS_MCAR__c> qirsmcar = new List<QIRS_MCAR__c>();
                    List<QIRS__c> qirs = new List<QIRS__c>();
                    qirsmcar =  [select ID, Name, MCAR_Code__c from QIRS_MCAR__c
                            where QIRS__c =: mcar.QIRS__c order by Name desc];
                    qirs = [select ID, Name,MCAR__c,Status__c from QIRS__c where id =: mcar.QIRS__c];
                     if(qirs.size() > 0)                 
                     {
                     if(qirs[0].Status__c != 'Closed' && qirs[0].Status__c != 'Submited to Master Approval')
                        {
                         string strMCAR = mcar.MCAR_Code__c;
                         for(Integer i = 0; i < qirsmcar.size(); i++)
                             {
                                   strMCAR = strMCAR + '; ' +String.Valueof(qirsmcar[i].MCAR_Code__c);
                             }
                        qirs[0].MCAR__c = strMCAR;     
                        update qirs;
                        }
                        
                      }
                      //}
            }
        }
}