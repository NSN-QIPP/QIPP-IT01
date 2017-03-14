public without sharing class TraceEmailStatus {
    
    private String claimID;
    
    public TraceEmailStatus()
    {
        claimID = ApexPages.currentPage().getParameters().get('Id');
        System.debug('Claim ');
    }
    
    public void traceEmail(){
        Decimal noOfTimesOpened = 0;
        if(claimID != null){
            list<Trace_Email__c> traceEmailRecord = [select Number_Of_Times_Email_Opened__c from Trace_Email__c where Claim_ID__c =: claimID];
            if(traceEmailRecord != null && !traceEmailRecord.isEmpty()){
                noOfTimesOpened = traceEmailRecord[0].Number_Of_Times_Email_Opened__c;
            }
        }
        Trace_Email__c emailTrace = new Trace_Email__c();
        emailTrace.Number_Of_Times_Email_Opened__c = ++noOfTimesOpened;
        emailTrace.Last_Time_Opened__c = Datetime.now();
        emailTrace.Claim_ID__c  = claimID;
        emailTrace.Claim__c = claimID;
        upsert emailTrace Claim_ID__c;
 
        //You can also modify the code accordingly like to count how many times the same email is opened
    }
}