public class SPE2_AdhocScorecardPageEXTNew{
    public string accountId{get;set;}
    public string accountName{get;set;}
    public SPE_ScorecardSPETemplateMap__c tempMap {get;set;}
    public SPE_ScorecardTemplate__c scorecardTemp {get;set;}
    public SPE_SPEPlan__c spePlanforDate {get;set;}
    public SPE_ScorecardGenerator__c scoreCardgenerator {get;set;}
    public List<SPE_SPEPlan__c> lstPlanAll {get;set;}
    public List<SPE_SPEPlan__c> lstPlan {get;set;}
    public List<wrapperPlan> wrapperPlanList {get;set;}
    public List<wrapperPlan> subwrapperList {get;set;}
    public List<wrapperPlan> subwrapperList3 {get;set;}
    public List<SPE_ScorecardSupplierMap__c> subwrapperSupplier {get;set;}
  //  public List<wrapperSupplier> lstSuppWrapper;sho
    public List<wrapperPlan> containerList {get;set;}
    public List<wrapperPlan> scopePlanwraperList {get;set;}
    public List<SPE_ScorecardSupplierMap__c> scorecardSupplierList;
    public List<SPE_SPETracker__c> lstTempPlanID; 
    public String SPEPlanName {get;set;}
    public Boolean showattb {get;set;}
    public String Stage {get;set;}
    public Boolean displayScorecardGenpage {get;set;}
    public boolean displaypopup{get;set;}
    public Date kpiday{get;set;}
    public String displaydate{get;set;}
    //Public boolean DisplayAccount{get;set;}
    public string marketVal{get;set;}
    public string marketUnitVal{get;set;}
    public string countryVal{get;set;} 
    public string projectVal{get;set;}
    public string buVal {get;set;}
    public string blVal{get;set;}
    public string prdVal{get;set;}
    public string caVal{get;set;}
    public string cgVal{get;set;}
    public string ctVal{get;set;}
    public String supplier {get;set;}
    public date startDate {get;set;}
    public date endDate {get;set;}
    public string name{get;set;}
    public string vintage{get;set;}
    public string organization{get;set;}
    public string active{get;set;}
    public Boolean applyValidation {get; set;}
    public String speTemplateName {get;set;}
    //----------------------------
    public integer DEFAULT_PAGE_SIZE{get;set;}
    public integer pageNumber{get;set;}
    public integer maxPages{get;set;}
    public integer startRecNo {get;set;}
    public integer endRecNo {get;set;}
    public boolean hasRecords{get;set;}
    public boolean shownext{get;set;}
    public boolean showprevoius{get;set;}
    public boolean showfirst{get;set;}
    public boolean showlast{get;set;}
    //---------------------------------
    public integer pageNumber2{get;set;}
    public integer maxPages2{get;set;}
    public integer startRecNo2 {get;set;}
    public integer endRecNo2 {get;set;}
    public boolean shownext2{get;set;}
    public boolean showprevoius2{get;set;}
    public boolean showfirst2{get;set;}
    public boolean showlast2{get;set;}
    //-------------------
    public integer pageNumber3{get;set;}
    public integer maxPages3{get;set;}
    public integer startRecNo3 {get;set;}
    public integer endRecNo3 {get;set;}
    public boolean shownext3{get;set;}
    public boolean showprevoius3{get;set;}
    public boolean showfirst3{get;set;}
    public boolean showlast3{get;set;}
    public Boolean hasRecordsSG {get;set;}
    //----------------------
    private Set<String> chkDuplicates;
    private Set<ID> setPlanId;
    private Set<ID> setPlanFilterId;
    private boolean showError {get;set;}
    //--------First Page Variables-----------
    
    public string geoScope{get;set;}
    public string catScope{get;set;}
    public string prodScope{get;set;}
    public boolean showScope{get;set;}
    public boolean showOnLoad {get;set;}
    public List<SPE_SPEPlan__c> lstScopePlans {get;set;}
    public String StrSet;
    public List<wrapperPlan> subwrapperList2 {get;set;}
    List<SPE_Scorecard_Plan__c> scoreCardPlans;
    public boolean showFilter {get;set;}
    public SPE_SPEPlanSupplierMap__c supp {get;set;}
    //-----------Supplier Section------------
    
    public Boolean hasRecordsSupplier {get;set;}
    public integer pageNumber4{get;set;}
    public integer maxPages4{get;set;}
    public integer startRecNo4 {get;set;}
    public integer endRecNo4{get;set;}
    public boolean shownext4{get;set;}
    public boolean showprevoius4{get;set;}
    public boolean showfirst4{get;set;}
    public boolean showlast4{get;set;}
    //-------saving scorecard generator----
    
    public List<SPE_ScorecardSPETemplateMap__c> lstSCTemplateMap;
    public SPE_ScorecardTemplate__c scTemplate;
    public String proceedNext {get;set;}
    public Integer startDateYear {get;set;}
    public Integer startDateMonth {get;set;}
    public Integer EndDateYear {get;set;}
    public Integer EndDateMonth {get;set;}
    public String scorecardName {get;set;}
    
    ///////////////////////New Variables///////////////////////////////////
        public boolean isShowScopePanel{get;set;}
        public boolean isSecondPage{get;set;}
        public boolean isThirdPage{get;set;}
        public String isShowPlansThirdPg{get;set;}
        public SPE2_CC_Contact_Details__c objCCDetails{get;set;}
        public String strContactName{get;set;}
        public List<Contact> lstContact{get;set;}
        Map<Id,List<Contact>> mapSuppIdContactList = new map<Id,List<Contact>>();
     //   public List<contactWrapper> lstWrapperContact{get;set;}
        public Id supplierId{get;set;}
        public Integer clickFilter;
        public Boolean showmsg ;
        public String suppSize {get;set;}
        public String uidentify {get;set;}
        public string bu {get;set;}
    /////////////////////////////////////////////////////////////
    
    //------------End of Variables----------
    public SPE2_AdhocScorecardPageEXTNew(Apexpages.Standardcontroller st)
    {  
        active = 'true';
        uidentify = system.Now()+userInfo.getUserId();
        objCCDetails = new SPE2_CC_Contact_Details__c();
        subwrapperList = new list<wrapperPlan>();
        subwrapperList2 = new list<wrapperPlan>();
        subwrapperList3 = new list<wrapperPlan>();
        subwrapperSupplier = new List<SPE_ScorecardSupplierMap__c>(); 
      //  lstSuppWrapper = new List<wrapperSupplier>(); 
        lstPlan = new List<SPE_SPEPlan__c>();
       // wrapperPlanList  = new List<wrapperPlan>();
        lstPlanAll = new List<SPE_SPEPlan__c>();
        containerList  = new List<wrapperPlan>();
        chkDuplicates = new Set<String>();
        lstTempPlanID = new List<SPE_SPETracker__c>();
        setPlanId = new Set<ID>();
        spePlanforDate = new SPE_SPEPlan__c();
        showmsg = false;
        DEFAULT_PAGE_SIZE = 10;
        pageNumber = 1;
        startRecNo=0;
        endRecNo=0;
        shownext=false;
        showprevoius=false;
        showfirst=false;
        showlast=false;
        pageNumber2 = 1;
        startRecNo2=0;
        endRecNo2=0;
        shownext2=false;
        showprevoius2=false;
        showfirst2=false;
        showlast2=false;
        //DisplayAccount=True;
        showScope = false;
        showOnLoad = false;
        showFilter = true;
        applyValidation = true;
        displayScorecardGenpage = false;
        hasRecordsSG = true;
         proceedNext = 'true';
         clickFilter = 0;
         endDateYear = system.today().addYears(2).year();
        system.debug('container list is in constructor---'+containerlist);
        
        ////////////////////////////////////////////////////////////////////////////////////////
        isShowScopePanel = true;
        isSecondPage = false;
        isThirdPage = false;
        isShowPlansThirdPg = 'false';
        displaypopup = false;
    }
    
