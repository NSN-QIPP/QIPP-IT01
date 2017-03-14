trigger QIPP_BCTDuplicateRecordValidation on QIPP_Benefit_Conversion_Table__c (before insert, before update) {

     Set<string> Set1= new Set<string>();
     for(QIPP_Benefit_Conversion_Table__c c1:trigger.new)
     {
       Set1.add(c1.Financial_Impact_Calculation_Driver__c);
     }
     Set<string> Set2= new Set<string>();
     for(QIPP_Benefit_Conversion_Table__c c2:trigger.new)
     {
       Set2.add(c2.Business_Line__c);
     }
     Set<string> Set3= new Set<string>();
     for(QIPP_Benefit_Conversion_Table__c c3:trigger.new)
     {
       Set3.add(c3.Fiscal_Year__c);
     }
     Set<string> Set4= new Set<string>();
     for(QIPP_Benefit_Conversion_Table__c c4:trigger.new)
     {
       Set4.add(c4.Fiscal_Quarter__c);
     }

     List<QIPP_Benefit_Conversion_Table__c> listbct= new List<QIPP_Benefit_Conversion_Table__c>();
     listbct=[select Financial_Impact_Calculation_Driver__c,Business_Line__c,Fiscal_Year__c,Fiscal_Quarter__c from QIPP_Benefit_Conversion_Table__c where Financial_Impact_Calculation_Driver__c in :Set1 and Business_Line__c in :Set2 and Fiscal_Year__c in :Set3 and Fiscal_Quarter__c in :Set4];
     
     for (QIPP_Benefit_Conversion_Table__c aNew:Trigger.New)
     {
      if(listbct.size()>0){
        aNew.addError('Duplicate record found with the same values of Financial Impact Calculation Driver,Business Line for the Fiscal Year and Quarter'); 
        } 
     }
     
     
}