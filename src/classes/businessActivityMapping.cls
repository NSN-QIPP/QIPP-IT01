public with sharing class businessActivityMapping {
    List<Business_Activity__c> businessActivity;
    List<Business_Activity__c> businessActivityMapping;
    List<QIPP_Project__c> showBAMapping;
    List<QIPP_Project__c> proj;
    public list<String> valueStreamList{get;set;}
    public List<InnerWrapper> InnerWrapperList{get;set;}
    public List<InnerWrapper> InnerWrapperList1{get;set;}
    public String selActivities{get;set;}
     public String selectedActivity{get;set;}
    public String projActivity{get;set;}
    public String projID{get;set;}
    public boolean displayhighimpactPopup{get; set;}
    public boolean displayPopupBAM{get; set;}
    public Boolean recIsLocked{get;set;}
    public string profilename {get;set;}
    public String projState{get;set;}
    public Map<String, Integer> valueStraemOrderMap = new Map<String, Integer>();
    public Map<String, Integer> businessFuncOrderMap = new Map<String, Integer>();    

    public void closePopup() {       
        displayhighimpactPopup= false; //To hide confirmation popup for submitting approval process  
    }
    public void showPopup() {       
        displayhighimpactPopup= true;
    }
    
    public businessActivityMapping(ApexPages.StandardController stdController){}
    
    public businessActivityMapping(){
        projID = ApexPages.CurrentPage().getParameters().get('projectID');
        recordIsLocked(projID);
        
        list <QIPP_Project__c> projval = new list<QIPP_Project__c> ([SELECT Id, Project_State__c from QIPP_Project__c WHERE Id=:projID]);
        projState = projval[0].Project_State__c;
        
        profile profilena =  [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
        profilename = profilena.Name;
        
        businessActivity= [select id,Name,Value_Stream__c,Business_Function__c,Description__c from Business_Activity__c  limit 50000];
        InnerWrapperList= new list<InnerWrapper>();
        
        Schema.DescribeFieldResult businessActivity2 = Business_Activity__c.Business_Function__c.getDescribe();
        List<Schema.PicklistEntry> ple = businessActivity2 .getPicklistValues();
        Integer i = 1;
        for(Schema.PicklistEntry val : ple){
            businessFuncOrderMap.put(val.getLabel(),i);
            i++;
        }
        
        Schema.DescribeFieldResult businessFunc = Business_Activity__c.Value_Stream__c.getDescribe();
        List<Schema.PicklistEntry> pleVal = businessFunc.getPicklistValues();
        
        List<string> lstVal = new List<string>();
        i = 1;
        for(Schema.PicklistEntry val : pleVal ){
            lstVal.add(val.getvalue());
            valueStraemOrderMap.put(val.getLabel(),i);
            i++;
        }
        InnerWrapper obj1 = new InnerWrapper('Dummy Header Test',lstVal);
     

        //--Aded by Rahul(22-08-2016)--Start--//
           for(Schema.PicklistEntry busiAc : ple ){
            InnerWrapper wrap = new InnerWrapper();
            for(Business_Activity__c ba2 : businessActivity){
                wrap.Business_Function_Val = busiAc.getValue();
                if(ba2.Business_Function__c == busiAc.getValue()&& ba2.Value_Stream__c == obj1.ValueSt_Features ){
                    wrap.ValueSt_Features = ba2.name;
                    wrap.DescrSt_Features = ba2.Description__c;
                }
                if(ba2.Business_Function__c == busiAc.getValue()&& ba2.Value_Stream__c == obj1.ValueStr_Price){
                     wrap.ValueStr_Price= ba2.name;
                     wrap.DescrStr_Price= ba2.Description__c;                     
                }
                if(ba2.Business_Function__c == busiAc.getValue()&& ba2.Value_Stream__c == obj1.ValueStr_Quality){
                     wrap.ValueStr_Quality= ba2.name;
                     wrap.DescrStr_Quality= ba2.Description__c;                     
                }
                if(ba2.Business_Function__c == busiAc.getValue()&& ba2.Value_Stream__c == obj1.ValueStr_Relationship){
                     wrap.ValueStr_Relationship= ba2.name;
                     wrap.DescrStr_Relationship= ba2.Description__c;                     
                }
                if(ba2.Business_Function__c == busiAc.getValue()&& ba2.Value_Stream__c == obj1.ValueStr_Time){
                     wrap.ValueStr_Time= ba2.name;
                     wrap.DescrStr_Time= ba2.Description__c;                     
                }         
            }
            InnerWrapperList.add(wrap);
        }
        
        valueStreamList=new List<String>();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get('Business_Activity__c');//From the Object Api name retrieving the SObject
        Sobject Object_name = targetType.newSObject();
        Schema.sObjectType sobject_type = Object_name.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
        
        
        List<Schema.PicklistEntry> pick_list_values = field_map.get('Value_Stream__c').getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        for (Schema.PicklistEntry a : pick_list_values) { //for all values in the picklist list
            valueStreamList.add(a.getValue());//add the value  to our final list
            
        }
    }
 
       public pagereference showMapping(){
        projActivity = '';
        showBAMapping = [select Id,Business_Activity_Mapping__r.Name,Business_Activity_Mapping2__r.Name,Business_Activity_Mapping3__r.Name from QIPP_Project__c where id =: projID];
        //projActivity = showBAMapping[0].Business_Activity_Mapping__r.name;
        
        if(showBAMapping[0].Business_Activity_Mapping__c != null){
            projActivity += showBAMapping[0].Business_Activity_Mapping__r.Name+';';
        }
        if(showBAMapping[0].Business_Activity_Mapping2__c != null){
            projActivity += showBAMapping[0].Business_Activity_Mapping2__r.Name+';';
        }
        if(showBAMapping[0].Business_Activity_Mapping3__c != null){
            projActivity += showBAMapping[0].Business_Activity_Mapping3__r.Name+';';
        }
        projActivity = projActivity.removeEnd(';');
        return null;
    }
    
    public pagereference saveMapping(){
     try{   
         system.debug('Insidetry');
        if(selActivities != null && selActivities != ''){
            List<String> selActivitiesList = selActivities.split(';');
            if(selActivitiesList != null && selActivitiesList.size() > 0){
            
                Set<String> selActivitiesSet = new Set<String>();
                for(String s : selActivitiesList){
                    selActivitiesSet.add(s);
                }
                businessActivityMapping = [select id,Name,Value_Stream__c,Business_Function__c from Business_Activity__c where name IN: selActivitiesSet];
                if(businessActivityMapping != null  && businessActivityMapping.size() > 0){
                    proj = [select Id,Business_Activity_Mapping__c,Business_Activity_Mapping_ValueStream__c,Business_Activity_Mapping_BusinessFunc__c,Business_Activity_Mapping2__c,Business_Activity_Mapping2_ValueStream__c,Business_Activity_Mapping2_BusinessFunc__c,Business_Activity_Mapping3__c,Business_Activity_Mapping3_ValueStream__c,Business_Activity_Mapping3_BusinessFunc__c from QIPP_Project__c where id =: projID];
                    proj[0].Business_Activity_Mapping__c = null;
                    proj[0].Business_Activity_Mapping_ValueStream__c = '';
                    proj[0].Business_Activity_Mapping_BusinessFunc__c = '';
                    proj[0].Business_Activity_Mapping2__c = null;
                    proj[0].Business_Activity_Mapping2_ValueStream__c = '';
                    proj[0].Business_Activity_Mapping2_BusinessFunc__c = '';
                    proj[0].Business_Activity_Mapping3__c = null;
                    proj[0].Business_Activity_Mapping3_ValueStream__c = '';
                    proj[0].Business_Activity_Mapping3_BusinessFunc__c = '';
                    
                    Map<String,String> busActivityMap = new Map<String,String>();
                    Map<String,String> nameToValueMap = new Map<String,String>();
                    Map<String,String> nameToBusFuncMap = new Map<String,String>();
                    
                    for(Business_Activity__c ba : businessActivityMapping){
                        String valueStream = '';
                        String busFunction = '';
                        
                        // Business activity name to Business activity Id map
                        busActivityMap.put(ba.Name, ba.Id);
                        
                        // Business activity name to comma separated Value stream map
                        if(nameToValueMap != null && nameToValueMap.containsKey(ba.Name)){
                            if(nameToValueMap.get(ba.Name) != ba.Value_Stream__c)
                                valueStream = nameToValueMap.get(ba.Name)+';'+ba.Value_Stream__c;
                        }else{
                            valueStream = ba.Value_Stream__c;
                        }
                        if(valueStream != '')
                            nameToValueMap.put(ba.Name, valueStream);

                        // Business activity name to comma separated business function map                            
                        if(nameToBusFuncMap != null && nameToBusFuncMap.containsKey(ba.Name)){
                            if(nameToBusFuncMap.get(ba.Name) != ba.Business_Function__c)
                                busFunction = nameToBusFuncMap.get(ba.Name)+';'+ba.Business_Function__c;
                        }else{
                            busFunction = ba.Business_Function__c;
                        }
                        if(busFunction != '')
                            nameToBusFuncMap.put(ba.Name, busFunction);

                    }
                    sortActivityMapping('ValueStream',nameToValueMap);

                    sortActivityMapping('BusinessFunc',nameToBusFuncMap);

                    //-- update values into project object
                    
                    for(String s : busActivityMap.keySet()){
                        if(proj[0].Business_Activity_Mapping__c == null){
                            proj[0].Business_Activity_Mapping__c =  busActivityMap.get(s);
                            proj[0].Business_Activity_Mapping_ValueStream__c = nameToValueMap.get(s);
                            proj[0].Business_Activity_Mapping_BusinessFunc__c = nameToBusFuncMap.get(s);
                        }
                        else if(proj[0].Business_Activity_Mapping2__c == null){
                            proj[0].Business_Activity_Mapping2__c =  busActivityMap.get(s);
                            proj[0].Business_Activity_Mapping2_ValueStream__c = nameToValueMap.get(s);
                            proj[0].Business_Activity_Mapping2_BusinessFunc__c = nameToBusFuncMap.get(s);
                        }
                        else if(proj[0].Business_Activity_Mapping3__c == null){
                            proj[0].Business_Activity_Mapping3__c =  busActivityMap.get(s);
                            proj[0].Business_Activity_Mapping3_ValueStream__c = nameToValueMap.get(s);
                            proj[0].Business_Activity_Mapping3_BusinessFunc__c = nameToBusFuncMap.get(s);
                        }
                    }
                    
                    update proj;
                }
            }
        }
        return null;
     }
     catch(exception e){
         system.debug('Insidecatch');
         System.Debug('Exception --'+e.getMessage());
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Insufficient access to associate Business Activity Mapping'));
         return null;
     }
    }
    
    public void sortActivityMapping(String orderOn, Map<String, String> valueMapping){
    
        Map<String,Integer> defaOrderMap = new Map<String,Integer>();
        if(orderOn == 'ValueStream'){
            defaOrderMap = valueStraemOrderMap.clone();
        }else{
            defaOrderMap = businessFuncOrderMap.clone();        
        }
        
        if(defaOrderMap != null){
            for(String key : valueMapping.keySet()){
                Map<Integer, String> orderToValMap = new Map<Integer, String>();
                List<String> splitValList = valueMapping.get(key).split(';');
                for(String splitVal : splitValList){
                    for(String defaKey : defaOrderMap.keySet()){
                        if(splitVal == defaKey){
                            orderToValMap.put(defaOrderMap.get(defaKey), splitVal);
                        }
                    }
                }

                String strVal = '';
                List<Integer> aList = new List<Integer>();
                aList.addAll(orderToValMap.keySet());
                aList.sort();
                for(Integer a: aList){
                    strVal += orderToValMap.get(a)+';';
                }
                valueMapping.put(key, strVal.removeEnd(';'));
            }
        }
    }
    
    public class InnerWrapper{
        public String Business_Function_Val{get;set;}
        public String ValueSt_Features{get;set;}
        public String ValueStr_Price{get;set;}
        public String ValueStr_Quality{get;set;}
        public String ValueStr_Relationship{get;set;}
        public String ValueStr_Time{get;set;}
        public list<String> valueStreamList{get;set;}
        public String DescrSt_Features{get;set;}
        public String DescrStr_Price{get;set;}
        public String DescrStr_Quality{get;set;}
        public String DescrStr_Relationship{get;set;}
        public String DescrStr_Time{get;set;}
        
        public InnerWrapper(){}
        /*public InnerWrapper(String Business_Func,String ValueSt_Fea,String DescrSt_Fea,
                            String ValueStr_Pri,String DescrStr_Pri,String ValueStr_Qua,String DescrStr_Qua,
                            String ValueStr_Rel,String DescrStr_Rel,String ValueStr_Ti,String DescrStr_Ti){
        
                            Business_Function_Val = Business_Func;
                            ValueSt_Features = ValueSt_Fea;
                            DescrSt_Features = DescrSt_Fea;
                                                        
                            ValueStr_Price = ValueStr_Pri;
                            DescrStr_Price = DescrStr_Pri;
                                                        
                            ValueStr_Quality = ValueStr_Qua;
                            DescrStr_Quality = DescrStr_Qua;

                            ValueStr_Relationship = ValueStr_Rel;
                            DescrStr_Relationship = DescrStr_Rel;
                            
                            ValueStr_Time = ValueStr_Ti;        
                            DescrStr_Time = DescrStr_Ti;
        }  */      
        //--Added by Rahul(22-08-2016)--End--//        
        
        
           public InnerWrapper(string funVal,List<string> pleVal){
                        Business_Function_Val = funVal;
                                if(pleVal.size()>0){
                                    for(integer i=0; i< pleVal.size(); i++ ){
                                        if(i==0)
                                            ValueSt_Features = pleVal[i];
                                        else if(i==1)
                                            ValueStr_Price = pleVal[i];
                                        else if(i==2)
                                            ValueStr_Quality = pleVal[i];
                                        else if(i==3)
                                            ValueStr_Relationship = pleVal[i];
                                        else if(i==4)
                                            ValueStr_Time = pleVal[i];
                                     }
                                }
                              /*  else{
                                    Business_Function_Val = Business_Func;
                                    ValueSt_Features = ValueSt_Fea;
                                    ValueStr_Price = ValueStr_Pri;
                                    ValueStr_Quality = ValueStr_Qua;
                                    ValueStr_Relationship = ValueStr_Rel;
                                    ValueStr_Time = ValueStr_Ti;
                                }*/
                            }
    }
    
     public void closePopupBAM() {       
        displayPopupBAM= false; //To hide confirmation popup for submitting approval process  
    }
    public void showPopupBAM() {       
        displayPopupBAM= true;
    }
    public Boolean recordIsLocked(ID projId){
        ID recId = projId;
        recIsLocked = Approval.isLocked(recId);
        return recIsLocked;
    }
    
}