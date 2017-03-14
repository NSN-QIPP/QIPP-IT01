public class NQT_Search_forHomepage_Component 
{

    public String myString { set; get; }
    
       
       
   public pageReference myfunc()
    {             
      
        PageReference pageRef = new PageReference('/search/SearchResults?searchType=2&sen=0&setLast=1&str='+myString);

        return pageRef ;
    } 

}