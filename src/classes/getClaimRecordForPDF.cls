public  class getClaimRecordForPDF 
{    
public String colorStatus {set; get;}
public  MCAR_Claim_Management__c claim{get;set;}
public MCAR_Manufacturer__c manufacturer{get;set;}
public MCAR_Facility__c facility{get;set;}
public  Claim_Contact__c contacs{set;get;}
public Id ClaimID{get; set;}
public String str {get;set;}
public list<MCARClaimNotesandAttchment> listNotesAttchment{get;set;}
    
    public String NameOfSupplier { set; get; }
    
    public getClaimRecordForPDF(ApexPages.StandardController Claimcontroller) 
    {
    
    ClaimID= ApexPages.currentPage().getParameters().get('id');
    
     claim = new MCAR_Claim_Management__c();
     manufacturer = new MCAR_Manufacturer__c();
     facility = new MCAR_Facility__c();
     claim = [select id,name,Part_Category__c,Manufacturer__c,H_Facility_Name__c,First_Claim_Letter_Sent__c,H_Related_Claim__c,Facility__c,X4C_Claim_ID__c,Title__c ,Related_to_Customer_Issue__c,Approvals_comments__c,Currency__c, Sending_Claim_letter__c, Send_Reclamation_Letter__c, manual_date_updated__c,Sup_Confirmed_Re_ceipt_of_Reclamation__c,updated_manufacturer__c, Probability__c, Nokia_Action_Summary__c, Payment_Summary__c,Supplied_Product_Summary__c,Colour_Status__c,Frame_Agreement__c, Claim_Direction__c,owner.name,CreatedBy.Name,LastModifiedBy.Name,EnterpriseID__c,Sub_Category__c,Retrofit_Amount__c,Retrofit_Case__c,Related_Claim__c,Response_Due_Date__c,
                Claim_Status__c,Expected_Closing_Date__c,Open_Date__c,Date_Problem_Was_First_Detected__c,Sending_Settlement_letter__c,Root_Cause_Summary__c,Other_Information__c,Corrective_Actions_Summary__c,Manufacturer_Accepts_Full_Responsibility__c,Total_Claim_Cost__c,
                Total_Cost_To_Be_Claimed__c, Claim_Type__c,Override_Claim_Type__c,Services_Loss__c, Materials_Factory_Loss__c,Materials_Field_Loss__c,Materials_Hub_Loss__c,    Technical_Details_Review_Approval__c,   Nonconformance_Costs_Review_Approval__c,
                Legal_Team_Review_Approval__c,Commodity_Manager_Review_Approval__c,Root_Cause_Analysis_Approved_Date__c,Non_Conformance_Costs_Approved_Date__c, Legal_Analysis_Approved_Date__c,Commodity_Manager_Approved_Date__c, Amount__c,Payment_Time_period__c,
                Method_of_Payment__c,Validated_Payments_Total__c,Confirmed_Write_Offs__c,Confirmed_Payments__c,(select id,IsNote,Title from NotesAndAttachments) from MCAR_Claim_Management__c where id =:claimID];        
     manufacturer = [select id,name from MCAR_Manufacturer__c where id=:claim.Manufacturer__c]; 
      NameOfSupplier = manufacturer.name;
     
        /////--------------------------------------Method 1--------------------------------------------------------------/////
        /*
        try
        {
            if(NameOfSupplier.isAlphaSpace())
            {                            
                List<String> elems = NameOfSupplier.split(' ');        
                NameOfSupplier = ''; 
                for (String x : elems)
                {
                    x = x.toLowerCase();
                    NameOfSupplier += x.substring(0,1).toUpperCase()+x.substring(1,x.length()) + ' ';
                } 
            }           
        }
        catch(Exception e)
        {
            
        }
            */                    
        ////-----------------------------------------------------------------------------------------------------/////                   
        try
            {                
                    List<String> elems = NameOfSupplier.split(' ');        
                    NameOfSupplier = ''; 
                    
                    for (String x : elems)
                    {
                         
                        if(x.length()<=3 || !(x.isAlphaSpace()))
                        {
                            NameOfSupplier += x + ' '; 
                        }
                        else
                        {
                            x = x.toLowerCase(); 
                            NameOfSupplier += x.substring(0,1).toUpperCase()+x.substring(1,x.length()) + ' ';
                        }
                        
                    }                                                           
                system.debug('***My Value***  :'+NameOfSupplier);
            }
            catch(Exception e)
            {
            
            }         
        ////-----------------------------------------------------------------------------------------------------/////
        
        
   // facility = [select name from MCAR_Facility__c where id=:claim.Facility__c];    
     getAllNotesandattachments();
     
                
   /*  if(claim.Colour_Status__c.contains('Claims_Red'))        
            colorStatus = 'Claims_Red';        
        else if(claim.Colour_Status__c.contains('Claim_Green'))
            colorStatus = 'Claim_Green';
        else if(claim.Colour_Status__c.contains('Claim_Yellow'))            
            colorStatus = 'Claim_Yellow';
            else if(claim.Colour_Status__c == null)            
            colorStatus = 'Claim_Yellow';
            */
        
    }
    
    
    

    
    
  public void getAllNotesandattachments()
  {
    List<NoteAndAttachment> listDocuments = claim.NotesAndAttachments ;
    listNotesAttchment = new list<MCARClaimNotesandAttchment>();
    if(listDocuments!=null && listDocuments.size()>0)
    {
        for(NoteAndAttachment NA : listDocuments){
            MCARClaimNotesandAttchment m = new MCARClaimNotesandAttchment();
            m.Title = na.Title;
            if(na.isnote==true)
            {
               m.URL= 'https://cs22.salesforce.com/'+na.id;
                
            }else{
                 m.URL = 'https://c.cs22.content.force.com/servlet/servlet.FileDownload?file='+na.Id;
            }
            listNotesAttchment.add(m);
        }
    }
    
  }  
  
public class MCARClaimNotesandAttchment
{
public String Title {get;set;}
public String URL {get;set;}
}

}