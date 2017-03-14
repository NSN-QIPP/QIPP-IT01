<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Unique_Id</fullName>
        <field>Unique_Id__c</field>
        <formula>Enterprise_Id__c</formula>
        <name>Update Unique Id</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Unique Id</fullName>
        <actions>
            <name>Update_Unique_Id</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Enterprise_Id__c != Null</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
