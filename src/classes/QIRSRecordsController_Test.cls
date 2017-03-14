@istest
private class QIRSRecordsController_Test{      
   
     static testmethod void QIRSRecordsController_Test()   // Name of the test method. Must be the same as the class name 
    {
        
        QIRSRecordsController testcls = new QIRSRecordsController(); 
        
        // Trying to invoke all possible conditions
        
        testcls.getPageDetails();
        testcls.getshowQIRS();
        testcls.getItem();
        
        testcls.Stop_Ship_Code = null;
        testcls.Status  = 'All';
        testcls.getPageDetails();
        
        testcls.Stop_Ship_Code = null;
        testcls.Status  = 'notAll';
        testcls.getPageDetails();
        
        testcls.Stop_Ship_Code = null;
        testcls.Status  = 'Closed';
        testcls.getPageDetails();
        
        testcls.Stop_Ship_Code = 'notNull';
        testcls.Status  = 'All';
        testcls.getPageDetails();
        
        testcls.Stop_Ship_Code = 'notNull';
        testcls.Status  = 'All';
        testcls.getshowQIRS();
        
        testcls.Stop_Ship_Code = null;
        testcls.Status  = 'All';
        testcls.getshowQIRS();
        
        testcls.Stop_Ship_Code = null;
        testcls.Status  = 'Closed';
        testcls.getshowQIRS();
        
        testcls.Stop_Ship_Code = 'notnull';
        testcls.Status  = 'Closed';
        testcls.getshowQIRS();
        
        testcls.Stop_Ship_Code = 'notNull';
        testcls.Status  = 'shiva';
        testcls.getshowQIRS();
        
        testcls.Stop_Ship_Code = null;
        testcls.Status  = 'shiva';
        testcls.getshowQIRS();
        
        testcls.Stop_Ship_Code = 'notNull';
        testcls.Status  = null;
        testcls.getshowQIRS();
        
        testcls.Stop_Ship_Code = null;
        testcls.Status  = null;
        testcls.getshowQIRS();
        
        
        
        
    }  
}