public class QIRSSerachController 
{
    public String myString { set; get; }
    
    private PageReference pg;
    
    public QIRSSerachController(){}
    
	public QIRSSerachController(ApexPages.StandardController controller){}
    
    public pageReference myfunc()
    {             
        pg = new PageReference('/search/SearchResults?searchType=2&sen=0&setLast=1&str='+myString);
        return pg;
    } 
}