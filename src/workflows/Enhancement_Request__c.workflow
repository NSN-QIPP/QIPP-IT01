<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Enhancement_Request_Creation</fullName>
        <ccEmails>Chetan.Nawale@atos.net</ccEmails>
        <description>Enhancement Request_Creation</description>
        <protected>false</protected>
        <recipients>
            <recipient>testforprod@atos.net</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Enhancement_Request_DeMaStatusEQUALSCreated</template>
    </alerts>
    <rules>
        <fullName>Enhancement Request_Record Creation</fullName>
        <actions>
            <name>Enhancement_Request_Creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Enhancement_Request__c.DeMaStatus__c</field>
            <operation>equals</operation>
            <value>Created</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
