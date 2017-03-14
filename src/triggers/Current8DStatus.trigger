trigger Current8DStatus on MCAR__c (before insert,before update) 
{
list<MCAR__c> mcarlist = [select name,X3D_Status__c,X4D_Owner_Approve_Reject__c,X5D_Status__c,X6D_Status__c,X7D_Status__c,MCAR_Current_8D_Step__c from MCAR__c ];
mcarlist = trigger.new ;
for(MCAR__c m : mcarlist )
{
if(m.X3D_Status__c =='APPROVE' && m.X4D_Owner_Approve_Reject__c != 'APPROVE')
{
m.MCAR_Current_8D_Step__c = '4D=Root Cause';
}
else if(m.X3D_Status__c !='APPROVE' && m.X4D_Owner_Approve_Reject__c == 'APPROVE'){
m.adderror('3D Approval is necessary for 4D Approval');
}

if(m.X4D_Owner_Approve_Reject__c =='APPROVE' && m.X5D_Status__c!= 'APPROVE')
{
m.MCAR_Current_8D_Step__c = '5D=Permanent Action';
}
else if(m.X4D_Owner_Approve_Reject__c !='APPROVE' && m.X5D_Status__c == 'APPROVE')
m.adderror('4D Approval is necessary for 5D Approval');

if(m.X5D_Status__c =='APPROVE' && m.X6D_Status__c!= 'APPROVE')
{
m.MCAR_Current_8D_Step__c = '6D=Verification';
}
else if(m.X5D_Status__c!='APPROVE' && m.X6D_Status__c == 'APPROVE')
m.adderror('5D Approval is necessary for 6D Approval');

if(m.X6D_Status__c =='APPROVE' && m.X7D_Status__c!= 'APPROVE')
{
m.MCAR_Current_8D_Step__c = '7D=Prevent Recurrence';
}
else if(m.X6D_Status__c!='APPROVE' && m.X7D_Status__c == 'APPROVE')
m.adderror('6D Approval is necessary for 7D Approval');

if(m.X7D_Status__c =='APPROVE')
{
m.MCAR_Current_8D_Step__c = '8D=Case Summary';
}

}

}