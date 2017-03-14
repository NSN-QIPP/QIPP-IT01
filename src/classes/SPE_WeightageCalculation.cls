public with sharing class SPE_WeightageCalculation 
{
    public static Map<String, Map<String, Map<String,Decimal>>> weightageData (Set<String> enterpriseIds, Set<String> periods, String type, Integer limits, String cluster, String categoryGroup, String category, String region, String subRegion, String country,  
                           String project, String businessUnit)
    {
        
        
        Map<String, Map<String, Map<String,Decimal>>> enterPriseIdAggregateResult = new Map<String, Map<String, Map<String,Decimal>>>();
    
        String query = 'SELECT SPEPeriod__c, EnterpriseId__c, AggregateLevel__c, Weight__c, CategoryCluster__c, CategoryGroup__c, Category__c, Region__c, SubRegion__c, Country__c, Spend__c, Project__c ' + 
                       ' FROM SPE_SpendandVolume__c ';
                       
        //*****************************Changes for Encryption***********************************//
            //String whereCondition = 'WHERE SPEPeriod__c In : periods AND EnterpriseID__c In: enterpriseIds ';
            String whereCondition = 'WHERE SPEPeriod__c In : periods ';
        //*****************************END***********************************//
        
        //whereCondition = whereCondition + ' AND Type__c =: type ';
        //whereCondition = whereCondition + ' AND CategoryCluster__c =: cluster ';
        //whereCondition = whereCondition + (categoryGroup != null ? ' AND CategoryGroup__c =: categoryGroup ' : '');
        //whereCondition = whereCondition + (category != null ? ' AND Category__c =: category ' : '');
        //whereCondition = whereCondition + (businessUnit != null ? ' AND BusinessUnit__c =: businessUnit ' : '');
        
        //whereCondition = whereCondition + ' LIMIT :limits';
        
        System.debug(periods + '' + enterpriseIds);
        
        List<SPE_SpendandVolume__c> spendAndVolumn = (List<SPE_SpendandVolume__c>) Database.query(query + whereCondition);
            
        for (SPE_SpendandVolume__c  spend: spendAndVolumn)
        {
          
          //*****************************Changes for Encryption***********************************//   
            if (JSON.serialize(enterpriseIds).contains(spend.EnterpriseID__c)){           
            System.debug('-->' + spend);
          //*****************************END***********************************//
            
            Map<String, Map<String,Decimal>> aggregateResult = new Map<String, Map<String,Decimal>>();
            
            if (enterPriseIdAggregateResult.get(spend.EnterpriseId__c) != null) 
            {
                aggregateResult = enterPriseIdAggregateResult.get(spend.EnterpriseId__c);
            }
            
            enterPriseIdAggregateResult.put(spend.EnterpriseId__c, aggregateResult);
            
            
            
            
            System.debug('-->' + enterPriseIdAggregateResult);
            
            //if (spend.AggregateLevel__c != null)
        //  {
                Map<String,Decimal> valuesMap = new Map<String,Decimal>();
                
                
                aggregateResult.put(spend.AggregateLevel__c, valuesMap);
            
                if (aggregateResult.get(spend.AggregateLevel__c) != null)
                {
                    valuesMap = aggregateResult.get(spend.AggregateLevel__c);
                }
                
                if (spend.AggregateLevel__c == 'Project')
                {
                    Decimal weight = valuesMap.get(spend.Project__c) == null ? spend.Weight__c : valuesMap.get(spend.Project__c) + spend.Weight__c;
                
                    valuesMap.put(spend.Project__c, weight);
                }
                else if (spend.AggregateLevel__c == 'Country')
                {
                    Decimal weight = valuesMap.get(spend.Country__c) == null ? spend.Weight__c : valuesMap.get(spend.Country__c) + spend.Weight__c;
                
                    valuesMap.put(spend.Country__c, weight);
                }
                else if (spend.AggregateLevel__c == 'Sub-region')
                {
                    Decimal weight = valuesMap.get(spend.SubRegion__c) == null ? spend.Weight__c : valuesMap.get(spend.SubRegion__c) + spend.Weight__c;
                
                    valuesMap.put(spend.SubRegion__c, weight);
                }
                else if (spend.AggregateLevel__c == 'Region')
                {
                    Decimal weight = valuesMap.get(spend.Region__c) == null ? spend.Weight__c : valuesMap.get(spend.Region__c) + spend.Weight__c;
                
                    valuesMap.put(spend.Region__c, weight);
                }
                
            //}
        
            System.debug('-->' + aggregateResult);
            }
        }
        
        return enterPriseIdAggregateResult;
    }

}