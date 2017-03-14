public with sharing class SPE_KPICalculationTrigger 
{
	public static void KPICalculationValidation(List<SPE_KPICalculation__c> kpiCalculations)
	{
		for (SPE_KPICalculation__c kCal: kpiCalculations)
		{
			
		}	
	}
	
	public static void reOrderIndex(List<SPE_KPICalculation__c> lstKPICal)
	{
		List<SPE_KPICalculation__c > KPICalcuation = [SELECT id,Index__c FROM SPE_KPICalculation__c 
	    											  WHERE KPIDefinition__c=:lstKPICal[0].KPIDefinition__c ];
	    
	    Set<String> indexSet = new Set<String>();
	    for(SPE_KPICalculation__c KPICal : KPICalcuation)
	    {
	    	indexSet.add(KPICal.Index__c);
	    }
	    Map<Integer,String> indexMap = SPE_Utility.IndexMap;
	    
	    String Index = indexMap.get((KPICalcuation.Size()+1));
	    
	    Boolean FoundMissing = false;
	    if(IndexSet.contains(Index)) 
	    {
			Integer i=1;
	        do 
	        {
		    	FoundMissing = true;
		        String ss=IndexMap.get(i);
		        if(!IndexSet.contains(ss)) 
		        {
			        FoundMissing = false;
			        lstKPICal[0].index__c=ss;
		        }            
	            i=i+1;
	         } while (FoundMissing);
	    
	     } 
	    
	     if(!indexSet.contains(Index))
	     {
	     	lstKPICal[0].index__c=Index;
	     }	
	}
	
	
	public static void DeletePITempValues (List<SPE_KPICalculation__c> oldKPICalculations)
	{
		Map<Id, Set<String>> kpiIndexMaps = new Map<Id, Set<String>>();
		
		for (SPE_KPICalculation__c kCal : oldKPICalculations)
		{
			Set<String> indexes = new Set<String>();
			
			if (kpiIndexMaps.get(kCal.KPIDefinition__c) != null)
			{
				indexes = kpiIndexMaps.get(kCal.KPIDefinition__c);
			}
			
			indexes.add(kCal.Index__c);
			
			kpiIndexMaps.put(kCal.KPIDefinition__c, indexes);
		}
		
		List<SPE_PITempValue__c> piTempValues = new List<SPE_PITempValue__c>();
		
		for (SPE_PITempValue__c piTemps : [SELECT Id, Index__c, KPIDefinition__c 
										   FROM SPE_PITempValue__c 
										   WHERE KPIDefinition__c =: kpiIndexMaps.keySet()])
		{
			if (kpiIndexMaps.get(piTemps.KPIDefinition__c).contains(piTemps.Index__c))
			{
				piTempValues.add(piTemps);
			}
		}
		
		delete piTempValues;
	}
}