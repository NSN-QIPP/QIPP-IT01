function populateMarketUnitJS(a){
        
           document.getElementById('pg:fm:pb:criteria:chooseMarketUnit').disabled='true';
           document.getElementById('pg:fm:pb:criteria:chooseCountry').disabled='true';
           document.getElementById('pg:fm:pb:criteria:chooseProject').disabled='true'; 
           document.getElementById('pg:fm:pb:criteria:chooseBU').disabled='true';
           document.getElementById('pg:fm:pb:criteria:chooseBL').disabled='true';
           document.getElementById('pg:fm:pb:criteria:chooseProduct').disabled='true';
           document.getElementById('pg:fm:pb:criteria:chooseCatArea').disabled='true';
           document.getElementById('pg:fm:pb:criteria:chooseCatGroup').disabled='true';
           document.getElementById('pg:fm:pb:criteria:chooseCategory').disabled='true';
           populateMarketUnit(a);
   
        }
        
        function populateCountryJS(val){
           document.getElementById('pg:fm:pb:criteria:chooseMarket').disabled='true';
           document.getElementById('pg:fm:pb:criteria:chooseCountry').disabled='true';
           document.getElementById('pg:fm:pb:criteria:chooseProject').disabled='true'; 
           document.getElementById('pg:fm:pb:criteria:chooseBU').disabled='true';
           document.getElementById('pg:fm:pb:criteria:chooseBL').disabled='true';
           document.getElementById('pg:fm:pb:criteria:chooseProduct').disabled='true';
           document.getElementById('pg:fm:pb:criteria:chooseCatArea').disabled='true';
           document.getElementById('pg:fm:pb:criteria:chooseCatGroup').disabled='true';
           document.getElementById('pg:fm:pb:criteria:chooseCategory').disabled='true';
           populateCountry(val);
 
        }
        
        function populateCountryJS1(){
           document.getElementById('pg:fm:pb:criteria:chooseMarket').disabled='false';
           document.getElementById('pg:fm:pb:criteria:chooseCountry').disabled='false';
           document.getElementById('pg:fm:pb:criteria:chooseProject').disabled='false'; 
           document.getElementById('pg:fm:pb:criteria:chooseBU').disabled='false';
           document.getElementById('pg:fm:pb:criteria:chooseBL').disabled='false';
           document.getElementById('pg:fm:pb:criteria:chooseProduct').disabled='false';
           document.getElementById('pg:fm:pb:criteria:chooseCatArea').disabled='false';
           document.getElementById('pg:fm:pb:criteria:chooseCatGroup').disabled='false';
           document.getElementById('pg:fm:pb:criteria:chooseCategory').disabled='false';
  
        }
       
        
        function populatePrjJS(val){
            document.getElementById('pg:fm:pb:criteria:chooseMarket').disabled='true';
			document.getElementById('pg:fm:pb:criteria:chooseMarketUnit').disabled='true';
            document.getElementById('pg:fm:pb:criteria:chooseCountry').disabled='true';
            document.getElementById('pg:fm:pb:criteria:chooseProject').disabled='true'; 
            document.getElementById('pg:fm:pb:criteria:chooseBU').disabled='true';
            document.getElementById('pg:fm:pb:criteria:chooseBL').disabled='true';
            document.getElementById('pg:fm:pb:criteria:chooseProduct').disabled='true';
            document.getElementById('pg:fm:pb:criteria:chooseCatArea').disabled='true';
            document.getElementById('pg:fm:pb:criteria:chooseCatGroup').disabled='true';
            document.getElementById('pg:fm:pb:criteria:chooseCategory').disabled='true';
            populatePrj(val);
            
        }

        function populatePrjJS1()
        {
            document.getElementById('pg:fm:pb:criteria:chooseMarket').disabled='false';
			document.getElementById('pg:fm:pb:criteria:chooseMarketUnit').disabled='false';
            document.getElementById('pg:fm:pb:criteria:chooseCountry').disabled='false';
            document.getElementById('pg:fm:pb:criteria:chooseProject').disabled='false'; 
            document.getElementById('pg:fm:pb:criteria:chooseBU').disabled='false';
            document.getElementById('pg:fm:pb:criteria:chooseBL').disabled='false';
            document.getElementById('pg:fm:pb:criteria:chooseProduct').disabled='false';
            document.getElementById('pg:fm:pb:criteria:chooseCatArea').disabled='false';
            document.getElementById('pg:fm:pb:criteria:chooseCatGroup').disabled='false';
            document.getElementById('pg:fm:pb:criteria:chooseCategory').disabled='false';
        
        }
        function populateBLJS(val){
             buValue = val;
             document.getElementById('pg:fm:pb:criteria:chooseBL').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseProduct').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseCatArea').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseCatGroup').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseCategory').disabled='true';
			 document.getElementById('pg:fm:pb:criteria:chooseMarket').disabled='true';
			 document.getElementById('pg:fm:pb:criteria:chooseMarketUnit').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseCountry').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseProject').disabled='true';
             populateBL(val);
          }
          
        function  populateBLJS1(){
             document.getElementById('pg:fm:pb:criteria:chooseBL').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseProduct').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseCatArea').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseCatGroup').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseCategory').disabled='false';
			 document.getElementById('pg:fm:pb:criteria:chooseMarket').disabled='false';
			 document.getElementById('pg:fm:pb:criteria:chooseMarketUnit').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseCountry').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseProject').disabled='false';
        } 
        
        function populateProductJS(val){
             blValue = val;
			 document.getElementById('pg:fm:pb:criteria:chooseBU').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseProduct').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseCatArea').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseCatGroup').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseCategory').disabled='true';
			 document.getElementById('pg:fm:pb:criteria:chooseMarket').disabled='true';
			 document.getElementById('pg:fm:pb:criteria:chooseMarketUnit').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseCountry').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseProject').disabled='true';
             populateProduct(val);
        }
        
        function populateProductJS1(){
            document.getElementById('pg:fm:pb:criteria:chooseBU').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseProduct').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseCatArea').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseCatGroup').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseCategory').disabled='false';
			 document.getElementById('pg:fm:pb:criteria:chooseMarket').disabled='false';
			 document.getElementById('pg:fm:pb:criteria:chooseMarketUnit').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseCountry').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseProject').disabled='false';
        }
        
         function populateCatGroupJS(val){
         document.getElementById('pg:fm:pb:criteria:chooseCatGroup').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseCategory').disabled='true';
			 document.getElementById('pg:fm:pb:criteria:chooseMarket').disabled='true';
			 document.getElementById('pg:fm:pb:criteria:chooseMarketUnit').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseCountry').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseProject').disabled='true';
			 document.getElementById('pg:fm:pb:criteria:chooseBU').disabled='true';
			 document.getElementById('pg:fm:pb:criteria:chooseBL').disabled='true';
             document.getElementById('pg:fm:pb:criteria:chooseProduct').disabled='true';
         populateCatGroup(val);
        }
        
        function populateCatGroupJS1(){
         document.getElementById('pg:fm:pb:criteria:chooseCatGroup').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseCategory').disabled='false';
			 document.getElementById('pg:fm:pb:criteria:chooseMarket').disabled='false';
			 document.getElementById('pg:fm:pb:criteria:chooseMarketUnit').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseCountry').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseProject').disabled='false';
			 document.getElementById('pg:fm:pb:criteria:chooseBU').disabled='false';
			 document.getElementById('pg:fm:pb:criteria:chooseBL').disabled='false';
             document.getElementById('pg:fm:pb:criteria:chooseProduct').disabled='false';
        
        }
        
        function populateCatJS(val){
		 document.getElementById('pg:fm:pb:criteria:chooseCatArea').disabled='true';
         document.getElementById('pg:fm:pb:criteria:chooseCategory').disabled='true';
		 document.getElementById('pg:fm:pb:criteria:chooseMarket').disabled='true';
		 document.getElementById('pg:fm:pb:criteria:chooseMarketUnit').disabled='true';
		 document.getElementById('pg:fm:pb:criteria:chooseCountry').disabled='true';
		 document.getElementById('pg:fm:pb:criteria:chooseProject').disabled='true';
		 document.getElementById('pg:fm:pb:criteria:chooseBU').disabled='true';
		 document.getElementById('pg:fm:pb:criteria:chooseBL').disabled='true';
		 document.getElementById('pg:fm:pb:criteria:chooseProduct').disabled='true';
         populateCat(val);
                
        }
        
        function populateCatJS1(){
         document.getElementById('pg:fm:pb:criteria:chooseCatArea').disabled='false';
         document.getElementById('pg:fm:pb:criteria:chooseCategory').disabled='false';
		 document.getElementById('pg:fm:pb:criteria:chooseMarket').disabled='false';
		 document.getElementById('pg:fm:pb:criteria:chooseMarketUnit').disabled='false';
		 document.getElementById('pg:fm:pb:criteria:chooseCountry').disabled='false';
		 document.getElementById('pg:fm:pb:criteria:chooseProject').disabled='false';
		 document.getElementById('pg:fm:pb:criteria:chooseBU').disabled='false';
		 document.getElementById('pg:fm:pb:criteria:chooseBL').disabled='false';
		 document.getElementById('pg:fm:pb:criteria:chooseProduct').disabled='false';
        }