public class ClaimMaterialDeviation 
{
    public id ClaimId { set; get; }
    public id codeid {set; get;}   
    public id mcarid {set; get;}       
    public id PerDevId { set; get; }
      
    public Claim_Final_Payment__c payment { set; get; }
    public MCAR_Claim_Management__c claim {set; get;}
    public Material_Deviation__c MeterialDeviation {set; get;}
    public MCAR__c AvaiMCARs {set;get;}
    public List<MCAR_MEPS__c> meps {set; get;}
    public List<MCAR__c> mcars {set; get;}
    public Claim_Final_Payment__c Paymentlog {get;set;}
    public Performance_Deviation_section__c PerformanceDeviation{get;set;}
    
    public ClaimMaterialDeviation(id mcarRef)
    {
        codeid = [select MCAR_NSN_Code__c from MCAR__c where id=:mcarRef limit 1].MCAR_NSN_Code__c;
    }
    
    public ClaimMaterialDeviation(ApexPages.StandardController controller)
    {
        codeid = null; mcarid = null;
        PerDevId = controller.getRecord().id;
        String type = controller.getRecord().getSObjectType().getDescribe().getName();
        system.debug('**PerDevId**'+PerDevId);
        system.debug('****'+type);
    }
     
    public ClaimMaterialDeviation()
    {                           
        ClaimId = ApexPages.currentPage().getParameters().get('Claimid');         
                claim =[select id,Name,Manufacturer__c,Facility__c from MCAR_Claim_Management__c where id=:Claimid ]; 
        
        ////--------------Meps Search Data---------------------////
        string SearchMeps = ApexPages.currentPage().getParameters().get('SearchMeps');  
        string SearchMcar = ApexPages.currentPage().getParameters().get('SearchMcar');  
                
       if(SearchMeps!=null)
        {
            searchValue = SearchMeps;            
            SearchMeps = '%'+SearchMeps+'%';
                        meps =[select id,Name,MCAR_NSN_Part__c,MCAR_Mfg_Part_Number__c,Manufacturer_Name__c,MCAR_MEPS_Enterprise_ID__c from MCAR_MEPS__c where Manufacturer_Name__c =:claim.Manufacturer__c  and Name like :SearchMeps limit 50];                                   
        }
        else if(SearchMcar==null) meps =[select id,Name,LastModifiedDate,MCAR_NSN_Part__c,MCAR_Mfg_Part_Number__c,Manufacturer_Name__c,MCAR_MEPS_Enterprise_ID__c from MCAR_MEPS__c where Manufacturer_Name__c=:claim.Manufacturer__c order by Name desc limit 1000];
        ////--------------------------------------------------///
                
        if(SearchMcar!=null)
        {
            searchValue = SearchMcar;
            SearchMcar = '%'+SearchMcar+'%';
            mcars = [select id,Name,LastModifiedDate,MCAR_Status__c,MCAR_Manufacturer__c,MCAR_NSN_Code__c from MCAR__c where MCAR_Manufacturer__c=:claim.Manufacturer__c and Name like :SearchMcar order by Name desc limit 50];
        }
        else mcars = [select id,Name,LastModifiedDate,MCAR_Status__c,MCAR_Manufacturer__c,MCAR_NSN_Code__c from MCAR__c where MCAR_Manufacturer__c=:claim.Manufacturer__c order by Name desc limit 1000]; 
        
        MeterialDeviation = new Material_Deviation__c();
        PerformanceDeviation = new Performance_Deviation_section__c();        
        AvaiMCARs = new MCAR__c();
        Paymentlog = new Claim_Final_Payment__c();
        Paymentlog.Claim__c = ClaimId;
    }
    
    public string searchValue
    {
        get
        {
            if(searchValue == null)
                searchValue = '';
            return searchValue;
        }
        set;
    }
    
    public List<MCAR_MEPS__c> searchResults
    {
        get
        {
            if(searchResults == null)
                searchResults = new List<MCAR_MEPS__c>();
            return searchResults;
        }
        set;
    }
    
        public List<MCAR__c> searchMCARList 
    {
        get
        {
            if(searchMCARList == null)
                searchMCARList = new List<MCAR__c>();
            return searchMCARList;
        }
        set;
    }
    
