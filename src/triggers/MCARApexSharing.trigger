trigger MCARApexSharing on MCAR__c (after insert,after update, before update) {
    
    Group NSNUser=[SELECT Id from Group where name=:'MCAR_NSN_Users'];
    Group NSNSupUser=[SELECT Id from group where name=:'MCAR_NSN_SuperUser'];
    Group NSNInternalFactory=[SELECT Id from group where name=:'MCAR_Internal_Sub_Factory'];
    Group ESMUser=[SELECT Id from group where name=:'MCAR_ESM_User'];
    Group Flextronics=[SELECT Id from group where name=:'MCAR EMS Flextronics'];
    Group Foxconn=[SELECT Id from group where name=:'MCAR EMS Foxconn'];
    Group JabilCircuit=[SELECT Id from group where name=:'MCAR EMS Jabil Circuit'];
    Group MLSManufacturing=[SELECT Id from group where name=:'MCAR EMS ML&S Manufacturing'];
    Group SanminaSCI=[SELECT Id from group where name=:'MCAR EMS SanminaSCI'];
    Group SRIRadio=[SELECT Id from group where name=:'MCAR EMS SRI Radio'];

    
 if(trigger.isInsert){
        //Create a new list of Sharing object for MCAR
        
    List<MCAR__Share> mcarShares = new List<MCAR__Share>();
    
    //Declare the variables for Owner,Supplier sharing
    
    MCAR__Share OwnerShr;
    MCAR__Share CreatedByShr;
    MCAR__Share ContactShr;
    MCAR__Share MCARNSNUserShr;
    MCAR__Share MCARNSNSUserShr;
    MCAR__Share MCARNSNInternalSubFactoryShr;
    MCAR__Share MCARESMUserShr;
    
    for(MCAR__c mcar : trigger.new){
   List<MCAR_Manufacturer_Contact__c> mcarContact = [SELECT MCAR_Manufacturer_Contact__c.MCAR_User__r.Id FROM MCAR_Manufacturer_Contact__c WHERE MCAR_Manufacturer_Contact__c.Manufacturer_Name__r.Id=: mcar.MCAR_Manufacturer__c and MCAR_User__r.Id !=null];
   system.debug('+++++++++++++++++++++++++++ With Duplicate Value+++++++++++++++++++++ '+mcarContact );
   List<MCAR_Manufacturer_Contact__c> DistinctCon = new List<MCAR_Manufacturer_Contact__c>();
   Boolean ConMatch = FALSE;
    for(MCAR_Manufacturer_Contact__c excon : mcarContact){
        ConMatch = FALSE;
        for(MCAR_Manufacturer_Contact__c newcon : DistinctCon)
            if(excon.MCAR_User__r.Id == newcon.MCAR_User__r.Id){ 
                ConMatch = TRUE; Break;}
        if(ConMatch == FALSE)
            DistinctCon.add(excon);
        }
    system.debug('+++++++++++++++++++++++++++WithOut Duplicate Value ++++++++++++++++++++'+DistinctCon );
    

        CreatedByShr = new MCAR__Share();
        CreatedByShr.ParentId = mcar.Id;
        if(mcar.CreatedById != null)
            { 
                id Creator = mcar.CreatedById;
                CreatedByShr.UserorGroupId = Creator;
                CreatedByShr.AccessLevel = 'edit';
                CreatedByShr.RowCause = Schema.MCAR__Share.RowCause.CreatedBy__c ;
                mcarShares.add(CreatedByShr);
            }
  
   }
        Database.SaveResult[] lsr = Database.insert(mcarShares,false);
        
        //Create  Counter
        
        Integer i=0;
        
        //Process the Save Result
        
        for(Database.SaveResult sr : lsr){
        
            if(!sr.isSuccess()){
                // Get the first Save result error
                Database.Error err = sr.getErrors()[0];
                
                // Check if the error is related to a trivial access level 
    
                // Access levels equal or more permissive than the object's default  
    
                // access level are not allowed.  
    
                // These sharing records are not required and thus an insert exception is  
    
                // acceptable.  
                
                if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION
                                                && err.getMessage().contains('AccessLevel'))){
                        // Throw an error when the error is not related to trivial access level.
trigger.newMap.get(mcarShares[i].ParentId).addError('Unable to grant sharing access due to following exception :' + err.getMessage());
            }
        }
          i++;
    
    }
  }
  

