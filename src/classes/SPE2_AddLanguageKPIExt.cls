public class SPE2_AddLanguageKPIExt{
    
    public SPE_KPIDefinition__c objKPI {get;set;}
    public String isLanguageAccessGranted{get;set;}
    public String isKPIFieldValuesAvailable{get;set;}
    public List<SPE2_Language_KPI__c> lstKPIAltLang {get;set;}
    public SPE2_Language_KPI__c objKPIAltLang {get;set;}
    public String inputLanguage {get;set;}
    public boolean showNext{get;set;}
    private List<SPE2_LanguageList__c> languages;
    public id idKPIRecId{get;set;}
    public SPE2_AddLanguageKPIExt(ApexPages.StandardController st){
        
        idKPIRecId = st.getId();
        objKPI = new SPE_KPIDefinition__c();
        objKPIAltLang = new SPE2_Language_KPI__c();
        lstKPIAltLang = new List<SPE2_Language_KPI__c>();
        isLanguageAccessGranted = 'false';
        isKPIFieldValuesAvailable = 'true';
        showNext = false;
        if(st.getId()!=null){
            objKPI = [SELECT ownerId,KPI_Title__c,Description__c,PreventiveActionInstructions__c,RCAInstructions__c,CorrectiveActionInstructions__c FROM SPE_KPIDefinition__c where id = :st.getId()];
        }
        system.debug('objKPI.Description__c----' + objKPI.Description__c);
        if(objKPI != null){
            if(userInfo.getUserId() == objKPI.OwnerId){
                isLanguageAccessGranted = 'true';
            }
            if(isLanguageAccessGranted == 'true'){
                if(objKPI.Description__c == '' || objKPI.Description__c == null || objKPI.PreventiveActionInstructions__c == '' || objKPI.PreventiveActionInstructions__c == null || objKPI.RCAInstructions__c == '' || objKPI.RCAInstructions__c == null || objKPI.CorrectiveActionInstructions__c == '' || objKPI.CorrectiveActionInstructions__c == null)
                    isKPIFieldValuesAvailable = 'false';
            }
        }
    }
    
    public List<SelectOption> getLanguageValues(){
    
        List<SelectOption> options = new List<SelectOption>();
        languages =SPE2_LanguageList__c.getall().values();
        languages.sort();
        for(SPE2_LanguageList__c lang : languages ){
            options.add(new SelectOption(lang.Name,lang.Language__c));    
        }  
        return options; 
     }
    
    public void showNext(){
        showNext = true;
        if(isLanguageAccessGranted == 'true' && isKPIFieldValuesAvailable == 'true'){
            lstKPIAltLang = [select 
                                Id,Name,Language__c,Alternate_Language_Corrective_Action_Ins__c,
                                Alternate_Language_Description__c,Language_Version__c,Alternate_Language_Preventive_Action_Ins__c,
                                Alternate_Language_RCA_Instructions__c,English_Version__c,KPI__c,KPI__r.KPI_Title__c 
                             FROM
                                 SPE2_Language_KPI__c
                             WHERE
                                 Language__c =: inputLanguage AND KPI__c =: idKPIRecId
                             ];
            if(!lstKPIAltLang.isEmpty()){
                objKPIAltLang = lstKPIAltLang[0];
               
                     
            }
            else{
                objKPIAltLang = new SPE2_Language_KPI__c();
            }
        }
    }  
    public pageReference saveChanges(){
        objKPIAltLang.English_Language_Corrective_Action_Ins__c = objKPI.CorrectiveActionInstructions__c;
        objKPIAltLang.English_Language_Description__c = objKPI.Description__c;
        objKPIAltLang.English_Language_Preventive_Action_Ins__c = objKPI.PreventiveActionInstructions__c;
        objKPIAltLang.English_Language_RCA_Instructions__c = objKPI.RCAInstructions__c;
        objKPIAltLang.Language__c = inputLanguage;
        objKPIAltLang.English_Version__c = objKPI.KPI_Title__c;
        objKPIAltLang.KPI__c = idKPIRecId;
        if(objKPIAltLang != null){
         if(objKPIAltLang.Alternate_Language_Corrective_Action_Ins__c=='' || objKPIAltLang.Alternate_Language_Description__c==''
                    || objKPIAltLang.Alternate_Language_Preventive_Action_Ins__c=='' || objKPIAltLang.Alternate_Language_RCA_Instructions__c==''
                    || objKPIAltLang.Language_Version__c=='' ){
                 ApexPages.Message myMsg = new ApexPages.message(ApexPages.severity.ERROR,'All the fields are mandatory to be filled.Please enter some values.');
                 ApexPages.addMessage(myMsg); 
            }
            try{
            
                upsert objKPIAltLang;
                PageReference pg = new Pagereference('/' + idKPIRecId);
                return pg;
            }
            catch(exception ex){
                return null;
            }
        }
        else{
            return null;
        }
    }
}