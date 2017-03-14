<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>QIPP_Portfolio_Name_Update</fullName>
        <description>Update portfolio name to maintain uniqueness</description>
        <field>Portfolio_Name_Unique__c</field>
        <formula>Name</formula>
        <name>QIPP Portfolio Name Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>QIPP Portfolio Name Update</fullName>
        <actions>
            <name>QIPP_Portfolio_Name_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QIPP_Portfolio__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Update Portfolio Name to maintain uniqueness</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
