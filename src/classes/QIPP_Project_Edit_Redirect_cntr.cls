public with sharing class QIPP_Project_Edit_Redirect_cntr {
    public String refererStr{get;set;}
    public boolean blockeditpage{get;set;}
    public QIPP_Project__c prj{get;set;}
    public String errormessage{get;set;}
    //public boolean recIsLocked{get;set;}
    
    public QIPP_Project_Edit_Redirect_cntr(ApexPages.StandardController controller) {
        refererStr = ApexPages.currentPage().getHeaders().get('Referer');
        blockeditpage =false;
        //recIsLocked =false;
        //prj = new QIPP_Project__c;
    }
    public pagereference Redirect(){
        try{
            string rolename='';
            //public string profilename;
            string  profilename =  [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1].name;
            //profilename = profilena.Name;
            if(UserInfo.getUserRoleId()!= null){
                userrole rolenames = [SELECT Id, Name FROM userrole WHERE Id=:UserInfo.getUserRoleId() LIMIT 1];
                rolename = rolenames.Name;
            }                
            prj = [select id,name,RecordType.Name,Project_Type__c,Project_State__c,Project_Number__c  from QIPP_Project__c where id=:ApexPages.currentPage().getParameters().get('id')];
            //recordIsLocked(prj.id);
            //******************************// 
            if(!recordIsLocked(prj.id)){
                if(profilename == 'Nokia QIPP Project Viewer'){
                    blockeditpage = true;
                    errormessage = 'You don\'t have access to edit Complete/Close records.';
                }else if((prj.Project_State__c == 'Complete' || prj.Project_State__c =='Closed') && (rolename == 'QIPP Project Lead')) {
                    blockeditpage = true;
                    errormessage = 'You don\'t have access to edit Complete/Close records.';
                }else if(prj.Project_State__c =='Closed' && (rolename == 'QIPP Portfolio Owner')) {
                    blockeditpage = true;
                    errormessage = 'You don\'t have access to edit Close records.';
                }
                //else if(prj.Project_State__c =='Complete' && (rolename == 'QIPP Portfolio Owner')) {
                //	blockeditpage = true;
                //}
                /*
                If(blockeditpage){
                	errormessage = 'You don\'t have access to edit Complete/Close records';
                }
*/
            }else{
                blockeditpage = true;
                errormessage = 'You don\'t have access to edit lock records';
            }
            
            //************************//	
            
            if(blockeditpage){
                return null;
            }    
            
            PageReference pageref ;
            string saveURL = '/apex/QIPP_Project_View_Redirect?id='+prj.id;
            string editRedirectpage ='';
            
            If(prj.RecordType.Name == 'Methodology: DMAIC / DMADV' || prj.RecordType.Name == 'Methodology: After QIPP DMAIC Define' || prj.RecordType.Name == 'Methodology: After DMAIC Improve' || prj.RecordType.Name == 'Methodology: After DMAIC Measure' || prj.RecordType.Name == 'Methodology: After QIPP DMAIC Analyze' || prj.RecordType.Name == 'Methodology: After QIPP DMAIC Control / Verify' || prj.RecordType.Name == 'Methodology: After DMAIC Project Initiation'){
                editRedirectpage = '/apex/QIPPProjectEditView?id=';
            }else If(prj.RecordType.Name == 'Methodology: Lean (including Kaizen)' ){
                editRedirectpage = '/apex/QIPPLeanProjectEditView?id=';
            }else If(prj.RecordType.Name == 'Methodology: DI Logic' || prj.RecordType.Name == 'Methodology : DI 4 Logic' || prj.RecordType.Name == 'Methodology: DI5 Logic' || prj.RecordType.Name == 'Methodology: DI Final Logic' ){
                editRedirectpage = '/apex/QIPP_DI_logic_Edit_View?id=';
            }else If(prj.RecordType.Name == 'Methodology: CIF' ){
                editRedirectpage = '/apex/QIPPCIFProjectEditView?id=';
            }else If(prj.RecordType.Name == 'Methodology: A3' ){
                editRedirectpage = '/apex/QIPPA3ProjectEditView?id=';
            }else If(prj.RecordType.Name == 'Methodology: 8D' ){
                editRedirectpage = '/apex/QIPP8DProjectEditView?id=';
            }else If(prj.RecordType.Name == 'Methodology: RCA/EDA' ){
                editRedirectpage = '/apex/QIPPRCAEDAProjectEditView?id=';
            }else If(prj.RecordType.Name == 'Methodology: Other Methodology' ){
                editRedirectpage = '/apex/QIPPOtherProjectEditView?id=';
            }
            //Redirecting 
            if(editRedirectpage == ''){
                pageref = new PageReference('/'+prj.id+'/e?');
                pageref.getParameters().put('nooverride', '1');
                //pageref.getParameters().put('retURL', prj.id);
                //https://cs22.salesforce.com/a1817000000icUZ/e?retURL=%2Fa1817000000icUZ
            }else{
                pageref = new PageReference(editRedirectpage+prj.id);
            }
            pageref.getParameters().put('retURL',refererStr);
            pageref.getParameters().put('saveURL',saveURL);
            pageref.setRedirect(true);
            return pageref;
        }catch(Exception e){
            System.Debug('Exception :'+e.getMessage());
            return null;
        }
    }
    public PageReference previouspage(){
        PageReference pageref = new PageReference('/'+ApexPages.currentPage().getParameters().get('retURL'));
        //pageref.getParameters().put('nooverride', '1');
        pageref.setRedirect(true);
        return pageref;		
    }
    public PageReference prjdetailpage(){
        PageReference pageref = new PageReference('/'+prj.id);
        //pageref.getParameters().put('nooverride', '1');
        pageref.setRedirect(true);
        return pageref;		
    }
    public Boolean recordIsLocked(ID projId){
        //ID recId = prj.id;
        Boolean recIsLocked = Approval.isLocked(projId);
        System.Debug('recIsLocked : '+recIsLocked );
        return recIsLocked;
    }
}