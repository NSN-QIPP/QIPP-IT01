public with sharing class SPE_NewScorecardTemplateExt 
{
    public string marketVal{get;set;}
    public string marketUnitVal{get;set;}
    public string countryVal{get;set;}
    public string projectVal{get;set;}
    public string buVal{get;set;}
    public string blVal{get;set;}
    public string prdVal{get;set;}
    public string caVal{get;set;}
    public string cgVal{get;set;}
    public string ctVal{get;set;}
    public boolean sameOrganization{get;set;}
    public SPE_ScorecardTemplate__c scoreCardTemp {get;set;}
    public SPE_ScorecardTemplate__c scoreCardTempCloned;
    public String url {get;set;}
    private String flag;
    public String contvalue{get;set;} 
    public String showCancel {get;set;}
    public String showSave {get;set;}
    public String recId;
    public Boolean isError {get;set;}
    public String errorMsg {get;set;}
    
    
    
    public List<SPE_ScorecardSPETemplateMap__c> scorecardSPETemplateMaps {get;set;}
   
    public List<SPE_ScorecardSPETemplateMap__c> scorecardSPETemplateMapstemp;
   
    private  List<SPE_ScorecardSPETemplateMap__c> ScorecardSPETemplateMapsCloned;
    
    private  List<SPE_ScorecardSPETemplateMap__c> toBeDeletedScorecardSPETemplateMaps;
    public String testV{get;set;}
    public List<SPE_SPETemplateHolder__c> existingSIds{get;set;}
    List<SPE_ScorecardSPETemplateMap__c> existingSPETempMap;
    Set<Id> setId = new Set<Id>();
    
    
    public SPE_NewScorecardTemplateExt (Apexpages.Standardcontroller st)
     {   
        flag = 'false';
        isError = false;
        existingSIds = new List<SPE_SPETemplateHolder__c>();
        existingSPETempMap = new List<SPE_ScorecardSPETemplateMap__c>();
        url = ApexPages.currentpage().getURL();
        showCancel = 'false';
        showSave = 'true';
       
        
        
        if(ApexPages.currentpage().getURL().contains('adhocview') && ApexPages.currentpage().getURL().contains('uniqueI')){
            existingSIds = [select Id,SPE_Template__c from SPE_SPETemplateHolder__c where UniqueIdentifier__c = :ApexPages.currentpage().getParameters().get('uniqueI')+'' AND CreatedById =: userInfo.getUserId()];
        }
        
        system.debug('existingSIds---' + existingSIds);
        if (st.getId() == null)
        {
            scoreCardTemp = new SPE_ScorecardTemplate__c();
            scorecardSPETemplateMaps = new List<SPE_ScorecardSPETemplateMap__c>();
            recId ='';  
            if(ApexPages.currentpage().getURL().contains('isNew=true') && ApexPages.currentpage().getURL().contains('RecName')){
            scoreCardTemp.Name = Apexpages.currentPage().getParameters().get('RecName');
            }    
        }
        else
        {
            recId = st.getId();
            
            scoreCardTempCloned = new SPE_ScorecardTemplate__c();
            ScorecardSPETemplateMapsCloned = new List<SPE_ScorecardSPETemplateMap__c>();
            scoreCardTemp = [SELECT Name, Stage__c, Region__c,Type__c, SubRegion__c, Country__c, Project__c, CategoryCluster__c, CategoryGroup__c, Category__c,
                                    BusinessUnit__c, BusinessLine__c, Product1__c,  Product2__c, Product3__c, Product__c,Organization_Group__c
                             FROM SPE_ScorecardTemplate__c 
                             WHERE Id =: st.getId()];
                             
            SPE_MathsUtil.market1 = scoreCardTemp .Region__c;
            SPE_MathsUtil.bu1 = scoreCardTemp .BusinessUnit__c;
            SPE_MathsUtil.marketUnit1 = scoreCardTemp .SubRegion__c;
            SPE_MathsUtil.bl1 = scoreCardTemp .BusinessLine__c;
            SPE_MathsUtil.country1 = scoreCardTemp .Country__c;
            SPE_MathsUtil.prd1 = scoreCardTemp .Product__c;
            SPE_MathsUtil.project1 = scoreCardTemp .Project__c;
            SPE_MathsUtil.ca1 = scoreCardTemp .CategoryCluster__c;
            SPE_MathsUtil.cg1 = scoreCardTemp .CategoryGroup__c;
            SPE_MathsUtil.ct1 = scoreCardTemp .Category__c;
        
            scorecardSPETemplateMaps = [SELECT Id,Name,SPETemplate__c, SPETemplate__r.Stage__c,SPETemplate__r.Name,Weight__c,SPETemplate__r.Organization_Group__c
                                        FROM SPE_ScorecardSPETemplateMap__c 
                                        WHERE ScorecardTemplate__c = : st.getId()];
                                        
               
                                  
                        
        }
        for(SPE_ScorecardSPETemplateMap__c  temp : scorecardSPETemplateMaps ){
                setId.add(temp.SPETemplate__c);
            }       
            
         
             
            if(!existingSIds.isEmpty()){
                for(SPE_SPETemplateHolder__c s  : existingSIds){
                    SPE_ScorecardSPETemplateMap__c objTM = new SPE_ScorecardSPETemplateMap__c();
                    objTM.SPETemplate__c = s.SPE_Template__c;
                    objTM.ScorecardTemplate__c = st.getId();
                    existingSPETempMap.add(objTM);
                }
            }
            
            if(!existingSPETempMap.isEmpty()){
            for(SPE_ScorecardSPETemplateMap__c  obj : existingSPETempMap){
               if(!setId.contains(obj.SPETemplate__c)) {   
                   scorecardSPETemplateMaps.add(obj);
                   system.debug('ading temp');
                   
                }   
               else{
                   isError = true;
                   system.debug('inside error');
               }    
            }  
        }           
        ScorecardSPETemplateMapsCloned = scorecardSPETemplateMaps.deepClone(); 
        if(isError){
            errorMsg = 'The selected template is already added';
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,errorMsg));
        }
        
    }

    public void addSPETemplate()
    {
        
        SPE_ScorecardSPETemplateMap__c spe = new SPE_ScorecardSPETemplateMap__c();
            
        scorecardSPETemplateMaps.add(spe);
        
    }
        
    public void removeSPETemplate()
    {
        Integer rowIndex = Integer.Valueof(Apexpages.currentPage().getParameters().get('rowIndex'));
   
        List<SPE_ScorecardSPETemplateMap__c> newScorecardSPETemplateMaps = new List<SPE_ScorecardSPETemplateMap__c>();
        
        toBeDeletedScorecardSPETemplateMaps = new List<SPE_ScorecardSPETemplateMap__c>();
    
        for (integer i=0; i<scorecardSPETemplateMaps.size(); i++) 
        {
            if(i != rowIndex-1)
            {
                newScorecardSPETemplateMaps.add(scorecardSPETemplateMaps[i]);
            }
            else
            {
                if (scorecardSPETemplateMaps[i].Id != null)
                {
                    toBeDeletedScorecardSPETemplateMaps.add(scorecardSPETemplateMaps[i]);
                }
                
            }
        }
    
        scorecardSPETemplateMaps.clear();
        
        delete toBeDeletedScorecardSPETemplateMaps;
        
        scorecardSPETemplateMaps.addall(newScorecardSPETemplateMaps);
        
    }
        
    public Pagereference save()
    {
        Pagereference pr;
            
        if (checkValidation() == true)
        {   
            if(url.contains('clone=1')){
                if(scoreCardTemp != null){
                scoreCardTempCloned = scoreCardTemp.clone(false,true);
                }
            
                if(scoreCardTempCloned != null && scoreCardTempCloned.Id != null){
                scoreCardTempCloned.Id = null;
               }
            
                if(scoreCardTempCloned != null){
                
                scoreCardTempCloned.Stage__c= 'Draft';
                scoreCardTempCloned.Region__c = marketVal;
                scoreCardTempCloned.BusinessUnit__c = buVal;
                scoreCardTempCloned.SubRegion__c = marketUnitVal;
                scoreCardTempCloned.BusinessLine__c = blVal;
                scoreCardTempCloned.Country__c = countryVal;
                scoreCardTempCloned.Product__c = prdVal;
                scoreCardTempCloned.Project__c = projectVal;
                scoreCardTempCloned.CategoryCluster__c = caVal;
                scoreCardTempCloned.CategoryGroup__c = cgVal;
                scoreCardTempCloned.Category__c = ctVal;
                   
                 
                //----
              try{  
                insert scoreCardTempCloned;
              }
              
              catch(Exception ex){
                ApexPages.addMessages(ex) ; 
                return null;
              } 
                
            
            }       
            
            if(scoreCardTempCloned.id != null){
                for(SPE_ScorecardSPETemplateMap__c objKPIC : ScorecardSPETemplateMapsCloned){
                    objKPIC.ScorecardTemplate__c = scoreCardTempCloned.id;
                    objKPIC.Id = null;
                    
                   }
                
                    if(!ScorecardSPETemplateMapsCloned.isEmpty())
                    {
                        if(ScorecardSPETemplateMapsCloned==null){  
                            try{
                            insert ScorecardSPETemplateMapsCloned;
                            }
                            catch(Exception ex){
                            ApexPages.addMessages(ex); 
                            }
                        }
                    }
                    
                }
                
              List<SPE_ScorecardSPETemplateMap__c> toBeInsertedScorecardSPETemp = assignScoreCards(scoreCardTempCloned);
              
              upsert toBeInsertedScorecardSPETemp;
              
              pr = new Pagereference('/' + scoreCardTempCloned.Id);
                
            }
            else{
            scoreCardTemp.Region__c = marketVal;
            scoreCardTemp.BusinessUnit__c = buVal;
            scoreCardTemp.SubRegion__c = marketUnitVal;
            scoreCardTemp.BusinessLine__c = blVal;
            scoreCardTemp.Country__c = countryVal;
            scoreCardTemp.Product__c = prdVal;
            scoreCardTemp.Project__c = projectVal;
            scoreCardTemp.CategoryCluster__c = caVal;
            scoreCardTemp.CategoryGroup__c = cgVal;
            scoreCardTemp.Category__c = ctVal;
            scoreCardTemp.Stage__c = 'Draft';
            
            try
            {
                upsert scoreCardTemp;
            }
            
            catch(exception ex){
            
            ApexPages.addMessages(ex);
            return null;
            }
                    
            List<SPE_ScorecardSPETemplateMap__c> toBeInsertedScorecardSPETemp = assignScoreCards(scoreCardTemp);
         
            upsert toBeInsertedScorecardSPETemp;
            
            pr = new Pagereference('/' + scoreCardTemp.Id);
            }         
            
            return pr;
        }
        
        
        if(ApexPages.currentpage().getURL().contains('adhocview') && ApexPages.currentpage().getURL().contains('uniqueI')){
            try{
                delete [Select id from SPE_SPETemplateHolder__c where UniqueIdentifier__c = : ApexPages.currentpage().getParameters().get('uniqueI') AND CreatedById =: userInfo.getUserId()];
            }
            catch(Exception e){
                system.debug('exception:::'+e.getMessage());
            }
        }   
        return null;
    }
      
    public Pagereference cancel()
    {
        Schema.DescribeSObjectResult r = SPE_ScorecardTemplate__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        Pagereference pr = new Pagereference('/'+keyPrefix);
        pr.setRedirect(true);
        return pr;
            
    }  
      
    private Boolean checkValidation()
    {
        Decimal total = 0;
        scorecardSPETemplateMapstemp = new List<SPE_ScorecardSPETemplateMap__c>();
        Set<Id>  addedSPEs = new Set<Id>();
        Map<Id,String> SPEOrg = new Map<Id,String>();
                  
        for (SPE_ScorecardSPETemplateMap__c spe: ScorecardSPETemplateMaps)
        { 
             
            if (!addedSPEs.contains(spe.SPETemplate__c))
            {
                addedSPEs.add(spe.SPETemplate__c);
            }
            
            else{
              
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Do Not Select Duplicate SPE Template'));
                
                return false;
              }
            
           
             
            /*if(spe.SPETemplate__c == null)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,
                                                            'SPE Template Should Not be kept Blank'));
                return false;
            }*/
            
            if (spe.Weight__c == null )
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,
                                                            'Weightage Should Always Be Filled with NonZero Value'));
                 return false;
            }

            else
            {
                total = total + spe.Weight__c;
            }
            
           
           
            system.debug('org value is'+spe.SPETemplate__r.Organization_Group__c);
          if(addedSPEs!=null){
              
                List<SPE_SPETemplate__c> lsttempspe = new List<SPE_SPETemplate__c>();
                lsttempspe = [Select Organization_Group__c  from SPE_SPETemplate__c  where id in :addedSPEs];
                system.debug('org value in set is'+lsttempspe);
                for(SPE_SPETemplate__c s:lsttempspe){
                       if(s.Organization_Group__c!=null){
                        SPEOrg.put(s.Id,s.Organization_Group__c);
                    }
               
                }
             
                List<String> orgGroupvals = new List<String>();
                for(String s :SPEOrg.keyset()){
                orgGroupvals.add(SPEOrg.get(s));
                }
                boolean sameOrganization = false;
                for(integer i=0;i < orgGroupvals.size(); i++){
                 if(orgGroupvals[i] == orgGroupvals[i++]){
                       sameOrganization = true; 
                       showCancel = 'true';
                       showSave = 'false';
                 }
             }  
             
                if(orgGroupvals.size()==1){
                 sameOrganization = false;
                 showCancel = 'false';
                 showSave = 'true';
                 }
             
             
             if(sameOrganization == true && contvalue != 'continueSave'){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'You can\'t add SPE Template with same organization group.Do you want to continue.'));
              return false;   
             }
            } 
          
           
           /* SPE_SPETemplate__c speTemp = [SELECT Id, Stage__c FROM SPE_SPETemplate__c WHERE Id =: spe.SPETemplate__c];
            
            if(speTemp.Stage__c == 'Obsolete')
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'You can\'t add Obsolete SPE Template into Scorecard Template'));
                return false;
            }*/ 
         }
        
        if ( total != 100 )
        {
             showCancel = 'false';
             showSave = 'true';
                       
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,System.Label.SPE_Weightage));
            return false;
        }   
        
        showCancel = 'false';
        showSave = 'true';
                       
        return true;
    }
        
    private List<SPE_ScorecardSPETemplateMap__c> assignScoreCards (SPE_ScorecardTemplate__c scorecardTemp)
    {
        List<SPE_ScorecardSPETemplateMap__c> toBeInsertedScorecardSPETemp = new List<SPE_ScorecardSPETemplateMap__c>();
         Map<String,Id> mapSPEOrgval = new Map<String,Id>();
        
        for (SPE_ScorecardSPETemplateMap__c speScorecardTemp : scorecardSPETemplateMaps)
        {
            speScorecardTemp.ScorecardTemplate__c = scorecardTemp.Id;
            toBeInsertedScorecardSPETemp.add(speScorecardTemp);
                        
        }   
                            
        return toBeInsertedScorecardSPETemp;
    }
   
   public PageReference redirectToadhoc(){
       String dateTimeStamp = System.now()+'';
       if(recId!=''){
       PageReference pg = new PageReference('/apex/SPE_AdhocScorecardPage?id='+recId+'&adhocView=true&RecName='+scoreCardTemp.Name + '&UID=' + dateTimeStamp.trim()+'&isNew=false');
       pg.setRedirect(true);
       return pg;
       }
       else{
       PageReference pg = new PageReference('/apex/SPE_AdhocScorecardPage?adhocView=true&RecName='+scoreCardTemp.Name + '&UID=' + dateTimeStamp.trim()+'&isNew=true');
       pg.setRedirect(true);
       return pg;
       
       }
   
   
   } 
 
}