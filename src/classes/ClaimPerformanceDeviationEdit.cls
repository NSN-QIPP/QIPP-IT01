public class ClaimPerformanceDeviationEdit 
{
    public Id Claim { set; get; }
    public Id PerDevId { set; get; }    
     
    public Performance_Deviation_section__c PerformanceDeviation {get;set;}
    private ApexPages.StandardController Controller;    
           
    public ClaimPerformanceDeviationEdit(ApexPages.StandardController Controller)
    { 
        PerDevId = ApexPages.CurrentPage().getParameters().get('id');
        PerformanceDeviation = [select id,Claim__c,Performance_Measure_Name__c,Claim__r.Name,Associated_Part_Code__c,Associated_Part_Code__r.Name,Name,Actual_Measurement__c,Associated_Product__c,Business_Impact__c,Date_Measured__c,Frequency_of_Measurement__c,Measurement_Standard__c,Shipper_Name_Location__c,Shipping_Destination__c from Performance_Deviation_section__c where id =:PerDevId limit 1];
    }
    
    public PageReference UpdatePerformance()
    {
        update PerformanceDeviation;
        pageReference pb1 = new pageReference('/'+PerformanceDeviation.Claim__c);        
        return pb1;                    
    }
}