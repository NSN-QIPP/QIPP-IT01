public class QIPPCommonFuctionController{

    public Map<String, Schema.SObjectType> gDescribeInfo = Schema.getGlobalDescribe(); 


    public QIPPCommonFuctionController(){
    
    }
    
    //Purpose: Return SOQL string of given object with all fields along with where condition
    //Parameter: objName - API Name of object
    //Parameter: whereClause - filter condition for given object 
    public String getObjectAllFieldsSOQL(String objName, String whereClause){
        try{
            String strQuery = 'Select ';
            if(objName != null && objName != ''){

                Map <String, Schema.SObjectField> fieldMap = gDescribeInfo.get(objName).getDescribe().fields.getMap();
                for(Schema.SObjectField sfield : fieldMap.Values()){
                    schema.describefieldresult dfield = sfield.getDescribe();
                    strQuery += dfield.getname()+',';
                }
                strQuery = strQuery.removeEnd(',');
                
                strQuery = strQuery + ' From '+objName;
                if(whereClause != null && whereClause != ''){
                    strQuery = strQuery +' Where '+whereClause;
                }
            }
            return strQuery;
        }catch(Exception e){
            System.Debug('@@ Exception:' + e.getMessage());
            return null;
        }
    }
    
    //Purpose: Return List of SelectOption of given picklist filed of object with/without default option as None.
    //Parameter: objName - API name of object
    //Parameter: objFieldName - API name of picklist filed
    //Parameter: defaultOption - true/false, if passing true, add default option as 'None'
    public List<SelectOption> getFieldPickListToSelectOptionList(String objName, String objFieldName, boolean defaultOption){
        try{
            List<SelectOption> retSelOptn = new List<Selectoption>();
            if(objName != null && objName != '' && objFieldName != null && objFieldName != ''){
                if(defaultOption){
                    retSelOptn.add(new SelectOption('1','--None--'));
                }
                List<Schema.PicklistEntry> Pickvalues = gDescribeInfo.get(objName).getDescribe().fields.getMap().get(objFieldName.toLowerCase()).getDescribe().getPickListValues();
                for( Schema.PicklistEntry p : Pickvalues){
                    retSelOptn.add(new SelectOption(p.getValue(), p.getLabel()));
                }
            }
            return retSelOptn;
        }catch(Exception e){
            System.Debug('@@ Exception:' + e.getMessage());
            return null;
        }
    }
    
    //Purpose: Return List of Project State values of project object with/without default option as 'None'. Provide user role for check and remove some values of picklist.
    //Parameter: userRoleName - Name of user role. 
    //Parameter: defaultOption - true/false, if passing true, add default option as 'None'
    public List<SelectOption> getProjectStateValues(String userRoleName, boolean defaultOption){
        try{
            List<SelectOption> retSelOptn = new List<Selectoption>();
            if(defaultOption){
                retSelOptn.add(new SelectOption('1','--None--'));
            }
            
            boolean addValue = true;
            List<Schema.PicklistEntry> Pickvalues = gDescribeInfo.get('QIPP_Project__c').getDescribe().fields.getMap().get('project_state__c').getDescribe().getPickListValues();
            for( Schema.PicklistEntry p : Pickvalues){
                if((p.getValue() != 'Not Started')){
                    addValue = true;
                    if((userRoleName != null && userRoleName != '' && userRoleName == 'QIPP Project Lead') && 
                            (p.getValue() == 'Complete' || p.getValue() == 'Closed')){
                        addValue = false;
                    }
                    if(addValue){
                        retSelOptn.add(new SelectOption(p.getValue(), p.getLabel()));
                    }
                }
            }
            
            return retSelOptn;
        }catch(Exception e){
            System.Debug('@@ Exception:' + e.getMessage());
            return null;
        }
    }    
    
    //Purpose: Return List of Portfolio values of given project type which are active.
    //Parameter: projType - API Name of project type(e.g. A3, 8D). 
    public List<SelectOption> getProjectPortfolioValues(String projType){
        try{
            List<SelectOption> retSelOptn = new List<Selectoption>();
            retSelOptn.add(new SelectOption('1','--Select One--'));

            String protfolioType = this.getProjectPortfolioFieldName(projType);
            if(protfolioType != null && protfolioType != ''){
                List<QIPP_Portfolio__c> portfolioList = new List<QIPP_Portfolio__c>();
                
                String query = 'Select Id,Name From QIPP_Portfolio__c where ' + protfolioType + '= true And Portfolio_Status__c = \'Active\' Order By Name';
                portfolioList = Database.query(query);
                system.debug('@@portfolioList:'+portfolioList);
                //portfolioList = [select id,name from QIPP_Portfolio__c where CIF__c =:true and Portfolio_Status__c =: 'Active' ORDER BY name];
                if(portfolioList != null && portfolioList.size() > 0){
                    for(QIPP_Portfolio__c pf : portfolioList){
                       retSelOptn.add(new selectOption(pf.Id, pf.Name));
                    }
                }
            }
            return retSelOptn;
        }catch(Exception exe){
            System.Debug('@@ Exception:' + exe.getMessage());
            return null;
        }
    }
    
    //Purpose: Return API Name of the given project type value.
    //Parameter: projType - API Name of project type(e.g. A3, 8D).     
    public String getProjectPortfolioFieldName(String projType){
        String retStr = '';
        if(projType == '8D'){
            retStr = 'X8D__c';
        }else if(projType == 'A3'){
            retStr = 'A3__c';        
        }else if(projType == 'CIF'){
            retStr = 'CIF__c';        
        }else if(projType == 'DI (CoPQ)'){
            retStr = 'DI_CoPQ__c';        
        }else if(projType == 'DMADV' || projType == 'DMAIC'){
            retStr = 'DMAIC_DMADV__c';        
        }else if(projType == 'Lean (including Kaizen)'){
            retStr = 'Lean_including_Kaizen__c';        
        }else if(projType == 'Other'){
            retStr = 'Other__c';        
        }else if(projType == 'RCA/EDA'){
            retStr = 'RCA_EDA__c';        
        }
        
        return retStr;
    }
    
    //Purpose: Return field API name to field Label name mapping for given object
    //Parameter: objName - API Name of object
    public Map<String, String> getObjectFieldLabels(String objName){
        Map<String, String> retFieldLableMap = new Map<String, String>();
        if(objName != null && objName != ''){
            Map<String, Schema.SObjectField> fieldMap = gDescribeInfo.get(objName).getDescribe().fields.getMap();
            for(Schema.SObjectField sfield : fieldMap.Values()){
                schema.describefieldresult f = sfield.getDescribe();
                retFieldLableMap.put(f.getName(), f.getLabel());
            }
        }
        return retFieldLableMap;
    }
    
    //Purpose: Return field API name to mandatory field validation message mapping for given object and provided fields.
    //Parameter: obj - object instance
    //Parameter: objMandatoryFields - set of mandatory fields which are going to check for value.
    //Parameter: excludeMandatoryFields - set of mandatory fields which are NOT going to check for value.
    public Map<String, String> validateFieldMandatory(sObject obj, Set<String> objMandatoryFields, Set<String> excludeMandatoryFields){
        Map<String, String> errorFieldMandatory = new Map<String, String>();
        system.debug('@@Object:'+obj);
        if(obj != null){
            String sObjType = String.valueOf(obj.getSObjectType().getDescribe().getName());
            system.debug('@@sObjType:'+sObjType);

            if(sObjType != null && sObjType != ''){
                Map<String, String> fieldToLableMap = this.getObjectFieldLabels(sObjType);
                system.debug('@@fieldToLableMap:'+fieldToLableMap);
                if(fieldToLableMap != null && fieldToLableMap.size() > 0){
                    List<String> objFieldList = new List<String>();
                    objFieldList.addAll(objMandatoryFields);
                    objFieldList.addAll(excludeMandatoryFields);
                    
                    if(objFieldList != null && objFieldList.size() > 0){
                        for(String f : objFieldList){
                            if(obj.get(f) == null || obj.get(f) == ''){
                                if(!excludeMandatoryFields.contains(f)){
                                    errorFieldMandatory.put(f, fieldToLableMap.get(f)+': Please enter the value.');
                                }else{
                                    errorFieldMandatory.put(f, '');
                                }
                            }
                        }
                    }
                }
            }                
        }            
        return errorFieldMandatory;
    }
    
    //Purpose: Return project record type ID based on given object and record type name.
    //Parameter: objectAPIName - API name of object
    //Parameter: objectRecordTypeName - Name of the project record type name
    public String getObjectRecordTypeIdByName(String objectAPIName, String objectRecordTypeName){
        String objRecTypeId = '';
        Map<String,Id> recordTypeNameToIdMap = new Map<String,Id>();

        List<Schema.RecordTypeInfo> recordTypeInfo = gDescribeInfo.get(objectAPIName).getDescribe().getRecordTypeInfos();
        for(Schema.RecordTypeInfo info : recordTypeInfo){
            recordTypeNameToIdMap.put(info.getName(),info.getRecordTypeId());
        }
        if(recordTypeNameToIdMap != null && recordTypeNameToIdMap.size() > 0 && recordTypeNameToIdMap.get(objectRecordTypeName) != null){
            objRecTypeId = String.valueOf(recordTypeNameToIdMap.get(objectRecordTypeName));
        }
        
        return objRecTypeId;
    }

    //Purpose: return boolean value according to project finanace approver is valid approver or not based on available approver business group values in custom metadata type
    //Parameter: contactId - Contact object record Id
    //Parameter: roleType - Name of the role type(Finance Approver/Project Mentor)
    //Where Used: Used to validate finance and mentor at project creation for all pages and trigger side.
    Set<String> bgvalueset= new Set<String>();
    Set<String> conroleSet = new Set<String>();
    Set<String> beltcertvalueset = new Set<String>();
    public boolean validContactBG(String contactId, String roleType){
        boolean isValid = false;
        if(contactId != null && contactId != ''){
            QIPP_Contacts__c contObj = new QIPP_Contacts__c();
            List<QIPP_Contacts__c> contObjList = [Select Id,Name,Belt_Certification__c,Contact_BU__c,CoPQ_Role_1__c,CoPQ_Role_2__c,CoPQ_Role_3__c,CoPQ_Role_4__c,User_License__r.Profile.Name,User_License__c,User_License__r.IsActive From QIPP_Contacts__c Where Id =: contactId];
            if(contObjList != null && contObjList.size() > 0){
                contObj = contObjList.get(0);
            }
            system.debug('@@contObj:'+contObj);
            system.debug('@@Out-roleType:'+roleType);
            if(contObj != null && contObj.User_License__c != null && contObj.User_License__r.IsActive && contObj.User_License__r.Profile.Name == 'Nokia QIPP Project Lead'){
                system.debug('@@-roleType:'+roleType);
                if(roleType == 'Finance Approver' || roleType == 'Business Owner' || roleType == 'Business Owner Delegate'){
                    system.debug('@@In-roleType:'+roleType);
                    //Set<String> criteriavalueset = getContactcriteriavalues(roleType);
                    getContactcriteriavalues(roleType);
                    //system.debug('@@bgvalueset:'+bgvalueset+' @@contactBG:'+contObj.Contact_BU__c);
                    //if(contObj.Contact_BU__c != null && contObj.Contact_BU__c != '' && bgvalueset!= null && bgvalueset.size() > 0 && bgvalueset.contains(contObj.Contact_BU__c)){
                     //   isValid = true;
                    //}
                    if(contObj.CoPQ_Role_1__c != null && contObj.CoPQ_Role_1__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(contObj.CoPQ_Role_1__c)){
                        isValid = true;
                    }else If(contObj.CoPQ_Role_2__c != null && contObj.CoPQ_Role_2__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(contObj.CoPQ_Role_2__c)){
                        isValid = true;
                    }else If(contObj.CoPQ_Role_3__c != null && contObj.CoPQ_Role_3__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(contObj.CoPQ_Role_3__c)){
                        isValid = true;
                    }else If(contObj.CoPQ_Role_4__c != null && contObj.CoPQ_Role_4__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(contObj.CoPQ_Role_4__c)){
                        isValid = true;
                    }
                   /*
                    if((contObj.CoPQ_Role_1__c == 'Finance Approver Delegate' || contObj.CoPQ_Role_2__c == 'Finance Approver Delegate' || contObj.CoPQ_Role_3__c == 'Finance Approver Delegate' && contObj.CoPQ_Role_4__c == 'Finance Approver Delegate') || (contObj.CoPQ_Role_1__c == 'Finance Approver' || contObj.CoPQ_Role_2__c == 'Finance Approver' || contObj.CoPQ_Role_3__c == 'Finance Approver' && contObj.CoPQ_Role_4__c == 'Finance Approver' ) ){
                    isValid = true;
                    }
                    */
                }else if(roleType == 'Project Mentor'){
                    isValid = true;
                }else if(roleType == 'Improvement Owner'){
                    isValid = true;
                }else if(roleType == 'L6S Belt Assigned'){
                    system.debug('@@-roleType L6S:'+roleType);
                    getContactcriteriavalues(roleType);
                    if(contObj.Belt_Certification__c != null && contObj.Belt_Certification__c != '' && beltcertvalueset!= null && beltcertvalueset.size() > 0 && beltcertvalueset.contains(contObj.Belt_Certification__c)){
                        isValid = true;
                    }
                }               
            }
        }
        system.debug('@@isValidFnC:'+isValid); 
        system.debug('@@obj.bgvalueset:'+bgvalueset);
        system.debug('@@obj.conroleSet:'+conroleSet);
        system.debug('@@obj.beltcertvalueset:'+beltcertvalueset);
        bgvalueset.clear();
        conroleSet.clear();
        beltcertvalueset.clear();      
        return isValid;
    }
    
    //Purpose: return set of string of available business group values from finance approver and mentor custom metadata type
    //Parameter: roleType - Name of the role type(Finance Approver/Project Mentor)
    
    public Set<String> getContactcriteriavalues(String roleType){
        ///Set<String> criteriavalueset = new Set<String>();
        //Set<String> bgvalueset = new Set<String>();
        List<QIPP_Project_Approves_Criteria__mdt> criteriavalues = [Select Id,Belt_Certification_Values__c,BG_Value__c,Contact_Role__c From QIPP_Project_Approves_Criteria__mdt Where Project_Role_Type__c =: roleType and Is_Active__c = true];
        if(criteriavalues != null && criteriavalues.size() > 0){
            for(QIPP_Project_Approves_Criteria__mdt obj : criteriavalues){
                conroleSet.add(obj.Contact_Role__c);
                bgvalueset.add(obj.BG_Value__c);
                beltcertvalueset.add(obj.Belt_Certification_Values__c);
                system.debug('@@obj.Contact_Role__c:'+obj.Contact_Role__c);
                system.debug('@@obj.BG_Value__c:'+obj.BG_Value__c);
                system.debug('@@obj.Belt_Certification_Values__c:'+obj.Belt_Certification_Values__c);
            }
        }
        return null;
    }

}