    public void showPlans(){
       Map<String,String> mapPlanApiValue = new Map<String,String>();
        
       wrapperPlanList = new List<wrapperPlan>();
       showOnLoad = true;
       isSecondPage = true;
       isThirdPage = false;
       hasrecords = false; 
       showScope = false;
       showFilter = false;
       clickFilter = 1;
        //******add plan to container on apply filter*************
        if(applyValidation == true){
             for(wrapperPlan w :scopeplanwraperList ){
                    if(w.selected){
                        containerList.add(w);
                    }
                
                }
            }
  
        else{
            
            for(wrapperPlan w :scopeplanwraperList ){
                    if(w.selected){
                        containerList.add(w);
                    }
            }
        
      }  
      
      //************************
       system.debug('final list1'+containerList);
       
       system.debug('scopewrapper list'+scopePlanwraperList.size());
       system.debug('stage is **'+stage);
       Map<String,String> mapTemplateIdStore = new Map<String,String>();
       for(wrapperplan w : scopeplanwraperList ){
           mapTemplateIdStore.put(w.speplan.SPETemplate__c,w.speplan.SPETemplate__r.Name);
       
       }
       
       if(scopePlanwraperList.size()>0){      
           if((Name=='' || Name==null) && (SPEPlanName=='' || SPEPlanName==null) && (organization=='' || organization==null) 
           && (marketVal=='' || marketVal==null) && (marketUnitVal=='' || marketUnitVal==null) && (countryVal=='' || countryVal==null) 
           && (projectVal=='' || projectVal==null) && (caVal=='' || caVal==null) && (cgVal=='' || cgVal==null) && (ctVal=='' || ctVal==null)
           && (buVal =='' || buVal==null) && (blVal=='' || blVal==null) && (prdVal=='' || prdVal==null) && (vintage=='' || vintage==null)
           && (active=='' || active ==null) && (speTemplateName =='' || speTemplateName == null) && stage == 'All'){
               wrapperPlanList.addAll(scopePlanwraperList);          
               system.debug('Adding all records');
           }
         }  
       if(Name!='' && Name!=null)
       {
           mapPlanApiValue.put('Name',Name);
       }
       
       if(SPEPlanName!='' && SPEPlanName!=null){
           mapPlanApiValue.put('SPEPlanName__c',SPEPlanName);
        }
        
        if(organization!='' && organization!=null){
            if(organization.contains('*')){
            organization = organization.replaceAll('[*]','');
            
            }
           mapPlanApiValue.put('Organization_Group__c',organization);
        }
        
        if(marketVal!='' && marketVal!=null){
           mapPlanApiValue.put('Region__c',marketVal);
        }
        
        if(marketUnitVal!='' && marketUnitVal!=null){
           mapPlanApiValue.put('SubRegion__c',marketUnitVal);
        }
        
        
        if(countryVal!='' && countryVal!=null){
           mapPlanApiValue.put('Country__c',countryVal);
        }
        
        if(projectVal!='' && projectVal!=null){
           mapPlanApiValue.put('Project__c',projectVal);
        }
        
        
        if(caVal!='' && caVal!=null){
           mapPlanApiValue.put('CategoryCluster__c',caVal);
        }
        
        
        if(cgVal!='' && cgVal!=null){
           mapPlanApiValue.put('CategoryGroup__c',cgVal);
        }
        
        
        if(ctVal!='' && ctVal!=null){
           mapPlanApiValue.put('Category__c',ctVal);
        }
        
        if(buVal!='' && buVal!=null){
           mapPlanApiValue.put('BusinessUnit__c',buVal);
        }
        
        
        if(blVal!='' && blVal!=null){
           mapPlanApiValue.put('BusinessLine__c',blVal);
        }
        
        
        if(prdVal!='' && prdVal!=null){
           mapPlanApiValue.put('Product__c',prdVal);
        }
        
        if(vintage!='' && vintage!=null){
           mapPlanApiValue.put('Vintage__c',vintage);
        }
        
        if(active!='' && active!=null){
           mapPlanApiValue.put('Active__c',active);
        }
        
        if(stage!='All'){
            mapPlanApiValue.put('Stage__c',Stage);
        }
  
        if(speTemplateName!='' && speTemplateName!=null){
            mapPlanApiValue.put('SPETemplate__c',speTemplateName);
        }
        
        
        system.debug('stage val is--'+stage);
        
        system.debug('map val---'+mapPlanApiValue);
         
        for(wrapperPlan w : scopePlanwraperList) {
            Boolean isMatch = false;
            Boolean isMatch1 = false;
            for(String s : mapPlanApiValue.keySet()){
            system.debug('plan val is--'+w.spePlan.get(s));
            system.debug('maplanapival---'+mapPlanApiValue.get(s));
            system.debug('val1---'+mapTemplateIdStore.get(w.spePlan.get(s)+''));
            //system.debug('track excep'+mapTemplateIdStore.get(w.spePlan.get(s)+'').contains(mapPlanApiValue.get(s)));
             if(mapTemplateIdStore.get(w.spePlan.get(s)+'')!=null){
                if(mapTemplateIdStore.get(w.spePlan.get(s)+'').contains(mapPlanApiValue.get(s))){
                    isMatch1 = true;
                    break;
                    system.debug('plan val4ee is--'+w.spePlan.get(s));
                
                }
            
                else{
                    isMatch1 = false;
                   
                } 
            system.debug('match template'+ismatch);
            }
            if((String.valueOf(w.spePlan.get(s))!=null)){
            if((String.valueOf(w.spePlan.get(s)).toLowerCase().contains(mapPlanApiValue.get(s).toLowerCase())) || (s == 'Active__c' && (w.spePlan.get(s) == Boolean.valueOf(mapPlanApiValue.get(s))))){
                isMatch = true;
               
                system.debug('plan val3ee is--'+w.spePlan.get(s));
                
            }
            
           else{
               isMatch = false;
                break;
           
           }
            system.debug('match others--'+ismatch);
           }
           
            system.debug('match val'+isMatch);
           } 
          
           if(isMatch == true || isMatch1 == true){
           
           system.debug('ismatch nd ismatch1'+ismatch+''+ismatch1);
           system.debug('value of w'+w);
           wrapperPlanList.add(w);
          }
        }
       
        system.debug('size of wrapperplanlist----'+wrapperPlanList.size());
        if(wrapperPlanList.size()>0){
            hasrecords = true;
            system.debug('FinalPlan----'+wrapperPlanList);
            system.debug('size of wrapper'+wrapperPlanList.size());
            //-------------------------------------------------------
            for(wrapperplan w : wrapperPlanList){
                w.isDuplicate = false;
                w.duplicatePlan = '';
            }
            
           if(applyValidation == true){
            List<wrapperPlan> tempWrapperList = new List<wrapperPlan>();
           tempWrapperList.addAll(wrapperPlanList);   
           for(wrapperplan temp : tempWrapperList){
               for(wrapperPlan w : wrapperPlanList){
                   if((w.planConcat == temp.planConcat) && (w.spePlan.Name!= temp.spePlan.Name)){
                      w.isDuplicate = true;
                      if(w.duplicatePlan=='' || w.duplicatePlan == null)
                      w.duplicatePlan = temp.spePlan.Name;
                   }   
                   
                   if(w.duplicatePlan=='' || w.duplicatePlan == null){
                   w.isDuplicate = false;
                   }
     
               }
           }  
         }  
           //---------------------------------
            
            
       pagination(wrapperPlanList);
       system.debug('has records'+hasrecords);
            
            //***********Adding to conatiner list after filtering***********
            
     /**       
        if(applyValidation == true){
            if(showScope == false){
                for(wrapperPlan w :wrapperPlanList){
                    if(w.selected && w.isDuplicate ==false){
                        containerList.add(w);
                    }
                
                }
            }
            
        }
        
        else{
            if(showScope == false){
            for(wrapperPlan w :wrapperPlanList){
                    if(w.selected){
                        containerList.add(w);
                    }
                }
            }
          }  
          
          **/
        }
    
    }
    
    public void nextFunction(){
    system.debug('inside next method');
        List<wrapperPlan> tempList3 = new List<wrapperPlan>();
        for(wrapperPLan w1 : scopeplanwraperList ){
                    if(w1.selected){
                    tempList3.add(w1);
                    }
                }
                
        system.debug('test test ' +tempList3);
    Set<wrapperPlan> setUniquePlans ;
        isShowScopePanel = false;
        isSecondPage = false;
        
        showOnLoad = true;
        scoreCardgenerator = new SPE_ScorecardGenerator__c();
        scoreCardgenerator.Additional_Days__c = 1;
        scoreCardgenerator.Aggregation_Period_Adhoc__c = 'Monthly';
        scoreCardgenerator.AggregationType__c = 'Simple Average';
        system.debug('validan is--'+applyValidation);
        system.debug('scope is----'+showScope);
        proceedNext = 'true';
        if(applyValidation == true){
        
            if(showScope == true){
                setUniquePlans = new Set<wrapperPlan>();
                List<wrapperPlan> tempList1 = new List<wrapperPlan>();
                List<wrapperPlan> tempList2 = new List<wrapperPlan>();
                for(wrapperPLan w : scopeplanwraperList ){
                    if(w.selected){
                    tempList1.add(w);
                    tempList2.add(w);
                    }
                }
                for(wrapperplan temp : tempList1){
                    for(wrapperPlan w : tempList2){
                        if(w.selected && w.planConcat == temp.planConcat && w.spePlan.Name!= temp.spePlan.Name)
                           {
                            proceedNext = 'false';
                            isThirdPage = false;
                            isSecondPage = true;
                            break;
                            }
                   
                    } 
                    
                     if(proceedNext == 'true'){
                        // setUniquePlans.add(temp);
                       containerList.add(temp);
              
                        } 
                          
                  }
                /**  List<wrapperPlan> tempListSet = new List<wrapperPLan>();
                  tempLIstSet.addAll(setUniquePlans);
                  for(wrapperPlan w : tempListSet ){
                      for(wrapperPlan setw : setUniquePlans){
                          if(w.planconcat != setw.planconcat)
                          containerList.add(w);
                      
                      }
                  
                  }
                  **/
                  system.debug('proceed to next----'+proceedNext);
                  
              }  
              
              else{
                  setUniquePlans = new Set<wrapperPlan>();
                  List<wrapperPlan> tempList1 = new List<wrapperPlan>();
                  List<wrapperPlan> tempList2 = new List<wrapperPlan>();
                  for(wrapperPLan w : wrapperPlanList){
                    if(w.selected){
                    tempList1.add(w);
                    tempList2.add(w);
                    }
                }
                for(wrapperplan temp : tempList1){
                    for(wrapperPlan w : tempList2){
                        if(w.selected && w.planConcat == temp.planConcat && w.spePlan.Name!= temp.spePlan.Name)
                           {
                            proceedNext = 'false';
                            isThirdPage = false;
                            isSecondPage = true;
                            break;
                            }
                       
                    } 
                    if(proceedNext == 'true'){
                       containerList.add(temp); 
                        //setUniquePlans.add(temp);
                        
                        }
          
                  }
                  
                 /**  List<wrapperPlan> tempListSet = new List<wrapperPLan>();
                  tempLIstSet.addAll(setUniquePlans);
                  for(wrapperPlan w : tempListSet ){
                      for(wrapperPlan setw : setUniquePlans){
                          if(w.planconcat != setw.planconcat)
                          containerList.add(w);
                      
                      }
                  
                  }
                  
                  **/
                system.debug('proceed to next----'+proceedNext);  
              }
            
        }
        
        else{
            system.debug('showscope in else'+showscope);
            Set<wrapperPlan> setUniquePlan = new Set<wrapperPlan>();
            if(showScope == true){
            for(wrapperPlan w :scopeplanwraperList ){
                    if(w.selected){
                      
                      containerList.add(w);
                      
                    }
            }
          }
          else{
              for(wrapperPlan w :wrapperPlanList){
                    if(w.selected){
                       
                      containerList.add(w);
                      
                    }
            }
 
          }
 
      }  
      
      if(containerList.isEmpty()){
         //proceedNext = 'false';
         isThirdPage = false;
         isSecondPage = true;
         ApexPages.Message myMsg = new ApexPages.message(ApexPages.severity.ERROR,'Please Select Unique Plans to continue to next page');
         ApexPages.addMessage(myMsg); 
            
        }    
      system.debug('containe r list in next is****'+containerList);
        if(applyValidation == true){
       if(containerList.size()>0){
       List<wrapperPlan> tempList = new List<wrapperPlan>();
       templist.addAll(containerlist);
       for(wrapperplan temp : templist){
           for(wrapperplan w : containerList){
               if(w.planConcat == temp.planConcat && w.spePlan.Name!= temp.spePlan.Name){
                   proceedNext = 'false';
                   isThirdPage = false;
                   isSecondpage = true;
                   break;
               
                 }
                 
                 else
                 proceedNext = 'true';
               }
           }
           system.debug('proceed next val is--'+proceedNext );
           system.debug('proceed next val is222'+isThirdPage);
           if(proceedNext == 'true'){
           displayScorecardGenpage = true;
           proceedNext = 'true';
            hasRecords = true;
            isThirdPage = true;
           system.debug('proceed next val is'+proceedNext );
           
           pagination3();
           getPlanSupplier();
           
           }
           else{
           isThirdPage = false;
            ApexPages.Message myMsg = new ApexPages.message(ApexPages.severity.ERROR,'Please Select Unique Plans to continue to next page');
         ApexPages.addMessage(myMsg); 
           }
           
       }
      
       
       }
       
       else{
          if(containerList.size()>0){
           displayScorecardGenpage = true;
           proceedNext = 'true';
            hasRecords = true;
            isThirdPage = true;
           system.debug('proceed next val is'+proceedNext );
            Set<wrapperPlan> planSet = new Set<wrapperPlan>();
           for(wrapperplan w : containerList){
               planSet.add(w);    
           
           }
           
           containerList.clear();
           containerList.addAll(planSet);
           pagination3();
           getPlanSupplier();
       }

       
       }  
       if(containerList.size()>0){
         List<SPE2_PlanHolder__c> planholddel = new List<SPE2_PlanHolder__c>();
         List<SPE2_PlanHolder__c> planholdinsert = new List<SPE2_PlanHolder__c>();
         planholddel = [Select SPE_Plan__c,UID__c from SPE2_PlanHolder__c where UID__c = :uidentify];
         if(planholddel.size()>0){
             delete planholddel;
         }
         for(wrapperPlan w : containerList){
             SPE2_PlanHolder__c ph= new SPE2_PlanHolder__c();
             ph.SPE_Plan__c = w.spePlan.ID;
             ph.UID__c = uidentify;
             planholdinsert.add(ph);
         }
          insert  planholdinsert;
       }
    }
    
    //*********Method added for searching Plans based on Scope****************
    
