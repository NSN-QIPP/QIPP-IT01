trigger QIPP_Benefit_Report on QIPP_BU_Reporting__c  ( before insert, before update,before delete,after insert, after update,after delete){
    // if(!BenefitingBusinessGroupController.dontFire){
    Trigger_Control__c s = Trigger_Control__c.getInstance(UserInfo.getUserId());
    if(s.Run_Triggers__c){        
        /* Start :: insert or update Benefit History Tracking records */
        list<QIPP_Benefit_History_Tracking__c> bhtupsert = new list<QIPP_Benefit_History_Tracking__c>();
        //list<QIPP_BU_Reporting__c> blineiteams = new list<QIPP_BU_Reporting__c>();
        list<QIPP_Benefit_History_Tracking__c> bht = new list<QIPP_Benefit_History_Tracking__c>();
        if(trigger.isafter){
            if(trigger.isinsert || trigger.isupdate){
                 bht = [select id,Benefit__c,Benefit_Line_Item__c,History_Tracking_For_Line_Items__c,History_Tracking_For_Initial_Line_Items__c,Is_Deleted__c from QIPP_Benefit_History_Tracking__c where Benefit_Line_Item__c in:Trigger.newMap.keySet()];
            }else if(trigger.isdelete && trigger.isafter){
                 bht = [select id,Benefit__c,Benefit_Line_Item__c,History_Tracking_For_Line_Items__c,History_Tracking_For_Initial_Line_Items__c,Is_Deleted__c from QIPP_Benefit_History_Tracking__c where Benefit_Line_Item__c in:Trigger.oldMap.keySet()];
            }       
            map<id,QIPP_Benefit_History_Tracking__c> mapbht = new map<id,QIPP_Benefit_History_Tracking__c>();      
            for(QIPP_Benefit_History_Tracking__c ht : bht){
                if (mapbht.containsKey(ht.Benefit_Line_Item__c)){
                    mapbht.put(ht.Benefit_Line_Item__c,ht);
                }
            }
            system.debug('Benefit History Tracking size --- '+bht.size()+'-----BHT'+bht);
                
            if(trigger.isinsert){                 
                for(QIPP_BU_Reporting__c bli : trigger.new){
                    QIPP_Benefit_History_Tracking__c bht1 = new QIPP_Benefit_History_Tracking__c();
                    string historytrack;
                    historytrack = bli.Quarters__c+' '+':'+' '+bli.Years__c+' '+':'+' '+bli.Benefit_Condition__c+' '+'amount'+' '+bli.Benefit_Savings_Amount__c;
                    bht1.Benefit__c= bli.Benefit_ID__c;
                    bht1.Benefit_Line_Item__c=bli.id;
                    bht1.History_Tracking_For_Line_Items__c = historytrack;
                    bht1.History_Tracking_For_Initial_Line_Items__c = historytrack;//******Only for insert/created records
                    bhtupsert.add(bht1);
                }                
            }  
            if(trigger.isupdate){
                for(QIPP_BU_Reporting__c bli : trigger.new){
                    QIPP_Benefit_History_Tracking__c bht1 = new QIPP_Benefit_History_Tracking__c();
                    bht1 = mapbht.get(bli.id);
                    if(bht1 != null ){
                        string historytrack;
                        historytrack = bli.Quarters__c+' '+':'+' '+bli.Years__c+' '+':'+' '+bli.Benefit_Condition__c+' '+'amount'+' '+bli.Benefit_Savings_Amount__c;
                        bht1.Benefit__c= bli.Benefit_ID__c;
                        bht1.Benefit_Line_Item__c=bli.id;
                        bht1.History_Tracking_For_Line_Items__c = historytrack;
                        bhtupsert.add(bht1);
                    }else{
                        
                    }
                    
                }
            }else{//list<QIPP_Benefit_History_Tracking__c> bhtinsertdelete = new list<QIPP_Benefit_History_Tracking__c>();
                if(trigger.isdelete){//Before Delete
                    for(QIPP_BU_Reporting__c bli : trigger.old){
                        QIPP_Benefit_History_Tracking__c bht1 = new QIPP_Benefit_History_Tracking__c();
                        bht1 = mapbht.get(bli.id);
                        if(bht1 != null ){
                            string historytrack;
                            historytrack = bli.Quarters__c+' '+':'+' '+bli.Years__c+' '+':'+' '+bli.Benefit_Condition__c+' '+'amount'+' '+bli.Benefit_Savings_Amount__c;
                            bht1.Benefit__c= bli.Benefit_ID__c;
                            bht1.Benefit_Line_Item__c=bli.id;
                            bht1.History_Tracking_For_Line_Items__c = historytrack;
                            bhtupsert.add(bht1);
                        }
                    }
                }
            }
            if(bhtupsert.size()>0){
                upsert bhtupsert;
                system.debug('Upsert records'+bhtupsert);
            }
        }
        /* END :: insert or update Benefit History Tracking records */
        
        /*Start ::  Insert or update Benefiting Business Group records  */
        map<string, List<QIPP_BU_Reporting__c  >> ObjMap = new map<string, List<QIPP_BU_Reporting__c  >>();
        Set<id> projectIDs = new Set<ID>();
        if(trigger.isBefore){
            system.debug('trigger.old :'+trigger.old);
            system.debug('trigger.new :'+trigger.new);
            If(trigger.old!=trigger.new){
                QIPPBenefit.insertWhenchanged=true;
            }
            else{
                QIPPBenefit.insertWhenchanged=false;
            }
            system.debug('insertWhenchanged'+QIPPBenefit.insertWhenchanged);
        }
        
        if(!trigger.isDelete){    
            for(QIPP_BU_Reporting__c   benifit: Trigger.new){        
                system.debug('benifit :'+benifit);
                if (benifit.project_id__C != Null){
                    if(ObjMap.get(benifit.project_id__c) == null){
                        ObjMap.put(benifit.project_id__c,new List<QIPP_BU_Reporting__c >());
                    }
                    ObjMap.get(benifit.project_id__c).add(benifit);            
                }
                if (benifit.project_id__C != Null){
                    projectIDs.add(benifit.project_id__C);
                    system.debug('projectIDs'+projectIDs);
                } 
            }
            system.debug('ObjMap'+ObjMap);
        }else{
            for(QIPP_BU_Reporting__c   benifit: Trigger.old){        
                system.debug('benifit :'+benifit);
                if (benifit.project_id__C != Null){
                    if(ObjMap.get(benifit.project_id__c) == null){
                        ObjMap.put(benifit.project_id__c,new List<QIPP_BU_Reporting__c >());
                    }
                    ObjMap.get(benifit.project_id__c).add(benifit);            
                }
                if (benifit.project_id__C != Null){
                    projectIDs.add(benifit.project_id__C);
                }
            }
        }
        
        List<Benefiting_Business_Group__c > bbgrec = [SELECT Id,project_number__c,Operational_Validation_Amount__c,Financial_Validation_Amount__c,Projected_Validation_Amount__c,project_id__C ,Realized_Validation_Amount__c,Project_BG__c 
                                                      FROM Benefiting_Business_Group__c WHERE project_id__C IN :ObjMap.KeySet()];
        system.debug('bbgrec :'+bbgrec);         
        List<Benefiting_Business_Group__c > bbgRecTrue = new List<Benefiting_Business_Group__c>();
        List<Benefiting_Business_Group__c > bbgRecFalse = new List<Benefiting_Business_Group__c>();
        
        for(Benefiting_Business_Group__c bgrec : bbgrec){
            if(bgrec.Project_BG__c){
                bbgRecTrue.add(bgrec);
            }else{
                bbgRecFalse.add(bgrec);
            }
        }
        
        Map<string,List<QIPP_BU_Reporting__c  >> bbgRecMethodologyMap = new Map<string,List<QIPP_BU_Reporting__c  >>();     
        Set<QIPP_BU_Reporting__c > benfrecSet =new Set<QIPP_BU_Reporting__c >([SELECT Achieved_Operational_Savings_k__c,Future_Operational_Savings_k__c,Achieved_Financial_Savings_k__c,Future_Financial_Savings_k__c,Achieved_Projected_Savings_k__c,Future_Projected_Savings_k__c,Achieved_Realized_Savings_k__c,Future_Realized_Savings_k__c,Project_ID__c,Benefit_Type__c FROM QIPP_BU_Reporting__c where Month__c != '' and project_id__C IN :ObjMap.KeySet()]);
        system.debug('benfrecSet :'+benfrecSet);
        for(QIPP_BU_Reporting__c benf : benfrecSet){
            if(bbgRecMethodologyMap.get(benf.benefit_Type__c) == null){
                bbgRecMethodologyMap.put(benf.benefit_Type__c,new List<QIPP_BU_Reporting__c>());             
            }
            bbgRecMethodologyMap.get(benf.benefit_Type__c).add(benf);
        }
        
        Set<Benefiting_Business_Group__c> bbgrecupdate = new Set<Benefiting_Business_Group__c>();
        List<Benefiting_Business_Group__c> bbgrecdelete = new List<Benefiting_Business_Group__c>();
        
        for(Benefiting_Business_Group__c bbgc: bbgRecTrue){
            system.debug('Original BBGC  ---:'+bbgc);
            Benefiting_Business_Group__c bbgRec2 = bbgc;
            if(bbgRec2 == null){
                bbgRec2  = new Benefiting_Business_Group__c();
            }
            try{
                system.debug('bbgc.project_id__c'+bbgc.project_id__c);
                system.debug('bbgc.ObjMap'+ObjMap);
                //String BBGprojid=string.valueof(bbgc.project_id__c); commented by Haripriya
                // system.debug('BBGprojid'+BBGprojid);
                //String Bbgcprojectid=BBGprojid.substring(0,15);  commented by Haripriya
                // system.debug('Bbgcprojectid'+Bbgcprojectid);
                //string BBGCrecid;  commented by Haripriya
                /*if(bbgc.project_number__c.contains('DMAIC')||bbgc.project_number__c.contains('Lean')){
BBGCrecid=BBGprojid;
}
else{
BBGCrecid=Bbgcprojectid;
}*/
                system.debug('ObjMap'+ObjMap);
                Set<QIPP_BU_Reporting__c> newBenfitRec = New Set<QIPP_BU_Reporting__c>(ObjMap.get(bbgc.project_id__c));
                system.debug('newBenfitRec'+newBenfitRec);
                for(QIPP_BU_Reporting__c bnfit : newBenfitRec ){
                    if(bbgRec2.Operational_Validation_Amount__c == null){
                        bbgRec2.Operational_Validation_Amount__c =0.0;
                    }
                    if(bbgRec2.Financial_Validation_Amount__c == null){
                        bbgRec2.Financial_Validation_Amount__c =0.0;
                    }
                    if(bbgRec2.Projected_Validation_Amount__c == null){
                        bbgRec2.Projected_Validation_Amount__c =0.0;
                    }
                    if(bbgRec2.Realized_Validation_Amount__c == null){
                        bbgRec2.Realized_Validation_Amount__c =0.0;
                    }
                    if(!Trigger.isDelete){
                        bbgRec2.Operational_Validation_Amount__c = bnfit.Achieved_Operational_Savings_k__c+bnfit.Future_Operational_Savings_k__c;
                        bbgRec2.Financial_Validation_Amount__c = bnfit.Achieved_Financial_Savings_k__c+bnfit.Future_Financial_Savings_k__c;
                        bbgRec2.Projected_Validation_Amount__c = bnfit.Achieved_Projected_Savings_k__c+bnfit.Future_Projected_Savings_k__c;
                        bbgRec2.Realized_Validation_Amount__c = bnfit.Achieved_Realized_Savings_k__c+bnfit.Future_Realized_Savings_k__c;
                        
                        system.debug('bbgRec2.Operational_Validation_Amount__c  1:'+bbgRec2.Operational_Validation_Amount__c);
                        system.debug('bbgRec2.Financial_Validation_Amount__c 1 :'+bbgRec2.Financial_Validation_Amount__c);
                        system.debug('bbgRec2.Projected_Validation_Amount__c 1 :'+bbgRec2.Projected_Validation_Amount__c );
                        system.debug('bbgRec2.Realized_Validation_Amount__c :1'+bbgRec2.Realized_Validation_Amount__c );
                        
                        for(QIPP_BU_Reporting__c existingRec : benfrecSet ) {
                            if(existingRec.id != bnfit.id ){
                                bbgRec2.Operational_Validation_Amount__c = bbgRec2.Operational_Validation_Amount__c+existingRec.Achieved_Operational_Savings_k__c+existingRec.Future_Operational_Savings_k__c;
                                bbgRec2.Financial_Validation_Amount__c = bbgRec2.Financial_Validation_Amount__c +existingRec.Achieved_Financial_Savings_k__c+existingRec.Future_Financial_Savings_k__c;
                                bbgRec2.Projected_Validation_Amount__c = bbgRec2.Projected_Validation_Amount__c +existingRec.Achieved_Projected_Savings_k__c+existingRec.Future_Projected_Savings_k__c;
                                bbgRec2.Realized_Validation_Amount__c = bbgRec2.Realized_Validation_Amount__c +existingRec.Achieved_Realized_Savings_k__c+existingRec.Future_Realized_Savings_k__c;
                            }
                            //system.debug('bbgRec2.Operational_Validation_Amount__c  for:'+bbgRec2.Operational_Validation_Amount__c);
                            //system.debug('bbgRec2.Financial_Validation_Amount__c for :'+bbgRec2.Financial_Validation_Amount__c);
                            //system.debug('bbgRec2.Projected_Validation_Amount__c for :'+bbgRec2.Projected_Validation_Amount__c );
                            //system.debug('bbgRec2.Realized_Validation_Amount__c :'+bbgRec2.Realized_Validation_Amount__c );
                        }
                    }else{
                        system.debug('bnfit.id :'+bnfit.id);
                        system.debug('OldMap :'+Trigger.oldMap);
                        QIPP_BU_Reporting__c  oldRec = Trigger.oldMap.get(bnfit.id);
                        system.debug('bbgRec2 :'+bbgRec2);
                        system.debug('oldRec :'+oldRec );
                        
                        bbgRec2.Operational_Validation_Amount__c =0.0;
                        bbgRec2.Financial_Validation_Amount__c =0.0;
                        bbgRec2.Projected_Validation_Amount__c =0.0;
                        bbgRec2.Realized_Validation_Amount__c =0.0;
                        
                        benfrecSet.removeAll(Trigger.Old);
                        
                        for(QIPP_BU_Reporting__c existingRec : benfrecSet ) {
                            system.debug('existingRec'+existingRec);
                            if(!New Set<QIPP_BU_Reporting__c>(Trigger.Old).contains(existingRec) && existingRec.id != bnfit.id  ){
                                bbgRec2.Operational_Validation_Amount__c = bbgRec2.Operational_Validation_Amount__c+existingRec.Achieved_Operational_Savings_k__c+existingRec.Future_Operational_Savings_k__c;
                                bbgRec2.Financial_Validation_Amount__c = bbgRec2.Financial_Validation_Amount__c +existingRec.Achieved_Financial_Savings_k__c+existingRec.Future_Financial_Savings_k__c;
                                bbgRec2.Projected_Validation_Amount__c = bbgRec2.Projected_Validation_Amount__c +existingRec.Achieved_Projected_Savings_k__c+existingRec.Future_Projected_Savings_k__c;
                                bbgRec2.Realized_Validation_Amount__c = bbgRec2.Realized_Validation_Amount__c +existingRec.Achieved_Realized_Savings_k__c+existingRec.Future_Realized_Savings_k__c;
                            }
                        }
                    }
                    if(QIPPBenefit.insertWhenchanged==true){ 
                        bbgrecupdate.add(bbgRec2 );
                    }
                }
            }catch(exception e){
                system.debug('Error :'+e.getMessage());
                system.debug('Reason:'+e.getCause());
                system.debug('Reason:'+e.getStackTraceString());
            }
        }
        for(Benefiting_Business_Group__c bbgcfalse: bbgRecFalse){
            try{
                if(QIPPBenefit.insertWhenchanged==true){
                    bbgrecdelete.add(bbgcfalse);
                }
            }
            catch(exception e){
                system.debug('Error :'+e.getMessage());
                system.debug('Reason:'+e.getCause());
                system.debug('Reason:'+e.getStackTraceString());
            }
        }
        system.debug('bbgrecupdate size*******'+bbgrecupdate.size());
        if(bbgrecupdate.size() > 0){
            try{
                upsert new List<Benefiting_Business_Group__c>(bbgrecupdate);
            }catch(exception e){
                system.debug('Error :'+e.getMessage());
                system.debug('Reason:'+e.getCause());
                system.debug('Reason:'+e.getStackTraceString());
            }
        }
        if(bbgrecdelete.size()>0){
            try{
                delete bbgrecdelete;
            }catch(exception e){
                system.debug('Error :'+e.getMessage());
                system.debug('Reason:'+e.getCause());
                system.debug('Reason:'+e.getStackTraceString());
            }
        }
        
        /*End ::  Insert or update Benefiting Business Group records  */
        
        
        //-- R17.3 E063-spread over 12 month- Start--//
        if(trigger.isAfter){
            Set<String> projIDSet = new Set<String>();
            Map<String,QIPP_Project__c> projectMap = new Map<String,QIPP_Project__c>();
            List<QIPP_Project__c> updProjList = new List<QIPP_Project__c>();

            for(QIPP_BU_Reporting__c bu: Trigger.isDelete ? Trigger.Old : Trigger.new){
                projIDSet.add(bu.Project_ID__c);
            }
            system.debug('@@projIDSet:'+projIDSet);

            if(projIDSet != null && projIDSet.size() > 0){
                Map<String,List<QIPP_BU_Reporting__c>> projToBenRepoMap = new Map<String,List<QIPP_BU_Reporting__c>>();
                projectMap = new Map<String,QIPP_Project__c>([SELECT id,Benefit_Spread_Over_Year__c FROM QIPP_Project__c WHERE Id IN: projIDSet]);
                
                List<QIPP_BU_Reporting__c> allBuLineList = [Select Id,Years__c,Months__c,Benefit_ID__c,Project_ID__c,Benefit_Savings_Amount__c,Benefits_Saving_Amount_Achieved__c From QIPP_BU_Reporting__c Where Project_ID__c In: projIDSet];
                //if(allBuLineList != null && allBuLineList.size() > 0){
                    List<QIPP_BU_Reporting__c> buList;
                    for(QIPP_BU_Reporting__c bu : allBuLineList){
                        if(projToBenRepoMap != null && projToBenRepoMap.get(bu.Project_ID__c) != null){
                            buList = projToBenRepoMap.get(bu.Project_ID__c);
                        }else{
                            buList = new List<QIPP_BU_Reporting__c>();
                        }
                        buList.add(bu);
                        projToBenRepoMap.put(bu.Project_ID__c,buList);
                    }
                    for(String prjId : projIDSet){
                        if(!projToBenRepoMap.containsKey(prjId)){
                            projToBenRepoMap.put(prjId,new List<QIPP_BU_Reporting__c>());
                        }
                    }
                    system.debug('@@projToBenRepoMap:'+projToBenRepoMap);
                    
                    if(projToBenRepoMap != null && projToBenRepoMap.size() > 0){
                        QIPP_Project__c proj;
                        for(String projId : projToBenRepoMap.keySet()){
                            List<QIPP_BU_Reporting__c> buLineList = projToBenRepoMap.get(projId);
                            
                            if(buLineList != null && buLineList.size() > 0){
                                List<Date> orderedDate = new List<Date>();
                                List<QIPP_BU_Reporting__c> benfitLineList = new List<QIPP_BU_Reporting__c>();
                                
                                for(QIPP_BU_Reporting__c bl : buLineList){ // add line only if validation amount is more than 0
                                    if((bl.Benefits_Saving_Amount_Achieved__c + bl.Benefit_Savings_Amount__c) > 0){
                                        benfitLineList.add(bl);
                                    }
                                }
                                system.debug('@@projId:'+projId);
                                system.debug('@@benfitLineList:'+benfitLineList);
                                
                                if(benfitLineList != null && benfitLineList.size() > 0){
                                    for(QIPP_BU_Reporting__c bl : benfitLineList){
                                        Date dt = Date.newInstance(Integer.valueOf(bl.Years__c), Integer.valueOf(bl.Months__c), 01);
                                        orderedDate.add(dt);
                                    }
                                    if(orderedDate != null && orderedDate.size() > 0){
                                        orderedDate.sort();
                                        Date oldestDate = orderedDate.get(0);
                                        Date latestDate = orderedDate.get(orderedDate.size()-1);
                                        system.debug('@@Oldest:'+oldestDate+'---@@Latest:'+latestDate);
                                        
                                        Integer monthDiff = Integer.valueOf(oldestDate.monthsBetween(latestDate))+1;
                                        system.debug('@@monthDiff:'+monthDiff);
                                        
                                        if(projectMap != null && projectMap.containsKey(projId)){
                                            proj = projectMap.get(projId);
                                            if(monthDiff > 12){
                                                proj.Benefit_Spread_Over_Year__c = true;
                                            }else{
                                                proj.Benefit_Spread_Over_Year__c = false;
                                            }
                                            updProjList.add(proj);
                                        }
                                    }
                                }
                            }else{    // delete benefit record, not for benefit line
                                if(projectMap != null && projectMap.containsKey(projId)){
                                    proj = projectMap.get(projId);
                                    proj.Benefit_Spread_Over_Year__c = false;
                                    updProjList.add(proj);
                                }
                            }
                        }
                    }
                //}
            }
            system.debug('@@updProjList:'+updProjList);
            if(updProjList != null && updProjList.size() > 0){
                update updProjList;
            }
        }
        //-- R17.3 E063-spread over 12 month- End--//
    }                        
}