public class SPE_KPIAdhocScheduleExt 
{
    public SPE_KPIDefinition__c objKPIDef{get;set;}
    public Integer inputdate {get;set;}
    public List<SelectOption> lstMonth;
    public List<SelectOption> lstYear;
    public String monthVal {get;set;}
    public Integer yearVal {get;set;}
    Map<String,Integer> yearMonthMap = new Map<String,Integer>{'Jan' => 1,
                                                               'Feb' => 2,
                                                               'Mar' => 3,
                                                               'Apr' => 4,
                                                               'May' => 5,
                                                               'Jun' => 6,
                                                               'Jul' => 7,
                                                               'Aug' => 8,
                                                               'Sep' => 9,
                                                               'Oct' => 10,
                                                               'Nov' => 11,
                                                               'Dec' => 12
                                                                };
    Id idKpiRec;
    List<SPE_KPIDefinition__c> lstKPIDefn;
    public SPE_KPIAdhocScheduleExt(ApexPages.StandardController con)
    {
        objKPIDef = [SELECT Id, adhoc_date__c,Number_Of_Months__c FROM SPE_KPIDefinition__c WHERE Id =: con.getId()];
        inputdate=1;
    }
    
    public PageReference scheduleBatch()
    {
        
        Date adhocDate = date.newInstance(yearVal,yearMonthMap.get(monthVal),inputdate);
        system.debug('date is'+adhocDate);
        objKPIDef.Adhoc_Date__c = adhocDate.addMonths(inputdate );
        objKPIDef.Number_Of_Months__c=inputdate ;
        update objKPIDef;
        
        delete[select id from SPE_KPIStats__c where kpi__c=:objKPIDef.Id];
        
        SPE_KPISchedulebatch1Adhoc objBatch= new SPE_KPISchedulebatch1Adhoc(objKPIDef.Id);
        String CronExp= Datetime.now().addMinutes(1).format('ss mm HH dd MM ? yyyy');
        System.schedule(SPE_Constants.KPIAdhocScheduleJob+system.now(),CronExp,objBatch);
        
        
        PageReference pgRef = new PageReference('/'+objKPIDef.Id);
        pgRef.setRedirect(true);
        return pgRef;
        
        
        
        /*lstKPIDefn = [select id,Adhoc__c from SPE_KPIDefinition__c where Adhoc__c = true ];
        try{
            if(lstKPIDefn.isEmpty()){
                objKPIDef.Adhoc__c= true;
                if (objKPIDef != null)
                    //update objKPIDef;
                SPE_KPISchedulebatch1Adhoc objBatch= new SPE_KPISchedulebatch1Adhoc();
                database.executebatch(objBatch,10000);
                PageReference pgRef = new PageReference('/'+idKpiRec);
                pgRef.setRedirect(true);
                return pgRef;
            }
            else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,System.Label.SPE_BatchAlreadyRunning));
                return null;
            }
        }catch(Exception ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
            return null;
        }
        */
    }
    
    public List<SelectOption> getMonth(){
        lstMonth = new List<SelectOption>();
        lstMonth.add(new SelectOption('Jan','Jan'));
        lstMonth.add(new SelectOption('Feb','Feb'));
        lstMonth.add(new SelectOption('Mar','Mar'));
        lstMonth.add(new SelectOption('Apr','Apr'));
        lstMonth.add(new SelectOption('May','May'));
        lstMonth.add(new SelectOption('Jun','Jun'));
        lstMonth.add(new SelectOption('Jul','Jul'));
        lstMonth.add(new SelectOption('Aug','Aug'));
        lstMonth.add(new SelectOption('Sep','Sep'));
        lstMonth.add(new SelectOption('Oct','Oct'));
        lstMonth.add(new SelectOption('Nov','Nov'));
        lstMonth.add(new SelectOption('Dec','Dec'));

        return lstMonth;
    }
    
    public List<SelectOption> getYear(){
        lstYear = new List<SelectOption>();
            lstYear.add(new SelectOption(string.valueof(System.Today().year()),string.valueof(System.Today().year())));
            lstYear.add(new SelectOption(string.valueof(System.Today().year()-1),string.valueof(System.Today().year()-1)));
            lstYear.add(new SelectOption(string.valueof(System.Today().year()-2),string.valueof(System.Today().year()-2)));
            return lstYear; 
            }
            
    
}