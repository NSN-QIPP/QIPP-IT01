<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QIPP_Task_Implementer_Assigned_for_Task</fullName>
        <description>QIPP Task Implementer Assigned for Task</description>
        <protected>false</protected>
        <recipients>
            <field>Project_Lead_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>TaskImplementorEmail__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/QIPP_Task_Implementer_Assigned_for_Task</template>
    </alerts>
    <alerts>
        <fullName>QIPP_When_a_Task_Implementer_is_assigned_or_changed_in_the_task_view_an_email_no</fullName>
        <description>QIPP When a Task Implementer is assigned or changed in the task view, an email notification is sent to the newly assigned Task Implementer</description>
        <protected>false</protected>
        <recipients>
            <field>Project_Lead_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>TaskImplementorEmail__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/QIPP_Task_Implementer_Assigned_for_Task</template>
    </alerts>
    <alerts>
        <fullName>When_a_task_is_completed_an_email_notification_is_sent_to_the_Project_Lead</fullName>
        <description>When a task is completed, an email notification is sent to the Project Lead</description>
        <protected>false</protected>
        <recipients>
            <field>Project_Lead_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>TaskImplementorEmail__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/QIPP_Task_has_been_completed_for_project</template>
    </alerts>
    <rules>
        <fullName>QIPP Task Implementer is assigned email notification is sent to the newly assigned Task Implementer</fullName>
        <actions>
            <name>QIPP_Task_Implementer_Assigned_for_Task</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QIPP_Task__c.TaskImplementorEmail__c</field>
            <operation>notEqual</operation>
            <value>null</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>QIPP Task Implementer is changed email notification is sent to the newly assigned Task Implementer</fullName>
        <actions>
            <name>QIPP_When_a_Task_Implementer_is_assigned_or_changed_in_the_task_view_an_email_no</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(Task_Implementer__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QIPP When a task is completed%2C an email notification is sent to the Project Lead</fullName>
        <actions>
            <name>When_a_task_is_completed_an_email_notification_is_sent_to_the_Project_Lead</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QIPP_Task__c.Task_State__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
