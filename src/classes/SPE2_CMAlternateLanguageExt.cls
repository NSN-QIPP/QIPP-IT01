public without sharing class SPE2_CMAlternateLanguageExt{
   
    public string selectedValue {get;set;}
    public List<SelectOption> statusOptions {get;set;}
    public boolean showOptions {get;set;}
    public List<SPE2_Language_KPI__c> altrLang{get;set;}
    Private List<SPE2_LanguageList__c> languages;   
    private Id idCMRecord;
    public SPE_ConsequenceManagement__c objCM{get;set;}
    public SPE2_CMAlternateLanguageExt(ApexPages.StandardController con){
        showOptions=false;
        statusOptions = new list<SelectOption>();
        languages =SPE2_LanguageList__c.getall().values();
        languages.sort();
        
        statusOptions.add(new SelectOption('English','English'));
        for(SPE2_LanguageList__c lang : languages ){
            
            statusOptions.add(new SelectOption(lang.Name,lang.Language__c));  
        }
        
        idCMRecord = con.getId();
        objCM = [select Id,Name,CorrectiveActionInstructions__c,Description__c,KPIName__c,KPIName__r.Kpi_Title__c,KPITitle__c,PreventiveActionInstructions__c,RCAInstructions__c from SPE_ConsequenceManagement__c WHERE Id =:idCMRecord];
        System.debug('objCM @@@@@@@@@@@@@@@@@@@'+objCM );
    
    }
      
     public void refreshLanguage(){
         
          altrLang = [Select id,KPI__c,Language__c,English_Language_RCA_Instructions__c,English_Language_Description__c,English_Language_Preventive_Action_Ins__c,English_Language_Corrective_Action_Ins__c,
             English_Version__c,Language_Version__c,Alternate_Language_Corrective_Action_Ins__c,Alternate_Language_Description__c,Alternate_Language_Preventive_Action_Ins__c,Alternate_Language_RCA_Instructions__c
             from SPE2_Language_KPI__c 
             where KPI__c=: objCM.KPIName__c and Language__c =: selectedValue ];
          System.debug('altrLang @@@@@@@@@@@@@@@@@@@'+altrLang );
          
          if(altrLang.size()>0){
              showOptions=true;
          }
          else{
              showOptions=false;
              if(selectedValue != 'English')
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info,'Alternate Language Not Available for '+(selectedValue ))); 
          }
     
     } 
  
     
}