public with sharing class SPE_ScoreGenerator_BulkExtension_1{
    
    /****************************************************************
                        VARIABLE DECLARATION
    ****************************************************************/
       
    List<SPE_ScorecardGenerator__c> scorecardList;
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
    public list<ScorecardWrapper> scorecardWrapperList{get;set;} // list of wrapper class to store all the Scorecards based on the criterias
    public List<ScorecardWrapper> subwrapperList{get;set;} // list of wrapper class to store only the limited no of(# of page size) Scorecards
    public String searchString{get;set;}
    public String strApproveReject{get;set;}
    public String strRedirectID{get;set;}
    public String isError {get;set;}
    public Set<String> addmsg {get;set;}
    
    List<SPE_ScorecardGenerator__c> subwrapperListSelected;
    
     public SPE_ScoreGenerator_BulkExtension_1(ApexPages.StandardSetController std){
         isError = 'false';
         DEFAULT_PAGE_SIZE = 10;
         pageNumber = 1;
         startRecNo=0;
         endRecNo=0;
         shownext=false;
         showprevoius=false;
         showfirst=false;
         showlast=false;
         scorecardWrapperList = new list<ScorecardWrapper>();
         subwrapperList = new list<ScorecardWrapper>();
         subwrapperListSelected = new list<SPE_ScorecardGenerator__c>();
         scorecardList = new  List<SPE_ScorecardGenerator__c>();
          Date d = System.today();

        // scorecardList = [Select Id,Name,Stage__c,Approver__c,Comments__c,Approver__r.Name,ScorecardTracker__c,ScorecardTracker__r.Name,StartDate__c from SPE_ScoreCard__c where Stage__c =: 'Pending' AND Approver__c =: UserInfo.getUserId() AND ScorecardTracker__c != Null];
         scorecardList = [Select Id,Name,Stage__c,StartDate__c,EndDate__c from SPE_ScorecardGenerator__c where EndDate__c >: d AND ScorecardTemplate__r.Stage__c!='Obsolete'];
            
         if(!scorecardList.isEmpty()){
             hasRecords = true;
             // Determining total no of pages 
             integer remainder = math.MOD(scorecardList.size(),DEFAULT_PAGE_SIZE);
             if(remainder ==0){
                maxPages = scorecardList.size()/DEFAULT_PAGE_SIZE;
             }
             else{
                maxPages = scorecardList.size()/DEFAULT_PAGE_SIZE + 1;
             }
             for(SPE_ScorecardGenerator__c scObj : scorecardList){
                scorecardWrapperList.add(new ScorecardWrapper(scObj));
             }
             if(scorecardList.size() > DEFAULT_PAGE_SIZE){
                firstBtnClick();      
             }
             else{
                 for(ScorecardWrapper scOj : scorecardWrapperList){
                     subwrapperList.add(scOj);
                 }
                 startRecNo=1;
                 endRecNo=scorecardWrapperList.size();
    
                 shownext = false;
                 showprevoius = false;
            }
         }
         else{
            hasRecords = false;
        }
    }
        
        
        /****************************************************************
                METHOD INVOKED WHEN SEARCH BUTTON IS CLICKED
        ****************************************************************/
        public void serachRecords(){
            String searchText = '%' + searchString + '%';
            pageNumber = 1;
             startRecNo=0;
             endRecNo=0;
             shownext=false;
             showprevoius=false;
             showfirst=false;
             showlast=false;
             scorecardWrapperList = new list<ScorecardWrapper>();
             subwrapperList = new list<ScorecardWrapper>();
             scorecardList = new  List<SPE_ScorecardGenerator__c>();
              Date d = System.today();

            scorecardList = [Select Id,Name,Stage__c,StartDate__c,EndDate__c from SPE_ScorecardGenerator__c where EndDate__c >: d AND ScorecardTemplate__r.Stage__c!='Obsolete' AND Name Like : searchText];
            if(!scorecardList.isEmpty()){
                 hasRecords = true;
                 // Determining total no of pages 
                 integer remainder = math.MOD(scorecardList.size(),DEFAULT_PAGE_SIZE);
                 if(remainder ==0){
                    maxPages = scorecardList.size()/DEFAULT_PAGE_SIZE;
                 }
                 else{
                    maxPages = scorecardList.size()/DEFAULT_PAGE_SIZE + 1;
                 }
                 for(SPE_ScorecardGenerator__c scObj : scorecardList){
                    scorecardWrapperList.add(new ScorecardWrapper(scObj));
                 }
                 if(scorecardList.size() > DEFAULT_PAGE_SIZE){
                    firstBtnClick();      
                 }
                 else{
                     for(ScorecardWrapper scOj : scorecardWrapperList){
                         subwrapperList.add(scOj);
                     }
                     startRecNo=1;
                     endRecNo=scorecardWrapperList.size();
        
                     shownext = false;
                     showprevoius = false;
                }
             }
             else{
                hasRecords = false;
            }
        }
        
        /****************************************************************
                METHOD INVOKED WHEN FIRST BUTTON IS CLICKED
        ****************************************************************/
        
        public void firstBtnClick(){
            pageNumber = 1;
            //showMessage=false;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            subwrapperList = new list<ScorecardWrapper>();
    
            for(integer i =0;i<DEFAULT_PAGE_SIZE;i++){
                subwrapperList.add(scorecardWrapperList[i]);
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
            subwrapperList = new list<ScorecardWrapper>();
            
            if(pageNumber == maxPages){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<scorecardWrapperList.size(); i++)           
                {
                    subwrapperList.add(scorecardWrapperList[i]);
                }
                shownext = false;
                showlast=false;
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=scorecardWrapperList.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
                {
                    subwrapperList.add(scorecardWrapperList[i]);
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
            subwrapperList = new list<ScorecardWrapper>();
            
            for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
            {
                subwrapperList.add(scorecardWrapperList[i]);
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
        subwrapperList = new list<ScorecardWrapper>();

        for(integer i =(maxPages-1)*DEFAULT_PAGE_SIZE;i<scorecardWrapperList.size();i++)           
        {
            subwrapperList.add(scorecardWrapperList[i]);
        }

        startRecNo=((maxPages-1)*DEFAULT_PAGE_SIZE)+1;
        endRecNo=scorecardWrapperList.size();


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
                
                
            subwrapperList = new list<ScorecardWrapper>();
            if(pageNumber == maxPages){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<scorecardWrapperList.size(); i++)           
                {
                    subwrapperList.add(scorecardWrapperList[i]);
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=scorecardWrapperList.size();
    
    
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
            else if(pageNumber ==1){
                for(integer i =0;i<DEFAULT_PAGE_SIZE;i++)           
                {
                    subwrapperList.add(scorecardWrapperList[i]);
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
                    subwrapperList.add(scorecardWrapperList[i]);
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
    
    
                shownext = true;
                showlast=true;
                showprevoius = true;
                showfirst=true;
            }
        }
        
        /************************************************************
                        APPROVING/REJECTING SCORECARDS
        *************************************************************/
        
        public void returnToScorecardListView(){
            isError = 'false';
            addmsg = new Set<String>();
            subwrapperListSelected = new list<SPE_ScorecardGenerator__c>();
         //   String rejectApprove = Apexpages.currentPage().getParameters().get('appRej').trim();
            integer c = 0;
            Schema.DescribeSObjectResult result = SPE_ScorecardGenerator__c.SObjectType.getDescribe();
            
            strRedirectID = result.getKeyPrefix()+'';
            system.debug('strRedirectID---' + strRedirectID);
            
            for(ScorecardWrapper sc:scorecardWrapperList){
                if(sc.isSelected){
                    if(sc.scorecardRec.EndDate__c < system.today()){
                        isError = 'true';
                        sc.Error = true;
                        addmsg.add(sc.scorecardRec.Name);
                        
                    }
                    else{
                     if(isError != 'true')
                         isError = 'false';
                     sc.Error = false;
                    subwrapperListSelected.add(sc.scorecardRec);
                    
                    }
                }
            }
            try{
                if(!subwrapperListSelected.isEmpty())
                    update subwrapperListSelected;
                system.debug('subwrapper size---' + c);
                
                            
           //     Schema.DescribeSObjectResult result = SPE_ScorecardGenerator__c.SObjectType.getDescribe();
           //     PageReference pageRef = new PageReference('/' + result.getKeyPrefix());
            //    pageRef.setRedirect(true);
               
            //    return pageRef;
            }
            catch(Exception ex){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
                ApexPages.addMessage(myMsg);
             //   return null;
            }
        }
        
        /****************************************************************
                        WRAPPER CLASS
        ****************************************************************/
        
        public class ScorecardWrapper
        {
            public SPE_ScorecardGenerator__c scorecardRec{get; set;}
            public Boolean isSelected{get; set;}
            public Boolean Error{get;set;}
            
            public ScorecardWrapper(SPE_ScorecardGenerator__c sc)
            {
                scorecardRec = sc;
                isSelected = false;
                
                
            }
        }
    }