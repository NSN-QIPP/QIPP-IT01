public class SPE2_AddCCContactDedtailsExt{
    public List<Contact> lstContact {get;set;}
    public List<contactWrapper> lstContactWrapper {get;set;}
    public List<contactWrapper> subwrapperList {get;set;} 
    public String contactstr {get;set;}
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
    public Boolean showResults {get;set;}
    public List<SPE2_CC_Contact_Details__c>  ccConList;
    public Id RecordId;
    public SPE_ScoreCard__c scorecardObj;
    public SPE_ScorecardSupplierMap__c scMap;

    public SPE2_AddCCContactDedtailsExt(ApexPages.StandardController st){
        DEFAULT_PAGE_SIZE = 10;
        pageNumber = 1;
        startRecNo=0;
        endRecNo=0;
        shownext=false;
        showprevoius=false;
        showfirst=false;
        showlast=false;
        hasrecords = false;
        lstContactWrapper = new List<contactWrapper>();
        subwrapperList = new List<contactWrapper>();
        RecordId = st.getId(); 
        scorecardObj = new SPE_ScoreCard__c();
        scMap = new SPE_ScorecardSupplierMap__c();
    }

    public void searchContacts(){
        lstContact  = new List<Contact>();
        lstContactWrapper = new List<contactwrapper>();
        String str = '%'+contactstr+'%';
        lstContact  = [SELECT Name,Email from Contact where Name like :str];
        system.debug('contatc list---'+lstContact);
        if(lstContact!=null){
            for(Contact c : lstContact){
            lstContactWrapper.add(new contactWrapper(c));
            }
            pagination(lstContactWrapper);
            
        } 
        else{
             ApexPages.Message myMsg = new ApexPages.message(ApexPages.severity.ERROR,'No Contacts were found matching the search criteria.');
             ApexPages.addMessage(myMsg); 
        }
            
       }
       
   public  PageReference saveContact(){
      
      Id scGenId;
      Id suppId;
      if(RecordId != null)
        scorecardObj = [SELECT Id,Name,Supplier__c,ScorecardTracker__c,ScorecardTracker__r.ScorecardGenerator__c from SPE_ScoreCard__c where id = :RecordId ];
       
       if(scorecardObj!=null){
           scGenId = scorecardObj.ScorecardTracker__r.ScorecardGenerator__c;
           suppId = scorecardObj.Supplier__c;
       }
       system.debug('scorecard value is'+scorecardObj);
      scMap = [Select Id,name from SPE_ScorecardSupplierMap__c where ScorecardGenerator__c = :scGenId and Supplier__c = :suppId ];
      ccConList = new List<SPE2_CC_Contact_Details__c>();
       for(contactwrapper w : lstContactWrapper){
           if(w.isContactSelected ){
           SPE2_CC_Contact_Details__c ccConObj = new SPE2_CC_Contact_Details__c();
           ccConObj.Contact__c = w.objContact.id;
           ccConObj.ScoreCard__c = recordId;
           ccConObj.Scorecard_Supplier_Map__c = scMap.Id;
           ccConList.add(ccConObj);
           }
           
       }
       
       system.debug('ccconlist is--'+ccConList);
       try{
       insert ccconlist;
      
       }
       catch(Exception e){
           system.debug('exception is'+e);
       }
       pageReference pf = new pageReference('/'+recordId);
       //pf.setRedirect(true);
       return pf;
       
   }   
       
    
     public void pagination(List<contactWrapper> lstContactWrapper){
            if(!lstContactWrapper.isEmpty()){
             subwrapperList.clear();
             hasRecords = true;
             // Determining total no of pages 
             integer remainder = math.MOD(lstContactWrapper.size(),DEFAULT_PAGE_SIZE);
             
             if(remainder ==0){
                maxPages = lstContactWrapper.size()/DEFAULT_PAGE_SIZE;
             }
             else{
                maxPages = lstContactWrapper.size()/DEFAULT_PAGE_SIZE + 1;
             }
             system.debug('max pages ---'+maxPages);
             system.debug('lstContactWrapper size'+lstContactWrapper);
             if(lstContactWrapper.size() > DEFAULT_PAGE_SIZE){
                firstBtnClick();      
                system.debug('goin to first btn clk');
             }
             else{
                 for(contactWrapper scOj : lstContactWrapper){
                     subwrapperList.add(scOj);
                 }
                 startRecNo=1;
                 endRecNo=lstContactWrapper.size();
    
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
            subwrapperList = new list<contactWrapper>();
    
            for(integer i =0;i<DEFAULT_PAGE_SIZE;i++){
                subwrapperList.add(lstContactWrapper[i]);
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
            subwrapperList = new list<contactWrapper>();
            
            if(pageNumber == maxPages){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<lstContactWrapper.size(); i++)           
                {
                    subwrapperList.add(lstContactWrapper[i]);
                }
                shownext = false;
                showlast=false;
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=lstContactWrapper.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
                {
                    subwrapperList.add(lstContactWrapper[i]);
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
            subwrapperList = new list<contactWrapper>();
            
            for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
            {
                subwrapperList.add(lstContactWrapper[i]);
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
        subwrapperList = new list<contactWrapper>();

        for(integer i =(maxPages-1)*DEFAULT_PAGE_SIZE;i<lstContactWrapper.size();i++)           
        {
            subwrapperList.add(lstContactWrapper[i]);
        }

        startRecNo=((maxPages-1)*DEFAULT_PAGE_SIZE)+1;
        endRecNo=lstContactWrapper.size();


        shownext = false;
        showprevoius = true;
        showlast=false;
        showfirst=true;
        }
        
        
          /****************************************************************
            METHOD INVOKED WHEN PAGE NUMBER IS CHANGED MANUALLY
        ****************************************************************/
        public void goToPage(){
            //showMessage=false;
            try
            {
                pageNumber=integer.valueOf(Apexpages.currentPage().getParameters().get('crntPageNum').trim());
            }
            catch(exception ex)
            {
                pageNumber=1;
            }
    
            if(pageNumber>maxPages)
                pageNumber=maxPages;
                
            if(pageNumber<1)// to handle the negative digit as page number
                pageNumber=1;
                
                
            subwrapperList = new list<contactWrapper>();
            if(pageNumber == maxPages){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<lstContactWrapper.size(); i++)           
                {
                    subwrapperList.add(lstContactWrapper[i]);
                }
    
                startRecNo =((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=lstContactWrapper.size();
    
    
                if(pageNumber==1)
                {
                    shownext = false;
                    showlast =false;
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
            else if(pageNumber ==1){
                for(integer i =0;i<DEFAULT_PAGE_SIZE;i++)           
                {
                    subwrapperList.add(lstContactWrapper[i]);
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
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
                {
                    subwrapperList.add(lstContactWrapper[i]);
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
    
    
                shownext = true;
                showlast=true;
                showprevoius = true;
                showfirst=true;
            }
        }
    //------------Pagination Ends ----    
       public class contactWrapper{
       public boolean isContactSelected{get;set;}
       public Contact objContact{get;set;}
       
       public contactWrapper(Contact objContactWrapTemp){
           isContactSelected = false;
           objContact = objContactWrapTemp;
       }
   }

}