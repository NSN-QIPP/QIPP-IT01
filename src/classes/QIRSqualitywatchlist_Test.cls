@istest
private class QIRSqualitywatchlist_Test{      
   
     static testmethod void QIRSqualitywatchlist_Test()   // Name of the test method. Must be the same as the class name 
    {    
     System.debug('=================== QIRSqualitywatchlist_Test class test method start ====================');
         QIRS__c i=new QIRS__c();
         ApexPages.StandardController con = new ApexPages.StandardController(i);
         QIRSqualitywatchlist testcls = new QIRSqualitywatchlist(con);   
        
        testcls.getQuery_Quality_List(); 
       
        testcls.Business = 'NotAll';
        testcls.getQuery_Quality_List();  
        
        testcls.getItems();
      System.debug('=================== QIRSqualitywatchlist_Test class test method end ====================');                   
    }  
    
   
}