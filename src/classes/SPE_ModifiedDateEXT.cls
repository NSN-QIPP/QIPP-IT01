public with sharing class SPE_ModifiedDateEXT {
public Date s{get;set;}
public SPE_ModifiedDateEXT (){
        Date d=system.today();
        s=d.addDays(integer.valueOf(Label.SPE_ScheduleDateModifier));
        system.debug('*********Date'+d);
        
}
}