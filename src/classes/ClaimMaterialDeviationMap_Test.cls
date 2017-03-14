@istest
public class ClaimMaterialDeviationMap_Test {
    static testmethod void test1(){
    
    MCAR_Claim_Management__c claimRec = new MCAR_Claim_Management__c();
    insert claimRec;
    
    MCAR_MEPS__c mepRec = new MCAR_MEPS__c();
    insert mepRec;
        
    MCAR__c mcarRec = new MCAR__c();
    insert mcarRec;
        
    Material_Deviation__c matDevRec = new Material_Deviation__c();
     matDevRec.Code__c=mcarRec.id;
     matDevRec.Code__c = mcarRec.name;
     matDevRec.Defect_PPM__c= 3;
     matDevRec.Expected_Containment_Hours__c= 9;
     matDevRec.Lot_Number_Date_Code__c='';
     matDevRec.MCARs__c =mcarRec.Id;
     //matDevRec.Mfg_Part_Number__c= 6;
     matDevRec.Problem_Description__c='test';
     matDevRec.Quantity__c=5;
     matDevRec.Serial_Number__c='123';
     matDevRec.MCARs__c=mcarRec.Name;
     matDevRec.MCAR_Claim_Management1__c = claimRec.id;
     insert matDevRec;
        
     Performance_Deviation_section__c perDevRec = new Performance_Deviation_section__c();
     perDevRec.Performance_Measure_Name__c = 'test';
     perDevRec.Frequency_of_Measurement__c=2;
     perDevRec.Measurement_Standard__c='test measure';
     perDevRec.Actual_Measurement__c='test';
     perDevRec.Associated_Part_Code__c= mcarRec.id;
     perDevRec.Associated_Part_Code__c =mcarRec.Name;
     perDevRec.Claim__c =claimRec.id;
     insert perDevRec;
        
     Claim_Contact__c claimContRec = new Claim_Contact__c();
     claimContRec.Contact_Type__c='SQM';
     claimContRec.Email__c='priya.burghate@atoss.net';
     claimContRec.Name__c='priya burghate';
     claimContRec.Phone__c='123456789';
     claimContRec.Claims__c = claimRec.id;
     insert claimContRec;
        
     Claim_NCC_Services_Worksheet__c NccServiceRec = new Claim_NCC_Services_Worksheet__c();
     //NccServiceRec.Amount__c=100;
     NccServiceRec.Description__c ='test description';
     NccServiceRec.NCC_Category__c ='Delay related costs';
     NccServiceRec.Qty_Hours__c=10;
     NccServiceRec.Unit_Price__c=10;
     NccServiceRec.Claim__c = claimRec.id;
     insert NccServiceRec;
        
        
     NCC_Materials_Factory_Worksheet__c NccMaterialFactoryRec = new NCC_Materials_Factory_Worksheet__c();
     //NccMaterialFactoryRec.Amount__c=100;
     NccMaterialFactoryRec.Category__c ='Incoming Goods Inspection Cost';
     NccMaterialFactoryRec.Description__c='test Description';
     NccMaterialFactoryRec.Qty_Hours__c=10;
     NccMaterialFactoryRec.Unit_Price__c=10;
     NccMaterialFactoryRec.Claim__c = claimRec.id;
     insert NccMaterialFactoryRec;
        
     Materials_Field_Worksheet__c NccMaterialFieldRec = new Materials_Field_Worksheet__c();
     //NccMaterialFieldRec.Amount__c=100;
     NccMaterialFieldRec.Category__c='Batch inspection at Supplier site';
     NccMaterialFieldRec.Description__c='test Description';
     NccMaterialFieldRec.Qty_Hours__c=10;
     NccMaterialFieldRec.Unit_Price__c=10;
     NccMaterialFieldRec.Claim__c = claimRec.id;
     insert NccMaterialFieldRec;
        
     Materials_Hub_Worksheet__c NccMaterialHubRec = new Materials_Hub_Worksheet__c();
     //NccMaterialHubRec.Amount__c = 100;
     NccMaterialHubRec.Category__c ='Incoming Inspection/ Identity Check';
     NccMaterialHubRec.Description__c='test Description';
     NccMaterialHubRec.Qty_Hours__c=10;
     NccMaterialHubRec.Unit_Price__c=10;
     NccMaterialHubRec.Claim__c = claimRec.id;
     insert NccMaterialHubRec;
        
     Trace_Email__c traceEmailRec = new Trace_Email__c();
     traceEmailRec.First_Time_Opened__c= datetime.newInstance(2016, 5, 15, 13, 30, 0);
     traceEmailRec.Last_Time_Opened__c = datetime.newInstance(2016, 6, 10, 13, 30, 0);
     traceEmailRec.Number_Of_Times_Email_Opened__c = 10;
     traceEmailRec.Claim__c = claimRec.id;
     insert traceEmailRec;
        
        
     test.startTest();
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(claimRec);
        ApexPages.currentPage().getParameters().put('claimId',claimRec.id);
        ClaimMaterialDeviationMap claimMatDevMap = new ClaimMaterialDeviationMap(sc);
     test.stopTest();
        
    }
    

}