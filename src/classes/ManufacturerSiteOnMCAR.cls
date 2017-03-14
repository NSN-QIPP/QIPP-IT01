public class ManufacturerSiteOnMCAR {
    
    public MCAR__c vmcar {get;set;}
    public MCAR_Manufacturer__c vmanfac {get;set;}
    public list<MCAR_Manufacturer_Site__c> vlstms {get;set;}
    public list<MCAR_Manufacturer_Site__c> Selectedms {get;set;}
    public list<MCAR_Manufacturer_Site__c> SelectedSites {get;set;}
    public list<wrappersites> vlstwst {get;set;}
    public list<wrappersites> vlstSelwst {get;set;}
    public list<MCAR__c> vlstmacr {get;set;}
    public ManufacturerSiteOnMCAR(ApexPages.StandardController stdcontroller)
    {
       string str = apexpages.currentPage().getParameters().get('id');
        vmcar = [select id,MCAR_Manufacturer__c ,Manufacturer_Site__c from MCAR__c where id =:str];
        vlstmacr  = new list<MCAR__c>();
         Selectedms = new list<MCAR_Manufacturer_Site__c>();
        SelectedSites = new list<MCAR_Manufacturer_Site__c>();
        system.debug('Current Record id----->' + vmcar);
        if(vlstwst == null)
        {
            vlstwst = new list<wrappersites>();
            vlstSelwst = new list<wrappersites>();
             
            vlstms = [select id,Name,Manufacturer_Name__c,MCAR_Manufacturer_Site_Address__c from MCAR_Manufacturer_Site__c where Manufacturer_Name__c =:vmcar.MCAR_Manufacturer__c];
            for(MCAR_Manufacturer_Site__c ms : vlstms)
            {
                if(ms.name!= vmcar.Manufacturer_Site__c)
                {                    
                    wrappersites us = new wrappersites(ms);             
                    vlstwst.add(us);
                }                
                else
                {
                    wrappersites us = new wrappersites(ms);
                    us.vbool = true;
                    vlstwst.add(us);
                }                 
           }            
        }
        
        for(wrappersites ws : vlstwst)
            {
             if(ws.vbool == true)
                {
                    Selectedms.add(ws.vms);
                    vlstSelwst.add(ws);
                }
            }
          SelectedSites = Selectedms;
		Selectedms.clear();
        system.debug('Current Record id----->' + vmcar);
        
        system.debug('SelectedSites--->'+ SelectedSites);
    }
    public pagereference DisplaySiteAccounts()
    {
        pagereference pr = new pagereference('/' + vmcar.id );
         pagereference pr2 = new pagereference('/apex/ManufactureSiteOnMCAR');
       
        for(wrappersites ws : vlstwst)
            {
             if(ws.vbool == true)
                {
                    system.debug('\n***'+ws.vbool+'***'+ws.vms);
                    Selectedms.add(ws.vms);
                    vlstSelwst.add(ws);
                }
            }                        
        
          SelectedSites = Selectedms;    
        SelectedSites.size();
        system.debug('Current Record id----->' + vmcar);
        
        system.debug('SelectedSites--->'+ SelectedSites);
    
        if(Selectedms.size() > 1)
        {
            
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Select only one Site'));
            SelectedSites.clear();
            return null;
            
        }
        else
        {
            String id=System.currentpagereference().getparameters().get('id');
            
           if(SelectedSites.size() > 0)
           {
           for(integer i=0;i<=SelectedSites.size();i++)
           {
             vmcar.Manufacturer_Site__c = SelectedSites[0].name;
             
           }
           // pr.setRedirect(true);
          }
             update vmcar;
             return pr;
        }                
    }
       
    public class wrappersites
    {
        public boolean vbool {get;set;}
        public MCAR_Manufacturer_Site__c vms {get;set;}
        public wrappersites(MCAR_Manufacturer_Site__c lstms)
        {
           vbool = false;
            vms = lstms;
        }
    }
}