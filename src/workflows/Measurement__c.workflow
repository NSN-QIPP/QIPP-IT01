<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>NoOfSubmissions</fullName>
        <field>No_of_Sbmissions__c</field>
        <literalValue>2</literalValue>
        <name>NoOfSubmissions</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>UTDNoOfSubmissionsUpdation</fullName>
        <actions>
            <name>NoOfSubmissions</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Measurement__c.Response_from_UTD__c</field>
            <operation>contains</operation>
            <value>SUCCESS</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
