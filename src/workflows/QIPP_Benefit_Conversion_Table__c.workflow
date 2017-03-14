<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>QIPP_Benefit_Conversion_Table_Update</fullName>
        <description>Field update to maintain uniqueness for QIPP - Benefit Conversion Table object</description>
        <field>Improvement_Measure_Unique__c</field>
        <formula>Name</formula>
        <name>QIPP - Benefit Conversion Table - Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QIPP - Benefit Conversion Table - Update Improvement Measure</fullName>
        <actions>
            <name>QIPP_Benefit_Conversion_Table_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QIPP_Benefit_Conversion_Table__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This rule is used to maintain uniqueness for the QIPP - Benefit Conversion Table object.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
