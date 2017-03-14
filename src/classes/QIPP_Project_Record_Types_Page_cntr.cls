public class QIPP_Project_Record_Types_Page_cntr { 
    public string RecordTypeID {get ; set ;}
    public QIPP_Portfolio__c Prtf;
    //public map<string,id> mry1 = new map<string,id>();
    //public map<string,string> mry2 = new map<string,string>();
    public list<RecordType> ry {get ; set ;}
    public id Portfolioid;
    public String rec_typeID{get;set;}
    public String refererStr;
    //public string cancelurl1;
    public string returl;
    //public string saveNewURL;
    public string urlfrom;
    
    public QIPP_Project_Record_Types_Page_cntr(ApexPages.StandardController controller) {
        refererStr = ApexPages.currentPage().getHeaders().get('Referer');
        //cancelurl1 = ApexPages.currentPage().getParameters().get('cancelURL');
        retURL = ApexPages.currentPage().getParameters().get('retURL');        
        //saveNewURL = ApexPages.currentPage().getParameters().get('save_new_url');
        
        urlfrom = System.currentPageReference().getParameters().get('urlfrom');
        system.debug('refererStr***'+refererStr);
        //system.debug('cancel URL***'+cancelurl1);
        system.debug('retURL***'+retURL);
        system.debug('urlfrom***'+urlfrom);
        //system.debug('saveNewURL***'+saveNewURL);
        //Portfolioid = ApexPages.currentPage().getParameters().get('id');
        ry = [SELECT Id, Name,Description FROM RecordType WHERE sObjectType = 'QIPP_Project__c' and Name in('Methodology: 8D','Methodology: A3','Methodology: CIF','Methodology: DI Logic','Methodology: DMAIC / DMADV','Methodology: Lean (including Kaizen)','Methodology: Other Methodology','Methodology: RCA/EDA')];
        Portfolioid = System.currentPageReference().getParameters().get('Portfolioid');        
        system.debug('Portfolio ID ::: '+Portfolioid);
        if(Portfolioid != null){
            Prtf = [SELECT Id, Name,X8D__c,A3__c,CIF__c,DI_CoPQ__c,DMAIC_DMADV__c,Lean_including_Kaizen__c,Other__c,RCA_EDA__c FROM QIPP_Portfolio__c WHERE Id = :Portfolioid];
            system.debug('QIPP_Portfolio'+Prtf);
            list<string> portrecordtype = new list<string>();                 
            if(Prtf.A3__c == true){
               portrecordtype.add('Methodology: A3');
            }
            if(Prtf.X8D__c == true){
                portrecordtype.add('Methodology: 8D');
            }  
            if(Prtf.CIF__c == true){
                portrecordtype.add('Methodology: CIF');
            }
            if(Prtf.DI_CoPQ__c == true){
                portrecordtype.add('Methodology: DI Logic');
            }
            if(Prtf.DMAIC_DMADV__c == true){
                portrecordtype.add('Methodology: DMAIC / DMADV');
            }
            if(Prtf.Lean_including_Kaizen__c== true){
                portrecordtype.add('Methodology: Lean (including Kaizen)');
            }
            if(Prtf.Other__c == true){
                portrecordtype.add('Methodology: Other Methodology');
            }
            if(Prtf.RCA_EDA__c == true){
                portrecordtype.add('Methodology: RCA/EDA');
            }
            //added by Rajesh
            //portrecordtype.add('Dummy Record Type');
            
            ry = [SELECT Id, Name,Description FROM RecordType WHERE sObjectType = 'QIPP_Project__c' and Name in:portrecordtype];
        }
    }
    
    public PageReference Createpage(){
        Schema.DescribeSObjectResult R = QIPP_Project__c.SObjectType.getDescribe();// Add /o to end of URL to view recent
        rec_typeID = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get(RecordTypeID).getRecordTypeId();
        PageReference pageref ;
        string newprojectRedirectpage ='';
        If(RecordTypeID == 'Methodology: DMAIC / DMADV'){
            newprojectRedirectpage = '/apex/QIPPProjectEditView?retURL=%2F';
        }else If(RecordTypeID == 'Methodology: Lean (including Kaizen)' ){
            newprojectRedirectpage = '/apex/QIPPLeanProjectEditView?retURL=%2F';
        }else If(RecordTypeID == 'Methodology: DI Logic'){
        newprojectRedirectpage = '/apex/QIPP_DI_logic_Edit_View?retURL=%2F';
        }else If(RecordTypeID == 'Methodology: CIF' ){
            newprojectRedirectpage = '/apex/QIPPCIFProjectEditView?retURL=%2F';
        }else If(RecordTypeID == 'Methodology: A3' ){
            newprojectRedirectpage = '/apex/QIPPA3ProjectEditView?retURL=%2F';
        }else If(RecordTypeID == 'Methodology: 8D' ){
            newprojectRedirectpage = '/apex/QIPP8DProjectEditView?retURL=%2F';
        }else If(RecordTypeID == 'Methodology: RCA/EDA' ){
            newprojectRedirectpage = '/apex/QIPPRCAEDAProjectEditView?retURL=%2F';
        }else If(RecordTypeID == 'Methodology: Other Methodology' ){
            newprojectRedirectpage = '/apex/QIPPOtherProjectEditView?retURL=%2F';
        }


        //Redirecting 
        if(newprojectRedirectpage == ''){
            if(Portfolioid != null){
                pageref = new PageReference('/' + R.getKeyPrefix() + '/e?CF00NU0000003NgvU='+ Prtf.name +'&retURL=%2F' + Prtf.id + '&RecordType='+ rec_typeID);
                pageref .getParameters().put('nooverride', '1');
                pageref .getParameters().put('cancelURL','/'+Portfolioid);
            }else{
                pageref = new PageReference('/' + R.getKeyPrefix() + '/e?RecordType='+ rec_typeID );
                pageref.getParameters().put('nooverride', '1');
                if(urlfrom == 'home'){
                    pageref .getParameters().put('cancelURL','/home/home.jsp');
                }else{
                    pageref .getParameters().put('cancelURL',refererStr);
                }   
            }   
        }else{
            pageref = new PageReference(newprojectRedirectpage + R.getKeyPrefix() +'%2fo&RecordType='+ RecordTypeID );
            if(Portfolioid != null){
                //pageref = new PageReference(newprojectRedirectpage + R.getKeyPrefix() +'%2fo&RecordType='+ RecordTypeID );
                pageref.getParameters().put('cancelURL','/'+Portfolioid);
                pageref.getParameters().put('currPortfolio',Portfolioid);
            }else{
                //page = new PageReference(newprojectRedirectpage+ R.getKeyPrefix() +'%2fo&RecordType='+ RecordTypeID );
                if(urlfrom == 'home'){
                    pageref.getParameters().put('cancelURL','/home/home.jsp');
                }else{
                    pageref.getParameters().put('cancelURL',refererStr);
                }               
            }
            
        }
        return pageref;
    }
    /*
    public PageReference Cancle(){
        if(Portfolioid != null){
            PageReference page = new PageReference('/'+Portfolioid);
            return page;
        }
        else{
            Schema.DescribeSObjectResult R = QIPP_Project__c.SObjectType.getDescribe();// Add /o to end of URL to view recent
            //PageReference page = new PageReference('/apex/QIPP_project_home');
            PageReference page = new PageReference(refererStr);
            //PageReference page = new PageReference('/' + R.getKeyPrefix()+'/o');// redirect to project tab/recent list            
            return page;
        }
    }
    */
}