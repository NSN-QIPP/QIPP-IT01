public class SPE_CategoryInfoEXT
{
    public string caVal{get;set;}
    public string cgVal{get;set;}
    public string ctVal{get;set;}
    public SPE_CategoryInfo__c categoryInfo{get;set;}
    
    private String strPIData; 
    
    public SPE_CategoryInfoEXT(ApexPages.StandardController controller) 
    {
        if (controller.getId() == null)
        {
            categoryInfo = (SPE_CategoryInfo__c)controller.getRecord();
            
        }
        
        else
        {
            categoryInfo = [SELECT Id, CategoryCluster__c, CategoryGroup__c,Group__c, Category__c, Supplier__c, Contact__c FROM SPE_CategoryInfo__c WHERE Id =: controller.getId()];
            SPE_MathsUtil.ca1 = categoryInfo.CategoryCluster__c;
            SPE_MathsUtil.cg1 = categoryInfo.CategoryGroup__c;
            SPE_MathsUtil.ct1 = categoryInfo.Category__c;
        }
    }
    
    public PageReference save()
    {
        categoryInfo.CategoryCluster__c = caVal;
        categoryInfo.CategoryGroup__c = cgVal;
        categoryInfo.Category__c = ctVal;
        
        upsert categoryInfo;
        
        PageReference pr;
        
        if (categoryInfo.Supplier__c != null)
        {
            pr = new PageReference('/'+categoryInfo.Supplier__c);
        }
        
        else
        {
            pr = new PageReference('/'+categoryInfo.Contact__c);
        }
        
        return pr;
    }
    
    public PageReference cancel()
    {
        PageReference pr;
        
        if (categoryInfo.Supplier__c != null)
        {
            pr = new PageReference('/'+categoryInfo.Supplier__c);
        }
        
        else
        {
            pr = new PageReference('/'+categoryInfo.Contact__c);
        }
        
        return pr;
    }
}