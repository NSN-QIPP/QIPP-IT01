trigger ADD_Manufacturer_Email on Claim_Contact__c (before insert, before update)
{  
   set<ID> claimsIDSet = new set<ID>();
   
    for(Claim_Contact__c triggger_obj : Trigger.new)
    {
        claimsIDSet.add(triggger_obj.Claims__c);
    }
    
    map<ID,MCAR_Claim_Management__c> MCARClaimsMap = new map<ID,MCAR_Claim_Management__c>([select ID,Manufacturer_Email__c,Category_Manager_Email__c,
                                                                                            Category_Manager_Name__c,Manufacturer_Name__c
                                                                                            from MCAR_Claim_Management__c where ID IN : claimsIDSet]);
   
    for (Claim_Contact__c triggger_obj: Trigger.new){
        if (triggger_obj.Contact_Type__c== 'Manufacturer'){
        /* COMMENTED MY VIVEK SINGH AS QUERY AND DML IS WRITTEN IN LOOP.
            MCAR_Claim_Management__c parent_obj = [select Manufacturer_Email__c from MCAR_Claim_Management__c WHERE id =: triggger_obj.Claims__c]; 
            
            parent_obj.Manufacturer_Email__c = triggger_obj.Email__c;
            
            update parent_obj;*/
        
            //MCARClaimsMap.get(triggger_obj.Claims__c).Manufacturer_Email__c = triggger_obj.Email__c;
            MCARClaimsMap.get(triggger_obj.Claims__c).Manufacturer_Name__c  = triggger_obj.Name__c;
            System.debug('Manufacturer Details : '+MCARClaimsMap.get(triggger_obj.Claims__c));
        
        }
           
        if (triggger_obj.Contact_Type__c== 'Category Manager'){
        /* COMMENTED MY VIVEK SINGH AS QUERY AND DML IS WRITTEN IN LOOP.
            MCAR_Claim_Management__c parent_obj = [select Category_Manager_Email__c,Category_Manager_Name__c from MCAR_Claim_Management__c WHERE id =: triggger_obj.Claims__c]; 
            
            parent_obj.Category_Manager_Email__c = triggger_obj.Email__c;
            parent_obj.Category_Manager_Name__c = triggger_obj.Name__c;
          
            update parent_obj;*/
            MCARClaimsMap.get(triggger_obj.Claims__c).Category_Manager_Email__c = triggger_obj.Email__c;
            MCARClaimsMap.get(triggger_obj.Claims__c).Category_Manager_Name__c  = triggger_obj.Name__c;                 
        }                
    }    
    update MCARClaimsMap.values();
}