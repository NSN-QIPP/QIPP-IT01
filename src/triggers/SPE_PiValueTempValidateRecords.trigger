trigger SPE_PiValueTempValidateRecords on SPE_PiValueTemp__c ( before update) {


Set<string> EnterpriseIdSet= new Set<string>(); 
Map<String,string> EnterpriseIDMapIgnorecase= new Map<string,string>();
Set<String> CategorySet= new Set<string>();
Set<String> GeoSet= new Set<string>();
Set<String> BUSet= new Set<string>();
SPE_PIDefinition__c PIscopes= new SPE_PIDefinition__c();
Map<String,string> EidTransformMap= new Map<string,string>();
Map<String,string> CatTransformMap= new Map<string,string>();
Map<String,string> BUTransformMap= new Map<string,string>();
Map<String,string> GeoTransformMap= new Map<string,string>();



PIscopes=[select id,CategoryScope__c,BUScope__c,GeoScope__c from SPE_PIDefinition__c where id=:(trigger.new[0]).PIDefination__c ];
String Catscope=PIscopes.CategoryScope__c;

    for(SPE_EnterpriseIDTransformTable__c s:[select FromValue__c,tovalue__r.name from SPE_EnterpriseIDTransformTable__c limit 20000 ]) 
        EidTransformMap.put(s.FromValue__c.toUpperCase(),s.tovalue__r.name);
        
    
    
    for(account a:[select id,enterpriseId__c from account where ParentId=Null Limit 20000]){
        if(a.enterpriseId__c!=Null && a.enterpriseId__c!=''){
        EnterpriseIdSet.add((a.enterpriseId__c).toUpperCase());
        EidTransformMap.put((a.enterpriseId__c).toUpperCase(),a.enterpriseId__c);    
        }
    } 
    //   Category Maps
    if(Catscope!='All Categories') {
    
        for(SPE_CategoryMaster__c c:[select Category__c,cluster__c,group__c from SPE_CategoryMaster__c]) {
           
            if(Catscope=='Category') {
                if(c.Category__c!=Null && c.Category__c!=''){
                CategorySet.add((c.Category__c).toUpperCase()); 
                CatTransformMap.put((c.Category__c).toUpperCase(),c.Category__c);   
                }
               }
            if(Catscope=='Category Group'){
                if(c.group__c!=Null && c.group__c!=''){
                CategorySet.add((c.group__c).toUpperCase());
                CatTransformMap.put((c.group__c).toUpperCase(),c.group__c);
                }
                }
            if(Catscope=='Category Area'){
                if(c.cluster__c!=Null && c.cluster__c!=''){
                CategorySet.add((c.cluster__c).toUpperCase());    
                CatTransformMap.put((c.cluster__c).toUpperCase(),c.cluster__c);                
                }
                }
        }
        
        if(Catscope=='Category') {
            for(SPE_Category_Transform_Table__c c:[select FromValue__c,ToValue__r.Category__c from SPE_Category_Transform_Table__c where Transform__c='Category'])
                   CatTransformMap.put(c.FromValue__c.toUpperCase(),c.ToValue__r.Category__c); 
        }
        
        if(Catscope=='Category Group') {
            for(SPE_Category_Transform_Table__c c:[select FromValue__c,ToValue__r.Group__c from SPE_Category_Transform_Table__c where Transform__c='Category Group'])
                   CatTransformMap.put(c.FromValue__c.toUpperCase(),c.ToValue__r.Group__c); 
        }
        
        if(Catscope=='Category Area') {
            for(SPE_Category_Transform_Table__c c:[select FromValue__c,ToValue__r.Cluster__c from SPE_Category_Transform_Table__c where Transform__c='Category Area'])
                   CatTransformMap.put(c.FromValue__c.toUpperCase(),c.ToValue__r.Cluster__c); 
        }
        
    }
   
   
    //   Geo Maps
    if(PIscopes.GeoScope__c!='All Markets') {
    
        for(SPE_ProjectMaster__c p:[select Market__c,MarketUnit__c,country__c,Project__c from SPE_ProjectMaster__c ]) {
           
            if(PIscopes.GeoScope__c=='Project') {
                if(p.Project__c!=Null && p.Project__c!=''){
                GeoSet.add(p.Project__c.toUpperCase() );
                GeoTransformMap.put(p.Project__c.toUpperCase(),p.Project__c); 
                }
                }
            if(PIscopes.GeoScope__c=='Country') {
                if(p.country__c!=Null && p.country__c!=''){
                GeoSet.add(p.country__c.toUpperCase());
                GeoTransformMap.put(p.country__c.toUpperCase(),p.country__c); 
                }
                }
            if(PIscopes.GeoScope__c=='Market Unit') {
                if(p.MarketUnit__c!=Null && p.MarketUnit__c!=''){
                GeoSet.add(p.MarketUnit__c.toUpperCase()); 
                GeoTransformMap.put(p.MarketUnit__c.toUpperCase(),p.MarketUnit__c); 
                }
                }
            if(PIscopes.GeoScope__c=='Market') {
                if(p.Market__c!=Null && p.Market__c!=''){
                GeoSet.add(p.Market__c.toUpperCase());
                GeoTransformMap.put(p.Market__c.toUpperCase(),p.Market__c); 
                }
                }                        
        }
        
        if(PIscopes.GeoScope__c=='Market') {
            for(SPE_Geo_Transform_Table__c c:[select FromValue__c,ToValue__r.Market__c from SPE_Geo_Transform_Table__c where Transform__c='Market'])
                   GeoTransformMap.put(c.FromValue__c.toUpperCase(),c.ToValue__r.Market__c); 
        }
        
        if(PIscopes.GeoScope__c=='Market Unit') {
            for(SPE_Geo_Transform_Table__c c:[select FromValue__c,ToValue__r.MarketUnit__c from SPE_Geo_Transform_Table__c where Transform__c='Market Unit'])
                   GeoTransformMap.put(c.FromValue__c.toUpperCase(),c.ToValue__r.MarketUnit__c); 
        }
        
        if(PIscopes.GeoScope__c=='Country') {
            for(SPE_Geo_Transform_Table__c c:[select FromValue__c,ToValue__r.Country__c from SPE_Geo_Transform_Table__c where Transform__c='Country'])
                   GeoTransformMap.put(c.FromValue__c.toUpperCase(),c.ToValue__r.Country__c); 
        }
       
        if(PIscopes.GeoScope__c=='Project') {
            for(SPE_Geo_Transform_Table__c c:[select FromValue__c,ToValue__r.Project__c from SPE_Geo_Transform_Table__c where Transform__c='Project'])
                   GeoTransformMap.put(c.FromValue__c.toUpperCase(),c.ToValue__r.Project__c); 
        } 
    }
    
    
    //   BU Maps
    if(PIscopes.BUScope__c!='All Products') {
    
        for(SPE_BUBL__c b:[select Product__c,BusinessUnit__c,BusinessLine__c from SPE_BUBL__c]) {
           
            if(PIscopes.BuScope__c=='Product'){
                if(b.Product__c!=Null && b.Product__c!=''){
                BUSet.add(b.Product__c.toUpperCase());
                BUTransformMap.put(b.Product__c.toUpperCase(),b.Product__c);
                }
                }
            if(PIscopes.BuScope__c=='Business Unit') {
                 if(b.BusinessUnit__c!=Null && b.BusinessUnit__c!=''){
                BUSet.add(b.BusinessUnit__c.toUpperCase());
                BUTransformMap.put(b.BusinessUnit__c.toUpperCase(),b.BusinessUnit__c);
                }
                }
            if(PIscopes.BuScope__c=='Business Line') {
                if(b.BusinessLine__c !=Null && b.BusinessLine__c !=''){
                BUSet.add(b.BusinessLine__c.toUpperCase() );
                BUTransformMap.put(b.BusinessLine__c.toUpperCase(),b.BusinessLine__c );
                }
                }                    
        }
        
        if(PIscopes.BuScope__c=='Product') {
            for(SPE_Product_Transform_Table__c c:[select FromValue__c,ToValue__r.Product__c from SPE_Product_Transform_Table__c where Transform__c='Product'])
                   BUTransformMap.put(c.FromValue__c.toUpperCase(),c.ToValue__r.Product__c); 
        }
        
        if(PIscopes.BuScope__c=='Business Unit') {
            for(SPE_Product_Transform_Table__c c:[select FromValue__c,ToValue__r.BusinessUnit__c from SPE_Product_Transform_Table__c where Transform__c='Business Unit'])
                   BUTransformMap.put(c.FromValue__c.toUpperCase(),c.ToValue__r.BusinessUnit__c); 
        }
        
        if(PIscopes.BuScope__c=='Business Line') {
            for(SPE_Product_Transform_Table__c c:[select FromValue__c,ToValue__r.BusinessLine__c from SPE_Product_Transform_Table__c where Transform__c='Business Line'])
                   BUTransformMap.put(c.FromValue__c.toUpperCase(),c.ToValue__r.BusinessLine__c); 
        }
        
    }
    
    
   // Trigger.new loop 
    for(SPE_PiValueTemp__c newRecords :trigger.new)  {
        if(newRecords.enterpriseId__c!=Null && EidTransformMap.containsKey((newRecords.enterpriseId__c).toUpperCase()))
            newRecords.enterpriseId__c=EidTransformMap.get((newRecords.enterpriseId__c).toUpperCase());
            
            if(newRecords.enterpriseId__c!=Null && EnterpriseIdSet.contains((newRecords.enterpriseId__c).toUpperCase()) ) {
                newRecords.VerrifiedEnterpriseID__c=true;
                newRecords.enterpriseId__c=EidTransformMap.get((newRecords.enterpriseId__c).toUpperCase());
            }
           
            if(Catscope!='All Categories'){
                     if(Catscope=='Category'){ 
                           if(CatTransformMap.containsKey((newRecords.category__c).toUpperCase()))
                                newRecords.category__c=CatTransformMap.get((newRecords.category__c).toUpperCase());
                                
                           if(CategorySet.contains((newRecords.category__c).toUpperCase()) && newRecords.category__c!=Null){
                                newRecords.ValidateCategory__c=true;
                                newRecords.category__c=CatTransformMap.get((newRecords.category__c).toUpperCase());
                                }    
                      }               
                     
                      if(Catscope=='Category Area'){
                            if(CatTransformMap.containsKey(newRecords.Cluster__c.toUpperCase()))
                                 newRecords.Cluster__c=CatTransformMap.get(newRecords.Cluster__c.toUpperCase());        
                                        
                            if(CategorySet.contains(newRecords.Cluster__c.toUpperCase()) && newRecords.Cluster__c!=Null) {
                                 newRecords.ValidateCategory__c=true;
                                 newRecords.Cluster__c=CatTransformMap.get((newRecords.Cluster__c).toUpperCase());
                                 }
                      }
                     
                      if(Catscope=='Category Group'){
                            if(CatTransformMap.containsKey(newRecords.categorygroup__c.toUpperCase()))
                                 newRecords.categorygroup__c=CatTransformMap.get(newRecords.categorygroup__c.toUpperCase());
                     
                            if(CategorySet.contains(newRecords.categorygroup__c.toUpperCase()) && newRecords.categorygroup__c!=Null){
                                newRecords.ValidateCategory__c=true;      
                                newRecords.categorygroup__c=CatTransformMap.get((newRecords.categorygroup__c).toUpperCase());
                                }          
                     }           
             } else {
            
            newRecords.ValidateCategory__c=true;
            newRecords.Cluster__c = PicklistDefaultValues__c.getall().values()[0].Category_Area__c;
            newRecords.categorygroup__c = PicklistDefaultValues__c.getall().values()[0].Category_Group__c;
            newRecords.category__c = PicklistDefaultValues__c.getall().values()[0].Category__c;
            }
            
            
            if(PIscopes.GeoScope__c!='All Markets') {
                 if(PIscopes.GeoScope__c=='Project'){
                     if(GeoTransformMap.containsKey(newRecords.project__c.toUpperCase()))
                        newRecords.project__c=GeoTransformMap.get(newRecords.project__c.toUpperCase());
                     
                     if(GeoSet.contains(newRecords.project__c.toUpperCase()) && newRecords.project__c!=Null){
                         newRecords.project__c=GeoTransformMap.get(newRecords.project__c.toUpperCase());
                         newRecords.Verified_Geo__c=true;
                     }   
                     }
                 
                 if(PIscopes.GeoScope__c=='Country'){
                     if(GeoTransformMap.containsKey(newRecords.country__c.toUpperCase()))
                            newRecords.country__c=GeoTransformMap.get(newRecords.country__c.toUpperCase());
                     
                     if(GeoSet.contains(newRecords.country__c.toUpperCase()) && newRecords.country__c!=Null) {
                            newRecords.Verified_Geo__c=true;
                            newRecords.country__c=GeoTransformMap.get(newRecords.country__c.toUpperCase());
                      }       
                 }        
                  
                 if(PIscopes.GeoScope__c=='Market Unit') {
                     if(GeoTransformMap.containsKey(newRecords.MarketUnit__c.toUpperCase()))
                             newRecords.MarketUnit__c=GeoTransformMap.get(newRecords.MarketUnit__c.toUpperCase());
                     if(GeoSet.contains(newRecords.MarketUnit__c.toUpperCase()) && newRecords.MarketUnit__c!=Null){
                             newRecords.Verified_Geo__c=true;
                             newRecords.MarketUnit__c=GeoTransformMap.get(newRecords.MarketUnit__c.toUpperCase());
                     }        
                 }                     
                  
                 if(PIscopes.GeoScope__c=='Market') {
                     if(GeoTransformMap.containsKey(newRecords.market__c.toUpperCase()))
                           newRecords.market__c=GeoTransformMap.get(newRecords.market__c.toUpperCase());
                     if(GeoSet.contains(newRecords.market__c.toUpperCase()) && newRecords.market__c!=Null ){
                           newRecords.Verified_Geo__c=true;   
                           newRecords.market__c=GeoTransformMap.get(newRecords.market__c.toUpperCase());                
                     }
                 }                         
            } else {
            
            newRecords.Verified_Geo__c=true;
            newRecords.market__c = PicklistDefaultValues__c.getall().values()[0].Market__c;
            newRecords.MarketUnit__c = PicklistDefaultValues__c.getall().values()[0].Market_Unit__c;
            newRecords.country__c = PicklistDefaultValues__c.getall().values()[0].Country__c;
            newRecords.project__c = PicklistDefaultValues__c.getall().values()[0].Project__c;
            }
            
            
            if(PIscopes.BUScope__c!='All Products') {
                 if(PIscopes.BUScope__c=='Product') {
                 
                     if(BUTransformMap.containsKey(newRecords.product__c.toUpperCase()))
                                 newRecords.product__c=BUTransformMap.get(newRecords.product__c.toUpperCase());
                                 
                     if(BUSet.contains(newRecords.product__c.toUpperCase()) && newRecords.product__c!=Null) {
                         newRecords.Verified_BU__c=true;
                         newRecords.product__c=BUTransformMap.get(newRecords.product__c.toUpperCase());
                     }    
                 }
                  
                if(PIscopes.BUScope__c=='Business unit'){
                
                     if(BUTransformMap.containsKey(newRecords.BusinessUnit__c.toUpperCase()))
                           newRecords.BusinessUnit__c=BUTransformMap.get(newRecords.BusinessUnit__c.toUpperCase());
                     if(BUSet.contains(newRecords.BusinessUnit__c.toUpperCase()) && newRecords.BusinessUnit__c!=Null){
                           newRecords.Verified_BU__c=true;
                            newRecords.BusinessUnit__c=BUTransformMap.get(newRecords.BusinessUnit__c.toUpperCase());
                     }    
                }
                
               if(PIscopes.BUScope__c=='Business Line'){
               
                     if(BUTransformMap.containsKey(newRecords.BusinessLine__c.toUpperCase()))
                           newRecords.BusinessLine__c=BUTransformMap.get(newRecords.BusinessLine__c.toUpperCase());
                     if(BUSet.contains(newRecords.BusinessLine__c.toUpperCase()) && newRecords.BusinessLine__c!=Null){
                           newRecords.BusinessLine__c=BUTransformMap.get(newRecords.BusinessLine__c.toUpperCase());
                           newRecords.Verified_BU__c=true;
                     }      
               }                       
                                                      
            } else {
            
            newRecords.Verified_BU__c=true;
            newRecords.BusinessUnit__c = PicklistDefaultValues__c.getall().values()[0].Business_Unit__c;
            newRecords.BusinessLine__c = PicklistDefaultValues__c.getall().values()[0].Business_Line__c;
            newRecords.product__c = PicklistDefaultValues__c.getall().values()[0].Product__c;
            } 
            
            // period Transformation
            if(newRecords.Period__c!=''){
                if(newRecords.DateFormat__c=='MM/DD/YYYY') {
                    try{
                    list<string> s=new list<string>();
                    newRecords.Period__c=newRecords.Period__c.replace('-','/');
                    s=newRecords.Period__c.split('/');
                    integer inputdate=integer.valueOf(s[1]);
                    integer monthVal=integer.valueOf(s[0]);
                    if(s[2].length()==2)
                    {
                     s[2]=string.valueof(20)+s[2];   
                    }
                    integer yearVal=integer.valueOf(s[2]);
                    
                    system.debug('********Year'+yearVal+'********month'+monthVal);
                    Date newDate = date.newInstance(yearVal,monthVal,inputdate);
                    //Date newDate = date.newInstance(2015,2,7);
                    newRecords.Period1__c=newDate ;
                    }
                
                    catch(exception e){
               
                    } 
               }   
               
               //for date format PMMYYYY
               if(newRecords.DateFormat__c=='PMMYYYY') {
                    try{
                    integer inputdate=7;
                    integer monthVal=integer.valueOf(newRecords.Period__c.SubString(1,3));
                    integer yearVal=integer.valueOf(newRecords.Period__c.SubString(3,7));
                    system.debug('********Year'+yearVal+'********month'+monthVal);
                    Date newDate = date.newInstance(yearVal,monthVal,inputdate);
                    //Date newDate = date.newInstance(2015,2,7);
                    newRecords.Period1__c=newDate ;
                    }
                
                    catch(exception e){
               
                    } 
               } 
               //END date format PMMYYYY  
               
               
                //for date format MM/DD/YYYY
               if(newRecords.DateFormat__c=='DD/MM/YYYY') {
                    try{
                    list<string> s=new list<string>();
                    newRecords.Period__c=newRecords.Period__c.replace('-','/');
                    s=newRecords.Period__c.split('/');
                    integer inputdate=integer.valueOf(s[0]);
                    integer monthVal=integer.valueOf(s[1]);
                    if(s[2].length()==2)
                    {
                     s[2]=string.valueof(20)+s[2];   
                    }
                    integer yearVal=integer.valueOf(s[2]);
                    
                    system.debug('********Year'+yearVal+'********month'+monthVal);
                    Date newDate = date.newInstance(yearVal,monthVal,inputdate);
                    //Date newDate = date.newInstance(2015,2,7);
                    newRecords.Period1__c=newDate ;
                    }
                
                    catch(exception e){
               
                    } 
               } 
               //END date format PMMYYYY  
          }
                
         if(newRecords.Verified_Geo__c && newRecords.Verified_BU__c && newRecords.ValidateCategory__c && newRecords.VerrifiedEnterpriseID__c){
             newRecords.Verified__c = true;
         }
                      
    }
    
}