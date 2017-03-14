/*
    Dema Number : DEMA0015460
    Description : Trigger for send Notification to Safty Product Notification
    Name        : Rajkumar
*/

trigger QIRS_New_Record_Notification on QIRS__c (After update, After insert) 
{               
    if(Trigger.isInsert || Trigger.isUpdate)
    {                        
        for(QIRS__c qirs : Trigger.new)
        {
            if( (qirs.Status__c == 'open'&& qirs.Product_Safety__c && Trigger.isInsert)  || (qirs.Status__c == 'Released'&& qirs.Product_Safety__c && Trigger.isInsert) || (qirs.Status__c == 'Closed' && qirs.Product_Safety__c && Trigger.isUpdate))
            {      
               //-------------------------------------Notification for Businuess and Buninuess Group Line --------------------------
                                                                   
                boolean isSendMail = QIRSBasecontroller.SendEmail(null, qirs.Business__c,null, qirs.Business_Group__c,'Create',qirs.Id);
                system.debug('isSendMail *-----> : '+ isSendMail );                                                             
                
               //------------------------------------------Notification for Product Safty list (New Object)------------------------------------------------------------               
                    
                boolean flag = QIRSNotificationController.sendNotification(qirs.id);
                system.debug('flag = ' + flag);
                
               //-------------------------------------------------------------------------------------------------------------------
            }
             
            ///---for testing purpose------//
            /*
                if(Trigger.isUpdate)
                {
                    boolean flag = QIRSNotificationController.sendNotification(qirs.id);
                    system.debug('flag = ' + flag);
                }*/
            //-----------------------------------
        }                       
    }           
}





//------------------------------------- future reference--------------------------------
            /*              
            if(qirs.Status__c == 'Closed' && qirs.Product_Safety__c && Trigger.isUpdate)
            {                
               boolean isSendMail = QIRSBasecontroller.SendEmail(null, qirs.Business__c,null, qirs.Business_Group__c,'Create',qirs.Id);
            }            
            */