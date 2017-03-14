//Test Class Name : MySupplierDataController_Test
public class supplierSpendController{
    public static String id;
    public supplierSpendController() {
        id=UserInfo.getUserId();
        getChartData();
    }
 
    public static List<barGraphData> getChartData() {    
        List<Account> acc = new list<Account>();
        List<barGraphData> data = new List<barGraphData>();
        acc = [select id, Name, Actual_Spend__c, LE_Spend__c from account where (LSM__c=:id OR SAM_Innovation_Manager__c=:id OR Supplier_Governance_Manager__c=:id OR Sponsor__c=:id) AND Unique_Id__c != NULL];
     
        if(!acc.isEmpty()){
            System.debug('inside'+acc.isEmpty());
            Map<String,Decimal> spendActual = new Map<String,Decimal>();
            Map<String,Decimal> spendLE = new Map<String,Decimal>();
      
            for(account a:acc){  
                Decimal spendActualAmount;
                Decimal spendLEAmount;
                System.debug('a.Actual_Spend__c:-'+a.Actual_Spend__c);
                if ((a.Actual_Spend__c != 0) && (a.Actual_Spend__c != null)){
                    spendActualAmount = (decimal)a.Actual_Spend__c;
                    spendActual.put(a.name,spendActualAmount);
                }
                else 
                    spendActualAmount =0;
       
                if((a.LE_Spend__c != 0) && (a.LE_Spend__c != null)){
                    spendLEAmount = (decimal)a.LE_Spend__c ;  
                    spendLE.put(a.name,spendLEAmount);
                }
                else
                    spendLEAmount =0;               
                
            }
            
            Set<String> supplierSet = new Set<String>();
            for(account a : acc){
                if(!supplierSet.contains(a.name)){
                supplierSet.add(a.name);
                barGraphData d = new barGraphData();
                d.supplier= a.name;
                if(spendActual.containsKey(d.supplier))
                    d.SpendAct=spendActual.get(d.supplier);
                else 
                    d.SpendAct=0;
                    
                if(spendLE.containsKey(d.supplier))
                    d.SpendLE=spendLE.get(d.supplier);
                else 
                    d.SpendLE=0;
                          
                d.totalCount = d.SpendAct+ d.SpendLE;
                if (d.totalCount !=0 )
                data.add(d);
                }
            }
        }
        else{
            ApexPages.Message msg = new ApexPages.Message(Apexpages.Severity.INFO, 'No Spend data available' );
            ApexPages.addMessage(msg);              
        }
    return data;
   }

   public class barGraphData {       
       public String supplier { get; set; }
       public Decimal SpendAct { get; set; }
       public Decimal SpendLE { get; set; }
       public Decimal totalCount { get; set;}
       public barGraphData() {
       }
   }
}