<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Send_Survey_Link_Field_Update</fullName>
        <field>SendSurveyLink__c</field>
        <literalValue>1</literalValue>
        <name>Send Survey Link Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Send_Survey_Link</fullName>
        <field>SendSurveyLink__c</field>
        <literalValue>1</literalValue>
        <name>Update Send Survey Link</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SPE2 Survey Mail Tracker Workflow</fullName>
        <active>true</active>
        <formula>ISPICKVAL(Survey__r.Stage__c,&apos;Published&apos;)&amp;&amp; ISPICKVAL(Status__c , &apos;Pending&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Send_Survey_Link</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>SPE2_SurveyTracker__c.DateOfExecution__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SPE2 Survey Reminder Mail Tracker Workflow</fullName>
        <active>true</active>
        <formula>ISPICKVAL(Survey__r.Stage__c,&apos;Published&apos;)&amp;&amp; ISPICKVAL(Status__c ,&apos;Pending&apos;)&amp;&amp;  (SurveyReminderBeforeExecutionDate__c &lt;&gt; Survey_Execution_Date__c)</formula>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Send_Survey_Link_Field_Update</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>SPE2_SurveyTracker__c.SurveyReminderBeforeExecutionDate__c</offsetFromField>
            <timeLength>2</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
