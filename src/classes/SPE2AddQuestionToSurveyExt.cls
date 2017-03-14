public with sharing class SPE2AddQuestionToSurveyExt{
//---------Variable Declaration----------------
    public List<SPE_SurveyQuestion__c> lstSurveyQuestion;
    public List<SPE_SurveyQuestion__c> lstSearchSurveyQuestions;
    public List<QuestionWrapper> lstQuestionWrapper {get;set;}
    public List<QuestionWrapper> lstSearchQuestionWrapper {get;set;}
    public List<QuestionWrapper> subwrapperList{get;set;}
    public List<QuestionWrapper> subwrapperList2{get;set;}
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
    //-------pagination 2 var---------------
    public integer pageNumber2{get;set;}
    public integer maxPages2{get;set;}
    public integer startRecNo2 {get;set;}
    public integer endRecNo2 {get;set;}
    public boolean hasRecords2{get;set;}
    public boolean shownext2{get;set;}
    public boolean showprevoius2{get;set;}
    public boolean showfirst2{get;set;}
    public boolean showlast2{get;set;}
    //------------------
    public String searchQue {get;set;}
    //--------------------------------
    public Boolean firstdefaultSec {get;set;}
    public Boolean searchRecords{get;set;}
    
      
    public SPE2AddQuestionToSurveyExt(ApexPages.StandardController controller){
      lstSurveyQuestion  = new List<SPE_SurveyQuestion__c>(); 
      lstQuestionWrapper = new List<QuestionWrapper>();
      subwrapperList = new List<QuestionWrapper>();
      DEFAULT_PAGE_SIZE = 5;
     pageNumber = 1;
     startRecNo=0;
     endRecNo=0;
     shownext=false;
     showprevoius=false;
     showfirst=false;
     showlast=false;
     pageNumber2= 1;
     startRecNo2 =0;
     endRecNo2=0;
     shownext2=false;
     showprevoius2=false;
     showfirst2 =false;
     showlast2=false;
     firstdefaultSec = true; 
     searchRecords = false;
      lstSurveyQuestion  = [ SELECT AnswerType__c,BUScope__c,Business__c,CategoryScope__c,Frequency__c,GeoScope__c,Id,IsRequired__c,Is_Translated__c,MaxScore__c,Name,OperationalType__c,Parent_Survey_Question__c,PIData__c,PIDefinition__c,PIType__c,QuestionAbbreviation__c,QuestionCode__c,QuestionLabel__c,Question_Bank__c,Secondary_Language__c,SurveyQueHeaderandSurveyQue__c,SurveyQuestion__c FROM SPE_SurveyQuestion__c ];
      if(lstSurveyQuestion.size()>0){
          for(SPE_SurveyQuestion__c survQ : lstSurveyQuestion ){
              lstQuestionWrapper.add(new QuestionWrapper(survQ));
          }
          pagination();

      }
      
      
    }
    
   public  void pagination(){
       if(!lstSurveyQuestion.isEmpty()){
             hasRecords = true;
             searchRecords = false;
             // Determining total no of pages 
             integer remainder = math.MOD(lstSurveyQuestion.size(),DEFAULT_PAGE_SIZE);
             if(remainder ==0){
                maxPages = lstSurveyQuestion.size()/DEFAULT_PAGE_SIZE;
             }
             else{
                maxPages = lstSurveyQuestion.size()/DEFAULT_PAGE_SIZE + 1;
             }
             for(SPE_SurveyQuestion__c scObj : lstSurveyQuestion){
                lstQuestionWrapper.add(new QuestionWrapper(scObj));
             }
             if(lstSurveyQuestion.size() > DEFAULT_PAGE_SIZE){
                firstBtnClick();      
             }
             else{
                 for(QuestionWrapper scOj : lstQuestionWrapper){
                     subwrapperList.add(scOj);
                 }
                 startRecNo=1;
                 endRecNo=lstQuestionWrapper.size();
    
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
            subwrapperList = new list<QuestionWrapper>();
    
            for(integer i =0;i<DEFAULT_PAGE_SIZE;i++){
                subwrapperList.add(lstQuestionWrapper[i]);
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
            subwrapperList = new list<QuestionWrapper>();
            
            if(pageNumber == maxPages){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<lstQuestionWrapper.size(); i++)           
                {
                    subwrapperList.add(lstQuestionWrapper[i]);
                }
                shownext = false;
                showlast=false;
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=lstQuestionWrapper.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
                {
                    subwrapperList.add(lstQuestionWrapper[i]);
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
            subwrapperList = new list<QuestionWrapper>();
            
            for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber); i++)           
            {
                subwrapperList.add(lstQuestionWrapper[i]);
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
        subwrapperList = new list<QuestionWrapper>();

        for(integer i =(maxPages-1)*DEFAULT_PAGE_SIZE;i<lstQuestionWrapper.size();i++)           
        {
            subwrapperList.add(lstQuestionWrapper[i]);
        }

        startRecNo=((maxPages-1)*DEFAULT_PAGE_SIZE)+1;
        endRecNo=lstQuestionWrapper.size();


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
                
                
            subwrapperList = new list<QuestionWrapper>();
            if(pageNumber == maxPages){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE); i<lstQuestionWrapper.size(); i++)           
                {
                    subwrapperList.add(lstQuestionWrapper[i]);
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=lstQuestionWrapper.size();
    
    
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
                    subwrapperList.add(lstQuestionWrapper[i]);
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
                    subwrapperList.add(lstQuestionWrapper[i]);
                }
    
                startRecNo=((DEFAULT_PAGE_SIZE*pageNumber)-DEFAULT_PAGE_SIZE)+1;
                endRecNo=(DEFAULT_PAGE_SIZE*pageNumber);
    
    
                shownext = true;
                showlast=true;
                showprevoius = true;
                showfirst=true;
            }
        }
        
    public void Search(){
    lstSearchSurveyQuestions = new List<SPE_SurveyQuestion__c>();
    lstSearchQuestionWrapper = new List<QuestionWrapper>();
    String searchSTR = '%'+searchQue+'%';
    if(searchQue ==''){
        firstdefaultSec = false;
    }
     lstSearchSurveyQuestions = [ SELECT AnswerType__c,BUScope__c,Business__c,CategoryScope__c,Frequency__c,GeoScope__c,Id,
                         IsRequired__c,Is_Translated__c,MaxScore__c,Name,OperationalType__c,Parent_Survey_Question__c,PIData__c,
                         PIDefinition__c,PIType__c,QuestionAbbreviation__c,QuestionCode__c,QuestionLabel__c,Question_Bank__c,Secondary_Language__c,
                         SurveyQueHeaderandSurveyQue__c,SurveyQuestion__c FROM SPE_SurveyQuestion__c where QuestionLabel__c like :searchSTR];
    if(lstSearchSurveyQuestions.size()>0){
        searchRecords = true;
        firstdefaultSec = false;
        for(SPE_SurveyQuestion__c survQ : lstSearchSurveyQuestions){
              lstSearchQuestionWrapper.add(new QuestionWrapper(survQ));
          }
          pagination2();

      }
    
    }
     public  void pagination2(){
       if(!lstSearchSurveyQuestions.isEmpty()){
             searchRecords = true;
             subwrapperList2 = new list<QuestionWrapper>();
             // Determining total no of pages 
             integer remainder2 = math.MOD(lstSearchSurveyQuestions.size(),DEFAULT_PAGE_SIZE);
             if(remainder2 ==0){
                maxPages2 = lstSearchSurveyQuestions.size()/DEFAULT_PAGE_SIZE;
             }
             else{
                maxPages2 = lstSearchSurveyQuestions.size()/DEFAULT_PAGE_SIZE + 1;
             }
             for(SPE_SurveyQuestion__c scObj : lstSearchSurveyQuestions){
                lstSearchQuestionWrapper.add(new QuestionWrapper(scObj));
             }
             if(lstSearchSurveyQuestions.size() > DEFAULT_PAGE_SIZE){
                firstBtnClick2();      
             }
             else{
                 for(QuestionWrapper scOj : lstSearchQuestionWrapper){
                     subwrapperList2.add(scOj);
                 }
                 startRecNo2=1;
                 endRecNo2=lstSearchQuestionWrapper.size();
    
                 shownext2 = false;
                 showprevoius2 = false;
            }
         }
     else{
        searchRecords = false;
    }
 
   }
   
       /****************************************************************
                METHOD INVOKED WHEN FIRST BUTTON IS CLICKED
     ****************************************************************/
        
        public void firstBtnClick2(){
            pageNumber2 = 1;
            //showMessage=false;
            System.debug('pageNumber2----->' + pageNumber2);
            subwrapperList2.clear();
            subwrapperList2 = new list<QuestionWrapper>();
    
            for(integer i =0;i<DEFAULT_PAGE_SIZE;i++){
                subwrapperList2.add(lstSearchQuestionWrapper[i]);
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
            subwrapperList2 = new list<QuestionWrapper>();
            
            if(pageNumber2 == maxPages2){
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<lstSearchQuestionWrapper.size(); i++)           
                {
                    subwrapperList2.add(lstSearchQuestionWrapper[i]);
                }
                shownext2 = false;
                showlast2=false;
    
                startRecNo2=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE)+1;
                endRecNo2=lstSearchQuestionWrapper.size();
            }
            else{
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber2); i++)           
                {
                    subwrapperList2.add(lstSearchQuestionWrapper[i]);
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
            subwrapperList2 = new list<QuestionWrapper>();
            
            for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<(DEFAULT_PAGE_SIZE*pageNumber2); i++)           
            {
                subwrapperList2.add(lstSearchQuestionWrapper[i]);
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
        subwrapperList2 = new list<QuestionWrapper>();

        for(integer i =(maxPages2-1)*DEFAULT_PAGE_SIZE;i<lstSearchQuestionWrapper.size();i++)           
        {
            subwrapperList2.add(lstSearchQuestionWrapper[i]);
        }

        startRecNo2=((maxPages2-1)*DEFAULT_PAGE_SIZE)+1;
        endRecNo2=lstSearchQuestionWrapper.size();


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
                pageNumber2=integer.valueOf(Apexpages.currentPage().getParameters().get('crntPageNum2').trim());
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
                for(integer i=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE); i<lstSearchQuestionWrapper.size(); i++)           
                {
                    subwrapperList2.add(lstSearchQuestionWrapper[i]);
                }
    
                startRecNo2=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE)+1;
                endRecNo2=lstSearchQuestionWrapper.size();
    
    
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
                for(integer i =0;i<DEFAULT_PAGE_SIZE;i++)           
                {
                    subwrapperList2.add(lstSearchQuestionWrapper[i]);
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
                    subwrapperList2.add(lstSearchQuestionWrapper[i]);
                }
    
                startRecNo2=((DEFAULT_PAGE_SIZE*pageNumber2)-DEFAULT_PAGE_SIZE)+1;
                endRecNo2=(DEFAULT_PAGE_SIZE*pageNumber2);
    
    
                shownext2 = true;
                showlast2=true;
                showprevoius2 = true;
                showfirst2=true;
            }
        }  
        
     /****************************************************************
                        WRAPPER CLASS
        ****************************************************************/
        public class QuestionWrapper
        {
            public SPE_SurveyQuestion__c surveyQue{get; set;}
            public Boolean isSelected{get; set;}
            public Boolean Error{get;set;}
            public Boolean isChecked {get;set;}
            
            public QuestionWrapper(SPE_SurveyQuestion__c sc)
            {
                surveyQue = sc;
                isSelected = false;
                
            }
        }


}