<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>SPE_Update_Question_Name</fullName>
        <field>Name</field>
        <formula>QuestionCode__c</formula>
        <name>SPE Update Question Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SPE Update Question Name</fullName>
        <actions>
            <name>SPE_Update_Question_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Question Name</description>
        <formula>True</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
