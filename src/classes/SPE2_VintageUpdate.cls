/**************************************************************************************
Apex Class Name:  SPE2_VintageUpdate
Version     : 1.0 
Created Date    : 10 March 2016
Function    : Trigger to Update the field vintage on SPE plan based on the earliest tracker 
Modification Log :
-----------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* Vishal Verma              10/03/2016              Original Version
*************************************************************************************/
Public without sharing Class SPE2_VintageUpdate{
/*
 * Method name  : returnPlanDate
 * Description  : Returns a Map with ids and their corresponding values
 * Return Type  : Map<id,String>
 * Parameter    : Set<id>
 */
 Public static Map<id,String> returnPlanDate(Set<id> speTrackerIds){
     list<SPE_SPETracker__c> SPETrackerList = new List<SPE_SPETracker__c>();
     Map<id,list<Date>> mplanwithTrack =new Map<id,list<Date>>();
     Map<String,Integer> mapDateValues = new Map<string, Integer> {
        'January' => 01,
        'February' => 02,
        'March' => 03,
        'April' => 04,
        'May' => 05,
        'June' => 06,
        'July' => 07,
        'August' => 08,
        'September' => 09,
        'October' => 10,
        'November' => 11,
        'December' => 12 
    };
    String str1,str2,str3;

    SPETrackerList = [select id,name,DateOfExecution__c,SPEPlan__c FROM SPE_SPETracker__c WHERE SPEPlan__c  IN :speTrackerIds AND Status__c ='Completed' ];
    System.debug('&&Test&123====>'+SPETrackerList);
    System.debug('&&Test12345678==>'+speTrackerIds);
    //****Populating the map to find out the individual plan with their corresponding trcaker***
    for(SPE_SPETracker__c speTrckr :SPETrackerList){
        if(!mplanwithTrack.containskey(speTrckr.SPEPlan__c)){
            mplanwithTrack.put(speTrckr.SPEPlan__c,new list<Date>{});
        }
        String trackerName = speTrckr.name;
        Integer yearVal = integer.valueOf(trackerName.split('-')[1].replace(' ',''));
        Integer monthVal = mapDateValues.get(trackerName.split('-')[0].replace(' ',''));
        Date trakerDateVal = date.newinstance(yearVal,monthVal, 25);
        mplanwithTrack.get(speTrckr.SPEPlan__c).add(trakerDateVal );          
    }
    system.debug('&&&&Test&&&&'+mplanwithTrack);
    Map<id,String> mplanwithTrackEarly = new Map<id,String>();
    
    List<Date> ld=new List<Date>();
    //*******Finding the earliset tracket***
    for(Id planId :mplanwithTrack.keySet()){
        List<Date> earlyDateList = mplanwithTrack.get(planId);
        Date dt = Date.newInstance(2099, 12, 31);
        Date recentDt = Date.newInstance(1600, 12, 31);
        system.debug('Date_test'+dt);
        for(Date d :earlyDateList){
            if(d < dt){
                dt = d;
            }
            if(d > recentDt){
                recentDt = d;
            } 
        }
        String StrDat;
        if (dt.month() <= 9)
            StrDat = '0' + String.ValueOf(dt.month());
        else 
            StrDat =   String.ValueOf(dt.month()); 
        
        //****Concatenating the string to obtain the required date format****
        String earlyDateFormatted = dt.year() + ' ' +'P'+ StrDat; 
        
        system.debug('TestEarlyTest'+mplanwithTrackEarly);
        system.debug('TestEarlyTest===='+dt);
        date myDate = date.newInstance(dt.year(),1,dt.month());
        system.debug('VinUp'+myDate);
        mplanwithTrackEarly.put(planId,earlyDateFormatted+'~'+myDate+'~'+recentDt);
    }
    return mplanwithTrackEarly;
    
   }
   /*private Static Date regularizeMon(Date dat){
    return Integer.valueOf(dat) > 9 ? dat:'0'+dat;
    }*/
}