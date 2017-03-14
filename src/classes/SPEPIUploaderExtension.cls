public without sharing class SPEPIUploaderExtension{
    
    public SPE_PIValues__c objSPEPIValues{get;set;}
    public SPE_Mapping_Values__c objSPEMV{get;set;}
    public SPE_Mapping_Values__c objSPEMVEditPopUp{get;set;}
    public SPE_Mapping_Template__c objSPEMT{get;set;}
    public SPE_Mapping_Template__c objSPEMTNew{get;set;}
    public boolean isTemplateSectionShown{get;set;}
    public List<SPE_Mapping_Values__c> lstSPEMappingVals{get;set;}
    public List<SelectOption> options{get;set;}
    public String headerVals{get;set;}
    public String headerValsFinal{get;set;}
    public List<createRecordsWrapper> createMappingRecords{get;set;}
    public List<updateRecordsWrapper> updateMappingRecords{get;set;}
    List<SPE_Mapping_Values__c> lstSPEMappingValstoInsert;
    List<SPE_Mapping_Values__c> lstSPEMappingValstoUpdate;
    public integer rowSkipExistingTemp{get;set;}
    public integer colSkipExistingTemp{get;set;}
    public SPE_Mapping_Template__c objSPEMTSelected{get;set;}
    public String callingPlace{get;set;}
    public boolean isValidated{get;set;}
    public boolean isValidatedUpdate{get;set;}
    String strGeoScope;
    String strProdScope;
    String strCategoryScope;
    String strValuesType;
    SPE_PIDefinition__c objCurrentPI;
    Set<String> strRequiredFields;
    public string strFinalHeaders{get;set;}
    public string strHeadersToAppend{get;set;}
    map<String,String> mapHeaders;
    List<SPE_Mapping_Values__c> lstSPEMV;
    public boolean isHeaderColMissing{get;set;}
    public string defVals{get;set;}
    public String isDefaultFieldsAvailable{get;set;}
    public List<fillAdditionalDataWrapper> lstFillData{get;set;}
    public String erroredFields{get;set;}
    public String erroredFieldsUpdate{get;set;}
    String strPIValueType='';
    Set<String> setNonValidEntries = new Set<String>();
    public String existingHeaders{get;set;}
    public boolean isExistingHeadersValidated{get;set;}
    public boolean isDefaultFieldsValidated{get;set;}
    String strDataInsert{get;set;}
    String strDateFormat{get;set;}
    
    public SPEPIUploaderExtension(ApexPages.StandardController con){
        existingHeaders = '';
        isTemplateSectionShown = false;
        objSPEMTSelected = new SPE_Mapping_Template__c();
        lstSPEMappingVals = new List<SPE_Mapping_Values__c>();
        objSPEPIValues = new SPE_PIValues__c();
        objSPEMVEditPopUp = new SPE_Mapping_Values__c();
        objSPEMV = new SPE_Mapping_Values__c();
        objSPEMTNew = new SPE_Mapping_Template__c();
        objCurrentPI = new SPE_PIDefinition__c();
        strRequiredFields = new Set<String>();
        
        if(ApexPages.currentPage().getParameters().get('id')!= null)
            objSPEPIValues.PIDefination__c = ApexPages.currentPage().getParameters().get('id');
        
        Map<String, Schema.SObjectType> schemaMapP = Schema.getGlobalDescribe();
        Map<String,Schema.DescribeFieldResult> finalMapP = new Map<String, Schema.DescribeFieldResult>();
        Schema.SObjectType childSchemaP = schemaMapP.get('SPE_PIDefinition__c');
        Map<String, Schema.SObjectField> fieldMapP = childSchemaP.getDescribe().fields.getMap();
        List<Schema.PicklistEntry> picklistVals = fieldMapP.get('ValuesType__c').getDescribe().getPickListValues(); //grab the list of picklist values
        system.debug('picklistVals---' + picklistVals);
        for (Schema.PicklistEntry a : picklistVals) {
            setNonValidEntries.add(a.getValue().tolowercase()+'value__c'); 
        }
        system.debug('setNonValidEntries---' + setNonValidEntries);
        objCurrentPI = [select Id,GeoScope__c,BUScope__c,CategoryScope__c,ValuesType__c from SPE_PIDefinition__c where Id=: objSPEPIValues.PIDefination__c];
        strPIValueType = objCurrentPI.ValuesType__c.tolowercase();
        if(setNonValidEntries.contains(strPIValueType+'value__c'))
            setNonValidEntries.remove(strPIValueType+'value__c');
        system.debug('setNonValidEntries-11--' + setNonValidEntries);
        strGeoScope = objCurrentPI.GeoScope__c.tolowercase();
        strProdScope = objCurrentPI.BUScope__c.tolowercase();
        strCategoryScope = objCurrentPI.CategoryScope__c.tolowercase();
        strValuesType = objCurrentPI.ValuesType__c.tolowercase();
        strRequiredFields.add('EnterpriseID__c'.tolowercase());
        strRequiredFields.add('Period__c'.tolowercase());
        if(strGeoScope != '' && strGeoScope != PicklistDefaultValues__c.getall().values()[0].Market__c)
             strRequiredFields.add(strGeoScope.replaceAll( '\\s+', '')+'__c');
        if(strProdScope != '' && strProdScope != PicklistDefaultValues__c.getall().values()[0].Product__c)
             strRequiredFields.add(strProdScope.replaceAll( '\\s+', '')+'__c');  
        if(strCategoryScope != '' && strCategoryScope != PicklistDefaultValues__c.getall().values()[0].Category__c){
             if(strCategoryScope.replaceAll( '\\s+', '')+'__c' == 'categoryarea__c')
                 strRequiredFields.add('cluster__c'); 
             else
                 strRequiredFields.add(strCategoryScope.replaceAll( '\\s+', '')+'__c');  
             
        }
        if(strValuesType != '')
             strRequiredFields.add(strValuesType.replaceAll( '\\s+', '')+'value__c');
        
        system.debug('strRequiredFields----' + strRequiredFields);  
    }
    
    public void fetchTemplateDetails(){
        lstSPEMappingVals = new List<SPE_Mapping_Values__c>();
        SPE_Mapping_Template__c objSPEMT1 = new SPE_Mapping_Template__c();
        system.debug('objSPEMV.Mapping_Template__c--' + objSPEMV.Mapping_Template__c);
        objSPEMT1 = [select 
                        id,Number_Of_Columns_to_Skip__c,Number_Of_Rows_to_Skip__c 
                    from 
                        SPE_Mapping_Template__c 
                    where 
                        id =: objSPEMV.Mapping_Template__c];
        
        rowSkipExistingTemp = objSPEMT1.Number_Of_Rows_to_Skip__c != null ? integer.valueof(objSPEMT1.Number_Of_Rows_to_Skip__c):0;
        colSkipExistingTemp = objSPEMT1.Number_Of_Columns_to_Skip__c != null ? integer.valueof(objSPEMT1.Number_Of_Columns_to_Skip__c):0;
        system.debug(colSkipExistingTemp + 'rowSkipExistingTemp--' + rowSkipExistingTemp);
    }
    
    public void fetchTemplateDetails1(){
        lstSPEMappingVals = new List<SPE_Mapping_Values__c>();
        SPE_Mapping_Template__c objSPEMT2 = new SPE_Mapping_Template__c();
        system.debug('objSPEMV.Mapping_Template__c--' + objSPEMV.Mapping_Template__c);
        objSPEMT2 = [select 
                        id,Number_Of_Columns_to_Skip__c,Number_Of_Rows_to_Skip__c 
                    from 
                        SPE_Mapping_Template__c 
                    where 
                        id =: objSPEMV.Mapping_Template__c];
        
        rowSkipExistingTemp = objSPEMT2.Number_Of_Rows_to_Skip__c != null ? integer.valueof(objSPEMT2.Number_Of_Rows_to_Skip__c):0;
        colSkipExistingTemp = objSPEMT2.Number_Of_Columns_to_Skip__c != null ? integer.valueof(objSPEMT2.Number_Of_Columns_to_Skip__c):0;
        system.debug(colSkipExistingTemp + 'rowSkipExistingTemp--' + rowSkipExistingTemp);
    }
    
    public void setHiddenFldVals(){
        SPE_Mapping_Template__c objSPEMTemp = new SPE_Mapping_Template__c();
        if(objSPEMVEditPopUp.Mapping_Template__c != null){
            objSPEMTemp = [select 
                        id,Number_Of_Columns_to_Skip__c,Number_Of_Rows_to_Skip__c 
                    from 
                        SPE_Mapping_Template__c 
                    where 
                        id =: objSPEMVEditPopUp.Mapping_Template__c];
        
            rowSkipExistingTemp = objSPEMTemp.Number_Of_Rows_to_Skip__c != null ? integer.valueof(objSPEMTemp.Number_Of_Rows_to_Skip__c):0;
            colSkipExistingTemp = objSPEMTemp.Number_Of_Columns_to_Skip__c != null ? integer.valueof(objSPEMTemp.Number_Of_Columns_to_Skip__c):0;
            system.debug(colSkipExistingTemp + 'rowSkipExistingTemp--' + rowSkipExistingTemp);
        }
    }
    
    public void fetchTemplateDetailsPopUp(){
        try{
        system.debug('headerVals-12---' + headerVals);
        List<String> lstHeaderV1 = new List<String>();
        lstHeaderV1.addAll(headerVals.split(','));
        system.debug('lstHeaderV1----' + lstHeaderV1.size());
        
        List<SelectOption> optionsTemp1 = new List<SelectOption>();
        optionsTemp1.add(new SelectOption('','--None--'));
        for(String s : lstHeaderV1){
            
            if(s != ''){
                optionsTemp1.add(new SelectOption(s.trim(),s.trim()));
            }
        }
        objSPEMT = new SPE_Mapping_Template__c();
        updateMappingRecords = new List<updateRecordsWrapper>();
        objSPEMT = [select 
                            id,Number_Of_Columns_to_Skip__c,Number_Of_Rows_to_Skip__c 
                    from 
                        SPE_Mapping_Template__c 
                    where 
                        id =: objSPEMVEditPopUp.Mapping_Template__c];
        
        isTemplateSectionShown = true;
        system.debug(objSPEMVEditPopUp.Mapping_Template__c+'objSPEMT----Setting' + objSPEMT);
        lstSPEMappingVals = [Select 
                            id,Name,Header_Value__c,Mapping_Field__c,SPE_IsScreenInput__c
                         from 
                             SPE_Mapping_Values__c 
                         where 
                             Mapping_Template__c =:objSPEMVEditPopUp.Mapping_Template__c];
    
        for(SPE_Mapping_Values__c sm : lstSPEMappingVals){
            updateRecordsWrapper objURW = new updateRecordsWrapper();
            objURW.fileNames = sm.Header_Value__c;
            objURW.savedMapping= sm.Mapping_Field__c;
            objURW.isScreenInputUW = sm.SPE_IsScreenInput__c;
            objURW.optionItemsofFile = optionsTemp1;
            objURW.selectedStringInFile = sm.Mapping_Field__c;
            if(strRequiredFields.contains(sm.Header_Value__c))
                objURW.isRequiredUpdate = true;
            else
                objURW.isRequiredUpdate = false;
            objURW.mapValuesId = sm.Id;
            updateMappingRecords.add(objURW);
        }
        system.debug('lstSPEMappingVals---1---' + lstSPEMappingVals);  
        system.debug('updateMappingRecords---1---' + updateMappingRecords);  
        }
        catch(exception ex){
            system.debug('yyyyy----'+ ex.getMessage());
        }             
    }
    public void saveNClose(){
        system.debug(objSPEMVEditPopUp.Mapping_Template__c + 'objSPEMT----Save' + objSPEMT);
        lstSPEMappingValstoUpdate = new List<SPE_Mapping_Values__c>();
        isValidatedUpdate = true;
        erroredFieldsUpdate ='';
        mapHeaders = new map<String,String>();
        try{
            system.debug('updateMappingRecords-Save-' + updateMappingRecords);
            if(erroredFieldsUpdate !='' && erroredFieldsUpdate.substring(0,erroredFieldsUpdate.length()) == ',')
                erroredFieldsUpdate = erroredFieldsUpdate.substring(0,erroredFieldsUpdate.length()-1);
            //if(isValidatedUpdate){    
                if(objSPEMT != null)
                    update objSPEMT;
                    for(updateRecordsWrapper uR : updateMappingRecords){
                        SPE_Mapping_Values__c objSMVT = new SPE_Mapping_Values__c();
                        objSMVT.Header_Value__c = uR.fileNames;
                        if(uR.selectedStringInFile != '')
                            objSMVT.Mapping_Field__c = uR.selectedStringInFile;
                        else
                            objSMVT.Mapping_Field__c = uR.savedMapping;
                        objSMVT.SPE_IsScreenInput__c = uR.isScreenInputUW;
                        objSMVT.Mapping_Template__c = objSPEMT.id;
                        objSMVT.Id = uR.mapValuesId;
                        if(strRequiredFields.contains(uR.fileNames)){
                            if((uR.savedMapping == ''  || uR.savedMapping == null) && (uR.selectedStringInFile == '' || uR.selectedStringInFile == null) && uR.isScreenInputUW == false){
                                isValidatedUpdate = false;
                                erroredFieldsUpdate += uR.fileNames+',';
                            }
                        }
                        lstSPEMappingValstoUpdate.add(objSMVT);
                    }
                    System.debug(isValidatedUpdate+'***lstSPEMappingValstoUpdate***' + lstSPEMappingValstoUpdate);
                    if(isValidatedUpdate && !lstSPEMappingValstoUpdate.isEmpty())
                        update lstSPEMappingValstoUpdate;

        }
        catch(Exception ex){
            system.debug('ex---' + ex.getMessage());
        }
    }
    
    public void validateFileHeaders(){
        isExistingHeadersValidated = true;
        List<String> lstHeaderVE = new List<String>();
        system.debug('existingHeaders---' + existingHeaders);
        if(existingHeaders.contains('\n')){
            existingHeaders = existingHeaders.replaceAll('\n', ' ');
        }
        lstHeaderVE.addAll(existingHeaders.split(','));
        system.debug('lstHeaderVE---' + lstHeaderVE);
        List<SPE_Mapping_Values__c> lstSPEMappingValsValidation = new List<SPE_Mapping_Values__c>();
        Set<String> mappedHeadersTemp = new Set<String>();
        for(String h : lstHeaderVE){
            if(h != '' && h != ','){
                mappedHeadersTemp.add(h.trim());
            }
        }
        system.debug('mappedHeadersTemp---' + mappedHeadersTemp);
        lstSPEMappingValsValidation = [Select 
                                        id,Name,Header_Value__c,Mapping_Field__c,SPE_IsScreenInput__c
                                     from 
                                         SPE_Mapping_Values__c 
                                     where 
                                         Mapping_Template__c =:objSPEMV.Mapping_Template__c];
        for(SPE_Mapping_Values__c s : lstSPEMappingValsValidation){
            
            if(s.Mapping_Field__c != '' && s.Mapping_Field__c != null && s.Mapping_Field__c != 'null' && !mappedHeadersTemp.contains(s.Mapping_Field__c)){
                system.debug('s.Mapping_Field__c---' + s.Mapping_Field__c);
                isExistingHeadersValidated = false;
            }
            if((s.Mapping_Field__c == '' || s.Mapping_Field__c == null) && s.SPE_IsScreenInput__c == false && strRequiredFields.contains(s.Header_Value__c)){
                system.debug('s.s.Header_Value__c---' + s.Header_Value__c);
                isExistingHeadersValidated = false;
            }
        }
        system.debug('isExistingHeadersValidated---' + isExistingHeadersValidated);
    }
    // Methods for New Template Creation

    public void createNewMT(){
        system.debug('headerVals----' + headerVals);
        if(headerVals.contains('\n')){
            headerVals = headerVals.replaceAll('\n', ' ');
        }
        createMappingRecords = new List<createRecordsWrapper>();
        List<String> lstHeaderV = new List<String>();
        lstHeaderV.addAll(headerVals.split(','));
        system.debug('lstHeaderV----' + lstHeaderV.size());
        
        List<SelectOption> optionsTemp = new List<SelectOption>();
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String,Schema.DescribeFieldResult> finalMap = new Map<String, Schema.DescribeFieldResult>();
        Schema.SObjectType childSchema = schemaMap.get('SPE_PiValueTemp__c');
        Map<String, Schema.SObjectField> fieldMap = childSchema.getDescribe().fields.getMap();
        System.debug('***fieldMap***' + fieldMap);
        optionsTemp.add(new SelectOption('','--None--'));
        for(String s : lstHeaderV){
            
            if(s != ''){
                optionsTemp.add(new SelectOption(s.trim(),s.trim()));
            }
        }
        for (String fieldName: fieldMap.keySet()) {
             if(fieldMap.get(fieldName).getDescribe().isUpdateable() && !fieldName.equalsIgnoreCase('currencyisocode') 
                        && !fieldName.equalsIgnoreCase('errorreason__c') && !fieldName.equalsIgnoreCase('validatecategory__c')
                        && !fieldName.equalsIgnoreCase('verified__c') && !fieldName.equalsIgnoreCase('verified_bu__c') 
                        && !fieldName.equalsIgnoreCase('verified_geo__c') && !fieldName.equalsIgnoreCase('verrifiedenterpriseid__c')
                        && !fieldName.equalsIgnoreCase('period1__c') && !setNonValidEntries.contains(fieldName)){
                createRecordsWrapper objWrap = new createRecordsWrapper();
                objWrap.colNames = fieldName;
                objWrap.optionItems = optionsTemp;
                objWrap.isScreenInput = false;
                if(strRequiredFields.contains(fieldName))
                    objWrap.isRequiredCreate = true;
                else
                    objWrap.isRequiredCreate = false;
                createMappingRecords.add(objWrap);
             }
        }
        
        
        
        system.debug('createMappingRecords-----' + createMappingRecords);
    }
    public void fillData(){
        isDefaultFieldsAvailable = 'false';
        strHeadersToAppend = '';
        List<String> strNewFields = new List<String>();
        lstSPEMV = new List<SPE_Mapping_Values__c>();
        lstFillData = new List<fillAdditionalDataWrapper>();
        if(objSPEMV.Mapping_Template__c != null){
            lstSPEMV = [select id,Name,Header_Value__c,Mapping_Field__c,SPE_IsScreenInput__c
                         from 
                             SPE_Mapping_Values__c 
                         where 
                             Mapping_Template__c =:objSPEMV.Mapping_Template__c];
        }
        system.debug('lstSPEMV--' + lstSPEMV);
        for(SPE_Mapping_Values__c s : lstSPEMV){
            if(s.SPE_IsScreenInput__c){
                strNewFields.add(s.Header_Value__c);
                
            }
        }
        system.debug('strNewFields--' + strNewFields);
        for(String tempS : strNewFields){
            strHeadersToAppend += tempS + ',';
            fillAdditionalDataWrapper objW = new fillAdditionalDataWrapper();
            objW.headerAPINames = tempS;
            if(strRequiredFields.contains(tempS))
                objW.isRequiredDef = true;
            else
                objW.isRequiredDef = false;
            if(tempS.equalsIgnorecase('numbervalue__c'))
                objW.isNumberValue = true;
            else
                objW.isNumberValue = false;
            if(tempS.equalsIgnorecase('booleanvalue__c')){
                objW.isBooleanValue = true;
            }
            else
                objW.isBooleanValue = false;
            lstFillData.add(objW);
        }
        system.debug('lstFillData--' + lstFillData);
        if(!lstFillData.isEmpty())
            isDefaultFieldsAvailable = 'true';
        system.debug('isDefaultFieldsAvailable-1--' + isDefaultFieldsAvailable);
        
    }
    public void setDefValues(){
        isDefaultFieldsValidated = true;
        defVals = '';
        system.debug('lstFillData-44-' + lstFillData);
        for(fillAdditionalDataWrapper fW : lstFillData){
            defVals += fW.defaultValue +',';
            system.debug('fW.headerAPINames' + fW.headerAPINames);
            system.debug('fW.defaultValue' + fW.defaultValue);
            if(strRequiredFields.contains(fW.headerAPINames) && fW.defaultValue == ''){
                isDefaultFieldsValidated = false;
            }
        }
        system.debug('isDefaultFieldsValidated---' + isDefaultFieldsValidated);
    }
    public void updateNewMT(){
        lstSPEMV = new List<SPE_Mapping_Values__c>();
        strFinalHeaders = '';
        system.debug('headerValsFinal----' +headerValsFinal);
        if(headerValsFinal.contains('\n')){
            headerValsFinal = headerValsFinal.replaceAll('\n', ' ');
        }
        List<String> lstHeaderV1 = new List<String>();
        lstHeaderV1.addAll(headerValsFinal.split(','));
        isHeaderColMissing = false;
        if(objSPEMV.Mapping_Template__c != null){
            lstSPEMV = [select id,Name,Header_Value__c,Mapping_Field__c,SPE_IsScreenInput__c
                         from 
                             SPE_Mapping_Values__c 
                         where 
                             Mapping_Template__c =:objSPEMV.Mapping_Template__c];
        }
        system.debug('lstSPEMV---' + lstSPEMV);
        mapHeaders = new map<String,String>();
        for(SPE_Mapping_Values__c s : lstSPEMV){
            if(s.Mapping_Field__c != null && s.Mapping_Field__c != '')
                mapHeaders.put(s.Mapping_Field__c,s.Header_Value__c);
        }
        
        system.debug('mapHeaders---' + mapHeaders);
        if(!isHeaderColMissing){
            for(String st : lstHeaderV1){
                system.debug('stttt---' + st);
                if(st != null && st != '' && st != ','){
                    if(mapHeaders != null && mapHeaders.containsKey(st.trim())){
                        system.debug('mapHeaders.get(st)---' + mapHeaders.get(st));
                        strFinalHeaders += mapHeaders.get(st.trim()).trim()+',';
                    }
                    else{
                        strFinalHeaders += 'Not Mapped,';
                    }
                }
            }            
            if(strFinalHeaders != null && strFinalHeaders !='' && strFinalHeaders.substring(0,strFinalHeaders.length()) == ',')
                    strFinalHeaders = strFinalHeaders.substring(0,strFinalHeaders.length()-1);
            system.debug('strFinalHeaders---' + strFinalHeaders);
        }
        else
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'The Template columns are different from the file columns'));
    }
    
    public void saveNewTemplate(){
        system.debug('createMappingRecords-SS----' + createMappingRecords);
        system.debug('strRequiredFields-SS----' + strRequiredFields);
        lstSPEMappingValstoInsert = new List<SPE_Mapping_Values__c>();
        isValidated = true;
        set<string> selectedFields = new set<string>();
        erroredFields ='';
        try{
            
            for(createRecordsWrapper cR : createMappingRecords){
                selectedFields.add(cR.selectedString);
            }
            
            if(erroredFields != null && erroredFields !='' && erroredFields.substring(0,erroredFields.length()) == ',')
                erroredFields = erroredFields.substring(0,erroredFields.length()-1);
                if(objSPEMTNew !=  null)
                    upsert objSPEMTNew;
                    for(createRecordsWrapper cR : createMappingRecords){
                        SPE_Mapping_Values__c objSMVT = new SPE_Mapping_Values__c();
                        objSMVT.Header_Value__c = cR.colNames;
                        objSMVT.Mapping_Field__c = cR.selectedString;
                        objSMVT.Mapping_Template__c = objSPEMTNew.id;
                        objSMVT.SPE_IsScreenInput__c = cR.isScreenInput;
                        lstSPEMappingValstoInsert.add(objSMVT);
                        system.debug('cR.colNames-SS----' + cR.colNames);
                        if(strRequiredFields.contains(cR.colNames)){
                            system.debug(cR.isScreenInput + 'cR.selectedString----' + cR.selectedString);
                            if((cR.selectedString == '' || cR.selectedString == null ) && cR.isScreenInput == false){
                                isValidated = false;
                                erroredFields += cR.colNames+',';
                                system.debug('cR.isValidated-SS----' + isValidated);
                            }
                        }
                    }
                    system.debug('erroredFields--' + erroredFields);
                    
                    if(isValidated && !lstSPEMappingValstoInsert.isEmpty())
                        insert lstSPEMappingValstoInsert;
            
        }
        catch(Exception ex){
            system.debug('ex---' + ex.getMessage());
        }
        
    }
    
    public void blankMethod(){}
    
    public void uploadBulkData(){
        system.debug('Method Called');
        String strDataInsert = ApexPages.currentPage().getParameters().get('sendValues');
        String tempDateFormat = ApexPages.currentPage().getParameters().get('dateFormatNew');
        system.debug('tempDateFormat---' + tempDateFormat);
        system.debug('strDataInsert----' + strDataInsert);
        List<SPE_PiValueTemp__c> lstPiTempValsToInsert = new List<SPE_PiValueTemp__c>();
        List<String> tempRows = new List<String>();
        tempRows = strDataInsert.split('###');
        for(integer i =0;i < tempRows.size(); i ++){
            SPE_PiValueTemp__c p = new SPE_PiValueTemp__c();
            List<String> tempFields = tempRows[i].split('@@@');
            for(integer j = 0;j < tempFields.size();j++){
                if(tempFields[j].substringBefore('$$$')!=''){
                    p.put(tempFields[j].substringBefore('$$$'),tempFields[j].substringAfter('$$$'));
                }
            }
            p.put('DateFormat__c',tempDateFormat);
            p.put('PIDefination__c',objSPEPIValues.PIDefination__c);
            lstPiTempValsToInsert.add(p);
        }
        system.debug(lstPiTempValsToInsert.size() + 'lstPiTempValsToInsert---' + lstPiTempValsToInsert);
        if(!lstPiTempValsToInsert.isEmpty()){
            try{
                insert lstPiTempValsToInsert;
            }
            catch(exception ex){
                system.debug('Exception :: ' + ex.getMessage());
            }
        }
        
    }
    
    public pagereference moveToValidate(){
        PageReference pg = new PageReference('/apex/SPE_intermediateUpload');
        pg.setRedirect(true);
        return pg;
    }
    public void deleteTestData(){
        List<SPE_PiValueTemp__c> delTempVal = new List<SPE_PiValueTemp__c>();
        delTempVal = [select id from SPE_PiValueTemp__c Where createdById =: userInfo.getUserId() limit 50000];
        if(!delTempVal.isEmpty()){
            try{
                delete delTempVal;
            }
            catch(Exception ex){
                system.debug('Exception :: ' + ex.getMessage());
            }
        }
    }
    
    public class fillAdditionalDataWrapper{
        
        public String headerAPINames{get;set;}
        public string defaultValue{get;set;}
        public boolean isRequiredDef{get;set;}
        public boolean isNumberValue{get;set;}
        public boolean isBooleanValue{get;set;}
    }
    
    public class createRecordsWrapper{
        
        public String colNames{get;set;}
        public List<SelectOption> optionItems{get;set;}
        public string selectedString{get;set;}
        public boolean isScreenInput{get;set;}
        public boolean isRequiredCreate{get;set;}
    }
    public class updateRecordsWrapper{
        
        public String fileNames{get;set;}
        public List<SelectOption> optionItemsofFile{get;set;}
        public string selectedStringInFile{get;set;}
        public string savedMapping{get;set;}
        public boolean isScreenInputUW{get;set;}
        public Id mapValuesId{get;set;}
        public boolean isRequiredUpdate{get;set;}
    }
}