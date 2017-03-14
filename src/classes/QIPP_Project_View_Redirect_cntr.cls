public with sharing class QIPP_Project_View_Redirect_cntr {
public String refererStr{get;set;}
public PageReference pageref{get;set;}
    public QIPP_Project_View_Redirect_cntr(ApexPages.StandardController controller) {
        refererStr = ApexPages.currentPage().getHeaders().get('Referer');
    }
    
    public pagereference Redirect(){
        try{
            QIPP_Project__c prj = [select id,name,RecordType.Name,Project_Type__c from QIPP_Project__c where id=:ApexPages.currentPage().getParameters().get('id')];
            PageReference pageref ;
            string detailviewRedirectpage ='';
            If(prj.RecordType.Name == 'Methodology: DMAIC / DMADV' || prj.RecordType.Name == 'Methodology: After QIPP DMAIC Define' || prj.RecordType.Name == 'Methodology: After DMAIC Improve' || prj.RecordType.Name == 'Methodology: After DMAIC Measure' || prj.RecordType.Name == 'Methodology: After QIPP DMAIC Analyze' || prj.RecordType.Name == 'Methodology: After QIPP DMAIC Control / Verify' || prj.RecordType.Name == 'Methodology: After DMAIC Project Initiation'){
            detailviewRedirectpage = '/apex/QIPPProjectDetailView?id=';
            }else If(prj.RecordType.Name == 'Methodology: Lean (including Kaizen)' ){
                detailviewRedirectpage = '/apex/QIPPLeanProjectDetailView?id=';
            }else If(prj.RecordType.Name == 'Methodology: DI Logic' || prj.RecordType.Name == 'Methodology : DI 4 Logic' || prj.RecordType.Name == 'Methodology: DI5 Logic' || prj.RecordType.Name == 'Methodology: DI Final Logic' ){
            detailviewRedirectpage = '/apex/QIPP_DI_logic_Detail_View?id=';
            }else If(prj.RecordType.Name == 'Methodology: CIF' ){
                detailviewRedirectpage = '/apex/QIPPCIFProjectDetailView?id=';
            }else If(prj.RecordType.Name == 'Methodology: A3' ){
                detailviewRedirectpage = '/apex/QIPPA3ProjectDetailView?id=';
            }else If(prj.RecordType.Name == 'Methodology: 8D' ){
                detailviewRedirectpage = '/apex/QIPP8DProjectDetailView?id=';
            }else If(prj.RecordType.Name == 'Methodology: RCA/EDA' ){
                detailviewRedirectpage = '/apex/QIPPRCAEDAProjectDetailView?id=';
            }else If(prj.RecordType.Name == 'Methodology: Other Methodology' ){
                detailviewRedirectpage = '/apex/QIPPOtherProjectDetailView?id=';
            }
            //Redirecting 
            if(detailviewRedirectpage == ''){
                pageref = new PageReference('/'+prj.id);
                pageref.getParameters().put('nooverride', '1');
            }else{
                pageref = new PageReference(detailviewRedirectpage+prj.id);
            }
            pageref.getParameters().put('retURL',refererStr);
            pageref.setRedirect(true);
            return pageref;
       }catch(Exception e){
           //pageref = Page.QIPP_project_home;
           //pageref.setredirect(true);
           System.Debug('Exception :'+e.getMessage());
           return null;
      }
    }
    
    public pagereference BenfitRedirect(){
        try{
            QIPP_Benefit__c benfprj=[select id,Project_ID__c from QIPP_Benefit__c  where id=:ApexPages.currentPage().getParameters().get('id')];
            QIPP_Project__c prj = [select id,name,RecordType.Name,Project_Type__c from QIPP_Project__c where id=:benfprj.Project_ID__c];
            PageReference pageref ;
            string detailviewRedirectpage ='';
            If(prj.RecordType.Name == 'Methodology: DMAIC / DMADV' || prj.RecordType.Name == 'Methodology: After QIPP DMAIC Define' || prj.RecordType.Name == 'Methodology: After DMAIC Improve' || prj.RecordType.Name == 'Methodology: After DMAIC Measure' || prj.RecordType.Name == 'Methodology: After QIPP DMAIC Analyze' || prj.RecordType.Name == 'Methodology: After QIPP DMAIC Control / Verify' || prj.RecordType.Name == 'Methodology: After DMAIC Project Initiation'){
            detailviewRedirectpage = '/apex/QIPPProjectDetailView?id=';
            }else If(prj.RecordType.Name == 'Methodology: Lean (including Kaizen)' ){
                detailviewRedirectpage = '/apex/QIPPLeanProjectDetailView?id=';
            }else If(prj.RecordType.Name == 'Methodology: DI Logic' || prj.RecordType.Name == 'Methodology : DI 4 Logic' || prj.RecordType.Name == 'Methodology: DI5 Logic' || prj.RecordType.Name == 'Methodology: DI Final Logic' ){
            detailviewRedirectpage = '/apex/QIPP_DI_logic_Detail_View?id=';
            }else If(prj.RecordType.Name == 'Methodology: CIF' ){
                detailviewRedirectpage = '/apex/QIPPCIFProjectDetailView?id=';
            }else If(prj.RecordType.Name == 'Methodology: A3' ){
                detailviewRedirectpage = '/apex/QIPPA3ProjectDetailView?id=';
            }else If(prj.RecordType.Name == 'Methodology: 8D' ){
                detailviewRedirectpage = '/apex/QIPP8DProjectDetailView?id=';
            }else If(prj.RecordType.Name == 'Methodology: RCA/EDA' ){
                detailviewRedirectpage = '/apex/QIPPRCAEDAProjectDetailView?id=';
            }else If(prj.RecordType.Name == 'Methodology: Other Methodology' ){
                detailviewRedirectpage = '/apex/QIPPOtherProjectDetailView?id=';
            }
            //Redirecting 
            if(detailviewRedirectpage == ''){
                pageref = new PageReference('/'+prj.id);
                pageref.getParameters().put('nooverride', '1');
            }else{
                pageref = new PageReference(detailviewRedirectpage+prj.id);
            }
            pageref.getParameters().put('retURL',refererStr);
            pageref.setRedirect(true);
            return pageref;
       }catch(Exception e){
           //pageref = Page.QIPP_project_home;
           //pageref.setredirect(true);
           System.Debug('Exception :'+e.getMessage());
           return null;
      }
    }
    
    
}