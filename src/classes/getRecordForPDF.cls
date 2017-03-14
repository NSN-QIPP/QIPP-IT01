public class getRecordForPDF
{


    public Id currid {get; set;}
    public MCAR__c currentMCAR {get;set;}
    public String getOpenDate {get;set;}
    public String getDaysOpen {get;set;}
    public String ManufactureAcceptFault {get;set;} 
    public String NSN_Code {get;set;}
    public String Manufacture {get;set;}
    public String QRISName {get;set;}
    public String RMASentDate {get;set;}    
    public String MCAR2DFailureDate {get;set;}
    public String DueDate3D {get;set;}
    public String Approval3D {get;set;}
    public String DueDate4D {get;set;}
    public String Approval4D {get;set;}
    public String DueDate5D {get;set;}
    public String Approval5D {get;set;}
    public String DueDate6D {get;set;}
    public String Approval6D {get;set;}
    public String DueDate7D {get;set;}
    public String Approval7D {get;set;}
    public List<MCARNotesandAttchment> listNotesAttchment {get;set;}
    Public List<NSNContactDetails> FactoryGM {get;set;}
    Public List<MCAR_Email_List__c> OtherEmailList{get;set;}
    public List<MCAR_Email_List__c> NSNEmailList {get;set;}
    public List<NSNContactDetails> OtherContacts {get;set;}
    
    public getRecordForPDF(ApexPages.StandardController controller)
    {
        currid = ApexPages.currentPage().getParameters().get('id');
      
        if(currid != null){    
        currentMCAR = [select Name  ,MCAR_Days_MCAR_Open__c, H_Facility_Name__c , MCAR_Failure_Type__c , MCAR_Status__c , MCAR_Current_8D_Step__c ,
                       MCAR_Legacy_No__c , Legacy_Facility_Name__c , Legacy_IMS_Link__c ,
                       Contributor_1D__c , Contributor_8D__c , CreatedBy.Name , MCAR_Creation_Date_Status_Open__c ,
                       MCAR_Days_Open__c , Manufacture_Accepts_Fault__c  ,Legacy_Originator__c , LastModifiedBy.Name , Owner.Name , 
                       MCAR_NSN_Code__c , MCAR_Part_Description__c , MCAR_Part_Type__c , MCAR_Part_Family__c , MCAR_Mfg_Part_Number__c ,
                       Legacy_Manufacturer__c , Legacy_Part_Number__c , Manufacturer_Agrees_to_Pursue_Remaining__c ,Owner_Approval__c ,
                       Owner_Is_Mfr_Involved_in_MCAR_Case__c , Owner_Comments__c , 
                       MCAR_Manufacturer__c , MCAR_Part_Enterprise_ID__c , MCAR_Part_Lifecycle__c , MCAR_Part_Recommendation__c ,
                       MCAR_Severity_Level__c , MCAR_Defect_Quantity__c , MCAR_Defect_Location__c ,Manufacturer_Comments__c,
                       MCAR_Customer_Name__c,MCAR_Time_In_Service__c , MCAR_Location__c ,Component_Current_Location__c ,
                       Product_Technology__c,Product_Family__c,MCAR_Product_Name__c,MCAR_Serial_No__c , MCAR_Red_Tag_ID__c , 
                       MCAR_Lot_Nbr_Date_Cd__c , MCAR_Compl_Id__c , MCAR_Claims_Management_ID__c , QIRS_ID__c,
                       MCAR_Factory_GM_Email__c , MCAR_CC_Email__c , MCAR_CC_Email2__c , MCAR_CC_Email3__c , MCAR_CC_Email4__c , MCAR_CC_Email5__c ,
                       MCAR_Quantity_to_Sup__c , MCAR_RMA_Number__c , MCAR_RMA_Tracking_Number__c , MCAR_RMA_Sent_Date__c , RMA_Carrier__c , MCAR_RMA_Address__c ,
                       MCAR_Defect_PPM__c , MCAR_Exp_Cont_Hrs__c , MCAR_Est_Incident_Cost__c  ,
                       MCAR_2D_Prob_Desc__c , MCAR_2D_failure_date__c , MCAR_2D_prod_level_fail_mode_del__c , MCAR_Device_Level_Failure_Mode__c , Contributor_2D__c ,
                       MCAR_2D_Analysis_Findings__c , MCAR_2D_Internal_Containment__c , MCAR_2D_failure_spl_condition__c , MCAR_2D_FP_isolated_method__c , MCAR_2D_Analyst_findings__c ,
                       MCAR_Containment_Action__c , Contributor_3D__c , X3D_Manufacturer_Response_Complete__c ,X3D_Owner_Response__c,   X3D_Status__c,MCAR_3D_Due_Date__c,MCAR_3D_Days_Allowed__c,
                       MCAR_4D_Root_Cause__c,Contributor_4D__c ,X4D_Manufacturer_Response_Complete__c,X4D_Owner_Response__c,X4D_Owner_Approve_Reject__c,MCAR_4D_Due_Date__c,MCAR_4D_Days_Allowed__c,
                       MCAR_5D_Permanent_Corrective_Action__c,Contributor_5D__c,X5D_Manufacturer_Response_Complete__c,  X5D_Reason__c,X5D_Status__c,MCAR_5D_Due_Date__c,MCAR_5D_Days_Allowed__c,
                       MCAR_6D_Ver_Corr_Action_Eff__c,Contributor_6D__c,X6D_Manufacturer_Response_Complete__c,  X6D_Reason__c,X6D_Status__c,MCAR_6D_Due_Date__c,MCAR_6D_Days_Allowed__c,
                       MCAR_7D_Preventive_Actions__c,Contributor_7D__c,X7D_Manufacturer_Response_Complete__c,X7D_Reason__c,X7D_Status__c,MCAR_7D_Due_Date__c,   MCAR_7D_Days_Allowed__c,
                       Summary__c, Send_Closure_Notification__c,MCAR_NTF_Explanation__c,
                       Suzhou__c , Beijing__c , Tianjin__c ,Shanghai__c , Chennai__c , Oulu__c , Bruchsal__c , FLEX_Tzcew__c,FOX_Shanghai__c,SANM_Haukipudas__c,SANM_Kunshan__c,SANM_Chennai__c,
                       MCARName1__c , MCAREmail1__c , MCARName2__c , MCAREmail2__c ,MCARName3__c , MCAREmail3__c ,    
                       MCARName4__c , MCAREmail4__c , MCARName5__c , MCAREmail5__c ,MCARName6__c , MCAREmail6__c ,
                       MCARName7__c , MCAREmail7__c ,MCARName8__c , MCAREmail8__c ,
                       (Select Id, IsNote, Title From NotesAndAttachments)
                       from MCAR__C where Id =: currid];
         
         getOpenDateFunction();  
         getDaysOpenFunction();
         getAllContact();  
         getAllNotesandAttachments();
         FetchingNameOfRecord();
         }
    }
    
    public void getAllContact()
    {
        FactoryGM  = new List<NSNContactDetails>();
            if(currentMCAR.Suzhou__c)
            {
                NSNContactDetails Suzhou = new NSNContactDetails();
                Suzhou.Name = 'Michael Yang';
                Suzhou.Email = 'michael.x.yang@nokia.com';
                Suzhou.Factory = 'Suzhou';
                FactoryGM.add(Suzhou);
                Suzhou = null;
            }
            if(currentMCAR.Beijing__c)
            {
                NSNContactDetails Beijing = new NSNContactDetails();
                Beijing.Name = 'Adam Wang';
                Beijing.Email = 'xuejun.wang@nokia.com';
                Beijing.Factory = 'Beijing';
                FactoryGM.add(Beijing);
                Beijing = null;
            }
            if(currentMCAR.Tianjin__c)
            {
                NSNContactDetails Tianjin = new NSNContactDetails();
                Tianjin.Name = 'Weichong Tan';
                Tianjin.Email = 'weichong.tan@nokia.com';
                Tianjin.Factory = 'Tianjin';
                FactoryGM.add(Tianjin);
                Tianjin = null;
            }
            if(currentMCAR.Shanghai__c)
            {
                NSNContactDetails Shanghai = new NSNContactDetails();
                Shanghai.Name = 'Jose Menendez';
                Shanghai.Email = 'jose.menendez_herrero@nokia.com';
                Shanghai.Factory = 'Shanghai';
                FactoryGM.add(Shanghai);
                Shanghai= null;
            }
            if(currentMCAR.Chennai__c)
            {
                NSNContactDetails Chennai = new NSNContactDetails();
                Chennai.Name = 'Satendra Singh';
                Chennai.Email = 'satendra.singh@nokia.com';
                Chennai.Factory = 'Chennai';
                FactoryGM.add(Chennai);
                Chennai = null;
            }
            if(currentMCAR.Oulu__c)
            {
                NSNContactDetails Oulu = new NSNContactDetails();
                Oulu.Name = 'Esa Myllyla';
                Oulu.Email = 'esa.myllyla@nokia.com';
                Oulu.Factory = 'Oulu';
                FactoryGM.add(Oulu);
                Oulu = null;
            }
            if(currentMCAR.Bruchsal__c)
            {
                NSNContactDetails Bruchsal = new NSNContactDetails();
                Bruchsal.Name = 'Heinrich Jurtan';
                Bruchsal.Email = 'heinrich.jurtan@nokia.com';
                Bruchsal.Factory = 'Bruchsal';
                FactoryGM.add(Bruchsal);
                Bruchsal= null;
            }
           
           // Added By Chandra
           
            if(currentMCAR.FLEX_Tzcew__c)
            {
                NSNContactDetails FLEX_Tzcew = new NSNContactDetails();
                FLEX_Tzcew.Name = 'Andrzej Polojko';
                FLEX_Tzcew.Email = 'andrzej.polojko@flextronics.com';
                FLEX_Tzcew.Factory = 'FLEX-Tzcew';
                FactoryGM.add(FLEX_Tzcew);
                FLEX_Tzcew = null;
            }  
            if(currentMCAR.FOX_Shanghai__c)
            {
                NSNContactDetails FOX_Shanghai = new NSNContactDetails();
                FOX_Shanghai.Name = 'Maggie Yang';
                FOX_Shanghai.Email = 'maggie.df.yang@mail.foxconn.com';
                FOX_Shanghai.Factory = 'FOX-Shanghai';
                FactoryGM.add(FOX_Shanghai);
                FOX_Shanghai = null;
            }
            if(currentMCAR.SANM_Haukipudas__c)
            {
                NSNContactDetails SANM_Haukipudas = new NSNContactDetails();
                SANM_Haukipudas.Name = 'Eeva-Liisa Kylmanen';
                SANM_Haukipudas.Email = 'eeva-liisa.kylmanen@sanmina.com';
                SANM_Haukipudas.Factory = 'SANM-Haukipudas';
                FactoryGM.add(SANM_Haukipudas);
                SANM_Haukipudas = null;
            }
            if(currentMCAR.SANM_Kunshan__c)
            {
                NSNContactDetails SANM_Kunshan = new NSNContactDetails();
                SANM_Kunshan.Name = 'Larry Chung';
                SANM_Kunshan.Email = 'larry.chung@sanmina.com';
                SANM_Kunshan.Factory = 'SANM-Kunshan';
                FactoryGM.add(SANM_Kunshan);
                SANM_Kunshan = null;
            }
            if(currentMCAR.SANM_Chennai__c)
            {
                NSNContactDetails SANM_Chennai = new NSNContactDetails();
                SANM_Chennai.Name = 'Muthu Sivan';
                SANM_Chennai.Email = 'muthu.sivan@sanmina.com';
                SANM_Chennai.Factory = 'SANM-Chennai';
                FactoryGM.add(SANM_Chennai);
                SANM_Chennai = null;
            }
                     
            /************************************* RETRIVE FACTORY GM CONTACT - END ***************************************************************/            
            
            /************************************* RETRIVE MCAR OTHER GM CONTACT - START ***************************************************************/            
            
            OtherContacts = new List<NSNContactDetails>();
            
            if((currentMCAR.MCARName1__c != NULL)&&(currentMCAR.MCAREmail1__c != NULL) ) 
            {
             String name1 = String.valueOf(currentMCAR.MCARName1__c);
             String email1 = String.valueOf(currentMCAR.MCAREmail1__c);
             if(name1.length() > 0 && email1.length() > 0)
                 {
                 NSNContactDetails contact1 = new NSNContactDetails();
                 contact1.Name =  currentMCAR.MCARName1__c;
                 contact1.Email = currentMCAR.MCAREmail1__c;
                 OtherContacts.add(contact1);
                 contact1= null;
                 }
             }

            if((currentMCAR.MCARName2__c != NULL)&&(currentMCAR.MCAREmail2__c != NULL) ) 
            {
             String name2 = String.valueOf(currentMCAR.MCARName2__c);
             String email2 = String.valueOf(currentMCAR.MCAREmail2__c);
             if(name2.length() > 0 && email2.length() > 0)
                 {
                 NSNContactDetails contact2 = new NSNContactDetails();
                 contact2.Name =  currentMCAR.MCARName2__c;
                 contact2.Email = currentMCAR.MCAREmail2__c;
                 OtherContacts.add(contact2);
                 contact2= null;
                 }
             }
            if((currentMCAR.MCARName3__c != NULL)&&(currentMCAR.MCAREmail3__c != NULL) ) 
            {
             String name3 = String.valueOf(currentMCAR.MCARName3__c);
             String email3 = String.valueOf(currentMCAR.MCAREmail3__c);
             if(name3.length() > 0 && email3.length() > 0)
                 {
                 NSNContactDetails contact3 = new NSNContactDetails();
                 contact3.Name =  currentMCAR.MCARName3__c;
                 contact3.Email = currentMCAR.MCAREmail3__c;
                 OtherContacts.add(contact3);
                 contact3= null;
                 }
             }

            if((currentMCAR.MCARName4__c != NULL)&&(currentMCAR.MCAREmail4__c != NULL) ) 
            {
             String name4 = String.valueOf(currentMCAR.MCARName4__c);
             String email4 = String.valueOf(currentMCAR.MCAREmail4__c);
             if(name4.length() > 0 && email4.length() > 0)
                 {
                 NSNContactDetails contact4 = new NSNContactDetails();
                 contact4.Name =  currentMCAR.MCARName4__c;
                 contact4.Email = currentMCAR.MCAREmail4__c;
                 OtherContacts.add(contact4);
                 contact4= null;
                 }
             }

            if((currentMCAR.MCARName5__c != NULL)&&(currentMCAR.MCAREmail5__c != NULL) ) 
            {
             String name5 = String.valueOf(currentMCAR.MCARName5__c);
             String email5 = String.valueOf(currentMCAR.MCAREmail5__c);
             if(name5.length() > 0 && email5.length() > 0)
                 {
                 NSNContactDetails contact5 = new NSNContactDetails();
                 contact5.Name =  currentMCAR.MCARName5__c;
                 contact5.Email = currentMCAR.MCAREmail5__c;
                 OtherContacts.add(contact5);
                 contact5= null;
                 }
             }


            if((currentMCAR.MCARName6__c != NULL)&&(currentMCAR.MCAREmail6__c != NULL) ) 
            {
             String name6 = String.valueOf(currentMCAR.MCARName6__c);
             String email6 = String.valueOf(currentMCAR.MCAREmail6__c);
             if(name6.length() > 0 && email6.length() > 0)
                 {
                 NSNContactDetails contact6 = new NSNContactDetails();
                 contact6.Name =  currentMCAR.MCARName6__c;
                 contact6.Email = currentMCAR.MCAREmail6__c;
                 OtherContacts.add(contact6);
                 contact6= null;
                 }
             }


            if((currentMCAR.MCARName7__c != NULL)&&(currentMCAR.MCAREmail7__c != NULL) ) 
            {
             String name7 = String.valueOf(currentMCAR.MCARName7__c);
             String email7 = String.valueOf(currentMCAR.MCAREmail7__c);
             if(name7.length() > 0 && email7.length() > 0)
                 {
                 NSNContactDetails contact7 = new NSNContactDetails();
                 contact7.Name =  currentMCAR.MCARName7__c;
                 contact7.Email = currentMCAR.MCAREmail7__c;
                 OtherContacts.add(contact7);
                 contact7= null;
                 }
             }


            if((currentMCAR.MCARName8__c != NULL)&&(currentMCAR.MCAREmail8__c != NULL) ) 
            {
             String name8 = String.valueOf(currentMCAR.MCARName8__c);
             String email8 = String.valueOf(currentMCAR.MCAREmail8__c);
             if(name8.length() > 0 && email8.length() > 0)
                 {
                 NSNContactDetails contact8 = new NSNContactDetails();
                 contact8.Name =  currentMCAR.MCARName8__c;
                 contact8.Email = currentMCAR.MCAREmail8__c;
                 OtherContacts.add(contact8);
                 contact8= null;
                 }
             }

            
            /************************************* RETRIVE MCAR OTHER GM CONTACT - END ***************************************************************/            
            
           NSNEmailList= [select MCAR_User_Account__c,id, MCAR_First_Name__c, MCAR_Contact_Type__c, MCAR_Email__c, MCAR_Selected__c, name, MCAR_Last_Name__c, MCAR_Role__c, MCAR_Topic__c from MCAR_Email_List__c where MCAR__c =: currid and MCAR_Contact_Type__c=:'NSN'  and MCAR_Selected__c = true]; 
           OtherEmailList = [select MCAR_User_Account__c,id, MCAR_Contact_Type__c, MCAR_First_Name__c, MCAR_Email__c, MCAR_Selected__c, name, MCAR_Last_Name__c, MCAR_Role__c, MCAR_Topic__c from MCAR_Email_List__c where MCAR__c =: currid and MCAR_Contact_Type__c=:'OTHER' and MCAR_Selected__c = true]; 
    }
    
    public void getOpenDateFunction()
    {
        Date objFailureDate = currentMCAR.MCAR_2D_failure_date__c;
        if(objFailureDate != null)
            MCAR2DFailureDate = String.ValueOf(objFailureDate.month()) + '/' + String.ValueOf(objFailureDate.Day()) + '/' +  String.ValueOf(objFailureDate.year());
    
        Date objDateTime = currentMCAR.MCAR_Creation_Date_Status_Open__c;           
        if(objDateTime != null)          
           getOpenDate = String.ValueOf(objDateTime.month()) + '/' + String.ValueOf(objDateTime.Day()) + '/' +  String.ValueOf(objDateTime.year());
      
        Date objDate = currentMCAR.MCAR_RMA_Sent_Date__c;
        if(objDate != null)          
          RMASentDate =  String.ValueOf(objDate.month()) + '/' + String.ValueOf(objDate.Day()) + '/' +  String.ValueOf(objDate.year());

        Date objDate3D = currentMCAR.MCAR_3D_Due_Date__c;
    if(objDate3D != null)
        DueDate3D = String.ValueOf(objDate3D.month()) + '/' + String.ValueOf(objDate3D.Day()) + '/' +  String.ValueOf(objDate3D.year());

        Date objDate4D = currentMCAR.MCAR_4D_Due_Date__c;
    if(objDate4D != null)
            DueDate4D = String.ValueOf(objDate4D.month()) + '/' + String.ValueOf(objDate4D.Day()) + '/' +  String.ValueOf(objDate4D.year());
            
        Date objDate5D = currentMCAR.MCAR_5D_Due_Date__c;
    if(objDate5D != null)
            DueDate5D = String.ValueOf(objDate5D.month()) + '/' + String.ValueOf(objDate5D.Day()) + '/' +  String.ValueOf(objDate5D.year());
        
    Date objDate6D=currentMCAR.MCAR_6D_Due_Date__c;
    if(objDate6D != null)
           DueDate6D = String.ValueOf(objDate6D.month()) + '/' + String.ValueOf(objDate6D.Day()) + '/' +  String.ValueOf(objDate6D.year());
        
    Date objDate7D = currentMCAR.MCAR_7D_Due_Date__c;
        if(objDate7D != null)
        DueDate7D = String.ValueOf(objDate7D.month()) + '/' + String.ValueOf(objDate7D.Day()) + '/' +  String.ValueOf(objDate7D.year());
      }
    
    public void getDaysOpenFunction()
    {
        if(currentMCAR.MCAR_Days_Open__c != null)
        {
            getDaysOpen = String.ValueOf(currentMCAR.MCAR_Days_MCAR_Open__c);
            if(getDaysOpen.contains('.'))
            {
                String []strDaysOnly = getDaysOpen.split('.');
                getDaysOpen = strDaysOnly[0];
            }
        }
    }
    
   
    public void FetchingNameOfRecord()
    {
        if(currentMCAR.MCAR_NSN_Code__c != null){
            List<MCAR_MEPS__c> MEPSName = [select Name from MCAR_MEPS__c where Id =: currentMCAR.MCAR_NSN_Code__c];
            NSN_Code = MEPSName[0].Name;    
        }
      
        if(currentMCAR.MCAR_Manufacturer__c != null){
        List<MCAR_Manufacturer__c> ManufactureName = [select Name from MCAR_Manufacturer__c where Id =: currentMCAR.MCAR_Manufacturer__c ];
        Manufacture = ManufactureName[0].Name;
        }
            
        if(currentMCAR.QIRS_ID__c != null){    
        List<QIRS__c> QIRSList = [select Name from QIRS__c where Id =: currentMCAR.QIRS_ID__c ];
        QRISName = QIRSList[0].Name;
        }
    }  
   
     public void getAllNotesandAttachments()   
     {
         List<NoteAndAttachment> listDocuments = currentMCAR.NotesAndAttachments ;
         listNotesAttchment = new List<MCARNotesandAttchment>();
         if(listDocuments != null && listDocuments.SIZE() > 0)
         {
         
              for(NoteAndAttachment na : listDocuments )
              {    
                    MCARNotesandAttchment obj = new MCARNotesandAttchment();
                    obj.Title = na.Title ;
                      if(na.IsNote == true)
                      {  
                   
                         obj.URL = 'https://cs22.salesforce.com/'+na.id;
                      }    
                      else
                      {
                         obj.URL = 'https://c.cs22.content.force.com/servlet/servlet.FileDownload?file='+na.Id;
                      }
                 listNotesAttchment.add(obj);
              } 
            
                    }
     }
     
   
class MCARNotesandAttchment
{
public String Title {get;set;}
public String URL {get;set;}
}
 
 class NSNContactDetails
    {
        public String Name {get;set;}
        public String Email {get;set;}
        public String Factory {get;set;}
    }    
 
 
           
}