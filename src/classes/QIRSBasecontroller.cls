public class QIRSBasecontroller
{

   // public static string BaseURL = URL.getSalesforceBaseUrl().toExternalForm();
    public static string BaseVarAccpetedByChampion = 'Accepted by Champion';    
    public static string BaseVarPendingforChampion = 'Pending for Champion';    
        
    public static string BaseVarImplementedbyChampion = 'Implemented by champion';    
    public static string BaseVarQAAlertType = 'Quality Alert';    
    public static string BaseVarSSAlertType = 'Delivery Stop';    

    //public static string BaseVarStopBuildIL = 'Stop build';    
    //Below line added by kishore on 22-Mar-2012
    public static string BaseVarStopBuildIL = 'Stop Production';    

    public static string BaseVarWatchListPublicGroup = 'QIRS_WatchList_Group';    
                

    public static string BaseVarQIRSAll = 'All';      
    public static string BaseVarQIRSOpen = 'Open';    
    public static string BaseVarQIRSClosed = 'Closed';    
    //public static string BaseVarQIRSLifted = 'Lifted';
    public static string BaseVarQIRSLifted = 'Released';    
        
    public static string BaseVarQIRSSubmitForApproval = 'Submitted to Master Approval';   
    public static string BaseVarQIRSResolutionIdentified = 'Resolution Identified / Awaiting for approval';   
          
    public static string BaseVarQIRSAPOpen = 'Open';    
    public static string BaseVarQIRSAPClosed = 'Closed';    
    public static string BaseVarQIRSAPRejected = 'Rejected';  
                
    public static string BaseVarContainmentActionType = 'Containment/Temporal Solution';    
    public static string BaseVarRootCauseActionType = 'Root Cause/Escape Point Analysis';    
    public static string BaseVarCorrectiveActionType = 'Corrective';    
    public static string BaseVarPreventiveActionType = 'Preventive';    
                
    //public static string BaseVarQIRSIssueLevelemerging = 'Emerging'; 
    //Below line added by kishore on 22-Mar-2012   
    public static string BaseVarQIRSIssueLevelemerging = 'Critical';    

                
    public static List<SelectOption> getBusinessList(boolean IsAll) 
    {
        List<SelectOption> options = new List<SelectOption>();
        if(IsAll)
        options.add(new SelectOption('All','All'));
        else
        options.add(new SelectOption('--None--','--None--'));
        //Below two new values added by kishore on 16-Mar-2011
        options.add(new SelectOption('Advanced Mobile Network Solutions','Advanced Mobile Network Solutions'));
        options.add(new SelectOption('Mobile Networks Global Services','Mobile Networks Global Services'));
        options.add(new SelectOption('Mobile Networks Products','Mobile Networks Products'));
        options.add(new SelectOption('zzCustomer Experience Management','zzCustomer Experience Management'));
        options.add(new SelectOption('zzGlobal Services','zzGlobal Services'));
        options.add(new SelectOption('zzMobile Broadband','zzMobile Broadband'));
        
        //added by mani
         options.add(new SelectOption('Fixed Networks Broadband Access','Fixed Networks Broadband Access'));
        options.add(new SelectOption('Fixed Networks Digital Home   ','Fixed Networks Digital Home  '));
        options.add(new SelectOption('Fixed Networks Cable','Fixed Networks Cable'));
        options.add(new SelectOption('ION Optics','ION Optics'));
        options.add(new SelectOption('A&A Customer Experience Management','A&A Customer Experience Management'));
        options.add(new SelectOption('  A&A Cloud','    A&A Cloud'));
        options.add(new SelectOption('A&A IoT/Security','A&A IoT/Security'));
        options.add(new SelectOption('A&A Policy and Charging','A&A Policy and Charging'));
        options.add(new SelectOption('A&A Service Assurance','A&A Service Assurance'));
        //options.add(new SelectOption('Networks Systems','Networks Systems'));
        //options.add(new SelectOption('Business Solutions','Business Solutions'));                
        
        
        return options;
    }

    //--------------------------------------------------------------Business Group List-----------------------------------------------------------------------------------------
    /*
    public static List<SelectOption> getBusinessGrpList()
    {     
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));
        options.add(new SelectOption('BBA','BBA'));
        options.add(new SelectOption('CDMA/LTE','CDMA/LTE'));
        options.add(new SelectOption('CET ( Carrier Ethernet Transport)','CET ( Carrier Ethernet Transport)'));
        //options.add(new SelectOption('Common Platforms','Common Platforms'));                        
        options.add(new SelectOption('Core Platforms','Core Platforms'));            
        options.add(new SelectOption('DNW (Dedicated Networks)','DNW (Dedicated Networks)'));
        options.add(new SelectOption('Global LTE','Global LTE'));        
        options.add(new SelectOption('GSM','GSM'));
        options.add(new SelectOption('MWT','MWT'));
        options.add(new SelectOption('Optical Networks','Optical Networks')); 
        options.add(new SelectOption('Packet Core','Packet Core'));
        options.add(new SelectOption('Packet Networks','Packet Networks'));            
        options.add(new SelectOption('Perfect Voice','Perfect Voice'));            
        options.add(new SelectOption('Radio Platforms','Radio Platforms')); 
       // options.add(new SelectOption('Transport Networks','Transport Networks'));                       
        options.add(new SelectOption('WCDMA','WCDMA'));
        options.add(new SelectOption('VIPT','VIPT'));
        return options;
    }*/
    public static List<SelectOption> getBusinessGrpList()
{             
    List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));
        options.add(new SelectOption('zzCDMA/LTE','zzCDMA/LTE'));
        options.add(new SelectOption('zzCET','zzCET'));
        options.add(new SelectOption('zzCore Platforms','zzCore Platforms'));
        options.add(new SelectOption('zzDNW','zzDNW'));
        options.add(new SelectOption('zzGlobal LTE','zzGlobal LTE'));
        options.add(new SelectOption('zzGSM','zzGSM'));
        options.add(new SelectOption('zzMWT','zzMWT'));
        options.add(new SelectOption('zzOptical Networks','zzOptical Networks'));
        options.add(new SelectOption('zzPacket Core','zzPacket Core'));
        options.add(new SelectOption('zzPacket Networks','zzPacket Networks'));
        options.add(new SelectOption('zzPerfect Voice','zzPerfect Voice'));
        options.add(new SelectOption('zzRadio Platforms','zzRadio Platforms'));
        options.add(new SelectOption('zzSmall Cell','zzSmall Cell'));
        options.add(new SelectOption('zzVIPT','zzVIPT'));
        options.add(new SelectOption('zzWCDMA','zzWCDMA'));
        options.add(new SelectOption('Cloud IMS','Cloud IMS'));
        options.add(new SelectOption('Cloud SDM','Cloud SDM'));
        options.add(new SelectOption('3G Core','3G Core'));
    options.add(new SelectOption('LTE-A','LTE-A')); 
    options.add(new SelectOption('HetRAN','HetRAN'));
    options.add(new SelectOption('RF and Advanced Antennas','RF and Advanced Antennas'));
    options.add(new SelectOption('5G','5G'));
    options.add(new SelectOption('Baseband Platform','Baseband Platform'));
    options.add(new SelectOption('IoT','IoT'));
    options.add(new SelectOption('Small Cell and WiFi Solutions','Small Cell and WiFi Solutions'));
    options.add(new SelectOption('X-Haul','X-Haul'));
    
       //added by mani
    options.add(new SelectOption('FN - BB Fiber','FN - BB Fiber'));
    options.add(new SelectOption('FN - BB Copper','FN - BB Copper'));
    options.add(new SelectOption('FN - BB 7342','FN - BB 7342'));
    options.add(new SelectOption('FN - FN - BB Voice','FN - FN - BB Voice'));
    options.add(new SelectOption('FN - Digital Home Americas','FN - Digital Home Americas'));
 options.add(new SelectOption('FN - Digital Home EMEA','FN - Digital Home EMEA'));
    options.add(new SelectOption('FN - Digital Home China/APAC','FN - Digital Home China/APAC'));
     options.add(new SelectOption('FN - Cable Americas','FN - Cable Americas'));
    options.add(new SelectOption('FN - Cable EMEA','FN - Cable EMEA'));
     options.add(new SelectOption('ION - 1625LX','ION - 1625LX'));
    options.add(new SelectOption('ION -  1626LM','ION -  1626LM'));
     options.add(new SelectOption('ION - 1646M/C','ION - 1646M/C'));
    options.add(new SelectOption('ION - 1660SM','ION - 1660SM'));
     options.add(new SelectOption('ION - 1662SMC','ION - 1662SMC'));
    options.add(new SelectOption('ION - 1665DMX','ION - 1665DMX'));
    options.add(new SelectOption('ION - 1675LU','ION - 1675LU'));
 options.add(new SelectOption('ION - 1678MCC','ION - 1678MCC'));
     options.add(new SelectOption('ION - 1830PSS-4','ION - 1830PSS-4'));
     options.add(new SelectOption('ION - 1830PSS-32/16','ION - 1830PSS-32/16'));
    options.add(new SelectOption('ION - 1830PSS-64/36','ION - 1830PSS-64/36'));
 options.add(new SelectOption('ION - 1830PSS-8/16II','ION - 1830PSS-8/16II'));
     options.add(new SelectOption('ION - 1830PSS-8x','ION - 1830PSS-8x'));
     options.add(new SelectOption('ION - 1830PSS-24x','ION - 1830PSS-24x'));
     options.add(new SelectOption('ION - 1830PSS-LX','ION - 1830PSS-LX'));
 options.add(new SelectOption('ION - 1830PSS-PSD','ION - 1830PSS-PSD'));
     options.add(new SelectOption('ION - 1830PSS-VWM','ION - 1830PSS-VWM'));
     options.add(new SelectOption('ION - 1850TSS - 160/320/320H','ION - 1850TSS - 160/320/320H'));
     options.add(new SelectOption('ION - 1850TSS-5C','ION - 1850TSS-5C'));
 options.add(new SelectOption('ION - 1850TSS-5R','ION - 1850TSS-5R'));
     options.add(new SelectOption('A&A - Motive 101 CXS','A&A - Motive 101 CXS'));
     options.add(new SelectOption('A&A - Motive Connected Device Platform','A&A - Motive Connected Device Platform'));
     options.add(new SelectOption('A&A - Traffica','A&A - Traffica'));
 options.add(new SelectOption('A&A - Wireless Network Guardian','A&A - Wireless Network Guardian'));
     options.add(new SelectOption('A&A - CloudBand','A&A - CloudBand'));
     options.add(new SelectOption('A&A - IoT Fleet Management','A&A - IoT Fleet Management'));
   options.add(new SelectOption('A&A - IoT Smart Cities','A&A - IoT Smart Cities'));
 options.add(new SelectOption('A&A - IoT Utilities','A&A - IoT Utilities'));
     options.add(new SelectOption('A&A - NetGuard Endpoint Security','A&A - NetGuard Endpoint Security'));
     options.add(new SelectOption('A&A - NetGuard Identity and Access Manager','A&A - NetGuard Identity and Access Manager'));
     options.add(new SelectOption('A&A - NetGuard Virtual Firewall','A&A - NetGuard Virtual Firewall'));
     options.add(new SelectOption('A&A - AAA','A&A - AAA'));
     options.add(new SelectOption('A&A - Billing Mediation','A&A - Billing Mediation'));
     options.add(new SelectOption('A&A - Billing Mediation','A&A - Billing Mediation'));
 options.add(new SelectOption('A&A - Diameter Signaling Control','A&A - Diameter Signaling Control'));
     options.add(new SelectOption('A&A - Monetization','A&A - Monetization'));
     options.add(new SelectOption('A&A - Eden-NET','A&A - Eden-NET'));
     options.add(new SelectOption('A&A - Evolved SoC','A&A - Evolved SoC'));
     options.add(new SelectOption('A&A - Identity and Access Manager','A&A - Identity and Access Manager'));
 options.add(new SelectOption('A&A - NetAct','A&A - NetAct'));
     options.add(new SelectOption('A&A - Service Assurance Management','A&A - Service Assurance Management'));
     
    //veera
      options.add(new SelectOption('MN - 3G Core','MN - 3G Core'));
      options.add(new SelectOption('MN - 5G','MN - 5G'));
      options.add(new SelectOption('MN - Baseband Platform','MN - Baseband Platform'));
      options.add(new SelectOption('MN - Cloud IMS','MN - Cloud IMS'));
      options.add(new SelectOption('MN - Cloud SDM','MN - Cloud SDM'));
      options.add(new SelectOption('MN - HetRAN','MN - HetRAN'));
      options.add(new SelectOption('MN - IoT','MN - IoT'));
      options.add(new SelectOption('MN - LTE-A','MN - LTE-A'));
      options.add(new SelectOption('MN - LTE-N','MN - LTE-N'));
      options.add(new SelectOption('MN - RF and Advanced Antennas','MN - RF and Advanced Antennas'));
      options.add(new SelectOption('MN - Small Cell and WiFi Solutions','MN - Small Cell and WiFi Solutions'));
      options.add(new SelectOption('MN - X-Haul','MN - X-Haul'));
    
    return options;
}
    //-------------------------------------------------------------------------------------------------------------------------------------------------------
     public static List<SelectOption> getAPStatus()
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Pending','Pending'));
        options.add(new SelectOption('Closed','Closed'));
        return options;
    }

    
     public static List<SelectOption> getActionPlanStatus()
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));
        //options.add(new SelectOption('No Action','No Action'));
        //options.add(new SelectOption('Open','Open'));
        options.add(new SelectOption('Pending for Champion','Pending for Champion'));
        options.add(new SelectOption('Implemented by Champion','Implemented by Champion'));
        //options.add(new SelectOption('Approved','Approved'));
        options.add(new SelectOption('Closed','Closed'));
        options.add(new SelectOption('Rejected','Rejected'));
        return options;
    }
         
    public static List<SelectOption> getSitesList(boolean IsAll) 
    {
        List<SelectOption> options = new List<SelectOption>();
        if(IsAll)
        options.add(new SelectOption('All','All'));
        else
        options.add(new SelectOption('Aichi Japan (Flextronic)','Aichi Japan (Flextronic)'));
        options.add(new SelectOption('Alsdorf','Alsdorf'));
        options.add(new SelectOption('APW India','APW India'));
        options.add(new SelectOption('Arden Hills (Celestica)','Arden Hills (Celestica)'));
        options.add(new SelectOption('Arlington Heights (IL75)','Arlington Heights (IL75)'));
        options.add(new SelectOption('Bangkok (Benchmark)','Bangkok (Benchmark)'));
        options.add(new SelectOption('Berlin, Germany','Berlin, Germany'));
        options.add(new SelectOption('Berlin CP','Berlin CP'));
        options.add(new SelectOption('Beijing, China','Beijing, China'));
        options.add(new SelectOption('Bruchsal, Germany','Bruchsal, Germany'));
        options.add(new SelectOption('Celestica Czechia','Celestica Czechia'));
        options.add(new SelectOption('Ceragon Isreal','Ceragon Isreal'));
        options.add(new SelectOption('Chennai, India','Chennai, India'));
        options.add(new SelectOption('Chennai Hub','Chennai Hub'));
        options.add(new SelectOption('Chennai (Flextronics)','Chennai (Flextronics)'));
        options.add(new SelectOption('Chihuahua (Foxconn)','Chihuahua (Foxconn)'));
        options.add(new SelectOption('Compal','Compal'));
        options.add(new SelectOption('Copenhagen (Denmark)','Copenhagen (Denmark)'));
        options.add(new SelectOption('CTS - Matamoras','CTS - Matamoras'));
        options.add(new SelectOption('CTS - TJ','CTS - TJ'));
        options.add(new SelectOption('Czech (Foxconn)','Czech (Foxconn)'));
        options.add(new SelectOption('Dongguan (Accton)','Dongguan (Accton)'));
        options.add(new SelectOption('Dongguan (Aztech)','Dongguan (Aztech)'));
        options.add(new SelectOption('Doumen (Flextronics)','Doumen (Flextronics)'));
        options.add(new SelectOption('Drop Ship Supplier','Drop Ship Supplier'));
        options.add(new SelectOption('Dubai Hub','Dubai Hub'));
        options.add(new SelectOption('Dusseldorf, Germany','Dusseldorf, Germany'));
        options.add(new SelectOption('Elcoteq Bangalore','Elcoteq Bangalore'));
        options.add(new SelectOption('Elgin (After Market) - Illinois','Elgin (After Market) - Illinois'));
        options.add(new SelectOption('Elgin (Depot) - Illinois','Elgin (Depot) - Illinois'));
        options.add(new SelectOption('Espoo, Finland','Espoo, Finland'));
        options.add(new SelectOption('Flash China','Flash China'));
        options.add(new SelectOption('Flextronics Bangalore','Flextronics Bangalore'));
        options.add(new SelectOption('Flextronics Finland','Flextronics Finland'));
        options.add(new SelectOption('Flextronics Israel','Flextronics Israel'));
        options.add(new SelectOption('Flextronics Poland','Flextronics Poland'));
        options.add(new SelectOption('Foxconn','Foxconn'));
        options.add(new SelectOption('Foxconn Shanghai','Foxconn Shanghai'));
        options.add(new SelectOption('Fujitsu','Fujitsu'));
        options.add(new SelectOption('Global Repair Ops','Global Repair Ops'));
        options.add(new SelectOption('Grapevine, Tx Hub','Grapevine, Tx Hub'));
        options.add(new SelectOption('Guadalajara (Flextronics)','Guadalajara (Flextronics)'));
        options.add(new SelectOption('Guadalajara (Solectron)','Guadalajara (Solectron)'));
        options.add(new SelectOption('Hangxing Beijing','Hangxing Beijing'));
        options.add(new SelectOption('Hangzhou (Foxconn)','Hangzhou (Foxconn)'));
        options.add(new SelectOption('Hangzhou (ZCH51)','Hangzhou (ZCH51)'));
        options.add(new SelectOption('Hangzhou JV','Hangzhou JV'));
//        options.add(new SelectOption('HPL(Beijing)','HPL(Beijing)'));
        options.add(new SelectOption('Hungary (Flextronics)','Hungary (Flextronics)'));
        options.add(new SelectOption('IDC','IDC'));
        //line 165 added by srinivas vadla on 09-oct-2012
        options.add(new SelectOption('IDS Berlin','IDS Berlin'));
        options.add(new SelectOption('Jabil Cassina','Jabil Cassina'));
        options.add(new SelectOption('Jabil Italy','Jabil Italy'));
        options.add(new SelectOption('Jabil Marcianise','Jabil Marcianise'));
        options.add(new SelectOption('Jabil Wuxi','Jabil Wuxi'));
        options.add(new SelectOption('Jaguariuna (Foxconn)','Jaguariuna (Foxconn)'));
        options.add(new SelectOption('Jaguariuna (JHT)','Jaguariuna (JHT)'));
        options.add(new SelectOption('Karlsdorf CP','Karlsdorf CP'));
        options.add(new SelectOption('Kolkata, India','Kolkata, India'));
        //options.add(new SelectOption('Matamoros MX (CTS)','Matamoros MX (CTS)'));
        options.add(new SelectOption('Mexico (Brightstar)','Mexico (Brightstar)'));
        options.add(new SelectOption('ML &S Greifswald','ML &S Greifswald'));
        options.add(new SelectOption('Monterrey-E (Celestica)','Monterrey-E (Celestica)'));
        options.add(new SelectOption('Monterrey-N (Celestica)','Monterrey-N (Celestica)'));
        options.add(new SelectOption('Munchen, Germany','Munchen, Germany'));
        options.add(new SelectOption('Nanjing (Compal)','Nanjing (Compal)'));
        options.add(new SelectOption('Nasu (Fujitsu)','Nasu (Fujitsu)'));
        options.add(new SelectOption('North America (NA)','North America (NA)'));
        options.add(new SelectOption('NSN - J','NSN - J'));
        options.add(new SelectOption('ODM Arima Wujiang','ODM Arima Wujiang'));
        options.add(new SelectOption('ODM BYD Huizhou','ODM BYD Huizhou'));
        options.add(new SelectOption('ODM CMCS','ODM CMCS'));
        options.add(new SelectOption('ODM Compal Nanjing','ODM Compal Nanjing'));
        options.add(new SelectOption('ODM Foxconn Longhua','ODM Foxconn Longhua'));
        options.add(new SelectOption('ODM Foxconn Taiyuan','ODM Foxconn Taiyuan'));
        options.add(new SelectOption('ODM Foxlink Kunshan','ODM Foxlink Kunshan'));
        options.add(new SelectOption('ODM HuaWei Shenzhen','ODM HuaWei Shenzhen'));
        options.add(new SelectOption('ODM Inventec Shanghai','ODM Inventec Shanghai'));
        options.add(new SelectOption('ODM Qisda Shanghai','ODM Qisda Shanghai'));
        options.add(new SelectOption('ODM Supplier','ODM Supplier'));
        options.add(new SelectOption('ODM TCT','ODM TCT'));
        options.add(new SelectOption('ODM TCT Huizhou','ODM TCT Huizhou'));
        options.add(new SelectOption('Offenburg (Elcoteq)','Offenburg (Elcoteq)'));
        options.add(new SelectOption('Other','Other'));
        options.add(new SelectOption('Oulu, Finland','Oulu, Finland'));
        options.add(new SelectOption('Parana Hub','Parana Hub'));
        options.add(new SelectOption('Penang','Penang'));
        options.add(new SelectOption('Penang (BCM)','Penang (BCM)'));
        options.add(new SelectOption('Penang (Sanmina)','Penang (Sanmina)'));
        options.add(new SelectOption('Penang (ZMY12)','Penang (ZMY12)'));
        options.add(new SelectOption('Philippines (Wistron)','Philippines (Wistron)'));
        options.add(new SelectOption('Plano-TX (Flextronics)','Plano-TX (Flextronics)'));
        options.add(new SelectOption('Quanta','Quanta'));
        options.add(new SelectOption('Rapid City, SD (Sanmina)','Rapid City, SD (Sanmina)'));
        options.add(new SelectOption('Rittal Germany','Rittal Germany'));
        options.add(new SelectOption('Roosendaal Hub','Roosendaal Hub'));
        options.add(new SelectOption('Salt Lake City','Salt Lake City'));
        options.add(new SelectOption('Sanford (Conelec)','Sanford (Conelec)'));
        options.add(new SelectOption('San Jose (Flextronics)','San Jose (Flextronics)'));
        options.add(new SelectOption('San Jose (Foxconn)','San Jose (Foxconn)'));
        options.add(new SelectOption('Sanmina-Penang','Sanmina-Penang'));
        options.add(new SelectOption('Sanmina Tatabanya','Sanmina Tatabanya'));
        options.add(new SelectOption('Scanfill Suzhou','Scanfill Suzhou'));
        options.add(new SelectOption('Scanfill Vantaa','Scanfill Vantaa'));
        options.add(new SelectOption('SC Global','SC Global'));
        options.add(new SelectOption('Shanghai','Shanghai'));
        options.add(new SelectOption('Shanghai (Flextronics)','Shanghai (Flextronics)'));
        options.add(new SelectOption('Shanghai, China','Shanghai, China'));
        options.add(new SelectOption('Shanghai (Quanta)','Shanghai (Quanta)'));
        options.add(new SelectOption('Shanghai (USI)','Shanghai (USI)'));
        options.add(new SelectOption('Shenzhen (Foxconn)','Shenzhen (Foxconn)'));
        options.add(new SelectOption('Shiji (DNI)','Shiji (DNI)'));
        //options.add(new SelectOption('Shuzhou Hub','Shuzhou Hub'));
        options.add(new SelectOption('Singapore (JHT)','Singapore (JHT)'));
        options.add(new SelectOption('Singapore (ZSG02)','Singapore (ZSG02)'));
        options.add(new SelectOption('SRI Germany','SRI Germany'));
        options.add(new SelectOption('SSCI Chennai','SSCI Chennai'));
        options.add(new SelectOption('SSCI Haukipudas','SSCI Haukipudas'));
        options.add(new SelectOption('SSCI Kunshan','SSCI Kunshan'));
        options.add(new SelectOption('Supplier','Supplier'));
        options.add(new SelectOption('Suzhou, China','Suzhou, China'));
        options.add(new SelectOption('Shuzhou, China','Shuzhou, China'));
        options.add(new SelectOption('Suzhou (Solectron)','Suzhou (Solectron)'));
        options.add(new SelectOption('Suzhou Hub','Suzhou Hub'));
        options.add(new SelectOption('Taiwan (CMCS)','Taiwan (CMCS)'));
        options.add(new SelectOption('Tel-Aviv (Israel)','Tel-Aviv (Israel)'));
        options.add(new SelectOption('Tianjin, China','Tianjin, China'));
        options.add(new SelectOption('Tianjin (Foxconn)','Tianjin (Foxconn)'));
        options.add(new SelectOption('Tianjin (JHT)','Tianjin (JHT)'));
        options.add(new SelectOption('Tianjin (Jinya)','Tianjin (Jinya)'));
        options.add(new SelectOption('Tianjin (Pemstar)','Tianjin (Pemstar)'));
        options.add(new SelectOption('Tianjin (ZCH06)','Tianjin (ZCH06)'));
        options.add(new SelectOption('Ulm, Germany','Ulm, Germany'));
        options.add(new SelectOption('Vantaa CP','Vantaa CP'));
        options.add(new SelectOption('Westminster Colorado','Westminster Colorado'));
       

        return options;
    }

    public static List<SelectOption> getAlertTypesList(boolean IsAll) 
    {
        List<SelectOption> options = new List<SelectOption>();
        if(IsAll)
        options.add(new SelectOption('All','All'));
        else
        options.add(new SelectOption('--None--','--None--'));
        options.add(new SelectOption('NPI Launch Impact','NPI Launch Impact'));
        options.add(new SelectOption('Quality Alert','Quality Alert'));
        options.add(new SelectOption('Delivery Stop','Delivery Stop')); 
        return options;
    }

    public static List<SelectOption> getStatusList(boolean IsAll) 
    {
        List<SelectOption> options = new List<SelectOption>();
         if(IsAll)
            options.add(new SelectOption('All','All'));
        else
            options.add(new SelectOption('--None--','--None--'));        
        options.add(new SelectOption('Open','Open'));
        options.add(new SelectOption('Closed','Closed'));
        options.add(new SelectOption('Canceled','Canceled'));
//        options.add(new SelectOption('Lifted','Lifted'));
        options.add(new SelectOption('Released','Released'));        
        
       // options.add(new SelectOption('Resolution Itentified / Awaiting for approval','Resolution Itentified / Awaiting for approval'));
        options.add(new SelectOption('Submitted to Master Approval','Submitted to Master Approval'));
        return options;
    }
     
    public static List<SelectOption> getProcessOwnersList() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));
        List<QIRS__c> qUserList = new List<QIRS__c>();
        qUserList = [select Process_Owner1__r.Name,Approval_Comments__c from QIRS__c where Process_Owner1__c != '' 
        order by Process_Owner1__c];
         //User[] usr = [SELECT id, Name FROM User];
        for (Integer j=0;j<qUserList.size();j++)
        {
        
                    
            if(j == 0)
            {
                options.add(new SelectOption(qUserList[j].Process_Owner1__c,
                qUserList[j].Process_Owner1__r.Name));
            }
            else
            {
                if(qUserList[j].Process_Owner1__c != qUserList[j-1].Process_Owner1__c)
                {
                    options.add(new SelectOption(qUserList[j].Process_Owner1__c,
                    qUserList[j].Process_Owner1__r.Name));  
                }
            }
        }
       
          
        return options;
    }   

    public static List<SelectOption> getQIRSActionplanItem() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));
        options.add(new SelectOption('No Action','No Action'));
        options.add(new SelectOption('Open','Open'));
        options.add(new SelectOption('Accepted by Champion','Accepted by Champion'));
        options.add(new SelectOption('Implemented by Champion','Implemented by Champion'));
        options.add(new SelectOption('Approved','Approved'));
        options.add(new SelectOption('Closed','Closed'));
        options.add(new SelectOption('Rejected','Rejected'));
        return options;
    } 
     public static List<QIRS__c> getProductName(List<QIRS__c> lstQirs)
       {
       
   for (Integer j=0;j<lstQirs.size();j++)
           { 
              lstQirs[j].View_Product_Name__c ='';
               for(QIRS_Product_Identification__c qProduct :lstQirs[j].Product_Identification__r)
               { 
                    //lstQirs[j].View_Product_Name__c =qProduct.Name;
                    if(!qProduct.Release_Product__c )
                    {
                    
                        if(lstQirs[j].View_Product_Name__c == '')
                        {
                            lstQirs[j].View_Product_Name__c =qProduct.Name;
                        }
                        else
                        {
                            lstQirs[j].View_Product_Name__c =lstQirs[j].View_Product_Name__c+ '; ' + qProduct.Name;
                        }
                    }
                } 
              if(lstQirs[j].View_Release_Product__c != '' && lstQirs[j].View_Release_Product__c != null && lstQirs[j].View_Product_Name__c != '')
              {
                  lstQirs[j].View_Product_Name__c = lstQirs[j].View_Product_Name__c + ';';
              }    
           }
          return  lstQirs;    
       }   
     public static List<QIRS__c> getProductPN(List<QIRS__c> lstQirs)
       {
       
   for (Integer j=0;j<lstQirs.size();j++)
           { 
               for(QIRS_Product_Identification__c qProduct :lstQirs[j].Product_Identification__r)
               { 
                    //lstQirs[j].View_Product_Name__c =qProduct.Name;
                    if(!qProduct.Release_Product__c )
                    {
                    
                        if(lstQirs[j].Product_PN__c == '')
                        {
                            lstQirs[j].Product_PN__c =qProduct.Name;
                        }
                        else
                        {
                            lstQirs[j].Product_PN__c =lstQirs[j].Product_PN__c+ '; ' + qProduct.Name;
                        }
                    }
                } 
              if(lstQirs[j].View_Release_Product__c != '' && lstQirs[j].View_Release_Product__c != null && lstQirs[j].Product_PN__c != '')
              {
                  lstQirs[j].Product_PN__c = lstQirs[j].Product_PN__c + ';';
              }    
           }
          return  lstQirs;    
       }   
    
       public static List<QIRS__c> getAPColorCode(List<QIRS__c> lstQirs)
       {
       
       for (Integer j=0;j<lstQirs.size();j++)
               { 
                   
                    //System.debug('5555555555555555555555555555555'+lstQirs[j].QIRS_Action_Plan__r);
                 for(QIRS_Action_Plan__c ap :lstQirs[j].QIRS_Action_Plan__r)
                   {
                       //System.debug('9999999999999999999999999999'+ap);
                       if(ap != null)    
                        {
                             lstQirs[j].View_AP_Color__c = 'white';                    
                        }
                        else
                        {
                             lstQirs[j].View_AP_Color__c = 'red';                    
                        }
                   }
                   if(lstQirs[j].QIRS_Action_Plan__r.size()==0)
                   {
                       lstQirs[j].View_AP_Color__c = 'red';  
                   }
               }
          return  lstQirs;    
       } 
    
       public static String QIRSBodyFormat(List<QIRS__c> lst,String Type)
       {
           string strbody ='';
           

           for(QIRS__c r : lst)
           {
               if(Type == 'Open')
               {
                    strbody += '<tr><td><b> Record Code </b></td> <td>'+ r.Name +'</td></tr><tr><td><b>Alert Type</b></td><td>'+r.Alert_Type__c+'</td></tr><tr><td><b>Originator</b></td><td>'+r.CreatedBy.Name+'</td></tr> <tr><td><b>Case Owner </b></td> <td>'+ r.Process_Owner1__r.Name +'</td></tr><tr><td><b>  Site </b></td> <td>'+ r.Site1__c +'</td></tr> <tr><td><b>  Business </b></td> <td>'+ r.Business__c +'</td></tr> <tr><td><b>  Business Group </b></td> <td>'+ r.Business_Group__c +'</td></tr> <tr><td><b>  Problem </b></td> <td>'+ r.Problem_Description1__c +'</td></tr> <tr><td><b>  Defective Part </b></td> <td>'+ r.Defective_Part__c +'</td></tr> <tr><td><b>  Issue Level </b></td> <td>'+ r.Issue_Level__c +'</td></tr><tr><td><b>Impacted Region</b></td><td>'+r.Impacted_Region__c+'</td></tr><tr><td><b> Impacted Countries </b></td> <td>'+ r.Countries__c +'</td></tr><tr><td><b>  Customer </b></td> <td>'+ r.Customer__c +'</td></tr><tr><td><b>  Orders at Risk </b></td> <td>'+ r.Orders_backlog__c +'</td></tr><tr><td><b>  Units at Risk </b></td> <td>'+ r.Units_Backlog__c +'</td></tr><tr><td><b>  Revenue at Risk </b></td> <td>'+ r.Revenue_Backlog__c +'</td></tr><tr><td><b>  Orders Impact </b></td> <td>'+ r.Orders_Impact__c +'</td></tr><tr><td><b>  Units Impact </b></td> <td>'+ r.Units_Impact__c +'</td></tr><tr><td><b>  Revenue Impact </b></td> <td>'+ r.Revenue_Impact__c +'</td></tr><tr><td><b>  Factory </b></td> <td>'+ r.Factory__c +'</td></tr><tr><td><b>Product PN</b></td><td>'+r.Product_PN__c+'</td></tr><tr><td><b>  Product Name </b></td> <td>'+ r.View_Product_Name__c +'</td></tr><tr><td><b>  Created Date </b></td> <td>'+ r.CreatedDate +'</td></tr><tr><td><b>Master Approver</b></td><td>'+r.Master_Approver__c+'</td></tr><tr><td><b>  Status <b></td> <td style="background-color:'+r.StatusColor__c+'">'+ r.Status__c +'</td></tr>';                                  
                    //'To Review the QIRS details, Please Click on the Link :<a href = https://cs11.salesforce.com/'+r.{!QIRS__c.Id}+'>https://cs11.salesforce.com/'+r.{!QIRS__c.Id}+'</a>'
               }
               if(Type == 'Create')
               {
                   strbody += '<tr><td><b> Record Code </b></td> <td>'+ r.Name +'</td></tr><tr><td><b>Alert Type</b></td><td>'+r.Alert_Type__c+'</td></tr><tr><td><b>Originator</b></td><td>'+r.CreatedBy.Name+'</td></tr><tr><td><b>Case Owner </b></td> <td>'+ r.Process_Owner1__r.Name +'</td></tr><tr><td><b>  Site </b></td> <td>'+ r.Site1__c +'</td></tr> <tr><td><b>  Business </b></td> <td>'+ r.Business__c +'</td></tr> <tr><td><b>  Business Group </b></td> <td>'+ r.Business_Group__c +'</td></tr> <tr><td><b>  Problem </b></td> <td>'+ r.Problem_Description1__c +'</td></tr> <tr><td><b>  Defective Part </b></td> <td>'+ r.Defective_Part__c +'</td></tr> <tr><td><b>  Issue Level </b></td> <td>'+ r.Issue_Level__c +'</td></tr><tr><td><b>Impacted Region</b></td><td>'+r.Impacted_Region__c+'</td></tr><tr><td><b> Impacted Countries </b></td> <td>'+ r.Countries__c +'</td></tr><tr><td><b>  Customer </b></td> <td>'+ r.Customer__c +'</td></tr><tr><td><b>  Orders at Risk </b></td> <td>'+ r.Orders_backlog__c +'</td></tr><tr><td><b>  Units at Risk </b></td> <td>'+ r.Units_Backlog__c +'</td></tr><tr><td><b>  Revenue at Risk </b></td> <td>'+ r.Revenue_Backlog__c +'</td></tr><tr><td><b>  Orders Impact </b></td> <td>'+ r.Orders_Impact__c +'</td></tr><tr><td><b>  Units Impact </b></td> <td>'+ r.Units_Impact__c +'</td></tr><tr><td><b>  Revenue Impact </b></td> <td>'+ r.Revenue_Impact__c +'</td></tr><tr><td><b>  Factory </b></td> <td>'+ r.Factory__c +'</td></tr><tr><td><b>Product PN</b></td><td>'+r.Product_PN__c+'</td></tr><tr><td><b>  Product Name </b></td> <td>'+ r.View_Product_Name__c +'</td></tr><tr><td><b>  Created Date </b></td> <td>'+ r.CreatedDate +'</td></tr><tr><td><b>Master Approver</b></td><td>'+r.Master_Approver__c+'</td></tr><tr><td><b>  Status <b></td> <td style="background-color:'+r.StatusColor__c+'">'+ r.Status__c +'</td></tr>';                   
               }
               if(Type =='ReOpen')
               {
                   strbody += '<tr><td><b> Record Code </b></td> <td>'+ r.Name +'</td></tr><tr><td><b>Alert Type</b></td><td>'+r.Alert_Type__c+'</td></tr><tr><td><b>Originator</b></td><td>'+r.CreatedBy.Name+'</td></tr> <tr><td><b>Case Owner </b></td> <td>'+ r.Process_Owner1__r.Name +'</td></tr><tr><td><b>  Site </b></td> <td>'+ r.Site1__c +'</td></tr> <tr><td><b>  Business </b></td> <td>'+ r.Business__c +'</td></tr> <tr><td><b>  Business Group </b></td> <td>'+ r.Business_Group__c +'</td></tr> <tr><td><b>  Problem </b></td> <td>'+ r.Problem_Description1__c +'</td></tr> <tr><td><b>  Defective Part </b></td> <td>'+ r.Defective_Part__c +'</td></tr> <tr><td><b>  Issue Level </b></td> <td>'+ r.Issue_Level__c +'</td></tr><tr><td><b>Impacted Region</b></td><td>'+r.Impacted_Region__c+'</td></tr><tr><td><b> Impacted Countries </b></td> <td>'+ r.Countries__c +'</td></tr><tr><td><b>  Customer </b></td> <td>'+ r.Customer__c +'</td></tr><tr><td><b>  Orders at Risk </b></td> <td>'+ r.Orders_backlog__c +'</td></tr><tr><td><b>  Units at Risk </b></td> <td>'+ r.Units_Backlog__c +'</td></tr><tr><td><b>  Revenue at Risk </b></td> <td>'+ r.Revenue_Backlog__c +'</td></tr><tr><td><b>  Orders Impact </b></td> <td>'+ r.Orders_Impact__c +'</td></tr><tr><td><b>  Units Impact </b></td> <td>'+ r.Units_Impact__c +'</td></tr><tr><td><b>  Revenue Impact </b></td> <td>'+ r.Revenue_Impact__c +'</td></tr><tr><td><b>  Factory </b></td> <td>'+ r.Factory__c +'</td></tr><tr><td><b>Product PN</b></td><td>'+r.Product_PN__c+'</td></tr><tr><td><b>  Product Name </b></td> <td>'+ r.View_Product_Name__c +'</td></tr><tr><td><b>  Created Date </b></td> <td>'+ r.CreatedDate +'</td></tr><tr><td><b>Master Approver</b></td><td>'+r.Master_Approver__c+'</td></tr><tr><td><b>  Status <b></td> <td style="background-color:'+r.StatusColor__c+'">'+ r.Status__c +'</td></tr>';                   
               }
              //if(Type =='Lifted')
              if(Type =='Released')
               {
                   strbody += '<tr><td><b> Record Code </b></td> <td>'+ r.Name +'</td></tr><tr><td><b>Alert Type</b></td><td>'+r.Alert_Type__c+'</td></tr><tr><td><b>Originator</b></td><td>'+r.CreatedBy.Name+'</td></tr> <tr><td><b>Case Owner </b></td> <td>'+ r.Process_Owner1__r.Name +'</td></tr><tr><td><b>  Site </b></td> <td>'+ r.Site1__c +'</td></tr> <tr><td><b>  Business </b></td> <td>'+ r.Business__c +'</td></tr> <tr><td><b>  Business Group </b></td> <td>'+ r.Business_Group__c +'</td></tr> <tr><td><b>  Problem </b></td> <td>'+ r.Problem_Description1__c +'</td></tr> <tr><td><b>  Defective Part </b></td> <td>'+ r.Defective_Part__c +'</td></tr> <tr><td><b>  Issue Level </b></td> <td>'+ r.Issue_Level__c +'</td></tr><tr><td><b>Impacted Region</b></td><td>'+r.Impacted_Region__c+'</td></tr><tr><td><b> Impacted Countries </b></td> <td>'+ r.Countries__c +'</td></tr><tr><td><b>  Customer </b></td> <td>'+ r.Customer__c +'</td></tr><tr><td><b> Orders at Risk </b></td> <td>'+ r.Orders_backlog__c +'</td></tr><tr><td><b>  Units at Risk </b></td> <td>'+ r.Units_Backlog__c +'</td></tr><tr><td><b>  Revenue at Risk </b></td> <td>'+ r.Revenue_Backlog__c +'</td></tr><tr><td><b>  Orders Impact </b></td> <td>'+ r.Orders_Impact__c +'</td></tr><tr><td><b>  Units Impact </b></td> <td>'+ r.Units_Impact__c +'</td></tr><tr><td><b>  Revenue Impact </b></td> <td>'+ r.Revenue_Impact__c +'</td></tr><tr><td><b>  Factory </b></td> <td>'+ r.Factory__c +'</td></tr><tr><td><b>Product PN</b></td><td>'+r.View_Release_Product__c+'</td></tr><tr><td><b>  Product Name </b></td> <td>'+ r.View_Product_Name__c +'</td></tr><tr><td><b>  Created Date </b></td> <td>'+ r.CreatedDate +'</td></tr><tr><td><b>Master Approver</b></td><td>'+r.Master_Approver__c+'</td></tr><tr><td><b>  Status <b></td> <td style="background-color:'+r.StatusColor__c+'">'+ r.Status__c +'</td></tr>';                   
               }
               //The below lines 441 t0 444 added by Thiresh on 19-Nov-2012
               if(Type =='Rejected')
               {
                 List<QIRS_Status__c> lstQirsStatus= new List<QIRS_Status__c>();
                 List<AggregateResult> lstQirsStatusnumber=new List<AggregateResult>();
                 lstQirsStatusnumber=[Select MAX(Record_Number__c) rn from QIRS_Status__c where QIRS__r.Id =:r.Id];
                 String maxRecordnumber;
                 for (AggregateResult ar : lstQirsStatusnumber) {
                         maxRecordnumber=String.Valueof(ar.get('rn'));
                         System.debug('Max Record Number in for loop is ' + maxRecordnumber);
                        }  
                 lstQirsStatus=[Select Record_Number__c, Comment__c from QIRS_Status__c where QIRS__r.Id =:r.Id and Record_Number__c=:maxRecordnumber];
                 System.debug('Max Record Comment'+lstQirsStatus[0].comment__c);
                 strbody += '<tr><td><b> Record Code </b></td> <td>'+ r.Name +'</td></tr><tr><td><b>Alert Type</b></td><td>'+r.Alert_Type__c+'</td></tr><tr><td><b>Originator</b></td><td>'+r.CreatedBy.Name+'</td></tr> <tr><td><b>Case Owner </b></td> <td>'+ r.Process_Owner1__r.Name +'</td></tr><tr><td><b>  Site </b></td> <td>'+ r.Site1__c +'</td></tr> <tr><td><b>  Business </b></td> <td>'+ r.Business__c +'</td></tr> <tr><td><b>  Business Group </b></td> <td>'+ r.Business_Group__c +'</td></tr> <tr><td><b>  Problem </b></td> <td>'+ r.Problem_Description1__c +'</td></tr> <tr><td><b>  Defective Part </b></td> <td>'+ r.Defective_Part__c +'</td></tr> <tr><td><b>  Issue Level </b></td> <td>'+ r.Issue_Level__c +'</td></tr><tr><td><b>Impacted Region</b></td><td>'+r.Impacted_Region__c+'</td></tr><tr><td><b> Impacted Countries </b></td> <td>'+ r.Countries__c +'</td></tr><tr><td><b>  Customer </b></td> <td>'+ r.Customer__c +'</td></tr><tr><td><b> Orders at Risk </b></td> <td>'+ r.Orders_backlog__c +'</td></tr><tr><td><b>  Units at Risk </b></td> <td>'+ r.Units_Backlog__c +'</td></tr><tr><td><b>  Revenue at Risk </b></td> <td>'+ r.Revenue_Backlog__c +'</td></tr><tr><td><b>  Orders Impact </b></td> <td>'+ r.Orders_Impact__c +'</td></tr><tr><td><b>  Units Impact </b></td> <td>'+ r.Units_Impact__c +'</td></tr><tr><td><b>  Revenue Impact </b></td> <td>'+ r.Revenue_Impact__c +'</td></tr><tr><td><b>  Factory </b></td> <td>'+ r.Factory__c +'</td></tr><tr><td><b>Product PN</b></td><td>'+r.View_Release_Product__c+'</td></tr><tr><td><b>  Product Name </b></td> <td>'+ r.View_Product_Name__c +'</td></tr><tr><td><b>  Created Date </b></td> <td>'+ r.CreatedDate +'</td></tr><tr><td><b>Master Approver</b></td><td>'+r.Master_Approver__c+'</td></tr><tr><td><b>  Status <b></td> <td style="background-color:'+r.StatusColor__c+'">'+ r.Status__c +'</td></tr><tr><td><b>Reason for Rejection</b></td><td>'+lstQirsStatus[0].Comment__c+'</td></tr>'; 
               }
               if(Type =='Canceled')
               {
                   strbody += '<tr><td><b> Record Code </b></td> <td>'+ r.Name +'</td></tr><tr><td><b>Alert Type</b></td><td>'+r.Alert_Type__c+'</td></tr><tr><td><b>Originator</b></td><td>'+r.CreatedBy.Name+'</td></tr> <tr><td><b>Case Owner </b></td> <td>'+ r.Process_Owner1__r.Name +'</td></tr><tr><td><b>  Site </b></td> <td>'+ r.Site1__c +'</td></tr> <tr><td><b>  Business </b></td> <td>'+ r.Business__c +'</td></tr> <tr><td><b>  Business Group </b></td> <td>'+ r.Business_Group__c +'</td></tr> <tr><td><b>  Problem </b></td> <td>'+ r.Problem_Description1__c +'</td></tr> <tr><td><b>  Defective Part </b></td> <td>'+ r.Defective_Part__c +'</td></tr> <tr><td><b>  Issue Level </b></td> <td>'+ r.Issue_Level__c +'</td></tr><tr><td><b>Impacted Region</b></td><td>'+r.Impacted_Region__c+'</td></tr><tr><td><b> Impacted Countries </b></td> <td>'+ r.Countries__c +'</td></tr><tr><td><b>  Customer </b></td> <td>'+ r.Customer__c +'</td></tr><tr><td><b>  Orders at Risk </b></td> <td>'+ r.Orders_backlog__c +'</td></tr><tr><td><b>  Units at Risk </b></td> <td>'+ r.Units_Backlog__c +'</td></tr><tr><td><b>  Revenue at Risk </b></td> <td>'+ r.Revenue_Backlog__c +'</td></tr><tr><td><b>  Orders Impact </b></td> <td>'+ r.Orders_Impact__c +'</td></tr><tr><td><b>  Units Impact </b></td> <td>'+ r.Units_Impact__c +'</td></tr><tr><td><b>  Revenue Impact </b></td> <td>'+ r.Revenue_Impact__c +'</td></tr><tr><td><b>  Factory </b></td> <td>'+ r.Factory__c +'</td></tr><tr><td><b>Product PN</b></td><td>'+r.Product_PN__c+'</td></tr><tr><td><b>  Product Name </b></td> <td>'+ r.View_Product_Name__c +'</td></tr><tr><td><b>  Created Date </b></td> <td>'+ r.CreatedDate +'</td></tr><tr><td><b>Master Approver</b></td><td>'+r.Master_Approver__c+'</td></tr><tr><td><b>  Status <b></td> <td style="background-color:'+r.StatusColor__c+'">'+ r.Status__c +'</td></tr>';                   
               }
               
               if(Type =='Closed')
               {
                   strbody +='<tr><td><b> Record Code </b></td> <td>'+ r.Name +'</td></tr><tr><td><b>Alert Type</b></td><td>'+r.Alert_Type__c+'</td></tr><tr><td><b>Originator</b></td><td>'+r.CreatedBy.Name+'</td></tr> <tr><td><b>Case Owner </b></td> <td>'+ r.Process_Owner1__r.Name +'</td></tr><tr><td><b>Alert Type</b></td><td>'+r.Alert_Type__c+'</td></tr> <tr><td><b>  Site </b></td> <td>'+ r.Site1__c +'</td></tr> <tr><td><b>  Business </b></td> <td>'+ r.Business__c +'</td></tr> <tr><td><b>  Business Group </b></td> <td>'+ r.Business_Group__c +'</td></tr> <tr><td><b>  Problem </b></td> <td>'+ r.Problem_Description1__c +'</td></tr> <tr><td><b>  Defective Part </b></td> <td>'+ r.Defective_Part__c +'</td></tr> <tr><td><b>  Issue Level </b></td> <td>'+ r.Issue_Level__c +'</td></tr><tr><td><b>Impacted Region</b></td><td>'+r.Impacted_Region__c+'</td></tr><tr><td><b> Impacted Countries </b></td> <td>'+ r.Countries__c +'</td></tr><tr><td><b>  Customer </b></td> <td>'+ r.Customer__c +'</td></tr><tr><td><b>  Orders at Risk </b></td> <td>'+ r.Orders_backlog__c +'</td></tr><tr><td><b>  Units at Risk </b></td> <td>'+ r.Units_Backlog__c +'</td></tr><tr><td><b>  Revenue at Risk </b></td> <td>'+ r.Revenue_Backlog__c +'</td></tr><tr><td><b>  Orders Impact </b></td> <td>'+ r.Orders_Impact__c +'</td></tr><tr><td><b>  Units Impact </b></td> <td>'+ r.Units_Impact__c +'</td></tr><tr><td><b>  Revenue Impact </b></td> <td>'+ r.Revenue_Impact__c +'</td></tr><tr><td><b>  Factory </b></td> <td>'+ r.Factory__c +'</td></tr><tr><td><b>Product PN</b></td><td>'+r.View_Release_Product__c+'</td></tr><tr><td><b>  Product Name </b></td> <td>'+ r.View_Product_Name__c +'</td></tr><tr><td><b>  Created Date </b></td> <td>'+ r.CreatedDate +'</td></tr><tr><td><b>Master Approver</b></td><td>'+r.Master_Approver__c+'</td></tr><tr><td><b>  Status <b></td> <td style="background-color:'+r.StatusColor__c+'">'+ r.Status__c +'</td></tr>';                   
               }
               //strbody += '<tr><td><b> Record Code </b></td> <td>'+ r.Name +'</td></tr><tr><td><b>Originator</b></td><td>'+r.CreatedBy.Name+'</td></tr> <tr><td><b>Case Owner </b></td> <td>'+ r.Owner.Name +'</td></tr><tr><td><b>Alert Type</b></td><td>'+r.Alert_Type__c+'</td></tr> <tr><td><b>  Site </b></td> <td>'+ r.Site1__c +'</td></tr> <tr><td><b>  Business </b></td> <td>'+ r.Business__c +'</td></tr> <tr><td><b>  Business Group </b></td> <td>'+ r.Business_Group__c +'</td></tr> <tr><td><b>  Problem </b></td> <td>'+ r.Problem_Description1__c +'</td></tr> <tr><td><b>  Defective Part </b></td> <td>'+ r.Defective_Part__c +'</td></tr> <tr><td><b>  Issue Level </b></td> <td>'+ r.Issue_Level__c +'</td></tr><tr><td><b>Impacted Region</b></td><td>'+r.Impacted_Region__c+'</td></tr><tr><td><b> Impacted Countries </b></td> <td>'+ r.Countries__c +'</td></tr><tr><td><b>  Customer </b></td> <td>'+ r.Customer__c +'</td></tr><tr><td><b>  Orders Backlog </b></td> <td>'+ r.Orders_backlog__c +'</td></tr><tr><td><b>  Units Backlog </b></td> <td>'+ r.Units_Backlog__c +'</td></tr><tr><td><b>  Revenue Backlog </b></td> <td>'+ r.Revenue_Backlog__c +'</td></tr><tr><td><b>  Orders Impact </b></td> <td>'+ r.Orders_Impact__c +'</td></tr><tr><td><b>  Units Impact </b></td> <td>'+ r.Units_Impact__c +'</td></tr><tr><td><b>  Revenue Impact </b></td> <td>'+ r.Revenue_Impact__c +'</td></tr><tr><td><b>  Factory </b></td> <td>'+ r.Factory__c +'</td></tr><tr><td><b>Product PN</b></td><td>'+r.Product_PN__c+'</td></tr><tr><td><b>  Product Name </b></td> <td>'+ r.View_Product_Name__c +'</td></tr><tr><td><b>  CreatedDate </b></td> <td>'+ r.CreatedDate +'</td></tr><tr><td><b>Master Approver</b></td><td>'+r.Master_Approver__c+'</td></tr><tr><td><b>  Status <b></td> <td style="background-color:'+r.StatusColor__c+'">'+ r.Status__c +'</td></tr>';                   
               //,'+View_Release_Product__c+'
           }
           return strbody;
       }
    
       public static String ActionPlanBodyFormat(String QIRSID)
       {
       List<QIRS_Action_Plan__c> qirsAP = new List<QIRS_Action_Plan__c>();
        qirsAP = [select ID, StatusColor__c,Implementation_Comment__c,QIRS__r.Process_Owner1__r.Name, Task__c,CreatedDate,Name,Action_Type__c,QIRS__r.Name,Createdby.Name,Approver__c,Champion__c,Required_date__c,Status__c,Implementation_Date__c from QIRS_Action_Plan__c
            where QIRS__r.Id =:QIRSID];
           string strbody ='';
           for(QIRS_Action_Plan__c r : qirsAP)
           {
               //strbody += '<tr><td> Action Plan Number</td><td>  QIRS </td><td>  Originator </td><td>  Champion </td><td>  Approver</td><td>  Action Type </td><td>  Task </td><td>  Created Date </td><td>  Required Date </td><td>  Implemented Date </td><td>  Status </td> </tr>''<tr><td>'+ r.Id +'</td> <td>'+ r.Owner.Name +'</td><td>'+ r.QIRS__c +'</td><td>'+ r.CreatedBy +'</td><td>'+ r.Champion__c +'</td><td>'+ r.Approver__c +'</td> <td>'+ r.Action_Type__c +'</td> <td>'+ r.Task__c +'</td><td>'+ r.CreatedDate +'</td><td>'+ r.Required_date__c +'</td><td>'+ r.Status__c+'</td> </tr>';                   
               strbody += '<tr><td>'+ r.Name +'</td>'
                          // +'<td>'+ r.QIRS__r.Name +'</td>'
                           +'<td>'+r.QIRS__r.Process_Owner1__r.Name +'</td>'
                           +'<td>'+ r.CreatedBy.Name +'</td>'
                           +'<td>'+ r.Champion__c +'</td>'
                           +'<td>'+ r.Approver__c +'</td>'
                           +'<td>'+ r.Action_Type__c +'</td>'
                           +'<td>'+ r.Task__c+'</td>'  
                           +'<td>'+ r.CreatedDate.format('MM/dd/yyyy')+'</td>'  
                           +'<td>'+ r.Required_date__c+'</td>'  
                           +'<td>'+ r.Implementation_Date__c+'</td>' 
                           +'<td>'+ r.Implementation_Comment__c+'</td>' 
                           +'<td style="background-color:'+ r.StatusColor__c +'">'+ r.Status__c+'</td>' 
                           +'</tr>' ; 
           }
           strbody = strbody.replace('null' , '') ;
           String finalStr = '' ;
           finalStr = '<br/><b>Action Plan Details</b><table border="1"> <td align="center" ><b> Action Plan Number</b></td><td align="center" ><b> Case Owner</b></td><td align="center" ><b>Action Originator </b></td> <td align="center" ><b> Champion</b></td> <td align="center"><b> Approver</b></td> <td align="center"><b> Action Type</b></td> <td align="center"><font color="white">aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</font><br/><b> Task</b></td><td align="center"><b>CreatedDate</b></td><td align="center"><b>RequiredDate</b></td><td align="center"><b>Implementation Date</b></td><td align="center"><b>Implementation Comments</b></td><td align="center"><b>Status</b></td> ' + strbody +'</table>' ;    
           
           return finalStr;
       }

      public static String BodyFormat(List<QIRS__c> lst,String Type)
       {
           String str = QIRSBodyFormat(lst,Type);
           str = str.replace('null' , '') ;
           string strbanner ='Record '+ lst[0].Status__c + ' - QIRS System';
           String Header=''; 
           String finalStr = '' ;
           //Test Environment
         // Header = '<table  width="100%" height="0.5%" bgcolor="#38ACEC"> <td width="30"> <img src="https://c.cs11.content.force.com/servlet/servlet.ImageServer?id=015K00000000gGa&oid=00DK0000002WcTM&lastMod=1336714039000" alt="Right click on the image to save it to your computer." title="Right click on the image to save it to your computer."/> </td> <td align="right"><b><font color="#FFFFFF" Size="4" face="Arial">' + strbanner +'<br/> </font></b></td></table><br/><table width="100%" height="0.1%" bgcolor="#3090C7"><td><a style="color:white" href = "https://test.salesforce.com">QIRS System</a></td></table><br/>';
          //Prod Environment
           Header = '<table  width="100%" height="0.5%" bgcolor="#38ACEC"> <td width="30"> <img src="https://c.cs63.content.force.com/servlet/servlet.ImageServer?id=015K00000000gGa&oid=00DK0000002WcTM&lastMod=1336714039000" alt="Right click on the image to save it to your computer." title="Right click on the image to save it to your computer."/> </td> <td align="right"><b><font color="#FFFFFF" Size="4" face="Arial">' + strbanner +'<br/> </font></b></td></table><br/><table width="100%" height="0.1%" bgcolor="#3090C7"><td><a style="color:white" href = "https://test.salesforce.com">QIRS System</a></td></table><br/>';          
           for(QIRS__c r : lst)
           {
           if(Type == 'Open')
           {
               Header += ' <b><h3>The Status of the ' + lst[0].Name + ' is Open.</h3></b>';
               //finalStr = Header +'<table border="2">'  + str +'</table>'+'To review the QIRS details, please click on the link :<a href = https://cs11.salesforce.com/'+r.Id+'>https://cs11.salesforce.com/'+r.Id+'</a><br/>'+'<b>To login as a Guest user (view only) go to:(http://nsn.force.com/QIRS)</b><br/>'+'<b>To login as an active user (update privileges)  go to:(https://test.salesforce.com)</b> <br/>'+'<b>To request a force.com user Id contact Kishore at: bala_kishorebabu.neelapu.ext@nokia.com</b> <br/>'; 
               // Below line added by kishore on 26March2012
               //Test environment
                //finalStr = Header +'<table border="2">'  + str +'</table>'+'To review the QIRS details, please click on the link :<a href = https://cs11.salesforce.com/'+r.Id+'>https://cs11.salesforce.com/'+r.Id+'</a><br/>'+'<b>To login as a Guest user (view only) go to:(http://qa01-nsn.cs11.force.com/QIRS)</b><br/>'+'<b>To login as an active user (update privileges)  go to:(https://test.salesforce.com)</b> <br/>'+'<b>To request a force.com User Id or for any other force.com issues</b> <br/>'+'<b>Contact your local NSN Helpdesk : </b><br/>'+'<b><a href=https://inside.nokiasiemensnetworks.com/global/MyServices/IT/support/Pages/ServiceDeskPhonesbyCountry.aspx>https://inside.nokiasiemensnetworks.com/global/MyServices/IT/support/Pages/ServiceDeskPhonesbyCountry.aspx</a></b><br/>'+'<b>Open a support ticket to : T2.Application Support-NE APPL-QIRS-Global</b><br/>';
                //Prod Envrronment
                finalStr = Header +'<table border="2">'  + str +'</table>'+'To review the QIRS details, please click on the link :<a href = https://cs63.salesforce.com/'+r.Id+'>https://cs63.salesforce.com/'+r.Id+'</a><br/>'+'<b>To login as a Guest user (view only) go to:(http://nsn.force.com/QIRS)</b><br/>'+'<b>To login as an active user (update privileges)  go to:(https://test.salesforce.com)</b> <br/>'+'<b>To request a force.com User Id or for any other force.com issues</b> <br/>'+'<b>Contact your local NSN Helpdesk : </b><br/>'+'<b><a href=https://inside.nokiasiemensnetworks.com/global/MyServices/IT/support/Pages/ServiceDeskPhonesbyCountry.aspx>https://inside.nokiasiemensnetworks.com/global/MyServices/IT/support/Pages/ServiceDeskPhonesbyCountry.aspx</a></b><br/>'+'<b>Open a support ticket to : T2.Application Support-NE APPL-QIRS-Global</b><br/>'; 
           }
           if(Type == 'Create')
           {
               Header += ' <b><h3>Record ' + lst[0].Name + ' has been created.</h3></b>';
               //Test Environment
              //finalStr = Header +'<table border="2">'  + str +'</table> <br/>'+'To review the QIRS details, please click on the link :<a href = https://cs11.salesforce.com/'+r.Id+'>https://cs11.salesforce.com/'+r.Id+'</a>';
               //Prod Environment
             finalStr = Header +'<table border="2">'  + str +'</table> <br/>'+'To review the QIRS details, please click on the link :<a href = https://cs63.salesforce.com/'+r.Id+'>https://cs63.salesforce.com/'+r.Id+'</a>'; 
           }
           //if(Type == 'Lifted')
           if(Type == 'Released')
           {
             Header += ' <b><h3>The Status of the ' + lst[0].Name + ' is Released.</h3></b>';
//               Header = ' <b><h3>The Status of the ' + lst[0].Name + ' is Lifted.</h3></b>';
              //finalStr = Header +'<table border="2">'  + str +'</table> <br/>'+ 'To review the QIRS details, please click on the link :<a href = https://cs11.salesforce.com/'+r.Id+'>https://cs11.salesforce.com/'+r.Id+'</a> <br/>' + ActionPlanBodyFormat(lst[0].Id)+'<br/><b>To login as a Guest user (view only) go to:(http://nsn.force.com/QIRS)</b><br/>'+'<b>To login as an active user (update privileges)  go to:(https://test.salesforce.com)</b> <br/>'+'<b>To request a force.com user Id contact Kishore at: bala_kishorebabu.neelapu.ext@nokia.com</b> <br/>' ;                   
              //Below line added by kishore on 26March2012
              //Test environment
            //  finalStr = Header +'<table border="2">' + str +'</table> <br/>'+ 'To review the QIRS details, please click on the link :<a href = https://cs11.salesforce.com/'+r.Id+'>https://cs11.salesforce.com/'+r.Id+'</a> <br/>' + ActionPlanBodyFormat(lst[0].Id);
              //Prod environment
              finalStr = Header +'<table border="2">' + str +'</table> <br/>'+ 'To review the QIRS details, please click on the link :<a href = https://cs63.salesforce.com/'+r.Id+'>https://cs63.salesforce.com/'+r.Id+'</a> <br/>' + ActionPlanBodyFormat(lst[0].Id);
              //+'<br/><b>To login as a Guest user (view only) go to:(http://nsn.force.com/QIRS)</b><br/>'+'<b>To login as an active user (update privileges) go to:(https://test.salesforce.com)</b> <br/>'+'<b>To request a force.com User Id or for any other force.com issues</b> <br/>'+'<b>Contact your local NSN Helpdesk : </b><br/>'+'<b><a href=https://inside.nokiasiemensnetworks.com/global/MyServices/IT/support/Pages/ServiceDeskPhonesbyCountry.aspx>https://inside.nokiasiemensnetworks.com/global/MyServices/IT/support/Pages/ServiceDeskPhonesbyCountry.aspx</a></b><br/>'+'<b>Open a support ticket to : T2.Application Support-NE APPL-QIRS-Global</b><br/>'; 
           }
           //The below lines 531 to 547 added by Thiresh on 19-Nov-2012
           if(Type == 'Rejected')
           {
             Header += ' <b><h3>The Status of the ' + lst[0].Name + ' is - <font style= "background-color:red">"Rejected by Master Approver".</font></h3></b>';
//               Header = ' <b><h3>The Status of the ' + lst[0].Name + ' is Lifted.</h3></b>';
              //finalStr = Header +'<table border="2">'  + str +'</table> <br/>'+ 'To review the QIRS details, please click on the link :<a href = https://cs11.salesforce.com/'+r.Id+'>https://cs11.salesforce.com/'+r.Id+'</a> <br/>' + ActionPlanBodyFormat(lst[0].Id)+'<br/><b>To login as a Guest user (view only) go to:(http://nsn.force.com/QIRS)</b><br/>'+'<b>To login as an active user (update privileges)  go to:(https://test.salesforce.com)</b> <br/>'+'<b>To request a force.com user Id contact Kishore at: bala_kishorebabu.neelapu.ext@nokia.com</b> <br/>' ;                   
              //Below line added by kishore on 26March2012
              //Test environment
             //finalStr = Header +'<table border="2">' + str +'</table> <br/>'+' <font color="red"><b>*** This ' + lst[0].Name + ' record has been rejected by the Master Approver  ***</b></font>'+'<br/></br>'+ 'To review the QIRS details, please click on the link :<a href = https://cs11.salesforce.com/'+r.Id+'>https://cs11.salesforce.com/'+r.Id+'</a> <br/>' + ActionPlanBodyFormat(lst[0].Id);
              //Prod environment
              finalStr = Header +'<table border="2">' + str +'</table> <br/>'+ 'To review the QIRS details, please click on the link :<a href = https://cs63.salesforce.com/'+r.Id+'>https://cs63.salesforce.com/'+r.Id+'</a> <br/>' + ActionPlanBodyFormat(lst[0].Id);
              //+'<br/><b>To login as a Guest user (view only) go to:(http://nsn.force.com/QIRS)</b><br/>'+'<b>To login as an active user (update privileges) go to:(https://test.salesforce.com)</b> <br/>'+'<b>To request a force.com User Id or for any other force.com issues</b> <br/>'+'<b>Contact your local NSN Helpdesk : </b><br/>'+'<b><a href=https://inside.nokiasiemensnetworks.com/global/MyServices/IT/support/Pages/ServiceDeskPhonesbyCountry.aspx>https://inside.nokiasiemensnetworks.com/global/MyServices/IT/support/Pages/ServiceDeskPhonesbyCountry.aspx</a></b><br/>'+'<b>Open a support ticket to : T2.Application Support-NE APPL-QIRS-Global</b><br/>'; 
           }
           if(Type == 'ReOpen')
           {
               Header += ' <b><h3>The Status of the ' + lst[0].Name + ' is Reopen.</h3></b>';
               //test environment
              // finalStr = Header +'<table border="2">'  + str +'</table> <br/>'+'To review the QIRS details, please click on the link :<a href = https://cs11.salesforce.com/'+r.Id+'>https://cs11.salesforce.com/'+r.Id+'</a> <br/>' + ActionPlanBodyFormat(lst[0].Id) ;
               //Prod environment
              finalStr = Header +'<table border="2">'  + str +'</table> <br/>'+'To review the QIRS details, please click on the link :<a href = https://cs63.salesforce.com/'+r.Id+'>https://cs63.salesforce.com/'+r.Id+'</a> <br/>' + ActionPlanBodyFormat(lst[0].Id) ;                   
           }
           if(Type == 'Canceled')
           {
               Header += ' <b><h3>The Status of the ' + lst[0].Name + ' is Canceled.</h3></b>';
               //test environment
               //finalStr = Header +'<table border="2">'  + str +'</table> <br/>'+'To Review the QIRS details, Please Click on the Link :<a href = https://cs11.salesforce.com/'+r.Id+'>https://cs11.salesforce.com/'+r.Id+'</a> <br/>' + ActionPlanBodyFormat(lst[0].Id) ;
               //Prod environment
               finalStr = Header +'<table border="2">'  + str +'</table> <br/>'+'To Review the QIRS details, Please Click on the Link :<a href = https://cs63.salesforce.com/'+r.Id+'>https://cs63.salesforce.com/'+r.Id+'</a> <br/>' + ActionPlanBodyFormat(lst[0].Id) ;                   
           }
          
           if(Type == 'Closed')
           {
               Header += ' <b><h3>The Status of the ' + lst[0].Name + ' is Closed.</h3></b>';
              // finalStr = Header +'<table border="2">'  + str +'</table> <br/>'+ 'To review the QIRS details, please click on the link :<a href = https://cs11.salesforce.com/'+r.Id+'>https://cs11.salesforce.com/'+r.Id+'</a> <br/>' + ActionPlanBodyFormat(lst[0].Id)+'<br/><b>To login as a Guest user (view only) go to:(http://nsn.force.com/QIRS)</b><br/>'+'<b>To login as an active user (update privileges)  go to:(https://test.salesforce.com)</b> <br/>'+'<b>To request a force.com user Id contact Kishore at: bala_kishorebabu.neelapu.ext@nokia.com</b> <br/>' ;
              //Below line added by kishore on 26March2012
              //test environment
           //finalStr = Header +'<table border="2">' + str +'</table> <br/>'+ 'To review the QIRS details, please click on the link :<a href = https://cs11.salesforce.com/'+r.Id+'>https://cs11.salesforce.com/'+r.Id+'</a> <br/>' + ActionPlanBodyFormat(lst[0].Id);
            //prod environment
            finalStr = Header +'<table border="2">' + str +'</table> <br/>'+ 'To review the QIRS details, please click on the link :<a href = https://cs63.salesforce.com/'+r.Id+'>https://cs63.salesforce.com/'+r.Id+'</a> <br/>' + ActionPlanBodyFormat(lst[0].Id);
            //+'<br/><b>To login as a Guest user (view only) go to:(http://nsn.force.com/QIRS)</b><br/>'+'<b>To login as an active user (update privileges) go to:(https://test.salesforce.com)</b> <br/>'+'<b>To request a force.com User Id or for any other force.com issues</b> <br/>'+'<b>Contact your local NSN Helpdesk : </b><br/>'+'<b><a href=https://inside.nokiasiemensnetworks.com/global/MyServices/IT/support/Pages/ServiceDeskPhonesbyCountry.aspx>https://inside.nokiasiemensnetworks.com/global/MyServices/IT/support/Pages/ServiceDeskPhonesbyCountry.aspx</a></b><br/>'+'<b>Open a support ticket to : T2.Application Support-NE APPL-QIRS-Global</b><br/>'; 
           }
           
          }
          //The below line belongs to production Environment 
          //The below line added by Thiresh on 28-Nov-2012
          string Footer = '<br/><br/> <table width="100%" height="1%" bgcolor="#38ACEC"><tr><td colspan="1" align="center" style="color:white"><font Size="1" face="Arial"><b>NSN Internal Use Only <br/>QIRS System</b></font> </td></tr><tr><td colspan="1" align="center"><b>To login to QIRS Application using Single Sign-On,click <a style="color:blue" href = "https://intrafed.inside.nsn.com/idp/profile/SAML2/Unsolicited/SSO?providerId=https://saml.salesforce.com">here.</a><br/>To login to QIRS Application with user name / password, click  <a style="color:blue" href="https://test.salesforce.com">here.</a><br/>To request a Force.com User ID or for any other issues related to Force.com platform, visit  My IT support to open a ticket <a style="color:blue" href="https://nsnsi.service-now.com/ess "></a><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tickets can be opened in My IT support – Request Services – Browse IT Services – Logistics Offering - QIRS </b><br/></td></tr></table>';

  //The below line belongs to TEst Environment 
   //The below line Modified by Thiresh on 28-Nov-2012      
         // string Footer = '<br/><br/> <table width="100%" height="1%" bgcolor="#38ACEC"><tr><td colspan="1" align="center" style="color:white"><font Size="1" face="Arial"><b>NSN Internal Use Only <br/><a style="color:white" href="https://test.salesforce.com">QIRS System</a></b></font> </td></tr><tr><td colspan="1" align="center"><b>To login as an active user (update privileges)  go to:(https://test.salesforce.com) <br/>To request a force.com User Id or for any other force.com issues<br/>        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Contact your local NSN Helpdesk:<br/><a href = "https://inside.nokiasiemensnetworks.com/global/MyServices/IT/support/Pages/ServiceDeskPhonesbyCountry.aspx" style="color:blue"> https://inside.nokiasiemensnetworks.com/global/MyServices/IT/support/Pages/ServiceDeskPhonesbyCountry.aspx </a><br/>       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Open a support ticket to : T2.Application Support-NE APPL-QIRS-Global </b><br/></td></tr></table>';
          finalStr =finalStr +Footer;
           return finalStr ;
       }        
    
       public static boolean SendEmail(List<String> Site, String Business,
        String AlertType,String BusinessGroup, String NotificationType,String Targetid)
       {
           system.debug('**SNDEmail ***Site**' + Site);
           system.debug('**SNDEmail ***Business**' + Business);
           system.debug('**SNDEmail ***AlertType**' + AlertType);
           system.debug('**SNDEmail ***BusinessGroup**' + BusinessGroup);
           system.debug('**SNDEmail ***NotificationType**' + NotificationType);
           system.debug('**SNDEmail ***Targetid**' + Targetid);
           boolean Result = true;
           
           try
          { 
               String strEmailTemplate='';
               String body = '' ;   
               Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
               //new Set added
               Set<String> tempqirsAPALset=new Set<String>();
               List<String> mailToAddresses = new List<String>();
               List<String> mailToAddresses1to100 = new List<String>();
               List<String> mailToAddresses100to200 = new List<String>();
               List<String> mailToAddresses200to300 = new List<String>();
               List<String> tempToAddresses1to100 = new List<String>();
               List<String> tempToAddresses100to200 = new List<String>();
               List<String> tempToAddresses200to300 = new List<String>();
               List<String> tempmailToAddresses = new List<String>();
               List<QIRS_Business_Notification_List__c> tempqirsAPAL = new List<QIRS_Business_Notification_List__c>();
               tempqirsAPAL  =  [select Email__c from QIRS_Business_Notification_List__c 
               where Business__c =: Business];    
                List<QIRS__c> lstform = new List<QIRS__c>();                 
               lstForm = [select CreatedBy.Email,Process_Owner1__r.Email,Process_Owner1__r.Name,Master_Approver__c,Impacted_Region__c,Product_PN__c,Id,Problem_Description1__c,Name,Owner.Name,View_AP_Color__c,Business__c, Alert_Type__c,Business_Group__c,Site1__c,Status__c,StatusColor__c,Process_Owner1__c ,Issue_Level__c, Defective_Part__c, Symptom__c, CreatedDate , IssueLevelColor__c,View_Product_Name__c, Watchlist__c, MCAR__c, Closed_Date1__c,Countries__c,CreatedBy.Name,Customer__c,Orders_backlog__c,Units_Backlog__c,Revenue_Backlog__c,
               Master_Approver1__r.Email,Master_Approver2__r.Email,Master_Approver3__r.Email,Master_Approver4__r.Email,Master_Approver5__r.Email,Master_Approver6__r.Email,Master_Approver7__r.Email,Master_Approver8__r.Email,Master_Approver9__r.Email,Master_Approver10__r.Email,
               Orders_Impact__c,Units_Impact__c,(select Comment__c from QIRS_Status__r),Revenue_Impact__c,Factory__c,View_Release_Product__c ,Additional_Email__c 
               from QIRS__c where Id =:  Targetid];  
                 //The below code modified by Thiresh on 05-Nov-2011  
            /*   if(NotificationType != 'Canceled'&& NotificationType != 'Rejected' )
               {      
                   for (Integer j=0;j<tempqirsAPAL.size();j++)
                       { 
                            mailToAddresses.add(tempqirsAPAL[j].Email__c);  
                                                
                       }
               }*/
                //if(NotificationType == 'Create' || NotificationType == 'Closed' || NotificationType == 'Lifted')
                if(NotificationType == 'Create' || NotificationType == 'Closed' || NotificationType == 'Released')                
                {       
                    list<String> addEmailList = new list<String>(); 
                    if(!(lstform[0].Additional_Email__c == null || lstform[0].Additional_Email__c == '')){
                        
                        /*
                         ** Last Modified By: Vivek Singh
                         ** Modified Date   : 24 September 2015
                         ** Reason: QIRS Simplification DEM0014107 
                         ** For future reference for email format we can use below Email Regex
                         ** String emailRegex = '([a-zA-Z0-9_\\-\\.]+)@((\\[a-z]{1,3}\\.[a-z]{1,3}\\.[a-z]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})'; 
                         */
                        
                        String emailRegex = '([a-zA-Z0-9_\\-\\.]+)@nokia.com';
                        Pattern emailPatternFormat = Pattern.compile(emailRegex);
                        String addStr = lstform[0].Additional_Email__c;
                        addEmailList = checkAndReturnAdditionalEmailList(addStr,emailPatternFormat); 
                    } 
                    mailToAddresses.add(lstform[0].Process_Owner1__r.Email);
                    if(addEmailList != null && !addEmailList.isEmpty()) mailToAddresses.addAll(addEmailList);  
                }        
               List<String> get_businessgroup = BusinessGroup.split(';');                  
               List<QIRS_Site_Notification__c> tempqirssite = new List<QIRS_Site_Notification__c>();
               tempqirssite = [select Email__c from QIRS_Site_Notification__c 
               where Business_Group__c  in: get_businessgroup];
               
               System.debug('9999999999999999999999999999'+tempqirssite.Size());
               //The below code modified by Thiresh on 05-Nov-2011  
              /* if(NotificationType != 'Canceled' && NotificationType != 'Rejected' )
               {
                   for (Integer j=0;j<tempqirssite.size();j++)
                       { 
                            mailToAddresses.add(tempqirssite[j].Email__c);
                       } 
               }*/
              
               if(NotificationType != 'Canceled' && NotificationType != 'Rejected' )
               {
                   for (Integer j=0;j<tempqirssite.size();j++)
                       { 
                            tempqirsAPALset.add(tempqirssite[j].Email__c);
                       } 
                  for (Integer i=0;i<tempqirsAPAL.size();i++)
                       { 
                            tempqirsAPALset.add(tempqirsAPAL[i].Email__c);  
                                                
                       } 
                  mailToAddresses.addAll(tempqirsAPALset);  
               }
               
               if(NotificationType == 'Canceled' || NotificationType == 'ReOpen')
                {
                   List<QIRS_Action_Plan__c> lstap = new List<QIRS_Action_Plan__c>();                 
                   lstap = [select Implementation_Comment__c,Core_ID__c,ID, Name, Task__c,Action_Type__c,Implementation_Date__c, Approver__c,Champion__c,
                     QIRS__c,Reason1__c,Required_date__c,Status__c,StatusColor__c, 
                     CreatedBy.Email,QIRS__r.CreatedBy.Email,Approver1__r.Email,Approver2__r.Email,Approver3__r.Email,Approver4__r.Email,Approver5__r.Email,Approver6__r.Email,Approver7__r.Email,Approver8__r.Email,Approver9__r.Email,Approver10__r.Email,
                     Champion1__r.Email,Champion2__r.Email,Champion3__r.Email,Champion4__r.Email,Champion5__r.Email,Champion6__r.Email,Champion7__r.Email,Champion8__r.Email,Champion9__r.Email,Champion10__r.Email
                     from QIRS_Action_Plan__c where QIRS__r.Id =: Targetid];
                    if(lstap.size()>0)
                    {
                    for (Integer j=0;j<lstap.size();j++)
                       { 
                            mailToAddresses.add(lstap[j].CreatedBy.Email);
                            mailToAddresses.add(lstap[j].QIRS__r.CreatedBy.Email);
                            mailToAddresses.add(lstap[j].Approver1__r.Email); 
                            mailToAddresses.add(lstap[j].Approver2__r.Email);                        
                            mailToAddresses.add(lstap[j].Approver3__r.Email);                                                                        
                            mailToAddresses.add(lstap[j].Approver4__r.Email);                        
                            mailToAddresses.add(lstap[j].Approver5__r.Email);                        
                            mailToAddresses.add(lstap[j].Approver6__r.Email);                        
                            mailToAddresses.add(lstap[j].Approver7__r.Email);                        
                            mailToAddresses.add(lstap[j].Approver8__r.Email);
                            mailToAddresses.add(lstap[j].Approver9__r.Email);
                            mailToAddresses.add(lstap[j].Approver10__r.Email);                                                                                                                                                                        
                            mailToAddresses.add(lstap[j].Champion1__r.Email);
                            mailToAddresses.add(lstap[j].Champion2__r.Email);
                            mailToAddresses.add(lstap[j].Champion3__r.Email);
                            mailToAddresses.add(lstap[j].Champion4__r.Email);
                            mailToAddresses.add(lstap[j].Champion5__r.Email);                                                                                                
                            mailToAddresses.add(lstap[j].Champion6__r.Email);
                            mailToAddresses.add(lstap[j].Champion7__r.Email);
                            mailToAddresses.add(lstap[j].Champion8__r.Email);
                            mailToAddresses.add(lstap[j].Champion9__r.Email);
                            mailToAddresses.add(lstap[j].Champion10__r.Email);                        
                       }
                            Boolean result1 = false;
                            for (Integer j=0;j<mailToAddresses.size();j++)
                            {
                                result1 = false;
                                if(j == 0)
                                {
                                    tempmailToAddresses.add(mailToAddresses[0]);
                                }
                               for (Integer x=0;x<tempmailToAddresses.size();x++)
                               {
                                   if(mailToAddresses[j] == tempmailToAddresses[x])
                                   {
                                       result1 = true;
                                       //tempmailToAddresses.add(mailToAddresses[j]);
                                   }
                               }
                               if(!result1)
                               {
                                    tempmailToAddresses.add(mailToAddresses[j]);
                               } 
                            }
                    }
                    else
                    {
                         tempmailToAddresses.add(lstForm[0].CreatedBy.Email);
                    }                 
                }
                if(NotificationType == 'Rejected')
                {
                    //NotificationType = 'Lifted';
                    //body = BodyFormat(lstForm,'Lifted');
                    body = BodyFormat(lstForm,'Rejected');
                }
                else
                {
                    body = BodyFormat(lstForm,NotificationType);
                }
                email.setHtmlBody(body);
            
                 if(NotificationType == 'Closed' || NotificationType == 'Rejected')
                {
                    
                    mailToAddresses.add(lstform[0].CreatedBy.Email);
                    mailToAddresses.add(lstform[0].Process_Owner1__r.Email);                    
                    mailToAddresses.add(lstform[0].Master_Approver1__r.Email);
                    mailToAddresses.add(lstform[0].Master_Approver2__r.Email);
                    mailToAddresses.add(lstform[0].Master_Approver3__r.Email);
                    mailToAddresses.add(lstform[0].Master_Approver4__r.Email);
                    mailToAddresses.add(lstform[0].Master_Approver5__r.Email);
                    mailToAddresses.add(lstform[0].Master_Approver6__r.Email);
                    mailToAddresses.add(lstform[0].Master_Approver7__r.Email);
                    mailToAddresses.add(lstform[0].Master_Approver8__r.Email);
                    mailToAddresses.add(lstform[0].Master_Approver9__r.Email);
                    mailToAddresses.add(lstform[0].Master_Approver10__r.Email);  
                    Boolean result1 = false;
                    for (Integer j=0;j<mailToAddresses.size();j++)
                    {
                        result1 = false;
                        if(j == 0)
                        {
                            tempmailToAddresses.add(mailToAddresses[0]);
                        }
                       for (Integer x=0;x<tempmailToAddresses.size();x++)
                       {
                           if(mailToAddresses[j] == tempmailToAddresses[x])
                           {
                               result1 = true;
                           }
                       }
                       if(!result1)
                       {
                            tempmailToAddresses.add(mailToAddresses[j]);
                       } 
                    }                                                                                                                                                                                  
                               
                }
                   
                
                 //The below lines 784 to 786 added by Thiresh on 03-Dec-2012
                if(NotificationType == 'Rejected')
                email.setSubject('Record '+lstform[0].Name+':'+'Rejected by Master Approver');
                else
                email.setSubject('Record '+lstform[0].Name+':'+lstform[0].Status__c);
                email.setSaveAsActivity(false);  
                
                if(NotificationType == 'ReOpen' || NotificationType == 'Canceled' || 
                NotificationType == 'Closed' ||  NotificationType == 'Rejected') { 
                //email.setToAddresses(tempmailToAddresses); 
                System.debug('The number of email ids in tempmailToAddresses Size: '+tempmailToAddresses.size());
                System.debug('The number of email ids in tempmailToAddresses: '+tempmailToAddresses);
               
                for(integer k=1;k<100;k++)
                  {
                     tempToAddresses1to100.add(tempmailToAddresses[k-1]);
                     System.debug('Email Address number first batch '+ k + 'is:' + tempmailToAddresses[k-1]);
                     if(k==tempmailToAddresses.size())
                     break;
                  }
                for(integer l=101;l<200;l++)
                    {
                     if(tempmailToAddresses.size()>100)
                     {
                      tempToAddresses100to200.add(tempmailToAddresses[l-1]);
                      System.debug('Email Address number second batch'+ l + 'is:' + tempmailToAddresses[l-1]);
                     }
                     if(l==tempmailToAddresses.size())
                     break;
                    }
                for(integer m=201;m<300;m++)
                    {
                     if(tempmailToAddresses.size()>200)
                     {
                      tempToAddresses200to300.add(tempmailToAddresses[m-1]);
                      System.debug('Email Address number third batch'+ m + 'is:' + tempmailToAddresses[m-1]);
                     }
                     if(m==tempmailToAddresses.size())
                     break;
                    }
                 
                 /*
                  * @ Modified by: Vivek Singh 
                  * @ Reason: Exception comming for Invalid_email_Address
                  * @ Description : null values is comming in all the Lists used for setToAddress.
                  *                 So remove null value
                  * @ Last Modified Date : 10 June 2015 
                  */
                 
                 set<String> tempToAddresses1to100ToRemoveNull = new set<String>();
                 tempToAddresses1to100ToRemoveNull.addAll(tempToAddresses1to100);
                 tempToAddresses1to100ToRemoveNull.remove(null);
                 tempToAddresses1to100.clear();
                 tempToAddresses1to100.addAll(tempToAddresses1to100ToRemoveNull);
                 if(!tempToAddresses1to100.isEmpty())
                  {
                    system.debug('***tempToAddresses1to100*******' + tempToAddresses1to100);
                    email.setToAddresses(tempToAddresses1to100);
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
                  }
                    
                  set<String> tempToAddresses100to200ToRemoveNull = new set<String>();
                  tempToAddresses100to200ToRemoveNull.addAll(tempToAddresses100to200);
                  tempToAddresses100to200ToRemoveNull.remove(null);
                  tempToAddresses100to200.clear();
                  tempToAddresses100to200.addAll(tempToAddresses100to200ToRemoveNull);                  
                  if(!tempToAddresses100to200.isEmpty())
                  {
                    email.setToAddresses(tempToAddresses100to200);
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
                  }
                  
                  set<String> tempToAddresses200to300ToRemoveNull = new set<String>();
                  tempToAddresses200to300ToRemoveNull.addAll(tempToAddresses200to300);
                  tempToAddresses200to300ToRemoveNull.remove(null);
                  tempToAddresses200to300.clear();
                  tempToAddresses200to300.addAll(tempToAddresses200to300ToRemoveNull); 
                  if(!tempToAddresses200to300.isEmpty())
                  {
                    email.setToAddresses(tempToAddresses200to300);
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
                  }
                }    
                else              
                { 
                System.debug('The number of email ids in mailToAddresses: '+mailToAddresses.size()); 
                for(integer k=1;k<100;k++)
                  {
                     mailToAddresses1to100.add(mailToAddresses[k-1]);
                     System.debug('Email Address number first batch '+ k + 'is:' + mailToAddresses[k-1]);
                     if(k==mailToAddresses.size())
                     break;
                  }
                for(integer l=101;l<200;l++)
                    {
                     if(mailToAddresses.size()>100)
                     {
                      mailToAddresses100to200.add(mailToAddresses[l-1]);
                      System.debug('Email Address number second batch'+ l + 'is:' + mailToAddresses[l-1]);
                     }
                     if(l==mailToAddresses.size())
                     break;
                    }
                 for(integer m=201;m<300;m++)
                    {
                     if(mailToAddresses.size()>200)
                     {
                      mailToAddresses200to300.add(mailToAddresses[m-1]);
                      System.debug('Email Address number third batch'+ m + 'is:' + mailToAddresses[m-1]);
                     }
                     if(m==mailToAddresses.size())
                     break;
                    }   
                 
                  set<String> mailToAddresses1to100ToRemoveNull = new set<String>();
                  mailToAddresses1to100ToRemoveNull.addAll(mailToAddresses1to100);
                  mailToAddresses1to100ToRemoveNull.remove(null);
                  mailToAddresses1to100.clear();
                  mailToAddresses1to100.addAll(mailToAddresses1to100ToRemoveNull);
                  if(!mailToAddresses1to100.isEmpty())
                  {
                    email.setToAddresses(mailToAddresses1to100);
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
                  }  
                  
                  set<String> mailToAddresses100to200ToRemoveNull = new set<String>();
                  mailToAddresses100to200ToRemoveNull.addAll(mailToAddresses100to200);
                  mailToAddresses100to200ToRemoveNull.remove(null);
                  mailToAddresses100to200.clear();
                  mailToAddresses100to200.addAll(mailToAddresses100to200ToRemoveNull);
                  if(!mailToAddresses100to200.isEmpty())
                  {
                    email.setToAddresses(mailToAddresses100to200);
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
                  }  
                  
                  set<String> mailToAddresses200to300ToRemoveNull = new set<String>();
                  mailToAddresses200to300ToRemoveNull.addAll(mailToAddresses200to300);
                  mailToAddresses200to300ToRemoveNull.remove(null);
                  mailToAddresses200to300.clear();
                  mailToAddresses200to300.addAll(mailToAddresses200to300ToRemoveNull);  
                  if(!mailToAddresses200to300.isEmpty())
                  {
                    email.setToAddresses(mailToAddresses200to300);
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
                  }  
               // email.setToAddresses(mailToAddresses); 
               
                }
                                             
               //Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
               

            }
            catch(System.DmlException ex)
             {
                ApexPages.addMessages(ex); 
                Result = false;
             }
             return  Result;
       }    
       
       static testMethod void testQIRSBasecontroller()
       {
       String Type='';
       List<Profile> tempprofile = new List<Profile>(); 
         String[] Profile = new String[] {'Nokia QIRS','Nokia QIRS Admin'};
         tempprofile=[SELECT Id,Name from Profile where Name In : Profile];
         List<String> strNSNQIRS =new List<String>();
         for (Integer j=0;j<tempprofile.size();j++)
            {
              strNSNQIRS.add(tempprofile[j].Id);
            }
             List<User> userlist= new List<User>();
             userlist= [select Id,Name from User where  IsActive = true and ProfileId In : strNSNQIRS order by Name]; 
           QIRS__c objqirs = new QIRS__c();
           objqirs.Site1__c = 'Alsdorf';
           objqirs.Process_Owner1__c = userlist[0].Id;           
           objqirs.Business__c = 'Mobile Broadband'; 
           //objqirs.Business__c = 'Networks Systems';           
           objqirs.Business_Group__c = 'CDMA';           
           objqirs.Alert_Type__c = 'NPI Launch Impact';           
           objqirs.Issue_Level__c = 'Launch Delay';                                            
             objqirs.Factory__c ='Berlin';
             objqirs.Problem_Description1__c = 'Mobile Broadband';
          // objqirs.Problem_Description1__c = 'Networks Systems';           
           objqirs.Customer__c = 'CDMA';           
           objqirs.Defective_Part__c = 'Design';           
           objqirs.Symptom__c = 'Hardware';                                            
           objqirs.Projected_Lift_Date__c  =Date.today();        
           
           objqirs.Impacted_Region__c = 'Asia';           
           objqirs.Countries__c = 'China';           
             insert objqirs;   
                List<QIRS__c> lstQirs = new List<QIRS__c>();             
             lstQirs.add(objqirs);      
        
         QIRS_Action_Plan__c objAP = new QIRS_Action_Plan__c();
         objAP.Action_Plan_Counter__c = 1;
         objAP.Action_Type__c = 'Containment';
         objAP.Approver__c = 'TestApp';
         objAP.Approver1__c = UserInfo.getUserId();
         objAP.Approver10__c = UserInfo.getUserId();
         objAP.Approver2__c = UserInfo.getUserId();
         objAP.Approver3__c = UserInfo.getUserId();
         objAP.Approver4__c = UserInfo.getUserId();
         objAP.Approver5__c =UserInfo.getUserId();
         objAP.Approver6__c =UserInfo.getUserId();
         objAP.Approver7__c =UserInfo.getUserId();
         objAP.Approver8__c =UserInfo.getUserId();
         objAP.Approver9__c =UserInfo.getUserId();
         objAP.Champion__c = 'TestChamp';
         objAP.Champion1__c = UserInfo.getUserId();
         objAP.Champion10__c = UserInfo.getUserId();
         objAP.Champion2__c = UserInfo.getUserId();
         objAP.Champion3__c = UserInfo.getUserId();
         objAP.Champion4__c = UserInfo.getUserId();
         objAP.Champion5__c =UserInfo.getUserId();
         objAP.Champion6__c =UserInfo.getUserId();
         objAP.Champion7__c =UserInfo.getUserId();
         objAP.Champion8__c =UserInfo.getUserId();
         objAP.Champion9__c =UserInfo.getUserId();
         objAP.QIRS__c =objqirs.ID;         
         objAP.Task__c ='Test Task';
         objAP.Required_date__c  = Date.Today();  
         objAP.Implementation_Date__c = Date.Today();  
            insert objAP;
                        QIRS_Business_Notification_List__c testobj = new QIRS_Business_Notification_List__c();
            testobj.Alert_Type__c='NPI Launch Impact';
            //testobj.Business__c='Networks Systems';
            testobj.Business__c='Mobile Broadband';
            testobj.Email__c='tejas.kardile1984@gmail.com';
            insert testobj;
            //QIRSBasecontroller controller = new QIRSBasecontroller();
            BaseVarAccpetedByChampion = 'Accepted by Champion';    
            BaseVarPendingforChampion = 'Pending for Champion';    
            BaseVarImplementedbyChampion = 'Implemented by champion';    
            BaseVarQAAlertType = 'Quality Alert';    
            BaseVarSSAlertType = 'Delivery Stop';    
            BaseVarStopBuildIL = 'Stop Production';    
            //BaseVarStopBuildIL = 'Stop build';    
            BaseVarWatchListPublicGroup = 'QIRS_WatchList_Group';    
            BaseVarQIRSAll = 'All';      
            BaseVarQIRSOpen = 'Open';    
            BaseVarQIRSClosed = 'Closed';    
            //BaseVarQIRSLifted = 'Lifted'; 
            BaseVarQIRSLifted = 'Released';                
            BaseVarQIRSSubmitForApproval = 'Submitted to Master Approval';   
            BaseVarQIRSResolutionIdentified = 'Resolution Identified / Awaiting for approval';   
            BaseVarQIRSAPOpen = 'Open';    
            BaseVarQIRSAPClosed = 'Closed';    
            BaseVarQIRSAPRejected = 'Rejected';  
            BaseVarContainmentActionType = 'Containment';    
            BaseVarRootCauseActionType = 'Root Cause/Escape Point Analysis';    
            BaseVarCorrectiveActionType = 'Corrective';    
            BaseVarPreventiveActionType = 'Preventive';    
            BaseVarQIRSIssueLevelemerging = 'Critical'; 
            //BaseVarQIRSIssueLevelemerging = 'Emerging'; 
            getBusinessList(true);
            getBusinessGrpList();
            getAPStatus();
            getActionPlanStatus();
            getSitesList(true);    
            getAlertTypesList(true);         
            getStatusList(true);  
            
            getSitesList(false);    
            getAlertTypesList(false);         
            getStatusList(false);  
            getBusinessList(false);     
            getProcessOwnersList();
            getQIRSActionplanItem();         
            getProductName(lstQirs);       
            getAPColorCode(lstQirs);
            QIRSBodyFormat(lstQirs,Type);
            ActionPlanBodyFormat(objqirs.id);
            BodyFormat(lstQirs,'Open');       
            BodyFormat(lstQirs,'Create');       
            BodyFormat(lstQirs,'Released'); 
            BodyFormat(lstQirs,'Closed');       
            BodyFormat(lstQirs,'Canceled');       
            BodyFormat(lstQirs,'ReOpen');
             List<QIRS_Action_Plan__c> lstap = new List<QIRS_Action_Plan__c>();
             lstap.add(objAP);
             SendEmail(null, objqirs.Business__c,objqirs.Alert_Type__c,objqirs.Business_Group__c,
              'Open',objqirs.id);  
              SendEmail(null, objqirs.Business__c,objqirs.Alert_Type__c,objqirs.Business_Group__c,
              'Canceled',objqirs.id);  
              List<String> mailToAddresses = new List<String>();
               List<String> tempmailToAddresses = new List<String>(); 
               //mailToAddresses.add('tejas.kardile1984@gmail.com');
              // tempmailToAddresses.add('tejas.kardile1984@gmail.com');
              //SendEmail(null, objqirs.Business__c,objqirs.Alert_Type__c,objqirs.Business_Group__c,
              //'Rejected',objqirs.id);  
              getProductPN(lstQirs);          
            //BodyFormat();            
            //getProductName(List<QIRS__c> lstQirs);       
            //getAPColorCode(List<QIRS__c> lstQirs);
            //String QIRSBodyFormat(List<QIRS__c> lst);
            //String ActionPlanBodyFormat(String QIRSID);
            //String BodyFormat(List<QIRS__c> lst,String Type)            
            //boolean SendEmail(List<String> Site, String Business,
               // String AlertType,String BusinessGroup, String NotificationType,String Targetid)            
        }
        
        @TestVisible private static list<String> checkAndReturnAdditionalEmailList(String additionalEmails,Pattern emailPatternFormat){
            list<String> addEmailList = new list<String>();
            list<String> tempAddmailList = additionalEmails.split(';');
            for(String str : tempAddmailList){
                str = str.trim();
                Matcher emailMatcher = emailPatternFormat.matcher(str);
                if(emailMatcher.matches()) addEmailList.add(str);
            }
            return addEmailList;
        }    
}