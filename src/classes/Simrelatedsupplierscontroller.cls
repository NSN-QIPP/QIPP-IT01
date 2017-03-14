public  class Simrelatedsupplierscontroller {

    
    public list<String>  SerchAlpabet { get; set; }
    public String SearchVar{get;set;}
    public list<account> suppliers{set;get;}
    public list<account> ser{set;get;}
    public list<account> supplist{set;get;}
    public string supp{get;set;}

 public void search() {
       
       String serquery = 'select id,name,Enterprise_Id__c,Unique_Id__c from account where Unique_Id__c like \'%'+supp+'%\' limit 3';
       suppliers = Database.query(serquery); 
        if(suppliers.size()==0){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'No records to display')); 
        }     
    } 
    public void search1() {
       String serquery = 'select id,name,Enterprise_Id__c,Unique_Id__c from account where Unique_Id__c like \'%'+supp+'%\' limit 3';
       suppliers = Database.query(serquery);  
        if(suppliers.size()==0){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No records to display')); 
        }
    }
    
    public Simrelatedsupplierscontroller()
    {
    
    SerchAlpabet=new List<string>
    {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','3','All'};
    supplist=new List<account>();
    supplist=[select id,name,Enterprise_Id__c from account where Unique_Id__c !=null order by  Unique_Id__c];
    
    SearchVar='All';
     suppliers=new List<account>();
      
      for(account a : supplist){
      if(SearchVar.equals('All'))
      suppliers.add(a);
      else
         if(a.Name.startsWith(SearchVar.toLowerCase())||a.Name.startsWith(SearchVar))
           suppliers.add(a);
      }

    }        
    

public void display()
{
 suppliers.clear();
 for(account a : supplist)
 {
 if(SearchVar.equals('All'))
suppliers.add(a);
else
if(a.Name.startsWith(SearchVar.toLowerCase())||a.Name.startsWith(SearchVar))
 {
  suppliers.add(a);
 }
 }
 //return null;
}   
}