if(trigger.isUpdate) {
       //Create a new list of Sharing object for MCAR
        
     list<MCAR__Share> umcarShares = new list<MCAR__Share>();
     list<MCAR__Share> delMCARShares = new list<MCAR__Share>();

    MCAR__Share uOwnerShr;
    MCAR__Share uCreatedByShr;
    MCAR__Share uContactShr;
    MCAR__Share uMCARNSNUserShr;
    MCAR__Share uMCARNSNSUserShr;
    MCAR__Share uMCARNSNInternalSubFactoryShr;
    MCAR__Share uMCARESMUserShr;
    MCAR__Share uMCAREMSFlextronicsShr;
    MCAR__Share uMCAREMSFoxconnShr;
    MCAR__Share uMCAREMSJabilCircuitShr;
    MCAR__Share uMCAREMSMLSManufacturingShr;
    MCAR__Share uMCAREMSSanminaSCIShr;
    MCAR__Share uMCAREMSSRIRadioShr;

    integer j = 0;
    integer k = 0;
    
    for(MCAR__c mcar : trigger.new){
    List<MCAR_Manufacturer_Contact__c> mcarContact = [SELECT MCAR_Manufacturer_Contact__c.MCAR_User__r.Id FROM MCAR_Manufacturer_Contact__c WHERE MCAR_Manufacturer_Contact__c.Manufacturer_Name__r.Id=: mcar.MCAR_Manufacturer__c and MCAR_User__r.Id !=null];
    List<MCAR_Manufacturer_Contact__c> DistinctCon = new List<MCAR_Manufacturer_Contact__c>();
    Boolean ConMatch = FALSE;
    for(MCAR_Manufacturer_Contact__c excon : mcarContact){
        ConMatch = FALSE;
        for(MCAR_Manufacturer_Contact__c newcon : DistinctCon)
            if(excon.MCAR_User__r.Id == newcon.MCAR_User__r.Id){ 
                ConMatch = TRUE; Break;}
        if(ConMatch == FALSE)
            DistinctCon.add(excon);
        }      
             if(trigger.isBefore)
        
                if(trigger.old[j].MCAR_Manufacturer__c != mcar.MCAR_Manufacturer__c && trigger.old[j].MCAR_Manufacturer__c !=null){
                    delMCARShares.addAll([SELECT Id FROM MCAR__Share WHERE ParentId =: mcar.id AND RowCause =: 'Supplier__c']);}
     if(mcar.MCAR_Status__c == 'Open' || mcar.MCAR_Status__c == 'Cancelled')
         {    
             
             //Instantite the sharing objects
                uContactShr= new MCAR__Share();
                uMCARNSNUserShr =new MCAR__Share();
                uMCARNSNSUserShr =new MCAR__Share();
                uMCARNSNInternalSubFactoryShr = new MCAR__Share();
                uMCARESMUserShr = new MCAR__Share();
                uMCAREMSFlextronicsShr = new MCAR__Share();
                uMCAREMSFoxconnShr = new MCAR__Share();
                uMCAREMSJabilCircuitShr = new MCAR__Share();
                uMCAREMSMLSManufacturingShr = new MCAR__Share();
                uMCAREMSSanminaSCIShr = new MCAR__Share();
                uMCAREMSSRIRadioShr = new MCAR__Share();

                
             //Set the ID of record being shared
                uMCARNSNUserShr.ParentId = mcar.Id;
                uMCARNSNSUserShr.ParentId = mcar.Id;
                uMCARNSNInternalSubFactoryShr.ParentId = mcar.Id;
                uMCARESMUserShr.ParentId = mcar.Id;
                uMCAREMSFlextronicsShr.ParentId = mcar.Id;
                uMCAREMSFoxconnShr.ParentId = mcar.Id; 
                uMCAREMSJabilCircuitShr.ParentId = mcar.Id; 
                uMCAREMSMLSManufacturingShr.ParentId = mcar.Id; 
                uMCAREMSSanminaSCIShr.ParentId = mcar.Id; 
                uMCAREMSSRIRadioShr.ParentId = mcar.Id;

            if(!DistinctCon.isEmpty())
            {   
                for(MCAR_Manufacturer_Contact__c con1 : DistinctCon ){
                 uContactShr= new MCAR__Share();
                 uContactShr.ParentId = mcar.Id;
                 uContactShr.UserorGroupId = con1.MCAR_User__r.Id;
                 uContactShr.AccessLevel = 'edit';
                 uContactShr.RowCause = Schema.MCAR__Share.RowCause.Supplier__c;
                 umcarShares.add(uContactShr);
                }
            }
            if(NSNUser != null)
            {
                uMCARNSNUserShr.UserorGroupId = NSNUser.Id;
                uMCARNSNUserShr.AccessLevel = 'Read';
                uMCARNSNUserShr.RowCause = Schema.MCAR__Share.RowCause.MCAR_NSN_User__c;
                umcarShares.add(uMCARNSNUserShr);
            }
            if(NSNSupUser != null)
            {
                  uMCARNSNSUserShr.UserorGroupId =NSNSupUser.Id;
                  uMCARNSNSUserShr.AccessLevel = 'All';
                  uMCARNSNSUserShr.RowCause = Schema.MCAR__Share.RowCause.MCAR_NSN_SuperUser__c;
                  umcarShares.add(uMCARNSNSUserShr); 
            }
            if(NSNInternalFactory != null)
            {
                  uMCARNSNInternalSubFactoryShr.UserorGroupId = NSNInternalFactory.Id;
                  uMCARNSNInternalSubFactoryShr.AccessLevel = 'Read';
                  uMCARNSNInternalSubFactoryShr.RowCause = Schema.MCAR__Share.RowCause.MCAR_Internal_Sub_Factory__c;
                  umcarShares.add(uMCARNSNInternalSubFactoryShr);
            }
                        if(mcar.MCAR_Facility__c != null)
            {
                MCAR_Facility__c facility =[SELECT MCAR_Facility_Type__c,MCAR_Facility_Company__c FROM MCAR_Facility__c WHERE Id =: mcar.MCAR_Facility__c];//.MCAR_Facility_Type__c;
             if(facility.MCAR_Facility_Type__c =='EMS' && facility.MCAR_Facility_Company__c =='Flextronics')
             {
                if(Flextronics !=NULL)
                    {
                    system.Debug('ababababababababbababababbabababababababababbabaababbabababaabababab::::'+Flextronics);
                        uMCAREMSFlextronicsShr.UserorGroupId = Flextronics.Id;
                        uMCAREMSFlextronicsShr.AccessLevel = 'Edit';
                        uMCAREMSFlextronicsShr.RowCause = Schema.MCAR__Share.RowCause.MCAR_EMS_Flextronics__c;
                        umcarShares.add(uMCAREMSFlextronicsShr);
                    }
             }
             if(facility.MCAR_Facility_Type__c =='EMS' && facility.MCAR_Facility_Company__c =='Foxconn')
             {
                 if(Foxconn !=NULL)
                    {
                    system.Debug('ababababababababbababababbabababababababababbabaababbabababaabababab::::'+Foxconn);
                        uMCAREMSFoxconnShr.UserorGroupId = Foxconn.Id;
                        uMCAREMSFoxconnShr.AccessLevel = 'Edit';
                        uMCAREMSFoxconnShr.RowCause = Schema.MCAR__Share.RowCause.MCAR_EMS_Foxconn__c;
                        umcarShares.add(uMCAREMSFoxconnShr);
                    }
             }
             if(facility.MCAR_Facility_Type__c =='EMS' && facility.MCAR_Facility_Company__c =='Jabil Circuit')
             {
                 if(JabilCircuit!=NULL)
                    {
                    system.Debug('ababababababababbababababbabababababababababbabaababbabababaabababab::::'+JabilCircuit);
                        uMCAREMSJabilCircuitShr .UserorGroupId = JabilCircuit.Id;
                        uMCAREMSJabilCircuitShr .AccessLevel = 'Edit';
                        uMCAREMSJabilCircuitShr .RowCause = Schema.MCAR__Share.RowCause.MCAR_EMS_Jabil_Circuit__C;
                        umcarShares.add(uMCAREMSJabilCircuitShr);
                    }
             }
             if(facility.MCAR_Facility_Type__c =='EMS' && facility.MCAR_Facility_Company__c =='ML&S Manufacturing')
             {
                 if(MLSManufacturing!=NULL)
                    {
                    system.Debug('ababababababababbababababbabababababababababbabaababbabababaabababab::::'+MLSManufacturing);
                        uMCAREMSMLSManufacturingShr.UserorGroupId = MLSManufacturing.Id;
                        uMCAREMSMLSManufacturingShr.AccessLevel = 'Edit';
                        uMCAREMSMLSManufacturingShr.RowCause = Schema.MCAR__Share.RowCause.MCAR_EMS_Flextronics__c;
                        umcarShares.add(uMCAREMSMLSManufacturingShr);
                    }
             }
             if(facility.MCAR_Facility_Type__c =='EMS' && facility.MCAR_Facility_Company__c =='Sanmina-SCI')
             {
                 if(SanminaSCI!=NULL)
                    {
                    system.Debug('ababababababababbababababbabababababababababbabaababbabababaabababab::::'+SanminaSCI);
                        uMCAREMSSanminaSCIShr.UserorGroupId = SanminaSCI.Id;
                        uMCAREMSSanminaSCIShr.AccessLevel = 'Edit';
                        uMCAREMSSanminaSCIShr.RowCause = Schema.MCAR__Share.RowCause.MCAR_EMS_Flextronics__c;
                        umcarShares.add(uMCAREMSSanminaSCIShr);
                    }
             }
             if(facility.MCAR_Facility_Type__c =='EMS' && facility.MCAR_Facility_Company__c =='SRI Radio Systems')
             {
                 if(SRIRadio!=NULL)
                    {
                    system.Debug('ababababababababbababababbabababababababababbabaababbabababaabababab::::'+SRIRadio);
                        uMCAREMSSRIRadioShr.UserorGroupId = SRIRadio.Id;
                        uMCAREMSSRIRadioShr.AccessLevel = 'Edit';
                        uMCAREMSSRIRadioShr.RowCause = Schema.MCAR__Share.RowCause.MCAR_EMS_Flextronics__c;
                        umcarShares.add(uMCAREMSSRIRadioShr);
                    }
             }
            }
         }
         uCreatedByShr = new MCAR__Share();
         uCreatedByShr.ParentId = mcar.Id;
         if(mcar.CreatedById !=null)
            {
                uCreatedByShr.UserorGroupId = mcar.CreatedById;
                uCreatedByShr.AccessLevel = 'edit';
                uCreatedByShr.RowCause = Schema.MCAR__Share.RowCause.CreatedBy__c ;
                umcarShares.add(uCreatedByShr);
            }
         j++;
         k++;
   }
    if(trigger.isBefore){
        Database.DeleteResult[] dlsr = Database.Delete(delMCARShares,false); }
        Database.SaveResult[] lsr = Database.insert(umcarShares,false); 

        //Create  Counter
        
        Integer i=0;
        
        //Process the Save Result
        
        for(Database.SaveResult sr : lsr){
        
            if(!sr.isSuccess()){
                // Get the first Save result error
                Database.Error err = sr.getErrors()[0];
                
                // Check if the error is related to a trivial access level 
    
                // Access levels equal or more permissive than the object's default  
    
                // access level are not allowed.  
    
                // These sharing records are not required and thus an insert exception is  
    
                // acceptable.  
                
                if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION
                                                && err.getMessage().contains('AccessLevel'))){
                        // Throw an error when the error is not related to trivial access level.
//trigger.newMap.get(umcarShares[i].ParentId).addError('Unable to grant sharing access due to following exception :' + err.getMessage());
            }
        }
          i++;
    }
   }
   }