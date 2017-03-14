public class QIPPRenderReport
{
public String countries {get;set;}
public String hyperlinkval {get;set;}
public String selectedLink {get;set;}
public QIPP_Project__c  account{get;set;}
public String returnpath {get;set;}
String strReportName = '';

public QIPPRenderReport(ApexPages.StandardController stdController)
{
    account = new QIPP_Project__c();
    String previouspath = ApexPages.currentPage().getParameters().get('F');

    if(previouspath == 'CDT')
    {
        countries = 'CDT'; 
        hyperlinkval = 'QIPPCDTReport' ;
        account.Report_Type__c = 'CDT';
        account.Report_Name__c = 'CDT Report';
        
    }
    else if(previouspath  == 'SOI')
    {
        countries = 'TIR'; 
        hyperlinkval = 'QIPPSumOfIssueAge' ;
        account.Report_Type__c = 'TIR';
        account.Report_Name__c = 'Customers by Sum Of Issue Age';
    }
    else if(previouspath  == 'QLT')
    {
        countries = 'Executive Dashboards'; 
        hyperlinkval = 'QIPPProjectsByQLTFunction' ;
        account.Report_Type__c = 'Executive Dashboards';
        account.Report_Name__c = 'Summary of Projects by QLT Function';
    }
    else if(previouspath  == 'PType')
    {
        countries = 'Executive Dashboards'; 
        hyperlinkval = 'QIPPProjectsByProjectType' ;
        account.Report_Type__c = 'Executive Dashboards';
        account.Report_Name__c = 'Summary of Projects by Project Type ';
    }
    else if(previouspath  == 'OIA')
    {
        countries = 'TIR'; 
        hyperlinkval = 'QIPPHighCustomerOpen' ;
        account.Report_Type__c = 'TIR';
        account.Report_Name__c = 'Customers By Open Issue Age';
    }
    else if(previouspath  == 'PortName')
    {
        countries = 'Executive Dashboards'; 
        hyperlinkval = 'QIPPProjectsByPortfolioName' ;
        account.Report_Type__c = 'Executive Dashboards';
        account.Report_Name__c = 'Summary of Projects by Portfolio Name';
    }
}
public QIPPRenderReport()
{}
public PageReference test() 
    {

        if((account.Report_Name__c == null || account.Report_Name__c == '--NONE--')  && (account.Report_Type__c == null || account.Report_Type__c == '--NONE--'))
        {
          hyperlinkval = '';
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select Report Type and Report Name.'));
        }        
        else if(account.Report_Name__c == null && account.Report_Type__c != null)
        {
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select Report Name.')); 
          hyperlinkval = '';
        }        
        else
        {
         if(account.Report_Name__c.equalsIgnoreCase('CDT Report'))
             strReportName = 'QIPPCDTReport';
         if(account.Report_Name__c.equalsIgnoreCase('Customers by Sum Of Issue Age'))
             strReportName = 'QIPPSumOfIssueAge';    
         if(account.Report_Name__c.equalsIgnoreCase('Customers By Open Issue Age'))
             strReportName = 'QIPPHighCustomerOpen'; 
         if(account.Report_Name__c.equalsIgnoreCase('Summary of Projects by Project Type'))
             strReportName = 'QIPPProjectsByProjectType';         
         if(account.Report_Name__c.equalsIgnoreCase('Summary of Projects by QLT Function'))
             strReportName = 'QIPPProjectsByQLTFunction';         
         if(account.Report_Name__c.equalsIgnoreCase('Summary of Projects by Portfolio Name'))
             strReportName = 'QIPPProjectsByPortfolioName';         
         hyperlinkval = strReportName;
        }
        return null;
    }
}