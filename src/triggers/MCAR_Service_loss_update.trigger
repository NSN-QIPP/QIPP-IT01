trigger MCAR_Service_loss_update on Claim_NCC_Services_Worksheet__c (after Insert, after Update,after delete) 
{
  
  if(System.Trigger.IsDelete)
  {
       for(Claim_NCC_Services_Worksheet__c childobj : Trigger.Old)
      {
          
    //AggregateResult Calim_total_obj = [select sum(Amount__c) total,Claim__c from Claim_NCC_Services_Worksheet__c where Claim__c=:childobj.Claim__c Group by Claim__c ]; 
    MCAR_Claim_Management__c claim_obj = [select Services_Loss__c,Claim_Type__c from MCAR_Claim_Management__c where ID =:childobj.Claim__c];
    //claim_obj.Services_Loss__c =integer.valueof(Calim_total_obj.get('total'));
    claim_obj.Services_Loss__c =(claim_obj.Services_Loss__c - childobj.Amount__c);
    update claim_obj;
         
       }
  }
else 
  {
      for(Claim_NCC_Services_Worksheet__c childobj : Trigger.New)
      {
   
    AggregateResult Calim_total_obj = [select sum(Amount__c) total,Claim__c from Claim_NCC_Services_Worksheet__c where Claim__c=:childobj.Claim__c Group by Claim__c ]; 
    MCAR_Claim_Management__c claim_obj = [select Services_Loss__c,Claim_Type__c from MCAR_Claim_Management__c where ID =:childobj.Claim__c];
    claim_obj.Services_Loss__c =double.valueof(Calim_total_obj.get('total'));
    update claim_obj;
      }
  }

}