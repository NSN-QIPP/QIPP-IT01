<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Bug_Modified</fullName>
        <ccEmails>kaushik.ganguly@atos.net</ccEmails>
        <ccEmails>SATYAJIT.KUMARSINGH@atos.net</ccEmails>
        <ccEmails>Soma.Giri@atos.net</ccEmails>
        <description>Bug Modified</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Bug_Modified</template>
    </alerts>
    <alerts>
        <fullName>Show_stopper_bug</fullName>
        <ccEmails>kaushik.ganguly@atos.net</ccEmails>
        <ccEmails>SATYAJIT.KUMARSINGH@atos.net</ccEmails>
        <ccEmails>Soma.Giri@atos.net</ccEmails>
        <description>Show stopper bug</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Show_Stopper_Bug</template>
    </alerts>
    <rules>
        <fullName>Bug Modified</fullName>
        <actions>
            <name>Bug_Modified</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Bugs__c.DefectStatus__c</field>
            <operation>equals</operation>
            <value>Resolved,Closed,Rejected / Invalid</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SPE_BugsShowStopper</fullName>
        <actions>
            <name>Show_stopper_bug</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Bugs__c.DefectSeverity__c</field>
            <operation>equals</operation>
            <value>Show Stopper</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
