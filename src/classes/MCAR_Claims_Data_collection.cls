global class MCAR_Claims_Data_collection 
{
 
Public MCAR_Claims_Data_collection(ApexPages.StandardController controller){}
             
        webservice static Integer Inform_DataCollection(string ClaimId)
       {
       
           List<MCAR_Claim_Management__c> nc=new List<MCAR_Claim_Management__c>();                   
           nc =[SELECT Data_Collection_Notification_Send__c,Owner.Email,Name,Sending_Claim_letter__c FROM MCAR_Claim_Management__c WHERE Id=:ClaimId];                     
           Integer result =0;                  
           if(nc.size()>0)                   
           {                     
               nc[0].Data_Collection_Notification_Send__c = TRUE;                
                        //nc[0].Claim_Status__c='Negotiation'                                                              
               update nc;                        
               result= 1;  
               
               //------------------------------------Claim Letter Attachment---------------------------------
               try
               {                                 
                   if(nc[0].Sending_Claim_letter__c){
                       system.debug('control....1');
                   //PageReference pdf = Page.MCAR_Claim_Letter;
                    PageReference pdf = Page.MCAR_Claim_Letter;
                   pdf.getParameters().put('id',ClaimId);
                   pdf.setRedirect(true);
                   //Blob body = pdf.getContent();
                                      
                                 
                       Blob body;                      
                       if (Test.IsRunningTest())                                            
                        {                               
                           body=Blob.valueOf('UNIT.TEST');   
                        }                    
                        else                         
                        {
                            body = pdf.getContent();
                        }
                       
                    Attachment recAttach = new Attachment();                       
                    recAttach.body = body;              
                    recAttach.Name = 'Claim Letter.pdf';                        
                    recAttach.IsPrivate = false;                        
                    recAttach.parentId = ClaimId;                        
                    insert recAttach;
                   
                   //------------------------------------------Claim Letter Sentding-----------------------------------------//
                   Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();                    
                   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                                      
                   attach.setContentType('application/pdf');
                   attach.setFileName('Claim Letter.pdf');   
                   attach.setInline(false);
                   attach.Body = body;
                   
                   List<Claim_Contact__c> ClaimContact = new List<Claim_Contact__c>([select id,Name,Email__c,Contact_Type__c from Claim_Contact__c where Claims__c=:ClaimId]);                   
                  
                    List<String> toAddress = new List<String> ();
                   toAddress.add(nc[0].Owner.Email);

                   List<String> ccAddress = new List<String>();
                    for(Claim_Contact__c cc : ClaimContact)
                    {
                        ccAddress.add(cc.Email__c);
                    }
                   
                   system.debug('**to Address' + toAddress +' *** '+ccAddress);
                   mail.setToAddresses(toAddress);
                   mail.setCcAddresses(ccAddress);
                   mail.setSubject('Nokia Networks Claim Notification for '+nc[0].Name); 
                   mail.setHtmlBody('<html><head><style>h1.hidden {visibility: hidden;}</style></head><body><tr><td>Dear Sir or Madam:</td></tr><br/><br/><tr><td>Attached is a Claim Letter, providing a summary of compensation for damages that Nokia Networks is seeking.</td></tr><br/><br/><tr><td>Please review and contact Nokia at your soonest convenience to resolve this matter.</td></tr><br/><br/>Yours sincerely,<br/><h>Nokia Networks</h></body></html>');                                    
                   mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });  
                   
                   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                   system.debug('control....2');
                   //----------------------------------------------------------------------------------------------------------//
                   }
               }
               catch(Exception e)
               {
                    system.debug('catch black...'+e.getMessage());   
                   system.debug('catch black...'+e.getCause());  
                   system.debug('catch black...'+e.getStackTraceString()); 
               }
               //--------------------------------------------------------------------------------------------
           }                   
           else                 
           {                      
               result=0;                   
           }
                   return result;          
       }
           
            
            webservice static Integer Inform_ClaimClosed(string ClaimId)
         {   Integer result;
             List<MCAR_Claim_Management__c> Claim_obj=new List<MCAR_Claim_Management__c>();
             Claim_obj =[SELECT Amount__c FROM MCAR_Claim_Management__c WHERE Id=:ClaimId];   
             Claim_obj[0].Data_claim_Notification_Send__c = TRUE;
             Claim_obj[0].Claim_Status__c='Closed';
             RecordType Rec = [SELECT Id FROM RecordType WHERE Name = 'MCAR Claim close layout'limit 1];
             Claim_obj[0].RecordTypeId=Rec.Id;
             //system.debug ('update12'+Claim_obj[0].Claim_Status__c);
             update Claim_obj;
             result=1; 
             return result;
         } 
              
              
              webservice static Integer Final_Settlement_Validation(string ClaimId)
         {
         //Integer final_payments;
         //Below Line is Added by Kiran on 21-04-2015 &commented the above Line
         Double final_payments;
         Integer result;
                   List<MCAR_Claim_Management__c> Claim_obj=new List<MCAR_Claim_Management__c>();
                   Claim_obj =[SELECT Amount__c FROM MCAR_Claim_Management__c WHERE Id=:ClaimId]; 

List<Claim_Final_Payment__c> Payment_obj = new List<Claim_Final_Payment__c>();
Payment_obj =[select Amount__c from Claim_Final_Payment__c where Claim__c=:ClaimId ]; 
              if (Payment_obj.size()>0)
              {
                              AggregateResult Calim_total_obj = [select sum(Amount__c) total from Claim_Final_Payment__c where Claim__c=:ClaimId  Group by Claim__c ];
                               
                 //final_payments=integer.valueof(Calim_total_obj.get('total'));
                 //Below Line is added by Kiran on 21-04-2015 and commented the above line
                 final_payments=double.valueof(Calim_total_obj.get('total'));
              }

                 

                 // system.debug ('main'+Claim_obj[0].Amount__c);
                 // system.debug ('child'+final_payments );
                    
                  if(Claim_obj.size()>0 && Payment_obj.size()>0 )
                   {
                        if (Claim_obj[0].Amount__c != final_payments)
                        {
                        result=2; 
                       /* }
                        else
                        {
                        result=1; 
                        Claim_obj[0].Data_claim_Notification_Send__c = TRUE;
                        Claim_obj[0].Claim_Status__c='Closed';
                        RecordType Rec = [SELECT Id FROM RecordType WHERE Name = 'MCAR Claim close layout'limit 1];
                        Claim_obj[0].RecordTypeId=Rec.Id;
                        //system.debug ('update12'+Claim_obj[0].Claim_Status__c);
                        update Claim_obj;*/
                        
                                
                        }   
                        
                        


                   }
                   else
                   {
                       result=3;
                   }
                   return result;
           }
    
    
     @isTest(SeeAllData=true)

    
    
    static void TestClass_Factory_Worksheet()
    {

    
    MCAR_Claim_Management__c  testParentObj = new MCAR_Claim_Management__c();
    testParentObj.Claim_Status__c = 'Data Collection';
    testParentObj.Materials_Factory_Loss__c=null;
    	testParentObj.Sending_Claim_letter__c = true;
        testParentObj.Technical_Details_Review_Approval__c =true;
        testParentObj.Root_Cause_Analysis_Approved_Date__c = system.today();
        testParentObj.Root_Cause_Summary__c ='Root_Cause_Summary__c';
        testParentObj.Corrective_Actions_Summary__c = 'test';
        testParentObj.Other_Information__c = 'tst';
    testParentObj.Amount__c=500;        
    testParentObj.CreatedDate= Datetime.now(); 
    insert testParentObj; 

    ApexPages.StandardController con = new ApexPages.StandardController(testParentObj);
    MCAR_Claims_Data_collection testclass_object = new MCAR_Claims_Data_collection (con);
     
              
            Test.startTest();
            Integer val;  
            val=Inform_DataCollection(testParentObj.ID);
            MCAR_Claim_Management__c result_oj =  [SELECT Data_Collection_Notification_Send__c FROM MCAR_Claim_Management__c WHERE Id=:testParentObj.ID]; 
            System.assertEquals (True, result_oj.Data_Collection_Notification_Send__c);
            System.assertEquals (1,val);
            
          
           val= Inform_DataCollection('a0qK00000001oyO');
           System.assertEquals (0,val);
           
           val=Inform_ClaimClosed(testParentObj.ID);
           System.assertEquals (1,val);
           
            
        
        Claim_Final_Payment__c Payment_obj = new Claim_Final_Payment__c ();
        Payment_obj.Claim__c=testParentObj.ID;
        Payment_obj.Payment_Validated__c=TRUE;
        Payment_obj.Amount__c=1500;
        insert Payment_obj;
        val=Final_Settlement_Validation(testParentObj.ID);
        System.assertEquals (2,val);
        

        delete Payment_obj;
        val=Final_Settlement_Validation(testParentObj.ID);
        System.assertEquals (3,val);
              
             

    }       
       
}