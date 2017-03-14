/* This trigger will apply the division logic on stored QIPP_BU_Reporting records those have Quarter and 
NO Month specified, and distribute the savings amount to equal share amount of related months of that Quarter.*/ 

Trigger QIPP_Divide_Quarterly_To_Monthly on QIPP_BU_Reporting__c (after insert, after update,after delete) {

    List<QIPP_BU_Reporting__c> benRepInsertList = new List<QIPP_BU_Reporting__c>();
    List<QIPP_BU_Reporting__c> benRepUpdateRemoveList = new List<QIPP_BU_Reporting__c>();
    List<QIPP_BU_Reporting__c> benRepUpdateAddList = new List<QIPP_BU_Reporting__c>();    
    List<QIPP_BU_Reporting__c> benRepDeleteList = new List<QIPP_BU_Reporting__c>();
    List<Id> Ids = new List<String>();
    List<Id> IdsUpdate = new List<String>();

    Trigger_Control__c s = Trigger_Control__c.getInstance(UserInfo.getUserId());
    
    system.debug('Run_Triggers__c :::'+s.Run_Triggers__c);
    
    if(s.Run_Triggers__c)
    {
    
        /*********Start::Insertion Logic for QIPP_BU_Reporting when a new QIPP_BU_Reporting record is inserted************/ 
        if(Trigger.isInsert)
        {  /*
            for(QIPP_BU_Reporting__c benrep1: Trigger.new){

                QIPP_BU_Reporting__c benrepm = new QIPP_BU_Reporting__c(Project_ID__c=benrep1.Project_ID__c,
                                                              Project_Number__c=benrep1.Project_Number__c,
                                                              Project_Name__c=benrep1.Project_Name__c,
                                                              Benefit_ID__c=benrep1.Benefit_ID__c,
                                                              Improvement_Measure__c=benrep1.Improvement_Measure__c,
                                                              Benefit_Type__c=benrep1.Benefit_Type__c,  
                                                              Benefit_Condition__c=benrep1.Benefit_Condition__c,
                                                              Years__c=benrep1.Year__c,
                                                              Year__c=benrep1.Year__c,
                                                              Quarters__c=benrep1.Quarters__c,
                                                              Entry_Type__c='System Entry',
                                                              Entry_Parent_ID__c=benrep1.id,
                                                              QIPP_Project_ID__c = benrep1.QIPP_Project_ID__c,
                                                              Portfolio_Name__c = benrep1.Portfolio_Name__c,
                                                              CoPQ_Type__c = benrep1.CoPQ_Type__c,
                                                              Benefitting_BU__c = benrep1.Benefitting_BU__c,
                                                              Benefitting_BL__c = benrep1.Benefitting_BL__c,
                                                              Benefitting_Project_BL_Level_4_Org__c = benrep1.Benefitting_Project_BL_Level_4_Org__c,
                                                              Benefit_Savings_Amount__c=benrep1.Benefit_Savings_Amount__c/3);


                //Quarter::1    
                if(benrep1.Months__c == null && benrep1.Quarters__c == 'Q1'){

                if(benrep1.Benefit_Condition__c == 'Planned')
                benrepm.Improvment_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                if(benrep1.Benefit_Condition__c == 'Achieved')
                benrepm.Achieved_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                if(benrep1.Benefit_Condition__c == 'Future')
                benrepm.Future_Saving_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);                                                          

                QIPP_BU_Reporting__c benrepm1 =benrepm.clone(true,false);
                benrepm1.Months__c='01';
                benrepm1.Month__c='01';
                benRepInsertList.add(benrepm1);            

                QIPP_BU_Reporting__c benrepm2 =benrepm.clone(true,false);
                benrepm2.Months__c='02';
                benrepm2.Month__c='02';
                benRepInsertList.add(benrepm2);

                QIPP_BU_Reporting__c benrepm3 =benrepm.clone(true,false);
                benrepm3.Months__c='03';
                benrepm3.Month__c='03';
                benRepInsertList.add(benrepm3);            
                }

                //Quarter::2    
                if(benrep1.Months__c == null && benrep1.Quarters__c == 'Q2'){

                if(benrep1.Benefit_Condition__c == 'Planned')
                benrepm.Improvment_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                if(benrep1.Benefit_Condition__c == 'Achieved')
                benrepm.Achieved_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                if(benrep1.Benefit_Condition__c == 'Future')
                benrepm.Future_Saving_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);                                                          

                QIPP_BU_Reporting__c benrepm4 =benrepm.clone(true,false);
                benrepm4.Months__c='04';
                benrepm4.Month__c='04';
                benRepInsertList.add(benrepm4);            

                QIPP_BU_Reporting__c benrepm5 =benrepm.clone(true,false);
                benrepm5.Months__c='05';
                benrepm5.Month__c='05';
                benRepInsertList.add(benrepm5);

                QIPP_BU_Reporting__c benrepm6 =benrepm.clone(true,false);
                benrepm6.Months__c='06';
                benrepm6.Month__c='06';            
                benRepInsertList.add(benrepm6);            
                }

                //Quarter::3    
                if(benrep1.Months__c == null && benrep1.Quarters__c == 'Q3'){

                if(benrep1.Benefit_Condition__c == 'Planned')
                benrepm.Improvment_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                if(benrep1.Benefit_Condition__c == 'Achieved')
                benrepm.Achieved_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                if(benrep1.Benefit_Condition__c == 'Future')
                benrepm.Future_Saving_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);                                                          

                QIPP_BU_Reporting__c benrepm7 =benrepm.clone(true,false);
                benrepm7.Months__c='07';
                benrepm7.Month__c='07';            
                benRepInsertList.add(benrepm7);            

                QIPP_BU_Reporting__c benrepm8 =benrepm.clone(true,false);
                benrepm8.Months__c='08';
                benrepm8.Month__c='08';            
                benRepInsertList.add(benrepm8);

                QIPP_BU_Reporting__c benrepm9 =benrepm.clone(true,false);
                benrepm9.Months__c='09';
                benrepm9.Month__c='09';            
                benRepInsertList.add(benrepm9);            
                }
                
                //Quarter::4    
                if(benrep1.Months__c == null && benrep1.Quarters__c == 'Q4'){

                if(benrep1.Benefit_Condition__c == 'Planned')
                benrepm.Improvment_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                if(benrep1.Benefit_Condition__c == 'Achieved')
                benrepm.Achieved_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                if(benrep1.Benefit_Condition__c == 'Future')
                benrepm.Future_Saving_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);                                                          

                QIPP_BU_Reporting__c benrepm10 =benrepm.clone(true,false);
                benrepm10.Months__c='10';
                benrepm10.Month__c='10';            
                benRepInsertList.add(benrepm10);            

                QIPP_BU_Reporting__c benrepm11 =benrepm.clone(true,false);
                benrepm11.Months__c='11';
                benrepm11.Month__c='11';            
                benRepInsertList.add(benrepm11);

                QIPP_BU_Reporting__c benrepm12 =benrepm.clone(true,false);
                benrepm12.Months__c='12';
                benrepm12.Month__c='12';            
                benRepInsertList.add(benrepm12);            
                }
            }
        insert benRepInsertList;*/
        }
        /*********End::Insertion Logic for QIPP_BU_Reporting when a new QIPP_BU_Reporting record is inserted************/     

        /*********Start::Updation Logic for QIPP_BU_Reporting when a new QIPP_BU_Reporting record is inserted************/ 
        if(Trigger.isUpdate){ 
            /*    

            for(QIPP_BU_Reporting__c bendel:Trigger.old){
            IdsUpdate.add(bendel.id);
            }    
            
            benRepUpdateRemoveList = [select id,Project_ID__c,Benefit_ID__c,Entry_Type__c,Entry_Parent_ID__c 
                                      from QIPP_BU_Reporting__c where Entry_Type__c =: 'System Entry' 
                                      and Entry_Parent_ID__c in: IdsUpdate];
            delete benRepUpdateRemoveList;
            //start::copied
            for(QIPP_BU_Reporting__c benrep1: Trigger.new){
                if(benrep1.Entry_Type__c == 'User Entry'){

                QIPP_BU_Reporting__c benrepm = new QIPP_BU_Reporting__c(Project_ID__c=benrep1.Project_ID__c,
                                                              Project_Number__c=benrep1.Project_Number__c,
                                                              Project_Name__c=benrep1.Project_Name__c,
                                                              Benefit_ID__c=benrep1.Benefit_ID__c,
                                                              Improvement_Measure__c=benrep1.Improvement_Measure__c,
                                                              Benefit_Type__c=benrep1.Benefit_Type__c,  
                                                              Benefit_Condition__c=benrep1.Benefit_Condition__c,
                                                              Years__c=benrep1.Year__c,
                                                              Year__c=benrep1.Year__c,
                                                              Quarters__c=benrep1.Quarters__c,
                                                              Entry_Type__c='System Entry',
                                                              Entry_Parent_ID__c=benrep1.id,
                                                              QIPP_Project_ID__c = benrep1.QIPP_Project_ID__c,                                                          
                                                              Portfolio_Name__c = benrep1.Portfolio_Name__c,
                                                              CoPQ_Type__c = benrep1.CoPQ_Type__c,
                                                              Benefitting_BU__c = benrep1.Benefitting_BU__c,
                                                              Benefitting_BL__c = benrep1.Benefitting_BL__c,
                                                              Benefitting_Project_BL_Level_4_Org__c = benrep1.Benefitting_Project_BL_Level_4_Org__c,
                                                              Benefit_Savings_Amount__c=benrep1.Benefit_Savings_Amount__c/3
                                                              );

                system.debug('Improvment_Amount__c:::'+benrepm.Improvment_Amount__c);
                system.debug('Achieved_Amount__c:::'+benrepm.Achieved_Amount__c);
                system.debug('Future_Saving_Amount__c :::'+benrepm.Future_Saving_Amount__c );                        
                //Quarter::1    
                if(benrep1.Months__c == null && benrep1.Quarters__c == 'Q1'){

                if(benrep1.Benefit_Condition__c == 'Planned'){
                benrepm.Improvment_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                benrepm.Achieved_Amount__c = '0.0';
                benrepm.Future_Saving_Amount__c = '0.0';
                }
                if(benrep1.Benefit_Condition__c == 'Achieved'){
                benrepm.Achieved_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                benrepm.Improvment_Amount__c = '0.0';
                benrepm.Future_Saving_Amount__c = '0.0';
                }
                if(benrep1.Benefit_Condition__c == 'Future'){
                benrepm.Future_Saving_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);                                                          
                benrepm.Improvment_Amount__c = '0.0';
                benrepm.Achieved_Amount__c = '0.0';
                }    
                QIPP_BU_Reporting__c benrepm1 =benrepm.clone(true,false);
                benrepm1.Months__c='01';
                benrepm1.Month__c='01';
                benRepInsertList.add(benrepm1);            

                QIPP_BU_Reporting__c benrepm2 =benrepm.clone(true,false);
                benrepm2.Months__c='02';
                benrepm2.Month__c='02';
                benRepInsertList.add(benrepm2);

                QIPP_BU_Reporting__c benrepm3 =benrepm.clone(true,false);
                benrepm3.Months__c='03';
                benrepm3.Month__c='03';
                benRepInsertList.add(benrepm3);            
                }

                //Quarter::2    
                if(benrep1.Months__c == null && benrep1.Quarters__c == 'Q2'){

                if(benrep1.Benefit_Condition__c == 'Planned'){
                benrepm.Improvment_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                benrepm.Achieved_Amount__c = '0.0';
                benrepm.Future_Saving_Amount__c = '0.0';
                }
                if(benrep1.Benefit_Condition__c == 'Achieved'){
                benrepm.Achieved_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                benrepm.Improvment_Amount__c = '0.0';
                benrepm.Future_Saving_Amount__c = '0.0';
                }
                if(benrep1.Benefit_Condition__c == 'Future'){
                benrepm.Future_Saving_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);                                                          
                benrepm.Improvment_Amount__c = '0.0';
                benrepm.Achieved_Amount__c = '0.0';
                }

                QIPP_BU_Reporting__c benrepm4 =benrepm.clone(true,false);
                benrepm4.Months__c='04';
                benrepm4.Month__c='04';
                benRepInsertList.add(benrepm4);            

                QIPP_BU_Reporting__c benrepm5 =benrepm.clone(true,false);
                benrepm5.Months__c='05';
                benrepm5.Month__c='05';
                benRepInsertList.add(benrepm5);

                QIPP_BU_Reporting__c benrepm6 =benrepm.clone(true,false);
                benrepm6.Months__c='06';
                benrepm6.Month__c='06';            
                benRepInsertList.add(benrepm6);            
                }

                //Quarter::3    
                if(benrep1.Months__c == null && benrep1.Quarters__c == 'Q3'){

                if(benrep1.Benefit_Condition__c == 'Planned'){
                benrepm.Improvment_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                benrepm.Achieved_Amount__c = '0.0';
                benrepm.Future_Saving_Amount__c = '0.0';
                }
                if(benrep1.Benefit_Condition__c == 'Achieved'){
                benrepm.Achieved_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                benrepm.Improvment_Amount__c = '0.0';
                benrepm.Future_Saving_Amount__c = '0.0';
                }
                if(benrep1.Benefit_Condition__c == 'Future'){
                benrepm.Future_Saving_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);                                                          
                benrepm.Improvment_Amount__c = '0.0';
                benrepm.Achieved_Amount__c = '0.0';
                }

                QIPP_BU_Reporting__c benrepm7 =benrepm.clone(true,false);
                benrepm7.Months__c='07';
                benrepm7.Month__c='07';            
                benRepInsertList.add(benrepm7);            

                QIPP_BU_Reporting__c benrepm8 =benrepm.clone(true,false);
                benrepm8.Months__c='08';
                benrepm8.Month__c='08';            
                benRepInsertList.add(benrepm8);

                QIPP_BU_Reporting__c benrepm9 =benrepm.clone(true,false);
                benrepm9.Months__c='09';
                benrepm9.Month__c='09';            
                benRepInsertList.add(benrepm9);            
                }
                
                //Quarter::4    
                if(benrep1.Months__c == null && benrep1.Quarters__c == 'Q4'){

                if(benrep1.Benefit_Condition__c == 'Planned'){
                benrepm.Improvment_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                benrepm.Achieved_Amount__c = '0.0';
                benrepm.Future_Saving_Amount__c = '0.0';
                }
                if(benrep1.Benefit_Condition__c == 'Achieved'){
                benrepm.Achieved_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);
                benrepm.Improvment_Amount__c = '0.0';
                benrepm.Future_Saving_Amount__c = '0.0';
                }
                if(benrep1.Benefit_Condition__c == 'Future'){
                benrepm.Future_Saving_Amount__c = string.valueof(benrep1.Benefit_Savings_Amount__c/3);                                                          
                benrepm.Improvment_Amount__c = '0.0';
                benrepm.Achieved_Amount__c = '0.0';
                }

                QIPP_BU_Reporting__c benrepm10 =benrepm.clone(true,false);
                benrepm10.Months__c='10';
                benrepm10.Month__c='10';            
                benRepInsertList.add(benrepm10);            

                QIPP_BU_Reporting__c benrepm11 =benrepm.clone(true,false);
                benrepm11.Months__c='11';
                benrepm11.Month__c='11';            
                benRepInsertList.add(benrepm11);

                QIPP_BU_Reporting__c benrepm12 =benrepm.clone(true,false);
                benrepm12.Months__c='12';
                benrepm12.Month__c='12';            
                benRepInsertList.add(benrepm12);            
                }
                system.debug('::::Improvment_Amount__c:::'+benrepm.Improvment_Amount__c);
                system.debug(':::::Achieved_Amount__c:::'+benrepm.Achieved_Amount__c);
                system.debug(':::::Future_Saving_Amount__c :::'+benrepm.Future_Saving_Amount__c );                        
                }
            }
        insert benRepInsertList;*/
            //End:: copied       
        }
        /*********End::Updation Logic for QIPP_BU_Reporting when a new QIPP_BU_Reporting record is inserted************/ 

        /*********Start::Deletion Logic for QIPP_BU_Reporting when a new QIPP_BU_Reporting record is inserted************/ 
        if(Trigger.isDelete){
        
            
            for(QIPP_BU_Reporting__c bendel:Trigger.old){
            Ids.add(bendel.id);
            }
            benRepDeleteList = [select id,Project_ID__c,Benefit_ID__c,Entry_Type__c,Entry_Parent_ID__c 
                        from QIPP_BU_Reporting__c where Entry_Type__c =: 'System Entry' 
                        and Entry_Parent_ID__c in: Ids];
            delete benRepDeleteList;                    
        }
    
    }
    
    /*********End::Deletion Logic for QIPP_BU_Reporting when a new QIPP_BU_Reporting record is inserted************/     
}