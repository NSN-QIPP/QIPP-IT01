public class SPE_ConsequenceMgmtExt {
  public List<SelectOption> options {get;set;}
  public string selectedValue {get;set;}
  public SPE_ConsequenceManagement__c cmObj{get;set;}
  public Database.SaveResult srList;
  private String supplierId;
  private Apexpages.Standardcontroller stdCon; 
   
  public SPE_ConsequenceMgmtExt (Apexpages.Standardcontroller st){
        stdCon = st;
        this.cmObj= (SPE_ConsequenceManagement__c)st.getRecord();
        supplierId = ApexPages.currentPage().getParameters().get('supplierId');
        options = new List<SelectOption>();
        options.add(new SelectOption('Audit NC','Audit NC'));
        options.add(new SelectOption('Develop','Develop'));
        options.add(new SelectOption('Phase Out','Phase Out'));  
        options.add(new SelectOption('Watchlist','Watchlist'));  
   } 
   
    public PageReference doCancel(){
        if(supplierId==null && ApexPages.currentPage().getParameters().get('recordTypeId') == null){
            return stdCon.cancel();
        }
        else if(supplierId==null){   
            PageReference pg = new PageReference(ApexPages.currentPage().getParameters().get('retURL'));
            return pg;
        }
        else{  
            PageReference pg= Page.SPE_TrackerView;
            pg.getParameters().put('id',cmObj.SPETracker__c);
            return pg ;
        }
    }
   
  public pagereference redirect(){
      if(!String.isBlank(selectedValue) && selectedValue !='Audit NC'){
          PageReference pageRef = new PageReference('/apex/SPE_ConsequenceManagementMainPage?recordTypeId='+selectedValue+'&isEdit=false');
          pageRef.setredirect(true);
          return pageRef ; 
          }
      
      if (!String.isBlank(selectedValue) && selectedValue =='Audit NC'){
          PageReference pageRef = new PageReference('/apex/SPE2_AuditNC_CM?recordTypeId='+selectedValue+'&isEdit=false');
          pageRef.setredirect(true);
          return pageRef ; 
      } 
      return null;
  }
   

}