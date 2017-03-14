@isTest

public class SPE_DataLoaderExtTest {
    static testmethod void testSPE_DataLoaderExt() {
        test.startTest();
        SPE_PIDefinition__c PIDefObj = new SPE_PIDefinition__c();
        PIDefObj = SPE_TestObjectCreator.CreatePIDefinition();
        
        //***************Changes for Encryption****************//
        //PIDefObj.Name = 'Test PI Definition';
        PIDefObj.PI_Title__c = 'Test PI Definition';
        //*************End******************//
        
        PIDefObj.LifecycleStage__c = 'Draft';
        
        insert PIDefObj;
        
        //-----update PI Definition data ----
        
        PIDefObj.LifecycleStage__c= 'Published';
        update PIDefObj;
        
        system.assertequals(PIDefObj.LifecycleStage__c,'Published');
        ApexPages.StandardController sc = new ApexPages.StandardController(PIDefObj);
        SPE_DataLoaderExt objDtLoader = new SPE_DataLoaderExt(sc); 
        
        PIDefObj.ValuesType__c= 'Date';
        update PIDefObj;
        ApexPages.StandardController sc1 = new ApexPages.StandardController(PIDefObj);
        SPE_DataLoaderExt objDtLoader1 = new SPE_DataLoaderExt(sc1);
        system.assertEquals(objDtLoader1.strValueType, 'DateValue__c');
        
        PIDefObj.ValuesType__c= 'String';
        update PIDefObj;
        ApexPages.StandardController sc2 = new ApexPages.StandardController(PIDefObj);
        SPE_DataLoaderExt objDtLoader2 = new SPE_DataLoaderExt(sc2);
        system.assertEquals(objDtLoader2.strValueType, 'StringValue__c');
        PIDefObj.ValuesType__c= 'Boolean';
        update PIDefObj;
        ApexPages.StandardController sc3 = new ApexPages.StandardController(PIDefObj);
        SPE_DataLoaderExt objDtLoader3 = new SPE_DataLoaderExt(sc3);
        system.assertEquals(objDtLoader3.strValueType, 'BooleanValue__c');
        test.stopTest();
    }
}