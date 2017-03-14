public class SPE_SectionUtilityGenerator 
{
    public static Map<String,List<String>> getPageSectionValueMap()
    {
        Map<String,List<String>> pageSectionValueMap = new Map<String,List<String>>{'Develop'=>new list<String>{'Supplier Information','SPE / KPI Information',
                                                                                        'Problem Analysis','Root Cause','Fault Assumption',
                                                                                        'Corrective Action Plan/ Preventive Action Plan','Verfication & closure'},
                                                           'Audit NC'=> new list<String>{'Problem Analysis','Root Cause','Fault Assumption',
                                                                                        'Corrective Action Plan/ Preventive Action Plan','Verfication & closure'},
                                                           'Phase Out'=> new list<String>{'Supplier Information','SPE / KPI Information',
                                                                                          'Problem Descriptions and Details','Phase out details','Phase out Plan','Phase out Status'},
                                                           'Watchlist' => new list<String>{'Supplier Information','SPE / KPI Information', 'KPI Score Trend'}
                                                          };
        return pageSectionValueMap;
    }
    
    public static Map<String, Map<String, Boolean>> getSectionFieldvalueMap(){
        Map<String, Map<String, Boolean>> sectionFieldvalueMap = new Map<String, Map<String, Boolean>> {
            'General Information' => new Map<String, Boolean>{
                                            'Title__c' => true,
                                            'SurveyCommentInclusion__c' => true,
                                            'OpenDate__c' => false,
                                            'CancelledNTFStatusExplanation__c' => true
            },
            'Supplier Information'=> new Map<String, Boolean>{
                                            'Supplier__c' => true,
                                            'SPEPlan__c'=> true
            },
            
            'KPI Score Trend' => new Map<String, Boolean>{
                                            'ContinuouslyAboveThreshold_Period__c'=>true,
                                            'KPIScoreThreshold__c'=>true,
                                            'AutoClose__c'=>true
            },
            
            'SPE / KPI Information'=> new Map<String, Boolean>{
                                            'KPIName__c' => true,
                                            'SPETracker__c' => true
            },
           'Problem Analysis' => new Map<String, Boolean>{
                                            'ProblemDescriptionDetails__c' => true,
                                            'AnalysisFindings__c' => true,
                                            'Datefailurefirstobserved__c' => true,
                                            'Contributor__c'  => true,
                                            'Problem_Analysis_Completed__c' =>false
            },
            'Problem Descriptions and Details' => new Map<String, Boolean>{
                                            'ProblemDescriptionDetails__c' => true,
                                            'AnalysisFindings__c' => true,
                                            'Datefailurefirstobserved__c' => true,
                                            'Contributor__c'  => true
            },
            'Root Cause' => new Map<String, Boolean>{
                                            'X3DManufacturerResponse__c' => false,
                                            'X3DOwnerApproveReject__c' => true,
                                            'X3DSupplierContributors__c' => false,
                                            'X3DOwnerResponse__c' => true,
                                            'X3DSupplierResponseComplete__c' => false,
                                            'X3DDueDate__c' => true,
                                            'BLANK' => false,         // to leave black space on the page
                                            'X3DDaysAllowed__c' => false
            }, 
            'Fault Assumption' => new Map<String, Boolean>{
                                            'ManufactureAcceptsFault__c' => false,
                                            'OwnerApproval__c' => true,
                                            'ManufacturerComments__c' => false,
                                            'OwnerComments__c' => true,
                                            'SupplierFaultAssumptionComplete__c' => false,
                                            'X3DDueDate__c' => true
            },
            'Corrective Action Plan/ Preventive Action Plan' => new Map<String, Boolean>{
                                            'X4DSupplierResponse__c' => false,
                                            'X4DOwnerApproveReject__c' => true,
                                            'X4DSupplierContributors__c' => false,
                                            'X4DOwnerResponse__c' => true,
                                            'X4DSupplierResponseComplete__c' => false,
                                            'X4DDueDate__c' => true,
                                            'BLANK' => false,         // to leave black space on the page
                                            'X4DDaysAllowed__c' => false
                                            /*
                                            'X4DSupplierResponse__c' => true,
                                            'X4DSupplierContributors__c' => true,
                                            'X4DSupplierResponseComplete__c' => true,
                                            'X4DOwnerResponse__c' => true,
                                            'X4DOwnerApproveReject__c' => true,
                                            'X4DDueDate__c' => true,
                                            'X4DDaysAllowed__c' => false*/
            },
            'Verfication & closure' => new Map<String, Boolean>{
                                            
                                            'X5DSupplierResponse__c' => false,
                                            'X5DOwnerApproveReject__c' => true,
                                            'X5DSupplierContributors__c' => false,
                                            'X5DOwnerResponse__c' => true,
                                            'X5DSupplierResponseComplete__c' => false,
                                            'X5DDueDate__c' => true,
                                            'BLANK' => false,         // to leave black space on the page
                                            'X5DDaysAllowed__c' => false
                                            /*
                                            'X5DSupplierResponse__c' => true,
                                            'X5DSupplierContributors__c' => true,
                                            'X5DSupplierResponseComplete__c' => true,
                                            'X5DOwnerResponse__c' => true,
                                            'X5DOwnerApproveReject__c' => true,
                                            'X5DDueDate__c' => true,
                                            'X5DDaysAllowed__c' => false */
            },
            'Audit Details' => new Map<String, Boolean>{
                                            'DetailsDayAllowed__c' => true
            },
            'Phase out details' => new Map<String, Boolean>{
                                            'DetailsDayAllowed__c' => true,
                                            'CategoryManager__c' => true
            },
            'Phase out Plan' => new Map<String, Boolean>{
                                            'VolumeReductionTargetDate_50__c' => true, 
                                            'VolumeReductionTargetDate_100__c' => true, 
                                            'StakeholderCommunicationTarget__c' => true, 
                                            'ContractTerminationTarget__c' => true
            },
            'Phase out Status' => new Map<String, Boolean>{
                                            'VolumeReductionActualDate_50__c' => true, 
                                            'VolumeReductionActualDate_100__c' => true, 
                                            'StakeholderCommunicationActual__c' => true,
                                            'ContractTerminationActual__c' => true,
                                            'RampDownUp__c' => true,
                                            'BLANK' => false         // to leave black space on the page
            },
            'WatchList Details' => new Map<String, Boolean>{
                                            'DetailsDayAllowed__c' => true
            }
        };
        return sectionFieldvalueMap;
    }
    
    public static List<String> getFieldsAPINames()
    {
        Schema.DescribeSObjectResult r = SPE_ConsequenceManagement__c.sObjectType.getDescribe();
        List<String> apiNames =  new list<String>();
        for (string apiName : r.fields.getMap().keySet())
        {
           apiNames.add(apiName);
        }
        
        return  apiNames;  
    }
    
    public static Set<String> getRequiredFields()
    {
        Set<String> requiredFields = new Set<String>{'Title__c', 'KPIName__c', 'Supplier__c', 'ProblemDescriptionDetails__c'};
        
        return  requiredFields ;  
    }
}