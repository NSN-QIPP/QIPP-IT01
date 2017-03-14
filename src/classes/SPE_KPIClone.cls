public with sharing class SPE_KPIClone{
        
        public SPE_KPIDefinition__c objKPIDef{get;set;}
        private SPE_KPIDefinition__c objKPIDefCloned;
        
        private List<SPE_KPICalculation__c> lstKPICalc;
        private List<SPE_KPICalculation__c> lstKPICalcCloned;
        private List<SPE2_Language_KPI__c> altrKPILang;
        private List<SPE2_Language_KPI__c> altrKPILangCloned;
        private List<SPE2_KPI_Threshold__c> lstKPIThr;
        private List<SPE2_KPI_Threshold__c> lstKPIThrCloned;
        
        public SPE_KPIClone(ApexPages.StandardController con){
            objKPIDef = new SPE_KPIDefinition__c();
            objKPIDefCloned = new SPE_KPIDefinition__c();
            lstKPICalc = new List<SPE_KPICalculation__c>();
            lstKPICalcCloned = new List<SPE_KPICalculation__c>();
            altrKPILang = new List<SPE2_Language_KPI__c>();
            altrKPILangCloned = new List<SPE2_Language_KPI__c>();        
            lstKPIThr = new List<SPE2_KPI_Threshold__c>();
            lstKPIThrCloned = new List<SPE2_KPI_Threshold__c>();
            
            if(con.getId() !=  null){
            
            //*************************Changes For Encryption**************************//
                objKPIDef = [select id, Name,KPI_Title__c,ActualCalculation__c,AggregationScope__c,CalculationFormula__c,CategoryScope__c ,
                                FrequencyinMonth__c,
                                GeoScope__c,Group1__c,Group2__c,Confidential__c,IsHighBetter__c,AbbreviatedName__c,
                                KPI_Description_Language_1__c,KPI_Description_Language_2__c,KPI_Description_Language_3__c,
                                KPI_Description_Language_4__c,KPI_Description_Language_5__c,Type__c,KPI_Title_Language_1__c,
                                KPI_Title_Language_2__c,KPI_Title_Language_3__c,KPI_Title_Language_4__c,KPI_Title_Language_5__c,
                                Level__c,MissingDatalogic__c,ScheduledDate__c,Buffer_Days__c,OperationalType__c,Cluster__c,PI_Data__c,
                                BUScope__c,PurposeAndObjective__c,SchedulePeriod__c,LifecycleStage__c,UoM__c,RPNExpression__c,Description__c,
                                PreventiveActionInstructions__c,RCAInstructions__c,CorrectiveActionInstructions__c
                                From
                                SPE_KPIDefinition__c
                                Where
                                Id =: con.getId()];
                if(objKPIDef.PI_Data__c != null){
                    objKPIDef.Buffer_Days__c = null;
                }
             //*********************************END**********************************//  
                lstKPICalc = [select id,Aggregation__c,ConstantValue__c,Filter1__c,filter10__c,Filter2__c,Filter3__c,Filter4__c,
                                Filter5__c,Filter6__c,Filter7__c,Filter8__c,filter9__c,flag__c,Index__c,IndexName__c,KPIDefinition__c,
                                PIDefination__c,PrevKPIDefination__c,QuestionName__c,SurveyQuestion__c,TimeFrame__c
                         From SPE_KPICalculation__c
                         Where
                             KPIDefinition__c = : con.getId()];
                             
                if(!lstKPICalc.isEmpty())             
                lstKPICalcCloned = lstKPICalc.deepClone();
                            
                altrKPILang = [select id,Language__c,Language_Version__c,English_Version__c,KPI__c 
                        From SPE2_Language_KPI__c
                        Where
                            KPI__c = : con.getId()];
                            
                if(!altrKPILang.isEmpty())            
                altrKPILangCloned = altrKPILang.deepClone();
                
                lstKPIThr = [Select ID,BusinessUnit__c,
                                        businessLine__c,
                                        Category__c,
                                        CategoryCluster__c,
                                        CategoryGroup__c,
                                        Category_Hierarchy__c,
                                        Country__c,
                                        Geo_Hierarchy__c,
                                        High_Better__c,
                                        KPI_Attrribute__c,
                                        KPI_ID__c,
                                        KPI_ID__r.BUScope__c,KPI_ID__r.GeoScope__c,KPI_ID__r.CategoryScope__c,
                                        KPI_Title__c,
                                        Region__c,
                                        SubRegion__c,
                                        Product__c,
                                        Product_Hierarchy__c,
                                        Project__c,
                                        Stage__c,
                                        Threshold_Boundary__c,Thr_External_ID__c,
                                        Threshold_Title__c, (Select ID,score__c,Lower__c,LowerTo__c,Upper__c,UpperTo__c from Scoring_Calculations__r)
                                 FROM SPE2_KPI_Threshold__c Where KPI_ID__c =: con.getId()];
                
                if(!lstKPIThr.isEmpty()){                        
                    for(SPE2_KPI_Threshold__c temp :lstKPIThr){
                        temp.Thr_External_ID__c = temp.ID+';'+temp.KPI_ID__c;
                        lstKPIThrCloned.add(temp);    
                    }
                }
            }
            else{
                objKPIDef = new SPE_KPIDefinition__c();
            }           
        }
        
        public pageReference SaveKPI(){
            try{
                if(objKPIDef != null){
                    objKPIDefCloned = objKPIDef.clone(false,true);
                }
                if(objKPIDefCloned != null && objKPIDefCloned.Id != null)
                    objKPIDefCloned.Id = null;
                
                if(objKPIDefCloned != null)
                    
                    objKPIDefCloned.LifecycleStage__c = 'Draft';
                    objKPIDefCloned.Master_KPI__c = null;
                    objKPIDefCloned.RPNExpression__c=objKPIDef.RPNExpression__c;
                    objKPIDefCloned.VerNumber__c = 0;
                    insert objKPIDefCloned;
                
                if(objKPIDefCloned.id != null){
                    for(SPE_KPICalculation__c objKPIC : lstKPICalcCloned){
                        objKPIC.Id = null;
                        objKPIC.KPIDefinition__c = objKPIDefCloned.id;
                    }
                    
                    if(!lstKPICalcCloned.isEmpty())
                        insert lstKPICalcCloned;
                                           
                   for(SPE2_Language_KPI__c altrKPIL : altrKPILangCloned ){
                        altrKPIL.Id = null;
                        altrKPIL.KPI__c = objKPIDefCloned.id;
                    }
                    
                    if(!altrKPILangCloned.isEmpty())                      
                       insert altrKPILangCloned;
                       
                    //System.Debug('lstKPIThr[0].KPI_ID__r.BUScope__c::'+lstKPIThr[0].KPI_ID__r.BUScope__c);
                    //System.Debug('objKPIDefCloned.BUScope__c::'+objKPIDefCloned.BUScope__c);
                     
                    if(!lstKPIThr.isEmpty()){
                        if(lstKPIThr[0].KPI_ID__r.BUScope__c == objKPIDefCloned.BUScope__c && lstKPIThr[0].KPI_ID__r.GeoScope__c == objKPIDefCloned.GeoScope__c && lstKPIThr[0].KPI_ID__r.CategoryScope__c == objKPIDefCloned.CategoryScope__c){               
                            
                            for(SPE2_KPI_Threshold__c KPIThr : lstKPIThrCloned){
                                KPIThr.Id = null;
                                KPIThr.KPI_ID__c = objKPIDefCloned.id;
                            } 
                                                                                 
                            if(!lstKPIThrCloned.isEmpty())                      
                               insert lstKPIThrCloned;
                                   
                            for(SPE2_KPI_Threshold__c temp :lstKPIThr){
                                temp.Thr_External_ID__c = temp.ID+';'+temp.KPI_ID__c;  
                            }
                            
                            if(!lstKPIThr.isEmpty())
                            update lstKPIThr;
                            
                            List<SPE_ScoringCalculation__c> scalList = new List<SPE_ScoringCalculation__c>();       
                                 for(SPE2_KPI_Threshold__c KPIThr1 : lstKPIThr){
                                     for(SPE_ScoringCalculation__c sc :KPIThr1.Scoring_Calculations__r){
                                         scalList.add(new SPE_ScoringCalculation__c(KPI_Threshold__r = new SPE2_KPI_Threshold__c(Thr_External_ID__c = KPIThr1.ID+';'+KPIThr1.KPI_ID__c),
                                                                               score__c =sc.score__c, Lower__c = sc.Lower__c,LowerTo__c = sc.LowerTo__c,Upper__c = sc.Upper__c,UpperTo__c=sc.UpperTo__c,KPIDefinition__c=KPIThr1.KPI_ID__c));
                                     }
                                    
                                    
                                }
                                
                                if(!scalList.isEmpty())  
                                insert scalList;
                          }
                      }     
                 }
            }
            catch(Exception ex){
                String s=ex.getMessage();
                s=(s.substringAfter('first error:').substringBefore('[]'));
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, s));
                return null;
            }
            
            Pagereference pr = new Pagereference('/'+objKPIDefCloned.id);          
            return pr;
        }
    }