@isTest(seeAllData=False)

public class SPE2_categoryUpdateTest{

 static testMethod void TestSPE2_categoryUpdate(){
     
     
      
     SPE_CategoryMaster__c cm = new SPE_CategoryMaster__c();
     cm.Category__c = 'All Categories';
     cm.Cluster__c = 'All Category Areas';
     cm.Group__c = 'All Category Groups';
     insert cm;
     
     cm.Group__c = 'All Category Groups1234';
     update cm;
     
     SPE_BUBL__c buBl = new SPE_BUBL__c();
     buBl.BusinessLine__c = 'All Business Lines';    
     buBl.BusinessUnit__c = 'All Business Units';
     buBl.Product__c = 'All Projects';
     buBl.ProductCode__c = 'rfff';
     insert buBl;
     
     buBl.BusinessUnit__c = 'All Business Units128';
     update buBl;
     
     SPE_ProjectMaster__c PM = new SPE_ProjectMaster__c();
     PM.Market__c = 'All Markets';
     PM.MarketUnit__c = 'All Market Units';
     PM.Project__c = 'All Projects'; 
     PM.Region__c  = 'All Countries';
     PM.Country__c  = 'All Countries';
     insert PM;
     
     SPE_CategoryInfo__c catInfo = new SPE_CategoryInfo__c();
     catInfo.BusinessLine__c = 'All Business Lines';    
     catInfo.BusinessUnit__c = 'All Business Units';
     catInfo.Category__c = 'All Categories';
     catInfo.CategoryCluster__c = 'All Category Areas';
     catInfo.Group__c = 'All Category Groups';
     catInfo.CategoryGroup__c = 'All Category Groups';
     catInfo.Region__c = 'All Countries';
     catInfo.SubRegion__c = 'All Countries121';
     catInfo.Product__c = 'All Projects';
     catInfo.ProductMaster__c = buBl.id;
     catInfo.ProjectMaster__c = PM.id;
     catInfo.CategoryMaster__c = cm.id;
     insert catInfo; 
     
     catInfo.BusinessLine__c = 'All Business Lines112';    
     update catInfo;
     
     
 }
}