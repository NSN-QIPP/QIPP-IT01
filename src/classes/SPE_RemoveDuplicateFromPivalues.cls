global class SPE_RemoveDuplicateFromPivalues implements Database.Batchable <sObject>,Schedulable 
{
    global Id piIds;
  
    global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this);

    }

    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        Id ID='a1QZ0000003PDbL';
        String query = 'select id,Period__c,EnterpriseID__c,CategoryGroup__c,NumberValue__c from SPE_PIValues__c where PIDefination__c=:ID';
        system.debug('Query*********'+query);
        return Database.getQueryLocator(query);
        
    }

    global void execute(Database.BatchableContext BC, List <SPE_PIValues__c> scope) 
    {
            list<SPE_PIValues__c> p=new list<SPE_PIValues__c>();
            p=[select id,Period__c,EnterpriseID__c,CategoryGroup__c,NumberValue__c from SPE_PIValues__c where PIDefination__c='a1QZ0000003PDbL'];
            
            set<String> setStr= new set<String>();    
            set<id> dup= new set<Id>();
            
            integer k=0;
            for(integer l=0;l<p.size();l++) {
              string s=String.valueOf(p[l].period__c)+String.valueOf(p[l].EnterpriseID__c)+String.valueOf(p[l].CategoryGroup__c)+String.valueOf(p[l].NumberValue__c);         
              if(setStr.contains(s)){
                 dup.add(p[l].id);
                
              }
              else {
              setStr.add(s);
              }
              
            }
           
            
            system.debug('*******dupsize'+dup.size());
            delete[select id from SPE_PIValues__c where id IN: Dup];
            

    }
    
    global void finish(Database.BatchableContext BC) 
    {
         
    }
}