public with sharing class SPE_scorecardEXT {
public AggregateResult[]  Deliveryresults{get;set;}
public Map<Id, SPE_KPIDefinition__c> IdValueKPIMap {get;set;} 
public String SupplierName{get;set;}
public list<ScorecardKPIMap__c> scoreKPIMap {get;set;}
public list<ScorecardKPIMap__c> scoreKPIMapbySPe {get;set;}
public Map<String,List<ScorecardKPIMap__c>> KPITemplateMap {get;set;}
public decimal OverallScore {get;set;}
public decimal OverallScoreper {get;set;}
public id sid;
public String strPgDisplay{get;set;} 
public boolean isShowScorecard{get;set;}
public boolean isPasswordCorrect{get;set;}
public string providePassword{get;set;}   
public String strMode{get;set;}
public String strKPIName{get;set;}
public String KPINameDisplay =''; 

    public SPE_scorecardEXT(ApexPages.StandardController controller) {
        sid=controller.getId();
        ScorecardCalculations(sid);
        
        system.debug('***sid'+sid);
        isPasswordCorrect = true;
        strKPIName = [select Id, ScorecardTracker__r.ScorecardGenerator__r.AdhocScorecardName__c from SPE_ScoreCard__c where Id=:sid].ScorecardTracker__r.ScorecardGenerator__r.AdhocScorecardName__c;
        Id Scorecardtempl=[select id,ScorecardTemplate__c from SPE_ScoreCard__c where id=:sid].ScorecardTemplate__c ;
        strPgDisplay = [select id,Password__c from SPE_ScoreCard__c where id=:sid].Password__c;
        system.debug('***strPgDisplay'+strPgDisplay);
        SupplierName=[select id,Supplier__r.name from SPE_ScoreCard__c where id=:sid].Supplier__r.name;
               
        //strMode = ApexPages.currentpage().getURL();
        strMode = URL.getSalesforceBaseUrl()+'';
        system.debug('strMode---' + strMode);
        if(strMode.contains('visual'))
            strMode = 'internal';
        else
            strMode = 'site';
        
        if(strMode == 'site')
            isShowScorecard = false;
        else
            isShowScorecard = true;
         
        
        
               
        list<SPE_ScorecardSPETemplateMap__c> scorecardMapTemp= [select id,SPETemplate__r.name,Weight__c from SPE_ScorecardSPETemplateMap__c where ScorecardTemplate__c=:Scorecardtempl];
        Decimal total=0.0; 
        overallScore=0.00;
        Map<string,Decimal> mapofWeight= new Map<string,Decimal>();
        system.debug('scorecardMapTemp--' + scorecardMapTemp.size());
        for(SPE_ScorecardSPETemplateMap__c s:scorecardMapTemp){
        if(s.SPETemplate__r.name != null && s.SPETemplate__r.name != '')
            mapofWeight.put(s.SPETemplate__r.name,s.Weight__c );
        }
        system.debug('TemplateDisplay--' + TemplateDisplay.size());
        for(SPE_ScorecardValues__c s:TemplateDisplay ){
            if(mapofWeight.containskey(s.SPE_Template_Name__c) && s.SPE_Template_Name__c != null && s.SPE_Template_Name__c != ''){
                OverallScore=overallScore+(s.score__c*mapofWeight.get(s.SPE_Template_Name__c));
                total=total+mapofWeight.get(s.SPE_Template_Name__c);
            }
        }
        
        if(total != 0.0)
        OverallScore=(OverallScore/total).setScale(2);
       
            
    }
    
    
    
/** New calculations **/    
public list<SPE_ScorecardValues__c> TemplateDisplay {get;set;}    
public scorecardviewNew[] scorecarddisplayNew{get;set;}    
   public void ScorecardCalculations(id Sid) {
    
    TemplateDisplay = new list<SPE_ScorecardValues__c>();
    TemplateDisplay =[select SPE_Template_Name__c,Score__c from SPE_ScorecardValues__c where ScoreCard__c=:Sid and KPI__c=Null and group__c=null];
    set<string> setOfname= new set<string>();
    for(SPE_ScorecardValues__c s : TemplateDisplay )
    setOfname.add(s.SPE_Template_Name__c);
    
    
    scorecarddisplayNew= new list<scorecardviewNew>();   
    list<SPE_ScorecardValues__c> listofRecords= new list<SPE_ScorecardValues__c>();
    
    for(string s:setOfname){
    
  //*************************************Changes For Encryption********************************//  
    listofRecords=[select id,SPE_Template_Name__c,Group__c,Score__c,KPI__r.AbbreviatedName__c,KPI__r.name,KPI__r.KPI_Title__c,kpi__r.group1__c,kpi__r.Confidential__c from SPE_ScorecardValues__c where ScoreCard__c=:Sid and (KPI__c!=Null OR group__c!=Null) and SPE_Template_Name__c=:s];
  //*************************************END********************************//  
  
    scorecarddisplayNew.add(new scorecardviewNew(s,listofRecords));  
    }
    }
    
    public class scorenew{
    public String KPiAbbr1{get;set;}
    public String KPiname1{get;set;}
    public Decimal Score1{get;set;}
    public boolean Confidential1{get;set;}
    
    public scorenew(String KPiAbbr,String KPiname,Decimal Score,boolean Confidential){
     KPiAbbr1=KPiAbbr;
     kPiname1=KPiname;  
     score1=score;
     Confidential1=Confidential;
    }
    
    }
    
    
    public class scorecardviewNew {
    public list<SPE_ScorecardValues__c > Quality{get;set;}
    public list<scorenew> Quality1 {get;set;}
    public list<SPE_ScorecardValues__c > Relationship{get;set;}
    public list<scorenew> Relationship1{get;set;}
    public list<SPE_ScorecardValues__c > Cost{get;set;}
    public list<scorenew> Cost1{get;set;}
    public list<SPE_ScorecardValues__c > Delivery{get;set;}
    public list<scorenew> Delivery1{get;set;}
    public list<SPE_ScorecardValues__c > Innovation {get;set;}
    public list<scorenew> Innovation1{get;set;}
    public String QualityScore{get;set;}
    public String CostScore{get;set;}
    public String RelationScore{get;set;}
    public String DeliveryScore{get;set;}
    Public string TemplateName{get;set;}
    Public string InnovationScore{get;set;}
    public Set<Id> KPIIDSet{get;set;}
    public Decimal templateScore{get;set;}
    public String KPINameDisplay='';    
    public AggregateResult[]  Deliveryresults{get;set;}
    public scorecardviewNew (String s,list<SPE_ScorecardValues__c> ScoreValues) {
     TemplateName=s;
     Quality1= new list<scorenew>();
     Relationship1= new list<scorenew>();
     Cost1= new list<scorenew>();
     Delivery1= new list<scorenew>();
     Innovation1= new list<scorenew>();
     Delivery= new list<SPE_ScorecardValues__c >();
     Cost=new list<SPE_ScorecardValues__c >();
     Quality=new list<SPE_ScorecardValues__c >();
     Relationship=new list<SPE_ScorecardValues__c >();
     Innovation=new list<SPE_ScorecardValues__c >(); 
    //Quality, Delivery, Commercial, Innovation and Relationship
    for(SPE_ScorecardValues__c v:ScoreValues){
        
    if(v.Kpi__r.group1__c=='Delivery')
    {
        Delivery.add(v);
        Delivery1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c));
    }
    if(v.Kpi__r.group1__c=='Commercial')
    {
        cost.add(v);
        cost1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c));
    }
    if(v.Kpi__r.group1__c=='Quality')
    {
        Quality.add(v);
        Quality1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c));
    }
    if(v.Kpi__r.group1__c=='Relationship')
    {
        Relationship.add(v); 
        Relationship1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c));
    }
    if(v.Kpi__r.group1__c=='Innovation')
    {
        Innovation.add(v);
        Innovation1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c)); 
    }                
    
    if(v.group__c!='' && v.group__c=='Quality')
    QualityScore=(string.valueof(v.score__c)).substring(0,4);
     if(v.group__c!='' && v.group__c=='Commercial')
    CostScore=(string.valueof(v.score__c)).substring(0,4);
     if(v.group__c!='' && v.group__c=='Relationship')
    RelationScore=(string.valueof(v.score__c)).substring(0,4);
     if(v.group__c!='' && v.group__c=='Delivery')
    DeliveryScore=(string.valueof(v.score__c)).substring(0,4);
    if(v.group__c!='' && v.group__c=='Innovation')
    InnovationScore=(string.valueof(v.score__c)).substring(0,4);
    
    
    }
    
    }
    }
    
    
    
    /* New calculation ends here */
    
    
    
    public void updateField(){
        SPE_ScoreCard__c s = new SPE_ScoreCard__c();
        s = [select id,ScorecardTemplate__c from SPE_ScoreCard__c where id=:sid];
        s.isScoreGenerated__c = true;
        try{
        update s;
        }
        catch(Exception ex){
            system.debug('Exception ex :: ' + ex.getMessage());
        }
    }
    public void showScorecard(){
    //system.debug('***providePassword.trim()'+providePassword.trim());
    //system.debug('***strPgDisplay.trim()'+strPgDisplay.trim());
        if(providePassword.trim() == strPgDisplay.trim()){
            isShowScorecard = true;
            isPasswordCorrect = true;
        }
        else{
            isPasswordCorrect = false;
            isShowScorecard = false;
        }
    }
     
     public PageReference createPDF()
    {
        PageReference pdf = new PageReference('/apex/SPE_Scorecardpdf?id='+sid);
        pdf.setRedirect(true);
        return pdf;
    }

     
}