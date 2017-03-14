trigger MCAR_Set_Approval_CheckedDate on MCAR__c (before insert, before update) {
    // This is trigger for requirement CR31 in which we have to set 
    // timestamp when 8D fields(Ready for review & Approval) are checked.
    // So its Ready Review & Approval date are captured in Database.
    
     
    
    if (Trigger.isInsert || Trigger.isUpdate) {
        for (MCAR__c mcar : Trigger.new) {
         
             if(mcar.Class_Access__c == FALSE){
    if(mcar.Class_Access1__c == FALSE){
    if(mcar.Class_Access2__c == FALSE){
    if(mcar.Class_Access3__c == FALSE){
    if(mcar.Class_Access4__c == FALSE){  
             if(mcar.MCAR_3D_Approval__c) {
                mcar.MCAR_3D_Approval_Date__c =  datetime.now();
             }
             if(!mcar.MCAR_3D_Approval__c) {
                 mcar.MCAR_3D_Approval_Date__c =  null;
             }
             
             if(mcar.MCAR_4D_Approval__c) {
                mcar.MCAR_4D_Approval_Date__c =  datetime.now();
             }
             if(!mcar.MCAR_4D_Approval__c) {
                 mcar.MCAR_4D_Approval_Date__c =  null;
             }  
            
             if(mcar.MCAR_5D_Approval__c) {
                mcar.MCAR_5D_Approval_Date__c =  datetime.now();
             }
             if(!mcar.MCAR_5D_Approval__c) {
                 mcar.MCAR_5D_Approval_Date__c =  null;
             }
            
             if(mcar.MCAR_6D_Approval__c) {
                mcar.MCAR_6D_Approval_Date__c =  datetime.now();
             }
             if(!mcar.MCAR_6D_Approval__c) {
                 mcar.MCAR_6D_Approval_Date__c =  null;
             }
             
             if(mcar.MCAR_7D_Approval__c) {
                mcar.MCAR_7D_Approval_Date__c =  datetime.now();
             }
             if(!mcar.MCAR_7D_Approval__c) {
                 mcar.MCAR_7D_Approval_Date__c =  null;
             } 
             
             
             
         }else
       mcar.Class_Access4__c = FALSE;}else
       mcar.Class_Access3__c = FALSE;}else
       mcar.Class_Access2__c = FALSE;}else
       mcar.Class_Access1__c = FALSE;}else
       mcar.Class_Access__c = FALSE;
        }
    }       
}