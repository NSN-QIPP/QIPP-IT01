trigger AssignCDTLeadName on QIPP_Portfolio__c (before insert , before update, before delete) 
{
    List<Id> portfolioIds = new List<Id>();

//prevent deletion for portfolios those associated with projects
if(Trigger.isDelete){   
   for(QIPP_Portfolio__c oldPortfolio : Trigger.old){
        List<QIPP_Project__c> exstPrjRecords = [select id, Portfolio_Name__c from QIPP_Project__c where Portfolio_Name__c =: oldPortfolio.id];
        if(exstPrjRecords.size() > 0){
            oldPortfolio.adderror('Portfolio cannot be deleted because it contains projects');
        }
    }
}    
    
if(Trigger.isInsert || Trigger.isUpdate){

    for(QIPP_Portfolio__c portfolio : Trigger.New)
    {

        if(portfolio.CDT_Lead__c != null)
        {
          QIPP_Contacts__c CONTACT = [select Name from QIPP_Contacts__c where Id =:  portfolio.CDT_Lead__c];
          if(CONTACT != null)
          {
              portfolio.CDT_Lead_Name__c = CONTACT.Name ;
          }   
        }
        
        portfolioIds.add(portfolio.id);

    }
    
    /* Added as part of R15-4 Req #065*/
    List<QIPP_Project__c> projects = [select Name,Project_State__c,Project_Type__c from QIPP_Project__c where Portfolio_Name__c in :portfolioIds];
    for(QIPP_Portfolio__c portfolio1:Trigger.New)
    {
        boolean prjStatusCheck = false;
        boolean existCDT = false;
        boolean existDMAIC = false;
        boolean existA3 = false;
        boolean exist8D = false;
        boolean existRCA = false;
        boolean existOther = false;
        boolean existDI = false;
        boolean existLean = false;
        
        if(portfolio1.Portfolio_Status__c == 'Inactive' && projects.size() == 0){
            portfolio1.Portfolio_Status__c.addError('Portfolio cannot be statused as inactive because it contains no projects.');            
            break;
        }    

        for(QIPP_Project__c prj:projects)
        {   
            if(prj.Project_State__c == 'In Progress' || prj.Project_State__c == 'On Hold' || prj.Project_State__c == 'Complete' || prj.Project_State__c == 'Not Started'){
            prjStatusCheck = false;
            break;
            }
            if(prj.Project_State__c == 'Canceled' || prj.Project_State__c == 'Closed') 
            prjStatusCheck = true;

        }
            if(portfolio1.Portfolio_Status__c == 'Inactive' && !prjStatusCheck){
                portfolio1.Portfolio_Status__c.addError('Portfolio Status cannot be Inactive since the associated projects are not closed or cancelled.');            
            }
        //start:R15-4:Req69    
        for(QIPP_Project__c prj1:projects)
        {   
            if(prj1.Project_Type__c == 'CDT') existCDT = true;
            if(prj1.Project_Type__c == 'DMAIC' || prj1.Project_Type__c == 'DMADV') existDMAIC = true;
            if(prj1.Project_Type__c == 'A3') existA3 = true;
            if(prj1.Project_Type__c == '8D') exist8D = true;
            if(prj1.Project_Type__c == 'RCA/EDA') existRCA = true;
            if(prj1.Project_Type__c == 'Other') existOther = true;
            if(prj1.Project_Type__c == 'DI (CoPQ)') existDI = true;
            if(prj1.Project_Type__c == 'Lean (including Kaizen)') existLean = true;                                                                        
        }
            if(portfolio1.DMAIC_DMADV__c == false && existDMAIC){
                portfolio1.DMAIC_DMADV__c.addError('This cannot be unchecked because there is one or more projects using this methodology in the portfolio');            
            }                    
            if(portfolio1.CDT__c == false && existCDT){
                portfolio1.CDT__c.addError('This cannot be unchecked because there is one or more projects using this methodology in the portfolio');            
            }                    
            if(portfolio1.A3__c == false && existA3){
                portfolio1.A3__c.addError('This cannot be unchecked because there is one or more projects using this methodology in the portfolio');            
            }                    
            if(portfolio1.X8D__c == false && exist8D){
                portfolio1.X8D__c.addError('This cannot be unchecked because there is one or more projects using this methodology in the portfolio');            
            }                    
            if(portfolio1.RCA_EDA__c == false && existRCA){
                portfolio1.RCA_EDA__c.addError('This cannot be unchecked because there is one or more projects using this methodology in the portfolio');            
            }                    
            if(portfolio1.Other__c == false && existOther){
                portfolio1.Other__c.addError('This cannot be unchecked because there is one or more projects using this methodology in the portfolio');            
            }                    
            if(portfolio1.DI_CoPQ__c == false && existDI){
                portfolio1.DI_CoPQ__c.addError('This cannot be unchecked because there is one or more projects using this methodology in the portfolio');            
            }                    
            if(portfolio1.Lean_including_Kaizen__c == false && existLean){
                portfolio1.Lean_including_Kaizen__c.addError('This cannot be unchecked because there is one or more projects using this methodology in the portfolio');            
            }
            
    }
}    
}