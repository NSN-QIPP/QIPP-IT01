<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Send_Survey_Field_Update</fullName>
        <field>SendSurveyLink__c</field>
        <literalValue>1</literalValue>
        <name>Send Survey Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Send_Survey_Link_Field_Update</fullName>
        <field>SendSurveyLink__c</field>
        <literalValue>1</literalValue>
        <name>Send Survey Link Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SPE Survey Mail Tracker Workflow</fullName>
        <active>true</active>
        <formula>ISPICKVAL(SPEPlan__r.Stage__c, &apos;Published&apos;)&amp;&amp;  ISPICKVAL(Status__c , &apos;Pending&apos;)&amp;&amp; ISPICKVAL( SPEPlan__r.Stage__c , &apos;Published&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Send_Survey_Field_Update</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>SPE_SPETracker__c.SurveyExecutionBeforeIndays__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SPE Survey Reminder Mail Tracker Workflow</fullName>
        <active>true</active>
        <formula>ISPICKVAL(SPEPlan__r.Stage__c, &apos;Published&apos;)&amp;&amp; ISPICKVAL(Status__c , &apos;Pending&apos;)&amp;&amp; ISPICKVAL( SPEPlan__r.Stage__c, &apos;Published&apos; )</formula>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Send_Survey_Link_Field_Update</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>SPE_SPETracker__c.SurveyReminderBeforeExecutionDate__c</offsetFromField>
            <timeLength>2</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
