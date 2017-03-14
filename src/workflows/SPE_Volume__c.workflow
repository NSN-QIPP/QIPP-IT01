<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>spe_volume_IsUpdated</fullName>
        <description>It will update the field IsUpdated__c whenever the record is edited</description>
        <field>IsUpdated__c</field>
        <literalValue>1</literalValue>
        <name>spe_volume_IsUpdated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SPE_IsUpdated%28Volume%29</fullName>
        <actions>
            <name>spe_volume_IsUpdated</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>It will update the field IsUpdated__c whenever the record is edited</description>
        <formula>AND (ISCHANGED( LastModifiedDate ),NOT(ISNEW()))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
