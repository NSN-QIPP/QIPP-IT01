<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>NQT_Assign_backup</fullName>
        <description>Assign backup</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Backup_Person__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_Assign_Backup</template>
    </alerts>
    <rules>
        <fullName>NQT Assign Backup From Email</fullName>
        <actions>
            <name>NQT_Assign_backup</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>NQT_Assign_Backup_Person__c.NQT_Availability_Status__c</field>
            <operation>equals</operation>
            <value>Out of office,Un Available</value>
        </criteriaItems>
        <description>Executes on start date of backup</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
