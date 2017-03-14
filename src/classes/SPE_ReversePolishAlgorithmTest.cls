@isTest(SeeAllData=false)
private class SPE_ReversePolishAlgorithmTest{
     static testMethod void testSPE_ReversePolishAlgorithmTest(){
         Test.startTest();
             List<Object> objectListActual = new List<Object>();
             objectListActual.add(10.0);
             objectListActual.add(20.0);
             objectListActual.add(30.0);
             SPE_ReversePolishAlgorithm.reversePolishCalculation(objectListActual);
             SPE_ReversePolishAlgorithm.conditionComparision(2.0,2.0,'==');
             SPE_ReversePolishAlgorithm.conditionComparision(3.0,2.0,'>');
             SPE_ReversePolishAlgorithm.conditionComparision(3.0,2.0,'>=');
             SPE_ReversePolishAlgorithm.conditionComparision(2.0,3.0,'<');
             SPE_ReversePolishAlgorithm.conditionComparision(2.0,3.0,'<=');
             SPE_ReversePolishAlgorithm.conditionComparision(1.0,2.0,'!=');
             SPE_ReversePolishAlgorithm.conditionComparision(null,2.0,'Null');
             SPE_ReversePolishAlgorithm.conditionComparision(2.0,null,'Not Null');
         Test.stopTest();
     }
     static testMethod void testSPE_ReversePolishAlgorithmTest1(){
         Test.startTest();
             List<Date> DateListActual = new List<Date>();
             DateListActual.add(Date.newInstance(2016,6,24));
             DateListActual.add(Date.newInstance(2016,7,24));
            // objectListActual.add('C');
             SPE_ReversePolishAlgorithm.reversePolishCalculationDate(DateListActual);
         Test.stopTest();
     }
     static testMethod void testSPE_ReversePolishAlgorithmTest2(){
         Test.startTest();
            List<Object> objectListActual = new List<Object>();
            objectListActual.add(10);
            objectListActual.add(5);
            objectListActual.add('*');
            SPE_ReversePolishAlgorithm.reversePolishCalculation(objectListActual);
            List<Object> objectListActual1 = new List<Object>();
            objectListActual1.add(10);
            objectListActual1.add(5);
            objectListActual1.add('+');
            SPE_ReversePolishAlgorithm.reversePolishCalculation(objectListActual1);
            List<Object> objectListActual2 = new List<Object>();
            objectListActual2.add(10);
            objectListActual2.add(5);
            objectListActual2.add('-');
            SPE_ReversePolishAlgorithm.reversePolishCalculation(objectListActual2);
            List<Object> objectListActual3 = new List<Object>();
            objectListActual3.add(10);
            objectListActual3.add(5);
            objectListActual3.add('/');
            SPE_ReversePolishAlgorithm.reversePolishCalculation(objectListActual3);
            List<Object> objectListActual4 = new List<Object>();
            objectListActual4.add(10);
            objectListActual4.add(0);
            objectListActual4.add('/');
            SPE_ReversePolishAlgorithm.reversePolishCalculation(objectListActual4);
               
            List<Object> DateListActual = new List<Object>();
            DateListActual.add(Date.newInstance(2016,6,24));
            DateListActual.add(Date.newInstance(2016,7,24));
            DateListActual.add('-');
            SPE_ReversePolishAlgorithm.reversePolishCalculationDate(DateListActual);
         Test.stopTest();
     }
     
      static testMethod void testSPE_ReversePolishAlgorithmTest3(){
         Test.startTest();
            List<Object> objectListActual = new List<Object>();
            objectListActual.add(10.0);
            SPE_ReversePolishAlgorithm.reversePolishCalculation(objectListActual);
            List<Date> DateListActual = new List<Date>();
            DateListActual.add(Date.newInstance(2016,6,24));
            SPE_ReversePolishAlgorithm.reversePolishCalculationDate(DateListActual);
         Test.stopTest();
     }
}