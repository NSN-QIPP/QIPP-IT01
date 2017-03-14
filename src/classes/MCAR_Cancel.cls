global class MCAR_Cancel{
    public Id Claim_Id{ get; set; }
    public String claimName{ get; set; }
    public MCAR_Claim_Management__c mcarclaim{ get; set; }
    public String Comments{ get; set; }
    
    public MCAR_Cancel() {
        Claim_Id = ApexPages.CurrentPage().getParameters().get('id');
       //modify by veera
        mcarclaim = [SELECT OwnerID,Retrofit_Amount__c,Retrofit_Case__c,Claim_Status__c,Open_Date__c,Days_Open__c,Name,Sending_Claim_letter__c FROM MCAR_Claim_Management__c WHERE Id =: Claim_Id LIMIT 1];
        claimName = mcarclaim.Name;
    }
    
    webservice static Boolean ClaimCancelvalidation(string claimId){
        MCAR_Claim_Management__c mcar_claim = [SELECT OwnerID FROM MCAR_Claim_Management__c WHERE Id =: claimId LIMIT 1];
        if(UserInfo.getUserId() != mcar_claim.OwnerId)
            return FALSE;
        return TRUE;
    }

Public MCAR_Cancel(ApexPages.StandardController controller){}

   webservice static Boolean cancel(string Mcar_Id1)
   {
       Boolean result =false;
       List<MCAR__c> mcar=new List<MCAR__c>();
       mcar=[SELECT OwnerId,Createdby.Name,MCAR_Status__c,Name FROM MCAR__c WHERE Id=:Mcar_Id1]; 
       if(mcar.size()>0)
       {
           if(mcar[0].MCAR_Status__c !='Cancelled')
            mcar[0].MCAR_Status__c ='Cancelled';
            mcar[0].MCAR_Closed_Date__c = System.today();
            update mcar;
            result=true;
       }
       else
       {
           result=false;
       }
       return result;
   }
   
    Public pagereference ClaimCancel()
    {
    if(comments == null || comments == '')
    {
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Kindly fill the Reason for Cancelation.');
        ApexPages.addMessage(myMsg);
        return null;
    } 
      
              
    list<String> EmailAddrAll = new list<String>();
    
    list<String> CCEmailAddr = new list<String>();
       
        if(mcarclaim.Claim_Status__c == 'Negotiation'){
        
          List<Claim_Contact__c> cc = new List<Claim_Contact__c>();
            cc = [select Email__c,Contact_Type__c,Claims__c from Claim_Contact__c WHERE Claims__c =: mcarclaim.id AND Contact_Type__c != 'Manufacturer'];
            for(Claim_Contact__c c : cc)
                EmailAddrAll.add(c.Email__c);
                
            mcarclaim.Claim_Status__c ='Cancelled';
            mcarclaim.Cancel_Comments__c = Comments;
            update mcarclaim;
               
            List<User> user = new List<User>();
            user = [Select Email from User where ID =: mcarclaim.OwnerID];
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            EmailTemplate et = [SELECT id, developerName FROM EmailTemplate WHERE developerName = 'MCAR_Claim_Draft_Notify_Cancel_Claim'];
            //mail.setToAddresses(CCEmailAddr);
            mail.setCCAddresses(EmailAddrAll);
            mail.setWhatId(mcarclaim.id);
            mail.setTemplateId(et.id);
            mail.setTargetObjectId(User[0].Id);
            mail.setSaveAsActivity(false);
            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});   
              
                
       
            }
            


              if(mcarclaim.Claim_Status__c == 'Payments'){
            List<Claim_Contact__c> cc = new List<Claim_Contact__c>();
            cc = [select Email__c,Contact_Type__c,Claims__c from Claim_Contact__c WHERE Claims__c =: mcarclaim.id AND Contact_Type__c != 'Manufacturer'];
            for(Claim_Contact__c c : cc)
                EmailAddrAll.add(c.Email__c);
               
            mcarclaim.Claim_Status__c ='Cancelled';
            mcarclaim.Cancel_Comments__c = Comments;
            update mcarclaim;
       
               
            List<User> user = new List<User>();
            user = [Select Email from User where ID =: mcarclaim.OwnerID ];
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            EmailTemplate et = [SELECT id, developerName FROM EmailTemplate WHERE developerName = 'Cancellation_Notice_During_Claims'];
            //mail.setToAddresses(CCEmailAddr);
            mail.setCCAddresses(EmailAddrAll);
            mail.setWhatId(mcarclaim.id);
            mail.setTemplateId(et.id);
            mail.setTargetObjectId(User[0].Id);
            mail.setSaveAsActivity(false);
            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});   
            

            }




              if(mcarclaim.Claim_Status__c == 'Data Collection'){
          List<Claim_Contact__c> cc = new List<Claim_Contact__c>();
            cc = [select Email__c,Contact_Type__c,Claims__c from Claim_Contact__c WHERE Claims__c =: mcarclaim.id AND Contact_Type__c != 'Manufacturer'];
            for(Claim_Contact__c c : cc)
                EmailAddrAll.add(c.Email__c);
            
            mcarclaim.Claim_Status__c ='Cancelled';
            mcarclaim.Cancel_Comments__c = Comments;
            update mcarclaim;
       
               
            List<User> user = new List<User>();
            user = [Select Email from User where ID =: mcarclaim.OwnerID ];
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            EmailTemplate et = [SELECT id, developerName FROM EmailTemplate WHERE developerName = 'Cancel_Notice_during_Data_Collection'];
            //mail.setToAddresses(CCEmailAddr);
            mail.setCCAddresses(EmailAddrAll);
            mail.setWhatId(mcarclaim.id);
            mail.setTemplateId(et.id);
            mail.setTargetObjectId(User[0].Id);
            mail.setSaveAsActivity(false);
            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});   
            

            }

    
     
        
        //result=true;
        pageReference ref = new pageReference('/'+Claim_Id);
        ref.setRedirect(TRUE);
        return ref;
    }
    public pageReference Cancel(){
        pageReference ref = new pageReference('/'+Claim_Id);
        ref.setRedirect(TRUE);
        return ref;
    }
    
    webservice static Boolean deletedraft(string ClaimId, integer identifier){
        if(identifier == 1){
            MCAR_Claim_Management__c mcar_claim = [SELECT OwnerId, Id FROM MCAR_Claim_Management__c WHERE Id =: claimId LIMIT 1];
            if(UserInfo.getUserId() != mcar_claim.OwnerId)
                return FALSE;
        }
        if(identifier == 2){
            MCAR_Claim_Management__c mcar_claim = [SELECT OwnerId, Id FROM MCAR_Claim_Management__c WHERE Id =: claimId LIMIT 1];
            
            delete mcar_claim;
            return null;
        }
        return NULL;
    }
    
    /** isValidateAndUpdate is used to check only to validate or update as well
     *  FALSE to Only to Validate and TRUE for Validate and Update
     */
    webservice static Integer NextStepNegotiation(string ClaimId,Boolean isValidateAndUpdate)
    {        
    list<Negotiation_Log__c> nlog = new list<Negotiation_Log__c>();
    
    nlog = [SELECT Name FROM Negotiation_Log__c WHERE Claim__c =: ClaimId];
    Integer result;
    if(nlog.size() == 0)
    {
      result = 1;
      return result;
    }
    else{
        MCAR_Claim_Management__c ian=new MCAR_Claim_Management__c();
        ian =[SELECT I_Agree_Negotiation__c,Amount__c, Sending_Settlement_letter__c,Manufacturer_Accepts_Full_Responsibility__c, ownerId FROM MCAR_Claim_Management__c WHERE Id=:ClaimId]; 
        if(ian != NULL)
        {
            /*
             if(ian.Manufacturer_Accepts_Full_Responsibility__c != True){
                 result = 2;          
                 return result;       
             }
            */
            
             if(ian.Amount__c == NULL){
                 result = 3;          
                 return result;       
             }
             
             
             
            ian.I_Agree_Negotiation__c = TRUE;
            
            if(ian.I_Agree_Negotiation__c ==TRUE)
            {                
            //RecordType Rec = [SELECT Id FROM RecordType WHERE Name = 'MCAR Claim close layout'limit 1];
            ian.RecordTypeId=[SELECT Id FROM RecordType WHERE developerName = 'MCAR_Claim_Final_Stage_layout'].Id;
            ian.Claim_Status__c='Payments';
            
           // ian.Claim_Stage_Status_Date__c= System.today();
            if(isValidateAndUpdate) update ian;
            
            result= 0;
            return result;
            }
            
            else{
            ian.I_Agree_Negotiation__c = FALSE;
            }
        } 
        
          
             
           list<String> EmailAddrzManufac = new list<String>();
           list<String> EmailAddrall = new list<String>();
           list<String> CCEmailAddr = new list<String>();
       
     
          List<Claim_Contact__c> cc = new List<Claim_Contact__c>();
            cc = [select Email__c,Contact_Type__c,Claims__c from Claim_Contact__c WHERE Claims__c =: ian.id];
            for(Claim_Contact__c c : cc)
                if(c.Contact_Type__c == 'Manufacturer')
                    EmailAddrzManufac.add(c.Email__c);
                else
                    EmailAddrall.add(c.Email__c);
            List<User> user = new List<User>();
            user = [Select Id, Email from User where ID =: ian.OwnerID];
            system.debug('UUUSSSEEERRR:' + user);
            if(!user.isEmpty())
                for(User u : user)
                    CCEmailAddr.add(u.Email);
            for(Claim_Contact__c c : cc)
                if(c.Contact_Type__c == 'Category Manager')
                    CCEmailAddr.add(c.Email__c);   
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            EmailTemplate et = [SELECT id, developerName FROM EmailTemplate WHERE developerName = 'MCAR_Claim_Nego_Notify_Claim_Owner'];
            mail.setToAddresses(EmailAddrzManufac);
            mail.setCCAddresses(CCEmailAddr);
            mail.setWhatId(ian.id);
            mail.setTemplateId(et.id);
            mail.setTargetObjectId(user[0].Id);
            mail.setSaveAsActivity(false);
            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});
            
            mail = new Messaging.SingleEmailMessage();
            et = [SELECT id, developerName FROM EmailTemplate WHERE developerName = 'MCAR_Claim_Negotiation_Close'];
            //mail.setToAddresses(EmailAddrzManufac);
            mail.setCCAddresses(EmailAddrall);
            mail.setWhatId(ian.id);
            mail.setTemplateId(et.id);
            mail.setTargetObjectId(user[0].Id);
            mail.setSaveAsActivity(false);
            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});   
            
       
       
    return result;
    }
    // The below line added by Thiresh 02-Jul-2013
    // return result;
    }
    
      webservice static Integer NextStepDataCollection(string ClaimId)
       {
      // list<MCAR_Claim__c> importmcar = new list<MCAR_Claim__c>();
      // list<Non_Mcar__c> nonmcar = new list<Non_Mcar__c>();
       list<Performance_Deviation_section__c> performacedev = new list<Performance_Deviation_section__c>();
       list<Material_Deviation__c> materialdev = new list<Material_Deviation__c>();
       list<Claim_Contact__c> claimcontact = new list<Claim_Contact__c>();
       //Boolean Legal = FALSE;
      // Boolean Technical = FALSE;
       //Boolean NCC = FALSE;
       Boolean Commodity = FALSE;
       Boolean SQM = FALSE;
       
       //importmcar = [SELECT Name FROM MCAR_Claim__c WHERE MCAR_Claim_Management__c =: ClaimId];
      // nonmcar = [SELECT Name FROM Non_Mcar__c WHERE Claim__c =: ClaimId];
       performacedev=[SELECT Id,Name FROM Performance_Deviation_section__c WHERE Claim__c =: ClaimId];
       materialdev=[SELECT Id,Name FROM Material_Deviation__c WHERE MCAR_Claim_Management1__c =: ClaimId];
       claimcontact = [SELECT Name, Contact_Type__c FROM Claim_Contact__c WHERE Claims__c =: ClaimId];
       Integer result =0;
     /*  if(importmcar.size() == 0 && nonmcar.size() == 0)
       {
           result = 1;
           return result;
       }
       else
           if(claimcontact.size() == 0){
               result = 2;
               return result;
           }
           else*/
           
             if(performacedev.size() ==0 && materialdev.size()==0 )
             {
             result = 10;
             return result; 
             }
           else{
               for(Claim_Contact__c cc : claimcontact){
                   /*if(cc.Contact_Type__c == 'Nonconformance Cost')
                       NCC = TRUE;
                   if(cc.Contact_Type__c == 'Technical')
                       Technical = TRUE;
                   if(cc.Contact_Type__c == 'Legal')
                       Legal = TRUE;*/
                   if(cc.Contact_Type__c == 'Category Manager')
                       Commodity = TRUE;
                   if(cc.Contact_Type__c == 'SQM')
                       SQM = TRUE;
               }
           }
           if(Commodity == FALSE){
               result = 2;
               return result;
           } 
            if(SQM == FALSE){
               result = 3;
               return result;
           }                        
           else{
               MCAR_Claim_Management__c nc=new MCAR_Claim_Management__c();
               nc =[SELECT Notification_Send__c, I_Agree__c FROM MCAR_Claim_Management__c WHERE Id=:ClaimId]; 
               if(nc != NULL)
               {
                    nc.Notification_Send__c = TRUE;
                    nc.I_Agree__c = TRUE;
                    update nc;
                    result= 4;
               }
               else
               {
                   result=0;
               }
           }
       return result;
       
       
   }

   webservice static Boolean check(string Mcar_Id1)
   {
       Boolean result =false;
       List<MCAR__c> mcar=new List<MCAR__c>();
       mcar=[SELECT OwnerId,Createdby.Name,MCAR_Status__c,Name FROM MCAR__c WHERE Id=:Mcar_Id1]; 
       if(mcar.size()>0)
       {
         if(mcar[0].CreatedById == UserInfo.getUserId()|| mcar[0].OwnerId == UserInfo.getUserId())
         {
            result=true;
         }
       else {
       result=false;
       } 
       }
       return result;
   }
   webservice static Boolean check1(string Mcar_CR)
   {
       Boolean result = false;
       List<MCAR_Change_Request__c> MCR=new List<MCAR_Change_Request__c>();
       MCR=[SELECT MCAR_CR_Status__c,MCAR_CR_Facility_Type__c FROM MCAR_Change_Request__c WHERE Id=:Mcar_CR];
       List<Profile> tempProfile = new List<Profile>();
       tempProfile = [SELECT Id ,Name FROM profile where Name='Nokia - MCAR Super User'];
       if(UserInfo.getprofileid()==tempProfile[0].id)
       {
           result=true;
       }
       else {
       result=false;
       }
       return result;
   }
   
   webservice static Boolean close(string Mcar_Id1)
   {
       Boolean result =false;
       List<MCAR__c> mcar=new List<MCAR__c>();
       mcar=[SELECT OwnerId,Createdby.Id,MCAR_Status__c,Name FROM MCAR__c WHERE Id=:Mcar_Id1]; 
       if(mcar.size()>0)
       {
         if(mcar[0].CreatedById == UserInfo.getUserId()|| mcar[0].OwnerId == UserInfo.getUserId())
         {
          if(mcar[0].MCAR_Status__c !='Closed')
            mcar[0].MCAR_Status__c ='Closed';
            mcar[0].MCAR_Closed_Date__c = System.today();
            update mcar;
            result=true;
         }
       else {
       result=false;
       }
       }   
       return result;
   }
   
   webservice static Boolean NTF(string Mcar_Id1)
   {
       Boolean result =false;
       List<MCAR__c> mcar=new List<MCAR__c>();
       mcar=[SELECT OwnerId,Createdby.Name,MCAR_Status__c,Name FROM MCAR__c WHERE Id=:Mcar_Id1]; 
       if(mcar.size()>0)
       {
          if(mcar[0].MCAR_Status__c !='No Trouble Found')
            mcar[0].MCAR_Status__c ='No Trouble Found';
            mcar[0].MCAR_Closed_Date__c = System.today();
            update mcar;
            result=true;
        }
       else {
       result=false;
       }  
       return result;
   }
   
   webservice static Boolean Close1(string Mcar_Id1)
   {
       Boolean result =false;
       List<MCAR__c> mcar=new List<MCAR__c>();
       mcar=[SELECT OwnerId,Createdby.Name,MCAR_Status__c,Name FROM MCAR__c WHERE Id=:Mcar_Id1];
       if(mcar.size()>0)
       {
          if(mcar[0].MCAR_Status__c =='Draft')
          {
               delete mcar;
               result=true;           
          }
       }
       else{
       result=false;
       }   
       return result;
   }
   webservice static Boolean Approve(string Mcar_CR)
   {
       Boolean result =false;
       List<MCAR_Change_Request__c> MCR=new List<MCAR_Change_Request__c>();
       MCR=[SELECT MCAR_CR_Status__c,MCAR_CR_Facility_Type__c FROM MCAR_Change_Request__c WHERE Id=:Mcar_CR];
 
      if(MCR.size()>0)
       {
           if(MCR[0].MCAR_CR_Status__c =='New' ||MCR[0].MCAR_CR_Status__c =='Rejected')
           {
               MCR[0].MCAR_CR_Status__c ='Approved';
               update MCR;
               result=true;
           }
           else{result=false;}
       }
       return result;
   } 
   webservice static Boolean Reject(string Mcar_CR)
   {
       Boolean result =false;
       List<MCAR_Change_Request__c> MCR=new List<MCAR_Change_Request__c>();
       MCR=[SELECT MCAR_CR_Status__c,MCAR_CR_Facility_Type__c FROM MCAR_Change_Request__c WHERE Id=:Mcar_CR];
      if(MCR.size()>0)
       {
           if(MCR[0].MCAR_CR_Status__c =='New' || MCR[0].MCAR_CR_Status__c =='Approved')
           {
               MCR[0].MCAR_CR_Status__c ='Rejected';
               update MCR;
               result=true;
           }
           else{result=false;}
       }
       return result;
   }
   
   @isTest(SeeAllData=true)
