<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Belt_Certification_Change_Notification</fullName>
        <description>Belt Certification Change Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/QIPP_Belt_Certification_Update</template>
    </alerts>
    <fieldUpdates>
        <fullName>QIPP_Contact_Name_Update</fullName>
        <field>Full_Name__c</field>
        <formula>Name</formula>
        <name>QIPP Contact Name Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QIPP Contact - Belt Certification Update</fullName>
        <actions>
            <name>Belt_Certification_Change_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND ( ISCHANGED( Belt_Certification__c ),  NOT( ISPICKVAL( Belt_Certification__c , &apos;Not Specified&apos;) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QIPP Contact Name Update</fullName>
        <actions>
            <name>QIPP_Contact_Name_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QIPP_Contacts__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Update QIPP Full name with Contact name</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
