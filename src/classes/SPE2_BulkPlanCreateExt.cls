public class SPE2_BulkPlanCreateExt{

    public string caVal{get;set;}
    public string cgVal{get;set;}
    public string ctVal{get;set;}
    public string buVal{get;set;}
    public string blVal{get;set;}
    public string marketVal{get;set;} 
    public string marketUnitVal{get;set;}
    public string countryVal{get;set;} 
    public string projectVal{get;set;}
    public string prdVal{get;set;}
    
    public Boolean isDisplayError{get;set;}
    public Boolean isDisplayError1{get;set;}
    
    public String startstring{get;set;}
    public String endstring{get;set;}
        
    public Boolean Mktchk{get;set;}
    public Boolean MktUnitchk{get;set;}
    public Boolean Countchk{get;set;}
    public Boolean Prjchk{get;set;}
    public Boolean CatAreachk{get;set;}
    public Boolean CatGrpchk{get;set;}
    public Boolean Catchk{get;set;}
    public Boolean BUchk{get;set;}
    public Boolean BLchk{get;set;}
    public Boolean Prodchk{get;set;}
    public Boolean Alldisable;
    
    List<SelectOption> CatGroupOptions;
    List<SelectOption> CategoryOptions;
    public Set<String> lstTemp{get;set;}
    Set<String> setCategoryArea;
    Set<String> setMarkets;
    Set<String> setMarketUnit;
    Set<String> setBusinessUnits;
    List<SelectOption>  mkoptions;
    List<SelectOption> countryOptions;
    List<SelectOption> projectOptions;
    List<SelectOption> BusinessLineOptions;
    List<SelectOption> ProductOptions;
    map<String,Set<String>> mapHierarchyDetails1;
    public map<String,Set<String>> mapHierarchyDetails{get;set;}
    public SPE_SPEPlan__c spePlan{get;set;}
    private ApexPages.StandardController controller;
    public ID scoringtemplateId{get;set;}    
    public Boolean isMktDisable{get;set;}
    public Boolean isMktUnitDisable{get;set;}
    public Boolean isCountryDisable{get;set;}
    public Boolean isProjDisable{get;set;}
    public Boolean isBUUnitDisable{get;set;}
    public Boolean isBULineDisable{get;set;}
    public Boolean isProdDisable{get;set;}
    public Boolean isCatAreaDisable{get;set;}
    public Boolean isCatGrpDisable{get;set;}
    public Boolean isCatDisable{get;set;}
    
    //********For Pagination*********//
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
    public Integer supplistsize{get;set;}
    public String PlanIdentifier{get;set;}
    
    public Boolean isError5{get;set;}
    public Boolean isError6{get;set;}
    public Date new_st_date;
    public Date new_end_date;
    public Date fiveyearsdate;
    public Date kpiday{get;set;}
        
    public SPE_ScoringTemplate__c scoringTemplatescope{get;set;}
    
    //*****Wrapper List to Display in Page******//
    //Transient List<SPEPlanWrapper> speplanwrapperListdisplay;
    public List<SPEPlanWrapper> speplanwrapperListdisplay;
    public List<SPEPlanWrapper> subwrapperList{get;set;} // list of wrapper class to store only the limited no of(# of page size) SPE Plan 
    
    public List<PicklistDefaultValues__c> defalultPicklist
    {
        get{
            return PicklistDefaultValues__c.getall().values();
        }
    } 

    public SPE2_BulkPlanCreateExt(ApexPages.StandardController controller){
    
            this.controller = controller;
            scoringtemplateId = apexpages.currentpage().getparameters().get('scoringtempId');
            spePlan =new SPE_SPEPlan__c(SPEScoringTemplate__c = scoringtemplateId,OwnerId = UserInfo.getUserId());
            mapHierarchyDetails1 = new map<String,Set<String>>();
            mapHierarchyDetails = SPE_MapUtility.returnMapValues();
            setCategoryArea = new Set<String>();
            setMarkets = new Set<String>();
            lstTemp =new Set<String>();
            setBusinessUnits = new Set<String>();
            PlanIdentifier = System.Now()+';'+UserInfo.getUserId();
            Mktchk = false;
            MktUnitchk = false;
            Countchk = false;
            Prjchk = false;
            CatAreachk = false;
            CatGrpchk = false;
            Catchk = false;
            BUchk = false;
            BLchk = false;
            Prodchk = false;
            
            isError5 = False;
            isError6 = False;
            isDisplayError = false;
            isDisplayError1 =false;

            Alldisable = false;
            
            DEFAULT_PAGE_SIZE = 50;
            pageNumber = 1;
            startRecNo=0;
            endRecNo=0;
            supplistsize=0;
            shownext=false;
            showprevoius=false;
            showfirst=false;
            showlast=false;
            
            speplanwrapperListdisplay = new List<SPEPlanWrapper>();
            subwrapperList = new list<SPEPlanWrapper>();
            
            isMktDisable = false;
            isMktUnitDisable = false;
            isCountryDisable = false;
            isProjDisable = false;
            isBUUnitDisable = false;
            isBULineDisable = false;
            isProdDisable = false;
            isCatAreaDisable = false;
            isCatGrpDisable = false;
            isCatDisable = false;

            for(String s : mapHierarchyDetails.keyset()){   
                 if(s.contains('~Market')){
                    setMarkets.add(s.split('~')[0]);                
                 }
                 if(s.contains('~BusinessUnit')){
                    setBusinessUnits.add(s.split('~')[0]);
                    system.debug('setBusinessUnits'+setBusinessUnits);
                 }         
                 if(s.contains('~CategoryArea')){
                    setCategoryArea.add(s.split('~')[0]);
                  }
             }
            
            for(String s : mapHierarchyDetails.keyset()){
                if(s.contains('~Market')){
                   String s1 = s.replace('~Market','');
                   mapHierarchyDetails1.put(s1,mapHierarchyDetails.get(s));
                }
                else{
                    mapHierarchyDetails1.put(s,mapHierarchyDetails.get(s));
                }
                
                if(s.contains('~BusinessUnit')){
                    String s1 = s.replace('~BusinessUnit','');
                    mapHierarchyDetails1.put(s1,mapHierarchyDetails.get(s));
                }
                else{
                     mapHierarchyDetails1.put(s,mapHierarchyDetails.get(s));
                }
                
                if(s.contains('~CategoryArea')){
                    String s1 = s.replace('~CategoryArea','');
                    mapHierarchyDetails1.put(s1,mapHierarchyDetails.get(s));
                }
                else{
                    mapHierarchyDetails1.put(s,mapHierarchyDetails.get(s));
                }
             }
            
             marketVal = PicklistDefaultValues__c.getall().values()[0].Market__c;
             caVal = PicklistDefaultValues__c.getall().values()[0].Category_Area__c;
             buVal = PicklistDefaultValues__c.getall().values()[0].Business_Unit__c;
             
             ScopeChange();
                
    }
    
     //------------------------------Method to Enable and Disable the correnponding Scope value according to Scoring Template Scope Value----------------------//
     public void disableScopeAttributes(){
         SPE_ScoringTemplate__c scoringTemp = new SPE_ScoringTemplate__c();
         scoringTemp = [Select Id,Region__c,SubRegion__c,Country__c,Project__c,CategoryCluster__c,
                               CategoryGroup__c,Category__c,BusinessUnit__c,BusinessLine__c,Product__c
                               from SPE_ScoringTemplate__c where ID =: scoringtemplateId];
                               
         //****For Market Scope***//                      
         if(scoringTemp.Region__c != SPE_Constants.ALL_GEOSCOPE && scoringTemp.SubRegion__c == SPE_Constants.ALL_GEOSCOPE_UNIT){
                isMktDisable = True;               
         }
         else if(scoringTemp.Region__c != SPE_Constants.ALL_GEOSCOPE 
                 && scoringTemp.SubRegion__c != SPE_Constants.ALL_GEOSCOPE_UNIT && scoringTemp.Country__c == SPE_Constants.ALL_Country){              
                
                isMktDisable = True;
                isMktUnitDisable = True;
              
         }         
         else if(scoringTemp.Region__c != SPE_Constants.ALL_GEOSCOPE && scoringTemp.SubRegion__c != SPE_Constants.ALL_GEOSCOPE_UNIT 
                 && scoringTemp.Country__c != SPE_Constants.ALL_Country && scoringTemp.Project__c == SPE_Constants.ALL_Project){
                 
                isMktDisable = True;
                isMktUnitDisable = True;
                isCountryDisable = True;
        }
        else if(scoringTemp.Region__c != SPE_Constants.ALL_GEOSCOPE && scoringTemp.SubRegion__c != SPE_Constants.ALL_GEOSCOPE_UNIT && scoringTemp.Country__c != SPE_Constants.ALL_Country 
                 && scoringTemp.Project__c != SPE_Constants.ALL_Project){
                 
                isMktDisable = True;
                isMktUnitDisable = True;
                isCountryDisable = True; 
                isProjDisable = True; 
        }
        //****For Category Scope***//
        if(scoringTemp.CategoryCluster__c != SPE_Constants.ALL_CATSCOPE_AREA && scoringTemp.CategoryGroup__c == SPE_Constants.ALL_CATSCOPE_GROUP){
               isCatAreaDisable = true;
        }
        else if(scoringTemp.CategoryCluster__c != SPE_Constants.ALL_CATSCOPE_AREA && scoringTemp.CategoryGroup__c != SPE_Constants.ALL_CATSCOPE_GROUP && scoringTemp.Category__c == SPE_Constants.ALL_CATSCOPE){
               isCatAreaDisable = true;
               isCatGrpDisable = true;  
        }
        else if(scoringTemp.CategoryCluster__c != SPE_Constants.ALL_CATSCOPE_AREA && scoringTemp.CategoryGroup__c != SPE_Constants.ALL_CATSCOPE_AREA && scoringTemp.Category__c != SPE_Constants.ALL_CATSCOPE){
              isCatAreaDisable = true;
              isCatGrpDisable = true;
              isCatDisable = true; 
        }
        
        //****For Business Scope***//
        if(scoringTemp.BusinessUnit__c != SPE_Constants.ALL_BU_BUSCOPE && scoringTemp.BusinessLine__c == SPE_Constants.ALL_BL_BUSCOPE){
              isBUUnitDisable = True;              
        }
        else if(scoringTemp.BusinessUnit__c != SPE_Constants.ALL_BU_BUSCOPE && scoringTemp.BusinessLine__c != SPE_Constants.ALL_BL_BUSCOPE && scoringTemp.Product__c == SPE_Constants.ALL_BUSCOPE){
              isBUUnitDisable = True;
              isBULineDisable = true;
        }
        else if(scoringTemp.BusinessUnit__c != SPE_Constants.ALL_BU_BUSCOPE && scoringTemp.BusinessLine__c != SPE_Constants.ALL_BU_BUSCOPE && scoringTemp.Product__c != SPE_Constants.ALL_BUSCOPE){
             isBUUnitDisable = True;
             isBULineDisable = true;
             isProdDisable = true; 
        }                               
     }
     
     //-----------------Fetch dropdown values of Market-------------
     
     public List<SelectOption> getMarketValues(){
            List<SelectOption> options = new List<SelectOption>();
            if(!setMarkets.contains(PicklistDefaultValues__c.getall().values()[0].Market__c))
                options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Market__c,PicklistDefaultValues__c.getall().values()[0].Market__c));
            for(String s : setMarkets){
                options.add(new SelectOption(s,s));
            }
            system.debug('market is'+marketVal);
            
           return options;
      }
      //------- Fetch dropdown values of Market Unit ---------------

      public List<SelectOption> getMarketUnitValues(){   
            fillMarketUnit();
            return mkoptions;
      }
    
      public void fillMarketUnit(){
            if(Apexpages.currentPage().getParameters().get('marketVal')!= null)
                marketVal = Apexpages.currentPage().getParameters().get('marketVal');
            mkoptions = new List<SelectOption>();
            Set<String> setMUVal = new Set<String>();
            system.debug('marketVal----' + marketVal);
            setMUVal = mapHierarchyDetails1.get(marketVal);
            system.debug('setMUVal----' + setMUVal);
            if(!setMUVal.contains(PicklistDefaultValues__c.getall().values()[0].Market_Unit__c))
                mkoptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Market_Unit__c,PicklistDefaultValues__c.getall().values()[0].Market_Unit__c));
            system.debug('marketVal---' + marketVal); 
            for(String s : mapHierarchyDetails1.get(marketVal)){
                mkoptions.add(new SelectOption(s,s));
              }
        }
        
        // Fetch drop down values for country
        
        public List<SelectOption> getCountryValues(){   
            fillCountry();
            return countryOptions;
        }
        
        
        public void fillCountry(){
            if(Apexpages.currentPage().getParameters().get('marketUnitVal')!= null)
                marketUnitVal = Apexpages.currentPage().getParameters().get('marketUnitVal');
            countryOptions = new List<SelectOption>();
            if((marketVal == PicklistDefaultValues__c.getall().values()[0].Market__c) || !(mapHierarchyDetails1.containsKey(marketVal+marketUnitVal)))
            {
                countryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Country__c,PicklistDefaultValues__c.getall().values()[0].Country__c));
    
            }
          else if(marketUnitVal != PicklistDefaultValues__c.getall().values()[0].Market_Unit__c){
                Set<String> setCVal = new Set<String>();
                setCVal = mapHierarchyDetails1.get(marketVal+marketUnitVal);
                
                if(!setCVal.contains(PicklistDefaultValues__c.getall().values()[0].Country__c))
                    countryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Country__c,PicklistDefaultValues__c.getall().values()[0].Country__c));
                
                system.debug('marketUnitVal---' + marketUnitVal); 
                for(String s : mapHierarchyDetails1.get(marketVal+marketUnitVal)){
                    countryOptions.add(new SelectOption(s,s));
                }
            }
            
            else{
                countryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Country__c,PicklistDefaultValues__c.getall().values()[0].Country__c));
            }
            
        }
        
        //------------------Fetch dropdown values of Project------------------
        
        public List<SelectOption> getProjectValues(){   
            fillProject();
            return projectOptions;
        }
        
        public void fillProject(){
            if(Apexpages.currentPage().getParameters().get('countryVal')!= null)
                countryVal = Apexpages.currentPage().getParameters().get('countryVal');
            projectOptions = new List<SelectOption>();
            if((marketVal == PicklistDefaultValues__c.getall().values()[0].Market__c) || (marketUnitVal == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c) || (countryVal == PicklistDefaultValues__c.getall().values()[0].Country__c) || !(mapHierarchyDetails1.containsKey(marketVal+marketUnitVal+countryVal)) )
            {
                 projectOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Project__c,PicklistDefaultValues__c.getall().values()[0].Project__c));
            }
            
            else if(countryVal != PicklistDefaultValues__c.getall().values()[0].Country__c){
                Set<String> setCVal = new Set<String>();
                setCVal = mapHierarchyDetails1.get(marketVal+marketUnitVal+countryVal);
                
                if(!setCVal.contains(PicklistDefaultValues__c.getall().values()[0].Project__c))
                    projectOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Project__c,PicklistDefaultValues__c.getall().values()[0].Project__c));
                
                system.debug('marketUnitVal---' + marketUnitVal); 
                for(String s : mapHierarchyDetails1.get(marketVal+marketUnitVal+countryVal)){
                    projectOptions.add(new SelectOption(s,s));
                }
            }
            else{
                projectOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Project__c,PicklistDefaultValues__c.getall().values()[0].Project__c));
            }
        }
        
        //--------------Fetch dropdown values for Category Area--------------------
        
        public List<SelectOption> getCategoryAreaValues(){
            List<SelectOption> options = new List<SelectOption>();
            if(!setCategoryArea.contains(PicklistDefaultValues__c.getall().values()[0].Category_Area__c))
                options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category_Area__c,PicklistDefaultValues__c.getall().values()[0].Category_Area__c));
            for(String s : setCategoryArea ){
                options.add(new SelectOption(s,s));
            }
            return options;
         }
         
       //-----------------Fetch dropdown values for Category Group---------------------------
         
        public List<SelectOption> getCategoryGroupValues(){   
            fillCategoryGroup();
            return CatGroupOptions;
        }
        
        public void fillCategoryGroup(){
            if(Apexpages.currentPage().getParameters().get('caVal')!= null)
                caVal = Apexpages.currentPage().getParameters().get('caVal');
            CatGroupOptions= new List<SelectOption>();
            Set<String> setCatGroupVal = new Set<String>();
            setCatGroupVal = mapHierarchyDetails1.get(caVal);
            if(!setCatGroupVal .contains(PicklistDefaultValues__c.getall().values()[0].Category_Group__c))
                CatGroupOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category_Group__c,PicklistDefaultValues__c.getall().values()[0].Category_Group__c));
           
            for(String s : mapHierarchyDetails1.get(caVal)){
                CatGroupOptions.add(new SelectOption(s,s));
            }
         }
         
         //----------------------Fetch drop down values for Category----------------------------
         
        public List<SelectOption> getCategoryValues(){   
            fillCategory();
            return CategoryOptions;
        }
        
        public void fillCategory(){
            if(Apexpages.currentPage().getParameters().get('cgVal')!= null)
            cgVal = Apexpages.currentPage().getParameters().get('cgVal');
            CategoryOptions= new List<SelectOption>();
            Set<String> setCatVal = new Set<String>();
            setCatVal = mapHierarchyDetails1.get(caVal+cgVal);
            
             if((caVal== PicklistDefaultValues__c.getall().values()[0].Category_Area__c) || !(mapHierarchyDetails1.containsKey(caVal+cgVal)))
             {
                CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
             }
            
             else if(!setCatVal .contains(PicklistDefaultValues__c.getall().values()[0].Category__c)){
                CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
           
                 for(String s : mapHierarchyDetails1.get(caVal+cgVal)){
                    CategoryOptions.add(new SelectOption(s,s));
                  }
             }
          
             else
               CategoryOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Category__c,PicklistDefaultValues__c.getall().values()[0].Category__c));
        }
        
        //--------------Fetch dropdown values of Business Units------------------------------
        
       public List<SelectOption> getBusinessUnitValues(){
            List<SelectOption> options = new List<SelectOption>();
            if(!setBusinessUnits.contains(PicklistDefaultValues__c.getall().values()[0].Business_Unit__c))
                options.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Business_Unit__c,PicklistDefaultValues__c.getall().values()[0].Business_Unit__c));
            for(String s : setBusinessUnits){
                options.add(new SelectOption(s,s));
            }
            
            return options;
        }
        
      //--------------------Fetch dropdown values for Business Line-------------------
         
        public List<SelectOption> getBusinesLineValues(){   
            fillBusinessLine();
            return BusinessLineOptions;
        }
        
       public void fillBusinessLine(){
            if(Apexpages.currentPage().getParameters().get('buVal')!= null)
                buVal= Apexpages.currentPage().getParameters().get('buVal');
            BusinessLineOptions= new List<SelectOption>();
            Set<String> setBUVal = new Set<String>();
            setBUVal = mapHierarchyDetails1.get(buVal);
            if(!setBUVal.contains(PicklistDefaultValues__c.getall().values()[0].Business_Line__c))
                BusinessLineOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Business_Line__c,PicklistDefaultValues__c.getall().values()[0].Business_Line__c));
           
            for(String s : mapHierarchyDetails1.get(buVal)){
                BusinessLineOptions.add(new SelectOption(s,s));
            }
        }
    
     //----------------Fetch dropdown values for Product------------------------------
    
       public List<SelectOption> getProductValues(){   
            fillProduct();
            return ProductOptions;
        }
        
       public void fillProduct(){
            
            if(Apexpages.currentPage().getParameters().get('blVal')!= null)
                blVal= Apexpages.currentPage().getParameters().get('blVal');
            
            system.debug('I am here-blVal--' + blVal);
            system.debug('I am here-buVal--' + buVal);
            ProductOptions= new List<SelectOption>();
            lstTemp = new Set<String>();
            Set<String> setProductVal = new Set<String>();
            setProductVal = mapHierarchyDetails1.get(buVal+blVal);
            
             if((buVal == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c) || !(mapHierarchyDetails1.containsKey(buVal+blVal)))
            {
              system.debug('I am here---');
              ProductOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Product__c,PicklistDefaultValues__c.getall().values()[0].Product__c));
              lstTemp.add(PicklistDefaultValues__c.getall().values()[0].Product__c);
            }
            
            else if(!setProductVal .contains(PicklistDefaultValues__c.getall().values()[0].Product__c)){
                ProductOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Product__c,PicklistDefaultValues__c.getall().values()[0].Product__c));
                lstTemp.add(PicklistDefaultValues__c.getall().values()[0].Product__c);   
                for(String s : mapHierarchyDetails1.get(buVal+blVal)){
                    ProductOptions.add(new SelectOption(s,s));
                    lstTemp.add(s);  
                }
            }
            else{ 
                 ProductOptions.add(new SelectOption(PicklistDefaultValues__c.getall().values()[0].Product__c,PicklistDefaultValues__c.getall().values()[0].Product__c));
                lstTemp.add(PicklistDefaultValues__c.getall().values()[0].Product__c);
            }
        }
        
      //*******************Method to display All new SPE Plan according to Scope Attributes*****************//
        
       public void createSPEPlan(){
          List<SPE_CategoryMaster__c>  satMaster = new List<SPE_CategoryMaster__c>();
          List<SPE_ProjectMaster__c>  mktMaster = new List<SPE_ProjectMaster__c>();
          List<SPE_BUBL__c>  buMaster = new List<SPE_BUBL__c>();
          List<SPE_SPEPlan__c> speplanListdisplay = new List<SPE_SPEPlan__c>();

          Map<String,SPE_CategoryMaster__c> CatAreaMap = new Map<String,SPE_CategoryMaster__c>();
          Map<String,SPE_ProjectMaster__c> MktMap = new Map<String,SPE_ProjectMaster__c>();
          Map<String,SPE_BUBL__c> BUMap = new Map<String,SPE_BUBL__c>();
          
          speplanwrapperListdisplay = new List<SPEPlanWrapper>();
          
         //************************All Category Scope Combination for 1D******************// 
          if(caVal != '' && CatAreachk == true && caVal != PicklistDefaultValues__c.getall().values()[0].Category_Area__c){
              String catArea = caVal;
              //System.Debug(LoggingLevel.ERROR,'######################'+catArea);
              satMaster = [Select ID,Cluster__c,Group__c,Category__c from SPE_CategoryMaster__c where Cluster__c =: catArea AND Group__c != ''
                                  AND Category__c != ''];
              for(SPE_CategoryMaster__c catar : satMaster)
              {                    
                  CatAreaMap.put(catar.Cluster__c,catar);
              }                       
              //System.Debug(LoggingLevel.ERROR,'######################'+satMaster);
          }
          else if(caVal != '' && CatAreachk == true && caVal == PicklistDefaultValues__c.getall().values()[0].Category_Area__c){
              satMaster = [Select ID,Cluster__c,Group__c,Category__c from SPE_CategoryMaster__c where Cluster__c != '' AND Group__c != ''
                                  AND Category__c != ''];
                                  
              for(SPE_CategoryMaster__c catar : satMaster)
              {                    
                  CatAreaMap.put(catar.Cluster__c,catar);
              }                      
          }
          else if(cgVal != '' && CatGrpchk == true && cgVal != PicklistDefaultValues__c.getall().values()[0].Category_Group__c && 
                  caVal != PicklistDefaultValues__c.getall().values()[0].Category_Area__c){
              
              String catArea = caVal;
              String catGroup = cgVal;
              
              satMaster = [Select ID,Cluster__c,Group__c,Category__c from SPE_CategoryMaster__c where Cluster__c =: caVal AND Group__c =: cgVal
                                  AND Category__c != ''];
                                  
              for(SPE_CategoryMaster__c catar : satMaster)
              {                    
                  CatAreaMap.put(catar.Group__c,catar);
              }                      
          }
          else if(cgVal != '' && CatGrpchk == true && cgVal == PicklistDefaultValues__c.getall().values()[0].Category_Group__c && 
                  caVal != PicklistDefaultValues__c.getall().values()[0].Category_Area__c){
              
              String catArea = caVal;
              
              satMaster = [Select ID,Cluster__c,Group__c,Category__c from SPE_CategoryMaster__c where Cluster__c =: caVal AND Group__c != ''
                                  AND Category__c != ''];
                                  
              for(SPE_CategoryMaster__c catar : satMaster)
              {                    
                  CatAreaMap.put(catar.Group__c,catar);
              }                      
          }
          else if(cgVal != '' && CatGrpchk == true && cgVal == PicklistDefaultValues__c.getall().values()[0].Category_Group__c && 
                  caVal == PicklistDefaultValues__c.getall().values()[0].Category_Area__c){
                            
              satMaster = [Select ID,Cluster__c,Group__c,Category__c from SPE_CategoryMaster__c where Cluster__c != '' AND Group__c != ''
                                  AND Category__c != ''];
                                  
              for(SPE_CategoryMaster__c catar : satMaster)
              {                    
                  CatAreaMap.put(catar.Cluster__c+catar.Group__c,catar);
              }                      
          }
          else if(ctVal != '' && Catchk == true && cgVal != PicklistDefaultValues__c.getall().values()[0].Category_Group__c && 
                  caVal != PicklistDefaultValues__c.getall().values()[0].Category_Area__c && 
                  ctVal != PicklistDefaultValues__c.getall().values()[0].Category__c){
                            
              String catArea = caVal;
              String catGroup = cgVal;
              String cat = ctVal;
              
              satMaster = [Select ID,Cluster__c,Group__c,Category__c from SPE_CategoryMaster__c where Cluster__c =: caVal AND Group__c =: cgVal
                                  AND Category__c =: cat];
                                  
              for(SPE_CategoryMaster__c catar : satMaster)
              {                    
                  CatAreaMap.put(catar.Category__c,catar);
              }                      
          }
          else if(ctVal != '' && Catchk == true && cgVal != PicklistDefaultValues__c.getall().values()[0].Category_Group__c && 
                  caVal != PicklistDefaultValues__c.getall().values()[0].Category_Area__c && 
                  ctVal == PicklistDefaultValues__c.getall().values()[0].Category__c){
                            
              String catArea = caVal;
              String catGroup = cgVal;
              
              satMaster = [Select ID,Cluster__c,Group__c,Category__c from SPE_CategoryMaster__c where Cluster__c =: caVal AND Group__c =: cgVal
                                  AND Category__c != ''];
                                  
              for(SPE_CategoryMaster__c catar : satMaster)
              {                    
                  CatAreaMap.put(catar.Category__c,catar);
              }                      
          }
          else if(ctVal != '' && Catchk == true && cgVal == PicklistDefaultValues__c.getall().values()[0].Category_Group__c && 
                  caVal != PicklistDefaultValues__c.getall().values()[0].Category_Area__c && 
                  ctVal == PicklistDefaultValues__c.getall().values()[0].Category__c){
                            
              String catArea = caVal;
              
              satMaster = [Select ID,Cluster__c,Group__c,Category__c from SPE_CategoryMaster__c where Cluster__c =: caVal AND Group__c != ''
                                  AND Category__c != ''];
                                  
              for(SPE_CategoryMaster__c catar : satMaster)
              {                    
                  CatAreaMap.put(catar.Group__c+catar.Category__c,catar);
              }                      
          }
          else if(ctVal != '' && Catchk == true && cgVal == PicklistDefaultValues__c.getall().values()[0].Category_Group__c && 
                  caVal == PicklistDefaultValues__c.getall().values()[0].Category_Area__c && 
                  ctVal == PicklistDefaultValues__c.getall().values()[0].Category__c){
                                          
              satMaster = [Select ID,Cluster__c,Group__c,Category__c from SPE_CategoryMaster__c where Cluster__c != '' AND Group__c != ''
                                  AND Category__c != ''];
                                  
              for(SPE_CategoryMaster__c catar : satMaster)
              {                    
                  CatAreaMap.put(catar.Cluster__c+catar.Group__c+catar.Category__c,catar);
              }                      
          }
          
       //************************All Geo Scope Combination for 1D******************//   
          if(marketVal != '' && Mktchk == true && marketVal != PicklistDefaultValues__c.getall().values()[0].Market__c){              
              String mktval = marketVal;
              mktMaster = [Select ID,Market__c,MarketUnit__c,Country__c,Project__c from SPE_ProjectMaster__c where Market__c =: mktval AND MarketUnit__c != '' 
                                  AND Country__c != '' AND Project__c != ''];
                                  
              for(SPE_ProjectMaster__c mkt : mktMaster)
              {                    
                  MktMap.put(mkt.Market__c,mkt);
              }                              
          }
          else if(marketVal != '' && Mktchk == true && marketVal == PicklistDefaultValues__c.getall().values()[0].Market__c){
               mktMaster = [Select ID,Market__c,MarketUnit__c,Country__c,Project__c from SPE_ProjectMaster__c where Market__c != '' AND MarketUnit__c != '' 
                                  AND Country__c != '' AND Project__c != ''];
                                  
              for(SPE_ProjectMaster__c mkt : mktMaster)
              {                    
                  MktMap.put(mkt.Market__c,mkt);
              }                   
          }
          else if(marketUnitVal != '' && MktUnitchk == true && marketUnitVal != PicklistDefaultValues__c.getall().values()[0].Market_Unit__c && marketVal != PicklistDefaultValues__c.getall().values()[0].Market__c){
              String mktval = marketVal;
              String mktunitval = marketUnitVal;
              mktMaster = [Select ID,Market__c,MarketUnit__c,Country__c,Project__c from SPE_ProjectMaster__c where Market__c =: mktval AND MarketUnit__c =: mktunitval
                                  AND Country__c != '' AND Project__c != ''];
                                  
              for(SPE_ProjectMaster__c mkt : mktMaster)
              {                    
                  MktMap.put(mkt.MarketUnit__c,mkt);
              }                    
          }
          else if(marketUnitVal != '' && MktUnitchk == true && marketUnitVal == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c && marketVal == PicklistDefaultValues__c.getall().values()[0].Market__c){
              mktMaster = [Select ID,Market__c,MarketUnit__c,Country__c,Project__c from SPE_ProjectMaster__c where Market__c != '' AND MarketUnit__c != '' 
                                  AND Country__c != '' AND Project__c != ''];
                                  
              for(SPE_ProjectMaster__c mkt : mktMaster)
              {                    
                  MktMap.put(mkt.Market__c+mkt.MarketUnit__c,mkt);
              }
          }
          else if(marketUnitVal != '' && MktUnitchk == true && marketUnitVal == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c && marketVal != PicklistDefaultValues__c.getall().values()[0].Market__c){
              String mktval = marketVal;
              mktMaster = [Select ID,Market__c,MarketUnit__c,Country__c,Project__c from SPE_ProjectMaster__c where Market__c =: mktval AND MarketUnit__c != ''
                                  AND Country__c != '' AND Project__c != ''];
                                  
              for(SPE_ProjectMaster__c mkt : mktMaster)
              {                    
                  MktMap.put(mkt.MarketUnit__c,mkt);
              }                    
          }
          else if(countryVal != '' && Countchk == true && 
                  marketUnitVal != PicklistDefaultValues__c.getall().values()[0].Market_Unit__c && 
                  marketVal != PicklistDefaultValues__c.getall().values()[0].Market__c && 
                  countryVal != PicklistDefaultValues__c.getall().values()[0].Country__c){
                  
              String mktval = marketVal;
              String mktunitval = marketUnitVal;
              String cntval = countryVal;
              
              mktMaster = [Select ID,Market__c,MarketUnit__c,Country__c,Project__c from SPE_ProjectMaster__c where Market__c =: mktval AND MarketUnit__c =: mktunitval
                                  AND Country__c =: cntval AND Project__c != ''];
                                  
              for(SPE_ProjectMaster__c mkt : mktMaster)
              {                    
                  MktMap.put(mkt.Country__c,mkt);
              }                    
          }
          else if(countryVal != '' && Countchk == true && 
                  marketUnitVal != PicklistDefaultValues__c.getall().values()[0].Market_Unit__c && 
                  marketVal != PicklistDefaultValues__c.getall().values()[0].Market__c && 
                  countryVal == PicklistDefaultValues__c.getall().values()[0].Country__c){
                  
              String mktval = marketVal;
              String mktunitval = marketUnitVal;
              
              mktMaster = [Select ID,Market__c,MarketUnit__c,Country__c,Project__c from SPE_ProjectMaster__c where Market__c =: mktval AND MarketUnit__c =: mktunitval
                                  AND Country__c != '' AND Project__c != ''];
                                  
              for(SPE_ProjectMaster__c mkt : mktMaster)
              {                    
                  MktMap.put(mkt.Country__c,mkt);
              }                    
          }
          else if(countryVal != '' && Countchk == true && 
                  marketUnitVal == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c && 
                  marketVal != PicklistDefaultValues__c.getall().values()[0].Market__c && 
                  countryVal == PicklistDefaultValues__c.getall().values()[0].Country__c){
                  
              String mktval = marketVal;
              
              mktMaster = [Select ID,Market__c,MarketUnit__c,Country__c,Project__c from SPE_ProjectMaster__c where Market__c =: mktval AND MarketUnit__c != ''
                                  AND Country__c != '' AND Project__c != ''];
                                  
              for(SPE_ProjectMaster__c mkt : mktMaster)
              {                    
                  MktMap.put(mkt.Country__c+mkt.MarketUnit__c,mkt);
              }                    
          }
          else if(countryVal != '' && Countchk == true && 
                  marketUnitVal == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c && 
                  marketVal == PicklistDefaultValues__c.getall().values()[0].Market__c && 
                  countryVal == PicklistDefaultValues__c.getall().values()[0].Country__c){
                  
              mktMaster = [Select ID,Market__c,MarketUnit__c,Country__c,Project__c from SPE_ProjectMaster__c where Market__c != '' AND MarketUnit__c != ''
                                  AND Country__c != '' AND Project__c != ''];
                                  
              for(SPE_ProjectMaster__c mkt : mktMaster)
              {                    
                  MktMap.put(mkt.Market__c+mkt.MarketUnit__c+mkt.Country__c,mkt);
              }                    
          }
          else if(projectVal != '' && Prjchk == true &&                    
                  marketVal != PicklistDefaultValues__c.getall().values()[0].Market__c &&
                  marketUnitVal != PicklistDefaultValues__c.getall().values()[0].Market_Unit__c && 
                  countryVal != PicklistDefaultValues__c.getall().values()[0].Country__c && 
                  projectVal != PicklistDefaultValues__c.getall().values()[0].Project__c){
                  
              String mktval = marketVal;
              String mktunitval = marketUnitVal;
              String cntval = countryVal;
              String projval = projectVal;
              
              mktMaster = [Select ID,Market__c,MarketUnit__c,Country__c,Project__c from SPE_ProjectMaster__c where Market__c =: mktval AND MarketUnit__c =: mktunitval
                                  AND Country__c =: cntval AND Project__c =: projval];
                                  
              for(SPE_ProjectMaster__c mkt : mktMaster)
              {                    
                  MktMap.put(mkt.Project__c,mkt);
              }                    
          }
          else if(projectVal != '' && Prjchk == true &&                    
                  marketVal != PicklistDefaultValues__c.getall().values()[0].Market__c &&
                  marketUnitVal != PicklistDefaultValues__c.getall().values()[0].Market_Unit__c && 
                  countryVal != PicklistDefaultValues__c.getall().values()[0].Country__c && 
                  projectVal == PicklistDefaultValues__c.getall().values()[0].Project__c){
                  
              String mktval = marketVal;
              String mktunitval = marketUnitVal;
              String cntval = countryVal;
              
              mktMaster = [Select ID,Market__c,MarketUnit__c,Country__c,Project__c from SPE_ProjectMaster__c where Market__c =: mktval AND MarketUnit__c =: mktunitval
                                  AND Country__c =: cntval AND Project__c != ''];
                                  
              for(SPE_ProjectMaster__c mkt : mktMaster)
              {                    
                  MktMap.put(mkt.Project__c,mkt);
              }                    
          }
          else if(projectVal != '' && Prjchk == true &&                    
                  marketVal != PicklistDefaultValues__c.getall().values()[0].Market__c &&
                  marketUnitVal != PicklistDefaultValues__c.getall().values()[0].Market_Unit__c && 
                  countryVal == PicklistDefaultValues__c.getall().values()[0].Country__c && 
                  projectVal == PicklistDefaultValues__c.getall().values()[0].Project__c){
                  
              String mktval = marketVal;
              String mktunitval = marketUnitVal;
              
              mktMaster = [Select ID,Market__c,MarketUnit__c,Country__c,Project__c from SPE_ProjectMaster__c where Market__c =: mktval AND MarketUnit__c =: mktunitval
                                  AND Country__c != '' AND Project__c != ''];
                                  
              for(SPE_ProjectMaster__c mkt : mktMaster)
              {                    
                  MktMap.put(mkt.Country__c+mkt.Project__c,mkt);
              }                    
          }
          else if(projectVal != '' && Prjchk == true &&                    
                  marketVal != PicklistDefaultValues__c.getall().values()[0].Market__c &&
                  marketUnitVal == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c && 
                  countryVal == PicklistDefaultValues__c.getall().values()[0].Country__c && 
                  projectVal == PicklistDefaultValues__c.getall().values()[0].Project__c){
                  
              String mktval = marketVal;
              
              mktMaster = [Select ID,Market__c,MarketUnit__c,Country__c,Project__c from SPE_ProjectMaster__c where Market__c =: mktval AND MarketUnit__c != ''
                                  AND Country__c != '' AND Project__c != ''];
                                  
              for(SPE_ProjectMaster__c mkt : mktMaster)
              {                    
                  MktMap.put(mkt.MarketUnit__c+mkt.Country__c+mkt.Project__c,mkt);
              }                    
          }
          else if(projectVal != '' && Prjchk == true &&                    
                  marketVal == PicklistDefaultValues__c.getall().values()[0].Market__c &&
                  marketUnitVal == PicklistDefaultValues__c.getall().values()[0].Market_Unit__c && 
                  countryVal == PicklistDefaultValues__c.getall().values()[0].Country__c && 
                  projectVal == PicklistDefaultValues__c.getall().values()[0].Project__c){
                  
              String mktval = marketVal;
              
              mktMaster = [Select ID,Market__c,MarketUnit__c,Country__c,Project__c from SPE_ProjectMaster__c where Market__c != '' AND MarketUnit__c != ''
                                  AND Country__c != '' AND Project__c != ''];
                                  
              for(SPE_ProjectMaster__c mkt : mktMaster)
              {                    
                  MktMap.put(mkt.Market__c+mkt.MarketUnit__c+mkt.Country__c+mkt.Project__c,mkt);
              }                    
          }
          
        //************************All Business Scope Combination for 1D******************//  
          if(buVal != '' && BUchk == true && buVal != PicklistDefaultValues__c.getall().values()[0].Business_Unit__c){              
              String buunitval = buVal ;
              buMaster = [Select ID,BusinessUnit__c,BusinessLine__c,Product__c from SPE_BUBL__c where BusinessUnit__c =: buunitval AND BusinessLine__c != ''
                                 AND Product__c != ''];
              
              for(SPE_BUBL__c bublpro : buMaster)
              {                    
                  BUMap.put(bublpro.BusinessUnit__c,bublpro);
              }                                 
          }
          else if(buVal != '' && BUchk == true && buVal == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c){
              buMaster = [Select ID,BusinessUnit__c,BusinessLine__c,Product__c from SPE_BUBL__c where BusinessUnit__c != '' AND BusinessLine__c != ''
                                 AND Product__c != ''];
              
              for(SPE_BUBL__c bublpro : buMaster)
              {                    
                  BUMap.put(bublpro.BusinessUnit__c,bublpro);
              }
          }
          else if(blVal != '' && BLchk == true && buVal != PicklistDefaultValues__c.getall().values()[0].Business_Unit__c && 
                  blVal != PicklistDefaultValues__c.getall().values()[0].Business_Line__c){
              
              String buunitval = buVal ;
              String bulineval = blVal ;
              
              buMaster = [Select ID,BusinessUnit__c,BusinessLine__c,Product__c from SPE_BUBL__c where BusinessUnit__c =: buunitval AND BusinessLine__c =: bulineval
                                 AND Product__c != ''];
              
              for(SPE_BUBL__c bublpro : buMaster)
              {                    
                  BUMap.put(bublpro.BusinessLine__c,bublpro);
              }                   
          }
          else if(blVal != '' && BLchk == true && buVal != PicklistDefaultValues__c.getall().values()[0].Business_Unit__c && 
                  blVal == PicklistDefaultValues__c.getall().values()[0].Business_Line__c){
              
              String buunitval = buVal ;
              
              buMaster = [Select ID,BusinessUnit__c,BusinessLine__c,Product__c from SPE_BUBL__c where BusinessUnit__c =: buunitval AND BusinessLine__c != ''
                                 AND Product__c != ''];
              
              for(SPE_BUBL__c bublpro : buMaster)
              {                    
                  BUMap.put(bublpro.BusinessLine__c,bublpro);
              }                   
          }
          else if(blVal != '' && BLchk == true && buVal == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c && 
                  blVal == PicklistDefaultValues__c.getall().values()[0].Business_Line__c){
              
              buMaster = [Select ID,BusinessUnit__c,BusinessLine__c,Product__c from SPE_BUBL__c where BusinessUnit__c != '' AND BusinessLine__c != ''
                                 AND Product__c != ''];
              
              for(SPE_BUBL__c bublpro : buMaster)
              {                    
                  BUMap.put(bublpro.BusinessUnit__c+bublpro.BusinessLine__c,bublpro);
              }                   
          }
          else if(prdVal != '' && Prodchk == true && buVal != PicklistDefaultValues__c.getall().values()[0].Business_Unit__c && 
                  blVal != PicklistDefaultValues__c.getall().values()[0].Business_Line__c && 
                  prdVal != PicklistDefaultValues__c.getall().values()[0].Product__c){
              
              String buunitval = buVal ;
              String bulineval = blVal ;
              String prodval = prdVal ;
              
              buMaster = [Select ID,BusinessUnit__c,BusinessLine__c,Product__c from SPE_BUBL__c where BusinessUnit__c =: buunitval AND BusinessLine__c =: bulineval
                                 AND Product__c =: prodval];
              
              for(SPE_BUBL__c bublpro : buMaster)
              {                    
                  BUMap.put(bublpro.Product__c,bublpro);
              }                   
          }
          else if(prdVal != '' && Prodchk == true && buVal != PicklistDefaultValues__c.getall().values()[0].Business_Unit__c && 
                  blVal != PicklistDefaultValues__c.getall().values()[0].Business_Line__c && 
                  prdVal == PicklistDefaultValues__c.getall().values()[0].Product__c){
              
              String buunitval = buVal ;
              String bulineval = blVal ;
              
              buMaster = [Select ID,BusinessUnit__c,BusinessLine__c,Product__c from SPE_BUBL__c where BusinessUnit__c =: buunitval AND BusinessLine__c =: bulineval
                                 AND Product__c != ''];
              
              for(SPE_BUBL__c bublpro : buMaster)
              {                    
                  BUMap.put(bublpro.Product__c,bublpro);
              }                   
          }
          else if(prdVal != '' && Prodchk == true && buVal != PicklistDefaultValues__c.getall().values()[0].Business_Unit__c && 
                  blVal == PicklistDefaultValues__c.getall().values()[0].Business_Line__c && 
                  prdVal == PicklistDefaultValues__c.getall().values()[0].Product__c){
              
              String buunitval = buVal ;
              
              buMaster = [Select ID,BusinessUnit__c,BusinessLine__c,Product__c from SPE_BUBL__c where BusinessUnit__c =: buunitval AND BusinessLine__c != ''
                                 AND Product__c != ''];
              
              for(SPE_BUBL__c bublpro : buMaster)
              {                    
                  BUMap.put(bublpro.BusinessLine__c+bublpro.Product__c,bublpro);
              }                   
          }
          else if(prdVal != '' && Prodchk == true && buVal == PicklistDefaultValues__c.getall().values()[0].Business_Unit__c && 
                  blVal == PicklistDefaultValues__c.getall().values()[0].Business_Line__c && 
                  prdVal == PicklistDefaultValues__c.getall().values()[0].Product__c){
                            
              buMaster = [Select ID,BusinessUnit__c,BusinessLine__c,Product__c from SPE_BUBL__c where BusinessUnit__c != '' AND BusinessLine__c != ''
                                 AND Product__c != ''];
              
              for(SPE_BUBL__c bublpro : buMaster)
              {                    
                  BUMap.put(bublpro.BusinessUnit__c+bublpro.BusinessLine__c+bublpro.Product__c,bublpro);
              }                   
          }
          
          System.Debug(LoggingLevel.ERROR,'##########CatAreaMap.size()*MktMap.size()############'+CatAreaMap.size()*MktMap.size());
          System.Debug(LoggingLevel.ERROR,'##########BUMap.size()*MktMap.size()############'+BUMap.size()*MktMap.size());
          System.Debug(LoggingLevel.ERROR,'##########BUMap.size()############'+BUMap.size());
          System.Debug(LoggingLevel.ERROR,'##########MktMap.size()############'+MktMap.size());
          System.Debug(LoggingLevel.ERROR,'##########CatAreaMap.size()############'+CatAreaMap.size());
          System.Debug(LoggingLevel.ERROR,'##########BUMap.size()*CatAreaMap.size()############'+BUMap.size()*CatAreaMap.size());
          System.Debug(LoggingLevel.ERROR,'##########MktMap.size()*BUMap.size()*CatAreaMap.size()############'+MktMap.size()*BUMap.size()*CatAreaMap.size());
          
         //*******************************SPE Plan Generation for 1D Map*********************************// 
          if((CatAreaMap.size() > 0 && MktMap.isEmpty() && BUMap.isEmpty()) && CatAreaMap.size() < 10000){
              for(SPE_CategoryMaster__c scat : CatAreaMap.Values()){
                  if(CatAreachk == true){
                      SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                      speScopePlan.SPEPlanName__c = scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE;
                      speScopePlan.CategoryCluster__c = scat.Cluster__c;
                      speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                      speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                      speScopePlan.Region__c = SPE_Constants.ALL_GEOSCOPE;                      
                      speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                      speScopePlan.Country__c = SPE_Constants.ALL_Country;
                      speScopePlan.Project__c = SPE_Constants.ALL_Project;
                      speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                      speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                      speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                      speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                      speplanListdisplay.add(speScopePlan);
                  }
                  else if(CatGrpchk == true){
                      SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                      speScopePlan.SPEPlanName__c = scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE;
                      speScopePlan.CategoryCluster__c = scat.Cluster__c;
                      speScopePlan.CategoryGroup__c = scat.Group__c;
                      speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                      speScopePlan.Region__c = SPE_Constants.ALL_GEOSCOPE;
                      speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                      speScopePlan.Country__c = SPE_Constants.ALL_Country;
                      speScopePlan.Project__c = SPE_Constants.ALL_Project;
                      speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                      speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                      speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                      speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                      speplanListdisplay.add(speScopePlan);
                  }
                  else if(Catchk == true){
                      SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                      speScopePlan.SPEPlanName__c = scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c;
                      speScopePlan.CategoryCluster__c = scat.Cluster__c;
                      speScopePlan.CategoryGroup__c = scat.Group__c;
                      speScopePlan.Category__c = scat.Category__c;
                      speScopePlan.Region__c = SPE_Constants.ALL_GEOSCOPE;
                      speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                      speScopePlan.Country__c = SPE_Constants.ALL_Country;
                      speScopePlan.Project__c = SPE_Constants.ALL_Project;
                      speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                      speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                      speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                      speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                      speplanListdisplay.add(speScopePlan);
                  } 
              }
              
              for(SPE_SPEPlan__c spl : speplanListdisplay){
                  SPEPlanWrapper spewrap = new SPEPlanWrapper();
                  spewrap.isSelected = true;
                  spewrap.scpl = spl;
                  speplanwrapperListdisplay.add(spewrap);
              }
          }
          else if((CatAreaMap.isEmpty() && MktMap.size() > 0 && BUMap.isEmpty()) && MktMap.size() < 10000){
              for(SPE_ProjectMaster__c mkt : MktMap.Values()){
                  if(Mktchk == true){
                      SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                      speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project;
                      speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                      speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                      speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                      speScopePlan.Region__c = mkt.Market__c;
                      speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                      speScopePlan.Country__c = SPE_Constants.ALL_Country;
                      speScopePlan.Project__c = SPE_Constants.ALL_Project;
                      speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                      speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                      speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                      speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                      speplanListdisplay.add(speScopePlan);
                  }
                  else if(MktUnitchk == true){
                      SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                      speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project;
                      speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                      speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                      speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                      speScopePlan.Region__c = mkt.Market__c;
                      speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                      speScopePlan.Country__c = SPE_Constants.ALL_Country;
                      speScopePlan.Project__c = SPE_Constants.ALL_Project;
                      speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                      speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                      speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                      speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                      speplanListdisplay.add(speScopePlan);
                  }
                  else if(Countchk == true){
                      SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                      speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project;
                      speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                      speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                      speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                      speScopePlan.Region__c = mkt.Market__c;
                      speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                      speScopePlan.Country__c = mkt.Country__c;
                      speScopePlan.Project__c = SPE_Constants.ALL_Project;
                      speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                      speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                      speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                      speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                      speplanListdisplay.add(speScopePlan);
                  }
                  else if(Prjchk == true){
                      SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                      speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c;
                      speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                      speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                      speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                      speScopePlan.Region__c = mkt.Market__c;
                      speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                      speScopePlan.Country__c = mkt.Country__c;
                      speScopePlan.Project__c = mkt.Project__c;
                      speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                      speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                      speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                      speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                      speplanListdisplay.add(speScopePlan);
                  } 
              }
              
              for(SPE_SPEPlan__c spl : speplanListdisplay){
                  SPEPlanWrapper spewrap = new SPEPlanWrapper();
                  spewrap.isSelected = true;
                  spewrap.scpl = spl;
                  speplanwrapperListdisplay.add(spewrap);
              }                            
          }
          else if((CatAreaMap.isEmpty() && MktMap.isEmpty() && BUMap.size()> 0) && BUMap.size() < 10000){
              for(SPE_BUBL__c bu : BUMap.Values()){
                  if(BUchk == true){
                      SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                      speScopePlan.SPEPlanName__c = bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                      speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                      speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                      speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                      speScopePlan.Region__c = SPE_Constants.ALL_GEOSCOPE;
                      speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                      speScopePlan.Country__c = SPE_Constants.ALL_Country;
                      speScopePlan.Project__c = SPE_Constants.ALL_Project;
                      speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                      speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                      speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                      speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                      speplanListdisplay.add(speScopePlan);
                  }
                  else if(BLchk == true){
                      SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                      speScopePlan.SPEPlanName__c = bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                      speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                      speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                      speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                      speScopePlan.Region__c = SPE_Constants.ALL_GEOSCOPE;
                      speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                      speScopePlan.Country__c = SPE_Constants.ALL_Country;
                      speScopePlan.Project__c = SPE_Constants.ALL_Project;
                      speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                      speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                      speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                      speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                      speplanListdisplay.add(speScopePlan);
                  }
                  else if(Prodchk == true){
                      SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                      speScopePlan.SPEPlanName__c = bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                      speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                      speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                      speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                      speScopePlan.Region__c = SPE_Constants.ALL_GEOSCOPE;
                      speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                      speScopePlan.Country__c = SPE_Constants.ALL_Country;
                      speScopePlan.Project__c = SPE_Constants.ALL_Project;
                      speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                      speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                      speScopePlan.Product__c = bu.Product__c;
                      speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                      speplanListdisplay.add(speScopePlan);
                  } 
              }
              
              for(SPE_SPEPlan__c spl : speplanListdisplay){
                  SPEPlanWrapper spewrap = new SPEPlanWrapper();
                  spewrap.isSelected = true;
                  spewrap.scpl = spl;
                  speplanwrapperListdisplay.add(spewrap);
              }
          }
          //****************************END 1D Map*****************************************//
          
          //**********************************SPE Plan Generation for 2D*****************************//
                    
          else if((CatAreaMap.isEmpty() && MktMap.size() > 0 && BUMap.size() > 0) && (BUMap.size()*MktMap.size() < 10000)){
              for(SPE_BUBL__c bu : BUMap.Values()){
                  for(SPE_ProjectMaster__c mkt : MktMap.Values()){
                      if(BUchk == true && Mktchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(BLchk == true && Mktchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(Prodchk == true && Mktchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                          speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                          speScopePlan.Product__c = bu.Product__c;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(BUchk == true && MktUnitchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(BLchk == true && MktUnitchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(Prodchk == true && MktUnitchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                          speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                          speScopePlan.Product__c = bu.Product__c;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(BUchk == true && Countchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = mkt.Country__c;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(BLchk == true && Countchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = mkt.Country__c;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(Prodchk == true && Countchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                          speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = mkt.Country__c;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                          speScopePlan.Product__c = bu.Product__c;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(BUchk == true && Prjchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = mkt.Country__c;
                          speScopePlan.Project__c = mkt.Project__c;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(BLchk == true && Prjchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = mkt.Country__c;
                          speScopePlan.Project__c = mkt.Project__c;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(Prodchk == true && Prjchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                          speScopePlan.CategoryCluster__c = SPE_Constants.ALL_CATSCOPE_AREA;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = mkt.Country__c;
                          speScopePlan.Project__c = mkt.Project__c;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                          speScopePlan.Product__c = bu.Product__c;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                  } 
              }
              
              for(SPE_SPEPlan__c spl : speplanListdisplay){
                  SPEPlanWrapper spewrap = new SPEPlanWrapper();
                  spewrap.isSelected = true;
                  spewrap.scpl = spl;
                  speplanwrapperListdisplay.add(spewrap);
              }
          }
          else if((CatAreaMap.size() > 0 && MktMap.size() > 0 && BUMap.isEmpty()) && (CatAreaMap.size()*MktMap.size() < 10000)){
              for(SPE_CategoryMaster__c scat : CatAreaMap.Values()){
                  for(SPE_ProjectMaster__c mkt : MktMap.Values()){
                      if(CatAreachk == true && Mktchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(CatGrpchk == true && Mktchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = scat.Group__c;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(Catchk == true && Mktchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = scat.Group__c;
                          speScopePlan.Category__c = scat.Category__c;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(CatAreachk == true && MktUnitchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(CatGrpchk == true && MktUnitchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = scat.Group__c;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(Catchk == true && MktUnitchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = scat.Group__c;
                          speScopePlan.Category__c = scat.Category__c;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(CatAreachk == true && Countchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = mkt.Country__c;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(CatGrpchk == true && Countchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = scat.Group__c;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = mkt.Country__c;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(Catchk == true && Countchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = scat.Group__c;
                          speScopePlan.Category__c = scat.Category__c;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = mkt.Country__c;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(CatAreachk == true && Prjchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = mkt.Country__c;
                          speScopePlan.Project__c = mkt.Project__c;
                          speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(CatGrpchk == true && Prjchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = scat.Group__c;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = mkt.Country__c;
                          speScopePlan.Project__c = mkt.Project__c;
                          speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(Catchk == true && Prjchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = scat.Group__c;
                          speScopePlan.Category__c = scat.Category__c;
                          speScopePlan.Region__c = mkt.Market__c;
                          speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                          speScopePlan.Country__c = mkt.Country__c;
                          speScopePlan.Project__c = mkt.Project__c;
                          speScopePlan.BusinessUnit__c = SPE_Constants.ALL_BU_BUSCOPE;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                  } 
              }
              
              for(SPE_SPEPlan__c spl : speplanListdisplay){
                  SPEPlanWrapper spewrap = new SPEPlanWrapper();
                  spewrap.isSelected = true;
                  spewrap.scpl = spl;
                  speplanwrapperListdisplay.add(spewrap);
              }
          }
          else if((CatAreaMap.size() > 0 && MktMap.isEmpty() && BUMap.size() > 0) && (BUMap.size()*CatAreaMap.size() < 10000)){
              for(SPE_BUBL__c bu : BUMap.Values()){
                  for(SPE_CategoryMaster__c scat : CatAreaMap.Values()){
                      if(BUchk == true && CatAreachk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;                          
                          speScopePlan.Region__c = SPE_Constants.ALL_GEOSCOPE;                          
                          speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(BLchk == true && CatAreachk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = SPE_Constants.ALL_GEOSCOPE;
                          speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(Prodchk == true && CatAreachk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = SPE_Constants.ALL_GEOSCOPE;
                          speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                          speScopePlan.Product__c = bu.Product__c;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(BUchk == true && CatGrpchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = scat.Group__c;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = SPE_Constants.ALL_GEOSCOPE;
                          speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(BLchk == true && CatGrpchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = scat.Group__c;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = SPE_Constants.ALL_GEOSCOPE;
                          speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(Prodchk == true && CatGrpchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = scat.Group__c;
                          speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                          speScopePlan.Region__c = SPE_Constants.ALL_GEOSCOPE;
                          speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                          speScopePlan.Product__c = bu.Product__c;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(BUchk == true && Catchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = scat.Group__c;
                          speScopePlan.Category__c = scat.Category__c;
                          speScopePlan.Region__c = SPE_Constants.ALL_GEOSCOPE;
                          speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(BLchk == true && Catchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = scat.Group__c;
                          speScopePlan.Category__c = scat.Category__c;
                          if(isMktDisable == False){
                              speScopePlan.Region__c = SPE_Constants.ALL_GEOSCOPE;
                          }else if(isMktDisable == True){
                              speScopePlan.Region__c = scoringTemplatescope.Region__c;
                          }
                          speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                          speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                      else if(Prodchk == true && Catchk == true){
                          SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                          speScopePlan.SPEPlanName__c = scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                          speScopePlan.CategoryCluster__c = scat.Cluster__c;
                          speScopePlan.CategoryGroup__c = scat.Group__c;
                          speScopePlan.Category__c = scat.Category__c;
                          if(isMktDisable == False){
                              speScopePlan.Region__c = SPE_Constants.ALL_GEOSCOPE;
                          }else if(isMktDisable == True){
                              speScopePlan.Region__c = scoringTemplatescope.Region__c;
                          }
                          speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                          speScopePlan.Country__c = SPE_Constants.ALL_Country;
                          speScopePlan.Project__c = SPE_Constants.ALL_Project;
                          speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                          speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                          speScopePlan.Product__c = bu.Product__c;
                          speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                          speplanListdisplay.add(speScopePlan);
                      }
                  } 
              }
              
              for(SPE_SPEPlan__c spl : speplanListdisplay){
                  SPEPlanWrapper spewrap = new SPEPlanWrapper();
                  spewrap.isSelected = true;
                  spewrap.scpl = spl;
                  speplanwrapperListdisplay.add(spewrap);
              }
          }
          //************************************END of 2D Map*************************************//
          
          //*******************************SPE Plan Generation for 3D Map*********************************//          
          else if(CatAreaMap.size() > 0 && MktMap.size() > 0 && BUMap.size() > 0 
                                  && (CatAreaMap.size()*MktMap.size()*BUMap.size() < 10000)){
              for(SPE_CategoryMaster__c scat : CatAreaMap.Values()){
                  if(CatAreachk == true){
                      for(SPE_BUBL__c bu : BUMap.Values()){
                          for(SPE_ProjectMaster__c mkt : MktMap.Values()){
                              if(BUchk == true && Mktchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BLchk == true && Mktchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(Prodchk == true && Mktchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = bu.Product__c;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BUchk == true && MktUnitchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BLchk == true && MktUnitchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(Prodchk == true && MktUnitchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = bu.Product__c;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BUchk == true && Countchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BLchk == true && Countchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(Prodchk == true && Countchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = bu.Product__c;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BUchk == true && Prjchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = mkt.Project__c;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BLchk == true && Prjchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = mkt.Project__c;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(Prodchk == true && Prjchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c+'_'+scat.Cluster__c+'_'+SPE_Constants.ALL_CATSCOPE_GROUP+'_'+SPE_Constants.ALL_CATSCOPE+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = SPE_Constants.ALL_CATSCOPE_GROUP;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = mkt.Project__c;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = bu.Product__c;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                          }
                      }                  
                  }
                  else if(CatGrpchk == true){
                      for(SPE_BUBL__c bu : BUMap.Values()){
                          for(SPE_ProjectMaster__c mkt : MktMap.Values()){
                              if(BUchk == true && Mktchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BLchk == true && Mktchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(Prodchk == true && Mktchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = bu.Product__c;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BUchk == true && MktUnitchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BLchk == true && MktUnitchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(Prodchk == true && MktUnitchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = bu.Product__c;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BUchk == true && Countchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BLchk == true && Countchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(Prodchk == true && Countchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = bu.Product__c;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BUchk == true && Prjchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = mkt.Project__c;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BLchk == true && Prjchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = mkt.Project__c;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(Prodchk == true && Prjchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+SPE_Constants.ALL_CATSCOPE+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = SPE_Constants.ALL_CATSCOPE;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = mkt.Project__c;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = bu.Product__c;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                          }
                      }                  
                  }
                  else if(Catchk == true){
                      for(SPE_BUBL__c bu : BUMap.Values()){
                          for(SPE_ProjectMaster__c mkt : MktMap.Values()){
                              if(BUchk == true && Mktchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = scat.Category__c;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BLchk == true && Mktchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = scat.Category__c;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(Prodchk == true && Mktchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+SPE_Constants.ALL_GEOSCOPE_UNIT+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = scat.Category__c;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = SPE_Constants.ALL_GEOSCOPE_UNIT;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = bu.Product__c;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BUchk == true && MktUnitchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = scat.Category__c;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BLchk == true && MktUnitchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = scat.Category__c;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(Prodchk == true && MktUnitchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+SPE_Constants.ALL_Country+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = scat.Category__c;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = SPE_Constants.ALL_Country;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = bu.Product__c;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BUchk == true && Countchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = scat.Category__c;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BLchk == true && Countchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = scat.Category__c;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(Prodchk == true && Countchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+SPE_Constants.ALL_Project+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = scat.Category__c;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = SPE_Constants.ALL_Project;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = bu.Product__c;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BUchk == true && Prjchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c+'_'+bu.BusinessUnit__c+'_'+SPE_Constants.ALL_BL_BUSCOPE+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = scat.Category__c;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = mkt.Project__c;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = SPE_Constants.ALL_BL_BUSCOPE;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(BLchk == true && Prjchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = scat.Category__c;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = mkt.Project__c;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = SPE_Constants.ALL_BUSCOPE;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                              else if(Prodchk == true && Prjchk == true){
                                  SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
                                  speScopePlan.SPEPlanName__c = mkt.Market__c+'_'+mkt.MarketUnit__c+'_'+mkt.Country__c+'_'+mkt.Project__c+'_'+scat.Cluster__c+'_'+scat.Group__c+'_'+scat.Category__c+'_'+bu.BusinessUnit__c+'_'+bu.BusinessLine__c+'_'+bu.Product__c;
                                  speScopePlan.CategoryCluster__c = scat.Cluster__c;
                                  speScopePlan.CategoryGroup__c = scat.Group__c;
                                  speScopePlan.Category__c = scat.Category__c;
                                  speScopePlan.Region__c = mkt.Market__c;
                                  speScopePlan.SubRegion__c = mkt.MarketUnit__c;
                                  speScopePlan.Country__c = mkt.Country__c;
                                  speScopePlan.Project__c = mkt.Project__c;
                                  speScopePlan.BusinessUnit__c = bu.BusinessUnit__c;
                                  speScopePlan.BusinessLine__c = bu.BusinessLine__c;
                                  speScopePlan.Product__c = bu.Product__c;
                                  speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
                                  speplanListdisplay.add(speScopePlan);
                              }
                          }
                      }                  
                  }
              }    
              for(SPE_SPEPlan__c spl : speplanListdisplay){
                  SPEPlanWrapper spewrap = new SPEPlanWrapper();
                  spewrap.isSelected = true;
                  spewrap.scpl = spl;
                  speplanwrapperListdisplay.add(spewrap);
              }  
          }
              
       //****************************************END of 3D Map********************************************//
              
              else if(CatAreaMap.size()*MktMap.size()*BUMap.size() > 10000 || CatAreaMap.size()*MktMap.size() > 10000 ||
                      MktMap.size()*BUMap.size() > 10000 || CatAreaMap.size()*BUMap.size() > 10000 || CatAreaMap.size() > 10000 ||
                      MktMap.size() > 10000 || BUMap.size() > 10000){
                  
                  hasRecords = false;
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Warning, 'Total Number of records are more than 10000'));
              }                                                        
              else if(speplanListdisplay.size() == 0)
              {                          
                  if(isMktDisable == true && isMktUnitDisable == true && isCountryDisable == true && isProjDisable == true &&
                      isBUUnitDisable == true && isBULineDisable == true && isProdDisable == true &&
                      isCatAreaDisable == true && isCatGrpDisable == true && isCatDisable == true){          
                      Alldisable = true;
                  }
                  else{
                      hasRecords = false;
                      pageNumber = 0;
                      maxPages = 0;
                      supplistsize = 0;
                      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'No records to display'));
                  }
              }   
       }
       public Pagereference StartEndDateCalculation(){
            Map<String,Integer> mapMonthName = new Map<String,Integer>();
                     
            mapMonthName.put('January',1);
            mapMonthName.put('February',2);
            mapMonthName.put('March',3);
            mapMonthName.put('April',4);
            mapMonthName.put('May',5);
            mapMonthName.put('June',6);
            mapMonthName.put('July',7);
            mapMonthName.put('August',8);
            mapMonthName.put('September',9);
            mapMonthName.put('October',10);
            mapMonthName.put('November',11);
            mapMonthName.put('December',12);
            
            isError5 = False;
            isError6 = False;
        
            new_st_date = Date.newinstance(1960, 1, 1);
            new_end_date = Date.newinstance(1960, 1, 1);
            fiveyearsdate = Date.newinstance(1960, 1, 1);
            
            if(spePlan.Start_Month__c == null || spePlan.Start_Year__c == null)
            {   
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please Provide Start Month and Year'));
               isError5 = true;
               new_st_date = null;
               return null;
            }
            if(spePlan.End_Month__c == null || spePlan.End_Year__c == null)
            {   
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please Provide End Month and Year'));
              isError6 = true;
              new_end_date = null;
              return null;
            }
            
            if(spePlan.End_Month__c != '' && spePlan.End_Year__c != ''){
                new_end_date = Date.NewInstance(Integer.ValueOf(spePlan.End_Year__c),mapMonthName.get(spePlan.End_Month__c),1);
                new_end_date = new_end_date.addMonths(1);
                new_end_date = new_end_date.addDays(-1);
                spePlan.EndDate__c = new_end_date;
            }
            
            kpiDay = Date.newinstance(1960, 1, 1);
            Integer monthvalue = System.Today().Month();
            
            Id templateId = scoringTemplatescope.SPETemplate__c;
            List<SPE_SPEKPIMap__c> speKPIMapList = [SELECT Id,SPETemplate__c,KPIDefinition__c,KPIDefinition__r.ScheduledDate__c,
                                                    KPIDefinition__r.PI_Data__c,KPIDefinition__r.PI_Data__r.DataAcquisitionMethod__c,
                                                    KPIDefinition__r.PI_Data__r.ValuesType__c,
                                                    KPIDefinition__r.PI_Data__r.PIUploadDuedate__c from SPE_SPEKPIMap__c where SPETemplate__c =: templateId];
                            
            Set<ID> kpiID = new Set<ID>();
            for (SPE_SPEKPIMap__c speKPIMap : speKPIMapList)
            {  
                kpiID.add(speKPIMap.KPIDefinition__c);
                if (speKPIMap.KPIDefinition__r.ScheduledDate__c != null && monthvalue == speKPIMap.KPIDefinition__r.ScheduledDate__c.Month())
                {                    
                    if(speKPIMap.KPIDefinition__r.ScheduledDate__c > kpiDay){
                        kpiDay = speKPIMap.KPIDefinition__r.ScheduledDate__c;
                    }                               
                }
            }
            List<SPE_KPICalculation__c> kpiCals = [Select Id,PIDefination__c,PIDefination__r.DataAcquisitionMethod__c,
                                                      PIDefination__r.PIUploadDuedate__c,KPIDefinition__c,KPIDefinition__r.ScheduledDate__c,
                                                      KPIDefinition__r.FrequencyinMonth__c,PIDefination__r.Frequency__c,
                                                      PrevKPIDefination__c,PrevKPIDefination__r.ScheduledDate__c,PrevKPIDefination__r.FrequencyinMonth__c
                                                      From SPE_KPICalculation__c 
                                                      Where KPIDefinition__c IN : kpiID AND PIDefination__r.DataAcquisitionMethod__c = 'Data Load'];
            
            if(new_st_date == Date.newinstance(1960, 1, 1) && kpiCals.size() > 0){
                for(SPE_KPICalculation__c kp: kpiCals){
                   if(kp.PIDefination__r.PIUploadDuedate__c != null && mapMonthName.get(spePlan.Start_Month__c) == kp.PIDefination__r.PIUploadDuedate__c.Month() && Integer.ValueOf(spePlan.Start_Year__c) == kp.PIDefination__r.PIUploadDuedate__c.Year()){
                       if(kp.PIDefination__r.PIUploadDuedate__c > new_st_date){
                           new_st_date = kp.PIDefination__r.PIUploadDuedate__c;
                       }
                    } 
                }
            }
            
            for (SPE_SPEKPIMap__c speKPIMap : speKPIMapList)
            {  
                if(speKPIMap.KPIDefinition__r.PI_Data__c != null && speKPIMap.KPIDefinition__r.PI_Data__r.DataAcquisitionMethod__c == 'Data Load' 
                    && speKPIMap.KPIDefinition__r.PI_Data__r.ValuesType__c == 'Number' && speKPIMap.KPIDefinition__r.PI_Data__r.PIUploadDuedate__c != Null 
                    && monthvalue == speKPIMap.KPIDefinition__r.PI_Data__r.PIUploadDuedate__c.Month())
                {                    
                    if(speKPIMap.KPIDefinition__r.PI_Data__r.PIUploadDuedate__c > new_st_date){
                        new_st_date = speKPIMap.KPIDefinition__r.PI_Data__r.PIUploadDuedate__c;
                    }                               
                }
            }
            
            if(spePlan.Additional_Days__c != Null){
                Integer additional_days = Integer.ValueOf(spePlan.Additional_Days__c);
                new_st_date = new_st_date.addDays(additional_days);
            }
            
            if(new_st_date < new_end_date){
                fiveyearsdate = new_st_date.addYears(5);
                spePlan.StartDate__c = new_st_date;
            }
            else if(new_st_date > new_end_date && new_st_date >= System.Today()){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Start Date cannot be greater than End Day'));
                return null;
            }
            
            if(new_st_date == Date.newinstance(1960, 1, 1) || kpiCals.size() == 0 || new_st_date == Date.newinstance(1960, 1, 1).addDays(Integer.ValueOf(spePlan.Additional_Days__c))){
                if(spePlan.Start_Month__c != '' && spePlan.Start_Year__c != '' ){
                    new_st_date = Date.NewInstance(Integer.ValueOf(spePlan.Start_Year__c),mapMonthName.get(spePlan.Start_Month__c),1);
                    fiveyearsdate = new_st_date.addYears(5);
                    spePlan.StartDate__c = new_st_date;
                }
            }                                          
            
            if(kpiDay == Date.newinstance(1960, 1, 1)){
               for (SPE_SPEKPIMap__c speKPIMap : speKPIMapList )
                {  
                    if (speKPIMap.KPIDefinition__r.ScheduledDate__c != null && monthvalue < speKPIMap.KPIDefinition__r.ScheduledDate__c.Month())
                    {
                        if(speKPIMap.KPIDefinition__r.ScheduledDate__c > kpiDay){
                            kpiDay = speKPIMap.KPIDefinition__r.ScheduledDate__c;
                        }                                   
                    }
                }
            }
                    
            if(spePlan.Additional_Days__c != Null){
                Integer additional_days = Integer.ValueOf(spePlan.Additional_Days__c);
                kpiDay = kpiDay.addDays(additional_days);
            }
            if(monthvalue < kpiDay.Month() && kpiDay > new_end_date){
                String displaydate = kpiDay.Day()+'/'+kpiDay.Month()+'/'+kpiDay.Year();
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Next Computed Day:'+displaydate+' cannot be greater than End Day'));
                return null;
            }       
            
            
            if(kpiDay < new_end_date && kpiDay >= System.Today() && kpiDay > new_st_date){            
                spePlan.Next_Computed_Day__c = kpiday;
            }
            else if(kpiDay < new_end_date && kpiDay >= System.Today() && kpiDay < new_st_date){            
                //spePlan.Next_Computed_Day__c = new_st_date;
                Date calNCD = Date.NewInstance(new_st_date.Year(),new_st_date.Month(),kpiday.Day());
                if(calNCD >= new_st_date){
                    spePlan.Next_Computed_Day__c = calNCD;
                }
                else{            
                    spePlan.Next_Computed_Day__c = new_st_date;
                }
            }        
            else if(kpiDay < new_end_date && kpiDay < System.Today()){
                //Integer additional_days = Integer.ValueOf(spePlan.Additional_Days__c);
                //spePlan.Next_Computed_Day__c = new_st_date;
                Date calNCD = Date.NewInstance(new_st_date.Year(),new_st_date.Month(),kpiday.Day());
                if(calNCD >= new_st_date){
                    spePlan.Next_Computed_Day__c = calNCD;
                }
                else{            
                    spePlan.Next_Computed_Day__c = new_st_date;
                }
            }        
            else if(kpiDay > new_end_date && kpiDay >= System.Today()){
                String displaydate = kpiDay.Day()+'/'+kpiDay.Month()+'/'+kpiDay.Year();
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Next Computed Day:'+displaydate+' cannot be greater than End Day'));
                return null;
            }
            return null;
       }
       public void finalSPEPlan(){
           List<SPEPlanWrapper> Tempspeplanwrapper = new List<SPEPlanWrapper>();
           createSPEPlan();
           StartEndDateCalculation();
           if(speplanwrapperListdisplay.size()>0){
               for(SPEPlanWrapper spp : speplanwrapperListdisplay){
                   if(isMktDisable == True){
                       spp.scpl.Region__c = scoringTemplatescope.Region__c;
                   }                   
                   if(isMktUnitDisable == True){
                       spp.scpl.SubRegion__c = scoringTemplatescope.SubRegion__c;
                   }
                   if(isCountryDisable == True){
                       spp.scpl.Country__c = scoringTemplatescope.Country__c;
                   }
                   if(isProjDisable == True){
                       spp.scpl.Project__c = scoringTemplatescope.Project__c;
                   }
                   if(isBUUnitDisable == True){
                       spp.scpl.BusinessUnit__c = scoringTemplatescope.BusinessUnit__c;
                   }
                   if(isBULineDisable == True){
                       spp.scpl.BusinessLine__c = scoringTemplatescope.BusinessLine__c;
                   }
                   if(isProdDisable == True){
                       spp.scpl.Product__c = scoringTemplatescope.Product__c;
                   }
                   if(isCatAreaDisable == True){
                       spp.scpl.CategoryCluster__c = scoringTemplatescope.CategoryCluster__c;
                   }
                   if(isCatGrpDisable == True){
                       spp.scpl.CategoryGroup__c = scoringTemplatescope.CategoryGroup__c;
                   }
                   if(isCatDisable == True){
                       spp.scpl.Category__c = scoringTemplatescope.Category__c;
                   }
                   spp.scpl.SPETemplate__c = scoringTemplatescope.SPETemplate__c;
                   spp.scpl.StartDate__c = spePlan.StartDate__c;
                   spp.scpl.EndDate__c = spePlan.EndDate__c;
                   spp.scpl.Next_Computed_Day__c = spePlan.Next_Computed_Day__c;
                   spp.scpl.FrequencyInMonths__c = spePlan.FrequencyInMonths__c;
                   spp.scpl.AggregationDuration__c = spePlan.AggregationDuration__c;
                   spp.scpl.Additional_Days__c = spePlan.Additional_Days__c;
                   spp.scpl.Start_Month__c = spePlan.Start_Month__c;
                   spp.scpl.Start_Year__c = spePlan.Start_Year__c;
                   spp.scpl.End_Month__c = spePlan.End_Month__c;
                   spp.scpl.End_Year__c = spePlan.End_Year__c;
                   spp.scpl.SurveyExecutionBeforeIndays__c = spePlan.SurveyExecutionBeforeIndays__c;
                   spp.scpl.SurveyReminderBeforeExecutionDate__c = spePlan.SurveyReminderBeforeExecutionDate__c;
                   spp.scpl.Organization_Group__c = spePlan.Organization_Group__c;
                   spp.scpl.OwnerId = UserInfo.getUserId();
                   spp.scpl.Plan_Identifier__c = PlanIdentifier;
                   Tempspeplanwrapper.add(spp);
               }
           }
           else if(speplanwrapperListdisplay.size() == 0 && Alldisable == true){
               SPE_SPEPlan__c speScopePlan = new SPE_SPEPlan__c();
               speScopePlan.SPEPlanName__c = scoringTemplatescope.Region__c+'_'+scoringTemplatescope.SubRegion__c+'_'+scoringTemplatescope.Country__c+'_'+scoringTemplatescope.Project__c+'_'+scoringTemplatescope.CategoryCluster__c+'_'+scoringTemplatescope.CategoryGroup__c+'_'+scoringTemplatescope.Category__c+'_'+scoringTemplatescope.BusinessUnit__c+'_'+scoringTemplatescope.BusinessLine__c+'_'+scoringTemplatescope.Product__c;
               speScopePlan.CategoryCluster__c = scoringTemplatescope.CategoryCluster__c;
               speScopePlan.CategoryGroup__c = scoringTemplatescope.CategoryGroup__c;
               speScopePlan.Category__c = scoringTemplatescope.Category__c;
               speScopePlan.Region__c = scoringTemplatescope.Region__c;
               speScopePlan.SubRegion__c = scoringTemplatescope.SubRegion__c;
               speScopePlan.Country__c = scoringTemplatescope.Country__c;
               speScopePlan.Project__c = scoringTemplatescope.Project__c;
               speScopePlan.BusinessUnit__c = scoringTemplatescope.BusinessUnit__c;
               speScopePlan.BusinessLine__c = scoringTemplatescope.BusinessLine__c;
               speScopePlan.Product__c = scoringTemplatescope.Product__c;
               speScopePlan.SPEScoringTemplate__c = scoringtemplateId;
               speScopePlan.SPETemplate__c = scoringTemplatescope.SPETemplate__c;
               speScopePlan.StartDate__c = spePlan.StartDate__c;
               speScopePlan.EndDate__c = spePlan.EndDate__c;
               speScopePlan.Start_Month__c = spePlan.Start_Month__c;
               speScopePlan.Start_Year__c = spePlan.Start_Year__c;
               speScopePlan.End_Month__c = spePlan.End_Month__c;
               speScopePlan.End_Year__c = spePlan.End_Year__c;
               speScopePlan.Next_Computed_Day__c = spePlan.Next_Computed_Day__c;
               speScopePlan.FrequencyInMonths__c = spePlan.FrequencyInMonths__c;
               speScopePlan.AggregationDuration__c = spePlan.AggregationDuration__c;
               speScopePlan.Additional_Days__c = spePlan.Additional_Days__c;
               speScopePlan.SurveyExecutionBeforeIndays__c = spePlan.SurveyExecutionBeforeIndays__c;
               speScopePlan.SurveyReminderBeforeExecutionDate__c = spePlan.SurveyReminderBeforeExecutionDate__c;
               speScopePlan.Organization_Group__c = spePlan.Organization_Group__c;
               speScopePlan.OwnerId = UserInfo.getUserId();
               speScopePlan.Plan_Identifier__c = PlanIdentifier;
               
               SPEPlanWrapper spewrap = new SPEPlanWrapper();
               spewrap.isSelected = true;
               spewrap.scpl = speScopePlan;
               Tempspeplanwrapper.add(spewrap);
              }
           speplanwrapperListdisplay = Tempspeplanwrapper;
       }
       public void displayAllSPEPlan(){
           DEFAULT_PAGE_SIZE = 50;
           pageNumber = 1;
           startRecNo=0;
           endRecNo=0;
           supplistsize=0;
           shownext=false;
           showprevoius=false;
           showfirst=false;
           showlast=false;          
           subwrapperList = new list<SPEPlanWrapper>();
           speplanwrapperListdisplay = new List<SPEPlanWrapper>();
           
           //createSPEPlan();
           finalSPEPlan();
           if(checkValidation()){
               if(speplanwrapperListdisplay.size()>0 && new_st_date != Date.newinstance(1960, 1, 1) && new_end_date != Date.newinstance(1960, 1, 1)){               
                     hasRecords = true;
                     integer remainder = math.MOD(speplanwrapperListdisplay.size(),DEFAULT_PAGE_SIZE);
                     if(remainder ==0){
                        maxPages = speplanwrapperListdisplay.size()/DEFAULT_PAGE_SIZE;
                     }
                     else{
                        maxPages = speplanwrapperListdisplay.size()/DEFAULT_PAGE_SIZE + 1;
                     }
         
                      if(speplanwrapperListdisplay.size() > DEFAULT_PAGE_SIZE){
                            firstBtnClick();      
                        }
                       else{
                            for(SPEPlanWrapper scOj : speplanwrapperListdisplay){
                                 subwrapperList.add(scOj);
                             }
                             startRecNo=1;
                             endRecNo=speplanwrapperListdisplay.size();
                             supplistsize = speplanwrapperListdisplay.size();
                             shownext = false;
                             showprevoius = false;
                        }
                    }
                    else if(new_st_date ==  Date.newinstance(1960, 1, 1) && new_end_date ==  Date.newinstance(1960, 1, 1)){
                        subwrapperList = new list<SPEPlanWrapper>();
                        speplanwrapperListdisplay = new List<SPEPlanWrapper>();
                        hasRecords = false; 
                    }
                }
                else{
                    subwrapperList = new list<SPEPlanWrapper>();
                    speplanwrapperListdisplay = new List<SPEPlanWrapper>();
                    hasRecords = false;
                }    
       }
       
       //*****************Code written for Pagination Part******************//
       /****************************************************************
                METHOD INVOKED WHEN FIRST BUTTON IS CLICKED
        ****************************************************************/
        
        public void firstBtnClick(){
            //finalSPEPlan();
            pageNumber = 1;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            subwrapperList = new List<SPEPlanWrapper>();
            if(speplanwrapperListdisplay.size() > DEFAULT_PAGE_SIZE)
            {
                for(integer i=0;i<DEFAULT_PAGE_SIZE;i++){
                    try{
                    subwrapperList.add(speplanwrapperListdisplay[i]);
                    }catch(exception e){}
                }
                startRecNo=1;
                endRecNo=DEFAULT_PAGE_SIZE;
                supplistsize = speplanwrapperListdisplay.size();
                shownext = true;
                showprevoius = false;
                showlast=true;
                showfirst=false;
             }else
             {
                 for(integer i=0;i<speplanwrapperListdisplay.size();i++){
                     try{
                    subwrapperList.add(speplanwrapperListdisplay[i]);
                    }catch(exception e){}
                }
                startRecNo=1;
                endRecNo=speplanwrapperListdisplay.size();
                supplistsize = speplanwrapperListdisplay.size();
                shownext = false;
                showprevoius = false;
                showlast=false;
                showfirst=false;
             }   
        }
        
        /****************************************************************
                METHOD INVOKED WHEN NEXT BUTTON IS CLICKED
        ****************************************************************/
        
        public void nextBtnClick(){
            //createSPEPlan();
            //finalSPEPlan();
            pageNumber = pageNumber+1;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            
            if(pageNumber == maxPages){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<speplanwrapperListdisplay.size(); i++)           
                {
                    try{
                    subwrapperList.add(speplanwrapperListdisplay[i]);
                    }catch(exception e){}
                }
                shownext = false;
                showlast=false;
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=speplanwrapperListdisplay.size();
                supplistsize = speplanwrapperListdisplay.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
                {
                    try{
                    subwrapperList.add(speplanwrapperListdisplay[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
                supplistsize = speplanwrapperListdisplay.size();
    
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
            //finalSPEPlan();
            pageNumber = pageNumber-1;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            
            for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
            {
                try{
                subwrapperList.add(speplanwrapperListdisplay[i]);
                }catch(exception e){}
            }
    
            startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
            endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
            supplistsize = speplanwrapperListdisplay.size();
    
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
            //createSPEPlan();
            //finalSPEPlan();
            pageNumber = maxPages;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            subwrapperList = new list<SPEPlanWrapper>();
    
            for(integer i =(maxPages-1)*DEFAULT_PAGE_SIZE;i<speplanwrapperListdisplay.size();i++)           
            {
                try{
                subwrapperList.add(speplanwrapperListdisplay[i]);
                }catch(exception e){}
            }
    
            startRecNo=((maxPages-1)*DEFAULT_PAGE_SIZE)+1;
            endRecNo=speplanwrapperListdisplay.size();
            supplistsize = speplanwrapperListdisplay.size();
    
            shownext = false;
            showprevoius = true;
            showlast=false;
            showfirst=true;
        }
        
        /****************************************************************
            METHOD INVOKED WHEN PAGE NUMBER IS CHANGED MANUALLY
        ****************************************************************/
        public void goToPage(){
            //finalSPEPlan();
            try
            {
                pageNumber = integer.valueOf(Apexpages.currentPage().getParameters().get('crntPageNum').trim());
            }
            catch(exception ex)
            {
                pageNumber=1;
            }
    
            if(pageNumber>maxPages)
                pageNumber=maxPages;
                
            if(pageNumber<1)// to handle the negative digit as page number
                pageNumber=1;
                
            subwrapperList.clear();    
            subwrapperList = new list<SPEPlanWrapper>();
            if(pageNumber == maxPages){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<speplanwrapperListdisplay.size(); i++)           
                {
                    try{
                    subwrapperList.add(speplanwrapperListdisplay[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=speplanwrapperListdisplay.size();
                supplistsize = speplanwrapperListdisplay.size();
    
                if(pageNumber==1)
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
            else if(pageNumber == 1){
                for(integer i =0;i<DEFAULT_PAGE_SIZE;i++)           
                {
                    try{
                    subwrapperList.add(speplanwrapperListdisplay[i]);
                    }catch(exception e){}
                }
    
                startRecNo=1;
                endRecNo=DEFAULT_PAGE_SIZE;
                supplistsize = speplanwrapperListdisplay.size();
                shownext = true;
                showlast=true;
                showprevoius = false;
                showfirst=false;  
            }
            else
            {
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
                {
                    try{
                    subwrapperList.add(speplanwrapperListdisplay[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
                supplistsize = speplanwrapperListdisplay.size();
    
                shownext = true;
                showlast=true;
                showprevoius = true;
                showfirst=true;
            }
        }
        
    //*******************************************Pagination End***********************************//
       
       
       //*********Wrapper Class for Pagination**********//
       
       public class SPEPlanWrapper{
            public Boolean isSelected {get;set;}
            public Boolean isError{get;set;}
            public SPE_SPEPlan__c scpl{get;set;}
       }
       
      public Boolean checkValidation()
        {   
            if (new_st_date > new_end_date)
            {   
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'SPE Plan End Date must be gretter than Start Date.'));
                return false; 
            }
            
            if (new_st_date <= system.today())
            {   
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'SPE Plan Start Date must be a future date.'));
                return false; 
            }
    
            if (new_end_date > fiveyearsdate)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.SPE_EndDateValidation));
                return false; 
            }
            
            if (spePlan.SurveyExecutionBeforeIndays__c < spePlan.SurveyReminderBeforeExecutionDate__c )
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.SPE_SurveyReminder));
                return false; 
            }                       
                
            return true;
        }
         
      public PageReference save(){
           //finalSPEPlan();
           List<SPE_SPEPlan__c> saveSPEPlanlist = new List<SPE_SPEPlan__c>();
           Map<String,String> DuplicatePlanNameCheck = new Map<String,String>();
           List<SPE_SPEPlan__c> duplicatechecklist = [Select SPEPlanName__c from SPE_SPEPlan__c];
           for(SPE_SPEPlan__c splan: duplicatechecklist){
               DuplicatePlanNameCheck.put(splan.SPEPlanName__c,splan.SPEPlanName__c);
           }
           isDisplayError = false;
           isDisplayError1 = false;
           String speplanname = '';
           List<String> allName = new List<String>();
           Set<String> alluniqueName = new Set<String>();
           for(SPEPlanWrapper sw1: speplanwrapperListdisplay){
               if(sw1.isSelected){
                   allName.add(sw1.scpl.SPEPlanName__c);
                   alluniqueName.add(sw1.scpl.SPEPlanName__c);
               }
           }
           if(allName.size() != alluniqueName.size()){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Every SPE Plan Name should be Unique'));
             return null;   
           }
           for(SPEPlanWrapper sw: speplanwrapperListdisplay){
               sw.isError = false;               
               if(sw.isSelected){
                   if(startstring != '' && endstring != ''){
                       sw.scpl.SPEPlanName__c = startstring+sw.scpl.SPEPlanName__c+endstring;
                       speplanname = sw.scpl.SPEPlanName__c;
                   }
                   if(DuplicatePlanNameCheck.containsKey(sw.scpl.SPEPlanName__c)){
                       sw.isError = true;
                       isDisplayError = true;                       
                   }
                   
                   if(speplanname.length() > 255){
                       sw.isError = true;
                       isDisplayError1 = true;
                   }
                   saveSPEPlanlist.add(sw.scpl);
               }
           }
           if(isDisplayError == true){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'SPE Plan Name should be Unique'));
              return null; 
           }
           if(isDisplayError1 == true){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'SPE Plan Name is too long..'));
              return null; 
           }
           
           System.Debug('**saveSPEPlanlist***'+saveSPEPlanlist.size());
           System.Debug('**speplanwrapperListdisplay***'+speplanwrapperListdisplay.size());
           try{
               upsert saveSPEPlanlist;
           }Catch(Exception e){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'SPE Plan Name should be Unique...'));
              return null;
           }
           
           System.Debug('PlanIdentifier'+PlanIdentifier);
           SPE2SPAddSupplierRespondent_new dtbatch = new SPE2SPAddSupplierRespondent_new(PlanIdentifier);
           database.executebatch(dtBatch,1);
           
           Schema.DescribeSObjectResult r = SPE_SPEPlan__c.sObjectType.getDescribe();
           String keyPrefix = r.getKeyPrefix();
           PageReference pf = new PageReference('/'+keyPrefix);
           return pf;           
       }
       
       public PageReference cancel(){
           Schema.DescribeSObjectResult r = SPE_SPEPlan__c.sObjectType.getDescribe();
           String keyPrefix = r.getKeyPrefix();
           PageReference pf = new PageReference('/'+keyPrefix);
           return pf;
        }
   
   
   //****************Method to auto populate Scope value from Scoring Template**************//
        
      public void ScopeChange()
      {
          scoringTemplatescope = new SPE_ScoringTemplate__c();
          try{
          scoringTemplatescope = [Select Id,SPETemplate__c,Region__c,SubRegion__c,Country__c,Project__c,CategoryCluster__c,
                                   CategoryGroup__c,Category__c,BusinessUnit__c,BusinessLine__c,Product__c
                                   from SPE_ScoringTemplate__c where ID =: scoringtemplateId];
           }catch(exception ex){}       
           
            marketVal = scoringTemplatescope.Region__c != null && scoringTemplatescope.Region__c != '' ? scoringTemplatescope.Region__c : '';
            marketUnitVal = scoringTemplatescope.SubRegion__c != null && scoringTemplatescope.SubRegion__c != '' ? scoringTemplatescope.SubRegion__c : '';
            countryVal = scoringTemplatescope.Country__c != null && scoringTemplatescope.Country__c != '' ? scoringTemplatescope.Country__c : '';
            projectVal = scoringTemplatescope.Project__c != null && scoringTemplatescope.Project__c != '' ? scoringTemplatescope.Project__c : '';
            
            buVal = scoringTemplatescope.BusinessUnit__c != null && scoringTemplatescope.BusinessUnit__c != '' ? scoringTemplatescope.BusinessUnit__c : '';
            blVal = scoringTemplatescope.BusinessLine__c != null && scoringTemplatescope.BusinessLine__c != '' ? scoringTemplatescope.BusinessLine__c : '';
            prdVal = scoringTemplatescope.Product__c != null && scoringTemplatescope.Product__c != '' ? scoringTemplatescope.Product__c : '';
            
            caVal = scoringTemplatescope.CategoryCluster__c != null && scoringTemplatescope.CategoryCluster__c != '' ? scoringTemplatescope.CategoryCluster__c : '';
            cgVal = scoringTemplatescope.CategoryGroup__c != null && scoringTemplatescope.CategoryGroup__c != '' ? scoringTemplatescope.CategoryGroup__c : '';
            ctVal = scoringTemplatescope.Category__c != null && scoringTemplatescope.Category__c != '' ? scoringTemplatescope.Category__c : '';
      
         disableScopeAttributes(); 
      }  
       
}