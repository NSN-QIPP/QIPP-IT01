public class StrategicSupplierOverviewController{
    public List<RadarData> data {get;set;}
    public static String id;
    Public Map<String,Decimal> radraMap;
    public StrategicSupplierOverviewController(){
        id=userinfo.getuserId();
    radraMap = new Map<String,Decimal>();
        List<PI_Param__c> piPramaList = new List<PI_Param__c>();
        for(Account acc : [select id,Name,LSM__c,Supplier_Governance_Manager__c,Business_Owner__c,SAM_Innovation_Manager__c,Sponsor__c,(select Delivery__c,Innovation__c,Quality__c,Relationship__c,Commercial__c,Sustainability__c FROM PI_Params__r ORDER BY CreatedDate desc limit 1 ) from Account where (LSM__c=:id OR SAM_Innovation_Manager__c=:id OR Supplier_Governance_Manager__c=:id OR Sponsor__c=:id or Lead_Category_Manager__c=:id) and Unique_Id__c != NULL]){
            if(!acc.PI_Params__r.isEmpty()){  
                PI_Param__c  param = acc.PI_Params__r;
              if(param.Delivery__c != null || param.Innovation__c != null || param.Quality__c != null
                 || param.Relationship__c != null || param.Commercial__c != null || param.Sustainability__c != null){
                     piPramaList.add(acc.PI_Params__r) ;
                 }
                
            }

        }

        radraMap.put('Quality',0);
        radraMap.put('Commercial',0);
        radraMap.put('Delivery',0);
        radraMap.put('Innovation',0);
        radraMap.put('Relationship',0);
        radraMap.put('Sustainability',0);
          system.debug('test$$$$$$');
        for(PI_Param__c acc : piPramaList ){
system.debug('Param record......'+acc);
            if(acc.Quality__c != null)
        radraMap.put('Quality', radraMap.get('Quality')+acc.Quality__c);
            
            if(acc.Commercial__c != null)
          radraMap.put('Commercial', radraMap.get('Commercial')+acc.Commercial__c);
            
            if(acc.Delivery__c != null)
          radraMap.put('Delivery', radraMap.get('Delivery')+acc.Delivery__c);
            
            if(acc.Innovation__c != null)
          radraMap.put('Innovation', radraMap.get('Innovation')+acc.Innovation__c);
            
            if(acc.Relationship__c != null)
          radraMap.put('Relationship', radraMap.get('Relationship')+acc.Relationship__c);
             if(acc.Sustainability__c != null)
          radraMap.put('Sustainability', radraMap.get('Sustainability')+acc.Sustainability__c);
          system.debug('radraMap.....'+radraMap);
        }
 try{       
        for(String str : radraMap.keyset()){
            radraMap.put(str,radraMap.get(str)/piPramaList.size());
        }
        system.debug('after avg.....'+radraMap);
        data = new List<RadarData> ();
        for(String str : radraMap.keyset()){
            data.add(new RadarData(str, radraMap.get(str),100));
        }
                  
}
    catch(Exception ex){
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'No data available');
            ApexPages.addMessage(myMsg);
    }
     //system.debug('datadatadata'+data[0].finalparam);                 
    }
    
    public class RadarData {
        Public String performanceParam{get;set;}
        Public Decimal percentage{get;set;}
        Public String finalparam{get;set;}
        public Decimal maxLimit { set; get; }
        
        public RadarData(String performanceParam, Decimal percentage, Decimal maxLimit) {
            this.performanceParam= performanceParam;
            this.percentage= percentage;
            this.finalparam = performanceParam + ':' + percentage;
            this.maxLimit = maxLimit;
        }
    }
}