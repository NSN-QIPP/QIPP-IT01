trigger UpdateUserId on Measurement__c (before insert) 
{
    String strOwner = UserInfo.getUserId();
    List<Measurement__c> listMeasurement = new List<Measurement__c>();
    
    for(Measurement__c updateMeasurement : trigger.new)
    {
        updateMeasurement.UserId__c = strOwner ;
    }


}