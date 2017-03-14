trigger SPE_PIDefinition on SPE_PIDefinition__c (before insert,before update) 
{
list<Spe_KPIDefinition__c> KPILIst= new list<Spe_KPIDefinition__c>();    
        //Set the stage to Draft when a new PI Data is Created
        if(trigger.isbefore && trigger.IsInsert) {
            for(SPE_PIDefinition__c pi : trigger.new)
                pi.LifecycleStage__c = 'Draft';   
            }
        
        // Check for the scope in mismatch with the linked KPI's
        if(trigger.isbefore && trigger.IsUpdate) {
            for(SPE_PIDefinition__c pi : trigger.new) {
                set<id> KPIIdset= new set<ID>();
                for(SPE_KPICalculation__c c:[select KPIDefinition__c from SPE_KPICalculation__c where PIDefination__c=:pi.Id]) {
                    KPIIdset.add(c.KPIDefinition__c);
                }
                
                for(Spe_KPIDefinition__c k:[select id from Spe_KPIDefinition__c where Pi_Data__c=:pi.Id]) {
                    KPIIdset.add(k.id);
                } 
                
                string errors='Below mentioned KPIs are in conflict: ';
               boolean flag=false;
               
               //********************************Changes For Encryption****************************//
               for(Spe_KPIDefinition__c k:[select KPI_Title__c, BUScope__c,categoryscope__c,GeoScope__c,name,version__c from Spe_KPIDefinition__c where Id IN:KPIIdset] )  {
               //********************************END****************************//            
                    // BU Scope reverse Validation
                    if ((k.BUScope__c == SPE_Constants.PRODUCT_BUSCOPE  && PI.BUScope__c != SPE_Constants.PRODUCT_BUSCOPE ) || 
                            (k.BUScope__c == SPE_Constants.BL_BUSCOPE  && (PI.BUScope__c != SPE_Constants.PRODUCT_BUSCOPE  && PI.BUScope__c != SPE_Constants.BL_BUSCOPE  )) ||
                            (k.BUScope__c == SPE_Constants.BU_BUSCOPE  && PI.BUScope__c == SPE_Constants.ALL_BUSCOPE ))
                            
                            {
                                  flag=true;
                                  //********************************Changes For Encryption****************************//
                                  errors=errors+'| '+k.KPI_Title__c+'-'+k.Version__c;
                                  //********************************END****************************//
                            }
                              
                              
                         // Category Scope reverse Validation      
                        if ((k.categoryscope__c == SPE_Constants.CATSCOPE  && PI.CategoryScope__c != SPE_Constants.CATSCOPE ) || 
                            (k.categoryscope__c == SPE_Constants.GROUP_CATSCOPE && (PI.CategoryScope__c != SPE_Constants.CATSCOPE  && PI.CategoryScope__c != SPE_Constants.GROUP_CATSCOPE  )) ||
                            (k.categoryscope__c == SPE_Constants.AREA_CATSCOPE && (PI.CategoryScope__c == SPE_Constants.ALL_CATSCOPE ))
                          )
                            {
                                flag=true;
                                //********************************Changes For Encryption****************************//
                                  errors=errors+'| '+k.KPI_Title__c+'-'+k.Version__c;
                                //********************************END****************************//  
                                   
                            }
                          
                          
                         // Geo Scope reverse Validation  
                        if ((k.GeoScope__c == SPE_Constants.PRJ_GEOSCOPE && PI.GeoScope__c != SPE_Constants.PRJ_GEOSCOPE ) || 
                            (k.GeoScope__c == SPE_Constants.COUNTRY_GEOSCOPE && (PI.GeoScope__c != SPE_Constants.PRJ_GEOSCOPE && PI.GeoScope__c != SPE_Constants.COUNTRY_GEOSCOPE )) || 
                            (k.GeoScope__c == SPE_Constants.MU_GEOSCOPE && (PI.GeoScope__c == SPE_Constants.MARKET_GEOSCOPE  || PI.GeoScope__c == SPE_Constants.ALL_GEOSCOPE )) || 
                            (k.GeoScope__c == SPE_Constants.MARKET_GEOSCOPE && PI.GeoScope__c == SPE_Constants.ALL_GEOSCOPE)
                           )
                            {
                                
                                flag=true;
                                //********************************Changes For Encryption****************************//
                                  errors=errors+'| '+k.KPI_Title__c+'-'+k.Version__c;
                                //********************************END****************************//  
                                   
                            }
                    
                    }
                 if(flag)
                     pi.adderror(errors);
             }
         }
}