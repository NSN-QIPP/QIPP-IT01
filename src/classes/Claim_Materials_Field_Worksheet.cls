public with sharing class Claim_Materials_Field_Worksheet
{
public Integer rows{get; set;}
public Boolean selected{get; set;}
private Integer i;
//public Integer total_loss{get; set;}
// The below line added by Thiresh on 26-Aug-2013
public double total_loss{get; set;}
Public String category{get; set;}
Public String dynamictext{get; set;}
public List<Materials_Field_Worksheet__c> prd {get; set;} 
public List<Materials_Field_Worksheet__c> added_rows {get; set;} 
public List<Materials_Field_Worksheet__c> selecteditems {get; set;}

//String parentid= ApexPages.currentPage().getParameters().get('id');
//s = 'The quick brown fox jumped over the lazy dog.';
Public String parentid{get; set;}





public List<cContact> contactList {get; set;}

    //This method uses a simple SOQL query to return a List of Contacts
    public List<cContact> getContacts() {
        if(contactList == null) {
            contactList = new List<cContact>();
            for(Materials_Field_Worksheet__c c : [select Category__c,Description__c,Qty_Hours__c,Unit_Price__c,Amount__c from Materials_Field_Worksheet__c where Claim__c=:parentid]) {
                // As each contact is processed we create a new cContact object and add it to the contactList
                contactList.add(new cContact(c));
            }
        }
        return contactList;
    }



// String parentid= 'a0tJ0000000GV1Y';
 
  public void total_loss_calculation()
{
List<Materials_Field_Worksheet__c> NCC_obj = [select ID,Category__c,Description__c,Qty_Hours__c,Unit_Price__c,Amount__c from Materials_Field_Worksheet__c where Claim__c=:parentid ORDER BY Id DESC LIMIT 1];
  if (NCC_obj.size() > 0)
  {
    AggregateResult Calim_total_obj = [select sum(Amount__c) total,Claim__c,COUNT(Id)
     from Materials_Field_Worksheet__c where Claim__c=:parentid Group by Claim__c ]; 
      if (Calim_total_obj != null)
      {
    //total_loss=integer.valueof(Calim_total_obj.get('total'));
    // The below line added by Thiresh on 26-Aug-2013
    total_loss=double.valueof(Calim_total_obj.get('total'));
    MCAR_Claim_Management__c claim_obj = [select Materials_Field_Loss__c from MCAR_Claim_Management__c where ID =:parentid];
    if (claim_obj  != null)
    {
    claim_obj.Materials_Field_Loss__c =total_loss;
    update claim_obj;
    }
}
}
}
         public void on_load()
            {
          
        total_loss_calculation();
        // category = 'select a category'; 
        selecteditems = new List<Materials_Field_Worksheet__c>();
         prd= new List<Materials_Field_Worksheet__c>();   
         added_rows =new List<Materials_Field_Worksheet__c>();  
         added_rows = [select Category__c,Description__c,Qty_Hours__c,Unit_Price__c,Amount__c from Materials_Field_Worksheet__c where Claim__c=:parentid];      

         
            }  


 
                 public Claim_Materials_Field_Worksheet(ApexPages.StandardSetController controller) 
                {
                                parentid= ApexPages.currentPage().getParameters().get('id');
                               prd= new List<Materials_Field_Worksheet__c>();   
                              
                
                } 
                
                  public pagereference updatedrows()
              {
                 
                 for(cContact obj:getContacts())  
                 { 
                 //selecteditems.add(obj) ;
                              if (obj.selected == true)
                              {
                              selecteditems.add(obj.con) ;
                              }
                  }
                  update selecteditems;
                  selecteditems = null;
//                 return null;
                 // PageReference pageRef = ApexPages.currentPage();
                          PageReference pageRef = new PageReference('/apex/MCAR_Claim_Materials_Field_Worksheet?&id='+parentid);
                          //https://c.cs9.visual.force.com/apex/MCAR_Claim_Materials_Field_Worksheet
                  //PageReference QIRSPage = new ApexPages.StandardController(theParent).view();
                  pageRef.setRedirect(true);
                  return pageRef;
                  
                  
              }
              
              
              
              
                
                  public pagereference deletedrows()
              {
                 
                 for(cContact obj:getContacts())  
                 { 
                 //selecteditems.add(obj) ;
                              if (obj.selected == true)
                              {
                              selecteditems.add(obj.con) ;
                              }
                  }
                  delete selecteditems;
                  selecteditems = null;
//                 return null;
                 // PageReference pageRef = ApexPages.currentPage();
                   PageReference pageRef = new PageReference('/apex/MCAR_Claim_Materials_Field_Worksheet?&id='+parentid);
                 //PageReference pageRef = new PageReference('https://c.cs9.visual.force.com/apex/MCAR_Claim_NCC_Services_Worksheet?&id=a0vK0000000VDkm');
                 //PageReference pageRef = new PageReference('https://c.cs9.visual.force.com/apex/MCAR_Claim_Materials_Field_Worksheet');
                  //PageReference QIRSPage = new ApexPages.StandardController(theParent).view();
                  pageRef.setRedirect(true);
                  return pageRef;
                  
                  
              }
                
                 public void addrows()
                  {
              //  prd.add(new Materials_Field_Worksheet__c(Claim__c=parentid,Category__c=category));
              
                          
      
                            prd.add(new Materials_Field_Worksheet__c(Claim__c=parentid));
      
                  
                  }
                  
                  public String getdynamictextvalue()
{

return '';
}

                  public pagereference save()
              {
                  insert prd;
                   prd =null;
                   getContacts();
                  //PageReference pageRef = ApexPages.currentPage();
                  PageReference pageRef = new PageReference('/apex/MCAR_Claim_Materials_Field_Worksheet?&id='+parentid);
                 // PageReference QIRSPage = new ApexPages.StandardController(theParent).view();
                  pageRef.setRedirect(true);
                  return pageRef;
                  
                  
              }
              
         public class cContact {
        public Materials_Field_Worksheet__c con {get; set;}
        public Boolean selected {get; set;}

        //This is the contructor method. When we create a new cContact object we pass a Contact that is set to the con property. We also set the selected value to false
        public cContact(Materials_Field_Worksheet__c c) {
            con = c;
            selected = false;
        }

            }
               
                  
  
  
 
}