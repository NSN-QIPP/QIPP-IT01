public class UTDSupportController
{
  List<CategoryWrapper> categories {get;set;}
  public Boolean checked{ get; set; }
  
  public Boolean tempRefresh{ get; set; }
 
  public String recid;
  
  public List<Measurement__c> lstMeasure = new List<Measurement__c>();
  
  String strOwner = UserInfo.getUserId();
 
  String strProf = UserInfo.getProfileId();
  
  Map<String, String> listResponse = new Map<String, String>();
  Map<String, Attachment> listAttachment = new Map<String, Attachment>();
  
  public List<Measurement__c> measurementName = new List<Measurement__c>();
         
  String strProfName = [select Id, Name from Profile where Id =: strProf limit 1].Name;
         
  //  public string ResponseID{get; set;}
    // Static variable that assumes a test is not running
    public static boolean isApexTest = false;
   
      public pagereference initialisePage() 
        {
        String tmpcheck = ApexPages.currentPage().getParameters().get('importData');
           
        if(tmpcheck == 'true')
        {
             
          System.Debug('--------------categories-----------['+categories+']'); 
          String counter= ApexPages.currentPage().getParameters().get('NumberOfRecordsCreatedByUpload');         
          System.Debug('-------tmpcheck----------['+tmpcheck+']'+'----- NumberOfRecordsCreatedByUpload = -------['+counter+']');
         
          Integer countCheck = Integer.valueOf(counter);
          System.Debug('--------countCheck---------['+countCheck+']'); 
        
          measurementName = [select Name from Measurement__c where UserId__c = : strOwner order By Name DESC Limit : countCheck]; 
           //System.Debug('--------------measurementName -----------['+measurementName+']');
           String strName = '';
           for(Integer i=0; i < measurementName.size(); i++)
           {
           strName = strName + ' '+ measurementName[i].Name;           
           }
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'Measurements Name:' + strName +  ' were imported successfully.' ));  
        }                    
         
         else if(tmpcheck == 'false')
         { 
          String strParamMeasurementsNameSubmittedToUTD = ApexPages.currentPage().getParameters().get('MeasurementsNameSubmittedToUTD');
          System.Debug('- inside initialisePage() : strParamMeasurementsNameSubmittedToUTD ['+strParamMeasurementsNameSubmittedToUTD +']');       
//         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Successfully submitted Measurements data to UTD.'+recid));                      
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Successfully submitted Measurements data to UTD.'+strParamMeasurementsNameSubmittedToUTD));                      
         //return null; 
         }
          return null;
        }
   
   
 public UTDSupportController(String value){
    
        if(null != value){
           isApexTest = true;
       }
    }
    
  public ApexPages.StandardSetController con 
  {
   
        get {
            if(con == null) 
             {
              //if(!strProfName.contains('Admin'))
              {
                   con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Name,Registration_ID__c,Product_Category_Table_Name__c,Product_Category__c, Product_Category_Name__c, Data_Template_Type__c, 
                   Year_Of_Data__c,Month_Of_Data__c,Product_Location__c, Software_Option__c,NPRa__c,NPRs__c,Np1__c,Np2__c,Np3__c,
                   Np4_7_5__c,Nso_7_5__c,Ns_7_5__c,NEOa__c,NEOs__c,NEOec__c,NEOdc__c,NEOep__c,NEOdp__c,hNEOa__c,hNEOs__c,hNEOec__c,hNEOdc__c,
                   hNEOep__c,hNEOdp__c,hSOa__c,hSOs__c,hSOea__c,hSOda__c,hSOep__c,hSOdp__c,rNEOa__c,rNEOs__c,rNEOec__c,rNEOdc__c,
                   rNEOep__c,rNEOdp__c,rSOa__c,rSOs__c,rSOea__c,rSOda__c,rSOep__c,rSOdp__c,Fr2c__c,Fr2d__c,Fr3c__c,Fr3d__c,Fr4c_7_5__c,
                   Fr4d_7_5__c,Fra__c,Frs__c,FRri__c,FRry__c,FRrt__c,Frsi__c,Frsy__c,FRst__c,Fc__c,DIa__c,  DId__c,DVa_7_5__c,DVd_7_5__c,
                   Dfc__c,SPRa__c,SPRs__c,Sp1__c,Sp2__c,Sp3__c,Soa__c,Sos__c,Soea__c,Soda__c,Soep__c,Sodp__c,SQd_7_5__c,SQt_7_5__c,
                   Of2c__c,Of2d__c,Of3c__c,Of3d__c,Of4c_7_5__c,Of4d_7_5__c,submit_yes_no__c, UserId__c,CreatedDate from Measurement__c where UserId__c =: strOwner and UTDSubmit__c =: True Order By Name DESC]));
                
             }
             /*
             else
             {
                   con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Name,Registration_ID__c,Product_Category_Table_Name__c,Product_Category__c, Product_Category_Name__c, Data_Template_Type__c, 
                   Year_Of_Data__c,Month_Of_Data__c,Product_Location__c, Software_Option__c,NPRa__c,NPRs__c,Np1__c,Np2__c,Np3__c,
                   Np4_7_5__c,Nso_7_5__c,Ns_7_5__c,NEOa__c,NEOs__c,NEOec__c,NEOdc__c,NEOep__c,NEOdp__c,hNEOa__c,hNEOs__c,hNEOec__c,hNEOdc__c,
                   hNEOep__c,hNEOdp__c,hSOa__c,hSOs__c,hSOea__c,hSOda__c,hSOep__c,hSOdp__c,rNEOa__c,rNEOs__c,rNEOec__c,rNEOdc__c,
                   rNEOep__c,rNEOdp__c,rSOa__c,rSOs__c,rSOea__c,rSOda__c,rSOep__c,rSOdp__c,Fr2c__c,Fr2d__c,Fr3c__c,Fr3d__c,Fr4c_7_5__c,
                   Fr4d_7_5__c,Fra__c,Frs__c,FRri__c,FRry__c,FRrt__c,Frsi__c,Frsy__c,FRst__c,Fc__c,DIa__c,  DId__c,DVa_7_5__c,DVd_7_5__c,
                   Dfc__c,SPRa__c,SPRs__c,Sp1__c,Sp2__c,Sp3__c,Soa__c,Sos__c,Soea__c,Soda__c,Soep__c,Sodp__c,SQd_7_5__c,SQt_7_5__c,
                   Of2c__c,Of2d__c,Of3c__c,Of3d__c,Of4c_7_5__c,Of4d_7_5__c,submit_yes_no__c,CreatedDate from Measurement__c where UTDSubmit__c =: True Order By Name limit 100]));
                
             }
             */
            }
            con.setPageSize(10); 
            return con;
            }
        set;
  }

     
    public UTDSupportController(ApexPages.StandardController controller) 
    {

    }

        public boolean displaySubmit{get; set;}
        public boolean  submitutd  {get; set;}     
      
        
        public pagereference submit() 
        {
         System.Debug('------StartSubmit----------');           
          
          List<Measurement__c> lstMeasureFalse = new List<Measurement__c>();
          System.Debug('----------------categories----------['+categories+']');
          Boolean flagAtleastOneRecordSelected = false;
          Integer numberOfMeasurementsChecked=0;
          String strMeasurementsNameSubmittedToUTD = '';
             
          if(categories != null )
          {
         
           System.Debug('------- categories['+categories+']');          
                Datetime tmpDateTime = datetime.now();
                Integer currentYear = tmpDateTime.year();
                Integer currentMonth = tmpDateTime.month();
                //Check if more than 10 records have been selected for Submission to UTD
                 for (CategoryWrapper cw : categories) 
                  {
                  System.Debug('-------- cw.checked['+cw.checked+']');
                        
                        if (cw.checked)
                        {
                              try{
                              // Check if data submitted is of current or future months  
                                if(integer.ValueOf(cw.mest.Year_Of_Data__c) > currentYear || (integer.ValueOf(cw.mest.Year_Of_Data__c) ==currentYear && integer.ValueOf(cw.mest.Month_Of_Data__c) >= currentMonth   )) 
                                {
                                    // if yes then show error message
                                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'You cannot report for current calendar month or for months after current month'));                     
                                    return null;
                                
                                }
                              }  
                              catch (Exception e)
                              {
                                    // Catch exception if the year or month data is not numeric  
                                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Invalid Year or Month for submitted records'));                     
                                    return null;

                              }  
                                flagAtleastOneRecordSelected = true; //set the Flag to true as - Atleast 1 record is selected
                                numberOfMeasurementsChecked = numberOfMeasurementsChecked+1;
                        }                               
                  }// for loop ends for checking more than 10 recs selection
            
            System.Debug('---------- numberOfMeasurementsChecked['+numberOfMeasurementsChecked+']'); 
            
                if(numberOfMeasurementsChecked > 10)
                  {
                        //Return back and Display an error message [Select atleast 1 and max 10 records to submit to UTD]
                         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select atleast 1 and max 10 records to submit to UTD.'));                     
                        return null;

                  }
          
           for (CategoryWrapper cw : categories) 
          {
              
                if (cw.checked)
                {
                      
                recid = cw.mest.Id;                    
                if(recid != null)
                {
               
                System.debug('RecordId-Start-------:'+recid);
                System.debug('CheckedName---------:'+cw.mest.Product_Category_Table_Name__c);
               
                lstMeasure = [select Name,User_Name__c, Registration_ID__c,Product_Category_Table_Name__c,Product_Category__c,
                Product_Category_Name__c,Data_Template_Type__c,Software_Option__c,Year_Of_Data__c,Month_Of_Data__c,
                Product_Location__c,NPRs_7_5__c,Np4_7_5__c,Fr4c_7_5__c, Fr4d_7_5__c,Of4c_7_5__c,Of4d_7_5__c,
                DVa_7_5__c,DVd_7_5__c,Nso_7_5__c,Ns_7_5__c,SQd_7_5__c,SQt_7_5__c,
                NPRa__c,NPRs__c,Np1__c,Np2__c,Np3__c,Fr2c__c,Fr2d__c,Fr3c__c,Fr3d__c,Of2c__c,Of2d__c,Of3c__c,Of3d__c,
                DIa__c,DId__c,SOa__c,SOs__c,SOea__c,SOda__c,SOep__c,SOdp__c,
                NEOa__c,NEOs__c,NEOec__c,NEOdc__c,NEOep__c,NEOdp__c,
                FRa__c,FRs__c,FRri__c,FRry__c,FRrt__c,FRsi__c,FRsy__c,FRst__c,
                DFc__c,Fc__c,SPRa__c,SPRs__c,Sp1__c,Sp2__c,Sp3__c,
                Submit_Data__c,Response_from_UTD__c,submit_yes_no__c,CreatedDate from Measurement__c where Id =: recid and UTDSubmit__c =: True];
                
                System.debug('-------------------lstMeasure===='+lstMeasure);
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
                //SoapXMLBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tran="http://Transport.B2B"><soapenv:Header><userName>vijay.gopalabhatla@nokia.com</userName><password>31399Q</password></soapenv:Header><soapenv:Body><ns1:CustomerWrapper xmlns:ns1="urn:customer"><![CDATA[<?xml version="1.0" encoding="UTF-8"?><TL9000 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><ClientInfo><TransactionId>291120110849578</TransactionId></ClientInfo><RequestInfo><TestMode>True</TestMode><RequestType>SubmitData</RequestType><RegistrationId>TL1310</RegistrationId><ProductCategoryTableName>4.5</ProductCategoryTableName><ProductCategory>7.5</ProductCategory><ProductCategoryName>CustomerSupportServices</ProductCategoryName><DataTemplateType>V</DataTemplateType><SoftwareOption>0</SoftwareOption><YearOfFirstMonthOfData>2011</YearOfFirstMonthOfData><FirstMonthOfData>3</FirstMonthOfData><ProductLocation>ALL</ProductLocation><EncryptionKey>2911201108490057</EncryptionKey><Email><AutoOption>On</AutoOption><ToAddress>CDS022@motorolasolutions.com</ToAddress></Email><SubmissionData><Measurement ID="NPR"><NPRs>1971</NPRs><Np4>1</Np4></Measurement><Measurement ID="FRT"><Fr4c>0</Fr4c><Fr4d>0</Fr4d></Measurement><Measurement ID="OFR"><Of4c>0</Of4c><Of4d>0</Of4d></Measurement><Measurement ID="OTD"><DVa>2653</DVa><DVd>2885</DVd></Measurement><Measurement ID="SSO"><Nso>0</Nso><Ns>2722</Ns></Measurement><Measurement ID="SQ"><SQd>18</SQd><SQt>2722</SQt></Measurement></SubmissionData></RequestInfo></TL9000>]]></ns1:CustomerWrapper></soapenv:Body></soapenv:Envelope>';
                
                // Common soap envolope
                //if(SoapCommonXml != null)
                SoapCommonXml = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tran="http://Transport.B2B"><soapenv:Body><ns1:CustomerWrapper xmlns:ns1="urn:customer"><![CDATA[<?xml version="1.0" encoding="UTF-8"?><TL9000 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><ClientInfo><TransactionId>'+transactionIDFormat+'</TransactionId></ClientInfo><RequestInfo><TestMode>'+testorlive+'</TestMode><RequestType>SubmitData</RequestType><RegistrationId>'+lstMeasure[0].Registration_ID__c+'</RegistrationId><ProductCategoryTableName>'+lstMeasure[0].Product_Category_Table_Name__c+'</ProductCategoryTableName><ProductCategory>'+lstMeasure[0].Product_Category__c+'</ProductCategory><ProductCategoryName>'+lstMeasure[0].Product_Category_Name__c+'</ProductCategoryName><DataTemplateType>'+lstMeasure[0].Data_Template_Type__c+'</DataTemplateType><SoftwareOption>'+lstMeasure[0].Software_Option__c+'</SoftwareOption><YearOfFirstMonthOfData>'+lstMeasure[0].Year_Of_Data__c+'</YearOfFirstMonthOfData><FirstMonthOfData>'+lstMeasure[0].Month_Of_Data__c+'</FirstMonthOfData><ProductLocation>'+lstMeasure[0].Product_Location__c+'</ProductLocation><EncryptionKey>'+encryptionIDFormat+'</EncryptionKey><Email><AutoOption>On</AutoOption><ToAddress>'+lstMeasure[0].User_Name__c+'</ToAddress></Email>';
                // Product Category 7.5 Soap message that needs to be added in between SoapCommonXml and SoapEndPart
                soap75category = '<SubmissionData><Measurement ID="NPR"><NPRs>'+lstMeasure[0].NPRs_7_5__c+'</NPRs><Np4>'+lstMeasure[0].Np4_7_5__c+'</Np4></Measurement><Measurement ID="FRT"><Fr4c>'+lstMeasure[0].Fr4c_7_5__c+'</Fr4c><Fr4d>'+lstMeasure[0].Fr4d_7_5__c+'</Fr4d></Measurement><Measurement ID="OFR"><Of4c>'+lstMeasure[0].Of4c_7_5__c+'</Of4c><Of4d>'+lstMeasure[0].Of4d_7_5__c+'</Of4d></Measurement><Measurement ID="OTD"><DVa>'+lstMeasure[0].DVa_7_5__c+'</DVa><DVd>'+lstMeasure[0].DVd_7_5__c+'</DVd></Measurement><Measurement ID="SSO"><Nso>'+lstMeasure[0].Nso_7_5__c+'</Nso><Ns>'+lstMeasure[0].Ns_7_5__c+'</Ns></Measurement><Measurement ID="SQ"><SQd>'+lstMeasure[0].SQd_7_5__c+'</SQd><SQt>'+lstMeasure[0].SQt_7_5__c+'</SQt></Measurement></SubmissionData></RequestInfo></TL9000>';
                // Non Product Category 7.5 Soap message that needs to be added in between SoapCommonXml and SoapEndPart
                SoapNon75Category = '<SubmissionData><Measurement ID="NPR"><NPRa>'+lstMeasure[0].NPRa__c+'</NPRa><NPRs>'+lstMeasure[0].NPRs__c+'</NPRs><Np1>'+lstMeasure[0].Np1__c+'</Np1><Np2>'+lstMeasure[0].Np2__c+'</Np2><Np3>'+lstMeasure[0].Np3__c+'</Np3></Measurement><Measurement ID="FRT"><Fr2c>'+lstMeasure[0].Fr2c__c+'</Fr2c><Fr2d>'+lstMeasure[0].Fr2d__c+'</Fr2d><Fr3c>'+lstMeasure[0].Fr3c__c+'</Fr3c><Fr3d>'+lstMeasure[0].Fr3d__c+'</Fr3d></Measurement><Measurement ID="OFR"><Of2c>'+lstMeasure[0].Of2c__c+'</Of2c><Of2d>'+lstMeasure[0].Of2d__c+'</Of2d><Of3c>'+lstMeasure[0].Of3c__c+'</Of3c><Of3d>'+lstMeasure[0].Of3d__c+'</Of3d></Measurement><Measurement ID="OTD"><DIa>'+lstMeasure[0].DIa__c+'</DIa><DId>'+lstMeasure[0].DId__c+'</DId></Measurement><Measurement ID="SO"><SOa>'+lstMeasure[0].SOa__c+'</SOa><SOs>'+lstMeasure[0].SOs__c+'</SOs><SOea>'+lstMeasure[0].SOea__c+'</SOea><SOda>'+lstMeasure[0].SOda__c+'</SOda><SOep>'+lstMeasure[0].SOep__c+'</SOep><SOdp>'+lstMeasure[0].SOdp__c+'</SOdp></Measurement><Measurement ID="SONE"><NEOa>'+lstMeasure[0].NEOa__c+'</NEOa><NEOs>'+lstMeasure[0].NEOs__c+'</NEOs><NEOec>'+lstMeasure[0].NEOec__c+'</NEOec><NEOdc>'+lstMeasure[0].NEOdc__c+'</NEOdc><NEOep>'+lstMeasure[0].NEOep__c+'</NEOep><NEOdp>'+lstMeasure[0].NEOdp__c+'</NEOdp></Measurement><Measurement ID="FR"><FRa>'+lstMeasure[0].FRa__c+'</FRa><FRs>'+lstMeasure[0].FRs__c+'</FRs><FRri>'+lstMeasure[0].FRri__c+'</FRri><FRry>'+lstMeasure[0].FRry__c+'</FRry><FRrt>'+lstMeasure[0].FRrt__c+'</FRrt><FRsi>'+lstMeasure[0].FRsi__c+'</FRsi><FRsy>'+lstMeasure[0].FRsy__c+'</FRsy><FRst>'+lstMeasure[0].FRst__c+'</FRst></Measurement><Measurement ID="SFQ"><DFc>'+lstMeasure[0].DFc__c+'</DFc><Fc>'+lstMeasure[0].Fc__c+'</Fc></Measurement><Measurement ID="SPR"><SPRa>'+lstMeasure[0].SPRa__c+'</SPRa><SPRs>'+lstMeasure[0].SPRs__c+'</SPRs><Sp1>'+lstMeasure[0].Sp1__c+'</Sp1><Sp2>'+lstMeasure[0].Sp2__c+'</Sp2><Sp3>'+lstMeasure[0].Sp3__c+'</Sp3></Measurement></SubmissionData></RequestInfo></TL9000>';
                // Soap message end part
                SoapEndPart = ']]></ns1:CustomerWrapper></soapenv:Body></soapenv:Envelope>';
                
                System.debug('==============lstMeasure[0].Product_Category__c===============: '+lstMeasure[0].Product_Category__c);
                if(lstMeasure[0].Product_Category__c == '7.5'){
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
                String username = 'vijay.gopalabhatla@nokia.com';
                String password = '31399Q';
                Blob headerValue = Blob.valueOf(username + ':' + password);
                String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
                req.setHeader('Authorization', authorizationHeader );
                req.setBody(SoapXML);
                
                String myString;
                // Printting request and the request body 
                System.Debug('req: '+req);
                System.Debug('req.getBody'+req.getBody());
                
                if (!isApexTest){
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
                myString = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><ns1:CustomerResponse xmlns:ns1="urn:customerResponse"><![CDATA[<?xml version="1.0" encoding="UTF-8"?><TL9000 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><ClientInfo><TransactionId>291120110849578</TransactionId></ClientInfo><RequestInfo><TestMode>True</TestMode><RequestType>SubmitData</RequestType><RegistrationId>TL1310</RegistrationId><ProductCategoryTableName>4.5</ProductCategoryTableName><ProductCategory>7.5</ProductCategory><ProductCategoryName>CustomerSupportServices</ProductCategoryName><DataTemplateType>V</DataTemplateType><SoftwareOption>0</SoftwareOption><YearOfFirstMonthOfData>2011</YearOfFirstMonthOfData><FirstMonthOfData>3</FirstMonthOfData><ProductLocation>ALL</ProductLocation><EncryptionKey>2911201108490057</EncryptionKey><Email><AutoOption>On</AutoOption><ToAddress>CDS022@motorolasolutions.com</ToAddress></Email><SubmissionData><Measurement ID="NPR"><NPRs>1971</NPRs><Np4>1</Np4></Measurement><Measurement ID="FRT"><Fr4c>0</Fr4c><Fr4d>0</Fr4d></Measurement><Measurement ID="OFR"><Of4c>0</Of4c><Of4d>0</Of4d></Measurement><Measurement ID="OTD"><DVa>2653</DVa><DVd>2885</DVd></Measurement><Measurement ID="SSO"><Nso>0</Nso><Ns>2722</Ns></Measurement><Measurement ID="SQ"><SQd>18</SQd><SQt>2722</SQt></Measurement></SubmissionData></RequestInfo><ErrorInfo><ResponseId>B2B-2011-12-23147</ResponseId><ErrorCode>ERR-100-NULL-LOGIN</ErrorCode><ErrorMessage>Error for Product Category 7.5 submission. Error is ERR-100-NULL-LOGIN</ErrorMessage></ErrorInfo></TL9000>]]></ns1:CustomerResponse></soapenv:Body></soapenv:Envelope>';
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
              //System.debug('response id ======: '+response);
              //              ResponseID =   response;
              
              // Setting response in the Response from UTD column
               listResponse.put(recid,response);    
                            
              // adding an attachment with response
              if(null != myString)
              {
                  System.debug('===================== Adding an attachment loop==============================');
                  Attachment attach = new Attachment();
                  attach.Body = Blob.valueOf(myString);
                  attach.Name = responseString +'_'+ myDateTime;
                  attach.ContentType = 'text/xml; charset=utf-8';
                  attach.ParentId = lstMeasure[0].Id;
                  //Putting attachment in a map after for loop to insert it.
                  listAttachment.put(recid,attach);   
                 
             }
                System.debug('RecordId-End-------:'+recid);
               
              }
                //- Add the MeasurementsName that would be sent htrough PageReference object
                strMeasurementsNameSubmittedToUTD   = strMeasurementsNameSubmittedToUTD + '['+ lstMeasure[0].Name + '] ,';     
         }
         
      } // for loop end
        
        System.debug('======= flagAtleastOneRecordSelected--------:'+flagAtleastOneRecordSelected);
        if (!flagAtleastOneRecordSelected)
        {
          System.debug('====== No Record selected--------:');
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'Please select at least 1 Measurement Record to submit to UTD.'));         
          return null;
        }
        else
        {      
        List<Measurement__c> updateMeasurement = new List<Measurement__c>();
        
   
        for (String keyRecordId : listResponse.keySet())
        {
            //Retrive corresponding responce for Record Id from the listResponse map.
            String strResponse = listResponse.get(keyRecordId);
            Measurement__c recordMeasurement = new Measurement__c(Id = keyRecordId);
         
            recordMeasurement.UTDSubmit__c = false;
            recordMeasurement.Response_from_UTD__c = strResponse;                
            updateMeasurement.add(recordMeasurement); 
            //Retrive corresponding attachment for Record Id from the attachment map.
            Attachment attachment =  listAttachment.get(keyRecordId);
             try 
             {
                insert(attachment);
                      
              } 
              catch(System.DMLException e) 
              {
                  System.debug(LoggingLevel.ERROR,'===========exception while inserting the attachment==========:KeyRecordId =  ['+keyRecordId+']'+'Exception = ' +e);                  
              }
                      System.debug('==============Adding an attachment with name === '+attachment.Name+' ======for this request is successful==================');
        }
                   
         if(updateMeasurement !=null )
         update updateMeasurement;  
         
        PageReference pageRef = new PageReference('/apex/UTDFileRecordsPage?importData=false');
        pageRef.setRedirect(true);
        System.debug('=============== importData=false------------:strMeasurementsNameSubmittedToUTD='+strMeasurementsNameSubmittedToUTD);
        
        //- Add strMeasurementsNameSubmittedToUTD  to PageReference and retrieve it on page initialise
        pageRef.getParameters().put('MeasurementsNameSubmittedToUTD', strMeasurementsNameSubmittedToUTD);
         return pageRef;
       } //else - flagAtleastOneRecordSelected is true
     }    
         else
         {
         System.debug('====== No Record selected = null---1234-----:');
         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'1234 -Please select at least 1 Measurement Record to submit to UTD.'));         
         return null;
         }        
        }
        
     public List<CategoryWrapper> getCategories()
     {
         categories = new List<CategoryWrapper>();
         if(con != null)     
         {
         Integer tempSrNoCount = 0;
             for (Measurement__c category : (List<Measurement__c>)con.getRecords())
            {
                 if(category != null)
                 {
                     tempSrNoCount  = tempSrNoCount + 1;
                     CategoryWrapper tempCategoryWrapper = new CategoryWrapper(category);
                     tempCategoryWrapper.setSrNo(tempSrNoCount);
                     categories.add(tempCategoryWrapper);
                  }
            }
         }
       
         return categories;
     }
    
        public class CategoryWrapper 
        {
         
            public Boolean checked{ get; set; }
            public Measurement__c mest {get; set;}
            public Integer srNo ;
            
            public Integer getSrNo()
            {
                return srNo;
            }
            

            public Integer setSrNo(Integer pSrNo)
            {
                srNo = pSrNo;
                return srNo;
            }
            
            
            public CategoryWrapper()
            {
                mest = new Measurement__c();
                checked = false;
            /*    if(srNo == null) srNo = 1;
                else  srNo = srNo+1;
                */
            }
         
            public CategoryWrapper(Measurement__c m)
            {
                mest = m;
                checked = false;
                /* if(srNo == null)srNo = 1;
                else  srNo = srNo+1;
                */
            }
        }
 
 
 
    // indicates whether there are more records after the current page set.
    public Boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }
 
    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            return con.getHasPrevious();
        }
        set;
    }
 
    // returns the page number of the current page set
    public Integer pageNumber {
        get {
            return con.getPageNumber();
        }
        set;
    }
 
    // returns the first page of records
    public void first() {
        con.first();
    }
 
    // returns the last page of records
    public void last() {
        con.last();
    }
 
    // returns the previous page of records
    public void previous() {
        con.previous();
    }
 
    // returns the next page of records
    public void next() {
        con.next();
    }
 
    // returns the PageReference of the original page, if known, or the home page.
    public void cancel() {
        con.cancel();
    } 
 
 
 
   //@isTest     
    public static testmethod void testUTDSupport() 
    {
     Measurement__c  temp = new Measurement__c();
     temp.Product_Category_Name__c ='4.6';
     temp.Year_Of_Data__c ='2001';
     temp.Month_Of_Data__c ='1';     
     temp.Submit_Data__c='TEST';
     temp.UTDSubmit__c =true;
     temp.submit_yes_no__c=true;
     insert temp;
     
     
     UTDSupportController supportController = new UTDSupportController('test');
     //supportController.UTDSupportController('test');
     CategoryWrapper obj = new CategoryWrapper();
     obj.mest =temp;
     obj.checked =true;
     List<CategoryWrapper> lstobj = new List<CategoryWrapper>();
     lstobj.add(obj);
     supportController.checked = true;
     supportController.categories = lstobj;
     supportController.getCategories();
     supportController.categories[0].checked = true;
     supportController.submit();
     /*CategoryWrapper obj1 = new CategoryWrapper();
     obj.mest =temp;
     obj.checked =true;
     supportController.submit();*/
     //Measurement__c temp1 = new Measurement__c();
     //obj1.mest =temp1;
     //obj1.checked =true;     

    }
     
 }