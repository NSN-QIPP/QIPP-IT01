public with sharing class QIRSProductIdentification{
    public List<QIRS_Product_Identification__c> productAddList {get;set;}
    String parentQirsID;
    public Integer indexes {set;get;}
    public Integer rowNum  {Set;get;}
    private QIRS__c qirsRec;

    public QIRSProductIdentification(ApexPages.StandardController controller) {
		String returnURLValue = ApexPages.currentPage().getParameters().get('retURL');
      	if(returnURLValue != null) parentQirsID = returnURLValue.remove('/'); 
      
		if(parentQirsID != null){
			productAddList= new List<QIRS_Product_Identification__c>();   
			productAddList.add(new QIRS_Product_Identification__c(qirs__c = parentQirsID));
            rowNum=1;
		}
	}

    public void AddRow(){
       productAddList.add(new QIRS_Product_Identification__c(qirs__c=parentQirsID));
    }
    
    public void delRow(){
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        productAddList.remove(rowNum);   
    }
    
    public void cloneRow(){
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        productAddList.add(new QIRS_Product_Identification__c(qirs__c=parentQirsID,Name__c=productAddList[rowNum].Name__c,Technology__c=productAddList[rowNum].Technology__c,Product_Name__c=productAddList[rowNum].Product_Name__c,Launch_Date__c=productAddList[rowNum].Launch_Date__c));   
    }    

    public pagereference  saveMemb(){
		try{
			insert productAddList;
	        QIRS__c theParent = new QIRS__c(id=productAddList[0].QIRS__c);
	        PageReference QIRSPage = new ApexPages.StandardController(theParent).view();
	        QIRSPage.setRedirect(true);
	        return QIRSPage;
		}catch(Exception ex){
			String errorMsg = ex.getMessage();
			if(errorMsg.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION')){
				errorMsg = errorMsg.split('FIELD_CUSTOM_VALIDATION_EXCEPTION,')[1];
			}else{
				errorMsg = 'Some error occured. Please contact adminstrator.';
			}
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,errorMsg));
			return null;
		}
    }
}