    public void showScopePlans(){
        isShowScopePanel = false;
        isSecondPage = true;
        lstScopePlans = new List<SPE_SPEPlan__c>();
        boolean validSet = false;
        
        showFilter = true;
        showOnLoad = true;
        scopePlanwraperList = new List<wrapperPlan>();
        
        if(spePlanforDate.StartDate__c!=null){
           Integer monthvalstart = spePlanforDate.StartDate__c.month();
           system.debug('monthval --'+monthvalstart );   
           Integer yearValstart =  spePlanforDate.StartDate__c.year();
           startdate = date.newInstance(yearValstart,monthvalstart,1);
           startdate = date.valueOf(startdate.addMonths(1));
           system.debug('start date'+startdate);
            system.debug('start date'+startdate);
          }
          
          if(spePlanforDate.EndDate__c!=null) {
           integer monthvalend = spePlanforDate.EndDate__c.month();
           system.debug('monthval --'+monthvalend );   
           Integer yearValend =  spePlanforDate.EndDate__c.year();
           enddate = date.newInstance(yearValend,monthvalend,1);
           enddate = date.valueOf(enddate.addMonths(1));
           
           }
                   
                    
         StrSet = '(';  
                   
        //lstTempPlanID = [Select SPEPlan__c,DateOfExecution__c from SPE_SPETracker__c where status__c='Completed' and DateOfExecution__c>=:startdate and DateOfExecution__c<=:endDate and ID in (Select SPETracker__c from SPE_TrackerScore__c where SPEScore__c=true and Score__c>0)];
        lstTempPlanID = [Select SPEPlan__c,DateOfExecution__c from SPE_SPETracker__c where status__c='Completed' and DateOfExecution__c>=:startdate and DateOfExecution__c<=:endDate and ID in (Select SPETracker__c from SPE_TrackerScore__c where SPEScore__c=true )];
        system.debug('lst of plans'+lstTempPlanID);
        for(SPE_SPETracker__c tracker:lstTempPlanID ){
            setPlanId.add(tracker.SPEPlan__c);
        }
        for(Id tracker : setPlanId){
            
            if(StrSet == '(') {
            StrSet += '\''+ tracker + '\'';
              }
            else {
            StrSet += ',\''+ tracker + '\'';
            }
        }
        StrSet += ')';
        
        system.debug('set of Id'+setPlanId);
        system.debug('set str is'+StrSet);
        if(setPlanID.size()>0){
            validSet = true;
        }
        else
        {
            validSet = false;
        }    
        
        
        String query = 'Select id,Name,Region__c,SubRegion__c,Country__c,Project__c,SPEPlanName__c,CategoryCluster__c,SPEId__c,' +
                        ' CategoryGroup__c,Category__c,BusinessUnit__c,BusinessLine__c,Stage__c,Product__c,StartDate__c, '+
                        ' EndDate__c,Vintage__c,  Active__c,Organization_Group__c,SPETemplate__r.name,'+
                        ' SPEScoringTemplate__r.name,Owner.Name  from SPE_SPEPlan__c where id in '+StrSet;
        system.debug('geoscope vals---'+catScope);                
        if(catScope == 'All Categories'){
            query +=' AND '+'CategoryCluster__c=\'All Category Areas\'' + ' AND '+'CategoryGroup__c=\'All Category Groups\''+' AND '+'Category__c=\'All Categories\''; 
        
        }
        
        if(catScope == 'Category Area'){
            query +=' AND '+'CategoryCluster__c!=\'All Category Areas\'' + ' AND '+'CategoryGroup__c=\'All Category Groups\''+' AND '+'Category__c=\'All Categories\''; 
        
        }
        
        if(catScope == 'Category Group'){
            query +=' AND '+'CategoryCluster__c!=\'All Category Areas\'' + ' AND '+'CategoryGroup__c!=\'All Category Groups\''+' AND '+'Category__c=\'All Categories\''; 
        
        }
        
        if(catScope == 'Category'){
            query +=' AND '+'CategoryCluster__c!=\'All Category Areas\'' + ' AND '+'CategoryGroup__c!=\'All Category Groups\''+' AND '+'Category__c!=\'All Categories\''; 
        
        }
        
        if(geoScope == 'All Markets'){
            query +=' AND '+'Region__c=\'All Markets\'' + ' AND '+'SubRegion__c=\'All Market Units\''+' AND '+'Country__c=\'All Countries\'' + ' AND '+'Project__c=\'All Projects\' '; 
        
        }
        if(geoScope == 'Market'){
            query +=' AND '+'Region__c!=\'All Markets\'' + ' AND '+'SubRegion__c=\'All Market Units\''+' AND '+'Country__c=\'All Countries\'' + ' AND '+'Project__c=\'All Projects\' '; 
        
        }
        
        if(geoScope == 'Market Unit'){
            query +=' AND '+'Region__c!=\'All Markets\'' + ' AND '+'SubRegion__c!=\'All Market Units\''+' AND '+'Country__c=\'All Countries\'' + ' AND '+'Project__c=\'All Projects\' '; 
        
        }
        
        if(geoScope == 'Country'){
            query +=' AND '+'Region__c!=\'All Markets\'' + ' AND '+'SubRegion__c!=\'All Market Units\''+' AND '+'Country__c!=\'All Countries\'' + ' AND '+'Project__c=\'All Projects\' '; 
        
        }
        
        if(geoScope == 'Project'){
            query +=' AND '+'Region__c!=\'All Markets\'' + ' AND '+'SubRegion__c!=\'All Market Units\''+' AND '+'Country__c!=\'All Countries\'' + ' AND '+'Project__c!=\'All Projects\' '; 
        
        }
                
        if(prodScope == 'All Products'){
            query +=' AND '+'BusinessUnit__c=\'All Business Units\'' + ' AND '+'BusinessLine__c=\'All Business Lines\''+' AND '+'Product__c=\'All Products\''; 
        
        }
        if(prodScope == 'Business Unit'){
            query +=' AND '+'BusinessUnit__c !=\'All Business Units\'' + ' AND '+'BusinessLine__c =\'All Business Lines\''+' AND '+'Product__c =\'All Products\''; 
        
        }       
        
        if(prodScope == 'Business Line'){
            query +=' AND '+'BusinessUnit__c !=\'All Business Units\'' + ' AND '+'BusinessLine__c !=\'All Business Lines\''+' AND '+'Product__c =\'All Products\''; 
        
        }  
        
        if(prodScope == 'Product'){
            query +=' AND '+'BusinessUnit__c !=\'All Business Units\'' + ' AND '+'BusinessLine__c !=\'All Business Lines\''+' AND '+'Product__c !=\'All Products\''; 
        
        }   
        
        query +=' AND '+'Stage__c!=\'Draft\'';
        
        query +=' Order BY Name';
        system.debug('scope query ++'+query);
        if(validSet)
        lstScopePlans = database.query(query);
        system.debug('lst of scope plans'+lstScopePlans);
        
       if(lstScopePlans.size()>0){
        showScope = true;
        showFilter = true;
        hasRecords = true;
        
            for(SPE_SPEPlan__c p : lstScopePlans ){
                scopePlanwraperList.add(new wrapperPlan(p));
               }
                
           system.debug('scope wrapper plan----'+scopePlanwraperList );
           if(applyValidation == true){
           List<wrapperPlan> tempWrapperList = new List<wrapperPlan>();
           tempWrapperList.addAll(scopePlanwraperList);   
           for(wrapperplan temp : tempWrapperList){
               for(wrapperPlan w : scopePlanwraperList){
                   if((w.planConcat == temp.planConcat) && (w.spePlan.Name!= temp.spePlan.Name)){
                      w.isDuplicate = true;
                      if(w.duplicatePlan=='' || w.duplicatePlan == null ){
                       w.duplicatePlan = temp.spePlan.Name;
                      }
                   }   
                    
                   if(w.duplicatePlan=='' || w.duplicatePlan == null){
                   w.isDuplicate = false;
                   }
               
               }
           } 
          }  
          pagination2();
        }
        else{
        showScope = false;
        showFilter = false;
        hasRecords = false;
        isSecondPage = false;
        isShowScopePanel = true;    
        }
    
    
    }
    
    //***************Method Ends*********************
    
     public void pagination(List<wrapperPlan> wrapperPlanList){
            if(!wrapperPlanList.isEmpty()){
             hasRecords = true;
             // Determining total no of pages 
             integer remainder = math.MOD(wrapperPlanList.size(),DEFAULT_PAGE_SIZE);
             subwrapperList.clear();
             if(remainder ==0){
                maxPages = wrapperPlanList.size()/DEFAULT_PAGE_SIZE;
             }
             else{
                maxPages = wrapperPlanList.size()/DEFAULT_PAGE_SIZE + 1;
             }
             system.debug('max pages ---'+maxPages);
             system.debug('wrapperPlanList size'+wrapperPlanList);
             if(wrapperPlanList.size() > DEFAULT_PAGE_SIZE){
                firstBtnClick();      
                system.debug('goin to first btn clk');
             }
             else{
                 for(wrapperPlan scOj : wrapperPlanList){
                     subwrapperList.add(scOj);
                 }
                 startRecNo=1;
                 endRecNo=wrapperPlanList.size();
    
                 shownext = false;
                 showprevoius = false;
                 system.debug('sub wrap----'+subwrapperList.size());
            }
         }
         else{
            hasRecords = false;
           
        }
        system.debug('###'+subwrapperList.size());
    }
  /****************************************************************
                METHOD INVOKED WHEN FIRST BUTTON IS CLICKED
     ****************************************************************/
        
        public void firstBtnClick(){
            pageNumber = 1;
            //showMessage=false;
            system.debug('inside first button');
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            subwrapperList = new list<wrapperPlan>();
    
            for(integer i =0;i<DEFAULT_PAGE_SIZE;i++){
                try{
                    subwrapperList.add(wrapperPlanList[i]);
                }catch(exception e){}
            }
            startRecNo=1;
            endRecNo=DEFAULT_PAGE_SIZE;
    
            shownext = true;
            showprevoius = false;
            showlast=true;
            showfirst=false;
        }
        /****************************************************************
                METHOD INVOKED WHEN NEXT BUTTON IS CLICKED
        ****************************************************************/
        
