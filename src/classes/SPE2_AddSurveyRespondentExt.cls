public with sharing class SPE2_AddSurveyRespondentExt 
{   
    public List<RespondentWrapper> respondentWrapperList {get;set;}    
    private Id surveyId;    
    private SPE2Survey__c speSurvey;
    public String contactName {get;set;}    
    private Set<Id> existContactIds = new Set<Id>();    
    public List<SPE2_Question_Survey_Association__c> existingSQA;
    public List<SPE2_Question_Survey_Association__c> lstSQAToInsert;
    public SPE2_Question_Survey_Association__c tempObjSQA;
    public Set<Id> existingPIDefIds;
    public SPE2_Question_Survey_Association__c objSQA;
    public List<SPE2_Question_Survey_Association__c> lstSQA;

    public integer DEFAULT_PAGE_SIZE{get;set;}
    public integer pageNumber2{get;set;}
    public integer maxPages2{get;set;}
    public integer startRecNo2 {get;set;}
    public integer endRecNo2 {get;set;}
    public boolean hasRecords2{get;set;}
    public boolean shownext2{get;set;}
    public boolean showprevoius2{get;set;}
    public boolean showfirst2{get;set;}
    public boolean showlast2{get;set;}   
    public List<RespondentWrapper> subwrapperList2{get;set;} 
    public Boolean hasRecords{get;set;}

    public SPE2_AddSurveyRespondentExt(Apexpages.Standardcontroller st)
    {   
        DEFAULT_PAGE_SIZE = 50;
        pageNumber2 = 1;
        startRecNo2=0;
        endRecNo2=0;
        //supplistsize2=0;
        shownext2=false;
        showprevoius2=false;
        showfirst2=false;
        showlast2=false;
        hasRecords = false;
        subwrapperList2 = new List<RespondentWrapper>();
        respondentWrapperList = new List<RespondentWrapper>();        
         
        surveyId = st.getId();
        speSurvey = [SELECT Id, CategoryArea__c, CategoryGroup__c, Category__c
                   FROM SPE2Survey__c
                   WHERE Id =: surveyId];
                   
            addRespondent ();         
    }   
    
    public void addRespondent()
    {
        
        DEFAULT_PAGE_SIZE = 50;
        pageNumber2 = 1;
        startRecNo2=0;
        endRecNo2=0;
        //supplistsize2=0;
        shownext2=false;
        showprevoius2=false;
        showfirst2=false;
        showlast2=false;
        hasRecords = false;
        subwrapperList2 = new List<RespondentWrapper>();
        respondentWrapperList = new List<RespondentWrapper>();
        
        List<SPE2_Survey_Respondents__c> respondents = [SELECT Id, Contact__c, Contact__r.Email, Contact__r.FirstName, Contact__r.LastName 
                                                       FROM SPE2_Survey_Respondents__c
                                                       WHERE Survey__c =: surveyId];
        for (SPE2_Survey_Respondents__c res: respondents)
        {
            existContactIds.add(res.Contact__c);
        }
        
        List<Contact> contactRespondentList = [SELECT Id, Email, FirstName, LastName, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c FROM Categories_Info__r ) cat
                                               FROM Contact  
                                               WHERE Id In: existContactIds 
                                              ];
                                    
        Map<Id, List<SPE_CategoryInfo__c>> contactCategoriesMap = new Map<Id, List<SPE_CategoryInfo__c>>();
        
        for (Contact c: contactRespondentList)
        {
            contactCategoriesMap.put(c.Id, c.Categories_Info__r);
        }
        
        for (SPE2_Survey_Respondents__c res: respondents)
        {
            RespondentWrapper rw = new RespondentWrapper(res,contactCategoriesMap.get(res.Contact__c));
            rw.isChecked = true;
            respondentWrapperList.add(rw);
          
        }
        
        Set<Id> contactsIds = new Set<Id>();
        
        for (SPE_CategoryInfo__c cat : [SELECT Category__c, CategoryCluster__c, CategoryGroup__c, Contact__c 
                                        FROM SPE_CategoryInfo__c
                                        WHERE ((CategoryCluster__c =: speSurvey.CategoryArea__c AND CategoryGroup__c = null AND Category__c = null) OR
                                               (CategoryCluster__c =: speSurvey.CategoryArea__c AND CategoryGroup__c =: speSurvey.CategoryGroup__c AND Category__c = null) OR
                                               (CategoryCluster__c =: speSurvey.CategoryArea__c AND CategoryGroup__c =: speSurvey.CategoryGroup__c AND Category__c =: speSurvey.Category__c)
                                              ) AND
                                                Contact__c not In: existContactIds AND
                                                Contact__c != null])
        {
            contactsIds.add(cat.Contact__c);
        }
        
        
        List<SPE2_SurveySupplierMap__c> planSupplier = [SELECT Id, Supplier__c, Supplier__r.SupplierManager__c
                                                        FROM SPE2_SurveySupplierMap__c
                                                        WHERE SPE2_Survey__c =: surveyId ];
        
        for (SPE2_SurveySupplierMap__c sup: planSupplier)
        {
            contactsIds.add(sup.Supplier__r.SupplierManager__c);
        }
        
        
        List<Contact> contactList = [SELECT Id, Email, FirstName, LastName, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c FROM Categories_Info__r ) cat
                                     FROM Contact  
                                     Where Id In: contactsIds AND
                                           Id not In: existContactIds 
                                    ];
        
        for (Contact c : contactList)
        {
            RespondentWrapper res = new RespondentWrapper(c, c.Categories_Info__r);
            
            respondentWrapperList.add(res);
            
            existContactIds.add(c.Id);            
        }
        
        if(!respondentWrapperList.isEmpty()){
            hasRecords = true;
             Integer remainder;   
             
             if(remainder==0){
                maxPages2 = respondentWrapperList.size()/DEFAULT_PAGE_SIZE;
             }
             else{
                maxPages2 = respondentWrapperList.size()/DEFAULT_PAGE_SIZE + 1;
             }
             if(respondentWrapperList.size() > DEFAULT_PAGE_SIZE){
                firstBtnClick2();      
                system.debug('goin to first btn clk');
             }
             else{
                 for(RespondentWrapper scOj : respondentWrapperList){
                     subwrapperList2.add(scOj);
                 }
                 startRecNo2=1;
                 endRecNo2=respondentWrapperList.size();
    
                 shownext2 = false;
                 showprevoius2 = false;
                 system.debug('sub wrap----'+subwrapperList2.size());
            }
         }
         else{
            hasRecords = false;
           
        }
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
            subwrapperList2 = new list<RespondentWrapper>();
    
            for(integer i =0;i<DEFAULT_PAGE_SIZE;i++){
                try{
                    subwrapperList2.add(respondentWrapperList[i]);
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
            subwrapperList2 = new list<RespondentWrapper>();
            
            if(pageNumber2 == maxPages2){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<respondentWrapperList.size(); i++)           
                {
                    try{
                        subwrapperList2.add(respondentWrapperList[i]);
                    }catch(exception e){}
                }
                shownext2 = false;
                showlast2=false;
    
                startRecNo2=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE)+1;
                endRecNo2=respondentWrapperList.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber2); i++)           
                {
                    try{
                        subwrapperList2.add(respondentWrapperList[i]);
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
            subwrapperList2 = new list<RespondentWrapper>();
            
            for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber2); i++)           
            {
                try{
                    subwrapperList2.add(respondentWrapperList[i]);
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
        subwrapperList2 = new list<RespondentWrapper>();

        for(integer i =(maxPages2-1)*DEFAULT_PAGE_SIZE;i<respondentWrapperList.size();i++)           
        {
            try{
                subwrapperList2.add(respondentWrapperList[i]);
            }catch(exception e){}
        }

        startRecNo2=((maxPages2-1)*DEFAULT_PAGE_SIZE)+1;
        endRecNo2=respondentWrapperList.size();


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
                
                
            subwrapperList2 = new list<RespondentWrapper>();
            if(pageNumber2 == maxPages2){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<respondentWrapperList.size(); i++)           
                {
                    try{
                        subwrapperList2.add(respondentWrapperList[i]);
                    }catch(exception e){}
                }
    
                startRecNo2 =((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE)+1;
                endRecNo2=respondentWrapperList.size();
    
    
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
                        subwrapperList2.add(respondentWrapperList[i]);
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
                        subwrapperList2.add(respondentWrapperList[i]);
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
        
    
    public void searchRespondent ()
    {
        system.debug('IN Method---');
        DEFAULT_PAGE_SIZE = 50;
        pageNumber2 = 1;
        startRecNo2=0;
        endRecNo2=0;
        //supplistsize2=0;
        shownext2=false;
        showprevoius2=false;
        showfirst2=false;
        showlast2=false;
        hasRecords = false;
        subwrapperList2.clear();
        subwrapperList2 = new List<RespondentWrapper>();
        
        List<RespondentWrapper> selectedRespondent = new List<RespondentWrapper>();
        
        List<SPE2_Survey_Respondents__c> toBeDeletedRespondent = new List<SPE2_Survey_Respondents__c>();
        
        selectedRespondent.addAll(respondentWrapperList);
        
        respondentWrapperList.clear();
        respondentWrapperList = new List<RespondentWrapper>();
        
        for (RespondentWrapper r : selectedRespondent)
        {
            if (r.isChecked)
            {
                respondentWrapperList.add(r);
            }
            else
            {
                if (r.res.Id != null)
                {
                    toBeDeletedRespondent.add(r.res);
                }
                existContactIds.remove(r.res.Contact__c);
            }
        }
        
        delete toBeDeletedRespondent;
        
        //respondentWrapperList = new List<RespondentWrapper>();
        String searchString = contactName;
        
        if  (searchString !=null && searchString.containsIgnoreCase('*'))
        {
            searchString = searchString.replaceAll('[*]', '%');
        }
        
        if (contactName != '' && contactName != '*')
        {
           List<Contact> contactList = [SELECT Id, Email, FirstName, LastName, (SELECT Category__c, CategoryCluster__c, CategoryGroup__c FROM Categories_Info__r ) cat
                                         FROM Contact  
                                         WHERE (FirstName LIKE: searchString OR LastName LIKE: searchString)  AND
                                               Id not IN: existContactIds
                                               LIMIT 100 ];
                                               
            for (Contact c : contactList)
            {
                RespondentWrapper res = new RespondentWrapper(c, c.Categories_Info__r);
                respondentWrapperList.add(res);
                existContactIds.add(c.Id);
            }   
        }
        system.debug('respondentWrapperList----' + respondentWrapperList);
        
        if(!respondentWrapperList.isEmpty()){
             hasRecords = true;
             Integer remainder;   
             
             if(remainder==0){
                maxPages2 = respondentWrapperList.size()/DEFAULT_PAGE_SIZE;
             }
             else{
                maxPages2 = respondentWrapperList.size()/DEFAULT_PAGE_SIZE + 1;
             }
             if(respondentWrapperList.size() > DEFAULT_PAGE_SIZE){
                firstBtnClick2();      
                system.debug('goin to first btn clk');
             }
             else{
                 for(RespondentWrapper scOj : respondentWrapperList){
                     subwrapperList2.add(scOj);
                 }
                 startRecNo2=1;
                 endRecNo2=respondentWrapperList.size();
    
                 shownext2 = false;
                 showprevoius2 = false;
                 system.debug('sub wrap----'+subwrapperList2.size());
            }
         }
         else{
            hasRecords = false;
           
        }
    }
    
    
    public Pagereference insertRespondent()
    {
        List<SPE2_Survey_Respondents__c> toBeCreatedRespondent = createRespondent(respondentWrapperList);
        List<SPE2_Survey_Respondents__c> toBeInsertedRespondent = new List<SPE2_Survey_Respondents__c>();
        List<SPE2_Survey_Respondents__c> toBeUpdatedRespondent = new List<SPE2_Survey_Respondents__c>();
        for(SPE2_Survey_Respondents__c s : toBeCreatedRespondent){
            if(s.Id!= null)
                toBeUpdatedRespondent.add(s);
            else
                toBeInsertedRespondent.add(s);
        }
        try{
            insert toBeInsertedRespondent;
            update toBeUpdatedRespondent;
            System.debug('toBeCreatedRespondent--' + toBeCreatedRespondent);
            lstSQA = new List<SPE2_Question_Survey_Association__c>();
            for(SPE2_Survey_Respondents__c sR : toBeInsertedRespondent){
                if(sR.Id != null){
                    objSQA = new SPE2_Question_Survey_Association__c();
                    objSQA.Survey__c = surveyId;
                   // objSQA.SurveyRespondent__c = sR.Id;
                   // objSQA.Is_Required__c = true;
                    lstSQA.add(objSQA);
                }
            }
            if(!lstSQA.isEmpty()){
                try{
                    existingSQA = new List<SPE2_Question_Survey_Association__c>();
                    lstSQAToInsert = new List<SPE2_Question_Survey_Association__c>();
                    existingPIDefIds = new Set<Id>();
                    existingSQA = [select id,Question_Bank__c,Survey__c from SPE2_Question_Survey_Association__c 
                                    where Survey__c=:surveyId AND SurveyRespondent__c = null AND Question_Bank__c != null];
                    
                    List<SPE2_SurveySupplierMap__c> lstSupMap = new List<SPE2_SurveySupplierMap__c>();
                    lstSupMap = [select id,Supplier__c,SPE2_Survey__c from SPE2_SurveySupplierMap__c where SPE2_Survey__c = : surveyId];
                    
                    Set<Id> existingSuppIds = new Set<Id>();
                    for(SPE2_SurveySupplierMap__c objSSM : lstSupMap){
                        existingSuppIds.add(objSSM.Supplier__c);
                    }
                    
                    List<PI_Survey_Association__c> existingPISA = new List<PI_Survey_Association__c>();
                    existingPISA = [SELECT Id, PIData__c,SPE2_Survey__c
                                               FROM PI_Survey_Association__c
                                               WHERE SPE2_Survey__c =: surveyId];
                    
                    for(PI_Survey_Association__c objPISA : existingPISA){
                        existingPIDefIds.add(objPISA.PIData__c);
                    }
                    List<SPE_PIDefinition__c> lstEstPID = new List<SPE_PIDefinition__c>();
                    Map<Id,Id> mapPIDefQuesId = new Map<Id,Id>();
                    lstEstPID = [select id,SurveyQuestion__c from SPE_PIDefinition__c where ID IN : existingPIDefIds];
                    for(SPE_PIDefinition__c s : lstEstPID){
                        mapPIDefQuesId.put(s.id,s.SurveyQuestion__c);
                    }
                    if(!lstSupMap.isEmpty() && !existingPISA.isEmpty()){
                        for(SPE2_Question_Survey_Association__c s : lstSQA){
                            for(Id i : existingPIDefIds){
                               for(Id j : existingSuppIds){
                                   tempObjSQA = new SPE2_Question_Survey_Association__c();
                                   tempObjSQA.Survey__c = surveyId;
                                   tempObjSQA.Question_Bank__c = mapPIDefQuesId.get(i);
                                  // tempObjSQA.SurveyRespondent__c = s.SurveyRespondent__c;
                                  // tempObjSQA.Supplier__c = j;
                                  // tempObjSQA.PIData__c = i;
                                  // tempObjSQA.Is_Required__c = false;
                                  // tempObjSQA.Is_Active__c = true;
                                   lstSQAToInsert.add(tempObjSQA);
                               }
                            }
                        }
                    }
                    /*if(lstSQAToInsert.isEmpty())
                        lstSQAToInsert.addAll(lstSQA);
                    if(!existingSQA.isEmpty())
                        delete existingSQA;*/
                    if(!lstSQAToInsert.isEmpty())
                        insert lstSQAToInsert;
                    System.debug('existingSQA---' + existingSQA);
                    System.debug('lstSQAToInsert---' + lstSQAToInsert);
                }catch(exception ex){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage()));
                    return null;
                }
            }
        }catch(exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage()));
            return null;
        }
           
        Pagereference pr = new Pagereference('/'+surveyId);
        return pr;
    }
          
    public Pagereference cancel()
    {
        Pagereference pr = new Pagereference('/'+surveyId);
        pr.setRedirect(true);
        return pr;
    }
    @TestVisible
    private List<SPE2_Survey_Respondents__c> createRespondent (List<RespondentWrapper> respondentWrapperList)
    {        
        List<SPE2_Survey_Respondents__c> toBeCreatedRespondent = new List<SPE2_Survey_Respondents__c>();        
        List<SPE2_Survey_Respondents__c> toBeDeletedRespondent = new List<SPE2_Survey_Respondents__c>();        
        for (RespondentWrapper rw : respondentWrapperList)
        {
            if (rw.isChecked)
            {
                rw.res.Survey__c = surveyId;
                toBeCreatedRespondent.add(rw.res);
            }
            else if (rw.isChecked == false && rw.res.Id != null)
            {
                toBeDeletedRespondent.add(rw.res);
            }
        }        
        delete toBeDeletedRespondent;        
        return toBeCreatedRespondent;
    }
    
    public class RespondentWrapper
    {
        public SPE2_Survey_Respondents__c res {get;set;}
        public Boolean isChecked {get;set;}
        public List<SPE_CategoryInfo__c> categories {get;set;}
        
        public RespondentWrapper (SPE2_Survey_Respondents__c res, List<SPE_CategoryInfo__c> cat)
        {
            this.res = res;
            isChecked = true;
            categories = cat;            
        }        
        public RespondentWrapper (Contact con, List<SPE_CategoryInfo__c> cat)
        {
            res = new SPE2_Survey_Respondents__c();
            res.Contact__c = con.Id;
            res.contact__r = con;
            
            categories = new List<SPE_CategoryInfo__c>();
            categories = cat;            
            isChecked = false;
        }
    }
}