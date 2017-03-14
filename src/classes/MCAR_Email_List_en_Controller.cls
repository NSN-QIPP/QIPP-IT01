/* 
Created By    - Tejas Kardile
Creation Date - 16 APR 2012
Desc          - Controller to Send Email to MCAR Contacts and NSN Contact
Last ModifyBy -
*/  
public class MCAR_Email_List_en_Controller 
{
//Public Variable 
    String strMCARId; 
     
    public MCAR__c currentMCAR2{get;set;}

    List<MCAR_Email_List__c> addEmailListNSN= new List<MCAR_Email_List__c>();
    List<MCAR_Email_List__c> addEmailListMFR= new List<MCAR_Email_List__c>();
    List<MCAR_Email_List__c> addEmailListfinal= new List<MCAR_Email_List__c>();
    List<MCAR_Email_List__c> addEmailListOther= new List<MCAR_Email_List__c>();
    List<MCAR_Email_List__c> addEmailListFGM= new List<MCAR_Email_List__c>();
    /* public boolean GM_Email {get;set;}
    public boolean CC1 {get;set;}
    public boolean CC2 {get;set;}
    public boolean CC3 {get;set;}
    public boolean CC4 {get;set;}
    public boolean CC5 {get;set;}
    public boolean rGM {get;set;}
    public boolean rCC1 {get;set;}
    public boolean rCC2 {get;set;}
    public boolean rCC3 {get;set;}
    public boolean rCC4 {get;set;}
    public boolean rCC5 {get;set;}*/
   // public boolean mcar {get;set;}
     public boolean Email1 {get;set;}
      public boolean Email2 {get;set;}
       public boolean Email3 {get;set;}
        public boolean Email4 {get;set;}
         public boolean Email5 {get;set;}
          public boolean Email6 {get;set;}
           public boolean Email7 {get;set;}
            public boolean Email8 {get;set;}
             public boolean Suzhou {get;set;}
             public boolean Beijing {get;set;}
             public boolean Tianjin  {get;set;}
              public boolean Shanghai {get;set;}
              public boolean Chennai {get;set;}
                public boolean Oulu {get;set;}
                public boolean Bruchsal {get;set;}
              public boolean rEmail1 {get;set;}
      public boolean rEmail2 {get;set;}
       public boolean rEmail3 {get;set;}
        public boolean rEmail4 {get;set;}
         public boolean rEmail5 {get;set;}
          public boolean rEmail6 {get;set;}
           public boolean rEmail7 {get;set;}
            public boolean rEmail8 {get;set;}
             public boolean rSuzhou {get;set;}
              public boolean rBeijing {get;set;}
             public boolean rTianjin  {get;set;}
              public boolean rShanghai {get;set;}
              public boolean rChennai {get;set;}
                public boolean rOulu {get;set;}
                public boolean rBruchsal {get;set;}
             
     
     
