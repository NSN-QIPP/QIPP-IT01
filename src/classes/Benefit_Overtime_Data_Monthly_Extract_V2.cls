public class Benefit_Overtime_Data_Monthly_Extract_V2{
    public String emailTo {get; set;}
    public datetime fromdate{get; set;}
    public datetime todate {get; set;}
    public String query;
    //user currentuser;
    
    public Benefit_Overtime_Data_Monthly_Extract_V2(){
        fromdate = DateTime.newInstanceGMT(2014,01,01,00,00,0); // From :: 2014
        todate = DateTime.newInstanceGMT(2019,01,01,00,00,0); // To :: 2018
        //currentuser=[Select Id,Name,Email from User where Id=:userinfo.getuserId()];
        emailTo  = Userinfo.getuseremail();
    }

    public void SendEmail(){ 
        Boolean flag = false;
        String uRoleId = UserInfo.getUserRoleId();
        system.debug('User Role Id '+uRoleId );
        
        List<UserRole> roleId= [Select Id,DeveloperName from UserRole where DeveloperName =: 'QIPP_Project_Lead' LIMIT 1];
        String UserroleId= roleId[0].Id;
        system.debug('====++++USERROLEID====='+UserroleId);
        
        
        
        if(String.isNotBlank(emailTo)) {
            String  emailRegex      = '([a-zA-Z0-9_\\-\\.]+)@((\\[a-z]{1,3}\\.[a-z]{1,3}\\.[a-z]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})';
            Pattern emailPattern    = Pattern.compile(emailRegex);
            Matcher emailMatcher    = emailPattern.matcher(emailTo.trim());
            flag                    = emailMatcher.matches();
            if(flag && emailTo != Userinfo.getuseremail() && uRoleId==UserroleId)
                flag = false;
        }
        If(flag==true && uRoleId != UserroleId && emailTo == Userinfo.getuseremail()){   
            Benefit_Overtime_Data_Monthly_Extract_B1  id = new Benefit_Overtime_Data_Monthly_Extract_B1 (emailto,fromdate,todate);
            id.query = 'select ID,Name,Project_ID__r.name,Project_ID__r.createddate from QIPP_Benefit__c where Project_ID__r.name != null and Project_ID__r.createddate >= :fromdate and Project_ID__r.createddate < :todate';
            if(!Test.isRunningTest()){
                database.executebatch(id);  
            } 
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.info,'Report Sent To Your Email : '+emailTo)); 
            emailTo = '';
        }
        //else ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You cannot send this report to an email address not associated with your QIPP user account'));   
        else{
       if(emailTo != Userinfo.getuseremail() && uRoleId != UserroleId){
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You cannot send this report to an email address not associated with your QIPP user account'));
       }
       if(uRoleId == UserroleId){
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You Dont have access to Send the Report'));
           
       }
     }
    }
    public PageReference Backtopreviouspage(){
        PageReference returnPage ;
       // returnPage.setRedirect(true);
       /* Map<string,string> URLParameters = ApexPages.currentPage().getParameters();
            system.debug('URLParameters :: '+ URLParameters); 
        if(URLParameters.containsKey('retURL')){
            returnPage= new PageReference(URLParameters.get('retURL'));
        }else{
        returnPage= new PageReference('/home/home.jsp');
        }*/
        returnPage= new PageReference('/home/home.jsp');        
        return returnPage ;        
    }    
}