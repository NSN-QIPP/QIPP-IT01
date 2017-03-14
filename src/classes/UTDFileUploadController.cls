public class UTDFileUploadController 
{

    public UTDFileUploadController(ApexPages.StandardController controller) {

    }

        public String upload { get; set; }
        public Blob contentFile { get; set; }
        public String nameFile  { get; set; }
        public Integer rowCount { get; set; }
        public Integer colCount { get; set; }
       
            String tempRecType;
            String Tempcheck;
            String Tempvalue;
            String Pickvalue;
            String PctName;
            String RegistrationId;
            Boolean Flag;
            Integer tempRowSize;
            
            public Boolean importData;
            
            String Temp1 = '\n'+'Product Category 1.1';
            String Temp2 = '\n'+'Product Category 1.2.9.2';
            String Temp3 = '\n'+'Product Category 3.2.2.1.2.1'; 
            String Temp4 = '\n'+'Product Category 3.2.2.1.2.2';
            String Temp5 = '\n'+'Product Category 3.2.2.1.2.3'; 
            String Temp6 = '\n'+'Product Category 3.3.1';
            String Temp7 = '\n'+'Product Category 3.3.2.2';     
            String Temp8 = '\n'+'Product Category 3.3.2.3';
            String Temp9 = '\n'+'Product Category 3.3.4';
            String Temp10 = '\n'+'Product Category 4.2.1';
            String Temp11 = '\n'+'Product Category 7.5';

            String Temp12 = 'Product Category 1.2.9.2';
            String Temp13 = 'Product Category 3.2.2.1.2.1'; 
            String Temp14 = 'Product Category 3.2.2.1.2.2';
            String Temp15 = 'Product Category 3.2.2.1.2.3'; 
            String Temp16 = 'Product Category 3.3.1';
            String Temp17 = 'Product Category 3.3.2.2';     
            String Temp18 = 'Product Category 3.3.2.3';
            String Temp19 = 'Product Category 3.3.4';
            String Temp20 = 'Product Category 4.2.1';
            
            String strMeasurementsName = '';
                       
            String strOwner = UserInfo.getUserId(); 
            
            public List<List<String>> parsedCSV = new List<List<String>>();
          
            public List<RecordType> Secrec = [select Id from RecordType where Name = : 'Product Category 1.2.9.2' limit 1];
            
            public List<RecordType> Thirec = [select Id from RecordType where Name = : 'Product Category 3.2.2.1.2.1' limit 1];
            
            public List<RecordType> Fourec = [select Id from RecordType where Name = : 'Product Category 3.2.2.1.2.2' limit 1];
            
            public List<RecordType> Fivrec = [select Id from RecordType where Name = : 'Product Category 3.2.2.1.2.3' limit 1];
            
            public List<RecordType> Sixrec = [select Id from RecordType where Name = : 'Product Category 3.3.1' limit 1];
            
            public List<RecordType> Sevrec = [select Id from RecordType where Name = : 'Product Category 3.3.2.2' limit 1];
            
            public List<RecordType> Eigrec = [select Id from RecordType where Name = : 'Product Category 3.3.2.3' limit 1];
            
            public List<RecordType> Ninrec = [select Id from RecordType where Name = : 'Product Category 3.3.4' limit 1];
            
            public List<RecordType> Tenrec = [select Id from RecordType where Name = : 'Product Category 4.2.1' limit 1];
            
            public List<RecordType> Elerec = [select Id from RecordType where Name = : 'Product Category 7.5' limit 1];
            
            public List<Measurement__c> recs = new List<Measurement__c>();
          

          public UTDFileUploadController()
            {
               Flag = false;                
            } 
       
            public pagereference Upload() 
            {
            
                rowCount = 0; colCount = 0;
                                  
            if (contentFile != null && nameFile.endsWith('.csv') == True && nameFile != null)
            {                                 
                String fileString = contentFile.toString();
                parsedCSV = parseCSV(fileString, true); 
                rowCount = parsedCSV.size();
                system.debug('rowCount---------'+rowCount);
                if(parsedCSV.Size() >0 && nameFile != null)
                {
                 for (List<String> row : parsedCSV){
                 system.debug('row.size--------'+row.size());
                 tempRowSize = row.size();
                 
                    Measurement__c rec = new  Measurement__c();                   
                    for(string col:row){
                     tempRecType = row[0];
                     System.Debug('aaaaaaaaaaaaaaaaaa ['+tempRecType + ']');
                     System.Debug('bbbbbbbbbbbbbbbbbb ['+temp10 + ']');
                     if(tempRecType == Temp1)
                     {
                        //return null;  
                     }                    
                        else if(tempRecType == Temp2)
                         {
                           String Tmp2 = common_recordtype_Code(Temp12 , rec, row, col);
                           if(Tmp2 != Null)
                           {
                              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Tmp2));
                              return null;                               
                           }                                      
                         }
                       
                        else if(tempRecType == Temp3)
                        {
                           string Tmp3 = common_recordtype_Code(Temp13 , rec, row, col);
                           if(Tmp3 != Null)
                           {
                              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Tmp3));
                              return null;                               
                           }                  
                        } 
                     
                        else if(tempRecType == Temp4)
                        {
                           string Tmp4 = common_recordtype_Code(Temp14 , rec, row, col);
                           if(Tmp4 != Null)
                           {
                              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Tmp4));
                              return null;                               
                           }                     
                        } 
                                          
                       else if(tempRecType == Temp5)
                       {
                           string Tmp5 = common_recordtype_Code(Temp15 , rec, row, col); 
                           if(Tmp5 != Null)
                           {
                              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Tmp5));
                              return null;                               
                           }   
                       } 
                     
                       else if(tempRecType == Temp6)
                       {
                          string Tmp6 = common_recordtype_Code(Temp16 , rec, row, col); 
                          if(Tmp6 != Null)
                           {
                              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Tmp6));
                              return null;                               
                           }   
                       } 
  
                       else if(tempRecType == Temp7)
                       {
                          string Tmp7 = common_recordtype_Code(Temp17 , rec, row, col);
                          if(Tmp7 != Null)
                           {
                              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Tmp7));
                              return null;                               
                           }   
                       }
                                           
                       else if(tempRecType == Temp8)
                       {
                          string Tmp8 = common_recordtype_Code(Temp18 , rec, row, col);
                          if(Tmp8 != Null)
                           {
                              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Tmp8));
                              return null;                               
                           }      
                       } 
                   
                       else if(tempRecType == Temp9)
                       {
                          string Tmp9 = common_recordtype_Code(Temp19 , rec, row, col);
                          if(Tmp9 != Null)
                           {
                              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Tmp9));
                              return null;                               
                           }  
                       } 
                     
                      else if(tempRecType == Temp10)
                      {
                      
                         string Tmp10 = common_recordtype_Code(Temp20 , rec, row, col);
                          if(Tmp10 != Null)
                           {
                              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Tmp10));
                              return null;                               
                           }                       
                     } 
                     
                     else if(tempRecType == Temp11)
                     {
                         String yearOfData;
                         yearOfData = row[1];
                         if((yearOfData != null) && (yearOfData != ''))
                         rec.Year_Of_Data__c = yearOfData;
                         else
                         {
                         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file,Please select the Year of Data.'));
                         return null;
                         }
                         Tempvalue = row[2];
                         if(Tempvalue == '1'|| Tempvalue == '2' || Tempvalue == '3' || Tempvalue == '4' || Tempvalue == '5' || Tempvalue == '6'|| Tempvalue == '7' || Tempvalue == '8' || Tempvalue == '9'|| Tempvalue == '10' || Tempvalue == '11' || Tempvalue == '12')
                         rec.Month_Of_Data__c = Tempvalue;
                         else
                         {
                         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file,Please select the correct Month.'));
                         return null;
                         }
                        
                         If(row[3]!= null & row[3]!= '')rec.NPRs_7_5__c =  Decimal.ValueOf(row[3]);else rec.NPRs_7_5__c = null;
                         If(row[4]!= null & row[4]!= '')
                         rec.Np4_7_5__c =  Decimal.ValueOf(row[4]);
                         else
                         rec.Np4_7_5__c = null; 
                         If(row[5]!= null & row[5]!= '')
                         rec.Fr4c_7_5__c =  Decimal.ValueOf(row[5]);
                         else
                         rec.Fr4c_7_5__c = null; 
                         If(row[6]!= null & row[6]!= '') 
                         rec.Fr4d_7_5__c =  Decimal.ValueOf(row[6]); 
                         else
                         rec.Fr4d_7_5__c = null;
                         If(row[7]!= null & row[7]!= '') 
                         rec.Of4c_7_5__c =  Decimal.ValueOf(row[7]);
                         else
                         rec.Of4c_7_5__c = null;
                         If(row[8]!= null & row[8]!= '')
                         rec.Of4d_7_5__c =  Decimal.ValueOf(row[8]);
                         else
                         rec.Of4d_7_5__c = null;
                         If(row[9]!= null & row[9]!= '')
                         rec.DVa_7_5__c =  Decimal.ValueOf(row[9]);
                         else
                         rec.DVa_7_5__c = null;
                         If(row[10]!= null & row[10]!= '')
                         rec.DVd_7_5__c =  Decimal.ValueOf(row[10]);
                         else
                         rec.DVd_7_5__c = null;
                         If(row[11]!= null & row[11]!= '')  
                         rec.Nso_7_5__c =  Decimal.ValueOf(row[11]);
                         else
                         rec.Nso_7_5__c = null;
                         If(row[12]!= null & row[12]!= '')
                         rec.Ns_7_5__c =  Decimal.ValueOf(row[12]);
                         else
                         rec.Ns_7_5__c = null;
                           
                         If(row[13]!= null & row[13]!= '')  
                         rec.SQd_7_5__c =  Decimal.ValueOf(row[13]);
                         else
                         rec.SQd_7_5__c = null;
                         If(row[14]!= null & row[14]!= '') 
                         rec.SQt_7_5__c =  Decimal.ValueOf(row[14]);
                         else
                         rec.SQt_7_5__c = null;
                         
                           //if (Tempcheck == 'YES' && Tempcheck != '' && Tempcheck != null)
                           
                           /*
                            The Excel file used to upload the UTD data for this template [7.5] has 16 columns.
                            Hence the index of the list should span from [0 to 15]. But if the last column is left blank in the CSV then
                            the list size would be only 15 and trying to retrieve the value at index[15] would result in [System.ListException: List index out of bounds].
                            Hence we use a temp variable to first check the list size (should be 16) and then retrieve the value at index[15].
                            */
                           //if((tempRowSize >= 48) && (row[47] != null && row[47] != '' && row[47] == 'YES')) 
                           if((tempRowSize >= 16) && (row[15] == 'YES'))
                           {
                              rec.submit_yes_no__c = true;
                           }
                           
                           else
                           {
                              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file,Please select "YES" for the column "Are you submitting data for this Product"'));
                              return null;
                           } 
                           rec.UserId__c = strOwner ;
                           rec.UTDSubmit__c = True;
                           // The value of Submit_Data__c will be LIVE for production env and TEST for others
                           //rec.Submit_Data__c = 'TEST';
                           rec.Submit_Data__c = 'LIVE';  
                           rec.RecordTypeId = Elerec[0].Id;
                     
                     }  
                       
                       else
                       {
                           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file,Please select the correct Record Type.'));
                           return null;
                       }
                    }
                    recs.add(rec);                                     
                 }  
                    // logic to detect duplicate file import begins                 
                     String strDuplicateMsg = 'Data for following record already present ';   
                     Integer iDuplicateRecordCount=0;
                     for (Measurement__c tempMsr: recs )
                     {
                        List<Measurement__c> obj = new List<Measurement__c>();
                        obj =  [select ID from Measurement__c 
                        where RecordTypeId  =: tempMsr.RecordTypeId 
                        and Year_Of_Data__c =: tempMsr.Year_Of_Data__c
                        and Month_Of_Data__c =: tempMsr.Month_Of_Data__c];
                        if(obj.size()>0)
                        {
                           // Get the Product Category Name  
                           RecordType tempRocordType = [select Id, Name from RecordType where id = : tempMsr.RecordTypeId limit 1];
                           strDuplicateMsg = strDuplicateMsg + '[ ' + tempRocordType.Name  +' Year: ' + tempMsr.Year_Of_Data__c + ' Month: ' + tempMsr.Month_Of_Data__c + ' ]   ';
                           iDuplicateRecordCount++; 
                        }                         
                                         
                         
                     }
                    // If any duplicate data is found return error message 
                    if(iDuplicateRecordCount >0)
                    {
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file - ' + strDuplicateMsg ));
                        strDuplicateMsg ='';
                        return null;
                    }
                    
                    // logic to detect duplicate file import ends
                  
                     upsert recs;                    
                     contentFile = null;
                     nameFile = null;
                     /*String strMeasurementsImported = '';
                     integer i=0;   
                     //public List<Measurement__c> recs = new List<Measurement__c>();
                     for (Measurement__c tempMsr: recs )
                     {
                         
                         strMeasurementsImported = strMeasurementsImported + '['+ tempMsr.Name + '] ,';  
                         i++;
                     }
                     System.debug('Measurement List ====>'+ strMeasurementsImported );*/
                     
                     PageReference reference=new PageReference('/apex/UTDFileRecordsPage?importData=true');
                     reference.getParameters().put('NumberOfRecordsCreatedByUpload', ''+rowCount);
                     reference.setRedirect(true);
                     
                     return reference;
                     
               }        
                    else   //for Blank csv file and CSV file with column Header(No Data)
                    {
                        System.debug('Error uploading file - incorrect csv file.');
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file - Incorrect csv file.Please select the correct csv file.'));
                        return null;
                    }
             }        
            else //for non csv file (doc,xls,txt)
            {
                System.debug('Error uploading file');
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file - Please select csv file to upload.'));
                return null;
            }
             return null;
             
             }
        
        
       public String common_recordtype_Code(String Temp, Measurement__c rec, List<String> row, string col)
       {
             String yearOfData;
             yearOfData = row[1];
             if((yearOfData != null) && (yearOfData != ''))
             rec.Year_Of_Data__c = yearOfData;
             else
             {
             //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file,Please select the Year of Data.'));
             return 'Error uploading file,Please select the Year of Data.';
             }
             
             Tempvalue = row[2];
             if(Tempvalue == '1'|| Tempvalue == '2' || Tempvalue == '3' || Tempvalue == '4' || Tempvalue == '5' || Tempvalue == '6'|| Tempvalue == '7' || Tempvalue == '8' || Tempvalue == '9'|| Tempvalue == '10' || Tempvalue == '11' || Tempvalue == '12')
             rec.Month_Of_Data__c = Tempvalue;
             else
             {
                 return 'Error uploading file,Please select the correct Month.';
             }
             
             If(row[3]!= null & row[3]!= '')rec.NPRa__c =  Decimal.ValueOf(row[3]);else rec.NPRa__c =  null;
             If(row[4]!= null & row[4]!= '')rec.NPRs__c =  Decimal.ValueOf(row[4]);else rec.NPRs__c = null;
             If(row[5]!= null & row[5]!= '')rec.Np1__c =  Decimal.ValueOf(row[5]);else rec.Np1__c = null;
             If(row[6]!= null & row[6]!= '')rec.Np2__c =  Decimal.ValueOf(row[6]);else rec.Np2__c = null;
             If(row[7]!= null & row[7]!= '')rec.Np3__c =  Decimal.ValueOf(row[7]);else rec.Np3__c =  null; 
                                    
             If(row[8]!= null & row[8]!= '')rec.Fr2c__c =  Decimal.ValueOf(row[8]);else rec.Fr2c__c = null;
             If(row[9]!= null & row[9]!= '')rec.Fr2d__c =  Decimal.ValueOf(row[9]);else rec.Fr2d__c = null;
             If(row[10]!= null & row[10]!= '')rec.Fr3c__c =  Decimal.ValueOf(row[10]);else rec.Fr3c__c = null;
             If(row[11]!= null & row[11]!= '')rec.Fr3d__c =  Decimal.ValueOf(row[11]);else rec.Fr3d__c = null;
             
             If(row[12]!= null & row[12]!= '')rec.Of2c__c =  Decimal.ValueOf(row[12]);else rec.Of2c__c = null;
             If(row[13]!= null & row[13]!= '')rec.Of2d__c =  Decimal.ValueOf(row[13]);else rec.Of2d__c = null;
             If(row[14]!= null & row[14]!= '')rec.Of3c__c =  Decimal.ValueOf(row[14]);else rec.Of3c__c = null;
             If(row[15]!= null & row[15]!= '')rec.Of3d__c =  Decimal.ValueOf(row[15]);else rec.Of3d__c = null;
             
             If(row[16]!= null & row[16]!= '')rec.DIa__c =  Decimal.ValueOf(row[16]);else rec.DIa__c = null;
             If(row[17]!= null & row[17]!= '')rec.DId__c =  Decimal.ValueOf(row[17]);else rec.DId__c = null;
             
             If(row[18]!= null & row[18]!= '')rec.SOa__c =  Decimal.ValueOf(row[18]);else rec.SOa__c = null;
             If(row[19]!= null & row[19]!= '')rec.SOs__c =  Decimal.ValueOf(row[19]);else rec.SOs__c = null;
             If(row[20]!= null & row[20]!= '')rec.SOea__c =  Decimal.ValueOf(row[20]);else rec.SOea__c = null;
             If(row[21]!= null & row[21]!= '')rec.SOda__c =  Decimal.ValueOf(row[21]);else rec.SOda__c = null;
             If(row[22]!= null & row[22]!= '')rec.SOep__c =  Decimal.ValueOf(row[22]);else rec.SOep__c = null;
             If(row[23]!= null & row[23]!= '')rec.SOdp__c =  Decimal.ValueOf(row[23]);else rec.SOdp__c = null;
             
             If(row[24]!= null & row[24]!= '')rec.NEOa__c =  Decimal.ValueOf(row[24]);else rec.NEOa__c = null;
             If(row[25]!= null & row[25]!= '')rec.NEOs__c =  Decimal.ValueOf(row[25]);else rec.NEOs__c = null;
             If(row[26]!= null & row[26]!= '')rec.NEOec__c =  Decimal.ValueOf(row[26]);else rec.NEOec__c = null;
             If(row[27]!= null & row[27]!= '')rec.NEOdc__c =  Decimal.ValueOf(row[27]);else rec.NEOdc__c = null;
             If(row[28]!= null & row[28]!= '')rec.NEOep__c =  Decimal.ValueOf(row[28]);else rec.NEOep__c = null;
             If(row[29]!= null & row[29]!= '')rec.NEOdp__c =  Decimal.ValueOf(row[29]);else rec.NEOdp__c = null;  
                                    
             If(row[30]!= null & row[30]!= '')rec.FRa__c =  Decimal.ValueOf(row[30]);else rec.FRa__c = null;
             If(row[31]!= null & row[31]!= '')rec.FRs__c =  Decimal.ValueOf(row[31]);else rec.FRs__c = null;
             If(row[32]!= null & row[32]!= '')rec.FRri__c =  Decimal.ValueOf(row[32]);else rec.FRri__c = null;
             If(row[33]!= null & row[33]!= '')rec.FRry__c =  Decimal.ValueOf(row[33]);else rec.FRry__c = null;
             If(row[34]!= null & row[34]!= '')rec.FRrt__c =  Decimal.ValueOf(row[34]);else rec.FRrt__c = null;
             If(row[35]!= null & row[35]!= '')rec.FRsi__c =  Decimal.ValueOf(row[35]);else rec.FRsi__c = null;
             If(row[36]!= null & row[36]!= '')rec.FRsy__c =  Decimal.ValueOf(row[36]);else rec.FRsy__c = null;
             If(row[37]!= null & row[37]!= '')rec.FRst__c =  Decimal.ValueOf(row[37]);else rec.FRst__c = null;
                                   
             If(row[38]!= null & row[38]!= '')rec.DFc__c =  Decimal.ValueOf(row[38]);else rec.DFc__c = null;
             If(row[39]!= null & row[39]!= '')rec.Fc__c =  Decimal.ValueOf(row[39]);else rec.Fc__c = null;
             
             If(row[40]!= null & row[40]!= '')rec.SPRa__c =  Decimal.ValueOf(row[40]);else rec.SPRa__c = null;
             If(row[41]!= null & row[41]!= '')rec.SPRs__c =  Decimal.ValueOf(row[41]);else rec.SPRs__c = null;
             If(row[42]!= null & row[42]!= '')rec.Sp1__c =  Decimal.ValueOf(row[42]);else rec.Sp1__c = null;
             If(row[43]!= null & row[43]!= '')rec.Sp2__c =  Decimal.ValueOf(row[43]);else rec.Sp2__c = null;
             If(row[44]!= null & row[44]!= '')rec.Sp3__c =  Decimal.ValueOf(row[44]);else rec.Sp3__c = null;                         
            
             /*
            The Excel file used to upload the UTD data for this template has 46 columns.
            Hence the index of the list should span from [0 to 45]. But if the last column is left blank in the CSV then
            the list size would be only 45 and trying to retrieve the value at index[45] would result in [System.ListException: List index out of bounds].
            Hence we use a temp variable to first check the list size (should be 46) and then retrieve the value at index[46].
            */
 
             if((tempRowSize >= 46) && (row[45] != null && row[45] != '' && row[45] == 'YES'))
             {
             System.debug('Tempcheck YES-----'+Tempcheck);
             rec.submit_yes_no__c = true;
             }
             else
             {
                  return 'Error uploading file,Please select "YES" for the column "Are you submitting data for this Product"';
             }
                 
               rec.UserId__c = strOwner ;
               rec.UTDSubmit__c = True;
               // The value of Submit_Data__c will be LIVE for production env and TEST for others 
               // rec.Submit_Data__c = 'TEST';
               rec.Submit_Data__c = 'LIVE';
                
                if(Temp == 'Product Category 1.2.9.2')                           
                rec.RecordTypeId = Secrec[0].Id;
                
                if(Temp == 'Product Category 3.2.2.1.2.1')                           
                rec.RecordTypeId = Thirec[0].Id;
                
                if(Temp == 'Product Category 3.2.2.1.2.2')                           
                rec.RecordTypeId = Fourec[0].Id;
                
                if(Temp == 'Product Category 3.2.2.1.2.3')                           
                rec.RecordTypeId = Fivrec[0].Id;
                
                if(Temp == 'Product Category 3.3.1')                           
                rec.RecordTypeId = Sixrec[0].Id;
                
                if(Temp == 'Product Category 3.3.2.2')                           
                rec.RecordTypeId = Sevrec[0].Id;
                
                if(Temp == 'Product Category 3.3.2.3')                           
                rec.RecordTypeId = Eigrec[0].Id;
                
                if(Temp == 'Product Category 3.3.4')                           
                rec.RecordTypeId = Ninrec[0].Id; 
                
                if(Temp == 'Product Category 4.2.1')                           
                rec.RecordTypeId = Tenrec[0].Id;                            
                
                return null;     
       }
     
             
        public static List<List<String>> parseCSV(String contents,Boolean skipHeaders) 
        {
            List<List<String>> allFields = new List<List<String>>();
            contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
            System.debug('contents:-------------'+contents);
            contents = contents.replaceAll('""','DBLQT');
            System.debug('contents:---------'+contents);
            List<String> lines = new List<String>();
            try 
            {
              
                lines = contents.split('\r'); // using carriage return accomodates windows, unix, and mac files
             
            } 
             catch (System.ListException e) 
             {
                System.debug('Limits exceeded?----------' + e.getMessage());
             }
            Integer num = 0;
            System.debug('No of Lines---------' +lines); 
            for(String line: lines)
            {
                 System.debug('Line---------' +line);
                // check for blank CSV lines (only commas)
                if (line.replaceAll(',','').trim().length() == 0) break;
              
                List<String> fields = line.split(',');
                List<String> cleanFields = new List<String>();
                String compositeField;
                Boolean makeCompositeField = false;
                for(String field: fields) 
                {
                    if (field.startsWith('"') && field.endsWith('"')) 
                    {
                        cleanFields.add(field.replaceAll('DBLQT','"'));
                    } 
                     else if (field.startsWith('"')) 
                     {
                        makeCompositeField = true;
                        compositeField = field;
                     } 
                     else if (field.endsWith('"')) 
                     {
                        compositeField += ',' + field;
                        cleanFields.add(compositeField.replaceAll('DBLQT','"'));
                        makeCompositeField = false;
                    }
                     else if (makeCompositeField) 
                     {
                        compositeField +=  ',' + field;
                     } 
                     else 
                     {
                        cleanFields.add(field.replaceAll('DBLQT','"'));
                    }
                }
              
                allFields.add(cleanFields);
            }
            System.debug('allFields-------------:'+allFields);
            if (skipHeaders)
            {
                if((allFields != null) && (allFields.Size() > 0))
                    allFields.remove(0);
            }
            System.debug('allFields:-----------'+allFields);
            return allFields;
                
        }    
        
    }