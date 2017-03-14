function populateMarketUnitJS(a){
        
           document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem2Id:chooseMarketUnit').disabled='true';
           document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem3Id:chooseCountry').disabled='true';
           document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem4Id:chooseProject').disabled='true'; 
           document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem5Id:chooseBU').disabled='true';
           document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem10Id:chooseBL').disabled='true';
           
           document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem7Id:chooseProduct').disabled='true';
           document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem11Id:chooseCatArea').disabled='true';
           document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem12Id:chooseCatGroup').disabled='true';
           document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem113Id:chooseCategory').disabled='true';
           populateMarketUnit(a);
   
        }
        function populateMarketUnitJS1(){
    
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem2Id:chooseMarketUnit').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem3Id:chooseCountry').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem4Id:chooseProject').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem5Id:chooseBU').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem10Id:chooseBL').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem7Id:chooseProduct').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem11Id:chooseCatArea').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem12Id:chooseCatGroup').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem113Id:chooseCategory').disabled=false;
            
    }
        function populateCountryJS(val){
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem1Id:chooseMarket').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem3Id:chooseCountry').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem4Id:chooseProject').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem5Id:chooseBU').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem10Id:chooseBL').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem7Id:chooseProduct').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem11Id:chooseCatArea').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem12Id:chooseCatGroup').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem113Id:chooseCategory').disabled='true';
             
             populateCountry(val);
 
        }
        
        function populateCountryJS1(){
        
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem1Id:chooseMarket').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem3Id:chooseCountry').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem4Id:chooseProject').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem5Id:chooseBU').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem10Id:chooseBL').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem7Id:chooseProduct').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem11Id:chooseCatArea').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem12Id:chooseCatGroup').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem113Id:chooseCategory').disabled=false;
  
        }
       
        
        function populatePrjJS(val){
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem1Id:chooseMarket').disabled='true';
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem2Id:chooseMarketUnit').disabled='true';
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem4Id:chooseProject').disabled='true';
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem5Id:chooseBU').disabled='true';
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem10Id:chooseBL').disabled='true';
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem7Id:chooseProduct').disabled='true';
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem11Id:chooseCatArea').disabled='true';
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem12Id:chooseCatGroup').disabled='true';
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem113Id:chooseCategory').disabled='true';
            populatePrj(val);
            
        }

        function populatePrjJS1()
        {
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem1Id:chooseMarket').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem2Id:chooseMarketUnit').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem4Id:chooseProject').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem5Id:chooseBU').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem10Id:chooseBL').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem7Id:chooseProduct').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem11Id:chooseCatArea').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem12Id:chooseCatGroup').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem113Id:chooseCategory').disabled=false;
        
        }
        function populateBLJS(val){
             buValue = val;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem10Id:chooseBL').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem7Id:chooseProduct').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem1Id:chooseMarket').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem2Id:chooseMarketUnit').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem4Id:chooseProject').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem3Id:chooseCountry').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem11Id:chooseCatArea').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem12Id:chooseCatGroup').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem113Id:chooseCategory').disabled='true';
             populateBL(val);
          }
          
        function  populateBLJS1(){
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem10Id:chooseBL').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem7Id:chooseProduct').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem1Id:chooseMarket').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem2Id:chooseMarketUnit').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem4Id:chooseProject').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem3Id:chooseCountry').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem11Id:chooseCatArea').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem12Id:chooseCatGroup').disabled=false;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem113Id:chooseCategory').disabled=false;
        } 
        
        function populateProductJS(val){
             blValue = val;
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem5Id:chooseBU').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem7Id:chooseProduct').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem1Id:chooseMarket').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem2Id:chooseMarketUnit').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem4Id:chooseProject').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem3Id:chooseCountry').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem11Id:chooseCatArea').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem12Id:chooseCatGroup').disabled='true';
             document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem113Id:chooseCategory').disabled='true';
             populateProduct(val);
        }
        
        function populateProductJS1(){
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem5Id:chooseBU').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem7Id:chooseProduct').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem1Id:chooseMarket').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem2Id:chooseMarketUnit').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem4Id:chooseProject').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem3Id:chooseCountry').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem11Id:chooseCatArea').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem12Id:chooseCatGroup').disabled=false;
            document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem113Id:chooseCategory').disabled=false;
        }
        
         function populateCatGroupJS(val){
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem12Id:chooseCatGroup').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem113Id:chooseCategory').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem1Id:chooseMarket').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem2Id:chooseMarketUnit').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem4Id:chooseProject').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem3Id:chooseCountry').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem5Id:chooseBU').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem10Id:chooseBL').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem7Id:chooseProduct').disabled='true';
         populateCatGroup(val);
        }
        
        function populateCatGroupJS1(){
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem12Id:chooseCatGroup').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem113Id:chooseCategory').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem1Id:chooseMarket').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem2Id:chooseMarketUnit').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem4Id:chooseProject').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem3Id:chooseCountry').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem5Id:chooseBU').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem10Id:chooseBL').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem7Id:chooseProduct').disabled=false;
        
        }
        
        function populateCatJS(val){
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem11Id:chooseCatArea').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem113Id:chooseCategory').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem1Id:chooseMarket').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem2Id:chooseMarketUnit').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem4Id:chooseProject').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem3Id:chooseCountry').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem5Id:chooseBU').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem10Id:chooseBL').disabled='true';
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem7Id:chooseProduct').disabled='true';

         populateCat(val);
                
        }
        
        function populateCatJS1(){
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem11Id:chooseCatArea').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem113Id:chooseCategory').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem1Id:chooseMarket').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem2Id:chooseMarketUnit').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem4Id:chooseProject').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem3Id:chooseCountry').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem5Id:chooseBU').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem10Id:chooseBL').disabled=false;
         document.getElementById('pgId:frmId:detail:pgsection:pgSectionItem7Id:chooseProduct').disabled=false;
        }