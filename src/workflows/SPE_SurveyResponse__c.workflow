<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>EID_To_be_Updated</fullName>
        <field>EncryptedEnterpriseId__c</field>
        <formula>Supplier__r.EnterpriseId__c</formula>
        <name>EID To be Updated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SPE_SurveyResponseEIDtobeUpdated</fullName>
        <actions>
            <name>EID_To_be_Updated</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>True</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