    public MCAR_Email_List_en_Controller() 
    {
        strMCARId= System.currentPagereference().getParameters().get('id');  
          currentMCAR2 = [select id,Re_Notify__c, MCAR_Index_NSN_Code__c , MCAR_Part_Enterprise_ID__c, MCAR_Facility__c, MCAR_NSN_Code__c, CreatedById, OwnerId, MCAR_Manufacturer__c, MCAREmail1__c, MCAREmail2__c, MCAREmail3__c, MCAREmail4__c, MCAREmail5__c, MCAREmail6__c, MCAREmail7__c, MCAREmail8__c,MCARName1__c,MCARName2__c,MCARName3__c,MCARName4__c,MCARName5__c,MCARName6__c,MCARName7__c,MCARName8__c,Suzhou__c ,Beijing__c,Tianjin__c,Shanghai__c,Chennai__c,Oulu__c,Bruchsal__c,
           MCAR_Status__c from MCAR__C where id=:strMCARId ];  
           if(currentMCAR2.MCAREmail1__c != null) 
                rEmail1 =false;
                else
                rEmail1  =true;
            if(currentMCAR2.MCAREmail2__c != null) 
                rEmail2 =false;
                else
                rEmail2  =true;

            if(currentMCAR2.MCAREmail3__c != null) 
                 rEmail3 =false;
                else
                rEmail3  =true;

            if(currentMCAR2.MCAREmail4__c != null) 
               rEmail4 =false;
                else
                rEmail4  =true;
                
            if(currentMCAR2.MCAREmail5__c != null) 
              rEmail5 =false;
                else
                rEmail5  =true;
                 if(currentMCAR2.MCAREmail6__c != null) 
               rEmail6 =false;
                else
                rEmail6  =true;
                 if(currentMCAR2.MCAREmail7__c != null) 
              rEmail7 =false;
                else
                rEmail7  =true;
                 if(currentMCAR2.MCAREmail8__c != null) 
               rEmail8 =false;
                else
                rEmail8  =true;
             
              if(currentMCAR2.Suzhou__c != null) 
                rSuzhou =false;
                else
                rSuzhou =true;
                if(currentMCAR2.Beijing__c != null) 
                rBeijing =false;
                else
                rBeijing =true;
                if(currentMCAR2.Tianjin__c != null) 
                rTianjin =false;
                else
                rTianjin =true;
                 if(currentMCAR2.Shanghai__c != null) 
                rShanghai =false;
                else
                rShanghai =true;
                 if(currentMCAR2.Chennai__c != null) 
                rChennai =false;
                else
                rChennai =true;
                  if(currentMCAR2.Oulu__c != null) 
                rOulu =false;
                else
                rOulu =true;
                  if(currentMCAR2.Bruchsal__c != null) 
                rBruchsal =false;
                else
                rBruchsal =true;
                Suzhou = false;
                Beijing = false;
                Tianjin = false;
                Shanghai = false;
                Chennai = false;
                Oulu = false;
                Bruchsal = false;
                Email1  =false;
                Email2  =false;
                Email3  =false;
                Email4  =false;
                Email5  =false;
                Email6  =false;
                Email7  =false;
                Email8  =false;
                                                                
                 
    }

/*
getMCARManufactureEmailList - function for fetching data for Manufacturing contacts
Return Type - List
*/
    public List<MCAR_Email_List__c> getMCARManufactureEmailList() 
    {

         List<MCAR_Manufacturer_Contact__c>  contactId = new List<MCAR_Manufacturer_Contact__c>();
        contactId =  [SELECT MCAR_User__r.Name,Email__c, Name, Contact_Type__c, Id, Manufacturer_Name__r.Id, Manufacturer_Site__r.Name FROM MCAR_Manufacturer_Contact__c WHERE (MCAR_Manufacturer_Contact__c.Manufacturer_Name__r.Id=: currentMCAR2.MCAR_Manufacturer__c)];        
        if (contactId!= null && contactId.size() > 0)
          {
              MCAR_Manufacturer_Contact__c cnt = contactId.get(0);          
              for(Integer i = 0; i < contactId.size(); i++){
              MCAR_Email_List__c tempEmailContact = new MCAR_Email_List__c();
              tempEmailContact.MCAR_Email__c= contactId[i].Email__c;
              tempEmailContact.MCAR_First_Name__c=contactId[i].Name;
              tempEmailContact.MCAR_Last_Name__c=contactId[i].Manufacturer_Site__r.Name;
              tempEmailContact.MCAR_Role__c=contactId[i].MCAR_User__r.Name; 
              tempEmailContact.MCAR_Topic__c='Manufacturer Contact';
              tempEmailContact.MCAR__c=currentMCAR2.id;
              tempEmailContact.MCAR_Contact_Type__c='Manufacturer Contact';
              addEmailListMFR.add(tempEmailContact); 

              }      
          }
          
        return addEmailListMFR;                                   
    }
/*
getMCARNSNContactEmailList - function for fetching data for NSN contacts
Return Type - List
*/
 public List<MCAR_Email_List__c> getMCARNSNContactEmailList() 
    {

 NSN_Part__c selectNSNCode;
          List<MCAR_NSN_Contacts__c> nsnContactTec;
          if (currentMCAR2.MCAR_Index_NSN_Code__c != null)
              selectNSNCode = [select id, COM__c, TEC__c, Name from NSN_Part__C where Name =: currentMCAR2.MCAR_Index_NSN_Code__c limit 1 ];
          if (selectNSNCode != null )
              nsnContactTec = [select id, COM__c, Tec__c, Role__c, Status__c, First_Name__c, Last_Name__c, Email__c, Domain__c from MCAR_NSN_Contacts__c where Domain__c='TEC' and Tec__c=:selectNSNCode.TEC__c  ];
          if (nsnContactTec != null && nsnContactTec.size() > 0 )
          {
              MCAR_NSN_Contacts__c cntp = nsnContactTec .get(0);
               for(Integer i = 0; i < nsnContactTec.size(); i++){
               MCAR_Email_List__c tempEmailContact = new MCAR_Email_List__c();
                   tempEmailContact.MCAR_Email__c=nsnContactTec[i].Email__c;
                   tempEmailContact.MCAR_First_Name__c=nsnContactTec[i].First_Name__c;

                  tempEmailContact.MCAR_Role__c=nsnContactTec[i].Role__c; 
                  tempEmailContact.MCAR_Topic__c='TEC';
                  tempEmailContact.MCAR__c=currentMCAR2.id;
                  tempEmailContact.MCAR_Contact_Type__c='NSN Contact';   
                  addEmailListNSN.add(tempEmailContact); 
                   
               }
          
          }
          
         List<MCAR_NSN_Contacts__c> nsnContactCom;  
          if (selectNSNCode != null)
          {
              if (selectNSNCode.COM__c != null)  
                  nsnContactCom = [select id, COM__c, Tec__c, Role__c, Status__c, First_Name__c, Last_Name__c, Email__c, Domain__c from MCAR_NSN_Contacts__c where Domain__c='COM' and COM__c=:selectNSNCode.COM__c  ];
              if (nsnContactCom != null && nsnContactCom.size() > 0 )
              {
                  MCAR_NSN_Contacts__c cntp = nsnContactCom.get(0);
                   for(Integer i = 0; i < nsnContactCom.size(); i++){
                  MCAR_Email_List__c tempEmailContact = new MCAR_Email_List__c();
                       tempEmailContact.MCAR_Email__c=nsnContactCom[i].Email__c;
                       tempEmailContact.MCAR_First_Name__c=nsnContactCom[i].First_Name__c;
    
                      tempEmailContact.MCAR_Role__c=nsnContactCom[i].Role__c; 
                      tempEmailContact.MCAR_Topic__c='COM';
                      tempEmailContact.MCAR__c=currentMCAR2.id;
                      tempEmailContact.MCAR_Contact_Type__c='NSN Contact'; 
                      addEmailListNSN.add(tempEmailContact); 
                       
                   }
              
              }
          }
          List<MCAR_NSN_Contacts__c> nsnContactSupplier;
          if(currentMCAR2.MCAR_Part_Enterprise_ID__c != null)  
              nsnContactSupplier = [select id, COM__c, Tec__c, Role__c, Status__c, First_Name__c, Last_Name__c, Email__c, Domain__c, Enterprise_ID__c from MCAR_NSN_Contacts__c where Domain__c='Supplier' and Enterprise_ID__c =: currentMCAR2.MCAR_Part_Enterprise_ID__c  ];
          if (nsnContactSupplier != null && nsnContactSupplier.size() > 0 )
          {
              MCAR_NSN_Contacts__c cntp = nsnContactSupplier .get(0);
               for(Integer i = 0; i < nsnContactSupplier.size(); i++){
               MCAR_Email_List__c tempEmailContact = new MCAR_Email_List__c();
                   tempEmailContact.MCAR_Email__c=nsnContactSupplier [i].Email__c;
                   tempEmailContact.MCAR_First_Name__c=nsnContactSupplier [i].First_Name__c;

                  tempEmailContact.MCAR_Role__c=nsnContactSupplier [i].Role__c; 
                  tempEmailContact.MCAR_Topic__c='COM';
                  tempEmailContact.MCAR__c=currentMCAR2.id;
                  tempEmailContact.MCAR_Contact_Type__c='NSN Contact';  
                  addEmailListNSN.add(tempEmailContact); 
                   
               }
          
          }


          // Add the sqe based on facility
          
          List<MCAR_Facility_Contact__c> faclityContact = new List<MCAR_Facility_Contact__c>();
          if(currentMCAR2.MCAR_Facility__c != null) 
              faclityContact = [select MCAR_User__r.Name,id, Name, Email__c, MCAR_Contact_Type__c, Facility__r.id from MCAR_Facility_Contact__c where Facility__r.id =: currentMCAR2.MCAR_Facility__c ]; 
              if(faclityContact.size()>0)
              {          
                   MCAR_Facility_Contact__c tmpContact1 = faclityContact.get(0);  
              } 
              for(Integer r = 0; r < faclityContact.size(); r++){
              MCAR_Email_List__c tempFacilityContact = new MCAR_Email_List__c();
                  tempFacilityContact.MCAR_Email__c= faclityContact[r].Email__c;
                  tempFacilityContact.MCAR_First_Name__c= faclityContact[r].Name;
              tempFacilityContact.MCAR_Role__c= faclityContact[r].MCAR_Contact_Type__c; 
              tempFacilityContact.MCAR_Topic__c='SQE';
              tempFacilityContact.MCAR__c=currentMCAR2.id;
              tempFacilityContact.MCAR_Contact_Type__c='NSN Contact';   
              tempFacilityContact.MCAR_User_Account__c=faclityContact[r].MCAR_User__r.Name;  
              addEmailListNSN.add(tempFacilityContact); 
           }
     return addEmailListNSN;  
    }
  /*
SendEmail - function for Sending email for selected contact and storing history
*/

