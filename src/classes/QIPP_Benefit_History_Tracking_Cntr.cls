public class QIPP_Benefit_History_Tracking_Cntr{
    // External variables
    //public SObject myObject {get; set;}
    public Integer recordLimit {get; set;}
    public   list<id> myObjectids {get; set;}
    public list<QIPP_Benefit_History_Tracking__c> QBR {get;set;}
   // public static  list<id> myObjectids2 {get; set;}
    public static String objectLabel {get;}
    // Internal Variables
    //public objectHistoryLine[] objectHistory; 
    public Id myObjectId;
    public static final Map<String, Schema.SObjectType> mySObjectTypeMap = Schema.getGlobalDescribe();
    public static Map<String, Schema.SObjectField> myObjectFieldMap;
    public static List<Schema.PicklistEntry> historyFieldPicklistValues;
    
    private integer counter = 0;  //keeps track of the offset
    private integer list_size= 5 ; //sets the page size or number of rows
    public  integer total_size ; //used to show user the total size of the list
    boolean querycheck = true;
    public List<objectHistoryLine> getObjectHistory(){
       try {
            Schema.DescribeSObjectResult objectDescription = QIPP_Benefit_History_Tracking__c.getSObjectType().getDescribe();
            myObjectFieldMap = objectDescription.fields.getMap();
            if(querycheck){
                total_size = [SELECT count() FROM QIPP_Benefit_History_Tracking__history  WHERE ParentId in: myObjectids and Field in ('History_Tracking_For_Line_Items__c','created') ]; //set the total size
                querycheck = false;
            }
            map<id,QIPP_Benefit_History_Tracking__c> blimap = new map<id,QIPP_Benefit_History_Tracking__c>();
            
            for(QIPP_Benefit_History_Tracking__c bli: QBR){
                blimap.put(bli.id,bli);
            }
            
            String objectHistoryTableName = 'QIPP_Benefit_History_Tracking__history';
            Schema.DescribeFieldResult objectHistoryFieldField = mySObjectTypeMap.get(objectHistoryTableName).getDescribe().fields.getMap().get('Field').getDescribe();
            historyFieldPicklistValues = objectHistoryFieldField.getPickListValues();
            list<objectHistoryLine> objectHistory = new list<objectHistoryLine>();
            String prevDate = '';
            if (recordLimit== null){
                recordLimit = 100;
            }
            //list<sObject> historyList = [SELECT CreatedDate,CreatedById,Field,NewValue,OldValue FROM QIPP_Benefit_History_Tracking__history  WHERE ParentId in: myObjectids and Field in('History_Tracking_For_Line_Items__c','Improvement_Measure__c','Benefit_Type__c') ORDER BY CreatedDate DESC limit 60];
            list<sObject> historyList = [SELECT CreatedDate,CreatedById,ParentId,Field,NewValue,OldValue FROM QIPP_Benefit_History_Tracking__history  WHERE ParentId in: myObjectids and Field in ('History_Tracking_For_Line_Items__c','created') ORDER BY CreatedDate DESC limit :list_size offset :counter];
            for(Integer i = 0; i < historyList.size(); i++){
                sObject historyLine = historyList.get(i);
                if ((historyLine.get('newValue') == null && historyLine.get('oldValue') == null) 
                || (historyLine.get('newValue') != null && !(string.valueOf(historyLine.get('newValue')).startsWith('005') || string.valueOf(historyLine.get('newValue')).startsWith('00G')))
                || (historyLine.get('oldValue') != null && !(string.valueOf(historyLine.get('oldValue')).startsWith('005') || string.valueOf(historyLine.get('oldValue')).startsWith('00G')))){
                objectHistoryLine tempHistory = new objectHistoryLine();
                // Set the Date and who performed the action
                if (String.valueOf(historyLine.get('CreatedDate')) != prevDate){
                    tempHistory.theDate = String.valueOf(historyLine.get('CreatedDate'));
                    tempHistory.userId = String.valueOf(historyLine.get('CreatedById'));
                    tempHistory.who = String.valueOf(historyLine.get('CreatedById'));
                }
                else{
                    tempHistory.theDate = '';
                    tempHistory.who = '';
                    tempHistory.userId = String.valueOf(historyLine.get('CreatedById'));
                }
                prevDate = String.valueOf(historyLine.get('CreatedDate'));
                // Get the field label
                String fieldLabel = QIPP_Benefit_Report_History_Cntr_v2.returnFieldLabel(String.valueOf(historyLine.get('Field')));
                // Set the Action value
                system.debug('Field :  : '+String.valueOf(historyLine.get('Field')));
                if(String.valueOf(historyLine.get('Field')) == 'created') { // on Creation ** New record created
                    QIPP_Benefit_History_Tracking__c benli = blimap.get(String.valueOf(historyLine.get('parentid')));
                    system.debug('Created History_Tracking_For_Initial_Line_Items__c :  : '+benli.History_Tracking_For_Initial_Line_Items__c);
                    if(benli.History_Tracking_For_Initial_Line_Items__c != null && benli.Is_Deleted__c != true){
                        tempHistory.action = 'Created <b> Line Item </b>'+' '+benli.History_Tracking_For_Initial_Line_Items__c+'.';
                    }else if(benli.History_Tracking_For_Initial_Line_Items__c != null && benli.Is_Deleted__c == true){ //Deleted line item record details 
                        tempHistory.action = 'Deleted <b> Line Item </b>'+' '+benli.History_Tracking_For_Initial_Line_Items__c+'.';
                    }else tempHistory.action = 'Created <b> Line Item</b>.';
                }else if (historyLine.get('oldValue') != null && historyLine.get('newValue') == null){ // when deleting a value from a field
                    // Format the Date and if there's an error, catch it and re
                    try {
                        tempHistory.action = 'Deleted ' + Date.valueOf(historyLine.get('oldValue')).format() + ' in <b>' + fieldLabel + '</b>.';
                    } catch (Exception e){
                        tempHistory.action = 'Deleted ' + String.valueOf(historyLine.get('oldValue')) + ' in <b>' + fieldLabel + '</b>.';
                    }
                }else{ // all other scenarios
                    String fromText = '';
                    if (historyLine.get('oldValue') != null) {
                        try {
                            fromText = ' from ' + Date.valueOf(historyLine.get('oldValue')).format();
                        } catch (Exception e) {
                            fromText = ' from ' + String.valueOf(historyLine.get('oldValue'));
                        }
                    }
                    String toText = '';
                    if (historyLine.get('oldValue') != null) {
                        try {
                            toText = Date.valueOf(historyLine.get('newValue')).format();
                        } catch (Exception e) {
                            toText = String.valueOf(historyLine.get('newValue'));
                        }
                    }
                    if (toText != ''){
                        tempHistory.action = 'Changed <b>' + fieldLabel + '</b>' + fromText + ' to <b>' + toText + '</b>.';
                    }
                    else {
                        tempHistory.action = 'Changed <b>' + fieldLabel;
                    }
                }
                // Add to the list
                objectHistory.add(tempHistory);
                system.debug('for loop 1 : ');
                }
            }

            List<Id> userIdList = new List<Id>();
            for (objectHistoryLine myHistory : objectHistory){
                userIdList.add(myHistory.userId);
            }
            Map<Id, User> userIdMap = new Map<ID, User>([SELECT Name FROM User WHERE Id IN : userIdList]);

            for (objectHistoryLine myHistory : objectHistory){
                if (userIdMap.containsKey(myHistory.userId) & (myHistory.who != '') ){
                myHistory.who = userIdMap.get(myHistory.who).Name;
                }
            }
            return objectHistory;
        } catch (QueryException e){
         ApexPages.addMessages(e);   
         return null;
        }
    } 
    // Function to return Field Label of a object field given a Field API name
    public Static String returnFieldLabel(String fieldName){
        if (QIPP_Benefit_Report_History_Cntr_v2.myObjectFieldMap.containsKey(fieldName)){
            return QIPP_Benefit_Report_History_Cntr_v2.myObjectFieldMap.get(fieldName).getDescribe().getLabel();
        }
        else {
            for(Schema.PicklistEntry pickList : historyFieldPicklistValues){
                if (pickList.getValue() == fieldName){
                    if (pickList.getLabel() != null){
                        return pickList.getLabel();
                    }
                    else {
                        return pickList.getValue();
                    }
                }
            }
        }
        return '';
    }
    
    // Inner Class to store the detail of the object history lines 
    public class objectHistoryLine {
        public String theDate {get; set;}
        public String who {get; set;}
        public Id userId {get; set;} 
        public String action {get; set;}
    }

    public PageReference Beginning() { //user clicked beginning
      counter = 0;
      system.debug('*** Counter Beginning ** : '+counter);
      return null;
    }

    public PageReference Previous() { //user clicked previous button
      counter -= list_size;
      system.debug('*** Counter Previous ** : '+counter);
      return null;
    }

    public PageReference Next() { //user clicked next button
      counter += list_size;
      system.debug('*** Counter Next ** : '+counter);
      return null;
    }

    public PageReference End() { //user clicked end
        //counter = total_size - math.mod(total_size, list_size);
        system.debug('*** Counter End ** : '+counter+ '::math.mod(total_size, list_size) : '+ math.mod(total_size, list_size));
        if(Math.Mod(total_size,list_size) == 0){
            counter = total_size-list_size;
        }
        else{
            counter = (total_size/list_size)*list_size;
        }
      return null;
    }

    public Boolean getDisablePrevious() { 
      //this will disable the previous and beginning buttons
      system.debug('*** Counter getDisablePrevious ** : '+counter);
      if (counter>0) return false; else return true;
      
    }

    public Boolean getDisableNext() { //this will disable the next and end buttons
      system.debug('*** Counter getDisableNext ** : counter= '+counter+': '+'list_size = ' +list_size+' : total_size =  '+total_size);
      if (counter + list_size < total_size) return false; else return true;
      
    }

    public Integer getTotal_size() {
        system.debug('*** Counter getTotal_size ** : '+counter);
      return total_size;
    }

    public Integer getPageNumber() {
        system.debug('*** getPageNumber ** : '+counter/list_size+1);
      return counter/list_size + 1;
    }

    public Integer getTotalPages() {
        system.debug('*** getTotalPages ** : '+total_size/list_size);
      if (math.mod(total_size, list_size) > 0) {
          system.debug('*** getTotalPages ** : '+total_size/list_size+1 + '  : total_size/list_size :  '+total_size/list_size);
         return total_size/list_size + 1;
      } else {
          system.debug('*** getTotalPages ** : '+total_size/list_size);
         return (total_size/list_size);
      }
    }
}