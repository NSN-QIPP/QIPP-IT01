<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QIPP_CoPQ_New_CoPQ_Reduction_Project</fullName>
        <description>QIPP - CoPQ - New CoPQ Reduction Project</description>
        <protected>false</protected>
        <recipients>
            <field>BL_Transformation_Lead_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Business_Owner_Delegate_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Business_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Finance_Approver_Delegate_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Finance_Approver_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Measure_Creator_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Q_PMO_Team_Member_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/QIPP_CoPQ_New_CoPQ_Reduction_Project</template>
    </alerts>
    <rules>
        <fullName>QIPP Notification Of NEW CoPQ Project Team is setup</fullName>
        <actions>
            <name>QIPP_CoPQ_New_CoPQ_Reduction_Project</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(Business_Owner__c != null, Finance_Approver__c != null,  Q_PMO_Team_Member__c != null)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
