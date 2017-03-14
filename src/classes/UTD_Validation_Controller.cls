global class UTD_Validation_Controller
{
 //Webservice integer intNoOfSubmissions;
 WebService static Boolean ValidateUTD(String strUserEmail, String strMesureName, String noSubmissions )
    {
    //System.debug('All the variables ' +----+ strUserEmail +----+ strMesureName );
      
        Boolean bResult = false;
        List<Measurement__c> obj = new List<Measurement__c>();
        obj =  [select Id,No_of_Sbmissions__c  from Measurement__c where 
        User_Name__c =: strUserEmail and
        Name =: strMesureName and
        No_of_Sbmissions__c =:noSubmissions
         ];
        
         //noSubmissions++ ;
         System.debug('Submissions' + noSubmissions);
          update obj;
        System.debug('Obj :'+obj+'--'+obj.size());
        if(noSubmissions.contains('2'))
        {
            System.debug('Entered into the IF Condition..');
            bResult = true;
        }
        System.debug('bResult  : '+bResult);
        return bResult;
    }
    static testMethod void testUTD_Validation_Controller()
     {
        Boolean TempResub = ValidateUTD('sasya.ravi@atos.net','UTD-697', '1');
       // Boolean TempResub = ValidateUTD('TL1193','7.5.1','Customer Support Services','2','2013');
         //Boolean TempResub = ValidateUTD('TL1193','2.9','MME','2','2012');
     }
}