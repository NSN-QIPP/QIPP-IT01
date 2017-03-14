public with sharing class SPE2_scorecardEXT  {
public AggregateResult[]  Deliveryresults{get;set;}
public Map<Id, SPE_KPIDefinition__c> IdValueKPIMap {get;set;} 
public String SupplierName{get;set;}
public list<ScorecardKPIMap__c> scoreKPIMap {get;set;}
public list<ScorecardKPIMap__c> scoreKPIMapbySPe {get;set;}
public Map<String,List<ScorecardKPIMap__c>> KPITemplateMap {get;set;}
public decimal OverallScore {get;set;}
public decimal OverallScoreper {get;set;}
public id sid {get;set;}
public String strPgDisplay{get;set;} 
public boolean isShowScorecard{get;set;}
public boolean isSite{get;set;}
public boolean isPasswordCorrect{get;set;}
public string providePassword{get;set;}   
public String strMode{get;set;}
public String strKPIName{get;set;}
public String KPINameDisplay =''; 
Public String selectedLang {get;set;}
public Set<ID> idOfKPI {get;set;}
public List<SPE2_Language_KPI__c> KPISPE2LanList {get;set;}
public Map<id,String> KPIlangMap{get;set;}
public Boolean ShowTrans{get;set;}
public SPE_ScoreCard__c scorecard{get;set;}
private List<SPE2_LanguageList__c> languages;
public String inputLanguage {get;set;}
public boolean showLangcol {get;set;}
public boolean isPPUser{get;set;}

public Integer templatePlanCount;
public boolean dispKPIval{get;set;}
public boolean dispKPITarget{get;set;}
public Map<String,string> kpiAvgMap{get;set;}
public Map<String,String> kpiTargetMap{get;set;}
public Map<String,Decimal> kpiWeightMap{get;set;}
public Map<String,Decimal> pillarWeightMap;
public boolean dispKPIWeight{get;set;}
public boolean dispPillarWeight{get;set;}
public Id scorecardGeneratorId;
public String scorecardPlanId;
public Id PlanTemplateId;
    public SPE2_scorecardEXT (ApexPages.StandardController controller) {
        kpiAvgMap = new Map<String,string>();
        kpiTargetMap = new Map<String,String>();
        kpiWeightMap = new Map<String,Decimal>();
        pillarWeightMap = new Map<String,Decimal>();
        scorecard = [select Stage__c,Comments__c,ScorecardTracker__c,Supplier__c,ScorecardTracker__r.Name,
                      ScorecardTracker__r.ScorecardGenerator__r.Aggregation_Period_Adhoc__c,
                      ScorecardTracker__r.ScorecardGenerator__r.isAdhoc__c,
                      ScorecardTracker__r.ScorecardGenerator__r.id,
                      ScorecardTracker__r.ScorecardGenerator__r.DisplayValues__c from SPE_ScoreCard__c 
                      WHERE id=:ApexPages.currentPage().getParameters().get('id')];
        Boolean gen_displayVal = scorecard.ScorecardTracker__r.ScorecardGenerator__r.DisplayValues__c; 
        system.debug('gen_displayVal ::'+gen_displayVal); 
        Boolean isAdhoc = scorecard.ScorecardTracker__r.ScorecardGenerator__r.isAdhoc__c;
        scorecardGeneratorId = scorecard.ScorecardTracker__r.ScorecardGenerator__r.id;  
        Integer scorecardPlansCount =[SELECT count() FROM SPE_Scorecard_Plan__c WHERE Scorecard_Generator__c =:scorecardGeneratorId];  
        system.debug('scorecardPlansCount ::'+scorecardPlansCount);       
        KPIlangMap = new map<id,String>();
        sid=controller.getId();
        if(isAdhoc && gen_displayVal){
            if(scorecardPlansCount == 1){
                system.debug('enetered 1st if here');
                dispKPIval=true;
                dispKPIWeight=true;
                dispPillarWeight=true;
                scorecardPlanId =[Select id,SPE_Plan__r.id From SPE_Scorecard_Plan__c 
                                    Where Scorecard_Generator__c =:scorecardGeneratorId].SPE_Plan__r.id;
                Set<String> trckerNames = fetchspeTrackers(scorecard.ScorecardTracker__r.Name,scorecard.ScorecardTracker__r.ScorecardGenerator__r.Aggregation_Period_Adhoc__c);
                List<AggregateResult> avgTrckrValuePerKPI = new List<AggregateResult>();
                avgTrckrValuePerKPI = [SELECT Avg(value__c) avgVal,KPIDefinition__c FROM SPE_TrackerValues__c 
                                         WHERE SPETracker__r.Name IN :trckerNames AND Supplier__c =: scorecard.Supplier__c
                                         AND SPETracker__r.SPEPlan__c =:scorecardPlanId Group by KPIDefinition__c];  
                system.debug('avgTrckrValuePerKPI ::'+avgTrckrValuePerKPI);                         
                for(AggregateResult val :avgTrckrValuePerKPI){
                    kpiAvgMap.put((String)val.get('KPIDefinition__c'),string.valueOf((decimal)val.get('avgVal')));
                }
                system.debug('kpiAvgMap ::'+kpiAvgMap);
            }
            PlanTemplateId =[Select id,SPETemplate__r.id From SPE_SPEPlan__c Where Id =:scorecardPlanId].SPETemplate__r.id;
            Integer planscoreTemplateCount =[SELECT count() FROM SPE_ScoringTemplate__c WHERE SPETemplate__r.id =:PlanTemplateId];
            system.debug('planscoreTemplateCount ::'+planscoreTemplateCount);
         //   if(planscoreTemplateCount == 1){
                    dispKPITarget=true;   
                    Id scoringtempId =[Select id,SPEScoringTemplate__r.id From SPE_SPEPlan__c Where Id =:scorecardPlanId].SPEScoringTemplate__r.id;
                   // Id scoretemplateId =[Select name,id from SPE_ScoringTemplate__c Where SPETemplate__r.id =:PlanTemplateId limit 1].id; 
                    system.debug('scoringtempId ::'+scoringtempId);              
                    List<SPE_ScoringTemplate__c> ScoringkpicalcLst =[Select Id,(Select KPIDefinition__c,KPIDefinition__r.IsHighBetter__c,Score__c,
                                                                     Lower__c,Upper__c,KPIDefinition__r.Level__c From Scoring_Calculations__r)
                                                                     From SPE_ScoringTemplate__c
                                                                     Where Id =:scoringtempId];
                     system.debug('ScoringkpicalcLst ::'+ScoringkpicalcLst);                                                  
                    Map<String,List<String>> kpiToScores = new Map<String,List<String>>();
                    for(SPE_ScoringCalculation__c scal :ScoringkpicalcLst[0].Scoring_Calculations__r){
                        if(!kpiToScores.containsKey(scal.KPIDefinition__c)){
                            kpiToScores.put(scal.KPIDefinition__c,new List<String>());                        
                        }
                        if(scal.KPIDefinition__r.IsHighBetter__c){
                            kpiToScores.get(scal.KPIDefinition__c).add('>'+scal.Lower__c);
                        }else{
                            kpiToScores.get(scal.KPIDefinition__c).add('<'+scal.Upper__c);
                        }
                    }
                    system.debug('kpiToScores ::'+kpiToScores); 
                    // SPE 2.1 changes starts here
                    for(String k :kpiToScores.keySet()){
                        if(kpiToScores.get(k).size() == 1){
                            integer scoreIndex = kpiToScores.get(k).size() - 1;
                            kpiTargetMap.put(k,kpiToScores.get(k)[scoreIndex]);  
                        }  
                        else{
                            integer scoreIndex = kpiToScores.get(k).size() - 2;
                            kpiTargetMap.put(k,kpiToScores.get(k)[scoreIndex]); 
                        }                 
                    }
                    // SPE 2.1 changes ends here
                    system.debug('kpiTargetMap ::'+kpiTargetMap);
            // } 
             List<SPE_SPETemplate__c> speTemplateKPI =[Select Id,(Select KPIDefinition__c,Weight__c From SPE_KPI_Maps__r)
                                                       From SPE_SPETemplate__c Where Id =:PlanTemplateId];
             for(SPE_SPEKPIMap__c kpimap :speTemplateKPI[0].SPE_KPI_Maps__r){
                 kpiWeightMap.put(kpiMap.KPIDefinition__c,kpiMap.Weight__c);
             } 
             system.debug('kpiWeightMap ::'+kpiWeightMap);                                                
             List<SPE_SPETemplate__c> speTempKPIList =[Select id,(Select KPIDefinition__c,KPIGroup1__c,Weight__c,KPIGroup2__c From SPE_KPI_Maps__r)
                                                        From SPE_SPETemplate__c Where Id = :PlanTemplateId];  
             Set<Id> kpiIds =new Set<Id>(); 
                   
             for(SPE_SPEKPIMap__c smap :speTempKPIList[0].SPE_KPI_Maps__r){
                kpiIds.add(smap.KPIDefinition__c);
             }    
             List<AggregateResult> kpiMapList =[Select KPIDefinition__r.Group1__c grp,Sum(Weight__c) wt
                                                 From SPE_SPEKPIMap__c 
                                                 Where KPIDefinition__c IN :kpiIds AND SPETemplate__c =:PlanTemplateId
                                                 group by KPIDefinition__r.Group1__c];
             for(AggregateResult smap :kpiMapList){
                pillarWeightMap.put((String)smap.get('grp'),(decimal)smap.get('wt'));
             }  
        }
        else if(isAdhoc && scorecardPlansCount > 1){
            system.debug('entered here ::');
            dispKPIWeight=true;
            dispPillarWeight=true;
            List<SPE_Scorecard_Plan__c> scdPlans = new List<SPE_Scorecard_Plan__c>();
            scdPlans = [Select id,SPE_Plan__c From SPE_Scorecard_Plan__c Where Scorecard_Generator__c =:scorecardGeneratorId];
            Set<String> plantempids = new Set<String>();
            for(SPE_Scorecard_Plan__c  sp :scdPlans){
                plantempids.add(sp.SPE_Plan__c);
            }
            List<SPE_SPEPlan__c> tempPlans = new List<SPE_SPEPlan__c>();
            tempPlans = [Select id,SPETemplate__c From SPE_SPEPlan__c Where Id IN :plantempids];
            Set<String> templateids = new Set<String>();
            for(SPE_SPEPlan__c pl :tempPlans ){
                templateids.add(pl.SPETemplate__c);
            }
            if(templateids.size() == 1){
                List<SPE_SPETemplate__c> speTemplateKPI =[Select Id,(Select KPIDefinition__c,Weight__c From SPE_KPI_Maps__r)
                                                       From SPE_SPETemplate__c Where Id IN:templateids];
                for(SPE_SPEKPIMap__c kpimap :speTemplateKPI[0].SPE_KPI_Maps__r){
                    kpiWeightMap.put(kpiMap.KPIDefinition__c,kpiMap.Weight__c);
                } 
                system.debug('kpiWeightMap ****'+kpiWeightMap);
                List<SPE_SPETemplate__c> speTempKPIList =[Select id,(Select KPIDefinition__c,KPIGroup1__c,Weight__c,KPIGroup2__c From SPE_KPI_Maps__r)
                                                        From SPE_SPETemplate__c Where Id IN:templateids];  
                 Set<Id> kpiIds =new Set<Id>(); 
                       
                 for(SPE_SPEKPIMap__c smap :speTempKPIList[0].SPE_KPI_Maps__r){
                    kpiIds.add(smap.KPIDefinition__c);
                 }    
                 List<AggregateResult> kpiMapList =[Select KPIDefinition__r.Group1__c grp,Sum(Weight__c) wt
                                                     From SPE_SPEKPIMap__c 
                                                     Where KPIDefinition__c IN :kpiIds AND SPETemplate__c IN:templateids
                                                     group by KPIDefinition__r.Group1__c];
                 for(AggregateResult smap :kpiMapList){
                    pillarWeightMap.put((String)smap.get('grp'),(decimal)smap.get('wt'));
                 }
                 system.debug('pillarWeightMap ****'+pillarWeightMap);  
            }
        }
        else{
            dispKPIval=false;
            dispKPIWeight=false;
            dispPillarWeight=false;
            dispKPITarget=false;
            list<SPE_ScorecardValues__c> temp_Template = new list<SPE_ScorecardValues__c>();
            temp_Template =[select SPE_Template_Name__c,Score__c from SPE_ScorecardValues__c where ScoreCard__c=:Sid and KPI__c=Null and group__c=null];
            set<string> setOfname= new set<string>();
            for(SPE_ScorecardValues__c s : temp_Template){
                setOfname.add(s.SPE_Template_Name__c);
            }             
            List<SPE_ScorecardValues__c> listofRecords=[select id,SPE_Template_Name__c,Group__c,Score__c,KPI__c from SPE_ScorecardValues__c where ScoreCard__c=:Sid and (KPI__c!=Null OR group__c!=Null) and SPE_Template_Name__c in :setOfName];
            for(SPE_ScorecardValues__c sv :listofRecords){
                kpiAvgMap.put(sv.KPI__c,'N-A');  
            }
        }
        ScorecardCalculations(sid);
        selectedValue = scorecard.Stage__c  ;
        //system.debug('Language Test'+selectedLang);
        if(selectedLang !=null){
            inputlanguage = selectedLang ;
        }
         
        showLangcol = false;
        if(inputlanguage!=null)
        showLangcol = true;
        system.debug('***sid'+sid);
        isPasswordCorrect = true;
        strKPIName = [select Id, ScorecardTracker__c,ScorecardTracker__r.Name,ScorecardTracker__r.ScorecardGenerator__r.AdhocScorecardName__c from SPE_ScoreCard__c where Id=:sid].ScorecardTracker__r.ScorecardGenerator__r.AdhocScorecardName__c;
        Id Scorecardtempl=[select id,ScorecardTemplate__c,ScorecardTracker__c,ScorecardTracker__r.Name from SPE_ScoreCard__c where id=:sid].ScorecardTemplate__c ;
        strPgDisplay = [select id,Password__c from SPE_ScoreCard__c where id=:sid].Password__c;
        system.debug('***strPgDisplay'+strPgDisplay);
        SupplierName=[select id,Supplier__r.name from SPE_ScoreCard__c where id=:sid].Supplier__r.name;
               
        //strMode = ApexPages.currentpage().getURL();
        strMode = URL.getSalesforceBaseUrl()+'';
        system.debug('strMode---' +strMode);
        if(strMode.contains('visual'))
            strMode = 'internal';
        else
            strMode = 'site';
        
        if(strMode == 'site')
        {
            isShowScorecard = false;
            isSite = false;
        }
        else{
            isShowScorecard = true;
            isSite = true;
        }
                         
        list<SPE_ScorecardSPETemplateMap__c> scorecardMapTemp= [select id,SPETemplate__r.name,Weight__c from SPE_ScorecardSPETemplateMap__c where ScorecardTemplate__c=:Scorecardtempl];
        Decimal total=0.0; 
        overallScore=0.00;
        Map<string,Decimal> mapofWeight= new Map<string,Decimal>();
        system.debug('scorecardMapTemp--' + scorecardMapTemp.size());
        for(SPE_ScorecardSPETemplateMap__c s:scorecardMapTemp){
        if(s.SPETemplate__r.name != null && s.SPETemplate__r.name != '')
            mapofWeight.put(s.SPETemplate__r.name,s.Weight__c );
            system.debug('mapofWeight **'+mapofWeight.get(s.SPETemplate__r.name));
        }
        
        system.debug('TemplateDisplay--' + TemplateDisplay.size());
        for(SPE_ScorecardValues__c s:TemplateDisplay){
            system.debug('spetemplatename ::'+s.SPE_Template_Name__c);
            system.debug('mapofWeight ::'+mapofWeight);
            if(mapofWeight.containskey(s.SPE_Template_Name__c) && s.SPE_Template_Name__c != null && s.SPE_Template_Name__c != ''){
                
                OverallScore=overallScore+(s.score__c*mapofWeight.get(s.SPE_Template_Name__c));
                total=total+mapofWeight.get(s.SPE_Template_Name__c);
            }
            system.debug('OverallScore1 ::'+OverallScore);
            system.debug('total ::'+total);
        }
        
        if(total != 0.0)
        OverallScore=(OverallScore/total).setScale(2);
        system.debug('OverallScore ::'+OverallScore);
          set<string> groupSet = new set<string>();
          isPPUser = false;
          for(GroupMember gm : [SELECT Group.name,UserOrGroupId FROM GroupMember where UserOrGroupId =:userInfo.getUserId()]){
           groupSet.add(gm.Group.name);
          }
          
          if(groupSet.contains('SPE1.0 User Group') && !groupSet.contains('SPE2.0 User Group')){
               isPPUser = false;
          } 
          else if(groupSet.contains('SPE2.0 User Group') && !groupSet.contains('SPE1.0 User Group')){
               isPPUser = true; 
          }
    
            
    }
    
    public Set<String> fetchspeTrackers(String scorecardTrackername,String aggrPeriod){
        Set<String> trackersName = new Set<String>();
      if(aggrPeriod == 'Quarterly'){
            if(scorecardTrackername.startsWith('Q1')){
                String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                trackersName.add('January - '+yearVal);
                trackersName.add('February - '+yearVal);
                trackersName.add('March - '+yearVal);
            }
            else if(scorecardTrackername.startsWith('Q2')){
                String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                trackersName.add('April - '+yearVal);
                trackersName.add('May - '+yearVal);
                trackersName.add('June - '+yearVal);
            }
            else if(scorecardTrackername.startsWith('Q3')){
                String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                trackersName.add('July - '+yearVal);
                trackersName.add('August - '+yearVal);
                trackersName.add('September - '+yearVal);
            }
            else{
                String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                trackersName.add('October - '+yearVal);
                trackersName.add('November - '+yearVal);
                trackersName.add('December - '+yearVal);
            }
        }
        else if(aggrPeriod == 'Half Yearly'){
            if(scorecardTrackername.startsWith('H1')){
                String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                trackersName.add('January - '+yearVal);
                trackersName.add('February - '+yearVal);
                trackersName.add('March - '+yearVal);
                trackersName.add('April - '+yearVal);
                trackersName.add('May - '+yearVal);
                trackersName.add('June - '+yearVal);
            }
            else{
                String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                trackersName.add('July - '+yearVal);
                trackersName.add('August - '+yearVal);
                trackersName.add('September - '+yearVal);
                trackersName.add('October - '+yearVal);
                trackersName.add('November - '+yearVal);
                trackersName.add('December - '+yearVal);
            }
        }
        else if(aggrPeriod == 'Monthly'){
            if(scorecardTrackername.startsWith('P - 01')){
                 String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                 trackersName.add('January - '+yearVal);
                 
            }
            else if(scorecardTrackername.startsWith('P - 02')){
                 String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                 trackersName.add('February - '+yearVal);
            }
            else if(scorecardTrackername.startsWith('P - 03')){
                 String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                 trackersName.add('March - '+yearVal);
            }
            else if(scorecardTrackername.startsWith('P - 04')){
                 String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                 trackersName.add('April - '+yearVal);
            }
            else if(scorecardTrackername.startsWith('P - 05')){
                 String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                 trackersName.add('May - '+yearVal);
            }
            else if(scorecardTrackername.startsWith('P - 06')){
                 String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                 trackersName.add('June - '+yearVal);
            }
            else if(scorecardTrackername.startsWith('P - 07')){
                 String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                 trackersName.add('July - '+yearVal);
            }
            else if(scorecardTrackername.startsWith('P - 08')){
                 String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                 trackersName.add('August - '+yearVal);
            }
            else if(scorecardTrackername.startsWith('P - 09')){
                 String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                 trackersName.add('September - '+yearVal);
            }
            else if(scorecardTrackername.startsWith('P - 10')){
                 String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                 trackersName.add('October - '+yearVal);
            }
            else if(scorecardTrackername.startsWith('P - 11')){
                 String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                 trackersName.add('November - '+yearVal);
            }
            else{
                 String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
                 trackersName.add('December - '+yearVal);
            }
        }
        else{
            String yearVal = scorecardTrackername.substring(scorecardTrackername.length()-4,scorecardTrackername.length());
            trackersName.add('January - '+yearVal);
            trackersName.add('February - '+yearVal);
            trackersName.add('March - '+yearVal);
            trackersName.add('April - '+yearVal);
            trackersName.add('May - '+yearVal);
            trackersName.add('June - '+yearVal);
            trackersName.add('July - '+yearVal);
            trackersName.add('August - '+yearVal);
            trackersName.add('September - '+yearVal);
            trackersName.add('October - '+yearVal);
            trackersName.add('November - '+yearVal);
            trackersName.add('December - '+yearVal);
        } 
        return trackersName;
    }
      /* For PickList */
       
   public List<SelectOption> options {get;set;}//for the picklist values
    public List<SelectOption> getValues()
    {
        options = new List<SelectOption>();
      //  options.add(new SelectOption('none','none'));
        options.add(new SelectOption('Approved','Approve'));
        options.add(new SelectOption('Rejected','Reject'));
     //   Schema.DescribeFieldResult fieldResult = SPE_ScoreCard__c.Stage__c.getDescribe();
      //  List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        return options;
    }  
    
   // public String comments{get;set;}
    public string selectedValue{get;set;}//for holding the selected value
    private List<SPE_ScoreCard__c> var;
    
    public PageReference saveChanges(){
       var =[select Stage__c,Comments__c,Approver__c,contact__c,contact__r.email from SPE_ScoreCard__c where id=:ApexPages.currentPage().getParameters().get('id')];
       system.debug('Approver----'+userinfo.getUserId());
       system.debug('User----'+var[0].Approver__c);
       if(var[0].Approver__c == userinfo.getUserId()){      
           if(var!=null && !var.isEmpty()){
               for(SPE_ScoreCard__c  sc :var){
                   sc.Comments__c = scorecard.comments__c;
                   sc.Stage__c = selectedValue;
                   update sc;
                   system.debug('Sc Value----'+sc);  
               }
            if(var[0].contact__c != null){   
                SPE_SendScorecard.SendScorecard(ApexPages.currentPage().getParameters().get('id'));
            }                  
          }           
       }
       else{
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Only Approver can change the status of Approval'));
           system.debug('Apex:Message----');  
           return null;
       }
       
    //   PageReference p = new PageReference('/apex/SPE2_Scorecard?id='+sid);
      // p.setRedirect(true);
     //  return p; 
     return null;
    }
    
    
/** New calculations **/    
public list<SPE_ScorecardValues__c> TemplateDisplay {get;set;}    
public scorecardviewNew[] scorecarddisplayNew{get;set;}    
   public void ScorecardCalculations(id Sid){
     selectedLang =Apexpages.currentPage().getParameters().get('Language');
         
    TemplateDisplay = new list<SPE_ScorecardValues__c>();
    TemplateDisplay =[select SPE_Template_Name__c,Score__c from SPE_ScorecardValues__c where ScoreCard__c=:Sid and KPI__c=Null and group__c=null];
    set<string> setOfname= new set<string>();
    for(SPE_ScorecardValues__c s : TemplateDisplay )
    setOfname.add(s.SPE_Template_Name__c);    
    
    scorecarddisplayNew= new list<scorecardviewNew>();   
    list<SPE_ScorecardValues__c> listofRecords= new list<SPE_ScorecardValues__c>();
    idOfKPI=new set<id>();
    KPISPE2LanList =new list<SPE2_Language_KPI__c>();
    for(string s:setOfname){
    
  //*************************************Changes For Encryption********************************//  
        listofRecords=[select id,SPE_Template_Name__c,Group__c,Score__c,KPI__c,KPI__r.AbbreviatedName__c,KPI__r.name,KPI__r.KPI_Title__c,kpi__r.group1__c,kpi__r.Confidential__c from SPE_ScorecardValues__c where ScoreCard__c=:Sid and (KPI__c!=Null OR group__c!=Null) and SPE_Template_Name__c=:s];
        system.debug('test line 94'+s);
        system.debug('test line 97'+listofRecords);
        for(SPE_ScorecardValues__c scoreValList:listofRecords){
            system.debug('Test Null value'+scoreValList);
            system.debug('Test Line 100'+scoreValList.KPI__c);    
            //*******************************************Changes For SPE2****************************************//
            idOfKPI.add(scoreValList.KPI__c);
            SYSTEM.DEBUG('+++TEST'+idOfKPI);
        }
        
           system.debug('Test Language'+selectedLang);
           //*******************************************Changes For SPE2****************************************//
           KPISPE2LanList=[select ID,Language__c,Language_Version__c,English_Version__c,KPI__c from SPE2_Language_KPI__c where KPI__c in: idOfKPI and Language__c =:selectedLang];
           system.debug('Line for condition '+KPISPE2LanList.size());
           if(KPISPE2LanList.size()!=0){
               ShowTrans=true;
               system.debug('Line no 114 '+ShowTrans);
               system.debug('Test Line 107::'+KPISPE2LanList);
               for(SPE2_Language_KPI__c speLang :KPISPE2LanList){
                    KPIlangMap.put(speLang.KPI__c,speLang.Language_Version__c);        
                }
          }
          system.debug('kpiTargetMap**'+dispKPITarget);
          scorecarddisplayNew.add(new scorecardviewNew(s,listofRecords,KPIlangMap,kpiAvgMap,kpiTargetMap,kpiWeightMap,pillarWeightMap));
      }
    }
    
    
  //*************************************END********************************//  
      

    public class scorenew{
        public String KPiAbbr1{get;set;}
        public String KPiname1{get;set;}
        public Decimal Score1{get;set;}
        public boolean Confidential1{get;set;}
        //*******************************************Changes For SPE2****************************************//
        public string selectedLanguage1{get;set;}
        public boolean tranValAvail1{get;set;}
        public decimal kpiVal1{get;set;}
        public String kpiTarget1{get;set;}
        public Decimal kpiWeight1{get;set;}
        public decimal pillarWt{get;set;}
        public scorenew(String KPiAbbr,String KPiname,Decimal Score,boolean Confidential,String selectedLanguage,boolean tranValAvail,String kpiVal,String kpiTarget,Decimal kpiWeight,decimal pillarWt){
         KPiAbbr1=KPiAbbr;
         kPiname1=KPiname;  
         score1=score;
         Confidential1=Confidential;
         //*******************************************Changes For SPE2****************************************//
         selectedLanguage1=selectedLanguage;
         tranValAvail1=tranValAvail;
         try{
             this.kpiVal1 =decimal.valueOf(kpiVal);
         }catch(exception e){
             this.kpiVal1 = null;
         }
         system.debug('kpiVal1 ::'+kpiVal1);
         this.kpiTarget1 =kpiTarget;        
         this.kpiWeight1 =kpiWeight;
         this.pillarWt = pillarWt;
        }
        
   }
    
    
    public class scorecardviewNew{
        public list<SPE_ScorecardValues__c > Quality{get;set;}
        public list<scorenew> Quality1 {get;set;}
        public list<SPE_ScorecardValues__c > Sustainability{get;set;}
        public list<scorenew> Sustainability1 {get;set;}

        public list<SPE_ScorecardValues__c > Relationship{get;set;}
        public list<scorenew> Relationship1{get;set;}
        public list<SPE_ScorecardValues__c > Cost{get;set;}
        public list<scorenew> Cost1{get;set;}
        public list<SPE_ScorecardValues__c > Delivery{get;set;}
        public list<scorenew> Delivery1{get;set;}
        public list<SPE_ScorecardValues__c > Innovation {get;set;}
        public list<scorenew> Innovation1{get;set;}
        public String QualityScore{get;set;}
        public String SustainabilityScore{get;set;}
        public String CostScore{get;set;}
        public String RelationScore{get;set;}
        public String DeliveryScore{get;set;}
        Public string TemplateName{get;set;}
        Public string InnovationScore{get;set;}
        public Set<Id> KPIIDSet{get;set;}
        public Decimal templateScore{get;set;}
        public String KPINameDisplay='';    
        public AggregateResult[]  Deliveryresults{get;set;}
        public Map<Id,String> KPIlangMap{get;set;}
        public Map<String,String> kpiAvgMap{get;set;}
        public Map<String,String> kpiTargetMap{get;set;}
        public Map<String,Decimal> kpiWeightMap{get;set;}
        public Map<String,Decimal> pillarWeightMap{get;set;}
        public Decimal QualityPillar{get;set;}
        public Decimal SustainabilityPillar{get;set;}
        public Decimal DeliveryPillar{get;set;}
        public Decimal CostPillar{get;set;}
        public Decimal RelationshipPillar{get;set;}
        public Decimal InnovationPillar{get;set;}
        
        public scorecardviewNew(String s,list<SPE_ScorecardValues__c> ScoreValues,Map<Id,String> KPIlangMap,
                                Map<String,String> kpiAvgMap,Map<String,String> kpiTargetMap,Map<String,Decimal> kpiWeightMap,
                                Map<String,Decimal> pillarWeightMap){
         TemplateName=s;
         Quality1= new list<scorenew>();
         Sustainability1= new list<scorenew>();
        Relationship1= new list<scorenew>();
         Cost1= new list<scorenew>();
         Delivery1= new list<scorenew>();
         Innovation1= new list<scorenew>();
         Delivery= new list<SPE_ScorecardValues__c >();
         Cost=new list<SPE_ScorecardValues__c >();
         Quality=new list<SPE_ScorecardValues__c >();
         Sustainability=new list<SPE_ScorecardValues__c >();
         Relationship=new list<SPE_ScorecardValues__c >();
         Innovation=new list<SPE_ScorecardValues__c >(); 
         this.KPIlangMap = KPIlangMap;
         this.kpiAvgMap = kpiAvgMap;
         this.kpiTargetMap =kpiTargetMap;
         this.kpiWeightMap =kpiWeightMap;
         this.pillarWeightMap =pillarWeightMap;
        //Quality, Delivery, Commercial, Innovation and Relationship
        
        for(SPE_ScorecardValues__c v:ScoreValues){
            
            if(v.Kpi__r.group1__c=='Delivery'){
                Delivery.add(v);
                if(KPIlangMap.get(v.KPI__c)!=null && KPIlangMap.get(v.KPI__c)!= ''){
                 Delivery1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),true,kpiAvgMap.get(v.KPI__c),kpiTargetMap.get(v.KPI__c),kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));
                 
                }
                else{
                    Delivery1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),false,kpiAvgMap.get(v.KPI__c),kpiTargetMap.get(v.KPI__c),kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));
                }
                DeliveryPillar = pillarWeightMap.get(v.Kpi__r.group1__c);
                //,v.kpi__r.Language_Version__c
            }
            if(v.Kpi__r.group1__c=='Commercial'){
                cost.add(v);
                if(KPIlangMap.get(v.KPI__c)!=null && KPIlangMap.get(v.KPI__c)!= '')
                {
                    cost1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),true,kpiAvgMap.get(v.KPI__c),kpiTargetMap.get(v.KPI__c),kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));
                }
                else{
                    cost1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),false,kpiAvgMap.get(v.KPI__c),kpiTargetMap.get(v.KPI__c),kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));
                }
                CostPillar = pillarWeightMap.get(v.Kpi__r.group1__c);
            }
            if(v.Kpi__r.group1__c=='Quality'){
                Quality.add(v);
                if(KPIlangMap.get(v.KPI__c)!=null && KPIlangMap.get(v.KPI__c)!= '')
                {
                    Quality1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),true,kpiAvgMap.get(v.KPI__c),kpiTargetMap.get(v.KPI__c),kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));                                       
                }
                else{
                    Quality1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),false,kpiAvgMap.get(v.KPI__c),kpiTargetMap.get(v.KPI__c),kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));                    
                }
                QualityPillar = pillarWeightMap.get(v.Kpi__r.group1__c);
            }

                if(v.Kpi__r.group1__c=='Sustainability'){
                Sustainability.add(v);
                if(KPIlangMap.get(v.KPI__c)!=null && KPIlangMap.get(v.KPI__c)!= '')
                {
                   Sustainability1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),true,kpiAvgMap.get(v.KPI__c),kpiTargetMap.get(v.KPI__c),kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));                                       
                }
                else{
                    Sustainability1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),false,kpiAvgMap.get(v.KPI__c),kpiTargetMap.get(v.KPI__c),kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));                    
                }
               SustainabilityPillar = pillarWeightMap.get(v.Kpi__r.group1__c);
            }
            if(v.Kpi__r.group1__c=='Relationship'){
                Relationship.add(v); 
                if(KPIlangMap.get(v.KPI__c)!=null && KPIlangMap.get(v.KPI__c)!= ''){
                    Relationship1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),true,kpiAvgMap.get(v.KPI__c),kpiTargetMap.get(v.KPI__c),kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));
                }
                else{
                    Relationship1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),false,kpiAvgMap.get(v.KPI__c),kpiTargetMap.get(v.KPI__c),kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c)));
                }
                RelationshipPillar = pillarWeightMap.get(v.Kpi__r.group1__c);
            }
            if(v.Kpi__r.group1__c=='Innovation'){
                Innovation.add(v);
                if(KPIlangMap.get(v.KPI__c)!=null && KPIlangMap.get(v.KPI__c)!= ''){
                    Innovation1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),true,kpiAvgMap.get(v.KPI__c),kpiTargetMap.get(v.KPI__c),kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c))); 
                    }
                  else{
                      Innovation1.add(new scorenew(v.KPI__r.AbbreviatedName__c,v.KPI__r.KPI_Title__c,v.score__c,v.kpi__r.Confidential__c,KPIlangMap.get(v.KPI__c),false,kpiAvgMap.get(v.KPI__c),kpiTargetMap.get(v.KPI__c),kpiWeightMap.get(v.KPI__c),pillarWeightMap.get(v.Kpi__r.group1__c))); 
                  }
                  InnovationPillar = pillarWeightMap.get(v.Kpi__r.group1__c);                 
            }               
            
            if(v.group__c!='' && v.group__c=='Quality')
                QualityScore=(string.valueof(v.score__c)).substring(0,4);
            if(v.group__c!='' && v.group__c=='Sustainability')
                SustainabilityScore=(string.valueof(v.score__c)).substring(0,4);
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
        if(inputLanguage == 'None'){
        PageReference pdf = new PageReference('/apex/SPE2_Scorecardpdf?id='+sid);
        pdf.setRedirect(true);
        return pdf;
        }
        else{
        PageReference pdf = new PageReference('/apex/SPE2_Scorecardpdf?id='+sid+'&Language='+inputLanguage);
        pdf.setRedirect(true);
        return pdf;
        
        }
    }
    
    //*************method added for language****
    
       public List<SelectOption> getLanguageValues(){
    
        List<SelectOption> options = new List<SelectOption>();
        languages =SPE2_LanguageList__c.getall().values();
        languages.sort();
        options.add(new SelectOption('None','None'));
        for(SPE2_LanguageList__c lang : languages ){
            options.add(new SelectOption(lang.Name,lang.Language__c));    
        }  
        
        return options;
      
      }  
     
     public PageReference refreshLanguage(){
     system.debug('input language is'+inputLanguage);
         if(inputLanguage!='None'){
           PageReference p = new PageReference('/apex/SPE2_Scorecard?id='+sid+'&Language='+inputLanguage);
           p.setRedirect(true);
            return p;
     }
         else{
         PageReference p = new PageReference('/apex/SPE2_Scorecard?id='+sid);
           p.setRedirect(true);
            return p;
         
         }
     }
}