public class SPE2_ValidateQuestionInSurveyExt{
   public List<SPE2_Question_Survey_Association__c> quesSurveyObj;
   public List<SPE2_Question_Survey_Association__c> quesSurveyObj2;
    public List<QuestionSurveyWrapper> lstQuesSurveyWrapper{get;set;}
    public Id surveyID {get;set;}
    Public Id QuesId {get;set;}
    public Id CurrentUserId {get;set;}
    public ID RecordOwnerId {get;set;}
    public integer DEFAULT_PAGE_SIZE{get;set;}
    public integer pageNumber2{get;set;}
    public integer maxPages2{get;set;}
    public integer startRecNo2 {get;set;}
    public integer endRecNo2 {get;set;}
    
    public boolean shownext2{get;set;}
    public boolean showprevoius2{get;set;}
    public boolean showfirst2{get;set;}
    public boolean showlast2{get;set;}   
    public List<QuestionSurveyWrapper> subwrapperList2{get;set;} 
    public String hasRecords{get;set;}
    public Id RecordId {get;set;}
    
    public String catarea;
    public String catgroup;
    public String cat;
    public String busUnit;
    public String busLine;
    public String prod;
    public String market;
    public String mktunit;
    public String cntry;
    public String proj;
    public List<SPE2Survey__c> surveyObj;
    
