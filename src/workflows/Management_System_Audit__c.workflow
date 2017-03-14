<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QIPP_Audit_Notification_Completed_Status</fullName>
        <description>QIPP Audit Notification - Completed Status</description>
        <protected>false</protected>
        <recipients>
            <field>Lead_Auditor_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/QIPP_Audit_Notification_Completed_Status</template>
    </alerts>
    <fieldUpdates>
        <fullName>Auto_Update_Audit_Completed_Date</fullName>
        <description>Auto Update Audit Completed Date</description>
        <field>Audit_Complete_Date__c</field>
        <formula>Today()</formula>
        <name>Auto Update Audit Completed Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Auto Update Audit Completed Date</fullName>
        <actions>
            <name>Auto_Update_Audit_Completed_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Management_System_Audit__c.Audit_Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>Auto Update Audit Completed Date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QIPP Audit - Status Changed To Complete</fullName>
        <actions>
            <name>QIPP_Audit_Notification_Completed_Status</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Management_System_Audit__c.Audit_Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>This workflow rule will be executed when Audit Status is changed to &apos;Complete&apos;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
