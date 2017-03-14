public class ClaimContactDetilasConroller 
{
    public id ClaimId;
    public MCAR_Claim_Management__c claim;
    public Claim_Contact__c claimContact {set; get;}            
    //public MCAR_Manufacturer__c supplierManager {set; get;}    
    
    public boolean isSaveNew { set; get; }
    public boolean zeroFactoryList { set; get; }
    public boolean zeroMexList { set; get; }
    public boolean zeroNSNuser { set; get; }
    
    public Map<String,Claim_Contact__c> ClaimContactMap {set; get;}    
    public List<Claim_Contact__c> oldClaimContact {set; get;}
    public List<Material_Deviation__c> materialdeviation {set; get;}    
        
    List<AllContacts> supplier { set; get; }
    List<AllContacts> factory {set; get;}
    List<AllContacts> MEXBuyer { set; get; }  
    List<AllContacts> NSNuser {set; get;}
    List<AllContacts> supplierManager { set; get; }
     
    public ClaimContactDetilasConroller()
    {                
        try{
        isSaveNew = false;
        claimContact = new Claim_Contact__c(); 
        ClaimId = ApexPages.currentPage().getParameters().get('claimId');         
        claimContact.Claims__c = ClaimId;
        claim = [select id,Name,Manufacturer__c,Facility__c,Manufacturer_Email__c from MCAR_Claim_Management__c where id=:ClaimId];         
        //supplierManager = [select id,Name,Supplier_Manager__c,Email__c,Enterprise_ID__c,SupplierManagerPhone__c from  MCAR_Manufacturer__c where id=:claim.Manufacturer__c limit 1];    
                
        //System.debug('**check id :'+supplierManager.id+'***'+supplierManager.Name);
        //supplierManager.Supplier_Manager__c = 'RAJ SUP MAN';
        //supplierManager.Email__c = 'raj@SM.com';        
          
        system.debug('****control 1');
        findOldClaimContact();
        supplier =  new List<AllContacts>();
        findSupplier();
                        
        MEXBuyer = new List<AllContacts>();
        factory = new List<AllContacts>();
        if(claim.Facility__c!=null)
        {        
          findMEXBuyer();
            findFactory();
        }
  
        NSNuser = new List<AllContacts>();
        findCM();
            system.debug('***conrol :'+ NSNUser.size());
        //findNSNuser();
        
        supplierManager = new List<AllContacts>();
        findSupplierManager();
        
        if(factory.size()==0) zeroFactoryList = true;
        if(MEXBuyer.size()==0) zeroMexList = true;        
        if(NSNuser.size()==0) zeroNSNuser = true;      
        }
        catch(Exception e)
        {
            
        }
    }
        
    //--------------------------getCurrentContact-----------------------------------------------------------//
    
    public void findOldClaimContact()
    {        
        oldClaimContact = [select id,Name,Contact_Type__c,Email__c,Name__c,Phone__c from Claim_Contact__c where Claims__c = :ClaimId and Contact_Type__c in('MEX Buyer','Factory SQE','Manufacturer','Category Manager','Supplier Manager')];
        
        ClaimContactMap = new Map<String,Claim_Contact__c>();
        for(Claim_Contact__c cc : oldClaimContact)
        {
            ClaimContactMap.put(cc.Email__c,cc);            
    	}  
    }        
        //-----------------------------------Supplier Data----------------------------------------------------------///
    public void findSupplier()
    {        
        boolean isPrimary = false;        
        for(MCAR_Manufacturer_Contact__c supp : [select id,Name,Email__c,Contact_Type__c,MCAR_Telephone__c from MCAR_Manufacturer_Contact__c where Manufacturer_Name__c=:claim.Manufacturer__c])
        {                        
                                 
            if((ClaimContactMap.get(supp.Email__c)!=null) && ((ClaimContactMap.get(supp.Email__c).Contact_Type__c =='Category Manager') || (ClaimContactMap.get(supp.Email__c).Contact_Type__c =='MEX Buyer') || (ClaimContactMap.get(supp.Email__c).Contact_Type__c =='Factory SQE')))            
                continue;   
                
            if(claim.Manufacturer_Email__c==supp.Email__c) isPrimary = true;
            else isPrimary = false;			
                        
            if((ClaimContactMap.get(supp.Email__c)!=null) && (ClaimContactMap.get(supp.Email__c).Contact_Type__c =='Manufacturer'))            
                supplier.add(new AllContacts(supp.id,supp.Contact_Type__c,supp.Name,supp.Email__c,supp.MCAR_Telephone__c,true,isPrimary,supp.Contact_Type__c));            
            else
            {                                                    
                if(supp.Email__c==claim.Manufacturer_Email__c) isPrimary = false;
                supplier.add(new AllContacts(supp.id,supp.Contact_Type__c,supp.Name,supp.Email__c,supp.MCAR_Telephone__c,false,isPrimary,supp.Contact_Type__c));                             
            }                        
        }                
    }
    public List<AllContacts> getSupplier()
    {
        return supplier;
    }

    //---------------------------------------------------------------------------------------------------------//
    
    public void findSupplierManager()
    {
        //supplierManager = [select id,Supplier_Manager__c,Email__c from SupplierContacts__c where Manufacturer_Name__c =: claim.Manufacturer__c];        
        for(SupplierContacts__c SM : [select id,Supplier_Manager__c,Email__c from SupplierContacts__c where Manufacturer_Name__c =: claim.Manufacturer__c])
        {
            if(ClaimContactMap.get(SM.Email__c)!=null)
                supplierManager.add(new AllContacts(SM.Id,'Supplier Manager',SM.Supplier_Manager__c,SM.Email__c,'',true));
            else
                supplierManager.add(new AllContacts(SM.Id,'Supplier Manager',SM.Supplier_Manager__c,SM.Email__c,'',false));
        }  

    }
    public List<AllContacts> getSupplierManager()
    {
        return supplierManager;
    }
    
    //------------------------------------------NSN User-------------------------------------------------------//
    public void findCM()
    {
        set<String> ComList = new set<String>();
        set<String> CMEmailList = new set<String>();   
        List<performance_Deviation_section__c> performanceDeviation =new List<performance_Deviation_section__c>();
        
        try{
          materialdeviation = [select id,Code__r.Name from Material_Deviation__c where Code__r.Name!=null and MCAR_Claim_Management1__c =:ClaimId];     
          performanceDeviation = [select id,Associated_Part_Code__r.Name from performance_Deviation_section__c where Claim__c =:ClaimId and Associated_Part_Code__r.Name!=null];
          
          for(Material_Deviation__c md : materialdeviation)
            {                        
                system.debug('*****'+md.Code__r.Name);
                ComList.add([select COM__c from NSN_Part__c where Name = :md.Code__r.Name and COM__c!=null].COM__c);                
            }
        
          for(performance_Deviation_section__c pd : performanceDeviation)
            {
                ComList.add([select COM__c from NSN_Part__c where Name = :pd.Associated_Part_Code__r.Name and COM__c!=null].COM__c);
            }

          for(MCAR_NSN_Contacts__c mcarNSNcontact : [select Id,Role__c,First_Name__c,Last_Name__c,Email__c from MCAR_NSN_Contacts__c where COM__c IN :ComList and Role__c='Category Manager'])
            {                                
                if(CMEmailList.add(mcarNSNcontact.Email__c))
                {                    
                    Claim_Contact__c tempcontact = ClaimContactMap.get(mcarNSNcontact.Email__c);
                    if(tempcontact!=null)
                    {
                      if(tempcontact.Contact_Type__c=='Category Manager')
                      NSNuser.add(new AllContacts(mcarNSNcontact.id,mcarNSNcontact.Role__c,mcarNSNcontact.First_Name__c+' '+mcarNSNcontact.Last_Name__c,mcarNSNcontact.Email__c,'',true));                        
                    }
                    else 
                        NSNuser.add(new AllContacts(mcarNSNcontact.id,mcarNSNcontact.Role__c,mcarNSNcontact.First_Name__c+' '+mcarNSNcontact.Last_Name__c,mcarNSNcontact.Email__c,'',false));
                }                
            }    
        }
        catch(Exception e)
        {}                    
    }
        
    /*
    public void findNSNuser()
    {                
        materialdeviation = [select id,name,MCARs__c from Material_Deviation__c where MCARs__c!=null and MCAR_Claim_Management1__c =:ClaimId];                           
        Set<String> MDduplicate = new Set<String>();                                
        
        for(Material_Deviation__c md : materialdeviation)
        {                           
            if(MDduplicate.add(md.MCARs__c))
          for(MCAR_Email_List__c NSN:[select id,MCAR_First_Name__c,MCAR_Contact_Type__c,MCAR_Email__c,MCAR_Role__c from MCAR_Email_List__c where MCAR_Contact_Type__c = 'NSN' and MCAR_Role__c = 'Category Manager' and MCAR__c =: md.MCARs__c])    
            {                      
                Claim_Contact__c tempcontact = ClaimContactMap.get(NSN.MCAR_Email__c);  
                system.debug('****>'+tempcontact);
        if(tempcontact!=null)
                {                    
                    if(tempcontact.Contact_Type__c=='Category Manager')
                    NSNuser.add(new AllContacts(NSN.id,'Category Manager',NSN.MCAR_First_Name__c,NSN.MCAR_Email__c,'',true));
                }
                else
                    NSNuser.add(new AllContacts(NSN.id,'Category Manager',NSN.MCAR_First_Name__c,NSN.MCAR_Email__c,'',false));
            }
        }  
        MDduplicate.clear();
        
        //for(AllContacts al:NSNuser)
            //system.debug('***NSN User :'+al.Email+' **** '+al.Name + '  *** ' + al.isSelect);
    }        
	*/
    public List<AllContacts> getNSNuser()
    {
        return NSNuser;
    }
	
    //-------------------------------------MEX Buyer data---------------------------------------------------///
        
    public void findMEXBuyer()
    {                     
        for(MCAR_Facility_Contact__c facility : [select id,Name,MCAR_Contact_Type__c,Email__c,MCAR_Telephone__c from MCAR_Facility_Contact__c where Facility__c =: claim.Facility__c])
        {
            Claim_Contact__c tempcontact = ClaimContactMap.get(facility.Email__c);
            if(tempcontact!=null)
            {               
                if(tempcontact.Contact_Type__c=='MEX Buyer')
                MEXBuyer.add(new AllContacts(facility.id,facility.MCAR_Contact_Type__c,facility.Name,facility.Email__c,facility.MCAR_Telephone__c,true));
            }                
            else            
                MEXBuyer.add(new AllContacts(facility.id,facility.MCAR_Contact_Type__c,facility.Name,facility.Email__c,facility.MCAR_Telephone__c,false));                            
        }
    }
    public List<AllContacts> getMEXBuyer()
    {
        return MEXBuyer;
    }
    //------------------------------------Factory data------------------------------------------------------///
    public void findFactory()
    {                                
        for(MCAR_Facility_Contact__c facility : [select id,Name,MCAR_Contact_Type__c,Email__c,MCAR_Telephone__c from MCAR_Facility_Contact__c where Facility__c =: claim.Facility__c])
        {
            Claim_Contact__c tempcontact = ClaimContactMap.get(facility.Email__c);
            if(tempcontact!=null)
            {               
                if(tempcontact.Contact_Type__c=='Factory SQE')
                factory.add(new AllContacts(facility.Id,facility.MCAR_Contact_Type__c,facility.Name,facility.Email__c,facility.MCAR_Telephone__c,true));
            }                
            else            
                factory.add(new AllContacts(facility.Id,facility.MCAR_Contact_Type__c,facility.Name,facility.Email__c,facility.MCAR_Telephone__c,false));                            
        }
    }
    public List<AllContacts> getFactory()
    {
        return factory;
    }
    
    //---------------------------------------------------------------------------------------------///    
    /*
    public void ClearAll()
    {
        oldClaimContact.clear();
        ClaimContactMap.clear();
        supplier.clear();
        factory.clear();
        MEXBuyer.clear();
    }
    public void LoadAll()
    {
        findOldClaimContact();
        findFactory();
        findSupplier();
        findMEXBuyer();
    }
	*/
    //---------------------------------------------------------------------------------------------///
    /*
    public pageReference checkPrimary()
    {                
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Primary Contact Should Be Select Only One...!'));
        return null;
        
        boolean primaryflag = false;
        for(AllContacts al:supplier)
        {            
            if(primaryflag) 
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Primary Contact Should Be Select Only One...!'));
                return null;
            }                           
            else if(al.isPrimary)
            {
                primaryflag = true;
                //system.debug('***supplier :'+al.Email+' **** '+al.Name + '  *** ' + al.isSelect+' **** '+al.isPrimary); 
            }
            else
            {               
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Contact Email Required...!')); 
                return null;
            }
        }         
        return null; 
    }
    */
    public pageReference SaveChanges()
    {                                  
        List<AllContacts> ContactCopy;        
        
        if(ClaimContact.Contact_Type__c=='Manufacturer')
        {                      
            ///-----------------checking for Primary contact (need to write in separate function)---------------///
            boolean primaryflag = false;
      boolean isSelect = false;            
            for(AllContacts al:supplier)
            {                                
                if(al.isPrimary)
                {
                   if(al.isSelect)
                   {                       
            if(primaryflag)
                        {                                            
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Only one Primary Contact can be Select...!'));
                      return null;
                        }
                         else
                        {
                            claim.Manufacturer_Email__c = al.Email;
                            primaryflag = true;
                        }                            
                   }                                        
                   else
                   {                                            
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Selected Contact only Should be Primary...!'));                                      
                        return null;
                   }                        
                }
                if(al.isSelect) isSelect = true;
            }
            if(!primaryflag && isSelect) 
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Set Primary Manufacturer Contact...!'));
                return null;
            }
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'stop control here...'));
            //return null;
            ///---------------------------------------------------------------//
            ContactCopy = new List<AllContacts>();
            ContactCopy.addAll(supplier);            
            SaveList(ContactCopy);
        }
        else if((ClaimContact.Contact_Type__c=='MEX Buyer'))
        {                             
            ContactCopy = new List<AllContacts>();
            ContactCopy.addAll(MEXBuyer);                          
            SaveList(ContactCopy);
        }        
        else if((ClaimContact.Contact_Type__c=='Factory SQE'))
        {            
            ContactCopy = new List<AllContacts>();
            ContactCopy.addAll(factory);    
            SaveList(ContactCopy);
        }               
        else if((ClaimContact.Contact_Type__c=='Category Manager'))
        {            
            ContactCopy = new List<AllContacts>();
            ContactCopy.addAll(NSNuser);    
            SaveList(ContactCopy);
        }
        else if((ClaimContact.Contact_Type__c=='Supplier Manager'))
        {
            ContactCopy = new List<AllContacts>();
            ContactCopy.addAll(SupplierManager);    
            SaveList(ContactCopy);           
        }
                        
        update claim;
        pageReference pb;
        
        if(isSaveNew)
        {
                pb = new PageReference('/apex/ClaimContactDetails?claimId='+ClaimId);     
            	isSaveNew = false;
                ClaimContact = new Claim_Contact__c();
                ClaimContact.Claims__c = ClaimId;
        }
        else
        {            
            pb = new pageReference('/'+ClaimId);        
        	return pb;
        }
        
        pb = new pageReference('/'+ClaimId);        
        return null;
    }
        
    public PageReference SaveAndNewList()
    {
        isSaveNew = true;
        SaveChanges();
        return null;
    }
    
    public pageReference SaveList(List<AllContacts> ContactCopy)
    {                
        List<Claim_Contact__c> removeContact = new List<Claim_Contact__c>();   
        List<Claim_Contact__c> addContact = new List<Claim_Contact__c>();                    
        
        try{
        for(AllContacts al:ContactCopy)
        {                            
            Claim_Contact__c temp;
            temp = ClaimContactMap.get(al.Email);            
            if(temp!=null && (!al.isSelect))
            {                
                ClaimContactMap.remove(temp.Email__c);
                removeContact.add(temp);
                if(temp.Contact_Type__c=='MEX Buyer') factory.add(al);                    
                else if(temp.Contact_Type__c=='Factory SQE') MEXBuyer.add(al);                                    
            }
            else if(temp==null)
            {
                if(al.isSelect)
                {                    
                    temp = new Claim_Contact__c();
                    temp.Claims__c = ClaimId;
                    temp.Contact_Type__c = claimContact.Contact_Type__c;
                    temp.Name__c = al.Name;
                    temp.Email__c = al.Email;
                    temp.Phone__c = al.Phone;   
                     
                    ClaimContactMap.put(temp.Email__c,temp);
          addContact.add(temp);      
                                                        
                    if(temp.Contact_Type__c=='MEX Buyer') RemoveIndex('MEX Buyer',al.Email);                         
                    else if(temp.Contact_Type__c=='Factory SQE') RemoveIndex('Factory SQE',al.Email);
                }
            }              
        }               
        system.debug('***before insert or delete');        
        Database.DeleteResult[] rmResult = Database.delete(removeContact,false);    
        Database.SaveResult[] svResult = Database.insert(addContact,false);         
        system.debug('***after insert or delete');            
        }
        catch(Exception e)
        {
            system.debug('****Duplicate Email Id found in the List......');
        }
    return null;        
    }
    
    public void RemoveIndex(String type,String email)
    {
        if(type == 'MEX Buyer')
        {
      for(integer i=0; i<factory.size(); i++)
            {
                if(factory.get(i).Email==email)
                {
                    factory.remove(i);
                }
            }
        } 
        else if(type == 'Factory SQE')
        {
      for(integer i=0; i<MEXBuyer.size(); i++)
            {
                if(MEXBuyer.get(i).Email==email)
                {
                    MEXBuyer.remove(i);
                }
            }            
        }
    }
        
    public PageReference SaveAndNew()
    {
       isSaveNew = true; 
        SaveContact();
        return null;
    }

    public pageReference SaveContact()
    {                                                               
        if(ClaimContact.Name__c==null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Contact Name Required...!'));
            return null;
        }
        else if(ClaimContact.Email__c==null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Contact Email Required...!'));
            return null;
        }
        else 
        {
            insert ClaimContact;
            pageReference pb;      
                        
            if(!isSaveNew)
            {                
                pb = new pageReference('/'+ClaimId);                
            }              
            else
            {
                pb = new PageReference('/apex/ClaimContactDetails?claimId='+ClaimId);     
                ClaimContact = new Claim_Contact__c();
                ClaimContact.Claims__c = ClaimId;
            }
                         
            pb = new pageReference('/'+ClaimId);
            return pb;            
        }                
    }
    
    public class AllContacts
    {
        public id RecId { set; get; }        
        public String Email { set; get; }
        public String Type { set; get; }
        public string Name { set; get;}        
        public String phone { set; get;}
        public boolean isSelect {set; get;}
        public boolean isPrimary { set; get; }
        public string ContactType {get;set;}
      public AllContacts(id RecId,String Type,string Name,String Email,String Phone,boolean isSelect)
      { 
           this.type = type;
            this.RecId = RecId;
            this.name = name;
            this.email = email;
            this.phone  = phone;
            this.isSelect = isSelect;
           
      }                           
        public AllContacts(id RecId,String Type,string Name,String Email,String Phone,boolean isSelect,boolean isPrimary,string ContactType)
      	{        	   
            this.type = type;         
            this.RecId = RecId;
            this.name = name;
            this.email = email;
            this.phone  = phone;
            this.isSelect = isSelect;
            this.isPrimary = isPrimary;             
            this.ContactType = ContactType;
      } 
  }    
}