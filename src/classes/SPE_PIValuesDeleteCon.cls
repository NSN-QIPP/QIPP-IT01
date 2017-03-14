public class SPE_PIValuesDeleteCon
{	
	public SPE_PIDefinition__c PIDef{get; set;}
    private Id piDefinitionId;
    
    public SPE_PIValuesDeleteCon()
    {
         piDefinitionId = ApexPages.currentPage().getParameters().get('Id');
         PIDef = [SELECT ID FROM SPE_PIDefinition__c WHERE Id =: piDefinitionId];
    }
    
    public Pagereference deletePIValues()
    {
        List<SPE_PIValues__c> toBeDeletedPIValues = [Select Id 
                                                     FROM SPE_PIValues__c 
                                                     WHERE PIDefination__c =: piDefinitionId 
                                                     LIMIT 10000];
        
        
        Database.delete(toBeDeletedPIValues);
    
        Pagereference pg = new Pagereference('/'+piDefinitionId);
        
        return pg;
    }
}