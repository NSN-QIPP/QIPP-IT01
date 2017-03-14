public class Claim_Contact{
    public Claim_Contact(){
    }
    
    public Id Claim_Id{ get; set; }
    
    public string getNCC(){
        list<Claim_Contact__c> ncc = [SELECT Name__c, Contact_Type__c FROM Claim_Contact__c WHERE Claims__c =: Claim_Id];
        string con = '';
        if(!ncc.isEmpty()){
            for(integer i=0; i<ncc.size(); i++)
                if(ncc[i].Contact_Type__c == 'Nonconformance Cost')
                    con = con + ncc[i].Name__c + ', ';
            /*if(ncc[ncc.size()-1].Contact_Type__c == 'Nonconformance Cost')
                con = con + ncc[ncc.size()-1];*/
        }
        return con;
    }
    
    public string getTech(){
        list<Claim_Contact__c> ncc = [SELECT Name__c, Contact_Type__c FROM Claim_Contact__c WHERE Claims__c =: Claim_Id];
        string con = '';
        if(!ncc.isEmpty()){
            for(integer i=0; i<ncc.size(); i++)
                if(ncc[i].Contact_Type__c == 'Technical')
                    con = con + ncc[i].Name__c + ', ';
            //con = con + ncc[ncc.size()-1];
        }
        return con;
    }
    
    public string getCommodity(){
        list<Claim_Contact__c> ncc = [SELECT Name__c, Contact_Type__c FROM Claim_Contact__c WHERE Claims__c =: Claim_Id];
        string con = '';
        if(!ncc.isEmpty()){
            for(integer i=0; i<ncc.size(); i++)
                if(ncc[i].Contact_Type__c == 'Category Manager')
                    con = con + ncc[i].Name__c + ', ';
            //con = con + ncc[ncc.size()-1];
        }
        return con;
    }
    
    public string getLegal(){
        list<Claim_Contact__c> ncc = [SELECT Name__c, Contact_Type__c FROM Claim_Contact__c WHERE Claims__c =: Claim_Id];
        string con = '';
        if(!ncc.isEmpty()){
            for(integer i=0; i<ncc.size(); i++)
                if(ncc[i].Contact_Type__c == 'Legal')
                    con = con + ncc[i].Name__c + ', ';
            //con = con + ncc[ncc.size()-1];
        }
        return con;
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
        
        /*MCAR_Claim__c MCL = new MCAR_Claim__c();
        MCL.MCAR_Claim_Management__c = MCM.Id;
        MCL.MCARs__c = objmcar.Id;
        insert MCL;*/
        
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
        Claim_Contact ccc = new Claim_Contact();
        ccc.Claim_Id = MCM.ID;
        ccc.getNCC();
        ccc.getTech();
        ccc.getLegal();
        
    }
}