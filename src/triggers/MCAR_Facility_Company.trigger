trigger MCAR_Facility_Company on MCAR__c (before insert , before update) 
{
     //if(Trigger.isInsert)
     //{    
         List<MCAR__c> McarRecords = Trigger.New;
         for(MCAR__c mcar : McarRecords)
         {
             Id id = mcar.MCAR_Facility__c;
             if(id != null)
             {
                 List<MCAR_Facility__c> FacilityDetails = [Select Name , MCAR_Facility_Company__c , MCAR_Facility_Type__c from MCAR_Facility__c WHERE ID =: id]; 
                 if(FacilityDetails != null){
                 mcar.H_Facility_Name__c = FacilityDetails[0].Name; 
                 mcar.Facility_Company__c = FacilityDetails[0].MCAR_Facility_Company__c;
                 mcar.Facility_Type__c = FacilityDetails[0].MCAR_Facility_Type__c;
                 System.Debug('****************** Facility Name ********************** ' + mcar.H_Facility_Name__c);
                 System.Debug('****************** Facility Company ********************** ' + mcar.Facility_Company__c);
                 System.Debug('****************** Facility Type ********************** ' + mcar.Facility_Type__c);
                 }
             }
         }
     //}
}