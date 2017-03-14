<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>QIRS_Status_Update_For_Product</fullName>
        <description>if qirs status is lifted and user try to add product then update qirs status as open.</description>
        <field>Status__c</field>
        <literalValue>Open</literalValue>
        <name>QIRS_Status_Update_For_Product</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>QIRS__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>QIRS_Lift_Rule</fullName>
        <actions>
            <name>QIRS_Status_Update_For_Product</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QIRS__c.Status__c</field>
            <operation>equals</operation>
            <value>Released</value>
        </criteriaItems>
        <criteriaItems>
            <field>QIRS__c.IsDefaultReleased__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
