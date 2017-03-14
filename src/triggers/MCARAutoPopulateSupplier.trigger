trigger MCARAutoPopulateSupplier on MCAR__c (before insert, before update) {
   if(Trigger.isBefore)
   {
    for(Mcar__c currentMCAR: Trigger.new)
    {
         List<MCAR_Meps__c> selectedMeps;
         List<NSN_Part__c> selectedNSNPart;
         List<MCAR_Manufacturer__c> selectedSupplier; 
            
        // If NSN Part is selected look for matching supplier and populate the Supplier lookup     
        if(currentMCAR.MCAR_NSN_Code__c != null) 
        {
            selectedMeps = [select id, MCAR_NSN_Part__c, Manufacturer_Name__c, MCAR_Mfg_Part_Number__c, MCAR_MEPS_Enterprise_ID__c  from MCAR_MEPS__c where id =: currentMCAR.MCAR_NSN_Code__c ];
            if (selectedMeps.size() !=0 )
            { currentMCAR.MCAR_Part_Enterprise_ID__c = selectedMeps[0].MCAR_MEPS_Enterprise_ID__c;
               currentMCAR.MCAR_Mfg_Part_Number__c = selectedMeps[0].MCAR_Mfg_Part_Number__c;

             }         
         }
        if(selectedMeps != null)
        {
            selectedSupplier= [select id, Name from MCAR_Manufacturer__c where id =: selectedMeps[0].Manufacturer_Name__c];
            if (selectedSupplier.size() != 0) {
                currentMCAR.MCAR_Manufacturer__c= selectedSupplier[0].Id;
                //currentMCAR.MCAR_Part_Manufacturer__c= selectedSupplier[0].Name;
             } else {
                 // to do - take care of else scenario
            }
                  
        }
        if(selectedMeps != null)
        {
            selectedNSNPart = [select id, Name, Description__c, NSN_Part_Lifecycle__c, NSN_Part_Type__c, NSN_Part_Family__c, NSN_Part_Recomendation__c, Category__c, Category_Area__c, Category_Group__c, Sub_Category_ID_ESN__c,COM__c from NSN_Part__c where id =: selectedMeps[0].MCAR_NSN_Part__c]; 
            if(selectedNSNPart.size() != 0 )
            {currentMCAR.MCAR_Part_Description__c = selectedNSNPart[0].Description__c;
            currentMCAR.MCAR_Part_Lifecycle__c = selectedNSNPart[0].NSN_Part_Lifecycle__c;
            currentMCAR.MCAR_Part_Type__c = selectedNSNPart[0].NSN_Part_Type__c;
            currentMCAR.MCAR_Part_Family__c = selectedNSNPart[0].NSN_Part_Family__c;
            currentMCAR.MCAR_Index_NSN_Code__c = selectedNSNPart[0].Name;
            currentMCAR.MCAR_Part_Recommendation__c = selectedNSNPart[0].NSN_Part_Recomendation__c;
            currentMCAR.Category__c = selectedNSNPart[0].Category__c;
            currentMCAR.Category_Area_text__c = selectedNSNPart[0].Category_Area__c;
            currentMCAR.Category_Group_text__c = selectedNSNPart[0].Category_Group__c;
            //currentMCAR.Sub_Category_ID_ESN__c = selectedNSNPart[0].Sub_Category_ID_ESN__c;
            currentMCAR.Sub_Category_ID_ESN__c = selectedNSNPart[0].COM__c;
    
            }
        }
    }
    }
}