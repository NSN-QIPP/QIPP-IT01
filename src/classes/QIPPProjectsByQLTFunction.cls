public class QIPPProjectsByQLTFunction 
{
        public String strQLTFunctionName ;
        public String strAhead ;
    
         public List<Data> getTable()
         {
          List<AggregateResult> groupedResults=new List<AggregateResult>(); 
          List<Data> wrapList = new List<Data>(); 
          groupedResults = [SELECT Primary_QLT_Function__c, Count(Name), SUM(Project_Schedule_Status_ahead__c),SUM(Project_Schedule_Status_on__c),SUM(Project_Schedule_Status_behind__c),SUM(Project_Schedule_Status_TBD__c),SUM(Actual_COPQ_Reduction_Rate__c),SUM(Planned_CoPQ_Reduction_Rate__c) FROM QIPP_Project__c WHERE (Project_State__c != 'Complete' and Project_State__c != 'Canceled' and Project_State__c != 'Closed') GROUP BY Primary_QLT_Function__c];
          System.debug('test sizeeeeeeee' +groupedResults.size());
            
            Integer aprojtotal=0,aheadtotal=0,onplantotal=0,behindtotal=0,tbdtotal=0,actualCoPQ=0,plannedCoPQ=0;
            Integer i=groupedResults.size();
                                         
            for(AggregateResult ar:groupedResults)
            { 
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
              
              wrapList.add(new data(string.valueOf(ar.get('Primary_QLT_Function__c')),Integer.valueOf(ar.get('expr0')),Integer.valueOf(ar.get('expr1')),Integer.valueOf(ar.get('expr2')),Integer.valueOf(ar.get('expr3')),Integer.valueOf(ar.get('expr4')),Integer.valueOf(ar.get('expr5')),Integer.valueOf(ar.get('expr6')),aheadpercentage,onplanpercentage,behindpercentage,tbdpercentage,'sub'));
              
              i--;
              if(i==0){
                  wrapList.add(new data('Total',aprojtotal,aheadtotal,onplantotal,behindtotal,tbdtotal,actualCoPQ,plannedCoPQ,null,null,null,null,'grand'));
              }
            }
              
         return wrapList;
         }
    
    public PageReference getFromQLTFunction()
         {
            PageReference  fromQLT = new PageReference('/apex/QIPPProjectsByQLTFunctionPrint');
            fromQLT.setRedirect(true);
            return fromQLT;
         }
         public PageReference ReturnFromQLTFunction()
         {
            PageReference  fromQLT = new PageReference('/apex/QIPPCustomReportPage?F=QLT');
            fromQLT.setRedirect(true);
            return fromQLT;
         }
    
    
      public class Data 
      {
        public Data(String a, Integer b, Integer c, Integer d, Integer e, Integer f,Integer g,Integer h, String rowtype1,String rowtype2,String rowtype3,String rowtype4,String rowtype){
        this.qltfun = a;
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
        
        public String qltfun { get; set; }
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
                     
              FETCHINGDATA = [SELECT Primary_QLT_Function__c, Count(Name), SUM(Project_Schedule_Status_ahead__c),SUM(Project_Schedule_Status_on__c),SUM(Project_Schedule_Status_behind__c),SUM(Project_Schedule_Status_TBD__c) FROM QIPP_Project__c WHERE (Project_State__c != 'Complete' and Project_State__c != 'Canceled' and Project_State__c != 'Closed') GROUP BY Primary_QLT_Function__c];
                for(AggregateResult l : FETCHINGDATA)
                {
                  Data obj = new Data();
                  obj.qltfun = string.valueOf(l.get('Primary_QLT_Function__c'));
                  obj.count = Integer.valueOf(l.get('expr0'));
                  obj.ahead = Integer.valueOf(l.get('expr1'));
                  obj.onplan = Integer.valueOf(l.get('expr2'));
                  obj.behind = Integer.valueOf(l.get('expr3'));
                  obj.tbd = Integer.valueOf(l.get('expr4'));
                  FINALRETURN.add(obj);
                }
       return FINALRETURN;
       }
       
               
   
  }