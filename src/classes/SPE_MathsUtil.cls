public with sharing class SPE_MathsUtil 
{
    
    public static string market1 = PicklistDefaultValues__c.getall().values()[0].Market__c;
    public static string marketUnit1 = PicklistDefaultValues__c.getall().values()[0].Market_Unit__c;
    public static string country1 = PicklistDefaultValues__c.getall().values()[0].Country__c;
    public static string project1 = PicklistDefaultValues__c.getall().values()[0].Project__c;
    public static string bu1 = PicklistDefaultValues__c.getall().values()[0].Business_Unit__c;
    public static string bl1 = PicklistDefaultValues__c.getall().values()[0].Business_Line__c;
    public static string prd1 = PicklistDefaultValues__c.getall().values()[0].Product__c;
    public static string ca1 = PicklistDefaultValues__c.getall().values()[0].Category_Area__c;
    public static string cg1 = PicklistDefaultValues__c.getall().values()[0].Category_Group__c;
    public static string ct1 = PicklistDefaultValues__c.getall().values()[0].Category__c;
    
    public static Boolean isEdit = false;
    
    static Map<String, EnumOperation> arithmeticOperationMap = new Map<String, EnumOperation>();
    
    static 
    {
        arithmeticOperationMap.put('>', EnumOperation.Greater);
        arithmeticOperationMap.put('>=', EnumOperation.GreaterAndEqual);
        arithmeticOperationMap.put('==', EnumOperation.Equal);
        arithmeticOperationMap.put('<', EnumOperation.Lesser);
        arithmeticOperationMap.put('<=', EnumOperation.LesserAndEqual);
    }
    
    public static Decimal textToArithmeticOperator(Decimal lower, String lowerOpp, Decimal upper, String upperOpp, Decimal score, Decimal actualScore)
    {
        
        if (operationCompare((EnumOperation)arithmeticOperationMap.get(lowerOpp), actualScore, lower) &&
            operationCompare((EnumOperation)arithmeticOperationMap.get(upperOpp), actualScore, upper) )
        {
            return score;
        }
        
        return null;
    }
    
    
    public enum EnumOperation 
    {
        Greater, GreaterAndEqual, Equal, Lesser, LesserAndEqual
    }
    
    public static Boolean operationCompare(EnumOperation opp, Decimal val1, Decimal val2)
    {
        
        if (EnumOperation.Greater == opp)
        {
            return val1 > val2;
        }
        else if (EnumOperation.GreaterAndEqual == opp)
        {
            return val1 >= val2;
        }
        else if (EnumOperation.Equal == opp)
        {
            return val1 == val2;
        }
        else if (EnumOperation.Lesser == opp)
        {
            return val1 < val2;
        }
        else if (EnumOperation.LesserAndEqual == opp)
        {
            return val1 <= val2;
        }
        else
        {
            return false;
        }   
    }
    
}