@isTest
public with sharing class QIRS_AP_Implement_Controller_Test{
    
   static testmethod void test1()
     {    
        QIRS__c i=new QIRS__c();
        QIRS_Action_Plan__c j=new QIRS_Action_Plan__c();
                
        ApexPages.StandardController con = new ApexPages.StandardController(i);
        QIRS_AP_Implement_Controller  aaa = new QIRS_AP_Implement_Controller (); 
        
               //PageReference pageRef = Page.QIRS_AP_Implement;
               //Test.setCurrentPageReference(new PageReference('ctask')); 
       
        PageReference pageRef = Page.QIRS_AP_Implement;
        Test.setCurrentPage(pageRef);
      
        aaa = new QIRS_AP_Implement_Controller ();
        
    
        ApexPages.currentPage().getParameters().put('id', '005Z0000000Hnsp');
       
       
       aaa = new QIRS_AP_Implement_Controller ();
       aaa.strSubtitleValue='abcd';
        
       
       Test.setCurrentPageReference(new PageReference('/apex/QIRS_AP_PendingTask?type=ctask')); 
     
       j.Action_Plan_Counter__c=2;
       j.Implementation_Comment__c='YES';
       j.Required_date__c=Date.Today()-8;
       j.Status__c='BaseVarImplementedbyChampion';
       j.Implementation_Date__c=Date.Today();
       j.Status_Date1__c = Date.Today();
        aaa = new QIRS_AP_Implement_Controller();
        aaa.cancel();
        //aaa.submit();
        
    
       
       
        
        }
        }