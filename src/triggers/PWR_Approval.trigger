trigger PWR_Approval on CPR__c (Before update) {

if(trigger.isupdate)

    for (CPR__c pcpr: Trigger.new)
     {
      if(trigger.old[0].NQT_Project_Status__c=='Quote Generation')
      {
         if((pcpr.PWR__c==false) && (pcpr.PWR_Approval_Request_Sent__c!=null || pcpr.PWR_Approval_Final_Feedback_Received__c!=null) )
          {
             pcpr.PWR__c.addError('PWR Approval checkbox should be selected');
          }
          if((pcpr.PWR__c==true) && (pcpr.PWR_Approval_Request_Sent__c==null || pcpr.PWR_Approval_Final_Feedback_Received__c==null) )
          {
             pcpr.PWR__c.addError('Please indicate the date Pricing War Room Approval was sent and the date of final approval from Pricing War Room.');
          }
         else if((pcpr.PWR__c==true) && !(pcpr.PWR_Approval_Final_Feedback_Received__c>=pcpr.PWR_Approval_Request_Sent__c))
          {
             pcpr.PWR__c.addError('PWR Approval Final Feedback Received date should be greater than or equal to PWR Approval Request Sent date');
          }
          
      }          
      /*
      if (trigger.old[0].NQT_Project_Status__c !=null && trigger.old[0].NQT_Project_Status__c !='Quote Generation') 
      {
         if(pcpr.PWR__c!=trigger.old[0].PWR__c || 
            pcpr.PWR_Approval_Request_Sent__c!=trigger.old[0].PWR_Approval_Request_Sent__c ||
            pcpr.PWR_Approval_Final_Feedback_Received__c!=trigger.old[0].PWR_Approval_Final_Feedback_Received__c)
            {
                   pcpr.PWR__c.addError('PWR approval fields can only be modified in Quote Generation Stage');
            }
       }  */
      }
}