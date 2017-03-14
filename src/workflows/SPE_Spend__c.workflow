<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>IsUpdated</fullName>
        <description>It will update the field IsUpdated__c whenever the record is edited</description>
        <field>IsUpdated__c</field>
        <literalValue>1</literalValue>
        <name>IsUpdated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Scope_Combination</fullName>
        <field>SpendScopeCombination__c</field>
        <formula>Region__c +&apos;;&apos;+ Sub_Region__c +&apos;;&apos;+ Country__c +&apos;;&apos;+ Project__c +&apos;;&apos;+ CategoryArea__c +&apos;;&apos;+ CategoryGroup__c +&apos;;&apos;+ Category__c +&apos;;&apos;+ Business_Unit__c +&apos;;&apos;+ Business_Line__c +&apos;;&apos;+ Product__c</formula>
        <name>Spend Scope Combination</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SPE2 Spend Scope Combination</fullName>
        <actions>
            <name>Spend_Scope_Combination</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6 AND 7 AND 8 AND 9 AND 10</booleanFilter>
        <criteriaItems>
            <field>SPE_Spend__c.Region__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <criteriaItems>
            <field>SPE_Spend__c.Sub_Region__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <criteriaItems>
            <field>SPE_Spend__c.Country__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <criteriaItems>
            <field>SPE_Spend__c.Project__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <criteriaItems>
            <field>SPE_Spend__c.CategoryArea__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <criteriaItems>
            <field>SPE_Spend__c.Category__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <criteriaItems>
            <field>SPE_Spend__c.CategoryGroup__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <criteriaItems>
            <field>SPE_Spend__c.Business_Line__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <criteriaItems>
            <field>SPE_Spend__c.Business_Unit__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <criteriaItems>
            <field>SPE_Spend__c.Product__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SPE_IsUpdated</fullName>
        <actions>
            <name>IsUpdated</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>It will update the field IsUpdated__c whenever the record is edited</description>
        <formula>AND (ISCHANGED( LastModifiedDate ),NOT(ISNEW()))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
