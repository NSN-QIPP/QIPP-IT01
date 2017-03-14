<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>SendSurveyMailToRespondent</fullName>
        <description>Send Survey Mail To Respondent</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>spe.admin@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>SPE_ScorecardTool/SPE_TrackerSurveyTemplate</template>
    </alerts>
    <alerts>
        <fullName>Send_Survey_Reminder_Mail_To_Respondent</fullName>
        <description>Send Survey Reminder Mail To Respondent</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>spe.admin@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>SPE_ScorecardTool/SPE_Tracker_Survey_Template_Remainder</template>
    </alerts>
    <fieldUpdates>
        <fullName>SPE_Last_SurveyEmailReceivedDateonCreate</fullName>
        <description>SPE_Last Survey Email Received Date update on Creation of new record</description>
        <field>LastSurveyEmailReceivedDate__c</field>
        <formula>LastModifiedDate</formula>
        <name>SPE_Last Survey Email Received Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SPE_Last_Survey_Email_Received_Date</fullName>
        <description>SPE_Last Survey Email Received Date Update</description>
        <field>LastSurveyEmailReceivedDate__c</field>
        <formula>LastModifiedDate</formula>
        <name>SPE_Last Survey Email Received Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SPE Send Survey Mail To Tracker Respondent</fullName>
        <actions>
            <name>SendSurveyMailToRespondent</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>SPE_Last_SurveyEmailReceivedDateonCreate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>!IsResponseReceived__c &amp;&amp;  ISPICKVAL(SPE_Tracker__r.Status__c, &apos;Pending&apos;)&amp;&amp; ISPICKVAL(SPE_Plan__r.Stage__c, &apos;Published&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>SPE Send Survey Reminder Mail To Tracker Respondent</fullName>
        <actions>
            <name>Send_Survey_Reminder_Mail_To_Respondent</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>SPE_Last_Survey_Email_Received_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>!ISNEW() &amp;&amp;  !IsResponseReceived__c &amp;&amp; ISPICKVAL(SPE_Tracker__r.Status__c, &apos;Pending&apos;) &amp;&amp; ISPICKVAL(SPE_Plan__r.Stage__c, &apos;Published&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
