public with sharing class SPE_CreateKPIVersion{
   
    public SPE_KPIDefinition__c objKPIDef{get;set;}
    private SPE_KPIDefinition__c objKPIDefCloned;
    private ID MasterKPIID;
    private List<SPE_KPICalculation__c> lstKPICalc;
    private List<SPE_KPICalculation__c> lstKPICalcCloned;
    public SPE_CreateKPIVersion(ApexPages.StandardController con){
        objKPIDef = new SPE_KPIDefinition__c();
        objKPIDefCloned = new SPE_KPIDefinition__c();
        lstKPICalc = new List<SPE_KPICalculation__c>();
        lstKPICalcCloned = new List<SPE_KPICalculation__c>();
        MasterKPIID = con.getId();
        if(con.getId() !=  null){
        
        //***************************Changes For Encryption*************************//
            objKPIDef = [select id, Name,KPI_Title__c,ActualCalculation__c,AggregationScope__c,CalculationFormula__c,CategoryScope__c ,
                            FrequencyinMonth__c,
                            GeoScope__c,Group1__c,Group2__c,Confidential__c,IsHighBetter__c,AbbreviatedName__c,
                            KPI_Description_Language_1__c,KPI_Description_Language_2__c,KPI_Description_Language_3__c,
                            KPI_Description_Language_4__c,KPI_Description_Language_5__c,Type__c,KPI_Title_Language_1__c,
                            KPI_Title_Language_2__c,KPI_Title_Language_3__c,KPI_Title_Language_4__c,KPI_Title_Language_5__c,
                            Level__c,MissingDatalogic__c,ScheduledDate__c,OperationalType__c,Cluster__c,PI_Data__c,
                            BUScope__c,PurposeAndObjective__c,SchedulePeriod__c,LifecycleStage__c,UoM__c,Master_KPI__c,RPNExpression__c
                    From
                        SPE_KPIDefinition__c
                    Where
                        Id =: con.getId()];
          //**********************************END*******************************//
            
            lstKPICalc = [select id,Aggregation__c,ConstantValue__c,Filter1__c,filter10__c,Filter2__c,Filter3__c,Filter4__c,
                            Filter5__c,Filter6__c,Filter7__c,Filter8__c,filter9__c,flag__c,Index__c,IndexName__c,KPIDefinition__c,
                            PIDefination__c,PrevKPIDefination__c,QuestionName__c,SurveyQuestion__c,TimeFrame__c
                     From SPE_KPICalculation__c
                     Where
                         KPIDefinition__c = : con.getId()];
            lstKPICalcCloned = lstKPICalc.deepClone();
        }
        else{
            objKPIDef = new SPE_KPIDefinition__c();
        }
       objKPIDef.lifecyclestage__c='Draft'; 
    }
    
    public pageReference SaveKPI(){
        try{
            if(objKPIDef != null){
                objKPIDefCloned = objKPIDef.clone(false,true);
            }
            if(objKPIDefCloned != null && objKPIDefCloned.Id != null)
                objKPIDefCloned.Id = null;
            
            if(objKPIDefCloned != null)
                if(objKPIDef.Master_KPI__c == null)
                {
                    objKPIDefCloned.Master_KPI__c=MasterKPIID;
                }
                else{
                    objKPIDefCloned.Master_KPI__c = objKPIDef.Master_KPI__c;
                }
                
                objKPIDefCloned.LifecycleStage__c = 'Draft';
                objKPIDefCloned.RPNExpression__c=objKPIDef.RPNExpression__c;
                insert objKPIDefCloned;
                
               
            
            if(objKPIDefCloned.id != null){
                for(SPE_KPICalculation__c objKPIC : lstKPICalcCloned){
                    objKPIC.Id = null;
                    objKPIC.KPIDefinition__c = objKPIDefCloned.id;
                }
                
                if(!lstKPICalcCloned.isEmpty())
                    insert lstKPICalcCloned;
            }
            
        }
        catch(Exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage()));
            return null;
        }
        
        Pagereference pr = new Pagereference('/'+objKPIDefCloned.id);
      
        return pr;
    }
   
}