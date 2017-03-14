public class QIPP_GenerateQuarterWiseReport
{
    
     public static List<QIPP_BU_Reporting__c> CreateRC(String BenefitID , Decimal Value , Date BenStartDate , Date BenEndDate , String PortfolioBU , String CPOQType , String strProjectName , String strPortfolioName , String strBenefitName , String strBusinessLine , String strImprovmentMeasure , String ProjectId , String stage , String ProjectBU , String Benefitting_Project_BL_Level_4_Org , String Project_Lead_BU , String Project_Lead_BL_Level_3_Org , String Project_Lead_BL_Level_4_Org , String DI_State , String Project_Number , String QIMethodology , String BeltProjectType)
     {
         String Quarter = null;
         Date startdate = null; 
         Integer Year ;     
         Map<String,Decimal> daywisedistribution = new Map<String,Decimal>();
         Integer diffMonth = 0 , daysdiff  = 0 ;
         Decimal perday = 0.0 , CalculatedPricePerMonth = 0.0  ;
         Integer OldYearQ1 = 0,OldYearQ2 = 0,OldYearQ3 = 0,OldYearQ4 = 0;
         Decimal GenerateQ1 = 0.0 , GenerateQ2 = 0.0 , GenerateQ3 = 0.0 , GenerateQ4 = 0.0 ;
         String strGenerateQ1 = null  , strGenerateQ2 = null  ,strGenerateQ3 = null  ,strGenerateQ4 = null  ;
         List<QData> qGeneratedData = new  List<QData>();
         Set<String> SetQuarterYear = new Set<String>();      
         String strData='';
         
      if(Value != null && BenStartDate != null && BenEndDate != null)
      {
         if(BenStartDate != null && BenEndDate != null)
         {
           diffMonth = BenStartDate.monthsBetween(BenEndDate);
           diffMonth += 1;    
           daysdiff = BenStartDate.daysBetween(BenEndDate);
           daysdiff += 1;   
         }

         if(Value != null )
             perday = Value / daysdiff ;
         else
             perday = 0 ;
        
        System.Debug('&&&&&&&&&&&&&&&&&& Per Day Value &&&&&&&&&&&&&&& ' + perday);
        
         for(Integer num = 0 ; num < diffMonth ; num++)
         {
            Integer daysremain = 0;
            startdate = BenStartDate.addMonths(num);
            if(BenStartDate.isSameDay(BenEndDate))
            {
                daysremain = 1;
            }    
            else if((BenStartDate.month() == BenEndDate.month()) && (BenStartDate.year() == BenEndDate.year()))
            {
                daysremain = BenStartDate.daysBetween(BenEndDate);
                daysremain += 1; 
            }
            else if(num == 0)
            {
                daysremain = getRemainDaysinMonths(startdate,'Y'); 
                daysremain += 1;               
            }
            else if(diffMonth-1 == num)
            {
                daysremain = BenEndDate.Day(); 
            }    
            else
            {
                daysremain = getRemainDaysinMonths(startdate,'N');
                daysremain += 1;
            }
          Decimal daysremainXperday = daysremain  * perday;
          System.Debug('&&&&&&&&&&&&&&&&&& VALUE FOR  &&&&&&&&&&&&&&& ' + startdate.MONTH() + ' ----------- is ' + daysremainXperday  );

           QData q = new QData();
           
             if(startdate.month() == 1 || startdate.month() == 2 || startdate.month() == 3)
                 q.Quarter = 'Q1';
             if(startdate.month() == 4 || startdate.month() == 5 || startdate.month() == 6)
                 q.Quarter = 'Q2';
             if(startdate.month() == 7 || startdate.month() == 8|| startdate.month() == 9)
                 q.Quarter = 'Q3';
             if(startdate.month() == 10 || startdate.month() == 11 || startdate.month() == 12)
                 q.Quarter = 'Q4';
              
             if(startdate.month() == 1)
                 q.Month = 1 ;
             if(startdate.month() == 2)
                 q.Month = 2 ;
             if(startdate.month() == 3)
                 q.Month = 3 ;
             if(startdate.month() == 4)
                 q.Month = 4 ;
             if(startdate.month() == 5)
                 q.Month = 5 ;
             if(startdate.month() == 6)
                 q.Month = 6 ;
             if(startdate.month() == 7)
                 q.Month = 7 ;
             if(startdate.month() == 8)
                 q.Month = 8 ;
             if(startdate.month() == 9)
                 q.Month = 9 ;
             if(startdate.month() == 10)
                 q.Month = 10 ;
             if(startdate.month() == 11)
                 q.Month = 11 ;
             if(startdate.month() == 12)
                 q.Month = 12 ;
             
                 
             q.Amount = daysremainXperday;
             q.Year = startdate.Year();
             q.Stage = stage;
             qGeneratedData.add(q);
             q= null;
         }
        }
        
        for(QData q : qGeneratedData)
        {
             String Test= q.Year + '--' + q.Quarter + '--' + q.Amount + '--' + q.Month + '--' + q.Year + ':' ;
             StrData += Test ;
        }
        
        List<QIPP_BU_Reporting__c> insertDatainObject = new  List<QIPP_BU_Reporting__c>();
        
        for (QData QY : qGeneratedData)
        {
                QIPP_BU_Reporting__c test = new QIPP_BU_Reporting__c();
                
                System.Debug('&&&&&&&&&&&&&&&&&&  QY.Amount =>> ' + QY.Amount + ' &&&&&&&&&&&&&&&&&&');
                
                if(QY.Stage == 'Achieved')
                    test.Achieved_Amount__c = String.valueOf(QY.Amount);
                if(QY.Stage == 'Planned')
                    test.Improvment_Amount__c = String.valueOf(QY.Amount);
                if(QY.Stage == 'Future')    
                    test.Future_Saving_Amount__c = String.valueOf(QY.Amount);
                    
                test.Benefit_Phase__c = QY.Stage;    
                test.Benefit_ID__c = BenefitID;
                test.Benefitting_BU__c = PortfolioBU;
                test.Benefitting_BL__c = ProjectBU;
                test.CoPQ_Type__c = CPOQType;
                test.Quarter__c = QY.Quarter;
                test.Year__c = String.valueOf(QY.Year);
                test.Project_Name__c = strProjectName ;
                test.Portfolio_Name__c = strPortfolioName ;
                test.Benefit_Type__c = strBenefitName;
                //test.Business_Line__c = strBusinessLine;
                test.Improvement_Measure__c = strImprovmentMeasure;
                test.Project_ID__c = ProjectId;
                //test.Month__c = QY.Month;
                test.Benefitting_Project_BL_Level_4_Org__c = Benefitting_Project_BL_Level_4_Org;
                test.Project_Lead_BU__c = Project_Lead_BU;
                test.Project_Lead_BL_Level_3_Org__c = Project_Lead_BL_Level_3_Org;
                test.Project_Lead_BL_Level_4_Org__c = Project_Lead_BL_Level_4_Org;
                test.DI_State__c = DI_State;
                test.Project_Number__c = Project_Number;
                test.QI_Methodology__c = QIMethodology;
                test.Belt_Project_Type__c = BeltProjectType;
                insertDatainObject.add(test);
                System.Debug('&&&&&&&&&&&&&&&&&& test &&&&&&&&&&&&&&& ' + test);   
        }
       return insertDatainObject ;
     }        

public static void UpdateAmount(List<QIPP_BU_Reporting__c> insertDatainObject)
  {
      System.Debug('&&&&&&&&&&&&&&&&&& insertDatainObject &&&&&&&&&&&&&&& ' + insertDatainObject.size());    
      insert insertDatainObject; 
  }  

PUBLIC static Integer getRemainDaysinMonths(Date getDate, String Status)
     {
         Integer daysRemain = 0 ;
         if(getDate.month() == 1 || getDate.month() == 3 || getDate.month() == 5 || getDate.month() == 7 || getDate.month() == 8 || getDate.month() == 10 || getDate.month() == 12 )
         {
             if(Status == 'N')
             return 30;
             else if(Status == 'Y')
             daysRemain = 31 - getDate.day();
         }         
         else if (getDate.month() == 2 && math.mod(getDate.Year(),4)==0)
         {
             if(Status == 'N')
             return 28;
             else if(Status == 'Y')           
             daysRemain = 29 - getDate.day();
         }
         else if (getDate.month() == 2 && math.mod(getDate.Year(),4)!=0)
         {
             if(Status == 'N')
             return 27;
             else if(Status == 'Y')        
             daysRemain = 28 - getDate.day();
         }
         else
         {
             if(Status == 'N')
             return 29;
             else if(Status == 'Y')       
             daysRemain = 30 - getDate.day();
         }
         return daysRemain ;
     }
     
    public  class QData
    {
        public Decimal Amount {get;set;}
        public Integer Month {get;set;}
        public Integer Year {get;set;}
        public String Quarter {get;set;}
        public String QuarterYear {get;set;}
        public String Stage {get;set;}
    }
    
    
}