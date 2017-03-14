public  class ConvertTextToDate {
  public static boolean run = true;
 public static void ConvertToDate(list<SPE_SPETracker__c> spetracker)
 {
     
 list<SPE_SPETracker__c> spetracklist = new list<SPE_SPETracker__c>();
     list<SPE_SPETracker__c> spetracklist1 = new list<SPE_SPETracker__c>();
   SPE_SPETracker__c[] sp = null;
    
     if(run){
          run=false;
     set<id> Trackerids = new set<id>();
     for(SPE_SPETracker__c spetrack : spetracker)
     {
        Trackerids.add(spetrack.id); 
         
     }
      spetracklist = [select id,name,Period_Date__c from SPE_SPETracker__c where id in:Trackerids];
     
        for(SPE_SPETracker__c spetrack : spetracklist)
        {
        Map <String, Integer> months = new Map <String, Integer> {'January'=>1, 'February'=>2, 'March'=>3, 'April'=>4, 'May'=>5, 'June'=>6, 'July'=>7, 'August'=>8, 'September'=>9, 'October'=>10, 'November'=>11, 'December'=>12};    
         string spename = spetrack.name;
          List <String> dateParts = spename.split(' - ');  
           Integer month = months.get(dateParts[0]);
           Integer year = Integer.valueOf(dateParts[1]);
           Date parsedDate = Date.newInstance(year,month,1);
           spetrack.Period_Date__c = parsedDate;
             spetracklist1.add(spetrack);
        }
     update spetracklist1;
     }
 } 

}