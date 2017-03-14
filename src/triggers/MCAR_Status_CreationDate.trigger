trigger MCAR_Status_CreationDate on MCAR__c (before insert, before update) {
    
    if (Trigger.isInsert) {
        for (MCAR__c mcar : Trigger.new)    {
            if(mcar.Class_Access__c == FALSE){
    if(mcar.Class_Access1__c == FALSE){
    if(mcar.Class_Access2__c == FALSE){
    if(mcar.Class_Access3__c == FALSE){
    if(mcar.Class_Access4__c == FALSE){  
            if (mcar.MCAR_Status__c == 'Open' ) {
                //if( mcar.MCAR_Creation_Date_Status_Open__c == null)
                    //mcar.MCAR_Creation_Date_Status_Open__c = System.Today();
           
                mcar.MCAR_3D_Due_Date__c= mcar.MCAR_Creation_Date_Status_Open__c + Integer.valueOf(mcar.MCAR_3D_Days_Allowed__c);
                mcar.MCAR_4D_Due_Date__c= mcar.MCAR_Creation_Date_Status_Open__c + Integer.valueOf(mcar.MCAR_4D_Days_Allowed__c);
                mcar.MCAR_5D_Due_Date__c= mcar.MCAR_Creation_Date_Status_Open__c + Integer.valueOf(mcar.MCAR_5D_Days_Allowed__c);
                mcar.MCAR_6D_Due_Date__c= mcar.MCAR_Creation_Date_Status_Open__c + Integer.valueOf(mcar.MCAR_6D_Days_Allowed__c);
                mcar.MCAR_7D_Due_Date__c= mcar.MCAR_Creation_Date_Status_Open__c + Integer.valueOf(mcar.MCAR_7D_Days_Allowed__c);
    
            
            }
              }else
       mcar.Class_Access4__c = FALSE;}else
       mcar.Class_Access3__c = FALSE;}else
       mcar.Class_Access2__c = FALSE;}else
       mcar.Class_Access1__c = FALSE;}else
       mcar.Class_Access__c = FALSE;
        }
        
      
    }
    if (Trigger.isUpdate) {
  
      for (Integer i = 0; i < Trigger.new.size(); i++)    {
      
        if(Trigger.new[i].Class_Access__c == FALSE){
    if(Trigger.new[i].Class_Access1__c == FALSE){
    if(Trigger.new[i].Class_Access2__c == FALSE){
    if(Trigger.new[i].Class_Access3__c == FALSE){
    if(Trigger.new[i].Class_Access4__c == FALSE){    
  
       if (Trigger.new[i].MCAR_Status__c != Trigger.old[i].MCAR_Status__c && Trigger.old[i].MCAR_Status__c == 'Draft') {
      
              Trigger.new[i].MCAR_Creation_Date_Status_Open__c = System.Today();  
                Trigger.new[i].MCAR_3D_Due_Date__c= Trigger.new[i].MCAR_Creation_Date_Status_Open__c + Integer.valueOf(Trigger.new[i].MCAR_3D_Days_Allowed__c);
                Trigger.new[i].MCAR_4D_Due_Date__c= Trigger.new[i].MCAR_Creation_Date_Status_Open__c + Integer.valueOf(Trigger.new[i].MCAR_4D_Days_Allowed__c);
                Trigger.new[i].MCAR_5D_Due_Date__c= Trigger.new[i].MCAR_Creation_Date_Status_Open__c + Integer.valueOf(Trigger.new[i].MCAR_5D_Days_Allowed__c);
                Trigger.new[i].MCAR_6D_Due_Date__c= Trigger.new[i].MCAR_Creation_Date_Status_Open__c + Integer.valueOf(Trigger.new[i].MCAR_6D_Days_Allowed__c);
                Trigger.new[i].MCAR_7D_Due_Date__c= Trigger.new[i].MCAR_Creation_Date_Status_Open__c + Integer.valueOf(Trigger.new[i].MCAR_7D_Days_Allowed__c);
    
           }
           if(Trigger.old[i].MCAR_Creation_Date_Status_Open__c != null) {
               if (Trigger.new[i].MCAR_Status__c == Trigger.old[i].MCAR_Status__c && Trigger.old[i].MCAR_Status__c == 'Open') {              
                Trigger.new[i].MCAR_Creation_Date_Status_Open__c = Trigger.old[i].MCAR_Creation_Date_Status_Open__c;  
                Trigger.new[i].MCAR_3D_Due_Date__c= Trigger.new[i].MCAR_Creation_Date_Status_Open__c + Integer.valueOf(Trigger.new[i].MCAR_3D_Days_Allowed__c);
                Trigger.new[i].MCAR_4D_Due_Date__c= Trigger.new[i].MCAR_Creation_Date_Status_Open__c + Integer.valueOf(Trigger.new[i].MCAR_4D_Days_Allowed__c);
                Trigger.new[i].MCAR_5D_Due_Date__c= Trigger.new[i].MCAR_Creation_Date_Status_Open__c + Integer.valueOf(Trigger.new[i].MCAR_5D_Days_Allowed__c);
                Trigger.new[i].MCAR_6D_Due_Date__c= Trigger.new[i].MCAR_Creation_Date_Status_Open__c + Integer.valueOf(Trigger.new[i].MCAR_6D_Days_Allowed__c);
                Trigger.new[i].MCAR_7D_Due_Date__c= Trigger.new[i].MCAR_Creation_Date_Status_Open__c + Integer.valueOf(Trigger.new[i].MCAR_7D_Days_Allowed__c);
    
               }
           
           }
            }else
       Trigger.new[i].Class_Access4__c = FALSE;}else
       Trigger.new[i].Class_Access3__c = FALSE;}else
       Trigger.new[i].Class_Access2__c = FALSE;}else
       Trigger.new[i].Class_Access1__c = FALSE;}else
       Trigger.new[i].Class_Access__c = FALSE;
        }
      
    }
    
   
}