<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Compatibility_Milestone_Review_Approval_Request</fullName>
        <description>Compatibility Milestone Review - Approval Request</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Approver_Compatibility_Milestone__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Compatibility_Milestone_Review_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>Compatibility_Milestone_Review_Approved</fullName>
        <description>Compatibility Milestone Review - Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Compatibility_Milestone_Review_Approved</template>
    </alerts>
    <alerts>
        <fullName>Compatibility_Milestone_Review_Rejected</fullName>
        <description>Compatibility Milestone Review - Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Compatibility_Milestone_Review_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Compatibility_Milestone_Appr_Required</fullName>
        <description>Update Approval State to Approval Required</description>
        <field>Approval_State__c</field>
        <literalValue>Approval required, please click ‘Submit for Approval’ button below</literalValue>
        <name>Compatibility Milestone - Appr Required</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Compatibility_Milestone_Approval_Date</fullName>
        <description>Update &quot;Approval Date&quot; for Compatibility Milestone Review</description>
        <field>Approval_Date__c</field>
        <formula>TODAY()</formula>
        <name>Compatibility Milestone - Approval Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Compatibility_Milestone_NOT_Required</fullName>
        <description>Update &quot;Approval State&quot; when Review Result is - Draft or Open</description>
        <field>Approval_State__c</field>
        <name>Compatibility Milestone - NOT Required</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Compatibility_Milestone_Review_Approved</fullName>
        <description>Update &quot;Approval State&quot; to - Approved - for Compatibility Milestone Review object</description>
        <field>Approval_State__c</field>
        <literalValue>Approved</literalValue>
        <name>Compatibility Milestone Review- Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Compatibility_Milestone_Review_Pending</fullName>
        <description>Update &quot;Approval State&quot; to - Pending for Approval - for Compatibility Milestone Review object</description>
        <field>Approval_State__c</field>
        <literalValue>Pending for Approval</literalValue>
        <name>Compatibility Milestone Review- Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Compatibility_Milestone_Review_Recalled</fullName>
        <description>Update &quot;Approval State&quot; to - None - for Compatibility Milestone Review object</description>
        <field>Approval_State__c</field>
        <name>Compatibility Milestone Review- Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Compatibility_Milestone_Review_Rejected</fullName>
        <description>Update &quot;Approval State&quot; to - Rejected - for Compatibility Milestone Review object</description>
        <field>Approval_State__c</field>
        <literalValue>Rejected</literalValue>
        <name>Compatibility Milestone Review- Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Compatibility Milestone Review - Approval NOT Required</fullName>
        <actions>
            <name>Compatibility_Milestone_NOT_Required</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Compatibility_Milestone_Review__c.Review_State__c</field>
            <operation>equals</operation>
            <value>Draft,Open</value>
        </criteriaItems>
        <criteriaItems>
            <field>Compatibility_Milestone_Review__c.Approval_State__c</field>
            <operation>notEqual</operation>
            <value>Approved,Rejected</value>
        </criteriaItems>
        <description>Update &quot;Approval State&quot; when Review Result (Review State) is - Draft or Open</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Compatibility Milestone Review - Approval Required</fullName>
        <actions>
            <name>Compatibility_Milestone_Appr_Required</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Compatibility_Milestone_Review__c.Review_State__c</field>
            <operation>equals</operation>
            <value>Finalized,Irrelevant,Business Decision</value>
        </criteriaItems>
        <criteriaItems>
            <field>Compatibility_Milestone_Review__c.Approval_State__c</field>
            <operation>notEqual</operation>
            <value>Approved,Rejected</value>
        </criteriaItems>
        <description>Update &quot;Approval State&quot; when Review Result (Review State) is - Final, Irrelevant or Business Decision</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