        public void nextBtnClick(){
            pageNumber = pageNumber+1;
            //showMessage=false;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            subwrapperList = new list<wrapperPlan>();
            
            if(pageNumber == maxPages){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<wrapperPlanList.size(); i++)           
                {
                    try{
                        subwrapperList.add(wrapperPlanList[i]);
                    }catch(exception e){}
                }
                shownext = false;
                showlast=false;
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=wrapperPlanList.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
                {
                    try{
                         subwrapperList.add(wrapperPlanList[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
    
                shownext = true;
                showlast=true;
            }
            showprevoius = true;
            showfirst=true;
        }
        
        /****************************************************************
                METHOD INVOKED WHEN PREVIOUS BUTTON IS CLICKED
        ****************************************************************/
        
        public void previousBtnClick(){     
            pageNumber = pageNumber-1;
            //showMessage=false;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            subwrapperList = new list<wrapperPlan>();
            
            for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
            {
                try{
                    subwrapperList.add(wrapperPlanList[i]);
                }catch(exception e){}
            }
    
            startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
            endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
    
    
            shownext = true;
            showprevoius = true;
            showlast=true;
            showfirst=true;
    
    
            if(pageNumber == 1){
                showprevoius = false;
                showfirst=false;
            }
            else{
                showprevoius = true;
            }
        }
        
        /****************************************************************
                METHOD INVOKED WHEN LAST BUTTON IS CLICKED
        ****************************************************************/
        
        public void lastBtnClick(){
        pageNumber = maxPages;
        //showMessage=false;
        System.debug('pageNumber----->' + pageNumber);
        subwrapperList.clear();
        subwrapperList = new list<wrapperPlan>();

        for(integer i =(maxPages-1)*DEFAULT_PAGE_SIZE;i<wrapperPlanList.size();i++)           
        {
            try{
                subwrapperList.add(wrapperPlanList[i]);
            }catch(exception e){}
        }

        startRecNo=((maxPages-1)*DEFAULT_PAGE_SIZE)+1;
        endRecNo=wrapperPlanList.size();


        shownext = false;
        showprevoius = true;
        showlast=false;
        showfirst=true;
        }
        
   //---------------------------Pagination2----for first Page scope filters---     
  
          public void pagination2(){
            if(!lstScopePlans.isEmpty()){
                system.debug('show scope---'+showScope);
            //--Determining total no of pages 
             integer remainder = math.MOD(lstScopePlans.size(),DEFAULT_PAGE_SIZE);
             subwrapperList2.clear();
             if(remainder ==0){
                maxPages2 = lstScopePlans.size()/DEFAULT_PAGE_SIZE;
             }
             else{
                maxPages2 = lstScopePlans.size()/DEFAULT_PAGE_SIZE + 1;
             }
             system.debug('max pages ---'+maxPages2);
             system.debug('lstScopePlans size'+lstScopePlans);
             if(lstScopePlans.size() > DEFAULT_PAGE_SIZE){
                firstBtnClick2();      
                system.debug('goin to first btn clk');
             }
             else{
                 for(wrapperPlan scOj : scopePlanwraperList){
                     subwrapperList2.add(scOj);
                 }
                 startRecNo2=1;
                 endRecNo2=scopePlanwraperList.size();
    
                 shownext2 = false;
                 showprevoius2 = false;
                 system.debug('sub wrap----'+subwrapperList2.size());
            }
         }
         else{
            hasRecords = false;
           
        }
        system.debug('###'+subwrapperList2.size());
    }
  /****************************************************************
                METHOD INVOKED WHEN FIRST BUTTON IS CLICKED
     ****************************************************************/
        
        public void firstBtnClick2(){
            pageNumber2 = 1;
            //showMessage=false;
            system.debug('inside first button');
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
            subwrapperList2 = new list<wrapperPlan>();
    
            for(integer i =0;i<DEFAULT_PAGE_SIZE;i++){
                try{
                    subwrapperList2.add(scopePlanwraperList[i]);
                }catch(exception e){}
            }
            startRecNo2=1;
            endRecNo2=DEFAULT_PAGE_SIZE;
    
            shownext2 = true;
            showprevoius2 = false;
            showlast2=true;
            showfirst2=false;
        }
        /****************************************************************
                METHOD INVOKED WHEN NEXT BUTTON IS CLICKED
        ****************************************************************/
        
        public void nextBtnClick2(){
            pageNumber2 = pageNumber2+1;
            //showMessage=false;
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
            subwrapperList2 = new list<wrapperPlan>();
            
            if(pageNumber2 == maxPages2){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<scopePlanwraperList.size(); i++)           
                {
                    try{
                        subwrapperList2.add(scopePlanwraperList[i]);
                    }catch(exception e){}
                }
                shownext2 = false;
                showlast2=false;
    
                startRecNo2=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE)+1;
                endRecNo2=scopePlanwraperList.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber2); i++)           
                {
                    try{
                        subwrapperList2.add(scopePlanwraperList[i]);
                    }catch(exception e){}
                }
    
                startRecNo2=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE)+1;
                endRecNo2=(DEFAULT_PAGE_SIZE*pageNumber2);
    
