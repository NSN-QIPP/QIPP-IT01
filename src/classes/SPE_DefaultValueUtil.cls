public with sharing class SPE_DefaultValueUtil 
{

	public static SPE_PITempValue__c assignPITempValues (SPE_PITempValue__c piTempValue)
	{
		SPE_PITempValue__c piTemp = piTempValue;
		piTemp.Region__c = 	PicklistDefaultValues__c.getall().values()[0].Market__c;
    	piTemp.SubRegion__c = PicklistDefaultValues__c.getall().values()[0].Market_Unit__c;
    	piTemp.Country__c = PicklistDefaultValues__c.getall().values()[0].Country__c;
    	piTemp.Project__c = PicklistDefaultValues__c.getall().values()[0].Project__c;
    	piTemp.BusinessUnit__c = PicklistDefaultValues__c.getall().values()[0].Business_Unit__c;
    	piTemp.BusinessLine__c = PicklistDefaultValues__c.getall().values()[0].Business_Line__c;
    	piTemp.Product__c = PicklistDefaultValues__c.getall().values()[0].Product__c;
    	piTemp.Cluster__c = PicklistDefaultValues__c.getall().values()[0].Category_Area__c;
    	piTemp.CategoryGroup__c = PicklistDefaultValues__c.getall().values()[0].Category_Group__c;
    	piTemp.Category__c = PicklistDefaultValues__c.getall().values()[0].Category__c;
    
    	return piTemp;
	}
}