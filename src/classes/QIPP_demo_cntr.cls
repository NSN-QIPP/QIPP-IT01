public class QIPP_demo_cntr {
    public list<string> BURids {get;set;} 
    public List<QIPP_BU_Reporting__c> Bn_rep_AddList{get;set;} 
    public List<QIPP_Benefit_History_Tracking__c> History_Tracking{get;set;} 
    public QIPP_demo_cntr(){
        Bn_rep_AddList = [select ID,                                 
                          Project_ID__c,
                          Benefit_ID__c,
                          Benefit_Condition__c,
                          Quarters__c,
                          Years__c,
                          Months__c,
                          //Month_s__c,//new field
                          Benefits_Saving_Amount_Planned__c,//new field
                          Benefits_Saving_Amount_Achieved__c,//new field
                          Benefit_Savings_Amount__c,
                          History_Tracking_For_Line_Items__c,
                          History_Tracking_For_Initial_Line_Items__c,
                          Entry_Type__c
                          from QIPP_BU_Reporting__c  where Project_ID__c ='a183B000000DSi4QAG' and Benefit_ID__c = 'a1B3B000001SCDkUAO' and Entry_Type__c != 'System Entry'];
        History_Tracking =new List<QIPP_Benefit_History_Tracking__c>();
        History_Tracking = [select ID, History_Tracking_For_Line_Items__c, History_Tracking_For_Initial_Line_Items__c from QIPP_Benefit_History_Tracking__c  where Benefit__c = 'a1B3B000001SCDkUAO'];
        
    }
    
    
}