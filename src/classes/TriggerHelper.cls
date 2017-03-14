Public class TriggerHelper{ 
    
    @TestVisible private static boolean alreadyModified = true;
    @TestVisible private static boolean alreadyModified1 = true;
    @TestVisible private static boolean alreadyModified2 = true;
    @TestVisible private static boolean alreadyModified3 = true;
    @TestVisible private static boolean alreadyModified4 = true;
    
    public static boolean checkRecursive_AssignContactsForApprovalProcess(){
        if(alreadyModified4 ){
            alreadyModified4 = false;
            return true;
        }else{
            return alreadyModified4;
        }
    }
    
    public static boolean checkRecursive(){
        if(alreadyModified ){
            alreadyModified = false;
            return true;
        }else{
            return alreadyModified;
        }
    }
    
    public static boolean checkRecursive1(){
        if(alreadyModified1 ){
            alreadyModified1 = false;
            return true;
        }else{
            return alreadyModified1;
        }
    }
    
    public static boolean checkRecursive2(){
        if(alreadyModified2 ){
            alreadyModified2 = false;
            return true;
        }else{
            return alreadyModified2;
        }
    }
    
    public static boolean checkRecursive3(){
        if(alreadyModified3 ){
            alreadyModified3 = false;
            return true;
        }else{
            return alreadyModified3;
        }
    }        
}