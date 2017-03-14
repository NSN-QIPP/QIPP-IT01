public class QIPP_Portfolio_Owner_Count {
    public Id thePortfolioId { set; get; }
    
    public QIPP_Portfolio_Owner_Count(apexpages.StandardController stdController){
      Map<String,String> projTypeMap = new Map<String,String>();
                    projTypeMap.put('DMAIC_DMADV__c','DMAIC/DMADV-DMAIC_DMADV__c');
                    projTypeMap.put('Lean_including_Kaizen__c','Lean (including Kaizen)-Lean_including_Kaizen__c');
                    projTypeMap.put('X8D__c','8D-X8D__c');
                    projTypeMap.put('A3__c','A3-A3__c');
                    projTypeMap.put('CIF__c','CIF-CIF__c');
                    projTypeMap.put('DI_CoPQ__c','DI (CoPQ)-DI_Logic__c');
                    projTypeMap.put('Other__c','Other-Other__c');
                    projTypeMap.put('RCA_EDA__c','RCA/EDA-RCA_EDA__c');
                    
      Map<String,Integer> methodologyCountMap = new Map<String,Integer>();              
      try{
          QIPP_Portfolio__c rec = (QIPP_Portfolio__c)stdController.getRecord();
          QIPP_Portfolio__c port = [select id,Lean_including_Kaizen__c,DMAIC_DMADV__c,X8D__c,A3__c,CIF__c,DI_CoPQ__c,Other__c,RCA_EDA__c from QIPP_Portfolio__c where id=:rec.id];
          List<Portfolios_Owner__c> Owners = [select id,X8D__c,A3__c,CIF__c,DI_Logic__c,DMAIC_DMADV__c,Lean_including_Kaizen__c,Other__c,RCA_EDA__c from Portfolios_Owner__c where  QIPP_Portfolio__c = :rec.id ];
          if(Owners.size() == 0){
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,'Please add atleast one Portfolio Owner and its correponding Methodology'));
          }
          String Methodology = '';
          system.debug('projTypeMap.keySet() :'+projTypeMap.keySet());
          for(String str: projTypeMap.keySet()){
              system.debug('str :'+str);
              system.debug('(Boolean)port.get(str):'+(Boolean)port.get(str));
              if((Boolean)port.get(str)){
                     system.debug('Hello-----');
                     for(Portfolios_Owner__c own : Owners ){
                         system.debug('(Boolean)own.get((projTypeMap.get(str)):'+(projTypeMap.get(str)));
                     }    
              }           
          }
          
         if(!Owners.isempty()){
             for(String str: projTypeMap.keySet()){
                 system.debug('str :'+str);
                 system.debug('(Boolean)port.get(str):'+(Boolean)port.get(str));
                 if((Boolean)port.get(str)){
                     system.debug('Hello-----');
                     methodologyCountMap.put(str,0);
                     for(Portfolios_Owner__c own : Owners ){
                         Boolean bool21 = ((Boolean)own.get((projTypeMap.get(str).split('-'))[1]));
                         system.debug('bool21 :'+bool21  );
                          
                         if((Boolean)own.get((projTypeMap.get(str).split('-'))[1])){
                           
                           methodologyCountMap.put(str,methodologyCountMap.get(str)+1);  
                         }
                     
                     }
                 
                 }
             
             }
             system.debug('methodologyCountMap :'+methodologyCountMap);
             for(String str: methodologyCountMap.keySet()){
                 if(methodologyCountMap.get(str)==0){    
                   if(Methodology == '' || Methodology == null ){  
                       Methodology =  (projTypeMap.get(str).split('-'))[0] ; 
                   }else{
                       Methodology = Methodology +','+' '+ (projTypeMap.get(str).split('-'))[0] ; 
                   }
                }    
                 
             }            
             if(Methodology!='' && Methodology != null ){
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Please add Portfolio Owner for '+Methodology+' methodology' ));
             }
         }
         
         //--E036--Start--//
         List<QIPP_BG_BU_BL_Contact_Mapping__c> bgMBBList = [select id from QIPP_BG_BU_BL_Contact_Mapping__c where  Portfolio_Name__c = :rec.id];
         if(bgMBBList == null || bgMBBList.size() == 0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,'Please add atleast one Master Black Belt'));
         }
         //--E036--End--//
                   
      }catch(exception e){
          
          
      }  
    }    

}