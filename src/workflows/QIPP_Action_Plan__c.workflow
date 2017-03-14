<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QIPP_Action_Plan_30day_Reminder_for_Target_Completion_Date</fullName>
        <description>QIPP Action Plan - 30 day Reminder for Target Completion Date</description>
        <protected>false</protected>
        <recipients>
            <field>Action_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Audit/QIPP_Action_Plan_Target_Completion_Date_Assigned</template>
    </alerts>
    <alerts>
        <fullName>QIPP_Action_Plan_5_days_Reminder_for_Target_Completion_Date</fullName>
        <description>QIPP Action Plan - 5 days Reminder for Target Completion Date</description>
        <protected>false</protected>
        <recipients>
            <field>Action_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Audit/QIPP_Action_Plan_Target_Completion_Date_Assigned</template>
    </alerts>
    <alerts>
        <fullName>QIPP_Action_Plan_Due_Today</fullName>
        <description>QIPP Action Plan - Due Today</description>
        <protected>false</protected>
        <recipients>
            <field>Action_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Audit/QIPP_Action_Plan_Due_Today</template>
    </alerts>
    <alerts>
        <fullName>QIPP_Action_Plan_Target_Completion_Date_was_Due_1_Day</fullName>
        <description>QIPP Action Plan - Target Completion Date was Due by 30 Days</description>
        <protected>false</protected>
        <recipients>
            <field>Action_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Finding_Auditor_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/QIPP_Action_Plan_Target_Completion_Date_was_Due</template>
    </alerts>
    <alerts>
        <fullName>QIPP_Action_Plan_Target_Completion_Date_was_Due_by_10_Days</fullName>
        <description>QIPP Action Plan - Target Completion Date was Due by 10 Days</description>
        <protected>false</protected>
        <recipients>
            <field>Action_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Finding_Auditor_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/QIPP_Action_Plan_Target_Completion_Date_was_Due</template>
    </alerts>
    <alerts>
        <fullName>QIPP_Action_Plan_Target_Completion_Date_was_Due_by_180_Days</fullName>
        <description>QIPP Action Plan - Target Completion Date was Due by 180 Days</description>
        <protected>false</protected>
        <recipients>
            <field>Action_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Finding_Auditor_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/QIPP_Action_Plan_Target_Completion_Date_was_Due</template>
    </alerts>
    <alerts>
        <fullName>QIPP_Action_Plan_Target_Completion_Date_was_Due_by_90_Days</fullName>
        <description>QIPP Action Plan - Target Completion Date was Due by 90 Days</description>
        <protected>false</protected>
        <recipients>
            <field>Action_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Finding_Auditor_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/QIPP_Action_Plan_Target_Completion_Date_was_Due</template>
    </alerts>
    <alerts>
        <fullName>QIPP_Action_plan_Target_Completion_Date_assign</fullName>
        <description>QIPP Action plan Target Completion Date assign</description>
        <protected>false</protected>
        <recipients>
            <field>Action_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Audit/QIPP_Action_Plan_Target_Completion_Date_Assigned</template>
    </alerts>
    <alerts>
        <fullName>QIPP_New_Action_Plan_Created</fullName>
        <description>QIPP New Action Plan Created</description>
        <protected>false</protected>
        <recipients>
            <field>Action_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Audit/QIPP_New_Action_Plan_Created</template>
    </alerts>
    <fieldUpdates>
        <fullName>Auto_Update_Closing_Date_Action_Plan</fullName>
        <description>Auto Update Closing Date - Action Plan</description>
        <field>Action_Plan_Actual_Completion_Date__c</field>
        <formula>Today()</formula>
        <name>Auto Update Closing Date - Action Plan</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Auto_Update_Closing_Date_CA</fullName>
        <description>Auto Update Closing Date - CA</description>
        <field>Actual_Completion_Date_CA__c</field>
        <formula>Today()</formula>
        <name>Auto Update Closing Date - CA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Auto_Update_Closing_Date_PA</fullName>
        <description>Auto Update Closing Date - PA</description>
        <field>Actual_Completion_Date_PA__c</field>
        <formula>Today()</formula>
        <name>Auto Update Closing Date - PA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Auto_Update_Closing_Date_RCA</fullName>
        <description>Auto Update Closing Date - RCA</description>
        <field>Closing_Date_RCA__c</field>
        <formula>Today()</formula>
        <name>Auto Update Closing Date - RCA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Auto Update Closing Date - Action Plan</fullName>
        <actions>
            <name>Auto_Update_Closing_Date_Action_Plan</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QIPP_Action_Plan__c.Action_Plan_State__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <description>Auto Update Closing Date - Action Plan</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Auto Update Closing Date - CA</fullName>
        <actions>
            <name>Auto_Update_Closing_Date_CA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QIPP_Action_Plan__c.Action_Plan_State_CA__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <description>Auto Update Closing Date - CA</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Auto Update Closing Date - PA</fullName>
        <actions>
            <name>Auto_Update_Closing_Date_PA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QIPP_Action_Plan__c.Action_Plan_State_PA__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <description>Auto Update Closing Date - PA</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Auto Update Closing Date - RCA</fullName>
        <actions>
            <name>Auto_Update_Closing_Date_RCA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QIPP_Action_Plan__c.Action_Plan_State_RCA__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <description>Auto Update Closing Date - RCA</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QIPP Action Plan %E2%80%93 30 Day Reminder</fullName>
        <active>true</active>
        <criteriaItems>
            <field>QIPP_Action_Plan__c.Action_Plan_Target_Completion_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>QIPP_Action_Plan__c.Action_Plan_State__c</field>
            <operation>equals</operation>
            <value>In Progress,On hold,Not started</value>
        </criteriaItems>
        <description>30 day reminder for QIPP Action Plan – based on the Target Completion Date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>QIPP_Action_Plan_30day_Reminder_for_Target_Completion_Date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>QIPP_Action_Plan__c.Action_Plan_Target_Completion_Date__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>QIPP Action Plan - Change in Action State</fullName>
        <active>false</active>
        <description>This workflow rule gets executed whenever there is a change in state for the Action Plan</description>
        <formula>ISCHANGED(Action_Plan_State__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QIPP Action Plan - Due Today</fullName>
        <actions>
            <name>QIPP_Action_Plan_Due_Today</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This workflow gets executed on the day this Action Plan is due</description>
        <formula>IF(TODAY() == Action_Plan_Target_Completion_Date__c &amp;&amp; ( (ISPICKVAL(Action_Plan_State__c, &quot;On hold&quot;)) || (ISPICKVAL(Action_Plan_State__c, &quot;In Progress&quot;)) || (ISPICKVAL(Action_Plan_State__c, &quot;Not started&quot;)) ) , true , false)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QIPP Action Plan - Target Completion Date was Due</fullName>
        <active>true</active>
        <criteriaItems>
            <field>QIPP_Action_Plan__c.Action_Plan_State__c</field>
            <operation>notEqual</operation>
            <value>Complete,Canceled</value>
        </criteriaItems>
        <criteriaItems>
            <field>QIPP_Action_Plan__c.Action_Plan_Target_Completion_Date__c</field>
            <operation>lessThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>QIPP_Action_Plan_Target_Completion_Date_was_Due_1_Day</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>QIPP_Action_Plan__c.Action_Plan_Target_Completion_Date__c</offsetFromField>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>QIPP_Action_Plan_Target_Completion_Date_was_Due_by_10_Days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>QIPP_Action_Plan__c.Action_Plan_Target_Completion_Date__c</offsetFromField>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>QIPP_Action_Plan_Target_Completion_Date_was_Due_by_180_Days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>QIPP_Action_Plan__c.Action_Plan_Target_Completion_Date__c</offsetFromField>
            <timeLength>180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>QIPP_Action_Plan_Target_Completion_Date_was_Due_by_90_Days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>QIPP_Action_Plan__c.Action_Plan_Target_Completion_Date__c</offsetFromField>
            <timeLength>90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>QIPP Action Plan 5 days Reminder Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>QIPP_Action_Plan__c.Action_Plan_Target_Completion_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>QIPP_Action_Plan__c.Action_Plan_State__c</field>
            <operation>notEqual</operation>
            <value>Complete,Canceled</value>
        </criteriaItems>
        <description>Send one more reminder 5 days prior to the &quot;Target Completion Date&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>QIPP_Action_Plan_5_days_Reminder_for_Target_Completion_Date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>QIPP_Action_Plan__c.Action_Plan_Target_Completion_Date__c</offsetFromField>
            <timeLength>-5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>QIPP Action plan Target Completion Date assign</fullName>
        <actions>
            <name>QIPP_Action_plan_Target_Completion_Date_assign</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QIPP_Action_Plan__c.Action_Plan_Target_Completion_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>QIPP_Action_Plan__c.Action_Plan_State__c</field>
            <operation>notEqual</operation>
            <value>Complete,Canceled</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QIPP New Action Plan Created</fullName>
        <actions>
            <name>QIPP_New_Action_Plan_Created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QIPP_Action_Plan__c.Action_Plan_Name__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
