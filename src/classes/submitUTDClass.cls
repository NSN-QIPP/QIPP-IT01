public with sharing class submitUTDClass {

    public string ResponseID{get; set;}
    // Static variable that assumes a test is not running
    public static boolean isApexTest = false;
    Id temp;
    list<Measurement__c> lstMeasure = new list<Measurement__c>();
    
    public submitUTDClass(String value){
        if(null != value){
            isApexTest = true;
        }
    }
    
    public submitUTDClass (ApexPages.StandardController controller) 
    {
    }
    
    public pagereference processUTDService(){
        temp = ApexPages.currentPage().getParameters().get('id');
        
        lstMeasure = [select User_Name__c, Registration_ID__c,Product_Category_Table_Name__c,Product_Category__c,
        Product_Category_Name__c,Data_Template_Type__c,Software_Option__c,Year_Of_Data__c,Month_Of_Data__c,
        Product_Location__c,NPRs_7_5__c,Np4_7_5__c,Fr4c_7_5__c, Fr4d_7_5__c,Of4c_7_5__c,Of4d_7_5__c,
        DVa_7_5__c,DVd_7_5__c,Nso_7_5__c,Ns_7_5__c,SQd_7_5__c,SQt_7_5__c,
        NPRa__c,NPRs__c,Np1__c,Np2__c,Np3__c,Fr2c__c,Fr2d__c,Fr3c__c,Fr3d__c,Of2c__c,Of2d__c,Of3c__c,Of3d__c,
        DIa__c,DId__c, DIPa__c, DIPd__c, SOa__c,SOs__c,SOea__c,SOda__c,SOep__c,SOdp__c,
        NEOa__c,NEOs__c,NEOec__c,NEOdc__c,NEOep__c,NEOdp__c,
        FRa__c,FRs__c,FRri__c,FRry__c,FRrt__c,FRsi__c,FRsy__c,FRst__c,
        DFc__c,Fc__c,SPRa__c,SPRs__c,Sp1__c,Sp2__c,Sp3__c,
        Submit_Data__c,Response_from_UTD__c,submit_yes_no__c,rSOa__c,rSOda__c,rSOdp__c,rSOea__c,rSOep__c,rSOs__c,rNEOa__c,rNEOdc__c,rNEOdp__c,rNEOec__c,rNEOep__c,rNEOs__c,hSOa__c,hSOda__c,hSOdp__c,hSOea__c,hSOep__c,hSOs__c,hNEOa__c,hNEOdc__c,hNEOdp__c,hNEOec__c,hNEOep__c,hNEOs__c,TEc__c,TEnc__c,TMc__c,TMnc__c from Measurement__c where Id =: temp limit 1];
        
        System.debug('$$$$$$$$$$$$$$$$$$submit_yes_no__c$$$$$$$$$$$$$$$$$$$$$:'+lstMeasure[0].submit_yes_no__c);
        
        System.debug('submit data value==============: '+lstMeasure[0].Submit_Data__c);
        // checking whether the submit data is live mode or test mode, if it is test mode we are setting true else its false
        String testorlive = 'true';
        if(lstMeasure[0].Submit_Data__c == 'LIVE'){
            testorlive = 'false';
        }
        System.debug('testorlive value============: '+testorlive);
        
        // finding the date time stamp 
        datetime myDateTime = datetime.now();
        System.debug('date time stamp:::::: '+myDateTime);
        
        // formatting datetimestamp
        String transactionIDFormat = myDateTime.format('ddMMyyyyhhmmsss','GMT');
        String encryptionIDFormat = myDateTime.format('ddMMyyyyhhmmssss','GMT');
        System.debug('transactionIDFormat time stamp after formatting:::::: '+transactionIDFormat);
        System.debug('encryptionIDFormat time stamp after formatting:::::: '+encryptionIDFormat);
        
        // Webservice call out start
        string SoapXMLBody;
        string SoapCommonXml;
        string SoapNon75Category;
        string SoapEndPart;
        string soap75category;
        System.debug('************************ nprs value**********************:  '+lstMeasure[0].NPRs_7_5__c);
        System.debug('************************ NPRa value**********************:  '+lstMeasure[0].NPRa__c);
      //SoapXMLBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tran="http://Transport.B2B"><soapenv:Header><userName>vijay.gopalabhatla@nsn.com</userName><password>31399Q</password></soapenv:Header><soapenv:Body><ns1:CustomerWrapper xmlns:ns1="urn:customer"><![CDATA[<?xml version="1.0" encoding="UTF-8"?><TL9000 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><ClientInfo><TransactionId>291120110849578</TransactionId></ClientInfo><RequestInfo><TestMode>True</TestMode><RequestType>SubmitData</RequestType><RegistrationId>TL1310</RegistrationId><ProductCategoryTableName>4.5</ProductCategoryTableName><ProductCategory>7.5</ProductCategory><ProductCategoryName>CustomerSupportServices</ProductCategoryName><DataTemplateType>V</DataTemplateType><SoftwareOption>0</SoftwareOption><YearOfFirstMonthOfData>2011</YearOfFirstMonthOfData><FirstMonthOfData>3</FirstMonthOfData><ProductLocation>ALL</ProductLocation><EncryptionKey>2911201108490057</EncryptionKey><Email><AutoOption>On</AutoOption><ToAddress>CDS022@motorolasolutions.com</ToAddress></Email><SubmissionData><Measurement ID="NPR"><NPRs>1971</NPRs><Np4>1</Np4></Measurement><Measurement ID="FRT"><Fr4c>0</Fr4c><Fr4d>0</Fr4d></Measurement><Measurement ID="OFR"><Of4c>0</Of4c><Of4d>0</Of4d></Measurement><Measurement ID="OTD"><DVa>2653</DVa><DVd>2885</DVd></Measurement><Measurement ID="SSO"><Nso>0</Nso><Ns>2722</Ns></Measurement><Measurement ID="SQ"><SQd>18</SQd><SQt>2722</SQt></Measurement></SubmissionData></RequestInfo></TL9000>]]></ns1:CustomerWrapper></soapenv:Body></soapenv:Envelope>';
        
        // Common soap envolope
        SoapCommonXml = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tran="http://Transport.B2B"><soapenv:Body><ns1:CustomerWrapper xmlns:ns1="urn:customer"><![CDATA[<?xml version="1.0" encoding="UTF-8"?><TL9000 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><ClientInfo><TransactionId>'+transactionIDFormat+'</TransactionId></ClientInfo><RequestInfo><TestMode>'+testorlive+'</TestMode><RequestType>SubmitData</RequestType><RegistrationId>'+lstMeasure[0].Registration_ID__c+'</RegistrationId><ProductCategoryTableName>'+lstMeasure[0].Product_Category_Table_Name__c+'</ProductCategoryTableName><ProductCategory>'+lstMeasure[0].Product_Category__c+'</ProductCategory><ProductCategoryName>'+lstMeasure[0].Product_Category_Name__c+'</ProductCategoryName><DataTemplateType>'+lstMeasure[0].Data_Template_Type__c+'</DataTemplateType><SoftwareOption>'+lstMeasure[0].Software_Option__c+'</SoftwareOption><YearOfFirstMonthOfData>'+lstMeasure[0].Year_Of_Data__c+'</YearOfFirstMonthOfData><FirstMonthOfData>'+lstMeasure[0].Month_Of_Data__c+'</FirstMonthOfData><ProductLocation>'+lstMeasure[0].Product_Location__c+'</ProductLocation><EncryptionKey>'+encryptionIDFormat+'</EncryptionKey><Email><AutoOption>On</AutoOption><ToAddress>'+lstMeasure[0].User_Name__c+'</ToAddress></Email>';
        // Product Category 7.5 Soap message that needs to be added in between SoapCommonXml and SoapEndPart
        soap75category = '<SubmissionData><Measurement ID="NPR"><NPRs>'+lstMeasure[0].NPRs_7_5__c+'</NPRs><Np4>'+lstMeasure[0].Np4_7_5__c+'</Np4></Measurement><Measurement ID="FRT"><Fr4c>'+lstMeasure[0].Fr4c_7_5__c+'</Fr4c><Fr4d>'+lstMeasure[0].Fr4d_7_5__c+'</Fr4d></Measurement><Measurement ID="OFR"><Of4c>'+lstMeasure[0].Of4c_7_5__c+'</Of4c><Of4d>'+lstMeasure[0].Of4d_7_5__c+'</Of4d></Measurement><Measurement ID="OTD"><DVa>'+lstMeasure[0].DVa_7_5__c+'</DVa><DVd>'+lstMeasure[0].DVd_7_5__c+'</DVd></Measurement><Measurement ID="SSO"><Nso>'+lstMeasure[0].Nso_7_5__c+'</Nso><Ns>'+lstMeasure[0].Ns_7_5__c+'</Ns></Measurement><Measurement ID="SQ"><SQd>'+lstMeasure[0].SQd_7_5__c+'</SQd><SQt>'+lstMeasure[0].SQt_7_5__c+'</SQt></Measurement><Measurement ID="MTRS"><TMc>'+lstMeasure[0].TMc__c+'</TMc><TEc>'+lstMeasure[0].TEc__c+'</TEc><TMnc>'+lstMeasure[0].TMnc__c+'</TMnc><TEnc>'+lstMeasure[0].TEnc__c+'</TEnc></Measurement></SubmissionData></RequestInfo></TL9000>';
        // Non Product Category 7.5 Soap message that needs to be added in between SoapCommonXml and SoapEndPart
        SoapNon75Category = '<SubmissionData><Measurement ID="NPR"><NPRa>'+lstMeasure[0].NPRa__c+'</NPRa><NPRs>'+lstMeasure[0].NPRs__c+'</NPRs><Np1>'+lstMeasure[0].Np1__c+'</Np1><Np2>'+lstMeasure[0].Np2__c+'</Np2><Np3>'+lstMeasure[0].Np3__c+'</Np3></Measurement><Measurement ID="FRT"><Fr2c>'+lstMeasure[0].Fr2c__c+'</Fr2c><Fr2d>'+lstMeasure[0].Fr2d__c+'</Fr2d><Fr3c>'+lstMeasure[0].Fr3c__c+'</Fr3c><Fr3d>'+lstMeasure[0].Fr3d__c+'</Fr3d></Measurement><Measurement ID="OFR"><Of2c>'+lstMeasure[0].Of2c__c+'</Of2c><Of2d>'+lstMeasure[0].Of2d__c+'</Of2d><Of3c>'+lstMeasure[0].Of3c__c+'</Of3c><Of3d>'+lstMeasure[0].Of3d__c+'</Of3d></Measurement><Measurement ID="OTD"><DIa>'+lstMeasure[0].DIa__c+'</DIa><DId>'+lstMeasure[0].DId__c+'</DId><DIPa>'+lstMeasure[0].DIPa__c+'</DIPa><DIPd>'+lstMeasure[0].DIPd__c+'</DIPd></Measurement><Measurement ID="SO"><SOa>'+lstMeasure[0].SOa__c+'</SOa><SOs>'+lstMeasure[0].SOs__c+'</SOs><SOea>'+lstMeasure[0].SOea__c+'</SOea><SOda>'+lstMeasure[0].SOda__c+'</SOda><SOep>'+lstMeasure[0].SOep__c+'</SOep><SOdp>'+lstMeasure[0].SOdp__c+'</SOdp><hSOa>'+lstMeasure[0].hSOa__c+'</hSOa><hSOs>'+lstMeasure[0].hSOs__c+'</hSOs><hSOea>'+lstMeasure[0].hSOea__c+'</hSOea><hSOda>'+lstMeasure[0].hSOda__c+'</hSOda><hSOep>'+lstMeasure[0].hSOep__c+'</hSOep><hSOdp>'+lstMeasure[0].hSOdp__c+'</hSOdp><rSOa>'+lstMeasure[0].rSOa__c+'</rSOa><rSOda>'+lstMeasure[0].rSOda__c+'</rSOda><rSOdp>'+lstMeasure[0].rSOdp__c+'</rSOdp><rSOea>'+lstMeasure[0].rSOea__c+'</rSOea><rSOep>'+lstMeasure[0].rSOep__c+'</rSOep><rSOs>'+lstMeasure[0].rSOs__c+'</rSOs></Measurement><Measurement ID="SONE"><NEOa>'+lstMeasure[0].NEOa__c+'</NEOa><NEOs>'+lstMeasure[0].NEOs__c+'</NEOs><NEOec>'+lstMeasure[0].NEOec__c+'</NEOec><NEOdc>'+lstMeasure[0].NEOdc__c+'</NEOdc><NEOep>'+lstMeasure[0].NEOep__c+'</NEOep><NEOdp>'+lstMeasure[0].NEOdp__c+'</NEOdp><hNEOa>'+lstMeasure[0].hNEOa__c+'</hNEOa><hNEOs>'+lstMeasure[0].hNEOs__c+'</hNEOs><hNEOec>'+lstMeasure[0].hNEOec__c+'</hNEOec><hNEOdc>'+lstMeasure[0].hNEOdc__c+'</hNEOdc><hNEOep>'+lstMeasure[0].hNEOep__c+'</hNEOep><hNEOdp>'+lstMeasure[0].hNEOdp__c+'</hNEOdp><rNEOa>'+lstMeasure[0].rNEOa__c+'</rNEOa><rNEOdc>'+lstMeasure[0].rNEOdc__c+'</rNEOdc><rNEOdp>'+lstMeasure[0].rNEOdp__c+'</rNEOdp><rNEOec>'+lstMeasure[0].rNEOec__c+'</rNEOec><rNEOep>'+lstMeasure[0].rNEOep__c+'</rNEOep><rNEOs>'+lstMeasure[0].rNEOs__c+'</rNEOs></Measurement><Measurement ID="FR"><FRa>'+lstMeasure[0].FRa__c+'</FRa><FRs>'+lstMeasure[0].FRs__c+'</FRs><FRri>'+lstMeasure[0].FRri__c+'</FRri><FRry>'+lstMeasure[0].FRry__c+'</FRry><FRrt>'+lstMeasure[0].FRrt__c+'</FRrt><FRsi>'+lstMeasure[0].FRsi__c+'</FRsi><FRsy>'+lstMeasure[0].FRsy__c+'</FRsy><FRst>'+lstMeasure[0].FRst__c+'</FRst></Measurement><Measurement ID="SFQ"><DFc>'+lstMeasure[0].DFc__c+'</DFc><Fc>'+lstMeasure[0].Fc__c+'</Fc></Measurement><Measurement ID="SPR"><SPRa>'+lstMeasure[0].SPRa__c+'</SPRa><SPRs>'+lstMeasure[0].SPRs__c+'</SPRs><Sp1>'+lstMeasure[0].Sp1__c+'</Sp1><Sp2>'+lstMeasure[0].Sp2__c+'</Sp2><Sp3>'+lstMeasure[0].Sp3__c+'</Sp3></Measurement></SubmissionData></RequestInfo></TL9000>';
        // Soap message end part
        SoapEndPart = ']]></ns1:CustomerWrapper></soapenv:Body></soapenv:Envelope>';
        
        System.debug('==============lstMeasure[0].Product_Category__c===============: '+lstMeasure[0].Product_Category__c);
       // if(lstMeasure[0].Product_Category__c == '7.5')
        if((lstMeasure[0].Product_Category__c == '7.5') || (lstMeasure[0].Product_Category__c == '7.5.1')|| (lstMeasure[0].Product_Category__c == '7.2.1.2') || (lstMeasure[0].Product_Category__c == '7.2.2') || (lstMeasure[0].Product_Category__c == '7.2.4') || (lstMeasure[0].Product_Category__c == '7.4') || (lstMeasure[0].Product_Category__c == '7.3.2'))
        {
        System.debug('shiva is in 7.5 category looop');
        SoapXMLBody = SoapCommonXml+soap75category+SoapEndPart;
        }else{
        System.debug('shiva is in other than 7.5 category looop');
        SoapXMLBody = SoapCommonXml+SoapNon75Category+SoapEndPart;
        }

        string SoapXML;
        SoapXML = SoapXMLBody;
        Integer ContentLength = 0;
        ContentLength = SoapXML.length();        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setMethod('GET');
        req.setEndPoint('https://portal.questforum.org/questVer2/services/TL9kB2BSubmissionService'); 
        req.setHeader('Content-type','text/xml');
        req.setHeader('Content-Length',ContentLength.format());
        req.setHeader('SoapAction','');
        //String username = 'vijay.gopalabhatla@nsn.com';
        //String password = '31399Q';
        //Below Lines from 98 to 99 are added by Kiran on 22-04-2015
        String username = 'Q12768@nokia.com';
        String password = '30787Q';
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader );
        req.setBody(SoapXML);
        req.setTimeout(60000);
        String myString;
        // Printting request and the request body 
        System.Debug('req: '+req);
        System.Debug('req.getBody'+req.getBody());
        
        if (!isApexTest)
         {
            System.debug('================Avoid Test Flow::::::: This is the block for hitting the webservice===============');
        // hitting the service
        res = h.send(req);
        
        // printing the response 
        System.Debug('RESPONSE====== ' + res);
        // reading the response with xmlStreamReader
        XmlStreamReader reader = res.getXmlStreamReader();

        // printing the reader file
        System.Debug('===============reader======='+reader);
        while(reader.hasNext()) {
            if (reader.getEventType() == XmlTag.END_ELEMENT) {
               break;
            } else if (reader.getEventType() == XmlTag.CHARACTERS) {
                // Setting the value in string myString
                myString = reader.getText();
            }
            reader.next();
         }
        }else{
        System.debug('==========else block to avoid the webservice call out for testing purpose===============');
            myString = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><ns1:CustomerResponse xmlns:ns1="urn:customerResponse"><![CDATA[<?xml version="1.0" encoding="UTF-8"?><TL9000 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><ClientInfo><TransactionId>291120110849578</TransactionId></ClientInfo><RequestInfo><TestMode>True</TestMode><RequestType>SubmitData</RequestType><RegistrationId>TL1310</RegistrationId><ProductCategoryTableName>4.5</ProductCategoryTableName><ProductCategory>7.5</ProductCategory><ProductCategoryName>CustomerSupportServices</ProductCategoryName><DataTemplateType>V</DataTemplateType><SoftwareOption>0</SoftwareOption><YearOfFirstMonthOfData>2011</YearOfFirstMonthOfData><FirstMonthOfData>3</FirstMonthOfData><ProductLocation>ALL</ProductLocation><EncryptionKey>2911201108490057</EncryptionKey><Email><AutoOption>On</AutoOption><ToAddress>CDS022@motorolasolutions.com</ToAddress></Email><SubmissionData><Measurement ID="NPR"><NPRs>1971</NPRs><Np4>1</Np4></Measurement><Measurement ID="FRT"><Fr4c>0</Fr4c><Fr4d>0</Fr4d></Measurement><Measurement ID="OFR"><Of4c>0</Of4c><Of4d>0</Of4d></Measurement><Measurement ID="OTD"><DVa>2653</DVa><DVd>2885</DVd></Measurement><Measurement ID="SSO"><Nso>0</Nso><Ns>2722</Ns></Measurement><Measurement ID="SQ"><SQd>18</SQd><SQt>2722</SQt></Measurement></Measurement></SubmissionData></RequestInfo><ErrorInfo><ResponseId>B2B-2011-12-23147</ResponseId><ErrorCode>ERR-100-NULL-LOGIN</ErrorCode><ErrorMessage>Error for Product Category 7.5 submission. Error is ERR-100-NULL-LOGIN</ErrorMessage></ErrorInfo></TL9000>]]></ns1:CustomerResponse></soapenv:Body></soapenv:Envelope>';
        }
        
      // printing the value of myString 
      System.debug('myString========: '+myString);  
      
      // Finding the response id 
      String responseString = myString.substring(myString.indexOf('ResponseId>', 0)+11, myString.indexOf('</ResponseId>', 0));
      
      String myString2 = '<SubmissionStatus>';
      // Finding whether the request is successful or not
      Boolean successorFailure = false;
      successorFailure = myString.contains(myString2);
      String response = '';
      if(successorFailure){    
          System.debug('===================== Success Status Block ===================');
      String myString3 = '</SubmissionStatus>';
      // Finding and Printing the index of the first occurance of Response Id String
      System.debug('value ==========='+myString.indexOf(myString2, 0));
      // Finding the response Id value
      response =  myString.substring(myString.indexOf(myString2, 0)+18, myString.indexOf(myString3, 0));
      
      }else{
          System.debug('===================== Failure Message Block ===================');
          String myString4 = 'ErrorMessage>';
          String myString5 = '</ErrorMessage>';
          response =  myString.substring(myString.indexOf(myString4, 0)+13, myString.indexOf(myString5, 0));
      }
      
      // Printing the response Id value
      System.debug('response id ======: '+response);
      ResponseID =   response;
      
      // Setting response in the Response from UTD column
      Measurement__c updateMeasuremnt = new Measurement__c(id = lstMeasure[0].Id);
      updateMeasuremnt.Response_from_UTD__c = response;
      // Printing the response id column
      update updateMeasuremnt;
      System.debug('udpated updateMeasuremnt.Response_from_UTD__c column::::: '+updateMeasuremnt.Response_from_UTD__c);
      
      // adding an attachment with response
      if(null != myString){
          System.debug('===================== Adding an attachment loop==============================');
          Attachment attach = new Attachment();
          attach.Body = Blob.valueOf(myString);
          attach.Name = responseString +'_'+ myDateTime;
          attach.ContentType = 'text/xml; charset=utf-8';
          attach.ParentId = lstMeasure[0].Id;
          try {
              insert(attach);
              } catch(System.DMLException e) {
                  System.debug('===========exception while inserting the attachment==========: '+e);
              }
              System.debug('==============Adding an attachment with name === '+attach.Name+' ======for this request is successful==================');
      }
      
        

        // WebService callout end
       return null; 
    }
    
    public pagereference backPage()
    {
        System.debug('shiva is in back button page ================'+lstMeasure[0].Id);
        PageReference pageRef = new PageReference('/'+lstMeasure[0].Id );    
        return pageRef;        
    }    


}