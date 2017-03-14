public class MCAR_Email_List_Controller 
{
    List<MCAR_Email_List__c> nsnEmailList = new List<MCAR_Email_List__c>();
    List<MCAR_Email_List__c> NSPList = new List<MCAR_Email_List__c>();
    List<MCAR_Email_List__c> otherEmailList = new List<MCAR_Email_List__c>();
    List<MCAR_Manufacturer_Site__c> siteList = new List<MCAR_Manufacturer_Site__c>();
    List<MCAR_Selected_Sites__c> selectedSiteList = new List<MCAR_Selected_Sites__c>();
    List<MCAR_Selected_Sites__c> addManufacturerSiteList= new List<MCAR_Selected_Sites__c>();
    List<MCAR_Manufacturer_Contact__c> allManufactureContact = new List<MCAR_Manufacturer_Contact__c>();
    String strMCARId; 
    boolean isgetContactsDisabled = true;
    boolean isEditAllowed = false;
    boolean isgSaveDisabled = true;
    boolean isManufactureContactDisabled = true;
    boolean isNSNContactsDisabled = true;
    boolean isNotifyDisabled = true;  
    boolean isFactoryGMContactDisabled = true; 
    boolean isManufacturerStatusDisabled = true;
    boolean isFacilityContactUserStatus = true;     
    MCAR__c currentMCAR2; 
    public MCAR__c mcar {get;set;}
    
    public boolean getisFactoryGMContactDisabled ()
    {
        return isFactoryGMContactDisabled ;
    }
    public boolean getisManufactureContactDisabled()
    {
        return isManufactureContactDisabled;
    }
    public boolean getContactsEnabled()
    {
        return isgetContactsDisabled ;
    }
    public boolean getisNSNContactsDisabled()
    {
        return isNSNContactsDisabled ;
    }
    public boolean getisgSaveDisabled()
    {
        return isgSaveDisabled ;
    }
    public boolean getisNotifyDisabled()
    {
        return isNotifyDisabled ;
    }
    public boolean getisManufacturerStatusDisabled()
    {
    return isManufacturerStatusDisabled;
    }
    public boolean getisFacilityContactUserStatus()
    {
    return isFacilityContactUserStatus;
    }
    public MCAR_Email_List_Controller(ApexPages.StandardController controller) 
    {
        mcar = new MCAR__c();
        strMCARId= System.currentPagereference().getParameters().get('id');  
        currentMCAR2 = [select id, MCAR_Index_NSN_Code__c , MCAR_Part_Enterprise_ID__c, MCAR_Facility__c, MCAR_NSN_Code__c, CreatedById, OwnerId, MCAR_Manufacturer__c, MCAR_Status__c , MCAR_Severity_Level__c , MCAR_Defect_Location__c , isContactCreatedForMCAR__c from MCAR__C where id=:strMCARId limit 1];       
         mcar = [select Suzhou__c , Beijing__c , Tianjin__c ,Shanghai__c , Chennai__c , Oulu__c , Bruchsal__c ,FLEX_Tzcew__c,FOX_Shanghai__c,SANM_Chennai__c,SANM_Haukipudas__c,SANM_Kunshan__c,
                    MCARName1__c , MCAREmail1__c , MCARName2__c , MCAREmail2__c ,MCARName3__c , MCAREmail3__c ,    
                    MCARName4__c , MCAREmail4__c , MCARName5__c , MCAREmail5__c ,MCARName6__c , MCAREmail6__c ,
                    MCARName7__c , MCAREmail7__c ,MCARName8__c , MCAREmail8__c 
                    from MCAR__c where Id =: strMCARId];
         System.Debug('MCAR Values are...........>'+mcar);              
        
        if (UserInfo.getUserId() == currentMCAR2.CreatedById ||UserInfo.getUserId() == currentMCAR2.OwnerId)
        {
            isEditAllowed = true;
        } 
        Profile extsupp = [SELECT Id FROM Profile WHERE Name='Nokia MCAR External Supplier'];

        if (UserInfo.getProfileId() == extsupp.Id)
        {
            isNSNContactsDisabled = false;
        }


        if(currentMCAR2.MCAR_Status__c == 'Draft' && currentMCAR2.isContactCreatedForMCAR__c != 'Yes')
        {
            
          siteList = [select id, MCAR_Manufacturer_Site_Address__c, Name from MCAR_Manufacturer_Site__c where  Manufacturer_Name__r.id =: currentMCAR2.MCAR_Manufacturer__c ]; 
          if( siteList.size() > 0)
          {
                MCAR_Manufacturer_Site__c site = siteList.get(0);
                for(Integer p = 0; p < siteList.size(); p++){
                MCAR_Selected_Sites__c tmpSelectedSite = new MCAR_Selected_Sites__c();
                tmpSelectedSite.MCAR_Sel_Man_Site_Address__c = siteList.get(p).MCAR_Manufacturer_Site_Address__c;
                tmpSelectedSite.MCAR_Sel_Manuf_Site__c = siteList.get(p).Name;
                tmpSelectedSite.MCAR_Man_Site_IsSelected__c = false;
                tmpSelectedSite.MCAR_No__c = currentMCAR2.id;
                addManufacturerSiteList.add(tmpSelectedSite); 
                } 
          }
          selectedSiteList = addManufacturerSiteList; 
          System.Debug('####################### BIG ISSUE ############################ ' + selectedSiteList );
  
  
          if(isEditAllowed )
          {
              isgetContactsDisabled = false;
              isgSaveDisabled = false;
              isManufactureContactDisabled = false;
          } 
          isFactoryGMContactDisabled = false;
          
         // ADDED NEW CODE FOR SELECTING ALL CONTACTS AT THE SAME TIME...
          getContacts();
        }

        else
        {
            System.Debug('############## In Elese ###################');            
            boolean CommonFlagForFactorySelection = true;
            /*New Factory GM's are added by kiran on 31-10-2013*/
            if(mcar.Bruchsal__c || mcar.Beijing__c  || mcar.Beijing__c || mcar.Oulu__c || mcar.Chennai__c || mcar.Shanghai__c || mcar.Suzhou__c || mcar.Tianjin__c || mcar.FLEX_Tzcew__c || mcar.FOX_Shanghai__c || mcar.SANM_Haukipudas__c|| mcar.SANM_Kunshan__c || mcar.SANM_Chennai__c)
                CommonFlagForFactorySelection  = true;
            else
                CommonFlagForFactorySelection  = false;
                
            if((currentMCAR2.MCAR_Status__c == 'Open')&& currentMCAR2.MCAR_Severity_Level__c == 'High' && 
                (currentMCAR2.MCAR_Defect_Location__c == 'Incoming' || currentMCAR2.MCAR_Defect_Location__c == 'Production') && 
                    (CommonFlagForFactorySelection==false))
                {    
                  isFactoryGMContactDisabled = false;
                  isgSaveDisabled = false;
                }  
            else
            {
                  isFactoryGMContactDisabled = true;  
                  isgSaveDisabled = true;
            }      
            isManufactureContactDisabled = True;  
            isNSNContactsDisabled = True;
            List<MCAR_Selected_Sites__c> siteselected = [select id, MCAR_Man_Site_IsSelected__c, MCAR_Sel_Man_Site_Address__c, Name, MCAR_Sel_Manuf_Site__c, MCAR_No__c  from MCAR_Selected_Sites__c where  MCAR_No__c =: currentMCAR2.id and MCAR_Man_Site_IsSelected__c =: true];
            NSNEmailList= [select id,MCAR_First_Name__c,MCAR_Last_Name__c,MCAR_Role__c,MCAR_Topic__c,MCAR_User_Account__c,Supplier_Manager__c ,MCAR_Email__c,MCAR_Contact_Type__c,MCAR_Selected__c,MCAR_User_Status__c , name from MCAR_Email_List__c where MCAR__c =: strMCARId and MCAR_Contact_Type__c=:'NSN' and MCAR_Role__c!='SQS' and MCAR_Role__c!='PSM']; 
            system.debug('NSNEmailList Values are*************'+NSNEmailList);
            OtherEmailList= [select MCAR_User_Account__c,id, MCAR_Contact_Type__c, MCAR_First_Name__c, MCAR_Email__c, MCAR_Selected__c, name, MCAR_Last_Name__c, MCAR_Role__c, MCAR_Topic__c,MCAR_User_Status__c from MCAR_Email_List__c where MCAR__c =: strMCARId and MCAR_Contact_Type__c=:'OTHER' and MCAR_Role__c != 'SQS' and MCAR_Role__c != 'PSM' ]; 
            system.debug('Other Email List Values are*************'+OtherEmailList);
            selectedSiteList = siteselected ; 
           
                      
          
  /*for(MCAR_Email_List__c melc : NSNEmailList){
              if(melc.MCAR_Role__c=='SQS'|| melc.MCAR_Role__c=='PSM'){
                             continue;
                }
                   NSPList.add(melc);
            }
                
NSNEmailList = NSPList;  */  
            System.Debug('############## NSNEmailList ################### ' + NSNEmailList);
            System.Debug('############## OtherEmailList ###################' + OtherEmailList);
            //System.Debug('############## SQSList:: ###################' + NSPList);
            
            

        }
    }
    public PageReference Save()
    {
          Boolean turnpage = false;
            
          if(!mcar.Bruchsal__c && !mcar.Beijing__c && !mcar.Beijing__c && !mcar.Oulu__c && !mcar.Chennai__c && 
             !mcar.Shanghai__c && !mcar.Suzhou__c && !mcar.Tianjin__c && !mcar.FLEX_Tzcew__c && !mcar.FOX_Shanghai__c && !mcar.SANM_Chennai__c && !mcar.SANM_Haukipudas__c && !mcar.SANM_Kunshan__c && currentMCAR2.MCAR_Severity_Level__c == 'High' && 
             (currentMCAR2.MCAR_Defect_Location__c == 'Incoming' || currentMCAR2 .MCAR_Defect_Location__c == 'Production'))
              {
                  System.Debug('*************** Inside Codition ********************* ');
                  ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select atleast one Factory GM'));
                  turnpage = true;
              }
          else
              {
                  currentMCAR2.Bruchsal__c = mcar.Bruchsal__c ;
                  currentMCAR2.Beijing__c = mcar.Beijing__c;
                  currentMCAR2.Oulu__c = mcar.Oulu__c;
                  currentMCAR2.Chennai__c = mcar.Chennai__c;
                  currentMCAR2.Shanghai__c = mcar.Shanghai__c;
                  currentMCAR2.Suzhou__c = mcar.Suzhou__c;
                  currentMCAR2.Tianjin__c = mcar.Tianjin__c;
                  currentMCAR2.FLEX_Tzcew__c = mcar.FLEX_Tzcew__c;
                  currentMCAR2.FOX_Shanghai__c = mcar.FOX_Shanghai__c;
                  currentMCAR2.SANM_Chennai__c = mcar.SANM_Chennai__c;
                  currentMCAR2.SANM_Haukipudas__c = mcar.SANM_Haukipudas__c;
                  currentMCAR2.SANM_Kunshan__c = mcar.SANM_Kunshan__c;
                                    
              }    


        if(mcar.MCARName1__c != null && mcar.MCAREmail1__c == null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Email Address for contact 1'));
            // return null; 
            turnpage = true;
        }
        else if(mcar.MCARName1__c == null && mcar.MCAREmail1__c != null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Name in contact 1'));
            // return null; 
            turnpage = true;
        }
        
        if(mcar.MCARName2__c != null && mcar.MCAREmail2__c == null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Email Address for contact 2'));
                        // return null; 
            turnpage = true;

        }
        else if(mcar.MCARName2__c == null && mcar.MCAREmail2__c != null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Name in contact 2'));
                        // return null; 
            turnpage = true;
        }
        
        if(mcar.MCARName3__c != null && mcar.MCAREmail3__c == null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Email Address for contact 3'));
                        // return null; 
            turnpage = true;

        }
        else if(mcar.MCARName3__c == null && mcar.MCAREmail3__c != null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Name in contact 3'));
                        // return null; 
            turnpage = true;

        }
        
        if(mcar.MCARName4__c != null && mcar.MCAREmail4__c == null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Email Address for contact 4'));
                        // return null; 
            turnpage = true;

        }
        else if(mcar.MCARName4__c == null && mcar.MCAREmail4__c != null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Name in contact 4'));
                        // return null; 
            turnpage = true;

        }
        
        if(mcar.MCARName5__c != null && mcar.MCAREmail5__c == null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Email Address for contact 5'));
                        // return null; 
            turnpage = true;

        }
        else if(mcar.MCARName5__c == null && mcar.MCAREmail5__c != null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Name in contact 5'));
                        // return null; 
            turnpage = true;

        }
        
        if(mcar.MCARName6__c != null && mcar.MCAREmail6__c == null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Email Address for contact 6'));
                        // return null; 
            turnpage = true;

        }
        else if(mcar.MCARName6__c == null && mcar.MCAREmail6__c != null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Name in contact 6'));
                        // return null; 
            turnpage = true;

        }
        
        if(mcar.MCARName7__c != null && mcar.MCAREmail7__c == null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Email Address for contact 7'));
                        // return null; 
            turnpage = true;

        }
        else if(mcar.MCARName7__c == null && mcar.MCAREmail7__c != null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Name in contact 7'));
                        // return null; 
            turnpage = true;

        }
        
        if(mcar.MCARName8__c != null && mcar.MCAREmail8__c == null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Email Address for contact 8'));
                        // return null; 
            turnpage = true;

        }
        else if(mcar.MCARName8__c == null && mcar.MCAREmail8__c != null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Name in contact 8'));
                        // return null; 
            turnpage = true;

        }
        /************************************************* STORING MCAR ADDITIONAL CONTACT IN OBJECT START ************************************************/
        currentMCAR2.MCARName1__c = mcar.MCARName1__c ; 
        system.debug('Current kiran values are+++++++'+currentMCAR2);
        currentMCAR2.MCARName2__c = mcar.MCARName2__c ; 
        currentMCAR2.MCARName3__c = mcar.MCARName3__c ; 
        currentMCAR2.MCARName4__c = mcar.MCARName4__c ; 
        currentMCAR2.MCARName5__c = mcar.MCARName5__c ; 
        currentMCAR2.MCARName6__c = mcar.MCARName6__c ; 
        currentMCAR2.MCARName7__c = mcar.MCARName7__c ; 
        currentMCAR2.MCARName8__c = mcar.MCARName8__c ; 
        
        currentMCAR2.MCAREmail1__c = mcar.MCAREmail1__c;
        currentMCAR2.MCAREmail2__c = mcar.MCAREmail2__c;
        currentMCAR2.MCAREmail3__c = mcar.MCAREmail3__c;
        currentMCAR2.MCAREmail4__c = mcar.MCAREmail4__c;
        currentMCAR2.MCAREmail5__c = mcar.MCAREmail5__c;
        currentMCAR2.MCAREmail6__c = mcar.MCAREmail6__c;
        currentMCAR2.MCAREmail7__c = mcar.MCAREmail7__c;
        currentMCAR2.MCAREmail8__c = mcar.MCAREmail8__c;
        /************************************************* STORING MCAR ADDITIONAL CONTACT IN OBJECT END ************************************************/

        System.debug('=====' +nsnEmailList.size());
        System.debug(selectedSiteList.size());
        System.debug('----->'+otherEmailList.size());
        
         if(turnpage == false)
         {
        if(currentMCAR2.isContactCreatedForMCAR__c != 'Yes')
        {
            Database.SaveResult[] lsr = Database.insert(nsnEmailList,false);
            for(Database.SaveResult sr : lsr)
            {
                if(sr.isSuccess())
                {} 
                else
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Failed to add entered data.')); 
                }
            }    
            Database.SaveResult[] lsr4 = Database.insert(selectedSiteList,false);
            for(Database.SaveResult sr4 : lsr4)
            {
                if(sr4.isSuccess())
                {} 
                else
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Failed to add entered data.')); 
                }
            }    
    
            Database.SaveResult[] lsr2 = Database.insert(otherEmailList,false);
            for(Database.SaveResult sr2 : lsr2)
            {
                if(sr2.isSuccess())
                {} 
                else
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Failed to add entered data.')); 
                }
            }    
         }
         else if(currentMCAR2.isContactCreatedForMCAR__c == 'Yes')
         {
             update nsnEmailList;
             update selectedSiteList;
             update otherEmailList;
         }
            
        currentMCAR2.isContactCreatedForMCAR__c = 'Yes';
        Database.SaveResult lsr3 = Database.update(currentMCAR2,false);
        if(lsr3.isSuccess())
            {
                        
            } 
            else
            {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Failed to add entered data.')); 
            }
            
         PageReference ref = new PageReference('/' + strMCARId);
        
             ref.setRedirect(true);
             return ref;   
         }    
         else
             return null;
    }  
    public List<MCAR_Selected_Sites__c> getSelectedSiteList ()
    {return  selectedSiteList ;} 

    public List<MCAR_Email_List__c> getNSNEmailList()
    {return  nsnEmailList;} 

    public List<MCAR_Email_List__c> getOtherEmailList()
    {return  otherEmailList;} 

    public void getContacts()
    {
         List<MCAR_Manufacturer_Contact__c>  contactId = new List<MCAR_Manufacturer_Contact__c>(); 
         List<MCAR_Email_List__c> addEmailListNSN= new List<MCAR_Email_List__c>();
         List<MCAR_Email_List__c> addEmailListMFR= new List<MCAR_Email_List__c>();
         
         Set<String> selectedsiteid = new Set<String>();
         if(selectedSiteList.size() > 0 )
         {
             MCAR_Selected_Sites__c selsite =  selectedSiteList.get(0); 
         }
         for (Integer l=0; l< selectedSiteList.size(); l++)
         {
                if(selectedSiteList[l].MCAR_Man_Site_IsSelected__c )
                {
                 selectedsiteid.add(selectedSiteList[l].MCAR_Sel_Manuf_Site__c); 
                }                      
         } 
         if(currentMCAR2.MCAR_Manufacturer__c !=null)           
         {
          contactId =  [SELECT MCAR_User__r.Name,Email__c, Name, Contact_Type__c, Id, Manufacturer_Name__r.Id,Manufacturer_Name__r.Supplier_Manager__c, Manufacturer_Site__r.Name,MCAR_User_Status__c FROM MCAR_Manufacturer_Contact__c WHERE (MCAR_Manufacturer_Contact__c.Manufacturer_Name__r.Id=: currentMCAR2.MCAR_Manufacturer__c) ];        //and (Manufacturer_Site__r.Name in :selectedsiteid)
          System.Debug('$$$$$$$$$$$$$$$$$$$$$$ contactId $$$$$$$$$$$$$$$$$$$$ ' + contactId);
         } 
          if (contactId!= null && contactId.size() > 0)
          {
              MCAR_Manufacturer_Contact__c cnt = contactId.get(0);          
              for(Integer i = 0; i < contactId.size(); i++){
              MCAR_Email_List__c tempEmailContact = new MCAR_Email_List__c();
              tempEmailContact.MCAR_Email__c= contactId[i].Email__c;
              tempEmailContact.MCAR_First_Name__c=contactId[i].Name;
              tempEmailContact.MCAR_Role__c=contactId[i].MCAR_User__r.Name; 
              tempEmailContact.MCAR_Topic__c='Manufacturer Contact';
              tempEmailContact.MCAR__c=currentMCAR2.id;
              tempEmailContact.MCAR_Contact_Type__c='OTHER';
              tempEmailContact.MCAR_User_Status__c = contactId[i].MCAR_User_Status__c;
              tempEmailContact.Supplier_Manager__c = contactId[i].Manufacturer_Name__r.Supplier_Manager__c;
              //tempEmailContact.ManufactureSiteName__c = 'xyz';
              //System.debug(' the name are   '+contactId[i].Manufacturer_Site__r.Name);                    
              addEmailListMFR.add(tempEmailContact); 
              }      
          }
          
          NSN_Part__c selectNSNCode;
          List<MCAR_NSN_Contacts__c> nsnContactTec;
          if (currentMCAR2.MCAR_Index_NSN_Code__c != null)
          //if (currentMCAR2.MCAR_NSN_Code__c != null)
              selectNSNCode = [select id, COM__c, TEC__c, Name from NSN_Part__C where Name =: currentMCAR2.MCAR_Index_NSN_Code__c limit 1 ];
              //selectNSNCode = [select id, COM__c, TEC__c, Name from NSN_Part__C where Name =: currentMCAR2.MCAR_NSN_Code__c limit 1 ];
              System.debug('##################selectNSNCode##############' +selectNSNCode);
          if (selectNSNCode != null)
              nsnContactTec = [select id, COM__c, Tec__c, Role__c, Status__c, First_Name__c,Supplier_Manager__c, Last_Name__c, Email__c, Domain__c from MCAR_NSN_Contacts__c where Domain__c='TEC' and Tec__c=:selectNSNCode.TEC__c  and Role__c != 'SQS' and Role__c != 'PSM' ];
               System.debug('##################nsnContactTec##############' +nsnContactTec);
          if (nsnContactTec != null && nsnContactTec.size() > 0 )
          {
              MCAR_NSN_Contacts__c cntp = nsnContactTec .get(0);
               for(Integer i = 0; i < nsnContactTec.size(); i++){
               MCAR_Email_List__c tempEmailContact = new MCAR_Email_List__c();
                  tempEmailContact.MCAR_Email__c=nsnContactTec[i].Email__c;
                  tempEmailContact.MCAR_First_Name__c=nsnContactTec[i].First_Name__c;
                  tempEmailContact.MCAR_Role__c=nsnContactTec[i].Role__c; 
                  tempEmailContact.Supplier_Manager__c=nsnContactTec[i].Supplier_Manager__c;  //Commented on 01-March-2015 for rebranding
                  tempEmailContact.MCAR_Topic__c='TEC';
                  tempEmailContact.MCAR__c=currentMCAR2.id;
                  tempEmailContact.MCAR_Contact_Type__c='NSN';          
                  addEmailListNSN.add(tempEmailContact); 
               }
          }
          List<MCAR_NSN_Contacts__c> nsnContactCom;
          if(selectNSNCode!=null)
          {
          if (selectNSNCode.COM__c != null)  
              nsnContactCom = [select id, COM__c, Tec__c, Role__c, Status__c, First_Name__c, Last_Name__c, Email__c, Domain__c from MCAR_NSN_Contacts__c where Domain__c='COM' and COM__c=:selectNSNCode.COM__c  and Role__c != 'SQS' and Role__c != 'PSM'  ];
          }    
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
                  tempEmailContact.MCAR_Contact_Type__c='NSN';          
                  addEmailListNSN.add(tempEmailContact); 
               }
          }
          List<MCAR_NSN_Contacts__c> nsnContactSupplier;
          System.Debug(' &&&&&&&&&&&&&&&&& MCAR_Part_Enterprise_ID__c &&&&&&&&&&& ' + currentMCAR2.MCAR_Part_Enterprise_ID__c);
          if(currentMCAR2.MCAR_Part_Enterprise_ID__c != null && currentMCAR2.MCAR_Part_Enterprise_ID__c != '')  
              {
                  nsnContactSupplier = [select id, COM__c, Tec__c, Role__c, Status__c, First_Name__c, Last_Name__c, Email__c, Domain__c, Enterprise_ID__c from MCAR_NSN_Contacts__c where Domain__c='Supplier' and Enterprise_ID__c =: currentMCAR2.MCAR_Part_Enterprise_ID__c  and Role__c != 'SQS' and Role__c != 'PSM' ];
              }                    
          if (nsnContactSupplier != null && nsnContactSupplier.size() > 0 )
          {
              MCAR_NSN_Contacts__c cntp = nsnContactSupplier .get(0);
               for(Integer i = 0; i < nsnContactSupplier .size(); i++){
               MCAR_Email_List__c tempEmailContact = new MCAR_Email_List__c();
              
                   tempEmailContact.MCAR_Email__c=nsnContactSupplier [i].Email__c;
                   tempEmailContact.MCAR_First_Name__c=nsnContactSupplier [i].First_Name__c;
                  tempEmailContact.MCAR_Role__c=nsnContactSupplier [i].Role__c; 
                  tempEmailContact.MCAR_Topic__c='COM';
                  tempEmailContact.MCAR__c=currentMCAR2.id;
                  system.debug('EmailContact' +  tempEmailContact.MCAR__c );
                  tempEmailContact.MCAR_Contact_Type__c='NSN';          
                  addEmailListNSN.add(tempEmailContact); 
               }
          }
          List<MCAR_Facility_Contact__c> faclityContact = new List<MCAR_Facility_Contact__c>();
          if(currentMCAR2.MCAR_Facility__c != null) 
              faclityContact = [select MCAR_User__r.Name,id, Name, Email__c, MCAR_Contact_Type__c, Facility__r.id,MCAR_User_Status__c from MCAR_Facility_Contact__c where Facility__r.id =: currentMCAR2.MCAR_Facility__c ]; 
              if(faclityContact.size()>0)
              {          
                   MCAR_Facility_Contact__c tmpContact1 = faclityContact.get(0);  
              } 
              for(Integer r = 0; r < faclityContact.size(); r++){
              MCAR_Email_List__c tempFacilityContact = new MCAR_Email_List__c();
              tempFacilityContact .MCAR_Email__c= faclityContact[r].Email__c;
              tempFacilityContact .MCAR_First_Name__c= faclityContact[r].Name;
              System.debug('facility contact =='+faclityContact[r].Name);
              tempFacilityContact.MCAR_Role__c= faclityContact[r].MCAR_Contact_Type__c; 
              tempFacilityContact.MCAR_Topic__c='SQE';
              tempFacilityContact.MCAR__c=currentMCAR2.id;
              tempFacilityContact.MCAR_Contact_Type__c='NSN'; 
              tempFacilityContact.MCAR_User_Account__c=faclityContact[r].MCAR_User__r.Name;   
                 tempFacilityContact.MCAR_User_Status__c = faclityContact[r].MCAR_User_Status__c;                  
              addEmailListNSN.add(tempFacilityContact); 
           }
       //Below lines from 532 to 555 are added by Kiran Kumar on 26-03-2015
       List<SupplierContacts__c> supplierContact = new List<SupplierContacts__c>();
       if(currentMCAR2.MCAR_Part_Enterprise_ID__c != null){
               /*supplierContact =[SELECT Name,Email__c,Supplier_Manager__c,MCAR_User_Account__r.Name,MCAR_User_Status__c,SupplierManagerTitle__c FROM SupplierContacts__c where Manufacturer_Name__r.id=:currentMCAR2.MCAR_Manufacturer__c];*/
               list<MCAR_Manufacturer__c> mcarManuListForNSNContacts = new list<MCAR_Manufacturer__c>();
               mcarManuListForNSNContacts = [select Email__c,Supplier_Manager__c,MCAR_User_Account__c,MCAR_User_Status__c,SupplierManagerTitle__c
                                                                                from MCAR_Manufacturer__c where ID =: currentMCAR2.MCAR_Manufacturer__c]; 
                                                                                
                        
                        MCAR_Email_List__c tempSupplierContact = new MCAR_Email_List__c();
                        tempSupplierContact .MCAR_Email__c                      = mcarManuListForNSNContacts[0].Email__c;
                        tempSupplierContact .MCAR_First_Name__c         = mcarManuListForNSNContacts[0].Supplier_Manager__c;
                        tempSupplierContact .MCAR_User_Account__c       = mcarManuListForNSNContacts[0].MCAR_User_Account__c;
                        tempSupplierContact .MCAR_User_Status__c        = mcarManuListForNSNContacts[0].MCAR_User_Status__c;
                        tempSupplierContact.MCAR__c                                     = currentMCAR2.id;
                        tempSupplierContact.MCAR_Contact_Type__c        = 'NSN'; 
                        tempSupplierContact.MCAR_Topic__c                       = 'SM';
                        tempSupplierContact.MCAR_Role__c                        = mcarManuListForNSNContacts[0].SupplierManagerTitle__c;
                        addEmailListNSN.add(tempSupplierContact);
                        NSNEmailList=addEmailListNSN;
                
       }
       /*
       if(supplierContact.size()>0)
              {          
                  SupplierContacts__c tmpContact2 = supplierContact.get(0);  
              } 
              
              for(Integer k = 0; k < supplierContact.size(); k++){
              MCAR_Email_List__c tempSupplierContact = new MCAR_Email_List__c();
              tempSupplierContact .MCAR_Email__c= supplierContact[k].Email__c;
              tempSupplierContact .MCAR_First_Name__c= supplierContact[k].Supplier_Manager__c;
              tempSupplierContact .MCAR_User_Account__c= supplierContact[k].MCAR_User_Account__r.Name;
              tempSupplierContact .MCAR_User_Status__c= supplierContact[k].MCAR_User_Status__c;
              tempSupplierContact.MCAR__c=currentMCAR2.id;
              tempSupplierContact.MCAR_Contact_Type__c='NSN'; 
              tempSupplierContact.MCAR_Topic__c='SM';
              tempSupplierContact.MCAR_Role__c=supplierContact[k].SupplierManagerTitle__c;
              system.debug('Supplier Manager Tiltle is *******>'+tempSupplierContact.MCAR_Role__c);
              //tempSupplierContact.Supplier_Manager__c = supplierContact[k].Supplier_Manager__c;
              System.debug('Supplier contact =='+supplierContact[k].Name);
              addEmailListNSN.add(tempSupplierContact);
              system.debug('EmailList values are+++++++'+addEmailListNSN);
              
               }
              NSNEmailList=addEmailListNSN; 
              system.debug('NSN EmailList values are+++++++'+NSNEmailList);
              */
       OtherEmailList= addEmailListMFR;
       isgSaveDisabled = false;
       }
    
    
    public PageReference cancel()
    {
            PageReference pageRef = new PageReference('/' + strMCARId);
            pageRef.setRedirect(true);
            return pageRef; 
    }             
   public void sendNotificationMail()
    {        
            List<String> toEmailListNSN = new List<String>();
            List<String> toEmailListManufacturer = new List<String>();
            MCAR__c currentMCAR = [select id, CreatedById, Suzhou__c , Beijing__c , Tianjin__c ,Shanghai__c , Chennai__c , Oulu__c , Bruchsal__c ,FLEX_Tzcew__c,FOX_Shanghai__c,SANM_Chennai__c,SANM_Haukipudas__c,SANM_Kunshan__c,
                                   MCAREmail1__c ,MCAREmail2__c ,MCAREmail3__c,MCAREmail4__c,MCAREmail5__c,MCAREmail6__c,MCAREmail7__c,MCAREmail8__c  from MCAR__C where id=:strMCARId ];                
            if(currentMCAR.Bruchsal__c)    
                toEmailListNSN.add('heinrich.jurtan@nokia.com'); 
            if(currentMCAR.Beijing__c)    
                toEmailListNSN.add('xuejun.wang@nokia.com');
            if(currentMCAR.Oulu__c)    
                toEmailListNSN.add('esa.myllyla@nokia.com');  
            if(currentMCAR.Chennai__c)    
                toEmailListNSN.add('satendra.singh@nokia.com'); 
            if(currentMCAR.Shanghai__c)    
                toEmailListNSN.add('jose.menendez_herrero@nokia.com'); 
            if(currentMCAR.Suzhou__c)
                toEmailListNSN.add('michael.x.yang@nokia.com');
               
                 if(currentMCAR.SANM_Kunshan__c)
                toEmailListNSN.add('larry.chung@sanmina.com');
              
            if(currentMCAR.Tianjin__c)     
                toEmailListNSN.add('weichong.tan@nokia.com');  
                // added by chandra
            if(currentMCAR.FLEX_Tzcew__c)
                toEmailListNSN.add('andrzej.polojko@flextronics.com');
                
             if(currentMCAR.FOX_Shanghai__c)
                  toEmailListNSN.add('maggie.df.yang@mail.foxconn.com');
                  
                      
             if(currentMCAR.SANM_Haukipudas__c)
                  toEmailListNSN.add('eeva-liisa.kylmanen@sanmina.com');
                  
                      
             if(currentMCAR.SANM_Chennai__c)
                  toEmailListNSN.add('muthu.sivan@sanmina.com');
                 // toEmailListNSN.add('kiran.2.kumar@atos.net');
                
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

            List<MCAR_Email_List__c>   emailListtobeSent= [select id, MCAR_Topic__c, MCAR_Email__c, MCAR_Selected__c, name, MCAR_Contact_Type__c from MCAR_Email_List__c where MCAR__c =: strMCARId and MCAR_Selected__c =: true]; 
            for(MCAR_Email_List__c selEmail :emailListtobeSent)
            {
                if (selEmail.MCAR_Email__c != null )
                {
                    if(selEmail.MCAR_Contact_Type__c == 'OTHER')
                        toEmailListManufacturer.add(selEmail.MCAR_Email__c);    
                    else
                        toEmailListNSN.add(selEmail.MCAR_Email__c);
                 }               
            } 
                   Messaging.SingleEmailMessage mCARCreationEmail= new Messaging.SingleEmailMessage();
                   EmailTemplate emailTmpl = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_Notify_Email_NSN_Contacts'];
                   mCARCreationEmail.setToAddresses(toEmailListNSN); 
                   mCARCreationEmail.setTargetObjectId(currentMCAR.CreatedById); 
                   mCARCreationEmail.setWhatId(currentMCAR.id );    
                   mCARCreationEmail.setSaveAsActivity(false);
                   mCARCreationEmail.setTemplateId(emailTmpl.Id);  
                   Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mCARCreationEmail});
                   mCARCreationEmail= new Messaging.SingleEmailMessage();
                   emailTmpl = [SELECT Id FROM EmailTemplate WHERE developerName ='MCAR_Notify_Email_Manufacturer_Contact'];
                   mCARCreationEmail.setToAddresses(toEmailListManufacturer); 
                   mCARCreationEmail.setTargetObjectId(currentMCAR.CreatedById); 
                   mCARCreationEmail.setWhatId(currentMCAR.id );    
                   mCARCreationEmail.setSaveAsActivity(false);
                   mCARCreationEmail.setTemplateId(emailTmpl.Id);  
                   Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mCARCreationEmail});     
    } 
    
   /* static testmethod void test_MCAR_Email_List_Controller()    
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
    //boolean isFactoryGMContactDisabled = true;      
    RecordType rtDraftMCAR = [select Id from RecordType where SObjectType='MCAR__c' and Name='Draft MCAR' limit 1];     
    RecordType rtOpenMCAR = [select Id from RecordType where SObjectType='MCAR__c' and Name='Open MCAR' limit 1];    
    MCAR_Manufacturer__c manufacturer = new MCAR_Manufacturer__c (Name='Test Systems Inc.',ownerId=owner.Id, MCAR_Supplier_Admin__c=manufacturerUser.id );    
    insert manufacturer;    
    // Manufacturer is wrong here      
    MCAR_Manufacturer_Site__c testSite = new MCAR_Manufacturer_Site__c(name='Test',Manufacturer_Name__c=manufacturer.id, MCAR_Manufacturer_Site_Address__c='Test'  );        
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
    ApexPages.StandardController controller = new ApexPages.StandardController(mcar);    
    MCAR_Email_List_Controller MELC = new MCAR_Email_List_Controller(null);   
    try{ MELC.getSelectedSiteList();} catch(Exception e){}   
    try{MELC.getNSNEmailList();} catch(Exception e){}    
    try{MELC.getOtherEmailList();} catch(Exception e){}    
    try{MELC.getContacts();} catch(Exception e){}   
    try{MELC.Save();} catch(Exception e){}    
    try{MELC.cancel();} catch(Exception e){}    
    
   // MELC.getisFactoryGMContactDisabled(); 
    MELC.getContactsEnabled();    
    MELC.getisgSaveDisabled();    
    MELC.getisNotifyDisabled(); 
        
    }*/
}