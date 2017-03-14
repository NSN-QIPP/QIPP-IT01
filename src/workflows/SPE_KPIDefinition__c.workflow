<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>SPE_KPIReminderEmailAlert</fullName>
        <description>SPE_KPIReminderEmailAlert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>spe.admin@nokia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>SPE_ScorecardTool/SPE_KPIReminderEmail</template>
    </alerts>
    <fieldUpdates>
        <fullName>KPI_Draft_pilot</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Draft_and_Pilot</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>KPI Draft-pilot</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SPE2_KPI_Next_Schedule_Date</fullName>
        <description>SPE2 KPI Next Schedule Date for PI = KPI</description>
        <field>ScheduledDate__c</field>
        <formula>PI_Data__r.PIUploadDuedate__c</formula>
        <name>SPE2 KPI Next Schedule Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SPE_KPIDraft_Version</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Draft_and_Pilot_Version</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>SPE_KPIDraft Version</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SPE_KPIObsolete</fullName>
        <description>change field update when the lifecycle stage is Obsolete</description>
        <field>RecordTypeId</field>
        <lookupValue>Obsolete</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>SPE_KPIObsolete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SPE_KPIPublished</fullName>
        <description>Change the record type when the Lifecycle stage is published</description>
        <field>RecordTypeId</field>
        <lookupValue>Published</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>SPE_KPIPublished</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SPE_KPIPublished_Version</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Published_Version</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>SPE_KPIPublished Version</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SPE2 KPI Next Schedule Date Calculation</fullName>
        <actions>
            <name>SPE2_KPI_Next_Schedule_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Next Schedule Date population in case of PI=KPI</description>
        <formula>NOT(ISBLANK(PI_Data__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SPE_KPI next schedule date notification</fullName>
        <active>true</active>
        <description>SPE_KPI next schedule date notification for pi values upload</description>
        <formula>ScheduledDate__c =today()+7</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>SPE_KPIReminderEmailAlert</name>
                <type>Alert</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SPE_KPIDraft Version</fullName>
        <actions>
            <name>SPE_KPIDraft_Version</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>SPE_KPIDefinition__c.VerNumber__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>SPE_KPIDefinition__c.LifecycleStage__c</field>
            <operation>equals</operation>
            <value>Draft,Pilot</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SPE_KPIDraft-Pilot</fullName>
        <actions>
            <name>KPI_Draft_pilot</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SPE_KPIDefinition__c.LifecycleStage__c</field>
            <operation>equals</operation>
            <value>Draft,Pilot</value>
        </criteriaItems>
        <criteriaItems>
            <field>SPE_KPIDefinition__c.VerNumber__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <description>Change record type to published if the lifecycle stage is published</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SPE_KPIObsolete</fullName>
        <actions>
            <name>SPE_KPIObsolete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SPE_KPIDefinition__c.LifecycleStage__c</field>
            <operation>equals</operation>
            <value>Obsolete</value>
        </criteriaItems>
        <description>Change record type to published if the lifecycle stage is Obsolete</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SPE_KPIPublished</fullName>
        <actions>
            <name>SPE_KPIPublished</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SPE_KPIDefinition__c.LifecycleStage__c</field>
            <operation>equals</operation>
            <value>Published</value>
        </criteriaItems>
        <criteriaItems>
            <field>SPE_KPIDefinition__c.VerNumber__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <description>Change record type to published if the lifecycle stage is published</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SPE_KPIPublished Version</fullName>
        <actions>
            <name>SPE_KPIPublished_Version</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>SPE_KPIDefinition__c.VerNumber__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>SPE_KPIDefinition__c.LifecycleStage__c</field>
            <operation>equals</operation>
            <value>Published</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
