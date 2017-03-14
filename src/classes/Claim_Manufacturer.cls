public Class Claim_Manufacturer{
    public Claim_Manufacturer(){
    }
    public Id Claim_Id{ get; set;}
    
    public string getManufacturer(){
        string man = '';
        list<MCAR_Claim__c> MC = new list<MCAR_Claim__c>(); 
        list<Id> MCId = new list<Id>();  
        MC = [SELECT MCARs__c FROM MCAR_Claim__c WHERE MCAR_Claim_Management__c =: Claim_Id];
        if(!MC.isEmpty()){
            
            for(MCAR_Claim__c mcarm : MC)
                MCId.add(mcarm.MCARs__c);
            list<MCAR__c> MCAR = [SELECT MCAR_Manufacturer__c FROM MCAR__c WHERE Id IN: MCId];
            
            MCId = new list<Id>();
            for(MCAR__c mc1 : MCAR)
                MCId.add(mc1.MCAR_Manufacturer__c);
            list<MCAR_Manufacturer__c> Manufac = [SELECT Name FROM MCAR_Manufacturer__c WHERE Id IN: MCId];
            for(integer i = 0; i < Manufac.size()-1; i++)
                man = man + Manufac[i].Name + ', ';
            man = man + Manufac[Manufac.size()-1].Name;
        }
                
        list<Non_Mcar__c> NM = [SELECT Manufacturer__c FROM Non_Mcar__c WHERE Claim__c =: Claim_Id];
        if(!NM.isEmpty()){
            man = man + ', ';
            MCId = new list<Id>();
            for(Non_Mcar__c nonm : NM)
                MCId.add(nonm.Manufacturer__c);
            list<MCAR_Manufacturer__c> Manufac = [SELECT Name FROM MCAR_Manufacturer__c WHERE Id IN: MCId];
            for(integer i = 0; i < Manufac.size()-1; i++)
                man = man + Manufac[i].Name + ', ';
            man = man + Manufac[Manufac.size()-1].Name;
        }
        return man;
    }
    
    static testmethod void test1(){
    
        MCAR_Manufacturer__c MM = new MCAR_Manufacturer__c();
        MM.Name = 'Samsung';
        insert MM;
        MCAR__c objmcar = new MCAR__c();
        objmcar.MCAR_Status__c ='No Trouble Found';
        objmcar.MCAR_Manufacturer__c = MM.Id;
        insert objmcar;
        MCAR_Claim_Management__c MCM = new MCAR_Claim_Management__c();
        MCM.Claim_Status__c = 'Draft'; 
        MCM.Part_Category__c = 'Components';
        MCM.Manufacturer__c = MM.Id;
        insert MCM;
        //pagereference ref = new pageReference(MCAR_Claim_Cancel);
        
        //NextStepDataCollection(MCM.ID);
        MCM.Claim_Status__c = 'Data Collection'; 
        MCM.Root_Cause_Summary__c = 'Testing';
        MCM.Corrective_Actions_Summary__c = 'Test';
        MCM.Manufacturer_Accepts_Full_Responsibility__c = True;
        MCM.Total_Cost_To_Be_Claimed__c = 123;
        MCM.Amount__c = 123;
        update MCM;
        
        
        NSN_Part__c NP = new NSN_Part__c();
        NP.Name = 'test';
        NP.Description__c = 'test';
        insert NP;
        MCAR_MEPS__c MMP = new MCAR_MEPS__c();
        MMP.Name = 'Test';
        MMP.MCAR_NSN_Part__c = NP.Id;
        MMP.MCAR_Mfg_Part_Number__c = 'test';
        MMP.Manufacturer_Name__c = MM.Id;
        insert MMP;
        Non_Mcar__c NM = new Non_Mcar__c();
        NM.Code__c = MMP.Id;
        NM.Quantity__c = 123;
        NM.Claim__c = MCM.Id;
        insert NM;
        
        MCAR_Claim__c MCL = new MCAR_Claim__c();
        MCL.MCAR_Claim_Management__c = MCM.Id;
        MCL.MCARs__c = objmcar.Id;
        insert MCL;
        
        //NextStepDataCollection(MCM.ID);
        Claim_Contact__c CC = new Claim_Contact__c();
        CC.Contact_Type__c = 'Legal';
        CC.Claims__c = MCM.ID;
        CC.Email__c = 'abc@xyz.com';
        insert CC;
        //NextStepDataCollection(MCM.ID);
        CC = new Claim_Contact__c();
        CC.Contact_Type__c = 'Category Manager';
        CC.Claims__c = MCM.ID;
        CC.Email__c = 'abc@xyz.com';
        insert CC;
        //NextStepDataCollection(MCM.ID);
        CC = new Claim_Contact__c();
        CC.Contact_Type__c = 'SQS';
        CC.Claims__c = MCM.ID;
        CC.Email__c = 'abc@xyz.com';
        insert CC;
        CC = new Claim_Contact__c();
        CC.Contact_Type__c = 'Technical';
        CC.Claims__c = MCM.ID;
        CC.Email__c = 'abc@xyz.com';
        insert CC;
        //NextStepDataCollection(MCM.ID);
        CC = new Claim_Contact__c();
        CC.Contact_Type__c = 'Nonconformance Cost';
        CC.Claims__c = MCM.ID;
        CC.Email__c = 'abc@xyz.com';
        insert CC;
        //NextStepDataCollection(MCM.ID);
        Claim_Manufacturer cnc = new Claim_Manufacturer();
        cnc.Claim_Id = MCM.ID;
        try{cnc.getManufacturer();}catch(exception e){}
        
    }
}