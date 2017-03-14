<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_Email_to_owner_and_system_admin_for_record_creation</fullName>
        <description>Send Email to owner and system admin for record creation</description>
        <protected>false</protected>
        <recipients>
            <field>Email_ID__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>QIRSAdminRole</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QIRS_Email_Template/QIRS_Change_Request_Template_When_Open</template>
    </alerts>
    <alerts>
        <fullName>Send_email_to_admin_and_user_when_request_is_closed</fullName>
        <description>Send email to admin and user when request is closed</description>
        <protected>false</protected>
        <recipients>
            <field>Email_ID__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>QIRSAdminRole</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QIRS_Email_Template/QIRS_Change_Request_Template_When_Close</template>
    </alerts>
    <rules>
        <fullName>QIRS Send email to user and system admin</fullName>
        <actions>
            <name>Send_Email_to_owner_and_system_admin_for_record_creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QIRS_Change_Request__c.QIRS_Number__c</field>
            <operation>equals</operation>
            <value>null</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QIRS Send email to user and system admin when status closed</fullName>
        <actions>
            <name>Send_email_to_admin_and_user_when_request_is_closed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QIRS_Change_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
