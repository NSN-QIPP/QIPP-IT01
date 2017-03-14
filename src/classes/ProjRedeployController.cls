public with sharing class ProjRedeployController{
    
    public Integer RedepRowNum {get;set;}
    public List<Project_Redeployed__c> projredepAddList{get;set;}
    public List<Project_Redeployed__c> projredepDelList{get;set;}
    public List<Project_Redeployed__c> projectselectbbg{get;set;}
    public Integer projredepRowNum {get;set;}
    public boolean displayPopupprojredepDist{get;set;}
    public boolean projredepErrorMessages{get;set;}
    public boolean projectErrorMessages{get;set;}
    public String projID{get;set;}
    public Integer RedepselectRowNum{get;set;}
    public QIPP_Project__c projectrec{get;set;}
    public List<QIPP_Project__c> projlist; 
    public String projredepdesc{get;set;}
    
    public ProjRedeployController(ApexPages.StandardController stdController){ 
        this.projectrec= (QIPP_Project__c)stdController.getRecord();                
        projID = projectrec.id;
        projectselectbbg = [select id from Project_Redeployed__c where Project__c=:projID];
        RedepselectRowNum = projectselectbbg.size();
        projectrec = [SELECT Id, Name, Can_Project_Redeployed__c,Project_Redeloy_Description__c FROM QIPP_Project__c WHERE Id =: projID];
        system.debug('projectrec::::'+projectrec);
       }

    public List<Project_Redeployed__c> getprojectredeplist(){
       // string projectid1 = projID;    // ApexPages.currentPage().getParameters().get('id');
        list<Project_Redeployed__c> projectbbg = [select id,name,Project__c,Benefitting_Business_Grp_Functional_Grp__c,Benefitting_Business_Unit__c from Project_Redeployed__c where Project__c=:projID];
        RedepRowNum = projectbbg.size();
        return projectbbg;
    }
     
    public void projredepDistribution(){
       
        projectrec = [SELECT Id, Name,Can_Project_Redeployed__c, Project_Redeloy_Description__c FROM QIPP_Project__c WHERE Id =: projID];
        projredepdesc= projectrec.Project_Redeloy_Description__c;
        projredepAddList = new List<Project_Redeployed__c>();  
        projredepDelList = new List<Project_Redeployed__c>();
        list<Project_Redeployed__c> projredep = new list<Project_Redeployed__c>();
        projredep =[select id,name,Project__c,Benefitting_Business_Grp_Functional_Grp__c,Benefitting_Business_Unit__c from Project_Redeployed__c where Project__c=:projID];
       
        if(projredep.size() >0){
                projredepAddList.addall(projredep);
                projredepRowNum = projredep.size();
                }
        displayPopupprojredepDist= true;
   
       }
    
    public void showPopupRedepDist() {       
            displayPopupprojredepDist= true;
        }

    public PageReference closePopupredepDist(){       
        displayPopupprojredepDist= false; //To hide confirmation popup for submitting approval process
        PageReference projectdetailpage = ApexPages.currentPage(); 
        projectdetailpage.setRedirect(true);
        return projectdetailpage ;
    }
    
    public void addRedepRowDist(){
        projredepAddList.add(new Project_Redeployed__c(Project__c=projID));
    }
    
    public PageReference delRedepRowDist(){
        try{
                projredepRowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
                system.debug('*** Index = '+projredepRowNum);
                projredepDelList.add(projredepAddList.get(projredepRowNum));
                projredepAddList.remove(projredepRowNum);
           }
        catch (Exception e){}
     return null;
       
    }
    
     public List<SelectOption> getProjectredepValues(){
        try{
            List<SelectOption> projredep_optns = new List<Selectoption>();
            Schema.DescribeFieldResult fieldResult = QIPP_Project__c.Can_Project_Redeployed__c.getDescribe();
            List<Schema.PicklistEntry> qap = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry f : qap)
            {
                projredep_optns.add(new SelectOption(f.getLabel(), f.getValue()));
            }     
            return projredep_optns;
        }catch(Exception exe){return null;}
    }
    
    
    public PageReference saveProjRedep(){
        projredepErrorMessages = false;
        boolean flag =false;
        Map<String,String> bbgmap = new Map<String,String>();
        Map<String,String> bbgmbu = new Map<String,String>();
        Map<String,String> bbgnmbu = new Map<String,String>();
        String key_bbg = '';
        String key_bgnbu = '';
        String key_bgbu = '';
      
        // Start:Validations 
      
        try{
             if((projectrec.Project_Redeloy_Description__c =='1800 Character Limit' || projectrec.Project_Redeloy_Description__c == null || projectrec.Project_Redeloy_Description__c == '') && (projectrec.Can_Project_Redeployed__c == 'Yes')){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Project Redeploy Description: Please enter the value.'));
             flag =true;
             }
        
            if((projectrec.Can_Project_Redeployed__c == 'Yes')&&(projredepAddList.size()<=0))
            {
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please Enter atleast one Business Group'));
                 flag =true;
            }
            
             if((projectrec.Can_Project_Redeployed__c == 'Yes'))
             {
            
             
                For(Project_Redeployed__c mulbbg :projredepAddList)
                {                  
               
                //if(mulbbg.Benefitting_Business_Grp_Functional_Grp__c !='Global'){
                if(mulbbg.Benefitting_Business_Grp_Functional_Grp__c != null &&( mulbbg.Benefitting_Business_Unit__c == null ) )
                    {
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter values for all fields.')); 
                        flag =true; 
                    }
                if(mulbbg.Benefitting_Business_Unit__c == null && mulbbg.Benefitting_Business_Grp_Functional_Grp__c == null)
                    {
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter values for all fields.')); 
                        flag =true; 
                    }
                
                if((mulbbg.Benefitting_Business_Grp_Functional_Grp__c == null || mulbbg.Benefitting_Business_Unit__c == null) )
                    {
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter values for all fields.')); 
                        flag =true; 
                    } 
                                           
                if(mulbbg.Benefitting_Business_Unit__c!='Multiple BUs')
                    {
                        key_bgnbu = mulbbg.Benefitting_Business_Grp_Functional_Grp__c+'Multiple BUs';
                        if(bbgmbu.containsKey(key_bgnbu))
                            {   
                                 ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'One of the Business Group already associated to "Multiple Business Unit", You cannot Add "Business Unit" for the same Business Group associated to "Multiple Business Unit"')); 
                                 flag =true; 
                            }
                    }
                        
                key_bbg = mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c;
                if(bbgmap.containsKey(key_bbg))
                    {
                         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Delete or Modify the duplicate row.')); 
                        flag =true;
                     }    
                    
                if(mulbbg.Benefitting_Business_Unit__c=='Multiple BUs')
                    {
                            key_bgbu = mulbbg.Benefitting_Business_Grp_Functional_Grp__c;
                            if(bbgnmbu.containsKey(key_bgbu))
                            {
                                 if(flag ==false)
                                 {
                                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'One of the Business Group already associated to another Business Unit, You cannot Add "Multiple Business Unit" for the same Business Group')); 
                                    flag =true; 
                                 }
                            }
                    } 
                    
                if(mulbbg.Benefitting_Business_Grp_Functional_Grp__c!=null && mulbbg.Benefitting_Business_Unit__c!=null )
                    {
                        bbgmap.put(mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c,'0');
                    }
                   
                if((mulbbg.Benefitting_Business_Grp_Functional_Grp__c =='Global')&&((projredepAddList.size()>1)))
                    {
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Delete or Modify the Global Business Group.')); 
                        flag =true;   
                    }
                        bbgmap.put(mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c,'0');
                        bbgmbu.put(mulbbg.Benefitting_Business_Grp_Functional_Grp__c+mulbbg.Benefitting_Business_Unit__c,'0');
                        bbgnmbu.put(mulbbg.Benefitting_Business_Grp_Functional_Grp__c,'0');
                }
        }    
          
            //End::Bbg Validations
            if(flag == true){
                
               projectErrorMessages= false;
               projredepErrorMessages = true;
               }   
          
            if(flag == false){
            
                //prdErrorMessages = false;
                list<Project_Redeployed__c> MultiBbgadd = new list<Project_Redeployed__c>();
                list<Project_Redeployed__c> MultiBbgdel = new list<Project_Redeployed__c>();
                
                projlist = [select Can_Project_Redeployed__c, Project_Redeloy_Description__c from QIPP_Project__c where id=:projID];
                system.debug('projectrec.Project_Redeloy_Description__c::::'+projectrec.Project_Redeloy_Description__c);
                 if(projlist.size() > 0) {
                    for(QIPP_Project__c prdl : projlist){
                        prdl.Project_Redeloy_Description__c=projectrec.Project_Redeloy_Description__c;
                        prdl.Can_Project_Redeployed__c=projectrec.Can_Project_Redeployed__c;
                    }
                 }
                
              //  projlist[0].Project_Redeloy_Description__c=projectrec.Project_Redeloy_Description__c;
                //projlist[0].Can_Project_Redeployed__c=projectrec.Can_Project_Redeployed__c;
                //projectrec.Project_Redeloy_Description__c= projlist[0].Project_Redeloy_Description__c;
                system.debug('projlist.Project_Redeloy_Description__c::::'+projlist[0].Project_Redeloy_Description__c);
                
                List<QIPP_Project__c> update_proj_BBG = new List<QIPP_Project__c>();
                
                for(QIPP_Project__c pj: projlist){
                     update_proj_BBG.add(pj);}
                     
               
                MultiBbgdel.addall(projredepDelList);
                MultiBbgadd.addall(projredepAddList);
               
                if(MultiBbgdel != null || MultiBbgdel.size() > 0){
                    try{
                    Delete MultiBbgdel;
                    }catch(Exception e){}
                    projredepDelList.clear();                
                }
                if(MultiBbgadd != null || MultiBbgadd.size() > 0){
                    if(MultiBbgadd.size()<21){
                    Upsert MultiBbgadd;
                    update update_proj_BBG;
                    projredepAddList.clear();
                    
                    }
                    else{
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Amount cannot be Distibuted to more than 20 Business Units.')); 
                    projredepErrorMessages = true;
                    return null;
                    }
                    
                } 
                
                 if(projectrec.Can_Project_Redeployed__c=='No')
                    {
                       Delete MultiBbgadd;
                       projlist = [select Project_Redeloy_Description__c,Redeployment_Business_Groups__c,Redeployment_Business_Units__c from QIPP_Project__c where id=:projID];
                       //projlist[0].Project_Redeloy_Description__c='';
                      // projectrec.Project_Redeloy_Description__c= '';
                       projlist[0].Redeployment_Business_Groups__c= '';
                       projlist[0].Redeployment_Business_Units__c= '';
                       projlist[0].Project_Redeloy_Description__c='';
                       update projlist;
                    }
                PageReference obj = null;
                displayPopupprojredepDist= false;
               }           
        }catch(Exception exe){
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Redepoyment Details Cannot be Saved,Please Contact Your System Administrator.'));
            projredepErrorMessages = true;
           return null;
        }  
        return null;
		
    }    
}