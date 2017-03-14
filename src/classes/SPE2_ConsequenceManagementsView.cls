public without sharing class SPE2_ConsequenceManagementsView 
{

    public Boolean isReadonly { get; set; }
    public Boolean disableInput { get; set; }
    public SPE_ConsequenceManagement__c ccm{get; set;}
    public Boolean isPassword {get;set;} 
    public String password {get;set;}
    public List<SPE_ConsequenceManagement__c> otherCMsTicket {get;set;}
    
    public String supplierName{ get; set; }
    public String kpiTitle{ get; set; }
    //------------Changes for Language------
    public string selectedValue {get;set;}
    public List<SelectOption> statusOptions {get;set;}
    public boolean showOptions {get;set;}
    public List<SPE2_Language_KPI__c> altrLang{get;set;}
    Private List<SPE2_LanguageList__c> languages;   
    private Id idCMRecord;
    
    public SPE2_ConsequenceManagementsView()
    {
        Map<String, String> parameterMaps = new Map<String, String>();
        parameterMaps = ApexPages.currentPage().getParameters();
        idCMRecord = parameterMaps.get('Id');
      
     //***********************************Changes For Encryption*********************************//   
        ccm = [SELECT Name, Contact__c,TicketStatus__c, Contact__r.Name,Market__c,MarketUnit__c,Country__c,Project__c,Category__c,BusinessLine__c,BusinessUnit__c,CategoryManager__c,Product__c, CurrentStage__c, Password__c, CategoryArea__c, Owner.Name, CategoryGroup__c, SPE_Status__c,KPIDetails__c,ProblemDescriptionDetails__c,
                            AnalysisFindings__c ,Datefailurefirstobserved__c,InternalContainmentifany__c,Problem_Analysis_Completed__c, OpenDate__c,ManufactureAcceptsFault__c,ManufacturerComments__c,
                            DevelopmentExpectation__c,SupplierFaultAssumptionComplete__c,OwnerApproval__c,OwnerIsMfrInvolvedinSPECase__c,OwnerComments__c,X2DDueDate__c,X2DDaysAllowed__c,X3DManufacturerResponse__c,
                            X3DSupplierContributors__c,X3DSupplierResponseComplete__c,X3DOwnerResponse__c,X3DOwnerApproveReject__c,X3DDueDate__c,X3DDaysAllowed__c,X4DSupplierResponse__c,X4DSupplierContributors__c,
                            X4DSupplierResponseComplete__c,X4DOwnerResponse__c,X4DOwnerApproveReject__c,X4DDueDate__c,X4DDaysAllowed__c,X5DSupplierResponse__c,X5DSupplierContributors__c,X5DSupplierResponseComplete__c,
                            X5DOwnerResponse__c,X5DOwnerApproveReject__c,X5DDueDate__c,X5DDaysAllowed__c,Summary_spe__c,CancelledNTFStatusExplanation__c,KPIName__c,CreatedDate,KPIName__r.Name,KPIName__r.KPI_Title__c,SPETracker__r.Name,Title__c,
                            Supplier__c, Supplier__r.Name, SupplierManagerContact__c, SPEPlan__r.Name , KPIAbbreviation__c, SurveyCommentsReview__c, InitialKPIValue__c, RCAInstructions__c, InitialKPIScore1__c, PreventiveActionInstructions__c,
                            CorrectiveActionInstructions__c,Date_of_Expected_Closure__c
                                             
               FROM SPE_ConsequenceManagement__c 
               WHERE Id=: parameterMaps.get('Id') ];
         
         kpiTitle = ccm.KPIName__r.KPI_Title__c;
         supplierName = ccm.Supplier__r.Name;
         //----------Changes for Language---------------
         
        showOptions=false;
        statusOptions = new list<SelectOption>();
        languages =SPE2_LanguageList__c.getall().values();
        languages.sort();
        
        statusOptions.add(new SelectOption('English','English'));
        for(SPE2_LanguageList__c lang : languages ){
            
            statusOptions.add(new SelectOption(lang.Name,lang.Language__c));  
        }
        
                 
    //*****************************************************END*********************************************//          
               
       system.debug('Approval Value is---->'+ccm.OwnerApproval__c);
        
        if (parameterMaps.get('pswd') == null)
        {
            isPassword = true;  
        }
        else
        {
            if (parameterMaps.get('pswd') == ccm.Password__c)
            {
                isPassword = false; 
                otherConsequenceManagementsticket();
            }
            else
            {
                isPassword = true;
            }
        }
    }
    @TestVisible
    private void otherConsequenceManagementsticket()
    {
        otherCMsTicket = new List<SPE_ConsequenceManagement__c>();
        
        otherCMsTicket = [SELECT Id, Name,TicketStatus__c, Password__c,CurrentStage__c,Problem_Analysis_Completed__c 
                          FROM SPE_ConsequenceManagement__c
                          WHERE Contact__c =: ccm.Contact__c AND Problem_Analysis_Completed__c=true];
                         
                          
    }
    
    public PageReference enter() 
    {
        if(password ==ccm.Password__c)
        {  
            PageReference requestPage = ApexPages.currentPage();
            requestPage.getParameters().clear();
            requestPage.getParameters().put('Id', ccm.Id);
            requestPage.getParameters().put('pswd', password);
                   
            requestPage.setRedirect(true);
            return requestPage;
        }
        else 
        {   
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Kindly fill the correct Password');
            ApexPages.addMessage(myMsg);  
            return null;                          
        } 
    }
    
    public PageReference save1()
    {
       
        
        if(ccm.OwnerApproval__c=='Approve')
        {
            isReadonly=true;
        }
        else
        {
            isReadonly=false;
        }
        
        Boolean isError = false;
        try 
        {
            update ccm;
        } 
        catch(DmlException e) 
        {
            isError = true;
        }

        if (isError)
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Kindly fill the correct Password');
            ApexPages.addMessage(myMsg);  
            
            return null;
        }
        else
        {
            PageReference editPage = Page.SPE_ConsequenceManagementThankyouPage;
            
            editpage.setRedirect(false); 
            return editPage;
        }
    }
    
      public void refreshLanguage(){
         
          altrLang = [Select id,KPI__c,Language__c,English_Language_RCA_Instructions__c,English_Language_Description__c,English_Language_Preventive_Action_Ins__c,English_Language_Corrective_Action_Ins__c,
             English_Version__c,Alternate_Language_Corrective_Action_Ins__c,Alternate_Language_Description__c,Alternate_Language_Preventive_Action_Ins__c,Alternate_Language_RCA_Instructions__c
             from SPE2_Language_KPI__c 
             where KPI__c=: ccm.KPIName__c and Language__c =: selectedValue ];
          System.debug('altrLang @@@@@@@@@@@@@@@@@@@'+altrLang );
          
          if(altrLang.size()>0){
              showOptions=true;
          }
          else{
              showOptions=false;
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info,'Alternate Language Not Available for '+(selectedValue ))); 
          }
     
     } 
}