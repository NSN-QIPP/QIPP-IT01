public Class SPE_Comparableinterface implements Comparable
{
	public Sobject mainObj;
    public String field;
    
    public SPE_Comparableinterface(Sobject sObj, String field)
    {
        this.mainObj = sObj;
        this.field = field;
    }
    
    public Integer compareTo(Object obj)
    {
        Decimal thisValue = (Decimal)mainObj.get(field);
        
        Decimal otherValue = (Decimal)((SPE_Comparableinterface)obj).mainObj.get(field);  
        
        if (thisValue > otherValue)
        {
            return 1;
        }        
        if (thisValue < otherValue)
        {
            return -1;
        }        
        else
        {
            return 0;
        }        
    } 
}