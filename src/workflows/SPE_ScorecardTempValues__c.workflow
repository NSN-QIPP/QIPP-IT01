<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Category</fullName>
        <field>Category__c</field>
        <formula>TEXT(SPE_Plan__r.Category__c)</formula>
        <name>Category</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Category_Area</fullName>
        <field>CategoryArea__c</field>
        <formula>TEXT( SPE_Plan__r.CategoryCluster__c )</formula>
        <name>Category Area</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Category_Group</fullName>
        <field>CategoryGroup__c</field>
        <formula>TEXT(SPE_Plan__r.CategoryGroup__c )</formula>
        <name>Category Group</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Country</fullName>
        <field>Country__c</field>
        <formula>TEXT(SPE_Plan__r.Country__c )</formula>
        <name>Country</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Market</fullName>
        <field>Market__c</field>
        <formula>TEXT(SPE_Plan__r.Region__c )</formula>
        <name>Market</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>market_Unit</fullName>
        <field>MarketUnit__c</field>
        <formula>TEXT(SPE_Plan__r.SubRegion__c )</formula>
        <name>market Unit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SPE_Fill scopes Scorecard</fullName>
        <actions>
            <name>Category</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Category_Area</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Category_Group</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Country</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Market</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>market_Unit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SPE_ScorecardTempValues__c.CrunchedScores__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
