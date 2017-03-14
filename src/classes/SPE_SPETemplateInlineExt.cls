public class SPE_SPETemplateInlineExt 
 {
        public List < SPE_SPEKPIMap__c > lstSpeKpi{ get; set; }
        
        public  Map <String, Decimal> gruop1Map{ get; set; }
        
        public  Map <String, Decimal> gruop2Map{ get; set; }
        
        public SPE_SPETemplateInlineExt (ApexPages.StandardController controller )
        {
        
            //****************Changes For Encryption*****************//
            lstSpeKpi = [SELECT Id, KPIDefinition__r.Id, KPIDefinition__r.Name,KPIDefinition__r.KPI_Title__c, KPIGroup1__c, KPIGroup2__c, Weight__c ,UseLatestKPIVersion__c,Version__c
                         FROM SPE_SPEKPIMap__c 
                         WHERE SPETemplate__c =: controller.getId()];
            //***************END******************//             
            
            gruop1Map = new Map <String, Decimal> ();
            gruop2Map = new Map <String, Decimal> ();
             
            for (SPE_SPEKPIMap__c SpeKpi : lstSpeKpi) 
            {
                if(gruop1Map.get(SpeKpi.KPIGroup1__c) == null )
                {
                    gruop1Map.put(SpeKpi.KPIGroup1__c, SpeKpi.Weight__c);
                }
                else
               {
                   Decimal totalWeight = gruop1Map.get(SpeKpi.KPIGroup1__c);
                   totalWeight = totalWeight + SpeKpi.Weight__c;
                   gruop1Map.put(SpeKpi.KPIGroup1__c, totalWeight);
               }
            }
            for (SPE_SPEKPIMap__c SpeKpi : lstSpeKpi) 
            {
                if(gruop2Map.get(SpeKpi.KPIGroup2__c) == null )
                {
                    gruop2Map.put(SpeKpi.KPIGroup2__c, SpeKpi.Weight__c);
                }
                else
               {
                   Decimal totalWeight = gruop2Map.get(SpeKpi.KPIGroup2__c);
                   totalWeight = totalWeight + SpeKpi.Weight__c;
                   gruop2Map.put(SpeKpi.KPIGroup2__c, totalWeight);
               }
            }
       }
      
}