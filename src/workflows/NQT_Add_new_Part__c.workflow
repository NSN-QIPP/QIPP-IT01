<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>NQT_Add_New_Part</fullName>
        <description>NQT Add New Part</description>
        <protected>false</protected>
        <recipients>
            <field>Business_Operation__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_Add_new_part</template>
    </alerts>
    <alerts>
        <fullName>New_Part_Added_By_Bus_Operation</fullName>
        <description>New Part Added By Bus Operation</description>
        <protected>false</protected>
        <recipients>
            <field>Business_Operation__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_BUS_OPS_COMPLETE</template>
    </alerts>
    <rules>
        <fullName>NQT Add New Part</fullName>
        <actions>
            <name>NQT_Add_New_Part</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>NQT_Add_new_Part__c.Name</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <criteriaItems>
            <field>NQT_Add_new_Part__c.NQT_Part_description__c</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <description>Execute after add new part requested</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>NQT New Part Added</fullName>
        <actions>
            <name>New_Part_Added_By_Bus_Operation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>NQT_Add_new_Part__c.NQT_Added__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>NQT_Add_new_Part__c.Name</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <description>New Part Added</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
