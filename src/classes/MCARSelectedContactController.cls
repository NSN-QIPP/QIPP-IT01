public class MCARSelectedContactController
{
    Public String strMCARId;
    Public List<NSNContactDetails> FactoryGM {get;set;}
    Public List<MCAR_Email_List__c> OtherEmailList{get;set;}
    public List<MCAR_Email_List__c> NSNEmailList {get;set;}
    public List<NSNContactDetails> OtherContacts {get;set;}
    public MCARSelectedContactController(ApexPages.StandardController controller) 
    {
            strMCARId= System.currentPagereference().getParameters().get('id'); 

            /************************************* RETRIVE FACTORY GM CONTACT - START ***************************************************************/

            MCAR__c objMCAR = [select Suzhou__c , Beijing__c , Tianjin__c ,Shanghai__c , Chennai__c , Oulu__c , Bruchsal__c ,
                                FLEX_Tzcew__c, FOX_Shanghai__c, SANM_Haukipudas__c, SANM_Kunshan__c, SANM_Chennai__c, 
                                MCARName1__c , MCAREmail1__c , MCARName2__c , MCAREmail2__c ,MCARName3__c , MCAREmail3__c ,    
                                MCARName4__c , MCAREmail4__c , MCARName5__c , MCAREmail5__c ,MCARName6__c , MCAREmail6__c ,
                                MCARName7__c , MCAREmail7__c ,MCARName8__c , MCAREmail8__c
                                from MCAR__c where Id =: strMCARId];     
            FactoryGM  = new List<NSNContactDetails>();
            if(objMCAR.Suzhou__c)
            {
                NSNContactDetails Suzhou = new NSNContactDetails();
                Suzhou.Name = 'Michael Yang';
                Suzhou.Email = 'michael.x.yang@nokia.com';
                Suzhou.Factory = 'Suzhou';
                FactoryGM.add(Suzhou);
                Suzhou = null;
            }
            if(objMCAR.Beijing__c)
            {
                NSNContactDetails Beijing = new NSNContactDetails();
                Beijing.Name = 'Adam Wang';
                Beijing.Email = 'xuejun.wang@nokia.com';
                Beijing.Factory = 'Beijing';
                FactoryGM.add(Beijing);
                Beijing = null;
            }
            if(objMCAR.Tianjin__c)
            {
                NSNContactDetails Tianjin = new NSNContactDetails();
                Tianjin.Name = 'Weichong Tan';
                Tianjin.Email = 'weichong.tan@nokia.com';
                Tianjin.Factory = 'Tianjin';
                FactoryGM.add(Tianjin);
                Tianjin = null;
            }
            if(objMCAR.Shanghai__c)
            {
                NSNContactDetails Shanghai = new NSNContactDetails();
                Shanghai.Name = 'Jose Menendez';
                Shanghai.Email = 'jose.menendez_herrero@nokia.com';
                Shanghai.Factory = 'Shanghai';
                FactoryGM.add(Shanghai);
                Shanghai= null;
            }
            if(objMCAR.Chennai__c)
            {
                NSNContactDetails Chennai = new NSNContactDetails();
                Chennai.Name = 'Satendra Singh';
                Chennai.Email = 'satendra.singh@nokia.com';
                Chennai.Factory = 'Chennai';
                FactoryGM.add(Chennai);
                Chennai = null;
            }
            if(objMCAR.Oulu__c)
            {
                NSNContactDetails Oulu = new NSNContactDetails();
                Oulu.Name = 'Erja Sankari';
                Oulu.Email = 'erja.sankari@nokia.com';
                Oulu.Factory = 'Oulu';
                FactoryGM.add(Oulu);
                Oulu = null;
            }
            if(objMCAR.Bruchsal__c)
            {
                NSNContactDetails Bruchsal = new NSNContactDetails();
                Bruchsal.Name = 'Heinrich Jurtan';
                Bruchsal.Email = 'heinrich.jurtan@nokia.com';
                Bruchsal.Factory = 'Bruchsal';
                FactoryGM.add(Bruchsal);
                Bruchsal= null;
            }
            //Added by Sunanda on 08-11-2013
            /*if(objMCAR.FLEX_Tzcew__c)
            {
                NSNContactDetails FLEX_Tzcew = new NSNContactDetails();
                FLEX_Tzcew.Name = 'Andrzej Polojko';
                FLEX_Tzcew.Email = 'andrzej.polojko@flextronics.com';
                FLEX_Tzcew.Factory = 'FLEX-Tzcew';
                FactoryGM.add(FLEX_Tzcew);
                FLEX_Tzcew = null;
            }  */
            
            if(objMCAR.FLEX_Tzcew__c)
            {
                NSNContactDetails FLEX_Tzcew = new NSNContactDetails();
                FLEX_Tzcew.Name = 'Andrzej Polojko';
                FLEX_Tzcew.Email = 'andrzej.polojko@flextronics.com';
                FLEX_Tzcew.Factory = 'FLEX-Tzcew';
                FactoryGM.add(FLEX_Tzcew);
                FLEX_Tzcew = null;
            }  
            if(objMCAR.FOX_Shanghai__c)
            {
                NSNContactDetails FOX_Shanghai = new NSNContactDetails();
                FOX_Shanghai.Name = 'Maggie Yang';
                FOX_Shanghai.Email = 'maggie.df.yang@mail.foxconn.com';
                FOX_Shanghai.Factory = 'FOX-Shanghai';
                FactoryGM.add(FOX_Shanghai);
                FOX_Shanghai = null;
            }
            if(objMCAR.SANM_Haukipudas__c)
            {
                NSNContactDetails SANM_Haukipudas = new NSNContactDetails();
                SANM_Haukipudas.Name = 'Eeva-Liisa Kylmanen';
                SANM_Haukipudas.Email = 'eeva-liisa.kylmanen@sanmina.com';
                SANM_Haukipudas.Factory = 'SANM-Haukipudas';
                FactoryGM.add(SANM_Haukipudas);
                SANM_Haukipudas = null;
            }
            if(objMCAR.SANM_Kunshan__c)
            {
                NSNContactDetails SANM_Kunshan = new NSNContactDetails();
                SANM_Kunshan.Name = 'Larry Chung';
                SANM_Kunshan.Email = 'larry.chung@sanmina.com';
                SANM_Kunshan.Factory = 'SANM-Kunshan';
                FactoryGM.add(SANM_Kunshan);
                SANM_Kunshan = null;
            }
            if(objMCAR.SANM_Chennai__c)
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
            
            if((objMCAR.MCARName1__c != NULL)&&(objMCAR.MCAREmail1__c != NULL) ) 
            {
             String name1 = String.valueOf(objMCAR.MCARName1__c);
             String email1 = String.valueOf(objMCAR.MCAREmail1__c);
             if(name1.length() > 0 && email1.length() > 0)
                 {
                 NSNContactDetails contact1 = new NSNContactDetails();
                 contact1.Name =  objMCAR.MCARName1__c;
                 contact1.Email = objMCAR.MCAREmail1__c;
                 OtherContacts.add(contact1);
                 contact1= null;
                 }
             }

            if((objMCAR.MCARName2__c != NULL)&&(objMCAR.MCAREmail2__c != NULL) ) 
            {
             String name2 = String.valueOf(objMCAR.MCARName2__c);
             String email2 = String.valueOf(objMCAR.MCAREmail2__c);
             if(name2.length() > 0 && email2.length() > 0)
                 {
                 NSNContactDetails contact2 = new NSNContactDetails();
                 contact2.Name =  objMCAR.MCARName2__c;
                 contact2.Email = objMCAR.MCAREmail2__c;
                 OtherContacts.add(contact2);
                 contact2= null;
                 }
             }
            if((objMCAR.MCARName3__c != NULL)&&(objMCAR.MCAREmail3__c != NULL) ) 
            {
             String name3 = String.valueOf(objMCAR.MCARName3__c);
             String email3 = String.valueOf(objMCAR.MCAREmail3__c);
             if(name3.length() > 0 && email3.length() > 0)
                 {
                 NSNContactDetails contact3 = new NSNContactDetails();
                 contact3.Name =  objMCAR.MCARName3__c;
                 contact3.Email = objMCAR.MCAREmail3__c;
                 OtherContacts.add(contact3);
                 contact3= null;
                 }
             }

            if((objMCAR.MCARName4__c != NULL)&&(objMCAR.MCAREmail4__c != NULL) ) 
            {
             String name4 = String.valueOf(objMCAR.MCARName4__c);
             String email4 = String.valueOf(objMCAR.MCAREmail4__c);
             if(name4.length() > 0 && email4.length() > 0)
                 {
                 NSNContactDetails contact4 = new NSNContactDetails();
                 contact4.Name =  objMCAR.MCARName4__c;
                 contact4.Email = objMCAR.MCAREmail4__c;
                 OtherContacts.add(contact4);
                 contact4= null;
                 }
             }

            if((objMCAR.MCARName5__c != NULL)&&(objMCAR.MCAREmail5__c != NULL) ) 
            {
             String name5 = String.valueOf(objMCAR.MCARName5__c);
             String email5 = String.valueOf(objMCAR.MCAREmail5__c);
             if(name5.length() > 0 && email5.length() > 0)
                 {
                 NSNContactDetails contact5 = new NSNContactDetails();
                 contact5.Name =  objMCAR.MCARName5__c;
                 contact5.Email = objMCAR.MCAREmail5__c;
                 OtherContacts.add(contact5);
                 contact5= null;
                 }
             }


            if((objMCAR.MCARName6__c != NULL)&&(objMCAR.MCAREmail6__c != NULL) ) 
            {
             String name6 = String.valueOf(objMCAR.MCARName6__c);
             String email6 = String.valueOf(objMCAR.MCAREmail6__c);
             if(name6.length() > 0 && email6.length() > 0)
                 {
                 NSNContactDetails contact6 = new NSNContactDetails();
                 contact6.Name =  objMCAR.MCARName6__c;
                 contact6.Email = objMCAR.MCAREmail6__c;
                 OtherContacts.add(contact6);
                 contact6= null;
                 }
             }


            if((objMCAR.MCARName7__c != NULL)&&(objMCAR.MCAREmail7__c != NULL) ) 
            {
             String name7 = String.valueOf(objMCAR.MCARName7__c);
             String email7 = String.valueOf(objMCAR.MCAREmail7__c);
             if(name7.length() > 0 && email7.length() > 0)
                 {
                 NSNContactDetails contact7 = new NSNContactDetails();
                 contact7.Name =  objMCAR.MCARName7__c;
                 contact7.Email = objMCAR.MCAREmail7__c;
                 OtherContacts.add(contact7);
                 contact7= null;
                 }
             }


            if((objMCAR.MCARName8__c != NULL)&&(objMCAR.MCAREmail8__c != NULL) ) 
            {
             String name8 = String.valueOf(objMCAR.MCARName8__c);
             String email8 = String.valueOf(objMCAR.MCAREmail8__c);
             if(name8.length() > 0 && email8.length() > 0)
                 {
                 NSNContactDetails contact8 = new NSNContactDetails();
                 contact8.Name =  objMCAR.MCARName8__c;
                 contact8.Email = objMCAR.MCAREmail8__c;
                 OtherContacts.add(contact8);
                 contact8= null;
                 }
             }

            
            /************************************* RETRIVE MCAR OTHER GM CONTACT - END ***************************************************************/            
            
           NSNEmailList= [select MCAR_User_Account__c,id, MCAR_First_Name__c, MCAR_Contact_Type__c, MCAR_Email__c, MCAR_Selected__c, name, MCAR_Last_Name__c, MCAR_Role__c, MCAR_Topic__c from MCAR_Email_List__c where MCAR__c =: strMCARId and MCAR_Contact_Type__c=:'NSN'  and MCAR_Selected__c = true]; 
           OtherEmailList = [select MCAR_User_Account__c,id, MCAR_Contact_Type__c, MCAR_First_Name__c, MCAR_Email__c, MCAR_Selected__c, name, MCAR_Last_Name__c, MCAR_Role__c, MCAR_Topic__c from MCAR_Email_List__c where MCAR__c =: strMCARId and MCAR_Contact_Type__c=:'OTHER' and MCAR_Selected__c = true]; 
           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'OtherEmailList ' + OtherEmailList )); 
           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'NSNEmailList' + NSNEmailList));
    }
  
  class NSNContactDetails
    {
        public String Name {get;set;}
        public String Email {get;set;}
        public String Factory {get;set;}
    }    
}