    public SPE2_ValidateQuestionInSurveyExt(ApexPages.StandardController st){
        DEFAULT_PAGE_SIZE = 20;
        pageNumber2 = 1;
        startRecNo2=0;
        endRecNo2=0;
        RecordId = st.getId();
        //supplistsize2=0;
        shownext2=false;
        showprevoius2=false;
        showfirst2=false;
        showlast2=false;
        hasRecords = 'false';
        subwrapperList2 = new list<QuestionSurveyWrapper>();
        lstQuesSurveyWrapper = new List<QuestionSurveyWrapper>();
        quesSurveyObj = new List<SPE2_Question_Survey_Association__c>();
        surveyObj = new List<SPE2Survey__c> ();
        
        surveyObj = [SELECT BusinessLine__c,BusinessUnit__c,CategoryArea__c,CategoryGroup__c,Category__c,Country__c,MarketUnit__c,
                    Market__c,Product__c,Project__c,Stage__c FROM SPE2Survey__c where id =:RecordID];
        CurrentUserId = UserInfo.getUserId();
        RecordOwnerId = [Select Id, ownerId from SPE2Survey__c 
                         WHERE Id =: RecordID].ownerId;
                         
        if(surveyObj.size()>0){
            catarea = surveyObj[0].CategoryArea__c;
            catgroup = surveyObj[0].CategoryGroup__c;
            cat = surveyObj[0].category__c;
            busUnit = surveyObj[0].BusinessUnit__c;
            busLine = surveyObj[0].BusinessLine__c;
            prod = surveyObj[0].Product__c;
            market = surveyObj[0].Market__c;
            mktunit = surveyObj[0].MarketUnit__c;
            cntry = surveyObj[0].Country__c;
            proj = surveyObj[0].Project__c;
        }            
        String query;
        query = 'SELECT ID,Question_Bank__c,Survey__c,PIData__c,PIData__r.DataAcquisitionMethod__c,Question_Bank__r.Name,'+
                 ' Question_Bank__r.QuestionLabel__c,Question_Bank__r.SurveyQuestion__c  from SPE2_Question_Survey_Association__c where Survey__c = :RecordId'+
                 ' and (PIData__r.DataAcquisitionMethod__c !=  \'Standalone Survey\' OR PIData__c = null ';
       
       system.debug('query is 1'+query);   
       if(catarea == 'All Category Areas'){
           query +=' OR '+'PIData__r.CategoryScope__c!=\'All Categories\'';
       
       }
       
       if(catarea != 'All Category Areas' && catgroup == 'All Category Groups'){
           query +=' OR '+'PIData__r.CategoryScope__c!=\'Category Area\'';
       
       }
       
       if(catarea != 'All Category Areas' && catgroup != 'All Category Groups' && cat == 'All Categories'){
           query +=' OR '+'PIData__r.CategoryScope__c!=\'Category Group\'';
       
       }
       
        if(catarea != 'All Category Areas' && catgroup != 'All Category Groups' && cat != 'All Categories'){
           query +=' OR '+'PIData__r.CategoryScope__c!=\'Category\'';
       
       }
       
       
       if(busUnit == 'All Business Units'){
           query +=' OR '+'PIData__r.BUScope__c!=\'All Products\'';
       
       }
       
       if(busUnit != 'All Business Units' && busLine == 'All Business Lines'){
           query +=' OR '+'PIData__r.BUScope__c!=\'Business Unit\'';
       
       }
       
        if(busUnit != 'All Business Units' && busLine != 'All Business Lines' && prod == 'All Products'){
           query +=' OR '+'PIData__r.BUScope__c!=\'Business Line\'';
       
       }
       
       if(busUnit != 'All Business Units' && busLine != 'All Business Lines' && prod != 'All Products'){
           query +=' OR '+'PIData__r.BUScope__c!=\'Product\'';
       
       }
       
        if(market == 'All Markets'){
           query +=' OR '+'PIData__r.GeoScope__c!=\'All Markets\')';
       
       }
       
       if(market != 'All Markets' && mktunit == 'All Market Units'){
           query +=' OR '+'PIData__r.GeoScope__c!=\'Market\')';
       
       }
       
       if(market != 'All Markets' && mktunit != 'All Market Units' && cntry == 'All Countries'){
           query +=' OR '+'PIData__r.GeoScope__c!=\'Market Unit\')';
       
       }
        if(market != 'All Markets' && mktunit != 'All Market Units' && cntry != 'All Countries' && proj == 'All Projects'){
           query +=' OR '+'PIData__r.GeoScope__c!=\'Country\')';
       
       }
       
       if(market != 'All Markets' && mktunit != 'All Market Units' && cntry != 'All Countries' && proj != 'All Projects'){
           query +=' OR '+'PIData__r.GeoScope__c!=\'Project\')';
       
       }
       
       
       system.debug('query is'+query);   
       
       quesSurveyObj = database.query(query);
       
       
           
    
    if(quesSurveyObj.size()>0){
       // quesSurveyObj.sort();
       hasRecords = 'true';
        for(SPE2_Question_Survey_Association__c spques : quesSurveyObj){
            lstQuesSurveyWrapper.add(new QuestionSurveyWrapper(spques,false));
            lstQuesSurveyWrapper.sort();
           
            pagination2();
        }
    }
    
  }  
  
   
  public void delQuestion(){
  Set<Id> delSurvID = new Set<ID>();
  system.debug('size of wrapper'+lstQuesSurveyWrapper.size());
  if(lstQuesSurveyWrapper.size()>0){
      for(Integer i = lstQuesSurveyWrapper.size()-1 ; i>=0;--i){
             if(lstQuesSurveyWrapper[i].isSelected == true){
              delSurvID.add(lstQuesSurveyWrapper[i].quesSurvey.ID);
              lstQuesSurveyWrapper.remove(i);
              system.debug('inside del');
          }
  
        }
        system.debug('to be delted'+lstQuesSurveyWrapper);
        if(delSurvID.size()>0){
         List<SPE2_Question_Survey_Association__c> lstsurvAss = [Select ID from SPE2_Question_Survey_Association__c where ID in :delSurvID];
            delete lstsurvAss ;
  
         } 
           
    }
    
     //  redirectPg();
  }
  public PageReference redirectPg(){
  system.debug('inside refresh');
    quesSurveyObj2 = new List<SPE2_Question_Survey_Association__c>();
        quesSurveyObj2 = [SELECT ID,Question_Bank__c,Survey__c,PIData__c,PIData__r.DataAcquisitionMethod__c,Question_Bank__r.Name,
                         Question_Bank__r.QuestionLabel__c,Question_Bank__r.SurveyQuestion__c from SPE2_Question_Survey_Association__c where Survey__c = :RecordId 
                         and (PIData__r.DataAcquisitionMethod__c != 'Standalone Survey' OR PIData__c = null)];
    
    if(quesSurveyObj2.size()>0){
     
   PageReference pg = new PageReference('/apex/SPE2_ValidateQuestionInSurvey?id='+RecordId);
   pg.setRedirect(true);
   return pg;
   }
   
   else{
        PageReference pg = new PageReference('/'+RecordId);
       pg.setRedirect(true);
       return pg;
       
       }
   }
   
