<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>EID_To_be_Updated</fullName>
        <description>This Field update is used to populate EID according to Mapping Key available in the KPI Value Record.</description>
        <field>EnterpriseId__c</field>
        <formula>EnterpriseIDEncrypted__r.EnterpriseId__c</formula>
        <name>EID To be Updated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SPE_KPIValueEIDtobeUpdated</fullName>
        <actions>
            <name>EID_To_be_Updated</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This Rule is used to populate EID according to Mapping Key available in the KPI Value Record.</description>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
