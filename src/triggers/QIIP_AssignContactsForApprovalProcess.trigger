trigger QIIP_AssignContactsForApprovalProcess on QIPP_Project__c (before insert, before update){
    Trigger_Control__c s = Trigger_Control__c.getInstance(UserInfo.getUserId());
    system.debug('Run_Triggers__c :::'+s.Run_Triggers__c);
    if(s.Run_Triggers__c){  //To control trigger at the time of dataloader updates
        if(TriggerHelper.checkRecursive_AssignContactsForApprovalProcess()){  
            list<RecordType> rectyp = [SELECT Id, Name,Description FROM RecordType WHERE sObjectType = 'QIPP_Project__c' and Name in('Methodology: After DMAIC Improve','Methodology: After QIPP DMAIC Control / Verify')];
            system.debug('rectyp :::'+rectyp);
            map<string,id> mry1 = new map<string,id>();
            for(RecordType r :rectyp){
                mry1.put(r.name,r.id);
            }
            Set<Id> protfolioIds = new Set<ID>();
            for(QIPP_Project__c proj:Trigger.new){
                protfolioIds.add(proj.Portfolio_name__c);    
            }
            id  Aftimproveid = mry1.get('Methodology: After DMAIC Improve');
            id  Aftcontrolid = mry1.get('Methodology: After QIPP DMAIC Control / Verify');
            system.debug('mry1 :::'+mry1);
            system.debug('Aftimproveid :::'+mry1.get('Methodology: After DMAIC Improve'));
            system.debug('Aftcontrolid :::'+mry1.get('Methodology: After QIPP DMAIC Control / Verify'));
            
            map<id,QIPP_Portfolio__c> projPortfolioMap = new Map<id,QIPP_Portfolio__c>([select Id,(select id,Email__c,Is_Super_Portfolio__c,QIPP_Contact__c,QIPP_Portfolio__c,DMAIC_DMADV__c,X8D__c,A3__c,CIF__c,DI_Logic__c,Lean_including_Kaizen__c,Other__c,RCA_EDA__c from Portfolios_Owners__r ) from QIPP_Portfolio__c where Id IN: protfolioIds]);
            system.debug('projPortfolioMap***::'+projPortfolioMap);
            
            Set<id> contactids = new Set<id>();
            for(QIPP_Project__c proj:Trigger.new){
                contactids.add(proj.Belt_Candidate_Mentor__c);
                contactids.add(proj.Finance_Approver__c);
                contactids.add(proj.Operational_Savings_Approver__c);
                contactids.add(proj.Business_Unit_Master_Black_Belt__c);
                contactids.add(proj.Project_Owner__c);
                contactids.add(proj.Project_Sponsor__c);
                contactids.add(proj.Belt_Project_Sponsor__c);
                contactids.add(proj.Lean_Coach__c);
                contactids.add(proj.Improvement_Owner__c);
                contactids.add(proj.Project_Lead__c);
                contactids.add(proj.DI_Business_Owner_Delegate__c);
                contactids.add(proj.DI_Business_Owner__c);
                //contactids.add(proj.Portfolio_Owner_Id__c);   
            }
            //List<QIPP_Contacts__c> contacts = null;
            map<id,QIPP_Contacts__c> mapcontacts = new map<id,QIPP_Contacts__c>();
            map<id,Portfolios_Owner__c> mapOwners = new map<id,Portfolios_Owner__c>();
            Set<string> contactemails = new Set<string>();
            if(contactids.size() > 0 && contactids != null){
                for(QIPP_Contacts__c mapcon :[Select id,Email__c,User_License__r.Profile.Name,User_License__c,User_License__r.id,User_License__r.email,User_License__r.IsActive,Contact_BU__c,Contact_BL__c,Contact_L4_Org__c,CoPQ_Role_1__c,CoPQ_Role_2__c,CoPQ_Role_3__c,CoPQ_Role_4__c from QIPP_Contacts__c where Id IN : contactids] ){
                    contactemails.add(mapcon.email__c);
                    mapcontacts.put(mapcon.id,mapcon);          
                }
            }
            if(projPortfolioMap.size()>0){          
                for(Portfolios_Owner__c con :[select id,Email__c,Is_Super_Portfolio__c,QIPP_Contact__c,QIPP_Portfolio__c from Portfolios_Owner__c where QIPP_Portfolio__c =: protfolioIds]){
                    contactemails.add(con.Email__c);
                    mapOwners.put(con.QIPP_Contact__c,con);
                    system.debug('mapOwners'+mapOwners);
                    system.debug('contactemails'+contactemails);
                }
            }
            map<string,user> mapuser = new map<string,user>();
            for(user us : [Select Id,Email,Profile.Name from User where Profile.Name = 'Nokia QIPP Project Lead' and Email =: contactemails and isactive =:True])
            {
                system.debug('us::::'+us);
                mapuser.put(us.email,us);
                system.debug('mapuser::::'+mapuser);
            } 
            
            list<User> portfolioManager = [select id,name,email from user where email=:Label.Porfolio_Manager ]; //Default Portfolio Manager(owner) if portfolio owners not assigned or not assigned any portfolio owner for a methodology 
            for(QIPP_Project__c proj:Trigger.new){  
               system.debug('Run_Triggers__c :::'+s.Run_Triggers__c);
                if(s.Run_Triggers__c){
                    /*
                    // ############# For assigning approver as Belt_Candidate_Mentor__c ############## 
                    QIPP_Contacts__c mentorcontact = mapcontacts.get(proj.Belt_Candidate_Mentor__c);
                    if(mentorcontact != null){
                        user u = mapuser.get(mentorcontact.email__c);
                        if(u == null)
                            proj.Belt_Candidate_Mentor__c.addError('Provided Mentor Contact is not actual Salesforce User');
                        else  
                            proj.Next_Approver__c = u.id;
                            proj.Email_Mentor__c = mentorcontact.email__c;
                            
                    }else{
                        proj.Next_Approver__c = null;
                        proj.Email_Mentor__c = null;
                    }
                    // ############# For assigning approver as Finance_Approver__c ################ 
                    QIPP_Contacts__c financecontact = mapcontacts.get(proj.Finance_Approver__c);
                    if(financecontact != null){
                        user u = mapuser.get(financecontact.email__c);
                        if(u == null)
                            proj.Finance_Approver__c.addError('Provided Finance Approver Contact is not actual Salesforce User');
                        else  
                            proj.Approver_Financial_Approver__c = u.id;
                            proj.Email_Finance_Approver__c = financecontact.email__c;
                            
                    }else{
                        proj.Approver_Financial_Approver__c = null;
                        proj.Email_Finance_Approver__c = null;
                    }
                    */
                    // Start : Updated by Srikanth 10th NOV 2016 **NOte ** Checking these validation in controller side at the time of create and approval request
                    //NOte ** Checking these validation in controller side at the time of create and approval request
                    // ############# For assigning approver as Belt_Candidate_Mentor__c ##############
                    QIPP_Contacts__c mentorcontact = mapcontacts.get(proj.Belt_Candidate_Mentor__c);
                    if(mentorcontact != null){
                        if(mentorcontact.User_License__c != null && mentorcontact.User_License__r.IsActive != false && mentorcontact.User_License__r.Profile.Name == 'Nokia QIPP Project Lead'){
                            proj.Next_Approver__c = mentorcontact.User_License__r.id;
                            proj.Email_Mentor__c = mentorcontact.User_License__r.email;
                        }else{
                            if(trigger.isinsert){
                                proj.Belt_Candidate_Mentor__c.addError('Provided Mentor Contact is not actual Salesforce User');
                            }
                        }
                    }else{
                        proj.Next_Approver__c = null;
                        proj.Email_Mentor__c = null;
                    }
                    
                    Set<String> conroleSet = new Set<String>();   
                    //NOte ** Checking these validation in controller side at the time of create and approval request
                    // ############# For assigning approver as Finance_Approver__c ################                     
                    QIPP_Contacts__c financecontact = mapcontacts.get(proj.Finance_Approver__c);
                    //QIPPCommonFuctionController comm = new QIPPCommonFuctionController();
                    String contactBG = financecontact != null && financecontact.Contact_BU__c != null && financecontact.Contact_BU__c != '' ? financecontact.Contact_BU__c : '';
                    //Set<String> bgvalueset = new Set<String>();
                    /*List<QIPP_Project_Approves_Criteria__mdt> criteriavalues = [Select Id,Is_Active__c,BG_Value__c,Contact_Role__c,Project_Role_Type__c From QIPP_Project_Approves_Criteria__mdt Where Project_Role_Type__c = 'Finance Approver' and Is_Active__c = true];
                    if(criteriavalues != null && criteriavalues.size() > 0){
                        for(QIPP_Project_Approves_Criteria__mdt obj : criteriavalues){
                            conroleSet.add(obj.Contact_Role__c);
                            bgvalueset.add(obj.BG_Value__c);
                        }
                    }
                    */
                    if(financecontact != null){
                        conroleSet.add('Finance Approver');
                        conroleSet.add('Finance Approver Delegate');
                        boolean isValid = false;
                        //system.debug('@@bgvalueset:'+bgvalueset+' @@contactBG:'+contactBG);  
                        //Contact BG values validating 
                        //if(financecontact != null && bgValueSet != null && bgValueSet.size() > 0 && bgValueSet.contains(contactBG)){
                           // isValid = true;
                        //}
                        //Contact role validating 
                        if(financecontact.CoPQ_Role_1__c != null && financecontact.CoPQ_Role_1__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(financecontact.CoPQ_Role_1__c)){
                            isValid = true;
                        }else If(financecontact.CoPQ_Role_2__c != null && financecontact.CoPQ_Role_2__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(financecontact.CoPQ_Role_2__c)){
                            isValid = true;
                        }else If(financecontact.CoPQ_Role_3__c != null && financecontact.CoPQ_Role_3__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(financecontact.CoPQ_Role_3__c)){
                            isValid = true;
                        }else If(financecontact.CoPQ_Role_4__c != null && financecontact.CoPQ_Role_4__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(financecontact.CoPQ_Role_4__c)){
                            isValid = true;
                        }
                        //*******    *******
                        if(financecontact.User_License__c != null && financecontact.User_License__r.IsActive != false && financecontact.User_License__r.Profile.Name == 'Nokia QIPP Project Lead' && isValid ==true){
                            proj.Approver_Financial_Approver__c = financecontact.User_License__r.id;
                            proj.Email_Finance_Approver__c = financecontact.User_License__r.email;
                        }else{
                            if(trigger.isinsert){
                                proj.Finance_Approver__c.addError('Provided \'Finance Approver\' Contact is not actual Salesforce User or not a configured as F&C. Contact your Administrator to get QIPP Salesforce account.');
                            }
                            proj.Approver_Financial_Approver__c = null;
                            proj.Email_Finance_Approver__c = null;
                        }
                    }else{
                        proj.Approver_Financial_Approver__c = null;
                        proj.Email_Finance_Approver__c = null;
                    }                       
                    // END : Updated by Srikanth 10th NOV 2016
                    // Start : Added by Srikanth 10th NOV 2016
                    // ############# For assigning approver as Business_Owner_Delegate ################ 
                    QIPP_Contacts__c BusiOwDelgcontact = mapcontacts.get(proj.DI_Business_Owner_Delegate__c);
                    
                    if(BusiOwDelgcontact != null){
                        boolean isValid = false;
                        conroleSet.add('Business Owner Delegate');
                        if(BusiOwDelgcontact.CoPQ_Role_1__c != null && BusiOwDelgcontact.CoPQ_Role_1__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(BusiOwDelgcontact.CoPQ_Role_1__c)){
                            isValid = true;
                        }else If(BusiOwDelgcontact.CoPQ_Role_2__c != null && BusiOwDelgcontact.CoPQ_Role_2__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(BusiOwDelgcontact.CoPQ_Role_2__c)){
                            isValid = true;
                        }else If(BusiOwDelgcontact.CoPQ_Role_3__c != null && BusiOwDelgcontact.CoPQ_Role_3__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(BusiOwDelgcontact.CoPQ_Role_3__c)){
                            isValid = true;
                        }else If(BusiOwDelgcontact.CoPQ_Role_4__c != null && BusiOwDelgcontact.CoPQ_Role_4__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(BusiOwDelgcontact.CoPQ_Role_4__c)){
                            isValid = true;
                        }
                        system.debug('Business_Owner_Delegate ::::'+BusiOwDelgcontact);
                        if(BusiOwDelgcontact.User_License__c != null && BusiOwDelgcontact.User_License__r.IsActive != false && BusiOwDelgcontact.User_License__r.Profile.Name == 'Nokia QIPP Project Lead' && isValid ==true){
                            proj.DI_Approver_Business_Owner_Delegate__c = BusiOwDelgcontact.User_License__r.id;
                            proj.Business_Owner_Delegate_Email__c = BusiOwDelgcontact.User_License__r.email;
                        }else{
                            if(trigger.isinsert){
                                proj.DI_Business_Owner_Delegate__c.addError('Provided Business Owner Delegate Contact is not actual Salesforce User');
                            }
                            proj.DI_Approver_Business_Owner_Delegate__c = null;
                            proj.Business_Owner_Delegate_Email__c = null;
                        }
                    }else{
                        system.debug('Business_Owner_Delegate ELSE::::'+BusiOwDelgcontact);
                        proj.DI_Approver_Business_Owner_Delegate__c = null;
                        proj.Business_Owner_Delegate_Email__c = null;
                    }
                    // ############# For assigning approver as Business_Owner_ ################
                    QIPP_Contacts__c BusiOwncontact = mapcontacts.get(proj.DI_Business_Owner__c);
                    if(BusiOwncontact != null){
                        boolean isValid = false;
                        conroleSet.add('Business Owner');
                        if(BusiOwncontact.CoPQ_Role_1__c != null && BusiOwncontact.CoPQ_Role_1__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(BusiOwncontact.CoPQ_Role_1__c)){
                            isValid = true;
                        }else If(BusiOwncontact.CoPQ_Role_2__c != null && BusiOwncontact.CoPQ_Role_2__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(BusiOwncontact.CoPQ_Role_2__c)){
                            isValid = true;
                        }else If(BusiOwncontact.CoPQ_Role_3__c != null && BusiOwncontact.CoPQ_Role_3__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(BusiOwncontact.CoPQ_Role_3__c)){
                            isValid = true;
                        }else If(BusiOwncontact.CoPQ_Role_4__c != null && BusiOwncontact.CoPQ_Role_4__c != '' && conroleSet != null && conroleSet.size() > 0 && conroleSet.contains(BusiOwncontact.CoPQ_Role_4__c)){
                            isValid = true;
                        }
                        
                        system.debug('Business_Owner_ ::::'+BusiOwncontact);
                        if(BusiOwncontact.User_License__c != null && BusiOwncontact.User_License__r.IsActive != false && BusiOwncontact.User_License__r.Profile.Name == 'Nokia QIPP Project Lead' && isValid ==true){
                            proj.DI_Approver_Business_Owner__c = BusiOwncontact.User_License__r.id;
                            proj.Business_Owner_Email__c = BusiOwncontact.User_License__r.email;
                        }else{
                            if(trigger.isinsert){
                                proj.DI_Business_Owner__c.addError('Provided Business Owner Contact is not actual Salesforce User');
                            }
                            proj.DI_Approver_Business_Owner__c = null;
                            proj.Business_Owner_Email__c = null;
                        }  
                    }else{
                        system.debug('Business_Owner_ ELSE::::'+BusiOwncontact);
                        proj.DI_Approver_Business_Owner__c = null;
                        proj.Business_Owner_Email__c = null;
                    }
                    // End : Added by Srikanth 10th NOV 2016

                    /* ############# For assigning approver as    Operational_Savings_Approver__c ################ */
                    QIPP_Contacts__c Operationalcontact = mapcontacts.get(proj.Operational_Savings_Approver__c);
                    if(Operationalcontact != null){
                        user u = mapuser.get(Operationalcontact.email__c);
                        if(u == null)
                            proj.Operational_Savings_Approver__c.addError('Provided Operational Savings Approver Contact is not actual Salesforce User');
                        else  
                            proj.Approver_Operational_Savings__c = u.id;
                            proj.Operational_Savings_Approver_Email__c = Operationalcontact.email__c;
                            
                    }else{
                        proj.Approver_Operational_Savings__c = null;
                        proj.Operational_Savings_Approver_Email__c = null;
                    }
                    /* ############ For assigning approver as Business_Unit_Master_Black_Belt__c ########### */
                    QIPP_Contacts__c BUMBBcontact = mapcontacts.get(proj.Business_Unit_Master_Black_Belt__c);
                    if(BUMBBcontact != null){
                        user u = mapuser.get(BUMBBcontact.email__c);
                        if(u == null)
                            proj.Business_Unit_Master_Black_Belt__c.addError('Provided BG MBB Contact is not actual Salesforce User');
                        else  
                            proj.Approver_BU_MBB__c = u.id;
                            proj.Email_BU_MBB__c = BUMBBcontact.email__c;
                            
                    }else{
                        proj.Approver_BU_MBB__c = null;
                        proj.Email_BU_MBB__c = null;
                    }
                    /* ########### For assigning approver as Project Owner for Lean Projects ############# */
                    /*QIPP_Contacts__c POwnercontact = mapcontacts.get(proj.Project_Owner__c);
                    if(POwnercontact != null &&  POwnercontact.Email__c != null){
                        proj.Email_Project_Owner__c = POwnercontact.email__c;
                    }else proj.Email_Project_Owner__c = null;
                    // for L6S projects Project_Sponsor
                    //Added By Srikanth for E035
                    if(proj.Email_Project_Owner__c == null){
                        QIPP_Contacts__c POwnercontact2 = mapcontacts.get(proj.Project_Sponsor__c);
                        if(POwnercontact2 != null &&  POwnercontact2.Email__c != null){
                            proj.Email_Project_Owner__c = POwnercontact2.email__c;
                        }else proj.Email_Project_Owner__c = null;
                        
                    }*/
                    QIPP_Contacts__c POwnercontact = mapcontacts.get(proj.Belt_Project_Sponsor__c);
                    if(POwnercontact != null &&  POwnercontact.Email__c != null){
                        proj.Email_Project_Owner__c = POwnercontact.email__c;
                        proj.Email_Belt_Project_Sponsor__c = POwnercontact.email__c;
                    }else proj.Email_Project_Owner__c = null;
                    // for L6S projects Project_Sponsor
                    //Added By Srikanth for E035
                    if(proj.Email_Project_Owner__c == null){
                        QIPP_Contacts__c POwnercontact2 = mapcontacts.get(proj.Project_Sponsor__c);
                        if(POwnercontact2 != null &&  POwnercontact2.Email__c != null){
                            proj.Email_Project_Owner__c = POwnercontact2.email__c;
                        }else proj.Email_Project_Owner__c = null;
                        
                    }
                    
                    /*if(POwnercontact != null){
                        user u = mapuser.get(POwnercontact.email__c);
                        if(u == null)
                            proj.Project_Owner__c.addError('Provided Project Owner Contact is not actual Salesforce User');
                        else  
                            proj.Approver_Project_Owner__c = u.id;
                            proj.Email_Project_Owner__c = POwnercontact.email__c;
                            
                    }else{
                        proj.Approver_Project_Owner__c = null;
                        proj.Email_Project_Owner__c = null;
                    }*/
                    /* ########### For assigning approver as Lean_Coach for Lean Projects ############# */
                    QIPP_Contacts__c leancoachcontact = mapcontacts.get(proj.Lean_Coach__c);
                    if(leancoachcontact != null){
                        user u = mapuser.get(leancoachcontact.email__c);
                        if(u == null)
                            proj.Lean_Coach__c.addError('Provided Lean Coach Contact is not actual Salesforce User');
                        else  
                            proj.Approver_Lean_Coach__c = u.id;
                            proj.Lean_Coach_Email_ID__c = leancoachcontact.email__c;
                            
                    }else{
                        proj.Approver_Lean_Coach__c = null;
                        proj.Lean_Coach_Email_ID__c = null;
                    }
                    /* ########### For assigning approver as Improvement Owner for CIF Projects ############# */
                    system.debug('@@mapcontacts:'+mapcontacts);
                    QIPP_Contacts__c impownercontact = mapcontacts.get(proj.Improvement_Owner__c);
                    system.debug('@@impownercontact:'+impownercontact);
                    if(impownercontact != null){
                        /*
                        user u = mapuser.get(impownercontact.email__c);
                        if(u == null)
                            proj.Improvement_Owner__c.addError('Provided Improvement Owner Contact is not actual Salesforce User');
                        else  
                            proj.Approver_Improvement_Owner__c = u.id;
                            proj.Improvement_Owner_Email__c = impownercontact.email__c;
                        */
                        if(impownercontact.User_License__c != null && impownercontact.User_License__r.IsActive != false && 
                            impownercontact.User_License__r.Profile.Name == 'Nokia QIPP Project Lead'){
                            proj.Approver_Improvement_Owner__c = impownercontact.User_License__r.id;
                            proj.Improvement_Owner_Email__c = impownercontact.User_License__r.email;                        
                        }else{
                            if(trigger.isinsert){
                                proj.Improvement_Owner__c.addError('Provided Improvement Owner Contact is not actual Salesforce User');
                            }
                            proj.Approver_Improvement_Owner__c = null;
                            proj.Improvement_Owner_Email__c = null;                        
                        }
                            
                    }else{
                        proj.Approver_Improvement_Owner__c = null;
                        proj.Improvement_Owner_Email__c = null;
                    }
                }
                
                /* ########### For assigning approver as Portfolio Owner for Approval Process #############*/ 
                    //Code Added by-Manish on 16-Aug-2016
                    Profile p = [Select Name from Profile where Id =: userinfo.getProfileid()];
                    Integer ownerCount =0;
                    Map<String,String> projTypeMap = new Map<String,String>();
                    projTypeMap.put('DMAIC','DMAIC_DMADV__c');
                    projTypeMap.put('DMADV','DMAIC_DMADV__c');
                    projTypeMap.put('Lean (including Kaizen)','Lean_including_Kaizen__c');
                    projTypeMap.put('8D','X8D__c');
                    projTypeMap.put('A3','A3__c');
                    projTypeMap.put('CIF','CIF__c');
                    projTypeMap.put('DI (CoPQ)','DI_Logic__c');
                    projTypeMap.put('Other','Other__c');
                    projTypeMap.put('RCA/EDA','RCA_EDA__c');
                    
                    if(portfolioManager == null || portfolioManager.size()==0){
                        proj.addError('Default Portfolio manager not found, please contact system Administrator');
                    }
                    else if(projPortfolioMap.get(proj.Portfolio_Name__c)!= null){
                        QIPP_Portfolio__c portRec = projPortfolioMap.get(proj.Portfolio_Name__c);
                        if(portRec.Portfolios_Owners__r.size()!=0){
                            system.debug('portRec.Portfolios_Owners__r :'+portRec.Portfolios_Owners__r);
                            boolean Ownerfound = false;
                            for(Portfolios_Owner__c portflOwner: portRec.Portfolios_Owners__r){                                
                                system.debug('Project_Type__c : '+(Boolean)portflOwner.get(projTypeMap.get(proj.Project_Type__c)));
                                system.debug('ownerCount.size0 : '+ownerCount);
                                system.debug('portflOwner : '+portflOwner);
                                  if((Boolean)portflOwner.get(projTypeMap.get(proj.Project_Type__c))){
                                      Ownerfound = true;
                                      system.debug('ownerCount.size : '+ownerCount);
                                      if(ownerCount==0){
                                          system.debug('InOwnerCount1');
                                        proj.Approver_Protfolio_Owner_Email_1__c = portflOwner.Email__c;
                                        try{
                                            Portfolios_Owner__c portfolioOwnerContact1 = mapOwners.get(portflOwner.QIPP_Contact__c);
                                            if(portfolioOwnerContact1 != null){
                                                user u = mapuser.get(portfolioOwnerContact1.email__c);
                                                proj.Approver_Portfolio_Owner_1__c = u.id;
                                                proj.Approver_Protfolio_Owner_Email_2__c = proj.Approver_Protfolio_Owner_Email_1__c;
                                                proj.Approver_Portfolio_Owner_2__c = proj.Approver_Portfolio_Owner_1__c;
                                                
                                                proj.Approver_Protfolio_Owner_Email_3__c = proj.Approver_Protfolio_Owner_Email_1__c;
                                                proj.Approver_Portfolio_Owner_3__c = proj.Approver_Portfolio_Owner_1__c;
                                                
                                                proj.Approver_Protfolio_Owner_Email_4__c = proj.Approver_Protfolio_Owner_Email_1__c;
                                                proj.Approver_Portfolio_Owner_4__c = proj.Approver_Portfolio_Owner_1__c;
                                            }else{
                                                proj.Approver_Portfolio_Owner_1__c = null;
                                            }
                                        }catch(Exception exe){System.Debug('******EXCEPTION OCCURES********'+exe.getMessage());}    
                                      }else if(ownerCount==1){
                                        proj.Approver_Protfolio_Owner_Email_2__c = portflOwner.Email__c;            
                                        try{
                                            Portfolios_Owner__c portfolioOwnerContact2 = mapOwners.get(portflOwner.QIPP_Contact__c);
                                            if(portfolioOwnerContact2 != null){
                                                user u = mapuser.get(portfolioOwnerContact2.email__c);
                                                proj.Approver_Portfolio_Owner_2__c = u.id;
                                                proj.Approver_Protfolio_Owner_Email_3__c = proj.Approver_Protfolio_Owner_Email_1__c;
                                                proj.Approver_Portfolio_Owner_3__c = proj.Approver_Portfolio_Owner_1__c;
                                                
                                                proj.Approver_Protfolio_Owner_Email_4__c = proj.Approver_Protfolio_Owner_Email_1__c;
                                                proj.Approver_Portfolio_Owner_4__c = proj.Approver_Portfolio_Owner_1__c; 
                                            }else{
                                                proj.Approver_Portfolio_Owner_2__c = null;
                                            }
                                        }catch(Exception exe){System.Debug('******EXCEPTION OCCURES********'+exe.getMessage());}
                                      }else if(ownerCount==2){
                                          system.debug('InOwnerCount3');
                                        proj.Approver_Protfolio_Owner_Email_3__c = portflOwner.Email__c;                
                                        try{
                                            Portfolios_Owner__c portfolioOwnerContact3 = mapOwners.get(portflOwner.QIPP_Contact__c);
                                            if(portfolioOwnerContact3 != null){
                                                user u = mapuser.get(portfolioOwnerContact3.email__c);
                                                    proj.Approver_Portfolio_Owner_3__c = u.id;
                                                    proj.Approver_Protfolio_Owner_Email_4__c = proj.Approver_Protfolio_Owner_Email_1__c;
                                                proj.Approver_Portfolio_Owner_4__c = proj.Approver_Portfolio_Owner_1__c; 
                                            }else{
                                                proj.Approver_Portfolio_Owner_3__c = null;
                                            }
                                        }catch(Exception exe){System.Debug('******EXCEPTION OCCURES********'+exe.getMessage());}
                                      }else if(ownerCount==3){
                                          system.debug('InOwnerCount4');
                                        proj.Approver_Protfolio_Owner_Email_4__c = portflOwner.Email__c;               
                                        try{
                                            Portfolios_Owner__c portfolioOwnerContact4 = mapOwners.get(portflOwner.QIPP_Contact__c);
                                            if(portfolioOwnerContact4 != null){
                                                user u = mapuser.get(portfolioOwnerContact4.email__c);
                                                    proj.Approver_Portfolio_Owner_4__c = u.id;
                                            }else{
                                                proj.Approver_Portfolio_Owner_4__c = null;
                                            }
                                        }catch(Exception exe){System.Debug('******EXCEPTION OCCURES********'+exe.getMessage());}  
                                      }
                                      ownerCount++; 
                                  }
                            }
                            if(!Ownerfound){
            //portfolio owner 1
            proj.Approver_Protfolio_Owner_Email_1__c = portfolioManager[0].email;
            proj.Approver_Portfolio_Owner_1__c = portfolioManager[0].id;
            //portfolio owner 2
            proj.Approver_Protfolio_Owner_Email_2__c = portfolioManager[0].email;
            proj.Approver_Portfolio_Owner_2__c = portfolioManager[0].id;
            //portfolio owner 3
            proj.Approver_Protfolio_Owner_Email_3__c = portfolioManager[0].email;
            proj.Approver_Portfolio_Owner_3__c = portfolioManager[0].id;
            //portfolio owner 4
            proj.Approver_Protfolio_Owner_Email_4__c = portfolioManager[0].email;
            proj.Approver_Portfolio_Owner_4__c = portfolioManager[0].id;
        }
                        }else{                        
                            //User portfolioManager = [select id,name,email from user where email=:Label.Porfolio_Manager ];
                            //portfolio owner 1
                            proj.Approver_Protfolio_Owner_Email_1__c = portfolioManager[0].email;
                            proj.Approver_Portfolio_Owner_1__c = portfolioManager[0].id;
                            //portfolio owner 2
                            proj.Approver_Protfolio_Owner_Email_2__c = portfolioManager[0].email;
                            proj.Approver_Portfolio_Owner_2__c = portfolioManager[0].id;
                            //portfolio owner 3
                            proj.Approver_Protfolio_Owner_Email_3__c = portfolioManager[0].email;
                            proj.Approver_Portfolio_Owner_3__c = portfolioManager[0].id;
                            //portfolio owner 4
                            proj.Approver_Protfolio_Owner_Email_4__c = portfolioManager[0].email;
                            proj.Approver_Portfolio_Owner_4__c = portfolioManager[0].id;
                        }                        
                    }//Eod of Code - Manish
                    
                /* ########## Status fileds update based on planned/current dates calculation ############### */
                //Email fields for stake holders
                proj.Email_Line_Manager__c=proj.Line_Manager_Email__c;
                //proj.Email_Belt_Project_Sponsor__c=proj.Belt_Project_Sponsor_Email__c;
                proj.Email_Belt_Project_Champion__c=proj.Belt_Project_Champion_Email__c;        
                // Define Phase
                if(proj.Belt_Project_Phase__c == 'Define'){ 
                    proj.Define_Status__c = 'In Progress';
                    proj.Measure_Status__c = 'Not Started';
                    proj.Analyze_Status__c = 'Not Started';
                    proj.Improve_Status__c = 'Not Started';
                    proj.Control_Status__c = 'Not Started';
                }
                // Define Phase
                if((proj.Belt_Project_Phase__c == 'Measure') && (proj.Define_Date_Current__c > proj.DMAIC_Define__c)){ 
                    proj.Define_Status__c = 'Delayed';
                }
                else if((proj.Belt_Project_Phase__c == 'Measure') && (proj.Define_Date_Current__c <= proj.DMAIC_Define__c)){
                    proj.Define_Status__c = 'Completed';
                }
                // Measure Phase
                if((proj.Belt_Project_Phase__c == 'Analyze') && (proj.Measure_Date_Current__c > proj.DMAIC_Measure__c)){ 
                    proj.Measure_Status__c = 'Delayed';
                }
                else if((proj.Belt_Project_Phase__c == 'Analyze') && (proj.Measure_Date_Current__c <= proj.DMAIC_Measure__c)){
                    proj.Measure_Status__c = 'Completed';
                }
                // Analyze Phase
                if((proj.Belt_Project_Phase__c == 'Improve / Design') && (proj.Analyze_Date_Current__c > proj.DMAIC_Analyze__c)){ 
                    proj.Analyze_Status__c = 'Delayed';
                }
                else if((proj.Belt_Project_Phase__c == 'Improve / Design') && (proj.Analyze_Date_Current__c <= proj.DMAIC_Analyze__c)){
                    proj.Analyze_Status__c = 'Completed';
                }
                // Improve Phase
                if((proj.Belt_Project_Phase__c == 'Control / Verify') && (proj.Improve_Date_Current__c > proj.DMAIC_Improve__c)){ 
                    proj.Improve_Status__c = 'Delayed';
                }
                else if((proj.Belt_Project_Phase__c == 'Control / Verify') && (proj.Improve_Date_Current__c <= proj.DMAIC_Improve__c)){
                    proj.Improve_Status__c = 'Completed';
                }
                // Control Phase
                if((proj.Belt_Project_Phase__c == 'Complete') && (proj.Control_Date_Current__c > proj.DMAIC_Control__c)){ 
                    proj.Control_Status__c = 'Delayed';
                }
                else if((proj.Belt_Project_Phase__c == 'Complete') && (proj.Control_Date_Current__c <= proj.DMAIC_Control__c)){
                    proj.Control_Status__c = 'Completed';
                }
                //Start of the code - Added by Manish
                //Purpose: To update the formula field value to text field to make it avialable for Global Search
                proj.ProjectIdGlobalSearch__c = proj.Project_Number__c;
                //Purpose: To update the Project State Completed Date value Whenever the Project State change to 'complete'
                if(proj.Project_State__c=='Complete'){
                proj.Project_State_Completed_Date__c=system.today();
                }
                //End of the code - Manish
                
                //Updating project lead Organizational Information - Added by Srikanth_V.
                
                QIPP_Contacts__c leadcontact = mapcontacts.get(proj.Project_Lead__c);
                if(leadcontact != null){
                    System.Debug('************* RecordType.Name************ ' +proj.RecordType.Name);
                    System.Debug('************* RecordTypeID************ ' +proj.RecordTypeid);
                    //After Complete freeze the project lead information fields
                    if((proj.Project_State__c != 'Complete' && proj.Project_State__c != 'Closed' ) && !(proj.Project_Type__c.contains('DMAIC') || proj.Project_Type__c.contains('DMADV'))){
                        proj.Project_Lead_Business_Grp__c = leadcontact.Contact_BU__c;
                        proj.Project_Lead_Business_Unit__c = leadcontact.Contact_BL__c;
                        proj.Project_Lead_Business_Line__c = leadcontact.Contact_L4_Org__c;
                    } //Only for DMAIC projects after improve phase complete  
                    else if( !(String.valueOf(proj.RecordTypeid).contains(Aftimproveid) || String.valueOf(proj.RecordTypeid).contains(Aftcontrolid)) && (proj.Project_Type__c.contains('DMAIC') || proj.Project_Type__c.contains('DMADV'))){
                        proj.Project_Lead_Business_Grp__c = leadcontact.Contact_BU__c;
                        proj.Project_Lead_Business_Unit__c = leadcontact.Contact_BL__c;
                        proj.Project_Lead_Business_Line__c = leadcontact.Contact_L4_Org__c;
                    }
                }
            } 
        }
    }
}