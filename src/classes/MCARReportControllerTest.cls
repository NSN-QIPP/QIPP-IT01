@isTest
public class MCARReportControllerTest 
{
    public static testmethod void sampletest1()
    {
        test.startTest();                                        
                        
        MCAR_Manufacturer__c manufacturer = new  MCAR_Manufacturer__c();
        manufacturer.Name = 'Test';
        manufacturer.Enterprise_ID__c = 'Test'; 
        insert manufacturer;
        
        MCAR__c MCAR = new MCAR__c();
        MCAR.MCAR_Manufacturer__c = manufacturer.Id;        
        mcar.MCAR_Status__c = 'Closed';
        mcar.MCAR_Part_Enterprise_ID__c = 'test';
        mcar.MCAR_Defect_Quantity__c = 10;
        mcar.Category_Group_text__c = 'Global Service Delivery';
        mcar.Category_Area_text__c = 'Product Procurement (PP)';  
        mcar.Category__c = 'Test';
        mcar.MCAR_Creation_Date_Status_Open__c = system.today() - 10;
        mcar.MCAR_Closed_Date__c = system.today();
        mcar.MCAR_Containment_Action__c = 'test 3D';
        mcar.MCAR_4D_Root_Cause__c = 'test 4D';                
        system.debug('control 1');
        insert MCAR;
        system.debug('control 1');
        
        mcar.MCAR_Containment_Action__c = 'test 3D - uptd';
        mcar.MCAR_4D_Root_Cause__c = 'test 4D - uptd'; 
        update mcar;
        
        MCARReportScheduler.sendReport();
        MCARReportScheduler.adminNotification('ClassName',12,'Message', 'TypeName');
        //select id,Name,MCAR_Defect_Location__c,MCAR_Status__c,MCAR_Part_Enterprise_ID__c,MCAR_Defect_Quantity__c,Category_Group_text__c,
        //Category_Area_text__c,MCAR_Manufacturer__r.Name,MCAR_Creation_Date_Status_Open__c,
        //MCAR_Closed_Date__c,(select id,field,CreatedDate from Histories where (field = 'MCAR_Containment_Action__c' or field = 'MCAR_4D_Root_Cause__c') order by CreatedDate desc) from MCAR__c where (MCAR_Status__c ='Closed' or MCAR_Status__c='No Trouble Found') and Manufacture_Accepts_Fault__c= 'YES' and MCAR_Closed_Date__c = LAST_MONTH
        PageReference pageRef = Page.MCARReportPage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('flt','2016-05');            
        MCARReportController mr = new MCARReportController();                
        
        system.debug('***'+mr.NextSchedule);                                
        test.stopTest();
    }   
}