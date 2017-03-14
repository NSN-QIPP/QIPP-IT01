trigger MCAR_Claim_Type_Update on MCAR_Claim_Management__c (before Insert, before Update) 
{
      
Date cDT = Date.today();


      
      for(MCAR_Claim_Management__c parentobj : Trigger.New)
      {           
           //changed by veera      
           Id id = parentobj.Facility__c;
           Id ClaimId = parentobj.Related_Claim__c;
                  if(id!=null)
                  {
                   List<MCAR_Facility__c> FacilityDetails = [Select Name  from MCAR_Facility__c WHERE ID =: id];
                     if(FacilityDetails != null){
                     parentobj.H_Facility_Name__c=FacilityDetails[0].Name;
                     }
                   }
                   
                    if(ClaimId!=null)
                  {
                   List<MCAR_Claim_Management__c> ClaimDetails = [Select Name  from MCAR_Claim_Management__c WHERE ID =: ClaimId];
                     if(ClaimDetails != null){
                     parentobj.H_Related_Claim__c=ClaimDetails[0].Name;
                     }
                  }
                  
               
                  if((parentobj.Technical_Details_Review_Approval__c == true) && (parentobj.Root_Cause_Analysis_Approved_Date__c == null))
                  {
                    parentobj.Root_Cause_Analysis_Approved_Date__c = cDT;
                  }
                   if((parentobj.Legal_Team_Review_Approval__c == true) && (parentobj.Legal_Analysis_Approved_Date__c == null))
                  {
                    parentobj.Legal_Analysis_Approved_Date__c = cDT;
                  }
                   if((parentobj.Commodity_Manager_Review_Approval__c == true) && (parentobj.Commodity_Manager_Approved_Date__c == null))
                  {
                    parentobj.Commodity_Manager_Approved_Date__c = cDT;
                  }
                   if((parentobj.Nonconformance_Costs_Review_Approval__c == true) && (parentobj.Non_Conformance_Costs_Approved_Date__c == null))
                  {
                    parentobj.Non_Conformance_Costs_Approved_Date__c = cDT;
                  }

                  
                 
            // MCAR_Claim_Management__c newobj = [select Services_Loss__c,Claim_Type__c from MCAR_Claim_Management__c where ID =:parentobj.ID];
            
              if (parentobj.Override_Claim_Type__c != true)   
              {
                    if (parentobj.Total_Cost_To_Be_Claimed__c < 50000)
                    {
                parentobj.Claim_Type__c='Local';               
                    }
                else if (parentobj.Total_Cost_To_Be_Claimed__c >= 50000)
                    {

                 parentobj.Claim_Type__c='Global';

                    }
              }   
              
                    /*if (parentobj.Claim_Status__c=='Data Collection')  
                    {
                    parentobj.RecordTypeId='012J0000000CojyIAC';
                    }
                    
                    if (parentobj.Claim_Status__c=='Negotiation')  
                    {
                    parentobj.RecordTypeId='012K00000004WPs';
                    }
                    
                    if (parentobj.Claim_Status__c=='Closed')  
                    {
                    parentobj.RecordTypeId='012K00000004WPt';
                    }*/
   // update newobj ;
      }
  
}