static void test_MCAR_Cancel()
{
    Boolean result = true;
    Test.startTest();
    MCAR_Facility__c testFacility = new MCAR_Facility__c(Name ='Chennai', MCAR_Facility_Company__c='NSN');    
    insert testFacility; 
    MCAR_Change_Request__c objCR=new MCAR_Change_Request__c(MCAR_CR_Status__c = 'New',Facility_Name__c=testFacility.id,Facility_Contact_Name__c='Test1',Facility_Contact_Email__c='Test@nokia.com');
    insert objCR;
    update objCR;
    MCAR__c objmcar = new MCAR__c();
    objmcar.MCAR_Status__c ='No Trouble Found';
    
    insert objmcar;
    List<MCAR__c> lstmcar =new List<MCAR__c>();
    lstmcar.add(objmcar);
    Boolean TempNTF = NTF(objmcar.Id);
    
    MCAR_Manufacturer__c MM = new MCAR_Manufacturer__c();
    MM.Name = 'Samsung';
    insert MM;
    MCAR_Claim_Management__c MCM = new MCAR_Claim_Management__c();
    MCM.Claim_Status__c = 'Draft'; 
    MCM.Part_Category__c = 'Components';
    MCM.Manufacturer__c = MM.Id;
    insert MCM;
    
    Test.stoptest();
    //pagereference ref = new pageReference(MCAR_Claim_Cancel);
    test.setCurrentPage(page.MCAR_Claim_Cancel);
    //test.seeAllData(true);
    ApexPages.CurrentPage().getParameters().put('id', MCM.Id);
    MCAR_Cancel mc = new MCAR_Cancel();
    ClaimCancelvalidation(MCM.Id);
    cancel(MCM.Id);
    mc.ClaimCancel();
    /*mc.Comments = 'test';
    mc.ClaimCancel();*/
    mc.Cancel();
    NextStepNegotiation(MCM.Id,true);
    NextStepDataCollection(MCM.ID);
    MCM.Claim_Status__c = 'Data Collection'; 
    MCM.Root_Cause_Summary__c = 'Testing';
    MCM.Corrective_Actions_Summary__c = 'Test';
    MCM.Manufacturer_Accepts_Full_Responsibility__c = True;
    MCM.Total_Cost_To_Be_Claimed__c = 123;
    MCM.Amount__c = 123;
    update MCM;
    mc.mcarclaim = MCM;
    mc.mcarclaim.OwnerId = Userinfo.getuserId();
    update mc.mcarclaim;
    mc.Comments = 'test';
    mc.ClaimCancel();
    mc.mcarclaim.Claim_Status__c = 'Negotiation';
    Update mc.mcarclaim;
    mc.ClaimCancel();
    mc.mcarclaim.Claim_Status__c = 'Payments';
    Update mc.mcarclaim;
    mc.ClaimCancel();
    Negotiation_Log__c NL = new Negotiation_Log__c();
    NL.Claim__c = MCM.Id;
    NL.Memo_Title__c = 'Test';
    NL.Memo_Description__c = 'Test';
    insert NL;
    NextStepNegotiation(MCM.Id,true);
    MCM.Manufacturer_Accepts_Full_Responsibility__c = False;
    update MCM;
    NextStepNegotiation(MCM.Id,true);
    MCM.Manufacturer_Accepts_Full_Responsibility__c = True;
    MCM.Amount__c = NULL;
    update MCM;
    NextStepNegotiation(MCM.Id,true);
    /*
    NSN_Part__c NP = new NSN_Part__c();
    NP.Name = 'test';
    NP.Description__c = 'test';
    insert NP;
    MCAR_MEPS__c MMP = new MCAR_MEPS__c();
    MMP.Name = 'Test';
    MMP.MCAR_NSN_Part__c = NP.Id;
    MMP.MCAR_Mfg_Part_Number__c = 'test';
    MMP.Manufacturer_Name__c = MM.Id;
    insert MMP;
    Non_Mcar__c NM = new Non_Mcar__c();
    NM.Code__c = MMP.Id;
    NM.Quantity__c = 123;
    NM.Claim__c = MCM.Id;
    insert NM;
    NextStepDataCollection(MCM.ID);*/
    Claim_Contact__c CC = new Claim_Contact__c();
    CC.Contact_Type__c = 'Legal';
    CC.Claims__c = MCM.ID;
    CC.Email__c = 'abc@xyz.com';
    insert CC;
    //NextStepDataCollection(MCM.ID);
    CC = new Claim_Contact__c();
    CC.Contact_Type__c = 'Category Manager';
    CC.Claims__c = MCM.ID;
    CC.Email__c = 'abc@xyz.com';
    insert CC;
    //NextStepDataCollection(MCM.ID);
    CC = new Claim_Contact__c();
    CC.Contact_Type__c = 'SQM';
    CC.Claims__c = MCM.ID;
    CC.Email__c = 'abc@xyz.com';
    insert CC;
    CC = new Claim_Contact__c();
    CC.Contact_Type__c = 'Manufacturer';
    CC.Claims__c = MCM.ID;
    CC.Email__c = 'abc@xyz.com';
    insert CC;
    //NextStepNegotiation(MCM.Id,true);
    deletedraft(MCM.Id,1);
    deletedraft(MCM.Id,2);
}

