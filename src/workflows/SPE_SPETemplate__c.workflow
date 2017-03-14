<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>SPE_SPETemplate_Obsolete</fullName>
        <description>Field update when the lifecycle stage is obsolete</description>
        <field>RecordTypeId</field>
        <lookupValue>Obsolete</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>SPE_SPETemplate_Obsolete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SPE_SPETemplate_Pilot</fullName>
        <description>change the record type to pilot when the lifecycle stage changes to pilot</description>
        <field>RecordTypeId</field>
        <lookupValue>Pilot</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>SPE_SPETemplate_Pilot</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SPE_SPETemplate_Obsolete</fullName>
        <actions>
            <name>SPE_SPETemplate_Obsolete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SPE_SPETemplate__c.Stage__c</field>
            <operation>equals</operation>
            <value>Obsolete</value>
        </criteriaItems>
        <description>Template of SPE Template when lifecycle stage is obsolete</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SPE_SPETemplate_Pilot</fullName>
        <actions>
            <name>SPE_SPETemplate_Pilot</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2 OR 3</booleanFilter>
        <criteriaItems>
            <field>SPE_SPETemplate__c.Stage__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <criteriaItems>
            <field>SPE_SPETemplate__c.Stage__c</field>
            <operation>equals</operation>
            <value>Pilot</value>
        </criteriaItems>
        <criteriaItems>
            <field>SPE_SPETemplate__c.Stage__c</field>
            <operation>equals</operation>
            <value>Published</value>
        </criteriaItems>
        <description>change the record type to pilot when the lifecycle changes to pilot</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