    public PageReference SendEmail() 
    {

      for(Integer r = 0; r < addEmailListNSN.size(); r++)
      {
          if(addEmailListNSN[r].MCAR_Selected__c)
          {
               addEmailListfinal.add(addEmailListNSN[r]); 
          }
      }
      for(Integer r = 0; r < addEmailListMFR.size(); r++)
      {
          if(addEmailListMFR[r].MCAR_Selected__c)
          {
               addEmailListfinal.add(addEmailListMFR[r]); 
          }
      }
     /* for(Integer r = 0; r < addEmailListOther.size(); r++)
      {
          if(addEmailListOther[r].MCAR_Selected__c)
          {
               addEmailListfinal.add(addEmailListOther[r]); 
          }
      }
      for(Integer r = 0; r < addEmailListFGM.size(); r++)
      {
          if(addEmailListFGM[r].MCAR_Selected__c)
          {
               addEmailListfinal.add(addEmailListFGM[r]); 
          }
      } */
      
        if(addEmailListfinal.size()>0 || Suzhou == true || Email1 == true || Email2 == true || Email3 == true || Email4 == true || Email5 == true || Email6 == true || Email7 == true || Email8 == true)
        {
            /*Database.SaveResult[] lsr = Database.insert(addEmailListfinal,false);
            for(Database.SaveResult sr : lsr)
            {
                if(!sr.isSuccess())
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Failed to add entered data.')); 
                    return null;
                }
            } */
            sendNotificationMail(); 
             Datetime cDT = System.now();
             
             

    
    
            currentMCAR2.Re_Notify__c = 'MCAR Email Re-notification email sent on ' + cDT.format('MM/dd/yyyy hh:mm:ss a'); 
            
            
            update currentMCAR2;
         }
         else
         {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'Select contact for sending e-mail.'));          
            addEmailListNSN= new List<MCAR_Email_List__c>();
            addEmailListMFR= new List<MCAR_Email_List__c>();
            return null;
         }   
              
              PageReference ref = new PageReference('/' + strMCARId);
              ref.setRedirect(true);
              return ref;
         
    }
