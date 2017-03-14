public class leadSupplierManager {
    
    public static String id;
    public leadSupplierManager(ApexPages.StandardController controller) {
        id=apexpages.currentpage().getparameters().get('id');
    }

    public static List<barGraphData> getChartData() {    
        List<SPE_Spend__c> spend = new list<SPE_Spend__c>();
        List<barGraphData> data = new List<barGraphData>();
        spend = [select CategoryArea__c,Spend__c, Period__c from SPE_Spend__c where EnterpriseId__c =:id order by Period__c
];
        System.debug(spend);
        if(!spend.isEmpty()){
            Map<Integer,Decimal> SP = new Map<Integer,Decimal>();
            Map<Integer,Decimal> PP = new Map<Integer,Decimal>();
            Map<Integer,Decimal> INP = new Map<Integer,Decimal>();
      
        for(SPE_Spend__c spe:spend){       
            Decimal spendAmount = (decimal)spe.Spend__c;
            Date period = spe.Period__c;
            System.debug('spendAmount:-'+spendAmount+' and period.year-'+period.year());
            if (spe.CategoryArea__c=='Services Procurement Operations (SPO)'){
                if(SP.containsKey(period.year()))
                    SP.put(period.year(), SP.get(period.year())+spendAmount);
                else 
                    SP.put(period.year(),spendAmount);
            }
            if (spe.CategoryArea__c=='Indirect Procurement Operations (INPO)'){
                if(INP.containsKey(period.year()))
                    INP.put(period.year(), INP.get(period.year())+spendAmount);
                else 
                    INP.put(period.year(),spendAmount);
            }
            if (spe.CategoryArea__c=='Product Procurement Operations (PPO)'){
                if(PP.containsKey(period.year()))
                    PP.put(period.year(), PP.get(period.year())+spendAmount);
                else 
                    PP.put(period.year(),spendAmount);
            }
        }
        
        System.Debug(SP.keySet()+' and values:-'+SP.values());
        System.Debug(INP.keySet()+' and values:-'+INP.values());
        System.Debug(PP.keySet()+' and values:-'+PP.values());
            
        Set<Integer> dateset = new Set<Integer>();
        for(SPE_Spend__c spen:spend){
            Date period = spen.Period__c;
            if(!dateset.contains(period.year())){
                dateset.add(period.year());
                barGraphData d = new barGraphData();
                d.year = period.year();
                if(SP.containsKey(d.year))
                    d.SPO=SP.get(d.year);
                else 
                    d.SPO=0;
               
                if(PP.containsKey(d.year))
                    d.PPO=PP.get(d.year);
                else 
                    d.PPO=0;
               
                if(INP.containsKey(d.year))
                    d.INPO=INP.get(d.year);
                else 
                    d.INPO=0;
               
                d.totalcount = d.SPO+ d.PPO+d.INPO;
                data.add(d);
            }
        }
    }
    else{
        ApexPages.Message msg = new ApexPages.Message(Apexpages.Severity.INFO, 'No Spend data available' );
        ApexPages.addMessage(msg);  
        //return null;       
    }
    system.debug(data);
    return data;
   }
   // Wrapper class 
   public class barGraphData {       
       public Integer year { get; set; }
       public Decimal SPO { get; set; }
       public Decimal PPO { get; set; }
       public Decimal INPO { get; set; }
       public Decimal totalcount {get;set;}
       public barGraphData() {
       }
   }
}