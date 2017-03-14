public class QIRSrecordsite
{

    public QIRSrecordsite(ApexPages.StandardController controller) 
    {

    }
     public QIRSrecordsite() 
    {

    }
        /*public String RecordName{ get; set;}   
        public String Site{ get; set;}
        public String CaseOwner{ get; set;}
        public String Business{ get; set;}
        public String AlertType{ get; set;}
        public String SerialNumbers{ get; set;}
        public String ProblemDescription{ get; set;}
        public String Customer{ get; set;}
        public String ExposedBase{ get; set;}
        public String TotalQualitySpillsCost{ get; set;}
        public String Ordersbacklog{ get; set;}
        public String UnitsBacklog{ get; set;}
        public String RevenueBacklog{ get; set;}
        public String DefectivePart{ get; set;}
        public String GrouptoNotify{ get; set;}
        public Date NextCustomerRequestedShipDateCRSD{ get; set;}
        public String OperatorWarningMessage{ get; set;}
        public Datetime LiftedDate{ get; set;}
        public String MasterApprover{ get; set;}
        public String ProcesstoStop{ get; set;}
        public String BusinessGroup{ get; set;}
        public String IssueLevel{ get; set;}
        public String Factory{ get; set;}
        public String ExpectedNumberofreturns{ get; set;}
        public String CustomerImpact{ get; set;}
        public String FactoryDC{ get; set;}
        public date Estimatedclosedate{ get; set;}
        public Decimal Cost{ get; set;}
        public String OrdersImpact{ get; set;}
        public String UnitsImpact{ get; set;}
        public String RevenueImpact{ get; set;}
        public String Symptom{ get; set;}
        public Date ProjectedLiftDate{ get; set;}
        public String ImpactedRegion{ get; set;}
        public String ImpactedCountries{ get; set;}
        public Datetime ClosedDate{ get; set;}
        public String ApprovalComments{ get; set;}
        public String Status{ get; set;}
        public String Supplier{ get; set;}
        public String SupplierPN{ get; set;}
        public String CreatedBy{ get; set;}
        public Datetime CreatedDate{ get; set;}
        public String LastModifiedBy{ get; set;}
        public Boolean Lock_Points_SH_Shipping{ get; set;}
        public Boolean ProductSafety { get; set;}
        public Boolean Yes{ get; set;}
        public string LegacyCode{ get; set;}
        public string color{ get; set;}
        public string OriginalCreatedBy{ get; set;}
        public Datetime OriginalCreationDate{ get; set;}*/
               
        public ID temp{get; set;}
        
        list<QIRS__c> q = new list<QIRS__c>();
        
        public pagereference temp()
        {
        if(ApexPages.currentPage().getParameters().get('id')!=null)
        {   
            temp = ApexPages.currentPage().getParameters().get('id');
           
        }
        
         
         /*if(temp!=null )
            {
                q = [SELECT Name,Site1__c,Status__c,Supplier__c,Original_Creation_Date__c,Original_Created_By__c,PKNI_SBSCode__c,CreatedBy.Name,LastModifiedBy.Name,CreatedDate,Supplier_Pn__c, Process_Owner1__r.Name,Orders_Impact__c,Approval_Comments__c,Closed_Date1__c,Countries__c,Units_Impact__c,Impacted_Region__c,Projected_Lift_Date__c,Revenue_Impact__c,Symptom__c, Business__c, Alert_Type__c, Serial_Numbers__c, Problem_Description1__c, Customer__c,Exposed_Base__c,Total_Quality_Spills_Cost__c,Orders_backlog__c,Units_Backlog__c,Revenue_Backlog__c,Defective_Part__c,Group_to_Notify__c,Next_CRSD__c,Operator_Warning_Message__c,Lifted_Date__c,Master_Approver__c,Process_to_Stop__c,Business_Group__c,Issue_Level__c,Factory__c,Expected_Number_of_return__c,Customer_Impact__c,Factory_DC__c,Estimated_close_date__c,Cost__c,Lock_Points_SH_Shipping__c,Product_Safety__c,Yes__c FROM QIRS__c where id =: temp limit 1];
                          
                RecordName = q[0].Name;
                Site = q[0].Site1__c;
                CaseOwner = q[0].Process_Owner1__r.Name;
                Business = q[0].Business__c;
                AlertType = q[0].Alert_Type__c;
                SerialNumbers = q[0].Serial_Numbers__c;
                ProblemDescription = q[0].Problem_Description1__c;
                Customer = q[0].Customer__c;
                ExposedBase = q[0].Exposed_Base__c;
                TotalQualitySpillsCost = q[0].Total_Quality_Spills_Cost__c;
                Ordersbacklog = q[0].Orders_backlog__c;
                UnitsBacklog = q[0].Units_Backlog__c;
                RevenueBacklog = q[0].Revenue_Backlog__c;
                DefectivePart = q[0].Defective_Part__c;
                GrouptoNotify = q[0].Group_to_Notify__c;
                NextCustomerRequestedShipDateCRSD = q[0].Next_CRSD__c;
                OperatorWarningMessage = q[0].Operator_Warning_Message__c;
                LiftedDate = q[0].Lifted_Date__c;
                MasterApprover = q[0].Master_Approver__c;
                ProcesstoStop = q[0].Process_to_Stop__c;
                BusinessGroup = q[0].Business_Group__c;
                IssueLevel = q[0].Issue_Level__c;
                Factory = q[0].Factory__c;
                ExpectedNumberofreturns = q[0].Expected_Number_of_return__c;
                CustomerImpact = q[0].Customer_Impact__c;
                FactoryDC = q[0].Factory_DC__c;
                Estimatedclosedate = q[0].Estimated_close_date__c;
                Cost = q[0].Cost__c;
                OrdersImpact = q[0].Orders_Impact__c;
                UnitsImpact = q[0].Units_Impact__c;
                RevenueImpact = q[0].Revenue_Impact__c;
                Symptom = q[0].Symptom__c;
                ProjectedLiftDate = q[0].Projected_Lift_Date__c;
                ImpactedRegion = q[0].Impacted_Region__c;
                ImpactedCountries = q[0].Countries__c;
                ClosedDate = q[0].Closed_Date1__c;
                ApprovalComments = q[0].Approval_Comments__c;
                Lock_Points_SH_Shipping = q[0].Lock_Points_SH_Shipping__c;
                ProductSafety = q[0].Product_Safety__c;
                Yes = q[0].Yes__c;
                Status = q[0].Status__c;
                Supplier = q[0].Supplier__c;
                CreatedBy = q[0].CreatedBy.Name;
                CreatedDate = q[0].CreatedDate;
                LastModifiedBy = q[0].LastModifiedBy.Name;
                SupplierPN = q[0].Supplier_Pn__c;
                LegacyCode = q[0].PKNI_SBSCode__c;     
                if([select Name from User where ID =: q[0].Original_Created_By__c].size()>0)           
                {
                    OriginalCreatedBy = [select Name from User where ID =: q[0].Original_Created_By__c].Name;
                    OriginalCreationDate = q[0].Original_Creation_Date__c;
                }
                else
                {
                    OriginalCreatedBy = q[0].CreatedBy.Name;
                    OriginalCreationDate =q[0].CreatedDate;
                }
                
                //if(status=='Lifted')
                if(status=='Released')
                color='yellow';
                if(status=='Open')
                color='red';
                if(status=='Closed')
                color='yellowgreen';
                if(status=='Submited to Master Approval')
                color='Orange';
                if(status=='Canceled')
                color='pink';
                return null;
            }*/
            return null;
        }
        List<QIRS_Action_Plan__c> lstQIRS_Action_Plan = new List<QIRS_Action_Plan__c>();
        public List<QIRS_Action_Plan__c> getactionPlans()
        {
            //if(!q.isEmpty())
            lstQIRS_Action_Plan = [select Name, Action_Type__c, Champion__c, Required_date__c, Approver__c, Status__c, QIRS__c,CreatedDate from QIRS_Action_Plan__c where
            QIRS__c =: temp ORDER BY Name desc];
            //lstQIRS_Action_Plan = [select Name, Action_Type__c, Champion__c, Required_date__c, Approver__c, Status__c, QIRS__c from QIRS_Action_Plan__c where QIRS__c =: q[0].Id ORDER BY Name desc];
            return lstQIRS_Action_Plan;
        }
            
        public List<QIRS__History> gethistory()
        {
            List<QIRS__History> lstHistory = new List<QIRS__History>();
            //if(!q.isEmpty())
            lstHistory = [Select ParentId, OldValue, NewValue, IsDeleted, Id, Field, CreatedDate, CreatedById From QIRS__History where ParentId =: temp];
            //lstHistory = [Select ParentId, OldValue, NewValue, IsDeleted, Id, Field, CreatedDate, CreatedById From QIRS__History where ParentId =: q[0].Id];
            return lstHistory;
        }  
        
               

        public List<QIRS_Product_Identification__c> getProductIdentification()
        {
            List<QIRS_Product_Identification__c> lstQIRS_Product_Identification = new List<QIRS_Product_Identification__c>();
            //if(!q.isEmpty())
            lstQIRS_Product_Identification = [select Name, Product_Name__c, Technology__c, CreatedBy.Name,CreatedDate, QIRS__c from QIRS_Product_Identification__c where QIRS__c =: temp ORDER BY Name desc];
            //lstQIRS_Product_Identification = [select Name, Product_Name__c, Technology__c, CreatedBy.Name,CreatedDate, QIRS__c from QIRS_Product_Identification__c where QIRS__c =: q[0].Id ORDER BY Name desc];
            return lstQIRS_Product_Identification;
        } 
        

        public List<QIRS_MCAR__c> getMCAR()
        {
            List<QIRS_MCAR__c> lstQIRS_MCAR = new List<QIRS_MCAR__c>();
            //if(!q.isEmpty())
            lstQIRS_MCAR = [select MCAR_Code__c,CreatedBy.Name,QIRS__c from QIRS_MCAR__c where QIRS__c =: temp ORDER BY Name desc];
            //lstQIRS_MCAR = [select MCAR_Code__c,CreatedBy.Name,QIRS__c from QIRS_MCAR__c where QIRS__c =: q[0].Id ORDER BY Name desc];
            return lstQIRS_MCAR;
        }
        

        public List<QIRS_Cost__c> getCosta()
        {
            List<QIRS_Cost__c> lstQIRS_Cost = new List<QIRS_Cost__c>();

            //if(!q.isEmpty())
            lstQIRS_Cost = [Select CurrencyIsoCode, CreatedDate, Cost__c, Comments__c, Category__c From QIRS_Cost__c where QIRS__c =: temp ORDER BY Name desc];
            //lstQIRS_Cost = [Select CurrencyIsoCode, CreatedDate, Cost__c, Comments__c, Category__c From QIRS_Cost__c where QIRS__c =: q[0].Id ORDER BY Name desc];            
            return lstQIRS_Cost;
        }
        

        public List<QIRS_Status__c> getStatuss()
        {
            List<QIRS_Status__c> lstQIRS_Status = new List<QIRS_Status__c>();
            //if(!q.isEmpty())
            lstQIRS_Status = [Select Status__c, CreatedDate, CreatedBy.Name, CreatedById, Comment__c From QIRS_Status__c where QIRS__c =: temp ORDER BY CreatedDate asc];
            //lstQIRS_Status = [Select Status__c, CreatedDate, CreatedBy.Name, CreatedById, Comment__c From QIRS_Status__c where QIRS__c =: q[0].Id ORDER BY CreatedDate asc];            
            return lstQIRS_Status;
        }
        
        
        
      
        
         
 
}