                shownext2 = true;
                showlast2=true;
            }
            showprevoius2 = true;
            showfirst2=true;
        }
        
        /****************************************************************
                METHOD INVOKED WHEN PREVIOUS BUTTON IS CLICKED
        ****************************************************************/
        
        public void previousBtnClick2(){     
            pageNumber2 = pageNumber2-1;
            //showMessage=false;
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
            subwrapperList2 = new list<wrapperPlan>();
            
            for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber2); i++)           
            {
                try{
                    subwrapperList2.add(scopePlanwraperList[i]);
                }catch(exception e){}
            }
    
            startRecNo2=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE)+1;
            endRecNo2=(DEFAULT_PAGE_SIZE*pageNumber2);
    
    
            shownext2 = true;
            showprevoius2 = true;
            showlast2=true;
            showfirst2=true;
    
    
            if(pageNumber2 == 1){
                showprevoius2 = false;
                showfirst2=false;
            }
            else{
                showprevoius2 = true;
            }
        }
        
        /****************************************************************
                METHOD INVOKED WHEN LAST BUTTON IS CLICKED
        ****************************************************************/
        
        public void lastBtnClick2(){
        pageNumber2 = maxPages2;
        //showMessage=false;
        System.debug('pageNumber2----->' + pageNumber2);
        subwrapperList2.clear();
        subwrapperList2 = new list<wrapperPlan>();

        for(integer i =(maxPages2-1)*DEFAULT_PAGE_SIZE;i<scopePlanwraperList.size();i++)           
        {
            try{
                subwrapperList2.add(scopePlanwraperList[i]);
            }catch(exception e){}
        }

        startRecNo2=((maxPages2-1)*DEFAULT_PAGE_SIZE)+1;
        endRecNo2=scopePlanwraperList.size();


        shownext2 = false;
        showprevoius2 = true;
        showlast2=false;
        showfirst2=true;
        }
                
        
        /****************************************************************
            METHOD INVOKED WHEN PAGE NUMBER IS CHANGED MANUALLY
        ****************************************************************/
        public void goToPage2(){
            //showMessage=false;
            try
            {
                pageNumber2=integer.valueOf(Apexpages.currentPage().getParameters().get('crntPageNum').trim());
            }
            catch(exception ex)
            {
                pageNumber2=1;
            }
    
            if(pageNumber2>maxPages2)
                pageNumber2=maxPages2;
                
            if(pageNumber2<1)// to handle the negative digit as page number
                pageNumber2=1;
                
                
            subwrapperList = new list<wrapperPlan>();
            if(pageNumber2 == maxPages2){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<wrapperPlanList.size(); i++)           
                {
                    try{
                        subwrapperList2.add(wrapperPlanList[i]);
                    }catch(exception e){}
                }
    
                startRecNo2 =((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE)+1;
                endRecNo2=wrapperPlanList.size();
    
    
                if(pageNumber2==1)
                {
                    shownext2 = false;
                    showlast2 =false;
                    showprevoius2 = false;
                    showfirst2=false;
                }else
                {
                    shownext2 = false;
                    showlast2=false;
                    showprevoius2 = true;
                    showfirst2=true;
                }
    
            }
            else if(pageNumber2 ==1){
                for(integer i =0;i<DEFAULT_PAGE_SIZE;i++)           
                {
                    try{           
                        subwrapperList2.add(wrapperPlanList[i]);
                    }catch(exception e){}
                }
    
                startRecNo2=1;
                endRecNo2=DEFAULT_PAGE_SIZE;
    
                shownext2 = true;
                showlast2=true;
                showprevoius2 = false;
                showfirst2=false;  
            }
            else
            {
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber2); i++)           
                {
                    try{
                        subwrapperList2.add(wrapperPlanList[i]);
                    }catch(exception e){}
                }
    
                startRecNo2=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE)+1;
                endRecNo2=(DEFAULT_PAGE_SIZE*pageNumber2);
    
    
                shownext2 = true;
                showlast2=true;
                showprevoius2 = true;
                showfirst2=true;
            }
        }
        
  //***********************Code for Pagination in adhoc scorecrad page ****************
  
      public void pagination3(){
            if(!containerList.isEmpty()){
              
            //--Determining total no of pages 
            hasRecordsSG = true;
             integer remainder = math.MOD(containerList.size(),DEFAULT_PAGE_SIZE);
             subwrapperList3.clear();
             if(remainder ==0){
                maxPages3 = containerList.size()/DEFAULT_PAGE_SIZE;
             }
             else{
                maxPages3 = containerList.size()/DEFAULT_PAGE_SIZE + 1;
             }
             system.debug('max pages ---'+maxPages3);
             system.debug('containerList size'+containerList);
             if(containerList.size() > DEFAULT_PAGE_SIZE){
                firstBtnClick3();      
                system.debug('goin to first btn clk');
             }
             else{
                 for(wrapperPlan scOj : containerList){
                     subwrapperList3.add(scOj);
                 }
                 startRecNo3=1;
                 endRecNo3=containerList.size();
    
                 shownext3 = false;
                 showprevoius3 = false;
                 system.debug('sub wrap----'+subwrapperList3.size());
            }
         }
         else{
            hasRecordsSG = false;
           
        }
        system.debug('###'+subwrapperList3.size());
    }
  /****************************************************************
                METHOD INVOKED WHEN FIRST BUTTON IS CLICKED
     ****************************************************************/
        
        public void firstBtnClick3(){
            pageNumber3 = 1;
            //showMessage=false;
            system.debug('inside first button');
            System.debug('pageNumber33----->' + pageNumber3);
            subwrapperList3.clear();
            subwrapperList3 = new list<wrapperPlan>();
    
            for(integer i =0;i<DEFAULT_PAGE_SIZE;i++){
                try{
                    subwrapperList3.add(containerList[i]);
                }catch(exception e){}
            }
            startRecNo3=1;
            endRecNo3=DEFAULT_PAGE_SIZE;
    
            shownext3 = true;
            showprevoius3 = false;
            showlast3=true;
            showfirst3=false;
        }
        /****************************************************************
                METHOD INVOKED WHEN NEXT BUTTON IS CLICKED
        ****************************************************************/
        
        public void nextBtnClick3(){
            pageNumber3 = pageNumber3+1;
            //showMessage=false;
            System.debug('pageNumber33----->' + pageNumber3);
            subwrapperList3.clear();
            subwrapperList3 = new list<wrapperPlan>();
            
            if(pageNumber3 == maxPages3){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber3)-DEFAULT_PAGE_SIZE); i<containerList.size(); i++)           
                {
                    try{
                        subwrapperList3.add(containerList[i]);
                    }catch(exception e){}

                }
                shownext3 = false;
                showlast3=false;
    
                startRecNo3=((DEFAULT_PAGE_SIZE*pageNumber3)-DEFAULT_PAGE_SIZE)+1;
                endRecNo3=containerList.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber3)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber3); i++)           
                {
                    try{
                        subwrapperList3.add(containerList[i]);
                    }catch(exception e){}
                }
    
                startRecNo3=((DEFAULT_PAGE_SIZE*pageNumber3)-DEFAULT_PAGE_SIZE)+1;
                endRecNo3=(DEFAULT_PAGE_SIZE*pageNumber3);
    
                shownext3 = true;
                showlast3=true;
            }
            showprevoius3 = true;
            showfirst3=true;
        }
        
        /****************************************************************
                METHOD INVOKED WHEN PREVIOUS BUTTON IS CLICKED
        ****************************************************************/
        
        public void previousBtnClick3(){     
            pageNumber3 = pageNumber3-1;
            //showMessage=false;
            System.debug('pageNumber33----->' + pageNumber3);
            subwrapperList3.clear();
            subwrapperList3 = new list<wrapperPlan>();
            
            for(integer i=((DEFAULT_PAGE_SIZE*pageNumber3)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber3); i++)           
            {
                try{
                    subwrapperList3.add(containerList[i]);
                }catch(exception e){}
            }
    
            startRecNo3=((DEFAULT_PAGE_SIZE*pageNumber3)-DEFAULT_PAGE_SIZE)+1;
            endRecNo3=(DEFAULT_PAGE_SIZE*pageNumber3);
    
    
            shownext3 = true;
            showprevoius3 = true;
            showlast3=true;
            showfirst3=true;
    
    
            if(pageNumber3 == 1){
                showprevoius3 = false;
                showfirst3=false;
            }
            else{
                showprevoius3 = true;
            }
        }
        
        /****************************************************************
                METHOD INVOKED WHEN LAST BUTTON IS CLICKED
        ****************************************************************/
        
        public void lastBtnClick3(){
        pageNumber3 = maxPages3;
        //showMessage=false;
        System.debug('pageNumber33----->' + pageNumber3);
        subwrapperList3.clear();
        subwrapperList3 = new list<wrapperPlan>();

        for(integer i =(maxPages3-1)*DEFAULT_PAGE_SIZE;i<containerList.size();i++)           
        {
            try{
                subwrapperList3.add(containerList[i]);
            }catch(exception e){}
        }

        startRecNo3=((maxPages3-1)*DEFAULT_PAGE_SIZE)+1;
        endRecNo3=containerList.size();


        shownext3 = false;
        showprevoius3 = true;
        showlast3=false;
        showfirst3=true;
        }
                
        
        /****************************************************************
            METHOD INVOKED WHEN PAGE NUMBER IS CHANGED MANUALLY
        ****************************************************************/
        public void goToPage3(){
            //showMessage=false;
            try
            {
                pageNumber3=integer.valueOf(Apexpages.currentPage().getParameters().get('crntPageNum').trim());
            }
            catch(exception ex)
            {
                pageNumber3=1;
            }
    
            if(pageNumber3>maxPages3)
                pageNumber3=maxPages3;
                
            if(pageNumber3<1)// to handle the negative digit as page number
                pageNumber3=1;
                
                
            subwrapperList = new list<wrapperPlan>();
            if(pageNumber3 == maxPages3){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber3)-DEFAULT_PAGE_SIZE); i<containerList.size(); i++)           
                {
                    try{
                        subwrapperList.add(containerList[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber3)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=containerList.size();
    
    
                if(pageNumber3==1)
                {
                    shownext = false;
                    showlast=false;
                    showprevoius = false;
                    showfirst=false;
                }else
                {
                    shownext = false;
                    showlast=false;
                    showprevoius = true;
                    showfirst=true;
                }
    
            }
            else if(pageNumber3 ==1){
                for(integer i =0;i<DEFAULT_PAGE_SIZE;i++)           
                {
                    try{
                        subwrapperList.add(containerList[i]);
                    }catch(exception e){}
                }
    
                startRecNo=1;
                endRecNo=DEFAULT_PAGE_SIZE;
    
                shownext = true;
                showlast=true;
                showprevoius = false;
                showfirst=false;  
            }
            else
            {
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber3)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber3); i++)           
                {
                    try{
                        subwrapperList.add(containerList[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber3)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=(DEFAULT_PAGE_SIZE*pageNumber3);
    
    
                shownext = true;
                showlast=true;
                showprevoius = true;
                showfirst=true;
            }
        }
       
    //**************Code for pagination in adhoc scorecrad ends***********************      
    
    //*********************Code for pagination in supplier section*************
    
 public void supplierPagination(){
            if(!scorecardSupplierList.isEmpty()){
                suppSize = scorecardSupplierList.size()+'';
               subwrapperSupplier = new List<SPE_ScorecardSupplierMap__c>(); 
            //--Determining total no of pages 
            hasRecordsSupplier = true;
             integer remainder = math.MOD(scorecardSupplierList.size(),DEFAULT_PAGE_SIZE);
             subwrapperSupplier.clear();
             if(remainder ==0){
                maxPages4 = scorecardSupplierList.size()/DEFAULT_PAGE_SIZE;
             }
             else{
                maxPages4 = scorecardSupplierList.size()/DEFAULT_PAGE_SIZE + 1;
             }
             system.debug('max pages ---'+maxPages4);
             system.debug('scorecardSupplierList size'+scorecardSupplierList);
             if(scorecardSupplierList.size() > DEFAULT_PAGE_SIZE){
                firstBtnClick4();      
                system.debug('goin to first btn clk');
             }
             else{
                 for(SPE_ScorecardSupplierMap__c scOj : scorecardSupplierList){
                     subwrapperSupplier.add(scOj);
                 }
                 startRecNo4=1;
                 endRecNo4=scorecardSupplierList.size();
    
                 shownext4 = false;
                 showprevoius4 = false;
                 system.debug('sub wrap----'+subwrapperSupplier.size());
            }
         }
         else{
            hasRecordsSupplier = false;
           
        }
        system.debug('###'+subwrapperSupplier.size());
    }
  /****************************************************************
                METHOD INVOKED WHEN FIRST BUTTON IS CLICKED
     ****************************************************************/
        
        public void firstBtnClick4(){
            pageNumber4 = 1;
            //showMessage=false;
            system.debug('inside first button');
            System.debug('pageNumber43----->' + pageNumber4);
            subwrapperSupplier.clear();
            subwrapperSupplier = new list<SPE_ScorecardSupplierMap__c>();
    
            for(integer i =0;i<DEFAULT_PAGE_SIZE;i++){
                try{
                    subwrapperSupplier.add(scorecardSupplierList[i]);
                }catch(exception e){}
            }
            startRecNo4=1;
            endRecNo4=DEFAULT_PAGE_SIZE;
    
            shownext4 = true;
            showprevoius4 = false;
            showlast4=true;
            showfirst4=false;
        }
        /****************************************************************
                METHOD INVOKED WHEN NEXT BUTTON IS CLICKED
        ****************************************************************/
        
        public void nextBtnClick4(){
            pageNumber4 = pageNumber4+1;
            //showMessage=false;
            System.debug('pageNumber43----->' + pageNumber4);
            subwrapperSupplier.clear();
            subwrapperSupplier = new list<SPE_ScorecardSupplierMap__c>();
            
            if(pageNumber4 == maxPages4){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber4)-DEFAULT_PAGE_SIZE); i<scorecardSupplierList.size(); i++)           
                {
                    try{
                        subwrapperSupplier.add(scorecardSupplierList[i]);
                    }catch(exception e){}
                }
                shownext4 = false;
                showlast4=false;
    
                startRecNo4=((DEFAULT_PAGE_SIZE*pageNumber4)-DEFAULT_PAGE_SIZE)+1;
                endRecNo4=scorecardSupplierList.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber4)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber4); i++)           
                {
                    try{
                        subwrapperSupplier.add(scorecardSupplierList[i]);
                    }catch(exception e){}
                }
    
                startRecNo4=((DEFAULT_PAGE_SIZE*pageNumber4)-DEFAULT_PAGE_SIZE)+1;
                endRecNo4=(DEFAULT_PAGE_SIZE*pageNumber4);
    
                shownext4 = true;
                showlast4=true;
            }
            showprevoius4 = true;
            showfirst4=true;
        }
        
        /****************************************************************
                METHOD INVOKED WHEN PREVIOUS BUTTON IS CLICKED
        ****************************************************************/
        
        public void previousBtnClick4(){     
            pageNumber4 = pageNumber4-1;
            //showMessage=false;
            System.debug('pageNumber43----->' + pageNumber4);
            subwrapperSupplier.clear();
            subwrapperSupplier = new list<SPE_ScorecardSupplierMap__c>();
            
            for(integer i=((DEFAULT_PAGE_SIZE*pageNumber4)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber4); i++)           
            {
                try{
                    subwrapperSupplier.add(scorecardSupplierList[i]);
                }catch(exception e){}
            }
    
            startRecNo4=((DEFAULT_PAGE_SIZE*pageNumber4)-DEFAULT_PAGE_SIZE)+1;
            endRecNo4=(DEFAULT_PAGE_SIZE*pageNumber4);
    
    
            shownext4 = true;
            showprevoius4 = true;
            showlast4=true;
            showfirst4=true;
    
    
            if(pageNumber4 == 1){
                showprevoius4 = false;
                showfirst4=false;
            }
            else{
                showprevoius4 = true;
            }
        }
        
        /****************************************************************
                METHOD INVOKED WHEN LAST BUTTON IS CLICKED
        ****************************************************************/
        
        public void lastBtnClick4(){
        pageNumber4 = maxPages4;
        //showMessage=false;
        System.debug('pageNumber43----->' + pageNumber4);
        subwrapperSupplier.clear();
        subwrapperSupplier = new list<SPE_ScorecardSupplierMap__c>();

        for(integer i =(maxPages4-1)*DEFAULT_PAGE_SIZE;i<scorecardSupplierList.size();i++)           
        {
            try{
                subwrapperSupplier.add(scorecardSupplierList[i]);
            }catch(exception e){}
        }

        startRecNo4=((maxPages4-1)*DEFAULT_PAGE_SIZE)+1;
        endRecNo4=scorecardSupplierList.size();


        shownext4 = false;
        showprevoius4 = true;
        showlast4=false;
        showfirst4=true;
        }
                
        
        /****************************************************************
            METHOD INVOKED WHEN PAGE NUMBER IS CHANGED MANUALLY
        ****************************************************************/
        public void goToPage4(){
            //showMessage=false;
            try
            {
                pageNumber4=integer.valueOf(Apexpages.currentPage().getParameters().get('crntPageNum').trim());
            }
            catch(exception ex)
            {
                pageNumber4=1;
            }
    
            if(pageNumber4>maxPages4)
                pageNumber4=maxPages4;
                
            if(pageNumber4<1)// to handle the negative digit as page number
                pageNumber4=1;
                
                
            subwrapperSupplier = new list<SPE_ScorecardSupplierMap__c>();
            if(pageNumber4 == maxPages4){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber4)-DEFAULT_PAGE_SIZE); i<scorecardSupplierList.size(); i++)           
                {
                    try{
                        subwrapperSupplier.add(scorecardSupplierList[i]);
                    }catch(exception e){}
                }
    
                startRecNo4=((DEFAULT_PAGE_SIZE*pageNumber4)-DEFAULT_PAGE_SIZE)+1;
                endRecNo4=scorecardSupplierList.size();
    
    
                if(pageNumber4==1)
                {
                    shownext4 = false;
                    showlast4=false;
                    showprevoius4 = false;
                    showfirst4=false;
                }else
                {
                    shownext = false;
                    showlast=false;
                    showprevoius = true;
                    showfirst=true;
                }
    
            }
            else if(pageNumber4 ==1){
                for(integer i =0;i<DEFAULT_PAGE_SIZE;i++)           
                {
                    try{
                        subwrapperSupplier.add(scorecardSupplierList[i]);
                    }catch(exception e){}
                }
    
                startRecNo=1;
                endRecNo=DEFAULT_PAGE_SIZE;
    
                shownext = true;
                showlast=true;
                showprevoius = false;
                showfirst=false;  
            }
            else
            {
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber4)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber4); i++)           
                {
                    try{
                        subwrapperSupplier.add(scorecardSupplierList[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber4)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=(DEFAULT_PAGE_SIZE*pageNumber4);
    
    
                shownext = true;
                showlast=true;
                showprevoius = true;
                showfirst=true;
            }
        }
    
    
    
    
    //**********************Code for pagination suppliers section ends***********************    
    
    
    //************************Delete for SPE Plans**************
    
    public void deletePlan(){
    system.debug('inside delete');
    Set<Id> planId = new Set<ID>(); 
    if(containerList.size()==1){
    ApexPages.Message myMsg = new ApexPages.message(ApexPages.severity.ERROR,'Atleast one Plan is needed for creation of scorecard generator');
    ApexPages.addMessage(myMsg); 
     }
     else{
        for(Integer j = containerList.size() -1 ; j >=0 ; j--){
            if(containerList.get(j).selected == true){
               planId.add(containerList[j].speplan.Id);
               system.debug('element to b removed'+containerList[j]);
               containerList.remove(j);
                system.debug('value of counter'+j);
            }
           system.debug('removed record'); 
         }
         
        
         
         List<SPE2_PlanHolder__c> phlist = new List<SPE2_PlanHolder__c>();
         phList = [Select SPE_Plan__c,UID__c from SPE2_PlanHolder__c where SPE_Plan__c in :planId and UID__c = :uidentify];
         if(phList.size()>0){
             delete phList;
         }
         endRecNo3 = containerList.size();
         if(containerList.size()>0){
             hasRecordsSG = true;
            
          }
       else{
           hasRecordsSG = false;
       }
       getPlanSupplier();
       
        }
      }  
    
    //***************delete ends***************
    
        
        /*********Code for Scope Picklist****************/
        public List<SelectOption> getGeographyScope() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('All Markets','All Markets'));
            options.add(new SelectOption('Market','Market'));
            options.add(new SelectOption('Market Unit','Market Unit'));
            options.add(new SelectOption('Country','Country'));
            options.add(new SelectOption('Project','Project'));
            return options;
        }
        public List<SelectOption> getCategoryScope() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('All Categories','All Categories'));
            options.add(new SelectOption('Category Area','Category Area'));
            options.add(new SelectOption('Category Group','Category Group'));
            options.add(new SelectOption('Category','Category'));
            return options;
        }
        public List<SelectOption> getProductScope() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('All Products','All Products'));
            options.add(new SelectOption('Business Unit','Business Unit'));
            options.add(new SelectOption('Business Line','Business Line'));
            options.add(new SelectOption('Product','Product'));
            return options;
        }
     
     
     //----------Drop Down for obsolete and published plans filter------------
     
      public List<SelectOption> getPlanStage() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('Obsolete','Obsolete'));
            options.add(new SelectOption('Published','Published'));
            options.add(new SelectOption('All','All'));
            options.sort();
            return options;
        }
        
    public void getPlanSupplier(){
        supp = new SPE_SPEPlanSupplierMap__c();
        List<SPE_SPEPlanSupplierMap__c> lstSupplierMap = new List<SPE_SPEPlanSupplierMap__c>();
        Set<String> supplierIds = new Set<String>();
        Set<String> spePlanIds = new Set<String>();
        scorecardSupplierList = new  List<SPE_ScorecardSupplierMap__c>();
        
        scoreCardPlans = new List<SPE_Scorecard_Plan__c>();
        
       // lstSuppWrapper  = new List<wrapperSupplier>();
        
        Set<ID> planSet = new Set<ID>();
        Map<ID,List<Boolean>> mapSupplierPlanList = new Map<ID,List<Boolean>>();
        Map<String,List<String>> suppVintageMap = new Map<String,List<String>>();
        Map<String,List<String>> suppLastTrackerDateMap = new Map<String,List<String>>();
        Set<String> tempPlan = new Set<String>();
        Set<ID> tempSupp = new Set<ID>();
        system.debug('inside supplier section');
        system.debug('size of list'+containerList.size());
        
        if(containerList.size()>0){
        for(wrapperPlan w : containerList){
            planSet.add(w.spePlan.Id);
        }   
        
        
           system.debug('set of plans---'+planSet); 
         lstSupplierMap = [SELECT SPEPlan__c,Supplier__c,SPEPlan__r.Vintage__c,SPEPlan__r.Last_Tracker_Date__c,Supplier__r.EnterpriseId__c,SPEPlan__r.Active__c from SPE_SPEPlanSupplierMap__c where speplan__r.Id in :planSet];
         system.debug('supplier in the list is'+lstSupplierMap);
         
         if(lstSupplierMap.size()>0){
         for(SPE_SPEPlanSupplierMap__c s : lstSupplierMap ){
             supplierIds.add(s.Supplier__c);
             spePlanIds.add(s.SPEPlan__c);
             system.debug('supplier'+s.Supplier__c);
             system.debug('plan'+s.SPEPlan__c);
             system.debug('latest data----'+s.SPEPlan__r.Last_Tracker_Date__c);
             //mapPlanSupplier.put(s.SPEPlan__c,s.Supplier__c);
            // planVintageMap.put(s.SPEPlan__c,s.SPEPlan__r.Vintage__c);
             //supplierVintageMap.put(s.Supplier__c,planVintageMap);
           //  lstSuppWrapper.add(new wrapperSupplier(s));
         }
         
         //-----adding vintage with supplier-------------
       // Map<String,List<String>> suppVintageMap = new Map<String,List<String>>();
        
        List<String> vintageList;
        List<Boolean> planActiveList;
        List<String> planLastDateList; 
        for(SPE_SPEPlanSupplierMap__c s : lstSupplierMap ){
            vintageList = new List<String>();
            planLastDateList = new List<String>();
            system.debug('inside before tempPlan');
            if(!tempPlan.contains(String.ValueOf(s.Supplier__c))){
                if(s.SPEPlan__r.Vintage__c!=null){
                vintageList.add(s.SPEPlan__r.Vintage__c);
                
                Date dt = Date.newInstance(s.SPEPlan__r.Last_Tracker_Date__c.year(),s.SPEPlan__r.Last_Tracker_Date__c.month(),s.SPEPlan__r.Last_Tracker_Date__c.day());
                system.debug('date is'+dt);
                String mon;
                if(dt.month()<10)
                mon = '0'+dt.month()+'';
                else
                mon = dt.month()+'';
                planLastDateList.add(dt.year()+' P'+mon);
                planLastDateList.sort();
                vintageList.sort();
                system.debug('supplier'+s.Supplier__r.EnterpriseId__c+'vintage'+s.SPEPlan__r.Vintage__c);
                 suppVintageMap.put(s.Supplier__c,vintageList);
                 suppLastTrackerDateMap.put(s.Supplier__c,planLastDateList);
                }
                
                planActiveList =  new List<Boolean>();
                planActiveList.add(s.SPEPlan__r.Active__c);
               
                mapSupplierPlanList.put(s.Supplier__c,planActiveList);
                 system.debug('supplier vintage map is in if---'+suppVintageMap);
                 system.debug('plan list wid supplier in if---'+mapSupplierPlanList);
                 String str = String.ValueOf(s.Supplier__c);
                tempPlan.add(str);
                tempSupp.add(s.Supplier__c);
                system.debug('tempplan is'+tempPlan);
            }
            else{
                
                if(suppVintageMap.get(s.Supplier__c)!=null){
                vintageList = suppVintageMap.get(s.Supplier__c);
                system.debug('vintage val----'+suppVintageMap.get(s.Supplier__c));
                
                vintageList.add(s.SPEPlan__r.Vintage__c);
                system.debug('vintage list----'+vintageList);
                vintageList.sort();
                suppVintageMap.put(s.Supplier__c,vintageList);
                } 
                
                if(suppLastTrackerDateMap.get(s.Supplier__c)!=null){
                planLastDateList = suppLastTrackerDateMap.get(s.Supplier__c);
                Date dt = Date.newInstance(s.SPEPlan__r.Last_Tracker_Date__c.year(),s.SPEPlan__r.Last_Tracker_Date__c.month(),s.SPEPlan__r.Last_Tracker_Date__c.day());       
                 system.debug('date2 is'+dt);
                String mon;
                if(dt.month()<10)
                mon = '0'+dt.month()+'';
                else
                mon = dt.month()+'';
                planLastDateList.add(dt.year()+' P'+mon);
                planLastDateList.sort();
                suppLastTrackerDateMap.put(s.Supplier__c,planLastDateList);
                } 
                
                planActiveList = mapSupplierPlanList.get(s.Supplier__c);
                if(planActiveList!=null){
                planActiveList.add(s.SPEPlan__r.Active__c);
                mapSupplierPlanList.put(s.Supplier__c,planActiveList);
                 system.debug('supplier vintage map is in else---'+suppVintageMap);
                 system.debug('plan list wid supplier in else---'+mapSupplierPlanList);
            }
           }
           
           system.debug('latest data'+suppLastTrackerDateMap);
        }
        
        
        system.debug('supplier vintage map is---'+suppVintageMap);
        system.debug('plan list wid supplier---'+mapSupplierPlanList);
         
         
         
         
         
         //----------------
        if(suppVintageMap != null) {
        for(String acc :suppVintageMap.keySet()){
            SPE_ScorecardSupplierMap__c scSupp = new SPE_ScorecardSupplierMap__c();
            scSupp.Supplier__c = acc;
            system.debug('errr-----'+suppVintageMap.get(acc));
            if(suppVintageMap.get(acc)!=null || (!suppVintageMap.isEmpty())){
            scSupp.Earliest_Date__c = suppVintageMap.get(acc)[0];
            }
            List<Boolean> lstSPEPlanActive = new List<Boolean>();
            if(mapSupplierPlanList.get(acc)!=null){
            lstSPEPlanActive = mapSupplierPlanList.get(acc);
            system.debug('lstSPEPlanActive ---'+lstSPEPlanActive);
            
            for(Boolean sp : lstSPEPlanActive){
                if(sp == true){
                String Mon;
                if(Date.today().month()<10)
                Mon = '0'+Date.today().month()+'';
                else
                mon = Date.today().month()+'';
                scSupp.Latest_Data__c = String.ValueOf(Date.today().year()+' P'+mon);
                system.debug('inside active');
                break; 
                }
            }
          }  
            if(scSupp.Latest_Data__c == '' || scSupp.Latest_Data__c == null){
            //Integer sizeList = suppVintageMap.get(acc).size();
            Integer sizeList = suppLastTrackerDateMap.get(acc).size();
            scSupp.Latest_Data__c = suppLastTrackerDateMap.get(acc)[sizeList - 1];
            system.debug('value is---'+scSupp);
                
        }
        scorecardSupplierList.add(scSupp);
     }   
         }
       
         
        }
      }   
      
      
      else{
          system.debug('scorecardSupplierList.size---'+scorecardSupplierList.size());
         subwrapperSupplier.clear();
      }
      
          
      
      if(!scorecardSupplierList.isEmpty()){
      
          supplierPagination();
      
      }
      
      
         
                     
             
  }    
  
  public void populateScopeVals(){
  
   if(containerList.size()==1){
        scoreCardgenerator.BusinessLine__c = containerList[0].spePlan.BusinessLine__c;
        scoreCardgenerator.BusinessUnit__c = containerList[0].spePlan.BusinessUnit__c;
        scoreCardgenerator.Category__c = containerList[0].spePlan.Category__c;
        scoreCardgenerator.CategoryCluster__c = containerList[0].spePlan.CategoryCluster__c;
        scoreCardgenerator.CategoryGroup__c = containerList[0].spePlan.CategoryGroup__c;
        scoreCardgenerator.Country__c = containerList[0].spePlan.Country__c;
        scoreCardgenerator.Product__c = containerList[0].spePlan.Product__c;
        scoreCardgenerator.Project__c = containerList[0].spePlan.Project__c;
        scoreCardgenerator.Region__c = containerList[0].spePlan.Region__c;
        scoreCardgenerator.SubRegion__c = containerList[0].spePlan.SubRegion__c;
        
        }
  
  
  } 

    public PageReference saveScorecardGen(){
     Set<ID> lstSPETemp;
     Set<ID> planID = new Set<ID>();
     scTemplate = new SPE_ScorecardTemplate__c();
        if(containerList.size()>0){
           lstSPETemp = new Set<ID>();
            for(wrapperPlan w : containerList){
                lstSPETemp.add(w.spePlan.SPETemplate__c);
               }
            system.debug('list of spe templates'+lstSPETemp);
         }
         
   //----------create scorecard template---------------------
      try{
           scTemplate.Name = 'AdhocScorecardTemplate'+system.Now();
           insert scTemplate;
           system.debug('scorecrd template craeted'+scTemplate);
           scTemplate.Stage__c = 'Pilot';
           update scTemplate;
  
           lstSCTemplateMap = new List<SPE_ScorecardSPETemplateMap__c>();
           if(lstSPETemp.size()>0){
               Integer size = lstSPETemp.size();
               Decimal sum = 0;
               system.debug('inside sctemplate');
               for(Id temp : lstSPETemp){
                   SPE_ScorecardSPETemplateMap__c scTempMap = new SPE_ScorecardSPETemplateMap__c();
                   scTempMap.ScorecardTemplate__c = scTemplate.ID;
                   scTempMap.SPETemplate__c = temp;
                   scTempMap.Weight__c = (Integer)Math.ceil(100/size);
                   lstSCTemplateMap.add(scTempMap);
                   system.debug('sctemp map --'+lstSCTemplateMap);
               }
               for(SPE_ScorecardSPETemplateMap__c sct : lstSCTemplateMap ){
                   sum   +=sct.Weight__c;
                   system.debug('sum is'+sum);
               }
               if(sum<=100){
                   Decimal diff = 100 - sum;
                   lstSCTemplateMap[0].Weight__c =  lstSCTemplateMap[0].Weight__c + diff;
                   system.debug('updated sctempmap---'+lstSCTemplateMap[0].Weight__c);
               }
               if(lstSCTemplateMap.size()>0)
               insert lstSCTemplateMap;
               system.debug('template map created'+lstSCTemplateMap);
           } 
           
    }
    
    catch(Exception e){
    system.debug('exception is'+e);
    }
    
    
    //-----------scorecard template created---------
    //---------------scorecard generator creation--------------------
    
        scoreCardPlans = new List<SPE_Scorecard_Plan__c>();
        Date strtD;
        Date endD;
        scorecardName = scoreCardgenerator.Name;
         if(containerList.size()==1){
        scoreCardgenerator.BusinessLine__c = containerList[0].spePlan.BusinessLine__c;
        scoreCardgenerator.BusinessUnit__c = containerList[0].spePlan.BusinessUnit__c;
        scoreCardgenerator.Category__c = containerList[0].spePlan.Category__c;
        scoreCardgenerator.CategoryCluster__c = containerList[0].spePlan.CategoryCluster__c;
        scoreCardgenerator.CategoryGroup__c = containerList[0].spePlan.CategoryGroup__c;
        scoreCardgenerator.Country__c = containerList[0].spePlan.Country__c;
        scoreCardgenerator.Product__c = containerList[0].spePlan.Product__c;
        scoreCardgenerator.Project__c = containerList[0].spePlan.Project__c;
        scoreCardgenerator.Region__c = containerList[0].spePlan.Region__c;
        scoreCardgenerator.SubRegion__c = containerList[0].spePlan.SubRegion__c;
        
        }
        
        system.debug('scorecard template ID'+scTemplate.ID);
        scoreCardgenerator.ScorecardTemplate__c = scTemplate.ID;
        if(scoreCardgenerator.Aggregation_Period_Adhoc__c == 'Monthly'){
            scoreCardgenerator.FrequencyInMonths__c = '1';
            strtD = Date.newInstance(startDateYear,startDateMonth,1);
            endD = Date.newInstance(endDateYear,endDateMonth,1);
            
          }   
        if(scoreCardgenerator.Aggregation_Period_Adhoc__c == 'Quarterly'){
            Integer mon;
             Integer endmon;
            scoreCardgenerator.FrequencyInMonths__c = '3'; 
            if(startDateMonth == 1)
                mon = 1;
            if(startDateMonth == 2)
                mon = 4;
             if(startDateMonth == 3)
                mon = 8;   
             if(startDateMonth == 4)
                mon = 12;
             if(endDateMonth == 1)
                endmon = 1;
            if(endDateMonth == 2)
                endmon = 4;
             if(endDateMonth == 3)
                endmon = 8;   
             if(endDateMonth == 4)
                endmon = 12;   
            strtD = Date.newInstance(startDateYear,mon,1);
            endD = Date.newInstance(endDateYear,endmon,1);
         }   
        if(scoreCardgenerator.Aggregation_Period_Adhoc__c == 'Half Yearly'){
             Integer mon;
             Integer endmon;
            scoreCardgenerator.FrequencyInMonths__c = '6';
            if(startDateMonth == 1)
                mon = 1;
           if(startDateMonth == 2)
                mon = 6;
           if(endDateMonth == 1)
              endmon = 1; 
           if(endDateMonth == 2)
              endmon = 12; 
          strtD = Date.newInstance(startDateYear,mon,1);
          endD = Date.newInstance(endDateYear,endmon,1);      
          }  
        if(scoreCardgenerator.Aggregation_Period_Adhoc__c == 'Annual'){
            scoreCardgenerator.FrequencyInMonths__c = '12';   
         strtD = Date.newInstance(startDateYear,1,1);
         endD = Date.newInstance(endDateYear,1,1);
         }
         //-----------------Next computed day calculation-----
            kpiDay = Date.newinstance(1960, 1, 1);
            Integer monthvalue = System.Today().Month();
            
            List<ID> speplanID = new List<ID>();
            for(wrapperPlan w : containerList){
                speplanID.add(w.speplan.ID);
            }
            
            //List<SPE_SPETracker__c> spetrackList = [Select ID,Name,DateOfExecution__c,SPEPlan__c,Period__c from SPE_SPETracker__c where SPEPlan__c IN:speplanID order by DateOfExecution__c];
            List<SPE_SPETracker__c> spetrackList = [Select ID,Name,DateOfExecution__c,SPEPlan__c,Period__c from SPE_SPETracker__c where SPEPlan__c IN:speplanID AND Status__c = 'Pending'];
            
            for(SPE_SPETracker__c speTrackMap : spetrackList)
            {  
                if (speTrackMap.DateOfExecution__c != null && monthvalue == speTrackMap.DateOfExecution__c.Month() && System.Today().Year() == speTrackMap.DateOfExecution__c.Year())
                {
                    if(speTrackMap.DateOfExecution__c > kpiDay){
                        kpiDay = speTrackMap.DateOfExecution__c;
                    }                               
                }
            }
            
            /*if(spetrackList[0].DateOfExecution__c != Null){
                kpiDay = spetrackList[0].DateOfExecution__c;
            }*/
            
            if(kpiDay == Date.newinstance(1960, 1, 1) || kpiDay < System.Today()){
               kpiDay = System.Today(); 
            }
             
            if(scoreCardgenerator.Additional_Days__c != Null){
                Integer additional_days = Integer.ValueOf(scoreCardgenerator.Additional_Days__c);
                kpiDay = kpiDay.addDays(additional_days);
            }
            
            if(monthvalue < kpiDay.Month() && kpiDay < endD && kpiDay >= strtD){
                displaydate = kpiDay.Day()+'/'+kpiDay.Month()+'/'+kpiDay.Year();
                displaypopup = true;
                return null;
            }
            if(monthvalue < kpiDay.Month() && kpiDay < endD && kpiDay < strtD){
                //kpiDay = strtD;
                Date calNCD = Date.NewInstance(strtD.Year(),strtD.Month(),kpiday.Day());
                if(calNCD >= strtD){
                    kpiday = calNCD;
                }
                else{            
                    kpiday = strtD;
                }
                displaydate = kpiDay.Day()+'/'+kpiDay.Month()+'/'+kpiDay.Year();
                displaypopup = true;
                return null;
            }
            else if(monthvalue < kpiDay.Month() && kpiDay > endD){
                displaydate = kpiDay.Day()+'/'+kpiDay.Month()+'/'+kpiDay.Year();
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Next Computed Day:'+displaydate+' cannot be greater than End Day'));
                return null;    
            }
            
            if(kpiDay < endD && kpiDay >= System.Today() && kpiDay >= strtD){
                scoreCardgenerator.Next_Computed_Day__c = kpiday;
            }
            else if(kpiDay < endD && kpiDay >= System.Today() && kpiDay < strtD){
                //scoreCardgenerator.Next_Computed_Day__c = strtD;
                Date calNCD = Date.NewInstance(strtD.Year(),strtD.Month(),kpiday.Day());
                if(calNCD >= strtD){
                    scoreCardgenerator.Next_Computed_Day__c = calNCD;
                }
                else{            
                    scoreCardgenerator.Next_Computed_Day__c = strtD;
                }
            }
            else if(kpiDay < endD && kpiDay < System.Today()){
                Integer additional_days = Integer.ValueOf(scoreCardgenerator.Additional_Days__c);
                scoreCardgenerator.Next_Computed_Day__c = System.Today().addDays(additional_days);
            }
            else if(kpiDay > endD && kpiDay >= System.Today()){
                displaydate = kpiDay.Day()+'/'+kpiDay.Month()+'/'+kpiDay.Year();
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Next Computed Day:'+displaydate+' cannot be greater than End Day'));
                return null;
            }
            
        //--------------------        
         system.debug('start date is'+strtD);
         system.debug('end date is '+endD);
        scoreCardgenerator.StartDate__c = strtD ;
        scoreCardgenerator.EndDate__c= endD;
        scoreCardgenerator.TimeFrame__c = scoreCardgenerator.FrequencyInMonths__c;
        scoreCardgenerator.isAdhoc__c = true;
        scoreCardgenerator.Stage__c='Draft';
        if(scorecardName =='' || scorecardName == null){
          showmsg = true;
           ApexPages.Message myMsg = new ApexPages.message(ApexPages.severity.ERROR,'Please enter Scorecard Generator Name to continue');
           ApexPages.addMessage(myMsg); 
        } 
       try{  
        insert scoreCardgenerator;        
        system.debug('scgenerator created'+scoreCardgenerator);
       // scorecardSupplierList = new List<SPE_ScorecardSupplierMap__c>();
        Set<String> scoreCardParamSet = new Set<String>();
        for(SPE_ScorecardSupplierMap__c smap : scorecardSupplierList ){
         smap.ScorecardGenerator__c = scoreCardgenerator.Id;
         scoreCardParamSet.add(smap.Identifier_Param__c);
        }
        for(wrapperPlan w : containerList){
            planID.add(w.speplan.ID);
        }
          for(String plan :planID){
            scoreCardPlans.add(new SPE_Scorecard_Plan__c(SPE_Plan__c = plan));    
        }
        for(SPE_Scorecard_Plan__c sp :scoreCardPlans){
            sp.Scorecard_Generator__c = scoreCardgenerator.Id;
        }
                
        insert scorecardSupplierList;
        insert scoreCardPlans;
        
        List<SPE2_CC_Contact_Details__c> ccContactList = new List<SPE2_CC_Contact_Details__c>();
        ccContactList = [Select Id,Scorecard_Supplier_Map__c,Identifier_Param__c From SPE2_CC_Contact_Details__c
                        Where Identifier_Param__c IN: scoreCardParamSet];
                
        for(SPE2_CC_Contact_Details__c cc :ccContactList){
            if(cc.Identifier_Param__c != '' && cc.Identifier_Param__c != null){
                SPE_ScorecardSupplierMap__c ssm1 = new SPE_ScorecardSupplierMap__c(Identifier_Param__c = cc.Identifier_Param__c);
                cc.Scorecard_Supplier_Map__r = ssm1;
            }
        } 
        update ccContactList;
         pageReference pf = new pageReference('/'+scoreCardgenerator.Id);
            if(!showmsg)
            return pf;
            else
            return null;
       
     
       } 
        catch(Exception e){
            ApexPages.addMessages(e) ; 
            system.debug('Exception is'+e);
            return null;
        }
        
        
    }
    
  public PageReference ContinueScorecardGen(){
     Set<ID> lstSPETemp;
     Set<ID> planID = new Set<ID>();
     scTemplate = new SPE_ScorecardTemplate__c();
        if(containerList.size()>0){
           lstSPETemp = new Set<ID>();
            for(wrapperPlan w : containerList){
                lstSPETemp.add(w.spePlan.SPETemplate__c);
               }
            system.debug('list of spe templates'+lstSPETemp);
         }
         
   //----------create scorecard template---------------------
      try{
           scTemplate.Name = 'AdhocScorecardTemplate'+system.Now();
           insert scTemplate;
           system.debug('scorecrd template craeted'+scTemplate);
           scTemplate.Stage__c = 'Pilot';
           update scTemplate;
  
           lstSCTemplateMap = new List<SPE_ScorecardSPETemplateMap__c>();
           if(lstSPETemp.size()>0){
               Integer size = lstSPETemp.size();
               Decimal sum = 0;
               system.debug('inside sctemplate');
               for(Id temp : lstSPETemp){
                   SPE_ScorecardSPETemplateMap__c scTempMap = new SPE_ScorecardSPETemplateMap__c();
                   scTempMap.ScorecardTemplate__c = scTemplate.ID;
                   scTempMap.SPETemplate__c = temp;
                   scTempMap.Weight__c = (Integer)Math.ceil(100/size);
                   lstSCTemplateMap.add(scTempMap);
                   system.debug('sctemp map --'+lstSCTemplateMap);
               }
               for(SPE_ScorecardSPETemplateMap__c sct : lstSCTemplateMap ){
                   sum   +=sct.Weight__c;
                   system.debug('sum is'+sum);
               }
               if(sum<=100){
                   Decimal diff = 100 - sum;
                   lstSCTemplateMap[0].Weight__c =  lstSCTemplateMap[0].Weight__c + diff;
                   system.debug('updated sctempmap---'+lstSCTemplateMap[0].Weight__c);
               }
               if(lstSCTemplateMap.size()>0)
               insert lstSCTemplateMap;
               system.debug('template map created'+lstSCTemplateMap);
           } 
           
    }
    
    catch(Exception e){
    system.debug('exception is'+e);
    }
    
    
    //-----------scorecard template created---------
    //---------------scorecard generator creation--------------------
    
        scoreCardPlans = new List<SPE_Scorecard_Plan__c>();
        Date strtD;
        Date endD;
        scorecardName = scoreCardgenerator.Name;
        if(containerList.size()==1){
        scoreCardgenerator.BusinessLine__c = containerList[0].spePlan.BusinessLine__c;
        scoreCardgenerator.BusinessUnit__c = containerList[0].spePlan.BusinessUnit__c;
        scoreCardgenerator.Category__c = containerList[0].spePlan.Category__c;
        scoreCardgenerator.CategoryCluster__c = containerList[0].spePlan.CategoryCluster__c;
        scoreCardgenerator.CategoryGroup__c = containerList[0].spePlan.CategoryGroup__c;
        scoreCardgenerator.Country__c = containerList[0].spePlan.Country__c;
        scoreCardgenerator.Product__c = containerList[0].spePlan.Product__c;
        scoreCardgenerator.Project__c = containerList[0].spePlan.Project__c;
        scoreCardgenerator.Region__c = containerList[0].spePlan.Region__c;
        scoreCardgenerator.SubRegion__c = containerList[0].spePlan.SubRegion__c;
        
        }
        system.debug('scorecard template ID'+scTemplate.ID);
        scoreCardgenerator.ScorecardTemplate__c = scTemplate.ID;
        if(scoreCardgenerator.Aggregation_Period_Adhoc__c == 'Monthly'){
            scoreCardgenerator.FrequencyInMonths__c = '1';
            strtD = Date.newInstance(startDateYear,startDateMonth,1);
            endD = Date.newInstance(endDateYear,endDateMonth,1);
          }   
        if(scoreCardgenerator.Aggregation_Period_Adhoc__c == 'Quarterly'){
            Integer mon;
             Integer endmon;
            scoreCardgenerator.FrequencyInMonths__c = '3'; 
            if(startDateMonth == 1)
                mon = 1;
            if(startDateMonth == 2)
                mon = 4;
             if(startDateMonth == 3)
                mon = 8;   
             if(startDateMonth == 4)
                mon = 12;
             if(endDateMonth == 1)
                endmon = 1;
            if(endDateMonth == 2)
                endmon = 4;
             if(endDateMonth == 3)
                endmon = 8;   
             if(endDateMonth == 4)
                endmon = 12;   
            strtD = Date.newInstance(startDateYear,mon,1);
            endD = Date.newInstance(endDateYear,endmon,1);
         }   
        if(scoreCardgenerator.Aggregation_Period_Adhoc__c == 'Half Yearly'){
             Integer mon;
             Integer endmon;
            scoreCardgenerator.FrequencyInMonths__c = '6';
            if(startDateMonth == 1)
                mon = 1;
           if(startDateMonth == 2)
                mon = 6;
           if(endDateMonth == 1)
              endmon = 1; 
           if(endDateMonth == 2)
              endmon = 12; 
          strtD = Date.newInstance(startDateYear,mon,1);
          endD = Date.newInstance(endDateYear,endmon,1);      
          }  
        if(scoreCardgenerator.Aggregation_Period_Adhoc__c == 'Annual'){
            scoreCardgenerator.FrequencyInMonths__c = '12';   
         strtD = Date.newInstance(startDateYear,1,1);
         endD = Date.newInstance(endDateYear,1,1);
         }
        scoreCardgenerator.StartDate__c = strtD ;
        scoreCardgenerator.EndDate__c= endD;
        scoreCardgenerator.isAdhoc__c = true;
        scoreCardgenerator.Stage__c='Draft';
        
        if(kpiDay < endD){
            scoreCardgenerator.Next_Computed_Day__c = kpiday;
        }
        
       if(scorecardName =='' || scorecardName == null){
          showmsg = true;
           ApexPages.Message myMsg = new ApexPages.message(ApexPages.severity.ERROR,'Please enter Scorecard Generator Name to continue');
           ApexPages.addMessage(myMsg); 
        }   
        
          try{ 
        insert scoreCardgenerator;
        system.debug('scgenerator created'+scoreCardgenerator);
       // scorecardSupplierList = new List<SPE_ScorecardSupplierMap__c>();
        
        for(SPE_ScorecardSupplierMap__c smap : scorecardSupplierList ){
         smap.ScorecardGenerator__c = scoreCardgenerator.Id;
        }
        for(wrapperPlan w : containerList){
            planID.add(w.speplan.ID);
        }
          for(String plan :planID){
            scoreCardPlans.add(new SPE_Scorecard_Plan__c(SPE_Plan__c = plan));    
        }
        for(SPE_Scorecard_Plan__c sp :scoreCardPlans){
            sp.Scorecard_Generator__c = scoreCardgenerator.Id;
        }
        system.debug('scorecardSupplierList created'+scorecardSupplierList);       
        insert scorecardSupplierList;
        insert scoreCardPlans;
        system.debug('scorecardSupplierList created'+scorecardSupplierList);
         system.debug('scoreCardPlans created'+scoreCardPlans);
          pageReference pf = new pageReference('/'+scoreCardgenerator.Id);
            if(!showmsg)
            return pf;
            else
            return null;
            
        
     
       } 
        catch(Exception e){
            ApexPages.addMessages(e) ; 
            system.debug('Exception is'+e);
            return null;
        }
       
        
    } 
    
    public List<SelectOption> getpopulateYear(){
       List<SelectOption> yearOptions = new List<SelectOption>();
       for(Integer i=-1;i<5;i++){
          String year = String.valueOf(System.today().addYears(i).year());
          yearOptions.add(new SelectOption(year,year));
       }
         return yearOptions;
    
    }
    
    public List<SelectOption> getpopulateMonth(){
       List<SelectOption> monthOptions = new List<SelectOption>();
       for(Integer i=1;i<=12;i++){
          String month = String.valueOf(i);
          monthOptions.add(new SelectOption(month,month));
       }
         return monthOptions;
    
    }
    public void blankMethod(){}
     public List<SelectOption> getpopulateQuarter(){
       List<SelectOption> quarterOptions = new List<SelectOption>();
       for(Integer i=1;i<=4;i++){
          String quarter= String.valueOf(i);
          quarterOptions.add(new SelectOption(quarter,quarter));
       }
         return quarterOptions ;
    
    }
    
    public List<SelectOption> getpopulateHalfYearly(){
       List<SelectOption> halfYearlyOptions = new List<SelectOption>();
       for(Integer i=1;i<=2;i++){
          String halfyearly= String.valueOf(i);
          halfYearlyOptions.add(new SelectOption(halfyearly,halfyearly));
       }
         return halfYearlyOptions ;
    
    }
    
    
    public PageReference cancelFunction(){
        Schema.DescribeSObjectResult result = SPE_ScorecardGenerator__c.SObjectType.getDescribe(); 
        PageReference pageRef = new PageReference('/' + result.getKeyPrefix()); 
        pageRef.setRedirect(true); 
         return pageRef; 
      }
  
  /**  public void contactSearch(){
        lstContact = new List<Contact>();
        System.debug('strContactName-----' + strContactName);
        lstWrapperContact = new List<contactWrapper>();
        String strSearchText = strContactName + '%';
        lstContact = [select Id,Name,Email from Contact where Name Like: strSearchText limit 999];
        System.debug('lstContact-----' + lstContact);
        for(Contact c : lstContact){
            lstWrapperContact.add(new contactWrapper(false,c));
        }
        
        System.debug('lstWrapperContact-----' + lstWrapperContact);
    }
    Set<Id> idSupplier = new Set<Id>();
    List<Contact> contList;
    public void addCCContactMap(){
        //Id supplierId = ApexPages.currentpage().getParameters().get('paramName');
        system.debug('supplierId----' + supplierId);
        system.debug('mapSuppIdContactList---Before--' + mapSuppIdContactList);
        
        for(contactWrapper con : lstWrapperContact) {
            if(con.isContactSelected){
                if(!idSupplier.contains(supplierId)) {
                    contList = new List<Contact>();
                    contList.add(con.objContactWrap);
                    mapSuppIdContactList.put(supplierId,contList);
                    idSupplier.add(supplierId);
                 } else {
                    contList = mapSuppIdContactList.get(supplierId);
                    contList.add(con.objContactWrap);
                    mapSuppIdContactList.put(supplierId,contList);
                 }
                
                contList = new List<Contact>();
                contList.add(con.objContactWrap);
                mapSuppIdContactList.put(supplierId,contList);
                    
             }
        }
        
        
        system.debug('mapSuppIdContactList-----' + mapSuppIdContactList);
    }
    public void clearWrapperList(){
        lstWrapperContact = new List<contactWrapper>();
    }
    
   **/ 
    /****************************************************************
                        WRAPPER CLASS
     ****************************************************************/
   /**    public class contactWrapper{
       public boolean isContactSelected{get;set;}
       public Contact objContactWrap{get;set;}
       
       public contactWrapper(boolean isContactSelectedTemp,Contact objContactWrapTemp){
           isContactSelected = isContactSelectedTemp;
           objContactWrap = objContactWrapTemp;
       }
   }
   
   **/
   
   
   public class wrapperPlan{
       public SPE_SPEPlan__c spePlan  {get; set;}
       public Boolean selected {get; set;}
       public string planConcat;
       public boolean isDuplicate {get;set;}
       public String duplicatePlan {get;set;}
          
       public wrapperPlan(SPE_SPEPlan__c plan) {
            spePlan  = plan;
            selected = false;
            planConcat = plan.Region__c+plan.SubRegion__c+plan.Country__c+plan.Project__c+plan.CategoryCluster__c+plan.CategoryGroup__c+plan.Category__c+plan.BusinessUnit__c+plan.BusinessLine__c+plan.Product__c;
            isDuplicate = false;
            
       }
   
   }
   
   public void closePopup() {        
        displayPopup = false;    
    }  
   
   public class wrapperSupplier{
       public SPE_ScorecardSupplierMap__c speSupplier{get;set;}
       public Boolean selected {get; set;}
       public String supplier {get;set;}
       
       public wrapperSupplier(SPE_ScorecardSupplierMap__c supp){
           speSupplier = supp;
           selected = false;
       }
  
   }
   
   
}