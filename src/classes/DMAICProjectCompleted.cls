public with sharing class DMAICProjectCompleted {
    public id projectId {get; set;}
   // public QIPP_Project__c projects;
    public List<ImsLstwrap> result = new List<ImsLstwrap>(); 
    public DMAICProjectCompleted (){
       
    }
    public  List<ImsLstwrap> getBenftreps() {
        //projects = [select id, name from QIPP_Project__c where id =: projectId limit 1];
       // system.debug('project details'+ projects);
        list<QIPP_BU_Reporting__c> benreps = new list<QIPP_BU_Reporting__c>();
        benreps =   [select ID,Project_ID__c,Benefit_Type__c,month__C,Improvement_Measure__c,Benefit_Condition__c,Improvment_Amount__c,Achieved_Amount__c,Future_Saving_Amount__c,
                        Planned_Financial_Savings_k__c,
                        Achieved_Financial_Savings_k__c,
                        Future_Financial_Savings_k__c,
                        Planned_Operational_Savings_k__c,
                        Achieved_Operational_Savings_k__c,
                        Future_Operational_Savings_k__c,
                        Achieved_Projected_Savings_k__c,
                        Future_Projected_Savings_k__c,
                        Achieved_Realized_Savings_k__c,
                        Future_Realized_Savings_k__c,
                    Entry_Type__c from QIPP_BU_Reporting__c where Project_ID__c =: projectId and Entry_Type__c = 'User Entry' and month__c != null];
        system.debug('BenRep details*****'+ benreps);
        system.debug('BenRep Size1*****'+ benreps.size());
        set<string> IMs = new set<string>();
        for(QIPP_BU_Reporting__c benr: benreps){
            if (benr.Improvement_Measure__c != null)
                IMs.add(benr.Improvement_Measure__c);
        }
        system.debug('Improvement_Measure****'+ IMs );
        for(string imkpi : IMs){
            string im = imkpi;
            string Fben = 'Financial Savings';
            decimal Famt= 0;
            string Fin;
            string Oben = 'Operational Savings';
            decimal Oamt= 0;
            string ope;
            string prben = 'Projected Revenue';
            decimal pramt= 0;
            string pr;
            string rrben = 'Realized Revenue';
            decimal rramt= 0;
            string rr;
            
            List<Integer> removebenreps = new List<Integer>();
            for(integer i = 0; i < benreps.size(); i++){
                
                if(benreps[i].Improvement_Measure__c != null && benreps[i].Improvement_Measure__c == imkpi && benreps[i].Benefit_Type__c != null && (benreps[i].Benefit_Type__c == Fben || benreps[i].Benefit_Type__c == oben || benreps[i].Benefit_Type__c == prben || benreps[i].Benefit_Type__c == rrben)){
                    if(benreps[i].Benefit_Type__c != null && benreps[i].Benefit_Type__c == Fben){
                        Famt =Famt+benreps[i].Achieved_Financial_Savings_k__c+benreps[i].Future_Financial_Savings_k__c;
                        Fin = 'yes';
                    }
                    if(benreps[i].Benefit_Type__c != null && benreps[i].Benefit_Type__c == Oben){
                        Oamt = Oamt+benreps[i].Achieved_Operational_Savings_k__c+benreps[i].Future_Operational_Savings_k__c;
                        ope = 'yes';
                    }
                    if(benreps[i].Benefit_Type__c != null && benreps[i].Benefit_Type__c == prben){
                        pramt =Famt+benreps[i].Achieved_Projected_Savings_k__c+benreps[i].Future_Projected_Savings_k__c;
                        pr = 'yes';
                    }
                    if(benreps[i].Benefit_Type__c != null && benreps[i].Benefit_Type__c == rrben){
                        rramt = Oamt+benreps[i].Achieved_Realized_Savings_k__c+benreps[i].Future_Realized_Savings_k__c;
                        rr = 'yes';
                    }
                    removebenreps.add(i);
                }
                system.debug('removebenreps1*********'+ removebenreps);
            }
            /*system.debug('removebenreps2*********'+ removebenreps.size());
            // remove it from your list.
            for(Integer x : removebenreps){
                system.debug('x1*********'+ x);
                system.debug('BenRep Size2*****'+ benreps.size());
                benreps.remove(x);
                system.debug('x2*********'+ x);
                system.debug('BenRep Size3*****'+ benreps.size());
            }
            system.debug('removebenreps3*********'+ removebenreps.size());
            system.debug('BenRep Size4*****'+ benreps.size());
            */
            if(Fin == 'yes'){
                ImsLstwrap imsWrap1 = new ImsLstwrap(im,Fben,Famt);
                result.add(imsWrap1);
            }
            if(ope == 'yes'){
                ImsLstwrap imsWrap2 = new ImsLstwrap(im,Oben,Oamt);
                result.add(imsWrap2);
            }
            if(pr == 'yes'){
                ImsLstwrap imsWrap1 = new ImsLstwrap(im,prben,pramt);
                result.add(imsWrap1);
            }
            if(rr == 'yes'){
                ImsLstwrap imsWrap1 = new ImsLstwrap(im,rrben,rramt);
                result.add(imsWrap1);
            }
        }
        return result;
    }
    
    public class ImsLstwrap{
        public String ImprovementMeasure{get; set;}  
        public String BenefitType{get; set;}      
        public String Amount{get; set;}     
        
        public String KPIS{get; set;} 
        
        ImsLstwrap(string im, string bentype, decimal amt)
        {
            
           // this.ImprovementMeasure = 'Improvement Measure : '+im+', ';
           // this.BenefitType = ' '+bentype;
           // this.Amount = ' '+String.valueOf(amt.format()) +'  k€ of'+'  ';
            this.KPIS = 'Improvement Measure and Total Benefit Amount : '+im+', '+String.valueOf(amt.format()) +' k€ of  '+' '+bentype;
        }
    }
    

}