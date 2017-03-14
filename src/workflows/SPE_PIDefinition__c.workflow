<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>PI_Draft_pilot</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Draft_and_Pilot</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PI Draft-pilot</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SPE_PIObsolete</fullName>
        <description>Update field type when the lifecycle stage is Obsolete</description>
        <field>RecordTypeId</field>
        <lookupValue>Obsolete</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>SPE_PIObsolete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SPE_Published</fullName>
        <description>Updating RecordType when the LifeCycle stage is published</description>
        <field>RecordTypeId</field>
        <lookupValue>Published</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>SPE_Published</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SPE_PIDraft-Pilot</fullName>
        <actions>
            <name>PI_Draft_pilot</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SPE_PIDefinition__c.LifecycleStage__c</field>
            <operation>equals</operation>
            <value>Draft,Pilot</value>
        </criteriaItems>
        <description>Change record type to draft and pilot if the lifecycle stage is draft of pilot</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SPE_PIObsolete</fullName>
        <actions>
            <name>SPE_PIObsolete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SPE_PIDefinition__c.LifecycleStage__c</field>
            <operation>equals</operation>
            <value>Obsolete</value>
        </criteriaItems>
        <description>Change record type to Obsolete if the lifecycle stage is Obsolete</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SPE_PIPublished</fullName>
        <actions>
            <name>SPE_Published</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SPE_PIDefinition__c.LifecycleStage__c</field>
            <operation>equals</operation>
            <value>Published</value>
        </criteriaItems>
        <description>Change record type to published if the lifecycle stage is published</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
