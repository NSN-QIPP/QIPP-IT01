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
        <template>SPE_ScorecardTool/SPE2_TrackerSurveyTemplate</template>
    </alerts>
    <alerts>
        <fullName>Send_Reminder_Email_to_Survey_Respondent</fullName>
        <description>Send Reminder Email to Survey Respondent</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>spe.admin@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>SPE_ScorecardTool/SPE_Tracker_Survey_Template_Remainder</template>
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
        <template>SPE_ScorecardTool/SPE2_Tracker_Survey_Template_Remainder</template>
    </alerts>
    <fieldUpdates>
        <fullName>SPE2Last_SurveyEmailReceivedDateonCreate</fullName>
        <description>SPE_Last Survey Email Received Date update on Creation of new record</description>
        <field>LastSurveyEmailReceivedDate__c</field>
        <formula>LastModifiedDate</formula>
        <name>SPE2_Last Survey Email Received Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SPE2_Last_Survey_Email_Received_Date</fullName>
        <description>SPE_Last Survey Email Received Date Update</description>
        <field>LastSurveyEmailReceivedDate__c</field>
        <formula>LastModifiedDate</formula>
        <name>SPE2_Last Survey Email Received Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SPE2 Send Survey Mail To SurveyTracker Respondent</fullName>
        <actions>
            <name>SendSurveyMailToRespondent</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>SPE2Last_SurveyEmailReceivedDateonCreate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>!IsResponseReceived__c &amp;&amp; ISPICKVAL( Survey_Tracker__r.Status__c, &apos;Pending&apos;)&amp;&amp; ISPICKVAL( Survey__r.Stage__c, &apos;Published&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>SPE2 Send Survey Reminder Mail To Tracker Respondent</fullName>
        <actions>
            <name>Send_Survey_Reminder_Mail_To_Respondent</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>SPE2_Last_Survey_Email_Received_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>!ISNEW() &amp;&amp; !IsResponseReceived__c &amp;&amp; ISPICKVAL( Survey_Tracker__r.Status__c, &apos;Pending&apos;) &amp;&amp; ISPICKVAL(Survey__r.Stage__c, &apos;Published&apos;)&amp;&amp; ( Survey_Tracker__r.SurveyReminderBeforeExecutionDate__c &lt;&gt;  Survey_Tracker__r.Survey_Execution_Date__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
