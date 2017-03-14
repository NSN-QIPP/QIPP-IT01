@istest
private class QIRSMyRecordsController_Test{      
   
     static testmethod void QIRSMyRecordsController_Tes()   // Name of the test method. Must be the same as the class name 
    {
        System.debug('===================== QIRSMyRecordsController_Tes() method start =================');
        QIRSMyRecordsController testcls = new QIRSMyRecordsController();  
        testcls.getPageDetails(); 
        testcls.getshowQIRS();   
        testcls.getItem();
        
        System.debug('=============Trying to test all the code conditions of class==============');
        
        testcls.Stop_Ship_Code= null;
        testcls.Status= 'All'; 
        testcls.getPageDetails(); 
        
        testcls.Stop_Ship_Code= null;
        testcls.Status= 'Closed'; 
        testcls.getPageDetails(); 
        
        testcls.Stop_Ship_Code= null;
        testcls.Status= 'shiva'; 
        testcls.getPageDetails(); 
        
        testcls.Stop_Ship_Code= 'statusCode';
        testcls.Status= 'All'; 
        testcls.getPageDetails(); 
                      
        testcls.Status= null; 
        testcls.Stop_Ship_Code= 'statusCode';
        testcls.getshowQIRS();   
        
        testcls.Status= null; 
        testcls.Stop_Ship_Code= null;
        testcls.getshowQIRS();   
                      
        testcls.Status= 'all'; 
        testcls.Stop_Ship_Code= 'notnull';
        testcls.getshowQIRS();     
        
        testcls.Status= 'all'; 
        testcls.Stop_Ship_Code= null;
        testcls.getshowQIRS();    
        
        testcls.Status= 'Closed'; 
        testcls.Stop_Ship_Code= 'notnull';
        testcls.getshowQIRS();     
        
        testcls.Status= 'Closed'; 
        testcls.Stop_Ship_Code= null;
        testcls.getshowQIRS();       
        
        testcls.Status= 'shiva'; 
        testcls.Stop_Ship_Code= 'notnull';
        testcls.getshowQIRS();     
        
        testcls.Status= 'shiva'; 
        testcls.Stop_Ship_Code= null;
        testcls.getshowQIRS();   
        
        testcls.getItem();
        System.debug('===================== QIRSMyRecordsController_Tes() method end =================');
    }   
}