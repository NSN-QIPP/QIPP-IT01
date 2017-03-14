public class QIPPProjectsByPortfolioName
{
        public String strQLTFunctionName ;
        public String strAhead ;
    
         public List<Data> getTable()
         {
          List<AggregateResult> groupedResults=new List<AggregateResult>(); 
          List<Data> wrapList = new List<Data>(); 
          groupedResults = [SELECT Portfolio_Name__r.Name , Count(Name), SUM(Project_Schedule_Status_ahead__c),SUM(Project_Schedule_Status_on__c),SUM(Project_Schedule_Status_behind__c),SUM(Project_Schedule_Status_TBD__c),SUM(Actual_COPQ_Reduction_Rate__c),SUM(Planned_CoPQ_Reduction_Rate__c) FROM QIPP_Project__c WHERE (Project_State__c != 'Complete' and Project_State__c != 'Canceled' and Project_State__c != 'Closed') GROUP BY Portfolio_Name__r.Name];
            
            Integer aprojtotal=0,aheadtotal=0,onplantotal=0,behindtotal=0,tbdtotal=0,actualCoPQ=0,plannedCoPQ=0;
            Integer i=groupedResults.size();
                                         
            for(AggregateResult ar:groupedResults)
            { 
            
             System.Debug('********************ar******************'+ar);
                
              Double aheadpercent=(Double.valueOf(ar.get('expr1'))/Double.valueOf(ar.get('expr0')))*100;
              Long aheadconvert = aheadpercent.round();
              String aheadpercentage = String.valueOf(aheadconvert) + '%';
              
              Double onplanpercent=(Double.valueOf(ar.get('expr2'))/Double.valueOf(ar.get('expr0')))*100;
              Long onplanconvert = onplanpercent.round();
              String onplanpercentage = String.valueOf(onplanconvert) + '%';
              
              Double behindpercent=(Double.valueOf(ar.get('expr3'))/Double.valueOf(ar.get('expr0')))*100;
              Long behindconvert = behindpercent.round();
              String behindpercentage = String.valueOf(behindconvert) + '%';
              
              Double tbdpercent=(Double.valueOf(ar.get('expr4'))/Double.valueOf(ar.get('expr0')))*100;
              Long tbdconvert = tbdpercent.round();
              String tbdpercentage = String.valueOf(tbdconvert) + '%';
              
              //Object pfname = ar.Portfolio_Name__r.Name; 
              
               //System.Debug('*******************pfname ******************'+ pfname );
              if(ar.get('expr0') != null)
              { aprojtotal+= Integer.valueOf(ar.get('expr0'));
              }
              if(ar.get('expr1') != null)
              { aheadtotal+= Integer.valueOf(ar.get('expr1'));
              }
              if(ar.get('expr2') != null)
              { onplantotal+= Integer.valueOf(ar.get('expr2'));
              }
              if(ar.get('expr3') != null)
              { behindtotal+= Integer.valueOf(ar.get('expr3'));
              }
              if(ar.get('expr4') != null)
              { tbdtotal+= Integer.valueOf(ar.get('expr4'));
              }
              if(ar.get('expr5') != null)
              { actualCoPQ+= Integer.valueOf(ar.get('expr5'));
              }
              if(ar.get('expr6') != null)
              { plannedCoPQ+= Integer.valueOf(ar.get('expr6'));
              } 
              wrapList.add(new data(string.valueOf(ar.get('Name')),Integer.valueOf(ar.get('expr0')),Integer.valueOf(ar.get('expr1')),Integer.valueOf(ar.get('expr2')),Integer.valueOf(ar.get('expr3')),Integer.valueOf(ar.get('expr4')),Integer.valueOf(ar.get('expr5')),Integer.valueOf(ar.get('expr6')),aheadpercentage,onplanpercentage,behindpercentage,tbdpercentage,'sub'));
            
              i--;
              if(i==0){
                  wrapList.add(new data('Total',aprojtotal,aheadtotal,onplantotal,behindtotal,tbdtotal,actualCoPQ,plannedCoPQ,null,null,null,null,'grand'));
              }
            }
              
         return wrapList;
         }
         
         public PageReference getFromPortfolioName()
         {
            PageReference  fromPType = new PageReference('/apex/QIPPProjectsByPortfolioNamePrint');
            fromPType.setRedirect(true);
            return fromPType;
         }
         public PageReference ReturnFromPortfolioName()
         {
            PageReference  fromPType = new PageReference('/apex/QIPPCustomReportPage?F=PortName');
            fromPType.setRedirect(true);
            return fromPType;
         }
    
      public class Data 
      {
        public Data(String a, Integer b, Integer c, Integer d, Integer e, Integer f,Integer g,Integer h, String rowtype1,String rowtype2,String rowtype3,String rowtype4,String rowtype){
        this.pfname = a;
        this.count= b;
        this.ahead = c;
        this.onplan = d;
        this.behind = e;
        this.tbd = f;
        this.actualCoPQ= g;
        this.plannedCoPQ= h;
        this.rowtype1= rowtype1;
        this.rowtype2= rowtype2;
        this.rowtype3= rowtype3;
        this.rowtype4= rowtype4;
        this.rowtype = rowtype;
        }
        public Data(){}
        
        public String pfname { get; set; }
        public Integer count { get; set; }
        public Integer ahead { get; set; }
        public Integer onplan { get; set; }
        public Integer behind { get; set; }
        public Integer tbd { get; set; }
        public Integer actualCoPQ{ get; set; }
        public Integer plannedCoPQ{ get; set; }
        
        public String rowtype1 { get; set; }
        public String rowtype2 { get; set; }
        public String rowtype3 { get; set; }
        public String rowtype4 { get; set; }
        public String rowtype{ get; set; }
        
      }
   
       public List<Data> getData()
       {
              List<AggregateResult> FETCHINGDATA= new List<AggregateResult>();
              List<Data> FINALRETURN= new List<Data>();
                     
              FETCHINGDATA = [SELECT Portfolio_Name__r.Name, Count(Name), SUM(Project_Schedule_Status_ahead__c),SUM(Project_Schedule_Status_on__c),SUM(Project_Schedule_Status_behind__c),SUM(Project_Schedule_Status_TBD__c) FROM QIPP_Project__c WHERE (Project_State__c != 'Complete' and Project_State__c != 'Canceled' and Project_State__c != 'Closed') GROUP BY Portfolio_Name__r.Name];
                for(AggregateResult l : FETCHINGDATA)
                {
                  Data obj = new Data();
                  //obj.pfname = string.valueOf(l.get('Name'));
                  
                  if(string.valueOf(l.get('Name'))!=null){
                  obj.pfname = string.valueOf(l.get('Name'));
                  }
                  else{obj.pfname='-';}
                  obj.count = Integer.valueOf(l.get('expr0'));
                  obj.ahead = Integer.valueOf(l.get('expr1'));
                  obj.onplan = Integer.valueOf(l.get('expr2'));
                  obj.behind = Integer.valueOf(l.get('expr3'));
                  obj.tbd = Integer.valueOf(l.get('expr4'));
                  FINALRETURN.add(obj);
                }
       return FINALRETURN;
       }
       
       /*public pageReference gotonewpage()
       {
        PageReference CO = New PageReference('/a15?fcf=00BK0000000NI3g');
        PageReference Comms = New PageReference('/a15?fcf=00BK0000000NI40');
        PageReference FandC = New PageReference('/a15?fcf=00BK0000000NI6f');
        PageReference GS = New PageReference('/a15?fcf=00BK0000000NI6k');
        PageReference IT = New PageReference('/a15?fcf=00BK0000000NI6p');
        PageReference MBB = New PageReference('/a15?fcf=00BK0000000NI6u');
        PageReference Ops = New PageReference('/a15?fcf=00BK0000000NI6z');
        PageReference QMSandCapability = New PageReference('/a15?fcf=00BK0000000NI7O');
        PageReference StrategyandPlanning = New PageReference('/a15?fcf=00BK0000000NI7T');
        PageReference ToBeDetermined = New PageReference('/a15?fcf=00BK0000000NI7Y');
        
        String str  = ApexPages.currentPage().getParameters().get('qlt');
        //String str1 = ApexPages.currentPage().getParameters().get('q');
        
        //String str2 = ApexPages.currentPage().getParameters().get('strQLTFunctionName'); 
        //String str3 = ApexPages.currentPage().getParameters().get('strAhead'); 
        
        
        //System.debug('qqqqqqqqqqqqqqqqqqqqqqqqqqq str '+ str );
        
        //System.debug('qqqqqqqqqqqqqqqqqqqqqqqqqqq str2 '+ str2);
        //System.debug('qqqqqqqqqqqqqqqqqqqqqqqqqqq str3 '+ str3);
        
        if(str=='CO') 
        {
            CO.setRedirect(true);
            return CO ;
        }
        else if(str=='Comms')
        {
            Comms.setRedirect(true);
            return Comms ;
        }
        else if(str=='F&C')
        {
            FandC.setRedirect(true);
            return FandC;
        }
        else if(str=='GS')
        {
            GS.setRedirect(true);
            return GS;
        }
        else if(str=='IT')
        {
            IT.setRedirect(true);
            return IT;
        }
        else if(str=='MBB')
        {
            MBB.setRedirect(true);
            return MBB;
        }
        else if(str=='Ops')
        {
            Ops.setRedirect(true);
            return Ops;
        }
        else if(str=='QMS & Capability')
        {
            QMSandCapability.setRedirect(true);
            return QMSandCapability;
        }
        else if(str=='Strategy & Planning')
        {
            StrategyandPlanning.setRedirect(true);
            return StrategyandPlanning;
        }
        else if(str=='To Be Determined')
        {
            ToBeDetermined.setRedirect(true);
            return ToBeDetermined;
        }
                
        return null;
        } */
        
   
  }