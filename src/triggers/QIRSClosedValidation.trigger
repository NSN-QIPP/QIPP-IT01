trigger QIRSClosedValidation on QIRS__c (before update) 
{
        for (QIRS__c qirs : Trigger.new)
    {
        if(qirs.Status__c == QIRSBasecontroller.BaseVarQIRSClosed)
        {
        boolean  bError = true;
        String  strActionPlanNumber = '';        
        List<QIRS_Action_Plan__c> qirsAP = new List<QIRS_Action_Plan__c>();
        qirsAP =  [select ID, Name, Action_Type__c,QIRS__c,Reason1__c,Required_date__c,Status__c from QIRS_Action_Plan__c
                    where QIRS__r.Id =: qirs.id and Status__c !=: 'Canceled'];
                  
                  for(Integer i = 0; i < qirsAP.size(); i++)
                     {
                          if(qirsAP[i].Status__c == QIRSBasecontroller.BaseVarQIRSAPClosed || 
                          qirsAP[i].Status__c == QIRSBasecontroller.BaseVarQIRSAPRejected)
                          {
                              bError =false;
                          }
                          else
                          {
                              bError =true;  
                              break; 
                          }  
                     }
                     if(bError == true)
                     {
                        qirs.addError('Before closing QIRS record all its corresponding action plans should be closed.'); 
                     }
           }
    }

}