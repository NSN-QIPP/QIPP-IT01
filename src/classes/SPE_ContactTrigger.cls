public with sharing class SPE_ContactTrigger
{
    public static void GeneratePassword (List<Contact> suppliercontact)
    {  
         for(Contact pwd : suppliercontact)
         {
             if (pwd.Password__c == null)
             {
                 Decimal key = Math.random()*1000000;
                 
                 pwd.Password__c = pwd.Firstname == null ? pwd.LastName.left(1).toUpperCase() + String.valueOf((Integer) key) : 
                     pwd.Firstname.left(1).toUpperCase() + pwd.LastName.left(1).toUpperCase() + String.valueOf((Integer) key);
             }
         }                                                                                                
    }                                                                             
}