/*
back - function is used for redirecting control to MCAR page
*/
    public PageReference back() {
        PageReference ref = new PageReference('/' + strMCARId);
          ref.setRedirect(true);
          return ref;
    }
/*
sendNotificationMail - function for Sending email for selected contact
                        this fuction used in SendEmail function.
*/
 public void sendNotificationMail()
    {        
            MCAR__c currentMCAR = [select id, CreatedById, Suzhou__c ,Beijing__c,Tianjin__c,Shanghai__c,Chennai__c,Oulu__c,Bruchsal__c,MCAREmail1__c, MCAREmail2__c, MCAREmail3__c, MCAREmail4__c, MCAREmail5__c, MCAREmail6__c, MCAREmail7__c, MCAREmail8__c,MCARName2__c from MCAR__C where id=:strMCARId ];       
            List<String> toEmailListNSN = new List<String>();
           // List<String> toEmailListManufacturer = new List<String>();
          /*  if(currentMCAR.MCAR_CC_Email__c != null) 
                toEmailListNSN.add(currentMCAR.MCAR_CC_Email__c );
            if(currentMCAR.MCAR_CC_Email2__c != null) 
                toEmailListNSN.add(currentMCAR.MCAR_CC_Email2__c );
            if(currentMCAR.MCAR_CC_Email3__c != null) 
                toEmailListNSN.add(currentMCAR.MCAR_CC_Email3__c );
            if(currentMCAR.MCAR_CC_Email4__c != null) 
                toEmailListNSN.add(currentMCAR.MCAR_CC_Email4__c );
            if(currentMCAR.MCAR_CC_Email5__c != null) 
                toEmailListNSN.add(currentMCAR.MCAR_CC_Email5__c );

            if(Email1) 
                toEmailListNSN.add(currentMCAR.MCAREmail1__c );
            if(Email2) 
                toEmailListNSN.add(currentMCAR.MCAREmail2__c );
            if(Email3) 
                toEmailListNSN.add(currentMCAR.MCAREmail3__c );
            if(Email4) 
                toEmailListNSN.add(currentMCAR.MCAREmail4__c );
            if(Email5) 
                toEmailListNSN.add(currentMCAR.MCAREmail5__c );   
                if(Email6) 
                toEmailListNSN.add(currentMCAR.MCAREmail6__c );                
             if(Email7) 
                toEmailListNSN.add(currentMCAR.MCAREmail7__c ); 
                if(Email8) 
                toEmailListNSN.add(currentMCAR.MCAREmail8__c ); */               
               
  if(currentMCAR.MCAREmail1__c != null && currentMCAR.MCAREmail1__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail1__c);
  if(currentMCAR.MCAREmail2__c != null && currentMCAR.MCAREmail2__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail2__c);
            if(currentMCAR.MCAREmail3__c != null && currentMCAR.MCAREmail3__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail3__c);
            if(currentMCAR.MCAREmail4__c != null && currentMCAR.MCAREmail4__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail4__c);
            if(currentMCAR.MCAREmail5__c != null && currentMCAR.MCAREmail5__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail5__c);
            if(currentMCAR.MCAREmail6__c != null && currentMCAR.MCAREmail6__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail6__c);
            if(currentMCAR.MCAREmail7__c != null && currentMCAR.MCAREmail7__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail7__c);
            if(currentMCAR.MCAREmail8__c != null && currentMCAR.MCAREmail8__c != '')
                toEmailListNSN.add(currentMCAR.MCAREmail8__c);
           // if(Suzhou) 
                //toEmailListNSN.add(currentMCAR.Suzhou__c);
                   if(currentMCAR.Suzhou__c)
                toEmailListNSN.add('michael.x.yang@nokia.com');
                if(currentMCAR.Beijing__c)
                toEmailListNSN.add('xuejun.wang@nokia.com');
                if(currentMCAR.Tianjin__c)
                toEmailListNSN.add('weichong.tan@nokia.com');
                if(currentMCAR.Shanghai__c)
                toEmailListNSN.add('jose.menendez_herrero@nokia.com');
                if(currentMCAR.Chennai__c)
                toEmailListNSN.add('satendra.singh@nokia.com');
                if(currentMCAR.Oulu__c)
                toEmailListNSN.add('erja.sankari@nokia.com');
                if(currentMCAR.Bruchsal__c)
                toEmailListNSN.add('heinrich.jurtan@nokia.com');



            for(MCAR_Email_List__c selEmail :addEmailListfinal)
            {
                if (selEmail.MCAR_Email__c != null )
                {
                    toEmailListNSN.add(selEmail.MCAR_Email__c);
                }               
            } 
                   EmailTemplate emailTmpl = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_ReNotify_Email'];
                   Messaging.SingleEmailMessage mCARCreationEmail= new Messaging.SingleEmailMessage();
                   mCARCreationEmail.setToAddresses(toEmailListNSN);
                   mCARCreationEmail.setTargetObjectId(UserInfo.getUserId());                    
                   mCARCreationEmail.setWhatId(currentMCAR.id);    
                   mCARCreationEmail.setSaveAsActivity(false);
                   mCARCreationEmail.setTemplateId(emailTmpl.Id);  
                   Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mCARCreationEmail});
                   toEmailListNSN = new List<String>();
    }
