<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>SPE_ScorecardGeneratorIsAdoc</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Adhoc_Record_Type</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>SPE_ScorecardGeneratorIsAdoc</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SPE_ScorecardGeneratorIsAdoc</fullName>
        <actions>
            <name>SPE_ScorecardGeneratorIsAdoc</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SPE_ScorecardGenerator__c.isAdhoc__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