    public pageReference doSearch()
    {                        
        if(searchValue=='')
        {
           if(meps.size()!=0)
           {                   
                meps =[select id,Name,MCAR_NSN_Part__c,MCAR_Mfg_Part_Number__c,Manufacturer_Name__c,MCAR_MEPS_Enterprise_ID__c from MCAR_MEPS__c where Manufacturer_Name__c=:claim.Manufacturer__c order by Name desc limit 1000];   
           }
           else return null; 
        }
        else 
        {
                        meps.clear();                        
            if(searchValue =='') return null;        
                String finalSearchValue = '%' + searchValue + '%';         
                meps =[select id,Name,MCAR_NSN_Part__c,MCAR_Mfg_Part_Number__c,Manufacturer_Name__c,MCAR_MEPS_Enterprise_ID__c from MCAR_MEPS__c where Manufacturer_Name__c =:claim.Manufacturer__c  and Name like :finalSearchValue limit 50];      
                searchResults = meps;  
                return null;
        }   
                return null;        
    }                  
            
    public pageReference searchMCAR()
    {                        
        if(searchValue=='')
        {
           if(mcars.size()!=0)
           {                   
                mcars = [select id,Name,LastModifiedDate,MCAR_Status__c,MCAR_Manufacturer__c,MCAR_NSN_Code__c from MCAR__c where MCAR_Manufacturer__c=:claim.Manufacturer__c order by Name desc limit 1000]; 
           }
           else return null; 
        }
        else 
        {
                        mcars.clear();                        
            if(searchValue =='') return null;        
                String finalSearchValue = '%' + searchValue + '%';         
                mcars = [select id,Name,LastModifiedDate,MCAR_Status__c,MCAR_Manufacturer__c,MCAR_NSN_Code__c from MCAR__c where MCAR_Manufacturer__c=:claim.Manufacturer__c and Name like :finalSearchValue limit 50];
                searchMCARList = mcars;  
                return null;
        }   
                return null;        
    } 
    
    public pageReference Save()
    {                               
        String Val1 = (String)codeid;
        String val2 = (String)mcarid;
        
        if(Val1.equals('')&&val2.equals(''))
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Code or MCAR field Should not be blank....'));
            return null;
        }
        else if(val1.equals(''))
        {
            codeid = [select MCAR_NSN_Code__c from MCAR__c where id=:mcarid limit 1].MCAR_NSN_Code__c;
        }
        system.debug('**** :   '+codeid+'***** :'+mcarid);
        MeterialDeviation.Code__c = codeid;              
        MeterialDeviation.MCARs__c = mcarid;           
        MeterialDeviation.MCAR_Claim_Management1__c = claimId;                        
                                    
        insert MeterialDeviation;                              
        pageReference pb = new pageReference('/'+ClaimId);            
        return pb;          
    }
    public pageReference Save1()
    {                
        Paymentlog.Claim__c=claimId;        
        insert Paymentlog;
        pageReference pb1 = new pageReference('/'+ClaimId);        
        return pb1;          
    }
  public PageReference SavePerformance() {
           
           PerformanceDeviation.Claim__C = claimId;
           insert PerformanceDeviation;
           pageReference pb1 = new pageReference('/'+ClaimId);
           return pb1;                
    }  
    
    public PageReference SavePaymentLog()
    {       
        if(Paymentlog.Amount__c == null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Amount Should not be blank....'));                
            return null;            
        }            
        if(Paymentlog.Payment_or_Discount__c!=null)         
        {
                if(Paymentlog.Method_of_Payment__c !=null && Paymentlog.Payment_Date__c !=null)
                {
                    if(Paymentlog.Method_of_Payment__c == 'Other')                    
                        if(Paymentlog.Other_Payment__c ==null)
                        {   
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Other Payment Should not be None....'));
                            return null;
                        }                                               
                }
                else
                {                    
                    if(Paymentlog.Payment_or_Discount__c =='Payment')
                    {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Method of Payment and Payment Date Should not be Blank....'));
                        return null;
                    }
                }
        }       
        else
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Payment or Write Off? Should not be None....'));
            return null;
        }

        //return null;
        insert Paymentlog;
          
        pageReference pb1 = new pageReference('/'+ClaimId);
        return pb1;             
        
        
    }
    
}