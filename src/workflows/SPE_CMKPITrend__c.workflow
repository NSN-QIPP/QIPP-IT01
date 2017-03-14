<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>UpdateDOE</fullName>
        <field>DateofExecution__c</field>
        <formula>TrackerValue__r.DateOfExecution__c</formula>
        <name>Update DOE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateFieldonCM</fullName>
        <field>GrowingPeriodInterval__c</field>
        <formula>if(KPIScore__c &gt;= ConsequenceManagement__r.ContinuouslyAboveThreshold_Period__c,  ConsequenceManagement__r.GrowingPeriodInterval__c+1, 0)</formula>
        <name>Update Field on CM</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ConsequenceManagement__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>SPE_UpdateDOE</fullName>
        <actions>
            <name>UpdateDOE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UpdateFieldonCM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
