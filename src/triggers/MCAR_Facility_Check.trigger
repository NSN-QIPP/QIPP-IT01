trigger MCAR_Facility_Check on MCAR_Facility__c (before insert, before update,after update) {

   
    if (Trigger.isInsert) {
     List<MCAR_Facility__c> facilitynew = new List<MCAR_Facility__c>();
       facilitynew = [select Id, MCAR_Facility_Type__c, Name, MCAR_Facility_Company__c from MCAR_Facility__c];
       for (MCAR_Facility__c faci : Trigger.new)    {
           if (facilitynew.size() > 0) { 
              for(Integer j = 0; j < facilitynew.size(); j++){  
                  if(faci.Name == facilitynew[j].Name && faci.MCAR_Facility_Company__c == facilitynew[j].MCAR_Facility_Company__c && faci.MCAR_Facility_Type__c == facilitynew[j].MCAR_Facility_Type__c) {
                       faci.addError('Record already exist with same Facility Name, Company & Type.');
                  }
              }
           }    
       }
    }
           
   /*
   
    if (Trigger.isUpdate) {        
         for (Integer i = 0; i < Trigger.new.size(); i++)    {
                if (Trigger.new[i].Name == Trigger.old[i].Name) {
                    if (Trigger.new[i].MCAR_Facility_Company__c == Trigger.old[i].MCAR_Facility_Company__c) {
                        if (Trigger.new[i].MCAR_Facility_Type__c == Trigger.old[i].MCAR_Facility_Type__c) {
                             Trigger.new[i].addError('Record already exist with same Facility Name, Company & Type. here');
                        } 
                    }                
               }
          }             
     } 
*/
}