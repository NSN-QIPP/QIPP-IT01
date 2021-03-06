<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QIPP_Finding_30day_Reminder_for_Target_Completion_Date</fullName>
        <description>QIPP Finding - 30 day Reminder for Target Completion Date</description>
        <protected>false</protected>
        <recipients>
            <field>Finding_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Audit/QIPP_Finding_Target_Completion_Date_Assigned</template>
    </alerts>
    <alerts>
        <fullName>QIPP_Finding_5_days_before_Reminder_for_Target_Completion_Date</fullName>
        <description>QIPP Finding - 5 days before Reminder for Target Completion Date</description>
        <protected>false</protected>
        <recipients>
            <field>Finding_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Audit/QIPP_Finding_Target_Completion_Date_Assigned</template>
    </alerts>
    <alerts>
        <fullName>QIPP_Finding_Due_Today</fullName>
        <description>QIPP Finding - Due Today</description>
        <protected>false</protected>
        <recipients>
            <field>Finding_Auditor_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Finding_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Audit/QIPP_Finding_Due_Today</template>
    </alerts>
    <alerts>
        <fullName>QIPP_Finding_Target_Completion_Date_is_assigned</fullName>
        <description>QIPP Finding Target Completion Date is assigned</description>
        <protected>false</protected>
        <recipients>
            <field>Finding_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Audit/QIPP_Finding_Target_Completion_Date_Assigned</template>
    </alerts>
    <alerts>
        <fullName>QIPP_Finding_Target_Completion_Date_was_Due_by_10_Days</fullName>
        <description>QIPP Finding - Target Completion Date was Due by 10 Days</description>
        <protected>false</protected>
        <recipients>
            <field>Finding_Auditor_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Finding_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/QIPP_Finding_Target_Completion_Date_was_Due</template>
    </alerts>
    <alerts>
        <fullName>QIPP_Finding_Target_Completion_Date_was_Due_by_180_Days</fullName>
        <description>QIPP Finding - Target Completion Date was Due by 180 Days</description>
        <protected>false</protected>
        <recipients>
            <field>Finding_Auditor_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Finding_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/QIPP_Finding_Target_Completion_Date_was_Due</template>
    </alerts>
    <alerts>
        <fullName>QIPP_Finding_Target_Completion_Date_was_Due_by_30_Days</fullName>
        <description>QIPP Finding - Target Completion Date was Due by 30 Days</description>
        <protected>false</protected>
        <recipients>
            <field>Finding_Auditor_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Finding_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/QIPP_Finding_Target_Completion_Date_was_Due</template>
    </alerts>
    <alerts>
        <fullName>QIPP_Finding_Target_Completion_Date_was_Due_by_90_Days</fullName>
        <description>QIPP Finding - Target Completion Date was Due by 90 Days</description>
        <protected>false</protected>
        <recipients>
            <field>Finding_Auditor_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Finding_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/QIPP_Finding_Target_Completion_Date_was_Due</template>
    </alerts>
    <alerts>
        <fullName>QIPP_New_Finding_Created</fullName>
        <description>QIPP New Finding Created</description>
        <protected>false</protected>
        <recipients>
            <field>Finding_Auditor_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Finding_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>qippadmin.quality@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Audit/QIPP_New_Finding_Created</template>
    </alerts>
    <rules>
        <fullName>QIPP Change in Finding State</fullName>
        <active>true</active>
        <formula>AND(ISCHANGED(Finding_State__c), NOT( ISBLANK( Finding_Name__c  ))  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QIPP Finding %E2%80%93 30 Day Reminder</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Finding__c.Finding_Completion_Date_Target__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Finding__c.Finding_State__c</field>
            <operation>notEqual</operation>
            <value>Complete,Canceled</value>
        </criteriaItems>
        <description>30 day reminder for QIPP Finding – based on the Target Completion Date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>QIPP_Finding_30day_Reminder_for_Target_Completion_Date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Finding__c.Finding_Completion_Date_Target__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>QIPP Finding - Due Today</fullName>
        <actions>
            <name>QIPP_Finding_Due_Today</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>QIPP Finding - Send a reminder if the Finding is not Completed or Cancelled</description>
        <formula>IF(TODAY() ==  Finding_Completion_Date_Target__c &amp;&amp;   ( (ISPICKVAL(Finding_State__c, &quot;On hold&quot;)) || (ISPICKVAL(Finding_State__c, &quot;In Progress&quot;)) || (ISPICKVAL(Finding_State__c, &quot;Not started&quot;))  ) , true , false)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QIPP Finding - Target Completion Date was Due</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Finding__c.Finding_State__c</field>
            <operation>notEqual</operation>
            <value>Complete,Canceled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finding__c.Finding_Completion_Date_Target__c</field>
            <operation>lessThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>QIPP_Finding_Target_Completion_Date_was_Due_by_30_Days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Finding__c.Finding_Completion_Date_Target__c</offsetFromField>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>QIPP_Finding_Target_Completion_Date_was_Due_by_10_Days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Finding__c.Finding_Completion_Date_Target__c</offsetFromField>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>QIPP_Finding_Target_Completion_Date_was_Due_by_180_Days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Finding__c.Finding_Completion_Date_Target__c</offsetFromField>
            <timeLength>180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>QIPP_Finding_Target_Completion_Date_was_Due_by_90_Days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Finding__c.Finding_Completion_Date_Target__c</offsetFromField>
            <timeLength>90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>QIPP Finding Target Completion Date is assigned</fullName>
        <actions>
            <name>QIPP_Finding_Target_Completion_Date_is_assigned</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Finding__c.Finding_Completion_Date_Target__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Finding__c.Finding_State__c</field>
            <operation>notEqual</operation>
            <value>Complete,Canceled</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QIPP New Finding Created</fullName>
        <actions>
            <name>QIPP_New_Finding_Created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Finding__c.Finding_Name__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>QIPP Target Completion Date 30 Days Before Reminder</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Finding__c.Finding_Completion_Date_Target__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Finding__c.Finding_State__c</field>
            <operation>notEqual</operation>
            <value>Complete,Canceled</value>
        </criteriaItems>
        <description>Send one reminder 30 days prior to the &quot;Target Completion Date&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>QIPP_Finding_30day_Reminder_for_Target_Completion_Date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Finding__c.Finding_Completion_Date_Target__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>QIPP Target Completion Date 5 days before Reminder</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Finding__c.Finding_Completion_Date_Target__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Finding__c.Finding_State__c</field>
            <operation>notEqual</operation>
            <value>Complete,Canceled</value>
        </criteriaItems>
        <description>Send one reminder 5 days prior to the &quot;Target Completion Date&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>QIPP_Finding_5_days_before_Reminder_for_Target_Completion_Date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Finding__c.Finding_Completion_Date_Target__c</offsetFromField>
            <timeLength>-5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
