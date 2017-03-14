public class SupplierPerformanceRadarChartController {
    public List<RadarData> data {get;set;}
    Public Map<String,Decimal> radraMap;
    public SupplierPerformanceRadarChartController (ApexPages.StandardController controller) {
        
    }
    
    Public pagereference generatePIParamData(){
        String id = apexpages.currentpage().getparameters().get('id');
        data = new List<RadarData>();
        radraMap = new Map<String,Decimal>();
        Account performanceList = new Account();
        PI_Param__c piPramaList = new PI_Param__c();
        performanceList = [select id,Name,(select Delivery__c,Innovation__c,Quality__c,Relationship__c,Commercial__c,Sustainability__c FROM PI_Params__r ORDER BY CreatedDate desc limit 1 ) from Account where ID =:id ];
        try{
        if(performanceList == null){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Supplier Performance data not available');
            ApexPages.addMessage(myMsg);
            System.debug(myMsg);
        }
        else{
             piPramaList=performanceList.PI_Params__r;      
            radraMap.put('Quality',0);
            radraMap.put('Commercial',0);
            radraMap.put('Delivery',0);
            radraMap.put('Innovation',0);
            radraMap.put('Relationship',0);
            radraMap.put('Sustainability',0);
            if(piPramaList.Quality__c != null)
                radraMap.put('Quality', radraMap.get('Quality')+piPramaList.Quality__c);
            
            if(piPramaList.Commercial__c != null)
                radraMap.put('Commercial', radraMap.get('Commercial')+piPramaList.Commercial__c);
            
            if(piPramaList.Delivery__c != null)
                radraMap.put('Delivery', radraMap.get('Delivery')+piPramaList.Delivery__c);
            
            if(piPramaList.Innovation__c != null)
                radraMap.put('Innovation', radraMap.get('Innovation')+piPramaList.Innovation__c);
            
            if(piPramaList.Relationship__c != null)
                radraMap.put('Relationship', radraMap.get('Relationship')+piPramaList.Relationship__c);
            
            if(piPramaList.Sustainability__c != null)
                 radraMap.put('Sustainability', radraMap.get('Sustainability')+piPramaList.Sustainability__c);
            data = new List<RadarData> ();
            for(String str : radraMap.keyset()){
                data.add(new RadarData(str, radraMap.get(str)));
            }
        }}
            catch(Exception e){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Supplier Performance data not available');
                ApexPages.addMessage(myMsg);
                System.debug(myMsg); 
            }
        return null;
            
    }
    
        
    public class RadarData {
        Public String performanceParam{get;set;}
        Public Decimal percentage{get;set;}
        Public String finalparam{get;set;}
        public Decimal maxLimit { set; get; }
        
        public RadarData(String performanceParam, Decimal percentage) {
            this.performanceParam= performanceParam;
            this.percentage= percentage;
            this.finalparam = performanceParam + ':' + percentage;
            this.maxLimit = 100;
        }
    }
    
}