static testmethod void test1(){
    
    MCAR_Manufacturer__c MM = new MCAR_Manufacturer__c();
    MM.Name = 'Samsung';
    insert MM;
    MCAR__c objmcar = new MCAR__c();
    objmcar.MCAR_Status__c ='No Trouble Found';
    objmcar.MCAR_Manufacturer__c = MM.Id;
    insert objmcar;
    MCAR_Claim_Management__c MCM = new MCAR_Claim_Management__c();
    MCM.Claim_Status__c = 'Draft'; 
    MCM.Part_Category__c = 'Components';
    MCM.Manufacturer__c = MM.Id;
    insert MCM;
    //pagereference ref = new pageReference(MCAR_Claim_Cancel);
    
    NextStepDataCollection(MCM.ID);
    MCM.Claim_Status__c = 'Data Collection'; 
    MCM.Root_Cause_Summary__c = 'Testing';
    MCM.Corrective_Actions_Summary__c = 'Test';
    MCM.Manufacturer_Accepts_Full_Responsibility__c = True;
    MCM.Total_Cost_To_Be_Claimed__c = 123;
    MCM.Amount__c = 123;
    update MCM;
    
    
    NSN_Part__c NP = new NSN_Part__c();
    NP.Name = 'test';
    NP.Description__c = 'test';
    insert NP;
    MCAR_MEPS__c MMP = new MCAR_MEPS__c();
    MMP.Name = 'Test';
    MMP.MCAR_NSN_Part__c = NP.Id;
    MMP.MCAR_Mfg_Part_Number__c = 'test';
    MMP.Manufacturer_Name__c = MM.Id;
    insert MMP;
    Non_Mcar__c NM = new Non_Mcar__c();
    NM.Code__c = MMP.Id;
    NM.Quantity__c = 123;
    NM.Claim__c = MCM.Id;
    insert NM;
    
    /*MCAR_Claim__c MCL = new MCAR_Claim__c();
    MCL.MCAR_Claim_Management__c = MCM.Id;
    MCL.MCARs__c = objmcar.Id;
    insert MCL;*/
    
    NextStepDataCollection(MCM.ID);
    Claim_Contact__c CC = new Claim_Contact__c();
    CC.Contact_Type__c = 'Legal';
    CC.Claims__c = MCM.ID;
    CC.Email__c = 'abc@xyz.com';
    insert CC;
    NextStepDataCollection(MCM.ID);
    CC = new Claim_Contact__c();
    CC.Contact_Type__c = 'Category Manager';
    CC.Claims__c = MCM.ID;
    CC.Email__c = 'abc@xyz.com';
    insert CC;
    NextStepDataCollection(MCM.ID);
    CC = new Claim_Contact__c();
    CC.Contact_Type__c = 'SQM';
    CC.Claims__c = MCM.ID;
    CC.Email__c = 'abc@xyz.com';
    insert CC;
    NextStepDataCollection(MCM.ID);
    
    
}
}