   public PageReference convertToadhocPI(){
       surveyID = ApexPages.currentPage().getParameters().get('parm1name');
       QuesId = ApexPages.currentPage().getParameters().get('parm2name');
       PageReference pg = new PageReference('/apex/SPE2_ConvertQuestionToPIData?sid='+surveyID+'&QID='+QuesId);
       pg.setRedirect(true);
       return pg;
    }
public void pagination2(){
            if(!quesSurveyObj.isEmpty()){
               // system.debug('show scope---'+showScope);
            //--Determining total no of pages 
             integer remainder = math.MOD(quesSurveyObj.size(),DEFAULT_PAGE_SIZE);
             subwrapperList2.clear();
             if(remainder ==0){
                maxPages2 = quesSurveyObj.size()/DEFAULT_PAGE_SIZE;
             }
             else{
                maxPages2 = quesSurveyObj.size()/DEFAULT_PAGE_SIZE + 1;
             }
             system.debug('max pages ---'+maxPages2);
             system.debug('quesSurveyObj size'+quesSurveyObj);
             if(quesSurveyObj.size() > DEFAULT_PAGE_SIZE){
                firstBtnClick2();      
                system.debug('goin to first btn clk');
             }
             else{
                 for(QuestionSurveyWrapper scOj : lstQuesSurveyWrapper){
                     subwrapperList2.add(scOj);
                 }
                 startRecNo2=1;
                 endRecNo2=lstQuesSurveyWrapper.size();
    
                 shownext2 = false;
                 showprevoius2 = false;
                 system.debug('sub wrap----'+subwrapperList2.size());
            }
         }
         else{
            hasRecords = 'false';
           
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
            subwrapperList2 = new list<QuestionSurveyWrapper>();
    
            for(integer i =0;i<DEFAULT_PAGE_SIZE;i++){
                try{
                    subwrapperList2.add(lstQuesSurveyWrapper[i]);
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
            subwrapperList2 = new list<QuestionSurveyWrapper>();
            
            if(pageNumber2 == maxPages2){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<lstQuesSurveyWrapper.size(); i++)           
                {
                    try{
                        subwrapperList2.add(lstQuesSurveyWrapper[i]);
                    }catch(exception e){}
                }
                shownext2 = false;
                showlast2=false;
    
                startRecNo2=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE)+1;
                endRecNo2=lstQuesSurveyWrapper.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber2); i++)           
                {
                    try{
                        subwrapperList2.add(lstQuesSurveyWrapper[i]);
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
            subwrapperList2 = new list<QuestionSurveyWrapper>();
            
            for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber2); i++)           
            {
                try{
                    subwrapperList2.add(lstQuesSurveyWrapper[i]);
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
        subwrapperList2 = new list<QuestionSurveyWrapper>();

        for(integer i =(maxPages2-1)*DEFAULT_PAGE_SIZE;i<lstQuesSurveyWrapper.size();i++)           
        {
            try{
                subwrapperList2.add(lstQuesSurveyWrapper[i]);
            }catch(exception e){}
        }

        startRecNo2=((maxPages2-1)*DEFAULT_PAGE_SIZE)+1;
        endRecNo2=lstQuesSurveyWrapper.size();


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
                
                
            subwrapperList2 = new list<QuestionSurveyWrapper>();
            if(pageNumber2 == maxPages2){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<lstQuesSurveyWrapper.size(); i++)           
                {
                    try{
                        subwrapperList2.add(lstQuesSurveyWrapper[i]);
                    }catch(exception e){}
                }
    
                startRecNo2 =((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE)+1;
                endRecNo2=lstQuesSurveyWrapper.size();
    
    
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
                        subwrapperList2.add(lstQuesSurveyWrapper[i]);
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
                        subwrapperList2.add(lstQuesSurveyWrapper[i]);
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
    
 public class QuestionSurveyWrapper implements Comparable{
     public SPE2_Question_Survey_Association__c quesSurvey {get;set;}
     public Boolean isSelected {get;set;}
     public Boolean isInvalid {get;set;} 
     
     public QuestionSurveyWrapper(SPE2_Question_Survey_Association__c qu,Boolean x){
         quesSurvey = qu;
         isSelected = x;
       //  isInvalid = y;
         
     
     }  
     
      public Integer compareTo(Object compareTo) {
         QuestionSurveyWrapper compareToSupp = (QuestionSurveyWrapper)compareTo;
        if (quesSurvey.Question_Bank__r.Name== compareToSupp.quesSurvey.Question_Bank__r.Name) return 0;
        if (quesSurvey.Question_Bank__r.Name> compareToSupp.quesSurvey.Question_Bank__r.Name) return 1;
        return -1;        
    }
        
        
 }   
}