Public class MCARChangeRequestExtention
{
    public MCARChangeRequestExtention(ApexPages.StandardController controller) 
    {
    }
        public String Name{ get; set;}
        public Boolean Name1{ get; set;}
        public Boolean Name2{ get; set;}
        public Boolean trackID{ get; set;}
        public Boolean trackID1{ get; set;}
        Public String get_id{get; set;}
        Public String MfgPartNumber{get; set;}
        Public String Description{get; set;}
        Public Boolean Save1{get; set;}
        
    public pagereference temp()
    {
        if(ApexPages.currentPage().getParameters().get('id')!=null)
        {   
            trackID1 = true;
            trackID = false;
            Save();
            Name1 = true;
            Name2 = false;
            Save1 = true;        
        }
        else
        {
            Name1 = true;
            Save1 = true;
            trackID = false;
            trackID1 = false;            
        }
        return null;
    }
    
    public Pagereference Save()
    {
        ID  temp = ApexPages.currentPage().getParameters().get('id');
      
               
        if(temp==null)
        {
            MCAR_Change_Request__c m = new MCAR_Change_Request__c();
            m.Name_Part__c = Name;
            m.Mfg_Part_Number__c = MfgPartNumber;
            m.Description_Part__c = Description;
            m.RecordTypeId = [SELECT Id FROM RecordType WHERE Name =: 'MCAR NSN Part'].id;
            try
            {
                insert m; 
            } 
            catch 
            (
            System.DmlException e
            ) 
            {ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Kindly fill the correct Email. (E.g.Firstname.Lastname@nokia.com)');
            ApexPages.addMessage(myMsg);
            System.debug('myMsg&&&&&&&&&&&&&&&&&&&&'+myMsg);
            return null;}
            
            get_id = [SELECT Name FROM MCAR_Change_Request__c ORDER BY CreatedDate DESC LIMIT 1].Name;
            Name1 = false;
            Name2 = true;
            trackID = true;
            Save1 = false;
            return null;
        }
    
        else
            {
            list<MCAR_Change_Request__c> m = new list<MCAR_Change_Request__c>();
            if(temp!=null )
            {
                m = [SELECT Name, Name_Part__c, Mfg_Part_Number__c, Description_Part__c  FROM MCAR_Change_Request__c where id =: temp];
                           
                Name = m[0].Name_Part__c;
                MfgPartNumber = m[0].Mfg_Part_Number__c;
                Description = m[0].Description_Part__c;
                get_id = m[0].Name;
                return null;
            }
            return null;
            }
        }  
        

    public List<SelectOption> getCRTypes() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Supplier','Supplier'));
        options.add(new SelectOption('NSN Part','NSN Part'));
        options.add(new SelectOption('Facility','Facility'));
        return options;
    }

          
    public pagereference cancel()
    {
        pagereference c = new pagereference('');
        return c;
    }
    //Test Method
    static testmethod void test_MCARChangeRequestExtention()
    {
        Boolean Name1 =true;
        Boolean Save1 =true;
        Boolean trackID =false;
        Boolean trackID1 =false;
        MCAR_Facility__c testFacility = new MCAR_Facility__c(Name ='Chennai', MCAR_Facility_Company__c='NSN');    
        insert testFacility; 
        MCAR_Change_Request__c CR1=new MCAR_Change_Request__c(Facility_Name__c=testFacility.id,Facility_Contact_Name__c='Test1',Facility_Contact_Email__c='Test@nokia.com');
        insert CR1;
        PageReference pageRef = Page.MCAR_Change_Request_Sup;    
        Test.setCurrentPage(pageRef);    
        ApexPages.currentPage().getParameters().put('id',CR1.id);
        MCAR_Change_Request__c CR =new MCAR_Change_Request__c();
        ApexPages.StandardController controller = new ApexPages.StandardController(CR1);
        MCARChangeRequestExtention MCR = new MCARChangeRequestExtention(controller);
        MCR.Temp();
        MCR.Save();
        MCR.getCRTypes();
        MCR.cancel();
    }
}