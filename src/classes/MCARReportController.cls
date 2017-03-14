/****************************************************************************
Author        : Rajkumar (rajkumar.p@atos.net)
Description   : Generate SPE report using MCAR Data - DEM0019546 
Dependencies  : No Dependencies 
Number of DML : No DML operations
*****************************************************************************/
public class MCARReportController 
{        
    public String NextSchedule 
    { 
        set; 
        get    
        {          
            String str = '--:--';
            try
            {
                if(Test.IsRunningTest())
                {
                    str = 'for Test....';
                }
                else
                str = String.valueOf([SELECT NextFireTime FROM CronTrigger where CronJobDetail.Name = 'MCAR SPE Report'].NextFireTime);
                
                return str;
            }
            catch(Exception E)
            {
                return '--:--';
            }
            return str;
        }
    }
    
    public List<List<ReportData>> ListMcarData { set; get; }
    public List<ReportData> report { set; get; }
    Map<string,List<MCARData>> mcarMaps { set; get; }    
    List<MCAR__c> mcars { set; get; } 
    
    public MCARReportController()
    {                            
        ListMcarData = new List<List<ReportData>>();
        mcarMaps = new Map<string,List<MCARData>>();        
        report = new List<ReportData>();                
        
        try
        {                        
            ///-------------------------------------------Initilize the values based on Flag---------------------------------------------------------//            
                
            string flag = ApexPages.currentPage().getParameters().get('flag'); 
            string flt = ApexPages.currentPage().getParameters().get('flt'); 
            
            if(flag=='flt' && flt!=null)
            {                
                String[] prd = flt.split('-');
                
                mcars = new List<MCAR__c>([select id,Name,MCAR_Defect_Location__c,MCAR_Status__c,MCAR_Part_Enterprise_ID__c,MCAR_Defect_Quantity__c,Category_Group_text__c,Category_Area_text__c,Category__c,MCAR_Manufacturer__r.Name,MCAR_Creation_Date_Status_Open__c,MCAR_Closed_Date__c,(select id,field,CreatedDate from Histories where (field = 'MCAR_Containment_Action__c' or field = 'MCAR_4D_Root_Cause__c') order by CreatedDate desc) from MCAR__c where (MCAR_Status__c ='Closed' or MCAR_Status__c='No Trouble Found') and Manufacture_Accepts_Fault__c= 'YES' and CALENDAR_YEAR(MCAR_Closed_Date__c) =:(Integer.valueOf(prd[0])) and CALENDAR_MONTH(MCAR_Closed_Date__c) =:(Integer.valueOf(prd[1]))]);                                                                   
            }
            else if(flag=='all')
            {
                mcars = new List<MCAR__c>([select id,Name,MCAR_Defect_Location__c,MCAR_Status__c,MCAR_Part_Enterprise_ID__c,MCAR_Defect_Quantity__c,Category_Group_text__c,Category_Area_text__c,Category__c,MCAR_Manufacturer__r.Name,MCAR_Creation_Date_Status_Open__c,MCAR_Closed_Date__c,(select id,field,CreatedDate from Histories where (field = 'MCAR_Containment_Action__c' or field = 'MCAR_4D_Root_Cause__c') order by CreatedDate desc) from MCAR__c where (MCAR_Status__c ='Closed' or MCAR_Status__c='No Trouble Found') and Manufacture_Accepts_Fault__c= 'YES']);                                                                     
            }
            else if(flag=='lm' || flag==null)
            {               
                mcars = new List<MCAR__c>([select id,Name,MCAR_Defect_Location__c,MCAR_Status__c,MCAR_Part_Enterprise_ID__c,MCAR_Defect_Quantity__c,Category_Group_text__c,Category_Area_text__c,Category__c,MCAR_Manufacturer__r.Name,MCAR_Creation_Date_Status_Open__c,MCAR_Closed_Date__c,(select id,field,CreatedDate from Histories where (field = 'MCAR_Containment_Action__c' or field = 'MCAR_4D_Root_Cause__c') order by CreatedDate desc) from MCAR__c where (MCAR_Status__c ='Closed' or MCAR_Status__c='No Trouble Found') and Manufacture_Accepts_Fault__c= 'YES' and MCAR_Closed_Date__c = LAST_MONTH]);                                                                     
            }
            
            if(Test.IsRunningTest())
            {
                mcars = new List<MCAR__c>([select id,Name,MCAR_Defect_Location__c,MCAR_Status__c,MCAR_Part_Enterprise_ID__c,MCAR_Defect_Quantity__c,Category_Group_text__c,Category_Area_text__c,Category__c,MCAR_Manufacturer__r.Name,MCAR_Creation_Date_Status_Open__c,MCAR_Closed_Date__c,(select id,field,CreatedDate from Histories where (field = 'MCAR_Containment_Action__c' or field = 'MCAR_4D_Root_Cause__c') order by CreatedDate desc) from MCAR__c]);                                                                    
            }
            ///---------------------------------------------------------------------------------------------------------------------------------------//                
            
            
            for(MCAR__c mcar : mcars)
            {                   
                //--------------------------------------Local Variale declaration---------------------------------------// 
                String SPEPeriod;
                Decimal CycleTime3D;   
                Decimal CycleTime4D;
                Decimal CycleTimeMCAR;
                
                //------------------------MCAR Closed Date to SPE Period format-----------------------------------------//
                    
                SPEPeriod = mcar.MCAR_Closed_Date__c.year()+'-'; 
                
                if(mcar.MCAR_Closed_Date__c.Month()<=9)
                {                    
                 SPEPeriod = SPEPeriod+'0'+mcar.MCAR_Closed_Date__c.Month();                       
                }                   
                else
                    SPEPeriod = SPEPeriod+mcar.MCAR_Closed_Date__c.Month();
                                
                //--------------------------------------------------------------------------------------------------------//                
                List<mcar__History> mcarHistory = mcar.getSObjects('Histories');                                                  
                if(mcarHistory!=null)
                for(mcar__History h : mcarHistory)
                {                                        
                        if(CycleTime3D!=null && CycleTime4D!=null) break;                            
                        else if(CycleTime3D==null && h.field=='MCAR_Containment_Action__c')
                        {                            
                            Date c3date = date.newInstance(h.CreatedDate.year(),h.CreatedDate.month(),h.CreatedDate.day());                              
                            CycleTime3D = mcar.MCAR_Creation_Date_Status_Open__c.daysBetween(c3date);
                        }
                        else if(CycleTime4D==null && h.field=='MCAR_4D_Root_Cause__c')
                        {
                            Date c4date = date.newInstance(h.CreatedDate.year(),h.CreatedDate.month(),h.CreatedDate.day());                             
                            CycleTime4D = mcar.MCAR_Creation_Date_Status_Open__c.daysBetween(c4date);
                        }
                }          
                CycleTimeMCAR = mcar.MCAR_Creation_Date_Status_Open__c.daysBetween(mcar.MCAR_Closed_Date__c);                                
                
                String KeyVal = SPEPeriod+mcar.MCAR_Part_Enterprise_ID__c+mcar.MCAR_Manufacturer__r.Name+mcar.Category_Area_text__c+mcar.Category_Group_text__c+mcar.Category__c;                
                MCARData mcarstemp = new MCARData(SPEPeriod,mcar.MCAR_Part_Enterprise_ID__c,mcar.MCAR_Manufacturer__r.Name,mcar.Category_Area_text__c,mcar.Category_Group_text__c,mcar.Category__c,mcar.Name,mcar.MCAR_Defect_Quantity__c,CycleTime3D,CycleTime4D,CycleTimeMCAR,mcar.MCAR_Defect_Location__c);                
                                                     
                if(!mcarMaps.containsKey(KeyVal))            
                {                
                    List<MCARData> mcartemplist = new List<MCARData>();
                    mcartemplist.add(mcarstemp);
                    mcarMaps.put(keyval,mcartemplist);                  
                }
                else
                {
                    mcarMaps.get(keyval).add(mcarstemp);
                }
            }               
            ReportAggregation();       
            ListMcarData.add(report);
            
            for(List<ReportData> rdl: ListMcarData)
            {
                for(ReportData rd : rdl)
                {
                    system.debug('***>>'+rd.eid);   
                }
            }
        }
        catch(Exception e)
        {
            boolean isnotified = MCARReportScheduler.adminNotification('MCARReportController',e.getLineNumber(),e.getMessage(),e.getTypeName());
            
            system.debug('****************Exception block***********************');
            system.debug('Cause       : '+e.getCause());
            system.debug('Line NUmber : '+e.getLineNumber());                                                  
            system.debug('Message     : '+e.getMessage());            
            system.debug('Type        : '+e.getTypeName());
            system.debug('******************************************************');
        }        
    }
    
