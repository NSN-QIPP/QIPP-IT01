trigger QIRS_ProductName_Update on QIRS_Product_Identification__c (before insert,before update,before delete) 
{
 //The below lines 4 to 8 added by Thiresh on 27/10/12
  if(Trigger.isUpdate || Trigger.isInsert)
  {
  for(QIRS_Product_Identification__c a : Trigger.new)
      a.Name =  a.Name__c;
  }   
    if (Trigger.isDelete) 
    {
        List<QIRS__c> qirsBulkupdate = new List<QIRS__c>();    
       for (QIRS_Product_Identification__c product : Trigger.old)
        {
         if(!product.ClassAccess__c)
            {
                List<QIRS_Product_Identification__c> qirsprod =
                 new List<QIRS_Product_Identification__c>();
                List<QIRS__c> qirs = new List<QIRS__c>();
                qirsprod =  [select ID, Name, Product_Name__c,Release_Product__c from 
                QIRS_Product_Identification__c
                        where QIRS__c =: product.QIRS__c  and ID !=: product.ID order by Name desc];
                qirs = [select ID, IsDefaultReleased__c,Product_PN__c,Name,Status__c,View_Release_Product__c,View_Product_Name__c from QIRS__c where id =: product.QIRS__c];
                 if(qirs.size() > 0)                 
                 {
                   if(qirs[0].Status__c != 'Closed' && qirs[0].Status__c != 'Submited to Master Approval')
                      {
                         string strProduct = '';
                         string updateReleaseProduct = '';
                         string updateUnReleaseProduct = '';   
                         for(Integer i = 0; i < qirsprod.size(); i++)
                             {
                              if(qirsprod[i].Product_Name__c != product.Product_Name__c)
                                {
                                         if(i == 0)
                                         {
                                             strProduct = String.Valueof(qirsprod[i].Product_Name__c);                         
                                             //strProductPN = String.Valueof(qirsprod[i].Name);                         
                                         }
                                         else
                                         {
                                             strProduct = strProduct + '; ' +String.Valueof(qirsprod[i].Product_Name__c);
                                            // strProductPN = strProductPN + '; ' +String.Valueof(qirsprod[i].Name);                                 
                                         }
                                 }
                             }
             
               for(Integer i = 0; i < qirsprod.size(); i++)
               {
                    if(qirsprod[i].Name != product.Name)
                    {
                         if(qirsprod[i].Release_Product__c == true || qirs[0].IsDefaultReleased__c == true)
                         {
                             if(qirs[0].IsDefaultReleased__c == true)
                             {
                                 qirsprod[i].Release_Product__c = true;
                             }
                             if(i == 0)
                             {
                                 updateReleaseProduct = qirsprod[i].Name;
                             }
                             else
                             {
                                 if(updateReleaseProduct == '')
                                 {
                                     updateReleaseProduct = qirsprod[i].Name;
                                 }
                                 else
                                 {
                                       updateReleaseProduct = updateReleaseProduct + '; ' + qirsprod[i].Name;
                                 }
                             }
                          }
                         else
                         {
                         
                             if(i == 0)
                             {
                                 updateUnReleaseProduct = qirsprod[i].Name;
                             }
                             else
                             {
                                 if(updateUnReleaseProduct == '')
                                 {
                                     updateUnReleaseProduct = qirsprod[i].Name;
                                 }
                                 else
                                 {
                                       updateUnReleaseProduct = updateUnReleaseProduct + '; ' + qirsprod[i].Name;
                                 }
                             }
                         }
                     }
                     
               }
                 if(updateUnReleaseProduct != '' && updateReleaseProduct != '')
                 {
                     updateUnReleaseProduct =updateUnReleaseProduct +';';
                 }                             
                             
                        qirs[0].View_Product_Name__c = strProduct;     
                        qirs[0].View_Release_Product__c = updateReleaseProduct; 
                        qirs[0].Product_PN__c = updateUnReleaseProduct;                          
                        //update qirs;
                         qirsBulkupdate.add(qirs[0]);
                     }
                 }
             }
             else
             {
                 product.ClassAccess__c = false;
             }
        }
        if (!qirsBulkupdate.isEmpty()) 
        {
            Update qirsBulkupdate;
        }
    }
    else
    {
         List<QIRS__c> qirsBulkupdate = new List<QIRS__c>();                    
         for (QIRS_Product_Identification__c product : Trigger.new)
            {
               if(!product.ClassAccess__c)
                {
                    List<QIRS_Product_Identification__c> qirsprod = new List<QIRS_Product_Identification__c>();
                    List<QIRS__c> qirs = new List<QIRS__c>();

                    qirsprod =  [select ID, Name, Product_Name__c,Release_Product__c from 
                    QIRS_Product_Identification__c
                        where QIRS__c =: product.QIRS__c order by Name desc];
                    qirs = [select View_Release_Product__c,IsDefaultReleased__c,ID,Product_PN__c, Name,Status__c,View_Product_Name__c 
                    from QIRS__c where id =: product.QIRS__c];
                     string strProduct ='';
                     string updateReleaseProduct = '';
                     string updateUnReleaseProduct = '';                     
                     //product.ClassAccess__c = false;
                    if(qirs.size() > 0)                 
                     {
                        // string strProduct = product.Product_Identification__r.Name;
                        if(qirs[0].Status__c != 'Closed' && qirs[0].Status__c != 'Submited to Master Approval')
                        {
                             if(qirsprod.size()>0)
                             {
                             strProduct =  product.Product_Name__c;
                                 for(Integer i = 0; i < qirsprod.size(); i++)
                                     {
                                        
                                         //{
                                             strProduct = strProduct + '; ' +String.Valueof(qirsprod[i].Product_Name__c);
                                         //}
                                     }
                              }
                              else
                              {
                                  strProduct =  product.Product_Name__c;
                              }
                   if(product.Release_Product__c == true || qirs[0].IsDefaultReleased__c == true)
                      updateReleaseProduct = product.Name;               
                  else
                      updateUnReleaseProduct = product.Name;                                 
               for(Integer i = 0; i < qirsprod.size(); i++)
               {
                     if(qirsprod[i].Release_Product__c == true || qirs[0].IsDefaultReleased__c == true)
                     {
                         if(qirs[0].IsDefaultReleased__c == true)
                             {
                                 qirsprod[i].Release_Product__c = true;
                             }
                         if(updateReleaseProduct == '')
                         {
                             updateReleaseProduct = qirsprod[i].Name;
                         }
                         else
                         {
                               updateReleaseProduct = updateReleaseProduct + '; ' + qirsprod[i].Name;
                         }
                      }
                     else
                     {
                     if(updateUnReleaseProduct == '')
                         {
                             updateUnReleaseProduct = qirsprod[i].Name;
                         }
                         else
                         {
                               updateUnReleaseProduct = updateUnReleaseProduct + '; ' + qirsprod[i].Name;
                          }
                     }
               }
                 if(updateUnReleaseProduct != '' && updateReleaseProduct != '')
                 {
                     updateUnReleaseProduct =updateUnReleaseProduct +';';
                 }
             
                            qirs[0].View_Product_Name__c = strProduct;     
                            qirs[0].View_Release_Product__c = updateReleaseProduct; 
                            qirs[0].Product_PN__c = updateUnReleaseProduct;                          
                            //update qirs;
                            qirsBulkupdate.add(qirs[0]);

                        }
                     }
                 
             }
             else
             {
                 product.ClassAccess__c = false;
             }
           
            }
          
            if (!qirsBulkupdate.isEmpty()) 
            {
               Map<Id,QIRS__c> mapQirs=new Map<Id,QIRS__c>();
                for(integer l=0;l<qirsBulkupdate.size();l++)
                {
                  mapQirs.put(qirsBulkupdate[l].id,qirsBulkupdate[l]);
                }
                
               update mapQirs.values();
            }
            
        }
  
}