global class SPE_ScorecardPdfBatchUpdate implements Database.Batchable <sObject> , Schedulable, Database.AllowsCallouts {

    
    global void execute(SchedulableContext sc) {
        Database.executebatch(new SPE_ScorecardPdfBatchUpdate(),1);
    }

    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        date d=system.today();
        String query ='select id from SPE_ScoreCard__c where EndDate__c=:d';
        return Database.getQueryLocator(query);
        
    }

    global void execute(Database.BatchableContext BC, list<SPE_ScoreCard__c> scope) {
    
    list<attachment> attachmentstoInsert= new list<attachment>();
               for(SPE_ScoreCard__c s:scope) {
               
                HttpRequest request = new HttpRequest();
                request.SetMethod('GET');
                request.SetEndPoint('http://dev02-nsn.cs10.force.com/scorecard?id='+s.Id);
                               
                HttpResponse httpResponse = new Http().Send(request);
                Blob pdf = httpResponse.GetBodyAsBlob();
                system.debug(pdf);               
                Attachment attachment = new Attachment();
                attachment.Body = pdf;
                attachment.Name = 'New check'+'.pdf';
                attachment.parentId =s.id;
                attachmentstoInsert.add(attachment);            
         }
            insert attachmentstoInsert;   
    }
    
    global void finish(Database.BatchableContext BC) {

    }
}