    public void ReportAggregation()
    {        
            for(string str : mcarMaps.keySet())
            {                
                //system.debug('***\n'+mcarMaps.get(str));  
                Decimal ct3davg=0;
                Decimal ct4davg=0;
                decimal ctmcaravg=0;    
                decimal quantity = 0;
                
                boolean ct3dflag = true;
                boolean ct4dflag = true;
                
                MCARData tempMcarData;
                    
                integer count=0;       
                integer cd3dcount = 0;
                integer cd4dcount = 0;
                integer Failurecount=0;

                for(MCARData mcardata : mcarMaps.get(str))
                {
                    if(mcardata.CT3D!=null) 
                    {
                        ct3davg = mcardata.CT3D+ct3davg;
                        ct3dflag = false;                                      
                    }                     
                    else cd3dcount = cd3dcount+1;
                    if(mcardata.CT4D!=null)
                    {
                        ct4davg = mcardata.CT4D+ct4davg;
                        ct4dflag = false;                                
                    }       
                    else cd4dcount = cd4dcount+1;                    
                    
                    ctmcaravg = mcardata.CTmcar+ctmcaravg;
                    quantity = mcardata.quantity+quantity;                                        
                    tempMcarData = mcardata;                     
                    count++;                                                      
                    
                    if(mcardata.defectlocation!=null)
                    {
                     if(mcardata.defectlocation.contains('Customer Field'))
                        Failurecount++;   
                    }                  
                    else
                        mcardata.defectlocation = '';                        
                }            
                    
                
                if(ct3dflag) ct3davg = null;
                if(ct4dflag) ct4davg = null;                                                                         
                
                if(ct3davg<0) ct3davg =  null;
                if(ct4davg<0) ct4davg = null;
                    
                if(ct3davg!=null && ct4davg!=null)
                {
                    ReportData rd = new ReportData(tempMcarData.period,tempMcarData.eid,tempMcarData.Manufacturer,tempMcarData.categoryArea,tempMcarData.CategoryGroup,tempMcarData.category,count,quantity,(ct3davg/(count-cd3dcount)),(ct4davg/(count-cd4dcount)),(ctmcaravg/count),Failurecount);                  
                    report.add(rd);                        
                }
                else if((ct3davg==null)&&(ct4davg==null))
                {
                    ReportData rd = new ReportData(tempMcarData.period,tempMcarData.eid,tempMcarData.Manufacturer,tempMcarData.categoryArea,tempMcarData.CategoryGroup,tempMcarData.category,count,quantity,null,null,(ctmcaravg/count),Failurecount);                    
                    report.add(rd);
                }
                else if(ct3davg==null)
                {
                    //system.debug(tempMcarData.period+'**'+tempMcarData.eid+'**'+tempMcarData.Manufacturer+'**'+tempMcarData.categoryArea+'**'+tempMcarData.CategoryGroup+'**'+count+'**'+quantity+'**'+ct3davg+'**'+ct4davg+'**'+ctmcaravg+'**'+Failurecount);
                    ReportData rd = new ReportData(tempMcarData.period,tempMcarData.eid,tempMcarData.Manufacturer,tempMcarData.categoryArea,tempMcarData.CategoryGroup,tempMcarData.category,count,quantity,null,(ct4davg/(count-cd4dcount)),(ctmcaravg/count),Failurecount);                 
                    report.add(rd);
                }
                else if(ct4davg==null)
                {
                    ReportData rd = new ReportData(tempMcarData.period,tempMcarData.eid,tempMcarData.Manufacturer,tempMcarData.categoryArea,tempMcarData.CategoryGroup,tempMcarData.category,count,quantity,(ct3davg/(count-cd3dcount)),null,(ctmcaravg/count),Failurecount);                 
                    report.add(rd);
                }                                
                                                
                if(report.size()>=500)
                {                                       
                    ListMcarData.add(report.clone());
                    report.clear();
                }
                                 
                /*
                system.debug('------------------------------');                    
                system.debug('SPE Period       :'+str);       
                system.debug('EID              :'+tempMcarData.eid);
                system.debug('Manufacturer     :'+tempMcarData.manufacturer);
                system.debug('Category Area    :'+tempMcarData.categoryArea);                    
                system.debug('Category Group   :'+tempmcardata.CategoryGroup);
                system.debug('MCAR Cases       :'+count);                    
                system.debug('Quantity         :'+quantity);                
                    
                    if(ct3dflag) system.debug('3D CT avg        : '+ct3davg);   
                    else system.debug('3D CT avg        : '+ct3davg/(count-cd3dcount));   
                    if(ct4dflag) system.debug('4D CT avg        : '+ct4davg);
                    else system.debug('4D CT avg        : '+ct4davg/(count-cd4dcount));
                    
                system.debug('Close CT avg     :'+ctmcaravg/count);
                system.debug('Field Failure    :'+Failurecount);
                system.debug('------------------------------');                    
                        */  
            }
    }    
        
