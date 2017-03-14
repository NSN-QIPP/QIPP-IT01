public class ClaimMeterialDeviationEdit 
{
   //public id DeviID{get;set;}
   //public id codeid {set; get;} 
   //public MCAR_Claim_Management__c claim {set; get;}
   //public Material_Deviation__c materialDeviation{get;set;}
    //public Id ClaimId { set; get; }
   //public String code{get;set;}
  // public List<MCAR_MEPS__c> meps {set; get;}
  
   /* public ClaimMeterialDeviationEdit(ApexPages.StandardController Materialcontroller) 
    {
        try
        {               
            DeviID = ApexPages.CurrentPage().getParameters().get('id');
            claim =[select id,Name,Manufacturer__c,Facility__c, (select id,code__C,MCAR_Claim_Management1__c from Material_Deviation__r) from  MCAR_Claim_Management__c where ID IN(select MCAR_Claim_Management1__c from Material_Deviation__c where ID =:DeviID) ];
           materialDeviation = [select id,name,code__C,MCARs__c,MCAR_Claim_Management1__c,code__r.name, MCARs__r.name from Material_Deviation__c where id=:DeviID ];           
        }
        catch(Exception e)
        {
            
        }            
    
    }*/
 
    public Id Claim { set; get; }
    public Id MatDevId { set; get; }    
     
    public string codeid { set; get; }
    public string mcarid { set; get; }
    
    public Material_Deviation__c MaterialDeviation {get;set;}
    private ApexPages.StandardController Controller;    
           
    public ClaimMeterialDeviationEdit(ApexPages.StandardController Controller)
    { 
        MatDevId = ApexPages.CurrentPage().getParameters().get('id');
        MaterialDeviation = [select id,name,MCAR_Claim_Management1__c,MCAR_Claim_Management1__r.name,Code__c,Code__r.name,MCARs__c,MCARs__r.name,codee__c,Defect_PPM__c,Expected_Containment_Hours__c,Lot_Number_Date_Code__c,  Mfg_Part_Number__c,Problem_Description__c,Quantity__c,  Serial_Number__c from Material_Deviation__c where id=:MatDevId ];        
        codeid = MaterialDeviation.Code__r.Name;
        mcarid = MaterialDeviation.MCARs__r.Name;
    }
    
    public PageReference Updatematerial()
    {        
        system.debug('****Mcar1 '+mcarid+'*** code1'+codeid);
        if(codeid.equals('') && mcarid.equals(''))
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Code or MCAR field Should not be blank....'));
            return null;
        }              
        else if(!mcarid.equals(''))
        {
            MaterialDeviation.Code__c = [select MCAR_NSN_Code__c from MCAR__c where id=:MaterialDeviation.MCARs__c limit 1].MCAR_NSN_Code__c;
        }  
        update MaterialDeviation;
        pageReference pb1 = new pageReference('/'+MaterialDeviation.MCAR_Claim_Management1__c);        
        return pb1;                    
    } 
 
 
}