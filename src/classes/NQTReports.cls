public class NQTReports
{
    
    /*********************************************************************************/
    public NQTReports() {
        CPRList = new list<CPR__c>();
        Res = new list<CPR__c>();
        allCPR = new list<CPR__c>();
        CPR = new CPR__c();
        CPR.Area1__c = '[ALL]';
        CPR.Market1__c = '[ALL]';
        CPR.Reports_To__c = date.Today();
        TableLog = FALSE;
        TableMetrices = FALSE;
        Quote = FALSE;
        VF = TRUE;
        XL = FALSE;
        pageLink = FALSE;
        InputButtons = TRUE;
        check_SOQL = 0;
        check_get = 0;
        check_getS = 0;
        All = 'ALL';
        //if(CPRList != NULL)
            //CPRRes = new ApexPages.StandardSetController(CPRList);
    }

    
    /*********************************************************************************/
    public NQTReports(ApexPages.StandardController controller) {

    }
    
    /*********************************************************************************/
    public CPR__c CPR{ get; set; }
    public List<CPR__c> CPRList{ get{if(CPRRes != null)  
                                            return (List<CPR__c>)CPRRes.getRecords();  
                                        else  
                                            return null ;} set;}
    public String All{ get; set; }
    public String ProductCategory{ get; set; }
    public String TextOrExcel{ get; set; }
    public Boolean InputButtons{ get; set;}
    public Boolean XL{ get; set; }
    public Boolean VF{ get; set; }
    public Boolean pageLink{ get; set; }
    public Boolean TableLog{ get; set;}
    public Boolean Quote{ get; set;}
    public Boolean TableMetrices{ get; set;}
    transient List<NQT_Holiday_Management__c> HM{ get; set;}
    public integer check_SOQL{ get; set;}
    public integer check_get{ get; set;}
    public integer check_getS{ get; set;}
    public list<CPR__c> Res{ get; set;}
    public double percent{ get; set; }
    public list<CPR__c> allCPR{ get; set; }
//Instantiate the StandardSetController  
    public ApexPages.StandardSetController CPRRes{get; set;}
//Boolean to check if there are more records after the present displaying records
    public Boolean hasNext  
    {  
        get  
        {  
            return CPRRes.getHasNext();  
        }  
        set;  
    }
//Boolean to check if there are more records before the present displaying records  
    public Boolean hasPrevious  
    {  
        get  
        {  
            return CPRRes.getHasPrevious();  
        }  
        set;  
    }
//Page number of the current displaying records  
    public Integer pageNumber  
    {  
        get  
        {  
            return CPRRes.getPageNumber();  
        }  
        set;  
    }
//Returns the previous page of records  
    public void previous()  
    {  
        CPRRes.previous();  
    }  
   
//Returns the next page of records  
    public void next()  
    {  
        CPRRes.next();  
    }  
    
    
    String[] ProjectStatus = new String[]{};
    String[] Engineer = new String[]{};
    
    
    public String[] getProjectStatus() {
        return ProjectStatus;
        }
            
    public void setProjectStatus(String[] ProjectStatus) {
        this.ProjectStatus = ProjectStatus;
        }
    
    
    public String[] getEngineer() {
        return Engineer;
        }
            
    public void setEngineer(String[] Engineer) {
        this.Engineer = Engineer;
        }
    
    
    /*********************************************************************************/
    public void ChangeMarket() {
        if(CPR.Area1__c == 'ALL')
            CPR.Market1__c = 'ALL';
        else
            CPR.Market1__c = '';
        }
        
    
    /*********************************************************************************/
    public PageReference EngineerCheck() {
        Boolean Check = FALSE;
        if(!Engineer.isEmpty())
            for(String Eng : Engineer)
                if(Eng == '[ALL]')
                    Check = TRUE;
        if(Check == TRUE)
            if(Engineer.size()>1){
                Engineer.clear();
                Engineer.add('[ALL]');
                setEngineer(Engineer);
                Return NULL;
            }
        Return NULL;
        }
    
    /*********************************************************************************/    
    public integer  QuoteLog(){
        Boolean ErrCheck = FALSE;
        if(CPR.Reports_From__c == NULL){
            CPR.Reports_From__c.addError('Please enter a date.');
            ErrCheck = TRUE;
            system.debug('##############################################################################'+ErrCheck );
            }
        if(CPR.Reports_To__c == NULL){
            CPR.Reports_To__c = date.Today();
            //ErrCheck = TRUE;
            }
        if(CPR.Reports_To__c < CPR.Reports_From__c){
            CPR.Reports_To__c.addError('\'To date\' should be greater than \'From date\'');
            ErrCheck = TRUE;
            }
        system.debug('##############################################################################'+ErrCheck );
        if(ErrCheck == TRUE)
            return NULL;
        getSearch();
        TableLog = TRUE;
        Quote = TRUE;
        InputButtons = FALSE;
        pageLink = TRUE;
        return NULL;
        }
    
    /*********************************************************************************/     
    public integer  QuoteMetrices(){
        Boolean ErrCheck = FALSE;
        //CPRRes = null;
        //HM = null;
        if(CPR.Reports_From__c == NULL){
            CPR.Reports_From__c.addError('Please enter a date.');
            ErrCheck = TRUE;
            }
        if(CPR.Reports_To__c == NULL){
            CPR.Reports_To__c = date.Today();
            //ErrCheck = TRUE;
            }
        if(CPR.Reports_To__c < CPR.Reports_From__c){
            CPR.Reports_To__c.addError('\'To date\' should be greater than \'From date\'');
            ErrCheck = TRUE;
            }
        if(ErrCheck == TRUE)
            return NULL;
        getSearch();
        Quote = TRUE;
        TableLog = TRUE;
        TableMetrices = TRUE;
        TableLog = FALSE;
        InputButtons = FALSE;
        pageLink = TRUE;
        return NULL;
        }
      
    
    /*********************************************************************************/                       
    public list<CPR__c> getSearch(){
        double yes = 0;
        double no = 0;
        dateTime strt = CPR.Reports_From__c;
        dateTime end1 = CPR.Reports_To__c;
        string area = CPR.Area1__c;
        string market = CPR.Market1__c; 
        String Query = 'SELECT NQT_MTX_Ericsson__c, CPR_Close_Date__c, SEMSC_Assigned_Date__c, SE_Assigned_Date__c, FE_Assigned_Date__c, Quote_to_PO_Cycle_Time__c, Sales_Cycle_Time__c, BusOps_Cycle_Time__c, FE_Cycle_Time__c, SEMSC_Cycle_Time__c, SE_Cycle_Time__c, PM_Cycle_Time__c, Quote_Cycle_Time__c, Met_Customer_Expectation__c, Customer_Requested_Cycle_Time__c, of_Times_CPR_was_Resubmitted__c, Reports_Comments__c, NQT_Market__c, NQT_CPR_Name__c, Name, NQT_CPR_Start_Date__c, NQT_Project_Status__c, CreatedDate, NQT_Requested_Quote_Delivery_Date__c, SE_Submitted_Date__c, NQT_SE__r.Name, SEMSC_Submitted_Date__c, NQT_SE_MSC__r.Name, FE_Submitted_Date__c, NQT_FE__r.Name, BusOps_Submitted_Date__c, Document_Quote__c, Document_Quote_Date__c, NQT_Product__c, NQT_SE_Services__c, NQT_FE_Services__c, NQT_Equipment__c, NQT_Total_PO__c, Document_PO__c, Document_PO_Date__c,PWR_Cycle_Time__c,PWR_Approval_Final_Feedback_Received__c,PWR_Approval_Request_Sent__c FROM CPR__c WHERE CreatedDate >=: strt AND CreatedDate <=: end1 ';
        if(CPR.Area1__c != '' && CPR.Area1__c != 'None')
            if(CPR.Area1__c != '[ALL]')
                Query = Query + 'AND NQT_Area__c =: area ';
        if(CPR.Market1__c != '' && CPR.Market1__c != 'None')
            if(CPR.Market1__c != '[ALL]')
                Query = Query + 'AND NQT_Market__c =: market ';
        if(!ProjectStatus.isEmpty())
            Query = Query + 'AND NQT_Project_Status__c IN: ProjectStatus ';
        else
            ProjectStatus.add('ALL');
        if(Engineer.isEmpty())
            Engineer.add('ALL');
        for(String engg : Engineer){
            if(engg == 'ALL')
                break;
            else{
                if(engg == 'SE')
                    Query = Query + 'AND NQT_SE__c != NULL ';
                if(engg == 'SE-MSC')
                    Query = Query + 'AND NQT_SE_MSC__c != NULL ';
                if(engg == 'FE')
                    Query = Query + 'AND NQT_FE__c != NULL ';
                }
            }
            
        if(ProductCategory == 'MTX-Ericsson')
            Query = Query + 'AND NQT_MTX_Ericsson__c = TRUE ';
        if(ProductCategory == 'MTX')
            Query = Query + 'AND NQT_Product__c INCLUDES (\'MTX\') ';
        //Query = Query + ' ORDER BY 999 ';
        
        //if(check_get != 0 && check_get != 1){
        allCPR = Database.Query(Query);
        for(CPR__c all_cpr : allCPR){
            if(all_cpr.NQT_CPR_Start_Date__c != NULL && all_cpr.NQT_Requested_Quote_Delivery_Date__c != NULL)
                all_cpr.Customer_Requested_Cycle_Time__c = CalcBusDays(all_cpr.NQT_CPR_Start_Date__c, all_cpr.NQT_Requested_Quote_Delivery_Date__c);
            
            if(all_cpr.NQT_CPR_Start_Date__c != NULL && all_cpr.Document_Quote_Date__c != NULL)
                all_cpr.Sales_Cycle_Time__c = CalcBusDays(all_cpr.NQT_CPR_Start_Date__c, all_cpr.Document_Quote_Date__c);
            
            if(all_cpr.Sales_Cycle_Time__c <= all_cpr.Customer_Requested_Cycle_Time__c){
                all_cpr.Met_Customer_Expectation__c = 'YES';
                yes++;
                }
            else
                if(all_cpr.Sales_Cycle_Time__c  != NULL && all_cpr.Customer_Requested_Cycle_Time__c != NULL){
                    all_cpr.Met_Customer_Expectation__c = 'NO';
                    no++;
                    }
            }
        system.debug('*********************************************************************'+yes+'****'+no+allCPR);
        percent_Calc(yes, no);  
        allCPR = new List<CPR__c>();  
        CPRRes = new ApexPages.StandardSetController(Database.getQueryLocator(Query));
        //CPRRes.setPageSize(99);
        //this code is changed by rajesh may 3rd 2012
        CPRRes.setPageSize(500);

        CPRList = CPRRes.getRecords();
        return (list<CPR__c>)CPRRes.getRecords();//}
        
        //check_get++;
        return null;
        
    }
    
    /*********************************************************************************/           
    public list<CPR__c> getSearchResults(){
        //getsearchQuote();
        
        
        if(check_get != 0 && (TableLog == TRUE || TableMetrices == TRUE))
            Res = CPRList.deepClone();
        check_get++;
        
        for(integer i = 0; i < Res.size(); i++){
                Res[i].NQT_Request_Submission_Date_del__c = CPRList[i].CreatedDate;
                Res[i].Project_Id_Backup__c = CPRList[i].Name;
                system.debug('44444444444444444444444444444444444444444444444444444444444444444444'+CPRList[i].Name); 
                }
        
        for(CPR__c CPR : Res){  
        if(CPR.PWR_Approval_Final_Feedback_Received__c!=NULL && CPR.PWR_Approval_Request_Sent__c!=NULL)
            CPR.PWR_Cycle_Time__c=CalcBusDays(CPR.PWR_Approval_Request_Sent__c,CPR.PWR_Approval_Final_Feedback_Received__c);
            System.debug('The value of PWR cycle time is'+CPR.PWR_Cycle_Time__c);
        if(CPR.NQT_CPR_Start_Date__c != NULL && CPR.NQT_Requested_Quote_Delivery_Date__c != NULL)
            CPR.Customer_Requested_Cycle_Time__c = CalcBusDays(CPR.NQT_CPR_Start_Date__c, CPR.NQT_Requested_Quote_Delivery_Date__c);
        if(CPR.NQT_CPR_Start_Date__c != NULL && CPR.Document_Quote_Date__c != NULL)
            CPR.Quote_Cycle_Time__c = CalcBusDays(CPR.NQT_CPR_Start_Date__c, CPR.Document_Quote_Date__c);
        if(CPR.NQT_CPR_Start_Date__c != NULL && CPR.Engineering_Assigned_Date__c != NULL)
            CPR.PM_Cycle_Time__c = CalcBusDays(CPR.NQT_CPR_Start_Date__c, CPR.Engineering_Assigned_Date__c);

        
        system.debug('!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!::::'+CPR.Met_Customer_Expectation__c);
        if(CPR.SE_Submitted_Date__c != NULL && CPR.SE_Assigned_Date__c != NULL)
            CPR.SE_Cycle_Time__c = CalcBusDays(CPR.SE_Assigned_Date__c, CPR.SE_Submitted_Date__c);
        if(CPR.SEMSC_Submitted_Date__c != NULL && CPR.SEMSC_Assigned_Date__c != NULL)
            CPR.SEMSC_Cycle_Time__c = CalcBusDays(CPR.SEMSC_Assigned_Date__c, CPR.SEMSC_Submitted_Date__c);
        if(CPR.FE_Assigned_Date__c != NULL && CPR.FE_Submitted_Date__c != NULL)
            CPR.FE_Cycle_Time__c = CalcBusDays(CPR.FE_Assigned_Date__c, CPR.FE_Submitted_Date__c);
        if(CPR.NQT_CPR_Start_Date__c != NULL && CPR.Document_Quote_Date__c != NULL)
            CPR.Sales_Cycle_Time__c = CalcBusDays(CPR.NQT_CPR_Start_Date__c, CPR.Document_Quote_Date__c);
        if(CPR.Document_Quote_Date__c != NULL && CPR.Quote_Generation_Date__c != NULL)
            CPR.Quote_to_PO_Cycle_Time__c = CalcBusDays(CPR.Quote_Generation_Date__c, CPR.Document_Quote_Date__c);
            if(CPR.Sales_Cycle_Time__c <= CPR.Customer_Requested_Cycle_Time__c){
            CPR.Met_Customer_Expectation__c = 'YES';
            //yes++;
            }
        else
            if(CPR.Sales_Cycle_Time__c  != NULL && CPR.Customer_Requested_Cycle_Time__c != NULL){
                CPR.Met_Customer_Expectation__c = 'NO';
                //no++;
                }
        }
         
        return Res;
        }        
    
    public void percent_Calc(double yes, double no){
        if(yes == 0 && no == 0){
            percent = 0.00;
            return;
            }
        system.debug('***************************************************************************'+yes+'**********'+no);
        percent = (yes/(yes+no))*100;
        }
    
    
    
    /*********************************************************************************/
    public Double CalcBusDays(DateTime StartDt, DateTime EndDt){
        DateTime StartWeek = StartDt.date().toStartofWeek();
        DateTime EndWeek = EndDt.date().toStartofWeek();
        Double WeekEnds = 0;
        Double Remainder = 0;
        
        Remainder = EndDt.hour() - StartDt.hour();
        Remainder = (Remainder/24);
        WeekEnds = StartWeek.date().daysBetween(EndWeek.date())/7;
        WeekEnds = StartDt.date().daysBetween(EndDt.date()) - 2*WeekEnds;
        if(StartWeek == StartDt)
            WeekEnds--;
        if(EndWeek == EndDt)
            WeekEnds--;
        if(EndWeek.addDays(6) == EndDt)
            WeekEnds--;
        if(check_SOQL == 0)
            HM = [SELECT Id FROM NQT_Holiday_Management__c WHERE NQT_Holiday_Date__c >=: StartDt.date() AND NQT_Holiday_Date__c <=: EndDt.date()];
        check_SOQL++;
        if(HM == null)
            return WeekEnds+1+Remainder;
        return WeekEnds+1-HM.size()+Remainder;
    }
    
    
    /*********************************************************************************/
    public List<CPR__c> getSearchQuote(){
        List<CPR__c> CPRQuote = new List<CPR__c>();
        if(check_getS != 0 && TableLog != FALSE){
            CPRQuote = Res.deepClone();
            /*for(integer i = 0; i < CPRQuote.size(); i++){
                CPRQuote[i].NQT_Request_Submission_Date_del__c = CPRList[i].CreatedDate;
                CPRQuote[i].Project_Id_Backup__c = CPRList[i].Name;
                }*/
            }
        check_getS++;
        return CPRQuote;
        }
    
    /*********************************************************************************/
    public void T2E(){
        VF = FALSE;
        XL = TRUE;
        TextOrExcel = 'application/vnd.ms-excel#CPRs From:'+CPR.Reports_From__c.format()+'-To:'+CPR.Reports_To__c.format();        
    }
    
    /*********************************************************************************/
    public void clear(){
        CPR = new CPR__c();
        CPR.Area1__c = 'ALL';
        CPR.Market1__c = 'ALL';
        ProjectStatus.clear();
        Engineer.clear();
        ProductCategory = 'All';
        TableLog = FALSE;
        TableMetrices = FALSE;
        check_SOQL = 0;
        }
        
    /*********************************************************************************/
    public void back(){
        TableMetrices = FALSE;
        TableLog = FALSE;
        Quote = FALSE;
        InputButtons = TRUE;
        //CPRRes = NULL;
        pageLink = FALSE;
        }
        
        
    public void saveComments(){
        integer i = 0;
        for(CPR__c cpr : Res){
            if(cpr.Reports_Comments__c != NULL){
                CPRList[i].NQT_Class_Access_After__c = TRUE;
                CPRList[i].NQT_Class_Access_Before__c = TRUE;
                CPRList[i].Reports_Comments__c = cpr.Reports_Comments__c;
                //cpr.Id = CPRList[i].Id;
                system.debug('((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((('+cpr.Reports_Comments__c);
                update CPRList[i];
                }
            i++;
            }
        }
    
    /*********************************************************************************/
    static testMethod void testNQTReports(){
    
        NQTReports rep = new NQTReports();
        DateTime StartDt = date.today();
        DateTime EndDt = date.today();
        
        
        rep.Engineer.add('FE');
        rep.Engineer.add('SE-MSC');
        rep.Engineer.add('SE');
        rep.ChangeMarket();
        rep.EngineerCheck();
        rep.QuoteLog();
        rep.QuoteMetrices();
        rep.getSearch();
        rep.CalcBusDays(StartDt, EndDt);
        rep.getSearchQuote();
        rep.CPR.Reports_From__c = date.today();
        rep.CPR.Reports_To__c = date.today();
        rep.QuoteMetrices();
        rep.T2E();
        rep.clear();
        rep.back();
        rep.QuoteLog();
        rep.Engineer.add('FE');
        rep.Engineer.add('SE-MSC');
        rep.Engineer.add('SE');
        rep.Engineer.add('ALL');
        rep.EngineerCheck();
        rep.CPR.Area1__c = '';
        rep.ChangeMarket();
        rep.getProjectStatus();
        rep.getEngineer();
        rep.ProjectStatus.add('');
        rep.setProjectStatus(rep.ProjectStatus) ;
        rep.next();
        rep.previous();
        rep.getSearchResults();
        rep.check_get = 2;
        rep.TableLog = TRUE;
        rep.getSearchResults();
        rep.saveComments();
        
        CPR__c CPR = new CPR__c();
        CPR.NQT_If_Other_MTSO__c = NULL;
        CPR.NQT_Database_Work_Description__c = NULL;
        CPR.NQT_Customer_Requested_Ship_Date__c = dateTime.now()+1;
        CPR.NQT_Target_Service_Start_Date__c = date.today()+1;
        CPR.NQT_Target_Service_Finish_Date__c = date.today()+1;
        CPR.NQT_Customer__c = 'VERIZON';
        CPR.NQT_CPR_Name__c = 'a';
        CPR.NQT_Customer_contact_Name__c = 'a';
        CPR.NQT_Customer_Contact_Phone__c = '3333';
        CPR.NQT_Customer_Email_Address__c = 'test@test.com';
        CPR.Reports_From__c = date.today();
        CPR.NQT_Account_manager_Picklist__c = 'Test NQT User AM';
        CPR.NQT_Area__c = 'Mid West';
        CPR.NQT_Market__c = 'St. Clairesville';
        CPR.NQT_MTSO__c = 'St. Clairesville';
        CPR.NQT_Program_Manager_Picklist__c = 'Test NQT User Program Manager1';
        CPR.Reports_To__c = date.today();
        CPR.NQT_Type_Of_Request__c = 'Services Only';
        CPR.NQT_Requested_Quote_Delivery_Date__c = dateTime.now()+1;
        CPR.NQT_MTX_Ericsson__c = TRUE;
        CPR.NQT_if_other__c = 'a';
        CPR.NQT_Product__c = 'BTS';
        
        CPR.NQT_SE__c = [SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_FE__c = [SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_SE_MSC__c = [SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.NQT_Project_Manager__c = [SELECT Id FROM USER WHERE Name LIKE: '%Test%' LIMIT 1].Id;
        CPR.Reports_Comments__c = 'test';
        
        try{insert CPR;}catch(exception e){}
        list<CPR__c> CPRList = new list<CPR__c>();
        CPRList.add(CPR);
        rep.CPRRes = new ApexPages.StandardSetController(CPRList);
        //rep.check_get = 0;
        //rep.TableLog = TRUE;
        rep.getSearchResults();
        try{rep.saveComments();}catch(exception e){}
    }
}