    public class ReportData
    {        
        public String Period{ set; get; }
        public String EID { set; get; }
        public String Manufacturer{ set; get; }       
        public String categoryArea{ set; get; }       
        public String CategoryGroup{ set; get; }
        public string category { set; get; }
        public Integer MCARCases{ set; get; }
        
        public Decimal quantity{ set; get; }
        public Decimal CT3Davg{ set; get; }
        public Decimal CT4Davg{ set; get; }
        public Decimal CTMCARavg{ set; get; }
        
        public Integer FieldFailurer {set; get;}

        public ReportData(String Period,String EID,String Manufacturer,String categoryArea,String CategoryGroup,string category,Integer MCARCases,Decimal quantity,Decimal CT3Davg,Decimal CT4Davg,Decimal CTMCARavg,Integer FieldFailurer)
        {
            this.period = period;
            this.eid = eid;
            this.manufacturer = manufacturer;            
            this.categoryArea = categoryArea;                            
            this.CategoryGroup = CategoryGroup;
            this.category = category;
            this.MCARCases = MCARCases;
            this.quantity = quantity;
            
            if(CT3Davg==null)
                this.CT3Davg = CT3Davg;          
            else 
                this.CT3Davg = CT3Davg.setScale(2);          
                
            if(CT4Davg==null)
                this.CT4Davg = CT4Davg;
            else 
                this.CT4Davg = CT4Davg.setScale(2);
            
            if(CTMCARavg==null)
                this.CTMCARavg = CTMCARavg;
            else
                this.CTMCARavg = CTMCARavg.setScale(2);
            
            this.FieldFailurer = FieldFailurer;
        }
    }
    
    public class MCARData
    {        
        String Period;
        String EID;
        String Manufacturer;         
        String categoryArea;         
        String CategoryGroup;
        String Category;
        String MCARNo;                                   

        Decimal quantity;        
        Decimal CT3D;
        Decimal CT4D;
        Decimal CTMCAR;
        
        String DefectLocation;                   
        
        public MCARData(String Period,String EID,String Manufacturer,String categoryArea,String CategoryGroup,String Category,String MCARNo,Decimal Quantity, Decimal CT3D, Decimal CT4D, Decimal CTMCAR,String DefectLocation)
        {            
            this.period = period;
            this.eid = eid;
            this.manufacturer = manufacturer;            
            this.categoryArea = categoryArea;                            
            this.CategoryGroup = CategoryGroup;
            this.category = Category;
            this.MCARNo = MCARNo;                
            this.quantity = quantity;                
            this.CT3D = CT3D;                
            this.CT4D  = CT4D;                        
            this.CTMCAR = CTMCAR;                
            this.DefectLocation = DefectLocation;
        }
    }    
}