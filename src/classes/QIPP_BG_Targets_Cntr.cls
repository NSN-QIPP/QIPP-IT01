public with sharing class QIPP_BG_Targets_Cntr {
    public string Years;
    public String selectedYear {get; set;}
    public boolean currentyear{get; set;}
    public boolean errorflag ;
    Map<String,String> Bgyear; 
    public boolean isedit{get; set;}
    public boolean issave{get; set;}
    public boolean editblock{get; set;}
    public boolean viewblock{get; set;}
    public list<BG_Targets__c> BGtargets{get;set;}
    public list<BG_Targets__c> BGtargetsDelList;
    
    
    public Integer rowNum  {Set;get;}
    
    public QIPP_BG_Targets_Cntr(){
        selectedYear = String.valueOf(System.Today().year());
        currentyear = true;
        BGtargets = [select id,Business_Group__c,Total_Target__c,P1__c,P2__c,P3__c,P4__c,P5__c,P6__c,P7__c,P8__c,P9__c,P10__c,P11__c,P12__c,Year__c from BG_Targets__c where Year__c =: selectedYear];
        system.debug('BGtargets Size'+BGtargets.size());
        if(BGtargets.size() > 0 ){
            rowNum= BGtargets.size();
            isedit = true;
            issave = false;
            editblock = false;
            system.debug('BGtargets found'+BGtargets.size());
        }
        else{
            isedit = true;
            //BGtargets.add(new BG_Targets__c(year__c = selectedYear));
            //rowNum=1;
            //isedit = false;
            //editblock = true;
            //issave = true;
            system.debug('BGtargets not found'+BGtargets.size());
        }
        //getbgtargets();
        system.debug('rowNum'+rowNum);
        system.debug('BGtargets ***'+BGtargets);
        system.debug('BGtargets size'+BGtargets.size());
        
        BGtargetsDelList = new list<BG_Targets__c>();
    }
    public List<SelectOption> getYears() {
        List<SelectOption> options = new List<SelectOption>();
        for (Integer i = 2015; i < System.Today().year() + 1; i++) {
            options.add(new SelectOption(String.valueOf(i), String.valueOf(i)));
        }
        return options;
    }
    Public list<BG_Targets__c> getbgtargets(){
        if(String.valueOf(System.Today().year()) == selectedYear){
            BGtargets = [select id,Business_Group__c,Total_Target__c,P1__c,P2__c,P3__c,P4__c,P5__c,P6__c,P7__c,P8__c,P9__c,P10__c,P11__c,P12__c,Year__c from BG_Targets__c where Year__c =: selectedYear];
            system.debug('BGtargets Size'+BGtargets.size());
            if(BGtargets.size() > 0 ){
                rowNum= BGtargets.size();
                isedit = true;
                editblock = false;
                issave = false;
            }
            else{
                isedit=true;
                //BGtargets.add(new BG_Targets__c(year__c = selectedYear));
                //rowNum=1;
                //isedit = false;
                //editblock = true;
                //issave = true;
            }
            if(BGtargetsDelList != null) BGtargetsDelList.clear(); 
            currentyear = true;
        }else{
            BGtargets = [select id,Business_Group__c,Total_Target__c,P1__c,P2__c,P3__c,P4__c,P5__c,P6__c,P7__c,P8__c,P9__c,P10__c,P11__c,P12__c,Year__c from BG_Targets__c where Year__c =: selectedYear];
            system.debug('BGtargets Size'+BGtargets.size());
            if(BGtargets.size() > 0 ){
                rowNum= BGtargets.size();
                isedit = false;
                editblock = false;
                issave = false;
            }
            if(BGtargetsDelList != null) BGtargetsDelList.clear();
            currentyear = false;
        }       
        System.debug('***currentyear ***'+currentyear+'***selectedYear**'+selectedYear+'**BGtargets**'+BGtargets);
        return null;
    }
    public void AddRow(){
        BGtargets.add(new BG_Targets__c(year__c=selectedYear));
        System.debug('**** Addrow****');
    }
   /* 
    public void delRow(){
        System.debug('**** ROW****' +rowNum);
        System.debug('**** BGtargets size****'+BGtargets.size());
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        System.debug('**** index****' + apexpages.currentpage().getparameters().get('index') + '*****row****'+rowNum);
        System.debug('**** BGtargets****'+BGtargets);
        System.debug('**** BGtargets get****'+BGtargets.get(rowNum));
        
        BGtargetsDelList.add(BGtargets.get(rowNum));
        BGtargets.remove(rowNum);   
        System.debug('**** BGtargets size****'+BGtargets.size());
    } 
   */
    public void deltraget(){
        System.debug('**** ROW****' +rowNum);
        System.debug('**** BGtargets size****'+BGtargets.size());
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        System.debug('**** index****' + apexpages.currentpage().getparameters().get('index') + '*****row****'+rowNum);
        System.debug('**** BGtargets****'+BGtargets);
        System.debug('**** BGtargets get****'+BGtargets.get(rowNum));
        
        BGtargetsDelList.add(BGtargets.get(rowNum));
        BGtargets.remove(rowNum);   
        System.debug('**** BGtargets size****'+BGtargets.size());
        System.debug('**** BGtargetsDelList ****'+BGtargetsDelList);
        
        list<BG_Targets__c> MultiBGdel = new list<BG_Targets__c>();
        For( BG_Targets__c bgtdel :BGtargetsDelList) {    
            BG_Targets__c testdel = new BG_Targets__c();
            If(bgtdel.id != null){
                testdel.id =bgtdel.id;
                MultiBGdel.add(testdel);
                System.debug('**** MultiBGdel ****'+MultiBGdel);
                System.debug('**** BGtargetsDelList ****'+BGtargetsDelList);
            }
        }
        if(MultiBGdel != null || MultiBGdel.size() > 0){
            System.debug('**** MultiBGdel ****'+MultiBGdel);
            System.debug('**** BGtargetsDelList ****'+BGtargetsDelList);
                Delete MultiBGdel;
                BGtargetsDelList.clear(); 
            System.debug('**** BGtargetsDelList ****'+BGtargetsDelList);                
        }
        System.debug('**** BGtargets size****'+BGtargets.size());
        if(BGtargets.size()==null || BGtargets.size()==0){
            issave = false;
            isedit = true;
            editblock= false;
            system.debug('****EDIT***isedit*'+isedit+'***Issave***'+issave);
        }

    }    
    public pageReference  Save(){
        try{
            errorflag = false;
            Bgyear = new Map<String,String>();
            String key_Bgyear = '';
            System.Debug('************** inside Save ****************** ');
            if(BGtargets.size() > 0){
                for(BG_Targets__c BGT:BGtargets){
                    key_Bgyear = BGT.Business_Group__c+BGT.Year__c;
				/*	decimal Total = 0;
                    if(BGT.P1__c !=null) total+= BGT.P1__c;
                    if(BGT.P2__c !=null) total+= BGT.P2__c;
                    if(BGT.P3__c !=null) total+= BGT.P3__c;
                    if(BGT.P4__c !=null) total+= BGT.P4__c;
                    if(BGT.P5__c !=null) total+= BGT.P5__c;
                    if(BGT.P6__c !=null) total+= BGT.P6__c;
                    if(BGT.P7__c !=null) total+= BGT.P7__c;
                    if(BGT.P8__c !=null) total+= BGT.P8__c;
                    if(BGT.P9__c !=null) total+= BGT.P9__c;
                    if(BGT.P10__c !=null) total+= BGT.P10__c;
                    if(BGT.P11__c !=null) total+= BGT.P11__c;
                    if(BGT.P12__c !=null) total+= BGT.P12__c;
                    BGT.Total_Target__c = Total;
				*/
                    if(BGT.Business_Group__c == null || BGT.Business_Group__c == ''){
                        System.Debug('**Blank***Contain  Bgyear ***** '+key_Bgyear);
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'"Business Group/Business Unit shouldn\'t be blank"')); 
                        errorflag =true;
                    }else if(Bgyear.containsKey(key_Bgyear)){
                        System.Debug('**Duplicate ***Contain  Bgyear ***** '+key_Bgyear);
                        string errormsg = '“Duplicate BG/BUs are not allowed, \''+ BGT.Business_Group__c +'\' is already exists"'; 
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,errormsg));
                        errorflag =true;
                    }else{
                        if(BGT.Business_Group__c != null && BGT.Year__c != null){
                            Bgyear.put(BGT.Business_Group__c+BGT.Year__c,BGT.Year__c);
                            System.Debug('*****add  Bgyear ***** '+Bgyear);
                        }
                    }
                    System.Debug('*****MAP Bgyear ***** '+Bgyear);
                }
            }
            if(errorflag == false){
                
                if(BGtargets != null || BGtargets.size() > 0){
                        Upsert BGtargets;
                }
                issave = false;
                isedit = true;
                editblock= false;
                system.debug('****EDIT***isedit*'+isedit+'***Issave***'+issave);
            }
            return null;
        }catch(Exception exe){
           System.Debug('************** inside Catch ****************** ' + exe.getLineNumber());
           System.Debug('************** inside Catch ****************** ' + exe.getMessage());
           return null;
        }   
    }
    public pageReference  cancel(){
        //Removing empty records which have no id
        Integer j = 0;
        while (j < BGtargets.size())
        {
          if(BGtargets.get(j).id == null)
          {
            BGtargets.remove(j);
          }else
          {
            j++;
          }
        }
                
        issave = false;
        isedit = true;
        editblock= false;
        system.debug('****EDIT***isedit*'+isedit+'***Issave***'+issave);
        System.debug('**** BGtargets size****'+BGtargets.size());

        return null;
    }
    
    public pageReference  edit(){
        if(currentyear==true && isedit == true && BGtargets.size() == 0){
            BGtargets.add(new BG_Targets__c(year__c=selectedYear));
            rownum=1;
        }
        
        issave = true;
        isedit = false; 
        editblock = true;
        system.debug('****EDIT***isedit*'+isedit+'***Issave***'+issave);
        return null;
    }
    
}