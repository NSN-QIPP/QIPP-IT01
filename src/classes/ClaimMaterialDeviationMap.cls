public with sharing class ClaimMaterialDeviationMap {

 public list<Performance_Deviation_section__c> PerformanceDev{get;set;}
 public list<Material_Deviation__c> MaterialDeviation{get;set;}
 //public MCAR_Claim_Management__c Clims {get;set;}
 public list<Claim_Contact__c> ClaimContacts{get;set;}
 public list<Claim_NCC_Services_Worksheet__c> NccService{get;set;}
 public list<NCC_Materials_Factory_Worksheet__c> NccMaterialFactory{get;set;}
 public list<Materials_Field_Worksheet__c> NccMaterialField{get;set;}
 public list<Materials_Hub_Worksheet__c> NccMaterialHub{get;set;}
 public list<Trace_Email__c> TraceEmail {get;set;}
 public list<Claim_Final_Payment__c> paymentlog{get;set;}
 public list<Negotiation_Log__c> Negotiationlog{get;set;}


    public ClaimMaterialDeviationMap(ApexPages.StandardController st) {
 
        try
        {                    
        MaterialDeviation = [select name,Code__c,code__r.name,Defect_PPM__c,Expected_Containment_Hours__c,Lot_Number_Date_Code__c,MCARs__c,Mfg_Part_Number__c,Problem_Description__c,
                             Quantity__c,Serial_Number__c,MCARs__r.name from Material_Deviation__c where MCAR_Claim_Management1__c =:st.getID()];
       PerformanceDev  = [select name,Frequency_of_Measurement__c,Measurement_Standard__c,Actual_Measurement__c,  Associated_Part_Code__c,Associated_Part_Code__r.name from Performance_Deviation_section__c where Claim__c=:st.getID() ];  
       ClaimContacts = [select name,Contact_Type__c,Email__c,Name__c,Phone__c from  Claim_Contact__c where Claims__c =:st.getID()];  
       NccService = [select name, Amount__c,Description__c,NCC_Category__c, Qty_Hours__c,Unit_Price__c from Claim_NCC_Services_Worksheet__c where Claim__c =:st.getID()];   
       NccMaterialFactory = [select name,Amount__c,Category__c, Description__c,Qty_Hours__c,Unit_Price__c from NCC_Materials_Factory_Worksheet__c where Claim__c =:st.getID()]; 
       NccMaterialField   = [select name,Amount__c,Category__c, Description__c,Qty_Hours__c,Unit_Price__c from Materials_Field_Worksheet__c where Claim__c =:st.getID()]; 
       NccMaterialHub =    [select name,Amount__c,Category__c, Description__c,Qty_Hours__c,Unit_Price__c from   Materials_Hub_Worksheet__c where Claim__c =:st.getID()];
       Negotiationlog = [select name,Memo_Title__c,Memo_Description__c,Date__c from Negotiation_Log__c  where Claim__c =:st.getID()];
       paymentlog = [select name,Amount__c,Discount_Explanation__c,Last_update__c,Method_of_Payment__c,Other_Payment__c,Payment_Date__c,Payment_or_Discount__c,Payment_Validated__c from Claim_Final_Payment__c where Claim__c =:st.getID()];
        TraceEmail = [select name,First_Time_Opened__c,Last_Time_Opened__c, Number_Of_Times_Email_Opened__c from Trace_Email__c where Claim__c =:st.getID() ];   
        }
        catch(Exception e)
        {
                }
    }

}