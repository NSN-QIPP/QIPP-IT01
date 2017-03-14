global class SPE2_ScorecardTrackerValueInsert implements Database.Batchable<sobject>,Database.Stateful
{
    List<sObject> ls { set; get; }
    global SPE2_ScorecardTrackerValueInsert(List<sObject> ls)
    {        
        this.ls = ls;
    }
    
	global Iterable<sObject> start(Database.BatchableContext BC)
    {
        return ls;
    }
    
    global void execute (Database.BatchableContext BC, List<sobject> Ols)
    {
        Insert Ols;
    }
    
    global void finish(Database.BatchableContext BC)
    {        
        system.debug('addition batch process...............');
    }
}