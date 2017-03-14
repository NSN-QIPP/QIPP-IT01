public without sharing class SPE2_AddQuestionToSurveyExt{
    
   SPE2Survey__c objSG;
    String idSPEPlanID;
    
  //****************************Changes for Encryption*************************//  
    //private Set<String> existSupplier = new Set<String>();
    //private Set<Id> existSupplierId = new Set<Id>();
  //****************************END*************************//   
  
    Transient List<SPE2_Question_Survey_Association__c> lstExistingSuppliers;
    public String supplierName {get;set;}
    public String supplierName2 {get;set;}
    public boolean isShowSuppliers{get;set;}
    public boolean isSearch{get;set;}
    public boolean isSearch2{get;set;}
    public boolean isDisplayError{get;set;}
    Transient List<QuestionWrapper> QuestionWrapperList;
    Transient List<QuestionWrapper> QuestionWrapperListSelected;
    public Set<Id> setIds {get;set;}
    
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
    public List<QuestionWrapper> subwrapperList{get;set;} // list of wrapper class to store only the limited no of(# of page size) Suppliers   
    
    public integer DEFAULT_PAGE_SIZE2{get;set;}
    public integer pageNumber2{get;set;}
    public integer maxPages2{get;set;}
    public integer startRecNo2 {get;set;}
    public integer endRecNo2 {get;set;}
    public boolean hasRecords2{get;set;}
    public boolean shownext2{get;set;}
    public boolean showprevoius2{get;set;}
    public boolean showfirst2{get;set;}
    public boolean showlast2{get;set;}    
    public Integer supplistsize2{get;set;}
    public List<QuestionWrapper> subwrapperList2{get;set;}
    public String sortname;
    public String sortname2;
    
    public list<String> AlphaList {get; set;}
    Transient List<QuestionWrapper> DisplayQuestionWrapperList;
    List<QuestionWrapper> templistQuestionWrapper;
    Map<String,String> tempMapDeQuestionWrapper;
    
    public list<String> AlphaList2 {get; set;}
    Transient List<QuestionWrapper> DisplayQuestionWrapperList2;
    
    public List<SPE2_Question_Survey_Association__c> lstSSM{get;set;}
    public SPE2_Question_Survey_Association__c objSSM{get;set;}
    List<SPE2_Question_Survey_Association__c> toDelete;
    List<SPE_PIDefinition__c> lstPidefOFQues;
   
   
    
    
    public SPE2_AddQuestionToSurveyExt(Apexpages.Standardcontroller st){
       
        idSPEPlanID = st.getId();
        isShowSuppliers = true;
        isSearch = false;
        isSearch2 = false;
        isDisplayError = False;
        objSG = new SPE2Survey__c();
        sortname = '';
        sortname2 = '';
        
        QuestionWrapperList = new List<QuestionWrapper>();
        setIds = new Set<Id>();
        
        
        DEFAULT_PAGE_SIZE = 10;
        pageNumber = 1;
        startRecNo=0;
        endRecNo=0;
        supplistsize=0;
        shownext=false;
        showprevoius=false;
        showfirst=false;
        showlast=false;
        subwrapperList = new list<QuestionWrapper>();
        
        DEFAULT_PAGE_SIZE2 = 10;
        pageNumber2 = 1;
        startRecNo2=0;
        endRecNo2=0;
        supplistsize2=0;
        shownext2=false;
        showprevoius2=false;
        showfirst2=false;
        showlast2=false;
        subwrapperList2 = new list<QuestionWrapper>();
        
        templistQuestionWrapper = new List<QuestionWrapper>();
        tempMapDeQuestionWrapper = new Map<String,String>();
        toDelete = new List<SPE2_Question_Survey_Association__c>();
        lstPidefOFQues = new List<SPE_PIDefinition__c>();
        
        //*************initialization alpha list**********//
        AlphaList = new list<String>{'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'All'};
        
        objSG =  [SELECT Id, CategoryArea__c, CategoryGroup__c, Category__c,Stage__c
                       FROM SPE2Survey__c
                       WHERE Id =: idSPEPlanID];
                   
                       
        // alphasortname();
        
      }                                              
                
        //************************Method For Alphabaticall sorting*********************//
        public void selectwrappsupp()
        {
           isSearch2 = false;                      
           lstExistingSuppliers = new List<SPE2_Question_Survey_Association__c>();
           Set<ID> QBID = new Set<ID>();
           Map<Id,SPE_PIDefinition__c> mapQuesPI = new Map<Id,SPE_PIDefinition__c>();
           lstExistingSuppliers = [SELECT Id , Question_Bank__r.Name, Question_Bank__r.QuestionCode__c,Question_Bank__r.Id,
                                   Question_Bank__r.QuestionLabel__c,Question_Bank__r.SurveyQuestion__c,Question_Bank__r.AnswerType__c,ordernumber__c,                             
                                    Question_Bank__r.IsRequired__c,PIData__c,PIData__r.name,PIData__r.LifecycleStage__c,PIData__r.categoryscope__c,
                            PIData__r.frequency__c FROM SPE2_Question_Survey_Association__c
                                     WHERE Survey__c =: idSPEPlanID];
                                                   
           lstExistingSuppliers.sort();
           
           for(SPE2_Question_Survey_Association__c scA : lstExistingSuppliers ){
               QBID.add(scA.Question_Bank__r.Id);
           
           }
           lstPidefOFQues = [Select Id,Name,SurveyQuestion__c,Frequency__c,SurveyQuestion__r.ID,LifecycleStage__c,categoryScope__c from SPE_PIDefinition__c where SurveyQuestion__c in :QBID and DataAcquisitionMethod__c!='Survey'];
           
           if(lstPidefOFQues.size()>0){
              for(SPE_PIDefinition__c pi : lstPidefOFQues ) {
                  mapQuesPI.put(pi.SurveyQuestion__r.ID,pi);
               }
           system.debug('map of pi to ques'+mapQuesPI);
           
           }
           DisplayQuestionWrapperList = new List<QuestionWrapper>();
           QuestionWrapperList = new List<QuestionWrapper>();
           Map<String,String> DeselectedSupplierMap = new Map<String,String>();
           
            for(SPE2_Question_Survey_Association__c ssmT : lstExistingSuppliers){
                QuestionWrapper sc = new QuestionWrapper();
                sc.isChecked = true;
                sc.strEnterpriseName = ssmT.Question_Bank__r.QuestionLabel__c;
                sc.strSupplierName = ssmT.Question_Bank__r.Name;
                sc.idEntId = ssmT.Question_Bank__r.Id;
                sc.idPlanSuppId = ssmT.Id;
                sc.isExisting = true;
                sc.scMap = ssMT;
                sc.SurveyQues = ssmT.Question_Bank__r.SurveyQuestion__c;
                sc.ansType = ssmT.Question_Bank__r.answertype__c;
                sc.isreq = ssmT.Question_Bank__r.IsRequired__c;
                sc.pidef = ssmT.PIData__r.name;
                sc.pidefStage = ssmT.PIData__r.LifecycleStage__c;
                SPE_PIDefinition__c pid = new SPE_PIDefinition__c (id=ssmT.PIData__c);
                sc.piData= pid;
                sc.freq = ssmT.PIData__r.frequency__c;
                sc.catscope = ssmT.PIData__r.categoryScope__c; 
                
                DisplayQuestionWrapperList.add(sc);
                
                setIds.add(sc.idEntId);
               
                
             //****************************Changes for Encryption*************************// 
                //existSupplier.add(ssmT.Supplier__r.EnterpriseId__c);            
                //existSupplierId.add(ssmT.Supplier__c);
             //****************************END*************************//   
                
            }            
              
            for(QuestionWrapper sw : subwrapperList2){
                if(sw.isChecked){                
                    //System.Debug(LoggingLevel.ERROR,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+sw.isChecked);
                    if(!setIds.contains(sw.idEntId)){
                    sw.isSelected = True;
                    templistQuestionWrapper.add(sw);
                    //System.Debug(LoggingLevel.ERROR,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+templistQuestionWrapper.size());
                    setIds.add(sw.idEntId);
                    }
                    else{
                    //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'The supplier is already selected'));
                    }                        
                 }
             }
             
              for(QuestionWrapper sw1 : subwrapperList){
                    if(!sw1.isChecked && sw1.isExisting && sw1.idPlanSuppId != null){
                        tempMapDeQuestionWrapper.put(sw1.strSupplierName,sw1.strSupplierName);                        
                    }
                    else
                    {
                        tempMapDeQuestionWrapper.remove(sw1.strSupplierName);                        
                    }
                 }
                
                if(tempMapDeQuestionWrapper.size()>0)
                {
                    toDelete = new List<SPE2_Question_Survey_Association__c>();
                    
                    for(QuestionWrapper scws : DisplayQuestionWrapperList)
                    {                    
                        if(tempMapDeQuestionWrapper.containsKey(scws.strSupplierName))
                        {
                            scws.isChecked  = False;
                            SPE2_Question_Survey_Association__c s = new SPE2_Question_Survey_Association__c (id=scws.idPlanSuppId,Survey__c=idSPEPlanID);
                            toDelete.add(s);
                        }
                    } 
                }  
                
                if(templistQuestionWrapper.size()>0)
                 {
                     DisplayQuestionWrapperList.addAll(templistQuestionWrapper);
                 }
                 
    //------------Added for top search suppliers----------------
          
        
        if(supplierName2 !='' && supplierName2 !=Null){
            //*************initialization alpha list**********//
            //AlphaList = new list<String>{'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'All'};
            QuestionWrapperListSelected = new List<QuestionWrapper>();
            List<QuestionWrapper> tempList = new List<QuestionWrapper>();
            String searchString = supplierName2;
            system.debug('search str'+searchString );
            
            if   (searchString !=null && searchString.containsIgnoreCase('*'))
            {
              //searchString = searchString.replaceAll('[*]', '%');
            }
            
         if (supplierName2 != '' && supplierName2 != '*')
            {
          //*******************************Changes For Encryption***********************//
                                                                                                         
              Pattern MyPattern = Pattern.compile('');
             
             if (searchString.substring(0,1) == '*' && searchString.substring(searchString.length()-1,searchString.length()) == '*')
             {
                if (searchString.length()>1)
                {
                    String Temp = searchString.subString(1, searchString.length());
                    searchString = Temp.replaceAll('[*]', '+');
                    MyPattern = Pattern.compile('(?i)'+searchString );
                }
             }
             else if (searchString.substring(0,1) != '*' && searchString.substring(searchString.length()-1,searchString.length()) == '*')
             {
                searchString = searchString.replaceAll('[*]', '+');
                MyPattern = Pattern.compile('(?i)\\A'+searchString);
             }
             
             else if (searchString.substring(0,1) == '*' && searchString.substring(searchString.length()-1,searchString.length()) != '*')
             {
                if (searchString.length()>1)
                {
                    String Temp = searchString.subString(1, searchString.length());
                    searchString = Temp + '+';
                    MyPattern = Pattern.compile('(?i)'+searchString +'\\z');
                }
             } 
             
             else if (searchString.substring(0,1) != '*' && searchString.substring(searchString.length()-1,searchString.length()) != '*')
             {
                 if (searchString.length()>1)
                {
                    MyPattern = Pattern.compile('(?i)\\A^'+searchString+'$');
                }
             }
                 
           system.debug('ques wrapper disp--'+DisplayQuestionWrapperList);    
          for (QuestionWrapper a : DisplayQuestionWrapperList)
            {
                if(a.strEnterpriseName !=null){
                String s = a.strEnterpriseName ;
                system.debug('disp----'+s);
                Matcher MyMatcher = MyPattern.matcher(s);
                system.debug('pattern debug---'+ MyPattern.matcher(s));
                system.debug('find match--'+MyMatcher.find());
                if (MyMatcher.find())
                {
                    QuestionWrapper sw = new QuestionWrapper();
                    sw.isChecked = true;
                    sw.strEnterpriseName = a.strEnterpriseName;
                    sw.strSupplierName = a.strSupplierName;
                    sw.idEntId = a.idEntId;
                    sw.isExisting = false;
                    sw.SurveyQues = a.SurveyQues;
                    sw.ansType = a.ansType ;
                    sw.isreq = a.isreq ;
                    if(mapQuesPI.containsKey(a.idEntId)){
                        sw.pidef = mapQuesPI.get(a.idEntId).name;
                        if(mapQuesPI.get(a.idEntId)!=null)
                        sw.piData= mapQuesPI.get(a.idEntId);
                        sw.freq = mapQuesPI.get(a.idEntId).frequency__c;
                        sw.pidefStage = mapQuesPI.get(a.idEntId).LifecycleStage__c;
                        sw.catscope = mapQuesPI.get(a.idEntId).categoryscope__c;
                     }
                    else
                    sw.pidef ='';
                    tempList.add(sw);
                }
                system.debug('templIst'+tempList);
              }  
             
            }
             if(tempList.size()>0){
                  DisplayQuestionWrapperList.clear();
                  DisplayQuestionWrapperList.addAll(tempList);
                  
              }
              else{
               isSearch2 = true;
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'No records to display here'));
              }
              
            }
         
    }
   

//-----------------------------------       

              if (sortname == null || sortname == 'All') {
                    for(QuestionWrapper scOj : DisplayQuestionWrapperList)
                             {
                                 QuestionWrapperList.add(scOj);
                                 hasRecords = true;                         
                                 integer remainder = math.MOD(QuestionWrapperList.size(),DEFAULT_PAGE_SIZE);
                                 if(remainder == 0){
                                    maxPages = QuestionWrapperList.size()/DEFAULT_PAGE_SIZE;
                                 }
                                 else{
                                    maxPages = QuestionWrapperList.size()/DEFAULT_PAGE_SIZE + 1;
                                 }
                             }
                             
                }else if(sortname != null && sortname != 'All'){
                        Pattern MyPattern = Pattern.compile('(?i)\\A^'+sortname);
                        System.debug('$$$$$$$$$$$$$$$$$$$$$$'+MyPattern);                    
                        
                        for(QuestionWrapper scOj : DisplayQuestionWrapperList){
                           String sname = scOj.strSupplierName;
                           System.debug('$$$$$$$$$$$$$$$$$$$$$$'+sname);
                           Matcher MyMatcher = MyPattern.matcher(sname);
                               if (MyMatcher.find())
                               {                                    
                                     QuestionWrapperList.add(scOj);
                                     hasRecords = true;                         
                                     integer remainder = math.MOD(QuestionWrapperList.size(),DEFAULT_PAGE_SIZE);
                                     if(remainder ==0){
                                        maxPages = QuestionWrapperList.size()/DEFAULT_PAGE_SIZE;
                                     }
                                     else{
                                        maxPages = QuestionWrapperList.size()/DEFAULT_PAGE_SIZE + 1;
                                     }
                               }                                                                             
                         }  
                }
              
                
                
      }  
       /* public void alphasortname(){
                DEFAULT_PAGE_SIZE = 10;
                pageNumber = 1;
                startRecNo=0;
                endRecNo=0;
                supplistsize=0;
                shownext=false;
                showprevoius=false;
                showfirst=false;
                showlast=false;
                QuestionWrapperList = new List<QuestionWrapper>();
                sortname = apexpages.currentpage().getparameters().get('alpha');
                                
                 if (sortname == null || sortname == 'All') {
                     subwrapperList.clear();
                     subwrapperList = new list<QuestionWrapper>();
                     selectwrappsupp();
                     if(QuestionWrapperList.size()>0)
                     {    
                     hasRecords = true;
                     System.Debug(LoggingLevel.ERROR,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+QuestionWrapperList.size());
                     System.Debug(LoggingLevel.ERROR,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+DisplayQuestionWrapperList.size());
                     integer remainder = math.MOD(QuestionWrapperList.size(),DEFAULT_PAGE_SIZE);
                         if(remainder ==0){
                            maxPages = QuestionWrapperList.size()/DEFAULT_PAGE_SIZE;
                         }
                         else{
                            maxPages = QuestionWrapperList.size()/DEFAULT_PAGE_SIZE + 1;
                         }
             
                          if(QuestionWrapperList.size() > DEFAULT_PAGE_SIZE){
                                firstBtnClick();      
                            }
                           else{
                                for(QuestionWrapper scOj : QuestionWrapperList){
                                     subwrapperList.add(scOj);
                                 }
                                 startRecNo=1;
                                 endRecNo=QuestionWrapperList.size();
                                 supplistsize = QuestionWrapperList.size();
                                 shownext = false;
                                 showprevoius = false;
                            }
                    } 
                 }else {
                    subwrapperList.clear();
                    subwrapperList = new list<QuestionWrapper>();
                    selectwrappsupp();
                     if(QuestionWrapperList.size()>0)
                     {
                         System.debug(LoggingLevel.ERROR,'$$$$$$$$$$$$$$$$$$$$$$'+QuestionWrapperList.size());                     
                         hasRecords = true;                         
                         integer remainder = math.MOD(QuestionWrapperList.size(),DEFAULT_PAGE_SIZE);
                         if(remainder ==0){
                            maxPages = QuestionWrapperList.size()/DEFAULT_PAGE_SIZE;
                         }
                         else{
                            maxPages = QuestionWrapperList.size()/DEFAULT_PAGE_SIZE + 1;
                         }
             
                          if(QuestionWrapperList.size() > DEFAULT_PAGE_SIZE){
                                firstBtnClick();      
                            }
                           else{
                                for(QuestionWrapper scOj1 : QuestionWrapperList){
                                     subwrapperList.add(scOj1);
                                 }
                                 startRecNo=1;
                                 endRecNo=QuestionWrapperList.size();
                                 supplistsize = QuestionWrapperList.size();
                                 shownext = false;
                                 showprevoius = false;
                            }
                        }
                      }
                      if(QuestionWrapperList.size() == 0)
                      {                          
                          System.debug('Enter Here'+QuestionWrapperList.size());
                          pageNumber = 0;
                          maxPages = 0;
                          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'No records to display'));
                      }
        }*/
        
        //*****************Code written for Pagination Part for Upper List******************//
       /****************************************************************
                METHOD INVOKED WHEN FIRST BUTTON IS CLICKED
        ****************************************************************/
        
        public void firstBtnClick(){
            selectwrappsupp();
            //System.Debug(LoggingLevel.ERROR,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+QuestionWrapperList.size());
            //System.Debug(LoggingLevel.ERROR,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+DisplayQuestionWrapperList.size());
            pageNumber = 1;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            subwrapperList = new List<QuestionWrapper>();
            if(QuestionWrapperList.size()>0){
                for(Integer i = QuestionWrapperList.size()-1 ; i>0;i--)
                {
                    if(QuestionWrapperList[i].strSupplierName ==null)                       
                        QuestionWrapperList.remove(i);
                }
            
            }
            if(QuestionWrapperList.size() > DEFAULT_PAGE_SIZE)
            {
                for(integer i=0;i<DEFAULT_PAGE_SIZE;i++){
                    if(QuestionWrapperList[i].strSupplierName !=null)
                    try{
                        subwrapperList.add(QuestionWrapperList[i]);
                    }catch(exception e){}
                }
                isShowSuppliers = true;
                startRecNo=1;
                endRecNo=DEFAULT_PAGE_SIZE;
                supplistsize = QuestionWrapperList.size();
                shownext = true;
                showprevoius = false;
                showlast=true;
                showfirst=false;
             }else
             {
                 for(integer i=0;i<QuestionWrapperList.size();i++){
                     if(QuestionWrapperList[i].strSupplierName !=null)
                    try{
                        subwrapperList.add(QuestionWrapperList[i]);
                    }catch(exception e){}
                }
                system.debug('subwrapper is'+subwrapperList);
                isShowSuppliers = true;
                startRecNo=1;
                endRecNo=QuestionWrapperList.size();
                supplistsize = QuestionWrapperList.size();
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
            selectwrappsupp();
            pageNumber = pageNumber+1;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            
            if(pageNumber == maxPages){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<QuestionWrapperList.size(); i++)           
                {
                    try{
                        subwrapperList.add(QuestionWrapperList[i]);
                    }catch(exception e){}
                }
                shownext = false;
                showlast=false;
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=QuestionWrapperList.size();
                supplistsize = QuestionWrapperList.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
                {
                    try{
                        subwrapperList.add(QuestionWrapperList[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
                supplistsize = QuestionWrapperList.size();
    
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
            selectwrappsupp();
            pageNumber = pageNumber-1;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            
            for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
            {
                try{
                    subwrapperList.add(QuestionWrapperList[i]);
                }catch(exception e){}
            }
    
            startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
            endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
            supplistsize = QuestionWrapperList.size();
    
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
            selectwrappsupp();
            pageNumber = maxPages;
            System.debug('pageNumber----->' + pageNumber);
            subwrapperList.clear();
            subwrapperList = new list<QuestionWrapper>();
    
            for(integer i =(maxPages-1)*DEFAULT_PAGE_SIZE;i<QuestionWrapperList.size();i++)           
            {
                try{
                    subwrapperList.add(QuestionWrapperList[i]);
                }catch(exception e){}
            }
    
            startRecNo=((maxPages-1)*DEFAULT_PAGE_SIZE)+1;
            endRecNo=QuestionWrapperList.size();
            supplistsize = QuestionWrapperList.size();
    
            shownext = false;
            showprevoius = true;
            showlast=false;
            showfirst=true;
        }
        
        /****************************************************************
            METHOD INVOKED WHEN PAGE NUMBER IS CHANGED MANUALLY
        ****************************************************************/
        public void goToPage(){
            selectwrappsupp();
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
            subwrapperList = new list<QuestionWrapper>();
            if(pageNumber == maxPages){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<QuestionWrapperList.size(); i++)           
                {
                    try{
                        subwrapperList.add(QuestionWrapperList[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=QuestionWrapperList.size();
                supplistsize = QuestionWrapperList.size();
    
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
                        subwrapperList.add(QuestionWrapperList[i]);
                    }catch(exception e){}
                }
    
                startRecNo=1;
                endRecNo=DEFAULT_PAGE_SIZE;
                supplistsize = QuestionWrapperList.size();
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
                        subwrapperList.add(QuestionWrapperList[i]);
                    }catch(exception e){}
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
                supplistsize = QuestionWrapperList.size();
    
                shownext = true;
                showlast=true;
                showprevoius = true;
                showfirst=true;
            }
        }
        
    //*******************************************Pagination End***********************************//
    
    /****************************************************************
                METHOD INVOKED WHEN FIRST BUTTON IS CLICKED
        ****************************************************************/
        
        public void firstBtnClick2(){
            searchSuppliers();
            pageNumber2 = 1;
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
            //subwrapperList2 = new list<QuestionWrapper>();
    
            for(integer i=0;i<DEFAULT_PAGE_SIZE2;i++){
                try{
                    subwrapperList2.add(QuestionWrapperListSelected[i]);
                }catch(exception e){}
            }
            startRecNo2=1;
            endRecNo2=DEFAULT_PAGE_SIZE2;
            supplistsize2=QuestionWrapperListSelected.size();
    
            shownext2 = true;
            showprevoius2 = false;
            showlast2=true;
            showfirst2=false;
        }
        
        /****************************************************************
                METHOD INVOKED WHEN NEXT BUTTON IS CLICKED
        ****************************************************************/
        
        public void nextBtnClick2(){
            searchSuppliers();
            pageNumber2 = pageNumber2+1;
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
            //subwrapperList2 = new list<QuestionWrapper>();
            
            if(pageNumber2 == maxPages2){
                for(integer i=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2); i<QuestionWrapperListSelected.size(); i++)           
                {
                    try{
                        subwrapperList2.add(QuestionWrapperListSelected[i]);
                    }catch(exception e){}
                }
                shownext2 = false;
                showlast2=false;
    
                startRecNo2=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2)+1;
                endRecNo2=QuestionWrapperListSelected.size();
                supplistsize2=QuestionWrapperListSelected.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2); i<(DEFAULT_PAGE_SIZE2*pageNumber2); i++)           
                {
                    try{
                        subwrapperList2.add(QuestionWrapperListSelected[i]);
                    }catch(exception e){}
                }
    
                startRecNo2=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2)+1;
                endRecNo2=(DEFAULT_PAGE_SIZE2*pageNumber2);
                supplistsize2=QuestionWrapperListSelected.size();
                
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
            searchSuppliers();     
            pageNumber2 = pageNumber2-1;
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
            //subwrapperList2 = new list<QuestionWrapper>();
            
            for(integer i=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2); i<(DEFAULT_PAGE_SIZE2*pageNumber2); i++)           
            {
                try{
                    subwrapperList2.add(QuestionWrapperListSelected[i]);
                }catch(exception e){}
            }
    
            startRecNo2=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2)+1;
            endRecNo2=(DEFAULT_PAGE_SIZE2*pageNumber2);
            supplistsize2=QuestionWrapperListSelected.size();   
    
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
            searchSuppliers();
            pageNumber2 = maxPages2;
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
            //subwrapperList2 = new list<QuestionWrapper>();
    
            for(integer i =(maxPages2-1)*DEFAULT_PAGE_SIZE2;i<QuestionWrapperListSelected.size();i++)           
            {
                try{
                    subwrapperList2.add(QuestionWrapperListSelected[i]);
                }catch(exception e){}
            }
    
            startRecNo2=((maxPages2-1)*DEFAULT_PAGE_SIZE2)+1;
            endRecNo2=QuestionWrapperListSelected.size();
            supplistsize2=QuestionWrapperListSelected.size();
    
            shownext2 = false;
            showprevoius2 = true;
            showlast2=false;
            showfirst2=true;
        }
        
        /****************************************************************
            METHOD INVOKED WHEN PAGE NUMBER IS CHANGED MANUALLY
        ****************************************************************/
        public void goToPage2(){
            searchSuppliers();
            try
            {
                pageNumber2 = integer.valueOf(Apexpages.currentPage().getParameters().get('crntPageNum2').trim());
            }
            catch(exception ex)
            {
                pageNumber2=1;
            }
    
            if(pageNumber2>maxPages2)
                pageNumber2=maxPages2;
                
            if(pageNumber2<1)// to handle the negative digit as page number
                pageNumber2=1;
                
                
            subwrapperList2 = new list<QuestionWrapper>();
            if(pageNumber2 == maxPages2){
                for(integer i=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2); i<QuestionWrapperListSelected.size(); i++)           
                {
                    try{
                        subwrapperList2.add(QuestionWrapperListSelected[i]);
                    }catch(exception e){}
                }
    
                startRecNo2=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2)+1;
                endRecNo2=QuestionWrapperListSelected.size();
    
    
                if(pageNumber2==1)
                {
                    shownext2 = false;
                    showlast2=false;
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
                for(integer i =0;i<DEFAULT_PAGE_SIZE2;i++)           
                {
                    try{
                        subwrapperList2.add(QuestionWrapperListSelected[i]);
                    }catch(exception e){}
                }
    
                startRecNo2=1;
                endRecNo2=DEFAULT_PAGE_SIZE2;
                supplistsize2=QuestionWrapperListSelected.size();
                shownext2 = true;
                showlast2=true;
                showprevoius2 = false;
                showfirst2=false;  
            }
            else
            {
                for(integer i=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2); i<(DEFAULT_PAGE_SIZE2*pageNumber2); i++)           
                {
                    try{
                        subwrapperList2.add(QuestionWrapperListSelected[i]);
                    }catch(exception e){}
                }
    
                startRecNo2=((DEFAULT_PAGE_SIZE2*pageNumber2)-DEFAULT_PAGE_SIZE2)+1;
                endRecNo2=(DEFAULT_PAGE_SIZE2*pageNumber2);
                supplistsize2=QuestionWrapperListSelected.size();
    
                shownext2 = true;
                showlast2=true;
                showprevoius2 = true;
                showfirst2=true;
            }
        }
        
    //*******************************************Pagination End***********************************//     
    
    public void searchSuppliers(){
            isSearch = true;
            Map<String,String> AddedSupplierMap = new Map<String,String>();      
            
        
        if(supplierName !='' && supplierName !=Null){
            //*************initialization alpha list**********//
            AlphaList2 = new list<String>{'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'All'};
            DisplayQuestionWrapperList2 = new List<QuestionWrapper>();
            QuestionWrapperListSelected = new List<QuestionWrapper>();
            String searchString = supplierName;
            
            if   (searchString !=null && searchString.containsIgnoreCase('*'))
            {
              //searchString = searchString.replaceAll('[*]', '%');
            }
            
         if (supplierName != '' && supplierName != '*')
            {
          //*******************************Changes For Encryption***********************//
              
              /*List<Account> accountList = [SELECT Id, EnterpriseId__c, Name
                                             FROM Account  
                                             WHERE EnterpriseId__c LIKE: searchString AND
                                                  EnterpriseId__c not IN: existSupplier AND
                                                  ParentId = Null AND
                                                  EnterpriseId__c != null 
                                             LIMIT 100];*/
                                             
              /*List<Account> accountList = [SELECT Id, EnterpriseId__c, Name
                                             FROM Account  
                                             WHERE Id not IN: existSupplierId AND
                                                   ParentId = Null
                                             ];*/
                                             
              List<SPE_SurveyQuestion__c> accountList = [SELECT AnswerType__c,BUScope__c,Business__c,CategoryScope__c,CreatedById,CreatedDate,CurrencyIsoCode,Frequency__c,GeoScope__c,Id,IsActive__c,IsDeleted,IsRequired__c,Is_Translated__c,LastActivityDate,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,MaxScore__c,Name,OperationalType__c,OwnerId,Parent_Survey_Question__c,PIData__c,PIData__r.LifecycleStage__c,PIDefinition__c,PIType__c,QuestionAbbreviation__c,QuestionCode__c,QuestionLabel__c,Question_Bank__c,Secondary_Language__c,SurveyQueHeaderandSurveyQue__c,SurveyQuestion__c,SystemModstamp FROM SPE_SurveyQuestion__c where Is_Translated__c=false];                               
              Map<Id,List<SPE_PIDefinition__c>> mapPItoAllQues = new Map<Id,List<SPE_PIDefinition__c>>();
              List<SPE_PIDefinition__c> allPidef = new List<SPE_PIDefinition__c>();
              Set<Id> QId = new Set<ID>();
              Set<Id> tempQId = new Set<ID>();
              List<SPE_PIDefinition__c> tempPidef; 
              for(SPE_SurveyQuestion__c surv : accountList ){
              QID.add(surv.id);
              
              }  
              
            allPidef = [Select Id,Name,Frequency__c,SurveyQuestion__c,SurveyQuestion__r.ID,LifecycleStage__c,categoryscope__c from SPE_PIDefinition__c where SurveyQuestion__c in :Qid and DataAcquisitionMethod__c!='Survey'];  
             for(SPE_PIDefinition__c p : allPidef) {
                 if(!tempQId.contains(p.SurveyQuestion__r.ID)){
                 tempPidef = new List<SPE_PIDefinition__c>();
                 tempPidef.add(p);
                 mapPItoAllQues.put(p.SurveyQuestion__r.ID,tempPidef);
                 tempQId.add(p.SurveyQuestion__r.ID);
                 }
                 else{
                 tempPidef = mapPItoAllQues.get(p.SurveyQuestion__r.ID);
                 tempPidef.add(p);
                 mapPItoAllQues.put(p.SurveyQuestion__r.ID,tempPidef);
                 
                 }
             }                                                                                                   
              Pattern MyPattern = Pattern.compile('');
             
             if (searchString.substring(0,1) == '*' && searchString.substring(searchString.length()-1,searchString.length()) == '*')
             {
                if (searchString.length()>1)
                {
                    String Temp = searchString.subString(1, searchString.length());
                    searchString = Temp.replaceAll('[*]', '+');
                    MyPattern = Pattern.compile('(?i)'+searchString );
                }
             }
             else if (searchString.substring(0,1) != '*' && searchString.substring(searchString.length()-1,searchString.length()) == '*')
             {
                searchString = searchString.replaceAll('[*]', '+');
                MyPattern = Pattern.compile('(?i)\\A'+searchString);
             }
             
             else if (searchString.substring(0,1) == '*' && searchString.substring(searchString.length()-1,searchString.length()) != '*')
             {
                if (searchString.length()>1)
                {
                    String Temp = searchString.subString(1, searchString.length());
                    searchString = Temp + '+';
                    MyPattern = Pattern.compile('(?i)'+searchString +'\\z');
                }
             } 
             
             else if (searchString.substring(0,1) != '*' && searchString.substring(searchString.length()-1,searchString.length()) != '*')
             {
                 if (searchString.length()>1)
                {
                    MyPattern = Pattern.compile('(?i)\\A^'+searchString+'$');
                }
             }
         
          for (SPE_SurveyQuestion__c a: accountList)
            {
             if (a.QuestionLabel__c!= null)
             {   
                
                String s = a.QuestionLabel__c;
                Matcher MyMatcher = MyPattern.matcher(s);
                
                if (MyMatcher.find())
                {
                    if(mapPItoAllQues.containsKey(a.Id)){
                       if(mapPItoAllQues.get(a.Id).size()>1){
                   
                    for(Integer i=0 ;i<mapPItoAllQues.get(a.Id).size();i++){
                    QuestionWrapper sw = new QuestionWrapper();
                    sw.isChecked = false;
                    sw.strEnterpriseName = a.QuestionLabel__c;
                    sw.strSupplierName = a.Name;
                    sw.idEntId = a.Id;
                    sw.isExisting = false;
                    sw.SurveyQues = a.SurveyQuestion__c;
                    sw.ansType = a.answertype__c;
                    sw.isreq = a.IsRequired__c;
                    sw.piData = mapPItoAllQues.get(a.Id)[i];
                    sw.pidef = mapPItoAllQues.get(a.Id)[i].name;
                    sw.pidefStage = mapPItoAllQues.get(a.Id)[i].LifecycleStage__c;
                    sw.freq = mapPItoAllQues.get(a.Id)[i].frequency__c;
                    sw.catscope = mapPItoAllQues.get(a.Id)[i].categoryscope__c;
                     DisplayQuestionWrapperList2.add(sw);
                    }
                     }
                    else {
                    QuestionWrapper sw = new QuestionWrapper();
                    sw.isChecked = false;
                    sw.strEnterpriseName = a.QuestionLabel__c;
                    sw.strSupplierName = a.Name;
                    sw.idEntId = a.Id;
                    sw.isExisting = false;
                    sw.SurveyQues = a.SurveyQuestion__c;
                    sw.ansType = a.answertype__c;
                    sw.isreq = a.IsRequired__c;
                    sw.piData = mapPItoAllQues.get(a.Id)[0];
                    sw.pidef = mapPItoAllQues.get(a.Id)[0].name;
                    sw.pidefStage = mapPItoAllQues.get(a.Id)[0].LifecycleStage__c;
                    sw.freq = mapPItoAllQues.get(a.Id)[0].frequency__c; 
                    sw.catscope = mapPItoAllQues.get(a.Id)[0].categoryscope__c;
                     DisplayQuestionWrapperList2.add(sw);
                    }  
                    }
                    else{
                    QuestionWrapper sw = new QuestionWrapper();
                    sw.isChecked = false;
                    sw.strEnterpriseName = a.QuestionLabel__c;
                    sw.strSupplierName = a.Name;
                    sw.idEntId = a.Id;
                    sw.isExisting = false;
                    sw.SurveyQues = a.SurveyQuestion__c;
                    sw.ansType = a.answertype__c;
                    sw.isreq = a.IsRequired__c;
                    
                     DisplayQuestionWrapperList2.add(sw);
                    }
                    
                   
                }
              }  
            }
          }      
                                
                System.debug(LoggingLevel.ERROR,'+++++++++++++++++++'+DisplayQuestionWrapperList2.size()); 
                DisplayQuestionWrapperList2.sort();
                selectwrappsupp();
                /*if(DisplayQuestionWrapperList.size()>0)
                {
                    QuestionWrapperList.addAll(DisplayQuestionWrapperList); 
                }*/
                for(QuestionWrapper scw : QuestionWrapperList)
                {
                    AddedSupplierMap.put(scw.strSupplierName,scw.strSupplierName);
                }
                
                for(QuestionWrapper scws : DisplayQuestionWrapperList2)
                {
                    if(AddedSupplierMap.containsKey(scws.strSupplierName))
                    {
                        scws.isChecked  = True;
                        scws.isSelected = True;                        
                    }
                }
                    
                if(sortname2 == null || sortname2 == 'All') {                 
                 for(QuestionWrapper scOj : DisplayQuestionWrapperList2)
                     {
                         QuestionWrapperListSelected.add(scOj);
                     }
                 }else if(sortname2 != null && sortname2 != 'All'){
                     Pattern MyPattern2 = Pattern.compile('(?i)\\A^'+sortname2);                    
                     for(QuestionWrapper scOj : DisplayQuestionWrapperList2){
                       String sname2 = scOj.strSupplierName;
                       System.debug('$$$$$$$$$$$$$$$$$$$$$$'+sname2);
                       Matcher MyMatcher2 = MyPattern2.matcher(sname2);
                           if (MyMatcher2.find())
                           {
                                 QuestionWrapperListSelected.add(scOj);                                
                           }                                                                             
                     }
                 }    
            
        //******************************************END**********************************//          
        }
        else{
            isSearch = false;
            //isDisplayError = True;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'Please provide atleast one character for the wild card search'));
        }
    }
    
    //************************Method For Alphabaticall sorting*********************//
    public void alphasortname2(){
            DEFAULT_PAGE_SIZE2 = 10;
            pageNumber2 = 1;
            startRecNo2=0;
            endRecNo2=0;
            supplistsize2=0;
            shownext2=false;
            showprevoius2=false;
            showfirst2=false;
            showlast2=false;
            QuestionWrapperListSelected = new list<QuestionWrapper>();
            sortname2 = apexpages.currentpage().getparameters().get('alpha2');
                            
        //*****alpha filter, use page parameter or set default to all*****//
             if (sortname2 == null || sortname2 == 'All') {
                 subwrapperList2.clear();
                 subwrapperList2 = new list<QuestionWrapper>();
                 searchSuppliers();
                 if(QuestionWrapperListSelected.size()>0)
                 {
                 hasRecords2 = true;
                 integer remainder = math.MOD(QuestionWrapperListSelected.size(),DEFAULT_PAGE_SIZE2);
                     if(remainder ==0){
                        maxPages2 = QuestionWrapperListSelected.size()/DEFAULT_PAGE_SIZE2;
                     }
                     else{
                        maxPages2 = QuestionWrapperListSelected.size()/DEFAULT_PAGE_SIZE2 + 1;
                     }
         
                      if(QuestionWrapperListSelected.size() > DEFAULT_PAGE_SIZE2){
                            firstBtnClick2();      
                        }
                       else{
                            for(QuestionWrapper scOj : QuestionWrapperListSelected){
                                 subwrapperList2.add(scOj);
                             }
                             startRecNo2=1;
                             endRecNo2=QuestionWrapperListSelected.size();
                             supplistsize2=QuestionWrapperListSelected.size();
                             shownext2 = false;
                             showprevoius2 = false;
                        }
                 } 
             }else {
                subwrapperList2.clear();                
                subwrapperList2 = new list<QuestionWrapper>();
                searchSuppliers();
                 if(QuestionWrapperListSelected.size()>0)
                 {
                     System.debug('$$$$$$$$$$$$$$$$$$$$$$'+QuestionWrapperListSelected);                     
                     hasRecords2 = true;                         
                     integer remainder = math.MOD(QuestionWrapperListSelected.size(),DEFAULT_PAGE_SIZE2);
                     if(remainder ==0){
                        maxPages2 = QuestionWrapperListSelected.size()/DEFAULT_PAGE_SIZE2;
                     }
                     else{
                        maxPages2 = QuestionWrapperListSelected.size()/DEFAULT_PAGE_SIZE2 + 1;
                     }
         
                      if(QuestionWrapperListSelected.size() > DEFAULT_PAGE_SIZE2){
                            firstBtnClick2();      
                        }
                       else{
                            for(QuestionWrapper scOj1 : QuestionWrapperListSelected){
                                 subwrapperList2.add(scOj1);
                             }
                             startRecNo2=1;
                             endRecNo2=QuestionWrapperListSelected.size();
                             supplistsize2=QuestionWrapperListSelected.size();
                             shownext2 = false;
                             showprevoius2 = false;
                        }
                     }
                  }
                  if(QuestionWrapperListSelected.size() == 0)
                  {
                      
                      System.debug('Enter Here'+QuestionWrapperListSelected.size());
                      pageNumber2 = 0;
                      maxPages2 = 0;
                      supplistsize2=0;
                      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'No records to display'));
                  }
                  
    }
    
    public void addToMainList(){
           firstBtnClick();
    }
    
    public pagereference gotoDetailPage(){
            selectwrappsupp();
            lstSSM = new List<SPE2_Question_Survey_Association__c>();
            if(subwrapperList2.size() > 0)
            {
            for(QuestionWrapper sw : templistQuestionWrapper){
                if(sw.isChecked){
                    objSSM = new SPE2_Question_Survey_Association__c();
                    objSSM.Question_Bank__c = sw.idEntId;
                    objSSM.Survey__C =idSPEPlanID;
                    system.debug('pi data ---'+sw.PiData);
                     if(sw.PiData!=null)
                    objSSM.PIData__c = sw.PiData.ID;
                    objSSM.AnswerType__c = sw.ansType;
                    if(sw.idPlanSuppId != null)
                        objSSM.Id = sw.idPlanSuppId;
                    
                    lstSSM.add(objSSM);
                }
            }
          }
        else{
            if(subwrapperList2.size() == 0)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please add suppliers to proceed'));
            else
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please click "Add" button to add the suppliers to proceed'));
        }
        system.debug('lstSSM----' + lstSSM);
        if(!toDelete.isEmpty())
        {
            delete toDelete;
        }
        
        if(!lstSSM.isEmpty()){
            try{
                List<Decimal> lstOrder = new List<Decimal>();
                Decimal i;
                if(lstExistingSuppliers.size()>0){
                for(SPE2_Question_Survey_Association__c aso : lstExistingSuppliers){
                    lstOrder.add(aso.ordernumber__c);
                }
                lstOrder.sort();
                i=lstOrder[lstOrder.size()-1]+1;
                }
                else
                i =0;
                
                for(SPE2_Question_Survey_Association__c sw : lstSSM){
                    
                    if(sw.ordernumber__c == null){
                        sw.ordernumber__c = i;
                        i++;
                        }
                    }
                
                upsert lstSSM;  
                
            }
            catch(exception ex){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage()));
                return null;
            }
        }
            
        Pagereference pr = new Pagereference('/'+idSPEPlanID);
        pr.setRedirect(true);
        return pr;
    }
    
    public class QuestionWrapper implements Comparable
    {
        public Boolean isChecked {get;set;}
        public Boolean isSelected {get;set;}
        public String strEnterpriseName {get;set;}
        public String strSupplierName {get;set;}
        public Id idEntId{get;set;}
        public String SurveyQues {get;set;}  
        public String ansType {get;set;}
        public Boolean isReq {get;set;}    
        public String freq {get;set;}  
        Id idPlanSuppId;
        boolean isExisting;
        SPE2_Question_Survey_Association__c scMap;
        public SPE_PIDefinition__c piData{get; set;}
        public SPE2Survey__c surRec{get; set;}
        public String pidef{get;set;}
        public String pidefStage{get;set;}
        public String catscope {get;set;}
        public Integer compareTo(Object compareTo) {
        QuestionWrapper compareToSupp = (QuestionWrapper)compareTo;
        if (strSupplierName == compareToSupp.strSupplierName) return 0;
        if (strSupplierName > compareToSupp.strSupplierName) return 1;
        return -1;        
    }
    }
  }