/*
    Test class for this controller.
*/   
     static testmethod void test_MCAR_Email_List_en_Controller ()    
    {
    User DummyUser = new User();        
    DummyUser.LastName = 'adc';        
    DummyUser.FirstName = 'adc';        
    DummyUser.Alias = 'adc';        
    DummyUser.Email = 'a@a.a';        
    DummyUser.Username = 'a@a.a.adc';        
    DummyUser.CommunityNickname = 'a';      
    DummyUser.IsActive = TRUE;       
    DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;        
    DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';       
    DummyUser.LocaleSidKey = 'en_US';       
    DummyUser.EmailEncodingKey = 'ISO-8859-1';      
    DummyUser.LanguageLocaleKey = 'en_US';       
    insert DummyUser;                       
    
    User DummyUserManufacturer = new User();     
    DummyUserManufacturer .LastName = 'adcd';   
    DummyUserManufacturer .FirstName = 'adcd';      
    DummyUserManufacturer .Alias = 'adcd';      
    DummyUserManufacturer .Email = 'ab@ab.ab';    
    DummyUserManufacturer .Username = 'ab@ab.ab.adcb';     
    DummyUserManufacturer .CommunityNickname = 'ab';        
    DummyUserManufacturer .IsActive = TRUE;        
    DummyUserManufacturer .ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%Nokia MCAR External Supplier%' LIMIT 1].Id;       
    DummyUserManufacturer .TimeZoneSidKey = 'Asia/Kamchatka';       
    DummyUserManufacturer .LocaleSidKey = 'en_US';        
    DummyUserManufacturer .EmailEncodingKey = 'ISO-8859-1';        
    DummyUserManufacturer .LanguageLocaleKey = 'en_US';       
    insert DummyUserManufacturer ;  
               
    User owner = DummyUser;    
    User manufacturerUser  =DummyUserManufacturer;  
            
    RecordType rtDraftMCAR = [select Id from RecordType where SObjectType='MCAR__c' and Name='Draft MCAR' limit 1];     
    RecordType rtOpenMCAR = [select Id from RecordType where SObjectType='MCAR__c' and Name='Open MCAR' limit 1];    
    MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c (Name='Test Systems Inc.',ownerId=owner.Id, MCAR_Supplier_Admin__c=manufacturerUser.id );    
    insert manufacturer;    
    // Manufacturer is wrong here      
   MCAR_Manufacturer_Site__c testSite = new MCAR_Manufacturer_Site__c(name='Test',Manufacturer_Name__c=manufacturer.id, MCAR_Manufacturer_Site_Address__c='Test', Zip__c = '12345'  );        
    insert testSite;        
    //MCAR_Manufacturer_Site__c=testSite.id,      
    MCAR_Manufacturer_Contact__c manufacturerContact = new MCAR_Manufacturer_Contact__c(Manufacturer_Site__c=testSite.id, Name='First', Email__c='last@company.com', Manufacturer_Name__c=manufacturer.Id, ownerId=owner.Id, MCAR_User__c=manufacturerUser.id  );    
    insert manufacturerContact;     
           
    NSN_Part__c testNSNPart = new NSN_Part__c(Name='1234567', Description__c='t', NSN_Part_Lifecycle__c='t', NSN_Part_Type__c='t', NSN_Part_Family__c='t', NSN_Part_Recomendation__c='Y', Tec__c='TEC1',Com__c='COM1' );     
    insert testNSNPart;         
    MCAR_MEPS__c testMCARMeps =new MCAR_MEPS__c(Name='1234567',MCAR_NSN_Part__c=testNSNPart.id , MCAR_Mfg_Part_Number__c='1234', MCAR_MEPS_Enterprise_ID__c='TESTEID', Manufacturer_Name__c=manufacturer.Id);    
    insert testMCARMeps;        
    MCAR_NSN_Contacts__c nsnContactPart = new MCAR_NSN_Contacts__c (Domain__c='COM', Com__c='COM1', Name='123', Contact_External_Id__c=1122223, First_Name__c='First', Last_Name__c='Last', email__c='last@company.com' );    
    insert nsnContactPart;     
    MCAR_NSN_Contacts__c nsnContactPart2 = new MCAR_NSN_Contacts__c ( Domain__c='TEC', Tec__c='TEC1', Name='123', Contact_External_Id__c=1122222, First_Name__c='First', Last_Name__c='Last', email__c='last@company.com');    
    insert nsnContactPart2;    
    MCAR_NSN_Contacts__c nsnContactPart3 = new MCAR_NSN_Contacts__c ( Domain__c='Supplier', Enterprise_ID__c='TESTEID', Name='123', Contact_External_Id__c=1122221, First_Name__c='First', Last_Name__c='Last', email__c='last@company.com');    
    insert nsnContactPart3;     
    //MCAR_NSN_Part_Contacts__c testNSNPartContact= new MCAR_NSN_Part_Contacts__c(    MCAR_NSN_Id__c= nsnContactPart.id, MCAR_NSN_Part__c=testNSNPart.id, MCAR_Role__c='test', MCAR_Topic__c='test' );     
    //insert testNSNPartContact;        
    MCAR_Facility__c testFacility = new MCAR_Facility__c(Name ='Chennai', MCAR_Facility_Company__c='NSN');    
    insert testFacility;       
    MCAR__c testMCAR = new MCAR__c(MCAR_Factory_GM_Email__c='test@test.com', MCAR_CC_Email__c='test@test.com', MCAR_CC_Email2__c='test@test.com',MCAR_CC_Email3__c='test@test.com',MCAR_CC_Email4__c='test@test.com',MCAR_CC_Email5__c='test@test.com', MCAR_Facility__c=testFacility.id,  MCAR_Status__c='Draft', MCAR_Failure_Type__c='Visual', MCAR_NSN_Code__c=testMCARMeps.id,MCAR_Severity_Level__c='Low',MCAR_Defect_Location__c='Production',MCAR_Defect_Quantity__c=4,MCAR_Product_Name__c='Test',MCAR_2D_Prob_Desc__c='Test',MCAR_2D_Analysis_Findings__c='Test',MCAR_3D_Days_Allowed__c='2',MCAR_4D_Days_Allowed__c='15',MCAR_5D_Days_Allowed__c='30',MCAR_6D_Days_Allowed__c='35',MCAR_7D_Days_Allowed__c='45',MCAR_Current_8D_Step__c='2D=Problem/Analysis', RecordTypeId=rtDraftMCAR.id );
    try{ insert testMCAR;} catch(Exception e){}             
    MCAR__c mcar = new MCAR__c();    
    PageReference pageRef = Page.MCAR_Email_List_Section;    
    Test.setCurrentPage(pageRef);    
    ApexPages.currentPage().getParameters().put('id',testMCAR.id); 
        MCAR_Email_List_en_Controller controller = new MCAR_Email_List_en_Controller();
        controller.sendNotificationMail();
        controller.back();
        controller.SendEmail();
        controller.getMCARNSNContactEmailList();
        controller.getMCARManufactureEmailList();
        
    }

}