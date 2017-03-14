<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CPR_QUote_CLosed</fullName>
        <description>NQT CPR Quote Closed</description>
        <protected>false</protected>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_FE__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE_MSC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_QUOTE_CLOSED_Sales</template>
    </alerts>
    <alerts>
        <fullName>Determine_deadline</fullName>
        <description>Determine deadline</description>
        <protected>false</protected>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_FE__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE_MSC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_CPR_REVIEW_COMPLETE</template>
    </alerts>
    <alerts>
        <fullName>Email_sent_to_JR_when_SEMSC_is_assigned</fullName>
        <description>Email sent to JR when SEMSC is assigned</description>
        <protected>false</protected>
        <recipients>
            <recipient>chandra@atos.net.prod</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_SEMSC_Assigned_Email_JR</template>
    </alerts>
    <alerts>
        <fullName>NQT_CPR_Cancelled</fullName>
        <description>NQT CPR Cancelled</description>
        <protected>false</protected>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_FE__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE_MSC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_CPR_CANCELLED</template>
    </alerts>
    <alerts>
        <fullName>NQT_CPR_Submitted</fullName>
        <description>NQT CPR Submitted</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_CPR_SUBMITTED</template>
    </alerts>
    <alerts>
        <fullName>NQT_Customer_Hold_Email</fullName>
        <description>NQT Customer Hold Email</description>
        <protected>false</protected>
        <recipients>
            <recipient>NQTCustomer477711</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_CUSTOMER_HOLD</template>
    </alerts>
    <alerts>
        <fullName>NQT_EE_Rework</fullName>
        <description>NQT FE Rework</description>
        <protected>false</protected>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_FE__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_ENGINEERING_RE_WORK_FE</template>
    </alerts>
    <alerts>
        <fullName>NQT_FE_In_Review</fullName>
        <description>NQT FE In Review</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_CPR_IN_REVIEW_FE</template>
    </alerts>
    <alerts>
        <fullName>NQT_Project_Milestone</fullName>
        <description>NQT Project Milestone</description>
        <protected>false</protected>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_FE__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE_MSC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_Project_status_Engineering_Assigned</template>
    </alerts>
    <alerts>
        <fullName>NQT_Request_In_Review</fullName>
        <description>NQT Request In Review</description>
        <protected>false</protected>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_FE__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE_MSC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_Request_In_Review</template>
    </alerts>
    <alerts>
        <fullName>NQT_Review_Completed</fullName>
        <description>NQT Review Completed</description>
        <protected>false</protected>
        <recipients>
            <field>NQT_Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_Project_status_Engineering_Assigned</template>
    </alerts>
    <alerts>
        <fullName>NQT_Review_Request</fullName>
        <description>NQT Review Request</description>
        <protected>false</protected>
        <recipients>
            <field>NQT_FE__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE_MSC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_Request_In_Review</template>
    </alerts>
    <alerts>
        <fullName>NQT_SE_Deliverable</fullName>
        <description>NQT SE Deliverable</description>
        <protected>false</protected>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_ENGR_DELIVERABLE_COMPLETE_SE</template>
    </alerts>
    <alerts>
        <fullName>NQT_SE_In_Review</fullName>
        <description>NQT SE In Review</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_CPR_IN_REVIEW_SE</template>
    </alerts>
    <alerts>
        <fullName>NQT_SE_MSC_Deliverable</fullName>
        <description>NQT SE MSC Deliverable</description>
        <protected>false</protected>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE_MSC__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_ENGR_DELIVERABLE_COMPLETE_SE_MSC</template>
    </alerts>
    <alerts>
        <fullName>NQT_SE_MSC_In_Review</fullName>
        <description>NQT SE-MSC In Review</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_CPR_IN_REVIEW_SEMSC</template>
    </alerts>
    <alerts>
        <fullName>NQT_SE_MSC_Rework</fullName>
        <description>NQT SE MSC Rework</description>
        <protected>false</protected>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE_MSC__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_ENGINEERING_RE_WORK_SE_MSC</template>
    </alerts>
    <alerts>
        <fullName>NQT_SE_Rework</fullName>
        <description>NQT SE Rework</description>
        <protected>false</protected>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_ENGINEERING_RE_WORK_SE</template>
    </alerts>
    <alerts>
        <fullName>NQT_SFE_Deliverable</fullName>
        <description>NQT SFE Deliverable</description>
        <protected>false</protected>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_FE__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_ENGR_DELIVERABLE_COMPLETE_FE</template>
    </alerts>
    <alerts>
        <fullName>NQT_Sales_Deliverables_Completed</fullName>
        <description>NQT Sales Deliverables Completed</description>
        <protected>false</protected>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Business_Operations__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_FE__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Program_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE_MSC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_SE__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_Project_Status_Quote_Submitted</template>
    </alerts>
    <alerts>
        <fullName>NQT_Sales_Rework</fullName>
        <description>NQT Sales Rework</description>
        <protected>false</protected>
        <recipients>
            <field>NQT_Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>NQT_Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NQT_Email_templates/NQT_Sales_Rework</template>
    </alerts>
    <fieldUpdates>
        <fullName>CPR_Close_Date</fullName>
        <field>CPR_Close_Date__c</field>
        <formula>NOW()</formula>
        <name>CPR Close Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CPR_Lock_Reset</fullName>
        <description>CPR Lock Reset</description>
        <field>NQT_CPR_Lock__c</field>
        <literalValue>0</literalValue>
        <name>CPR Lock Reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CPR_Review_Completed_reset</fullName>
        <field>NQT_CPR_Review_Completed__c</field>
        <literalValue>0</literalValue>
        <name>CPR Review Completed reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Customer_Hold</fullName>
        <field>Customer_Hold__c</field>
        <literalValue>0</literalValue>
        <name>Customer Hold</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Customer_Hold_Checkbox</fullName>
        <field>Customer_Hold__c</field>
        <literalValue>1</literalValue>
        <name>Customer Hold Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Customer_Hold_Checkbox_Reset</fullName>
        <field>Customer_Hold__c</field>
        <literalValue>0</literalValue>
        <name>Customer Hold Checkbox Reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Deliverable_Status_Determine_deadlin</fullName>
        <field>NQT_Deliverable_Status__c</field>
        <literalValue>Determine Deadline</literalValue>
        <name>Deliverable Status-Determine deadlin</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Deliverable_status</fullName>
        <description>Deliverable status</description>
        <field>NQT_Deliverable_Status__c</field>
        <literalValue>Sales Deliverable</literalValue>
        <name>Deliverable status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Deliverable_status_Assign</fullName>
        <field>NQT_Deliverable_Status__c</field>
        <literalValue>Assign</literalValue>
        <name>Deliverable status-Assign</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Deliverable_status_Engineering_Assigned</fullName>
        <field>NQT_Deliverable_Status__c</field>
        <literalValue>Engineering Deliverable</literalValue>
        <name>Deliverable status-Engineering Assigned</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Determine_Deadline_Complete</fullName>
        <field>NQT_Project_Milestone_End__c</field>
        <literalValue>1</literalValue>
        <name>Determine Deadline Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Engineering_Assigned_Date</fullName>
        <field>Engineering_Assigned_Date__c</field>
        <formula>NOW()</formula>
        <name>Engineering Assigned Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Equipment</fullName>
        <description>Equipment ($)</description>
        <field>NQT_Equipment__c</field>
        <name>Equipment ($)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FE_Review_Comments</fullName>
        <description>FE Review Comments Reset</description>
        <field>NQT_FE_Review_Comments__c</field>
        <name>FE Review Comments</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FE_Review_Completed_reset</fullName>
        <field>FE_Review_Completed__c</field>
        <literalValue>0</literalValue>
        <name>FE Review Completed reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FE_Services</fullName>
        <description>FE Services ($)</description>
        <field>NQT_FE_Services__c</field>
        <name>FE Services ($)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>I_Agree</fullName>
        <description>I Agree</description>
        <field>NQT_I_Agree__c</field>
        <literalValue>0</literalValue>
        <name>I Agree</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>I_agree_to_the_completeness_of_CPR_FE</fullName>
        <description>I agree to the completeness of CPR FE Reset</description>
        <field>NQT_FE_agree_to_the_completeness_of_CPR__c</field>
        <name>I agree to the completeness of CPR FE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>I_agree_to_the_completeness_of_CPR_SE</fullName>
        <description>I agree to the completeness of CPR SE Reset</description>
        <field>NQT_SE_agree_to_the_completeness_of_CPR__c</field>
        <name>I agree to the completeness of CPR SE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>I_agree_to_the_completeness_of_CPR_SE_MS</fullName>
        <description>I agree to the completeness of CPR SE MSC Reset</description>
        <field>NQT_SEM_agree_to_the_completeness_of_CPR__c</field>
        <name>I agree to the completeness of CPR SE MS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Agree_with_Customer_Requested_Quote</fullName>
        <description>Agree with Customer Requested Quote Date</description>
        <field>NQT_Agree_with_Customer_Requested_Quote__c</field>
        <name>Agree with Customer Requested Quote Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_CPR_Lock</fullName>
        <description>NQT CPR Lock Reset</description>
        <field>NQT_CPR_Lock__c</field>
        <literalValue>0</literalValue>
        <name>NQT CPR Lock</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_CPR_Review_Completed</fullName>
        <description>NQT CPR Review Completed Reset</description>
        <field>NQT_CPR_Review_Completed__c</field>
        <literalValue>0</literalValue>
        <name>NQT CPR Review Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Deliver_Status_Customer_Hold</fullName>
        <description>NQT Deliverable Status-Customer Hold</description>
        <field>NQT_Deliverable_Status__c</field>
        <literalValue>Customer Hold</literalValue>
        <name>NQT Deliver Status-Customer Hold</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Deliver_Status_FE_Rework</fullName>
        <description>NQT Deliver Status-FE Rework</description>
        <field>NQT_Deliverable_Status__c</field>
        <literalValue>Engineering Deliverable</literalValue>
        <name>NQT Deliver Status-FE Rework</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Deliver_Status_SE_MSCRework</fullName>
        <description>NQT Deliver Status-SE-MSCRework</description>
        <field>NQT_Deliverable_Status__c</field>
        <literalValue>Engineering Deliverable</literalValue>
        <name>NQT Deliver Status-SE-MSCRework</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Deliver_Status_Waiting_For_PO</fullName>
        <description>NQT Deliver Status-Waiting For PO</description>
        <field>NQT_Deliverable_Status__c</field>
        <literalValue>Waiting For PO</literalValue>
        <name>NQT Deliver Status-Waiting For PO</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Deliverable_Status_Determine_deadlin</fullName>
        <field>NQT_Deliverable_Status__c</field>
        <literalValue>Determine Deadline</literalValue>
        <name>NQT Deliverable Status-Determine deadlin</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Deliverable_Status_SE_Rework</fullName>
        <description>NQT Deliverables Status-SE Rework(EA)</description>
        <field>NQT_Deliverable_Status__c</field>
        <literalValue>Engineering Deliverable</literalValue>
        <name>NQT Deliverable Status-SE Rework</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Deliverable_status</fullName>
        <field>NQT_Deliverable_Status__c</field>
        <literalValue>Assign</literalValue>
        <name>Deliverable status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Deliverable_status_In_review</fullName>
        <field>NQT_Deliverable_Status__c</field>
        <literalValue>In Review</literalValue>
        <name>Deliverable status-In review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Deliverable_status_Quote_Closed</fullName>
        <description>Deliverable status</description>
        <field>NQT_Deliverable_Status__c</field>
        <literalValue>Quote Closed</literalValue>
        <name>Deliverable status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_FE</fullName>
        <description>NQT FE Reset</description>
        <field>NQT_FE__c</field>
        <name>NQT FE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_FE_Assigned_Flag</fullName>
        <description>FE Assigned Flag</description>
        <field>NQT_FE_Assigned__c</field>
        <literalValue>0</literalValue>
        <name>FE Assigned Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_FE_Deadline</fullName>
        <description>FE Deadline Reset</description>
        <field>NQT_FE_Deadline__c</field>
        <name>FE Deadline</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_FE_Deliverable_Completed_Flag</fullName>
        <field>NQT_FE_Deliverables_Completed__c</field>
        <literalValue>1</literalValue>
        <name>NQT FE Deliverable Completed Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_FE_Deriverables_Completed_flag</fullName>
        <description>NQT FE Deriverables Completed flag</description>
        <field>NQT_FE_Deliverables_Completed__c</field>
        <literalValue>0</literalValue>
        <name>NQT FE Deriverables Completed flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_FE_Deriverables_Submitted</fullName>
        <description>NQT FE Deriverables Submitted Reset</description>
        <field>NQT_FE_Deliverables_submit__c</field>
        <literalValue>0</literalValue>
        <name>NQT FE Deriverables Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_FE_In_Review</fullName>
        <field>FE_Review_Completed__c</field>
        <literalValue>1</literalValue>
        <name>NQT FE In Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_FE_Review_Completed</fullName>
        <description>NQT FE Review Completed Reset</description>
        <field>FE_Review_Completed__c</field>
        <literalValue>0</literalValue>
        <name>NQT FE Review Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Field_Engineering</fullName>
        <description>NQT Field  Engineering</description>
        <field>NQT_Field_Engineering__c</field>
        <name>NQT Field  Engineering</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Has_the_CPR_been_Reviewed</fullName>
        <description>Has the CPR been Reviewed?</description>
        <field>NQT_Has_the_CPR_been_Reviewed__c</field>
        <name>Has the CPR been Reviewed?</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Is_the_CPR_Complete_and_Accurate</fullName>
        <description>Is the CPR Complete and Accurate? RESET</description>
        <field>NQT_Is_the_CPR_Complete_and_Accurate__c</field>
        <name>Is the CPR Complete and Accurate?</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Please_enter_Reason_for_SE_Rework</fullName>
        <description>Please enter Reason for SE Rework Reset</description>
        <field>NQT_Please_enter_Reason_for_SE_Rework__c</field>
        <name>Please enter Reason for SE Rework</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Delihverable_Complete_Flag</fullName>
        <description>NQT Project Deliverable Complete Flag</description>
        <field>NQT_Project_Deliverable_Complete__c</field>
        <literalValue>0</literalValue>
        <name>NQT Project Deliverable Complete Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Deliverable_Complete_Flag</fullName>
        <description>NQT Project Deliverable Complete Flag</description>
        <field>NQT_Project_Deliverable_Complete__c</field>
        <literalValue>0</literalValue>
        <name>NQT Project Deliverable Complete Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Deliverable_Complete_Reset</fullName>
        <field>NQT_Project_Deliverable_Complete__c</field>
        <literalValue>0</literalValue>
        <name>Project Deliverable Complete Reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Deliverable_Start</fullName>
        <field>NQT_Project_Deliverable_Start__c</field>
        <literalValue>1</literalValue>
        <name>Project Deliverable Start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Deliverable_Start_flag</fullName>
        <description>NQT Project Deliverable Start flag</description>
        <field>NQT_Project_Deliverable_Start__c</field>
        <literalValue>0</literalValue>
        <name>NQT Project Deliverable Start flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Deliverable_Start_reset</fullName>
        <field>NQT_Project_Deliverable_Start__c</field>
        <literalValue>0</literalValue>
        <name>Project Deliverable Start reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Desliverable_Start_flag</fullName>
        <description>NQT Project Deliverable Start flag</description>
        <field>NQT_Project_Deliverable_Start__c</field>
        <literalValue>0</literalValue>
        <name>NQT Project Deliverable Start flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Manager_Reset</fullName>
        <description>NQT Project Manager Reset</description>
        <field>NQT_Project_Manager__c</field>
        <name>NQT Project Manager Reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Milestone_Start</fullName>
        <field>NQT_Project_Milestone_Start__c</field>
        <literalValue>1</literalValue>
        <name>NQT Project Milestone Start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Milestone_Start_Reset</fullName>
        <description>NQT Project Milestone Start Reset</description>
        <field>NQT_Project_Milestone_Start__c</field>
        <literalValue>0</literalValue>
        <name>NQT Project Milestone Start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Status</fullName>
        <field>NQT_Project_Status__c</field>
        <literalValue>Request Submitted</literalValue>
        <name>Project status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Status_Customer_Hold</fullName>
        <description>NQT Deliverable Status-Customer Hold</description>
        <field>NQT_Project_Status__c</field>
        <literalValue>Customer Hold</literalValue>
        <name>NQT Project Status-Customer Hold</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Status_FE_Rework_EA</fullName>
        <description>NQT Project Status-FE Rework(EA)</description>
        <field>NQT_Project_Status__c</field>
        <literalValue>Engineering Assigned</literalValue>
        <name>NQT Project Status-FE Rework(EA)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Status_Quote_Submitted</fullName>
        <description>NQT Project Status-Quote Submitted</description>
        <field>NQT_Project_Status__c</field>
        <literalValue>Quote Submitted</literalValue>
        <name>NQT Project Status-Quote Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Status_SE_MSC_Rework_EA</fullName>
        <field>NQT_Project_Status__c</field>
        <literalValue>Engineering Assigned</literalValue>
        <name>NQT Project Status-SE-MSC Rework(EA)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Status_SE_Rework_EA</fullName>
        <description>NQT Project Status-SE Rework/Engineering Assigned</description>
        <field>NQT_Project_Status__c</field>
        <literalValue>Engineering Assigned</literalValue>
        <name>NQT Project Status-SE Rework(EA)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_Status_field_update</fullName>
        <field>NQT_Project_Status__c</field>
        <literalValue>Request Submitted</literalValue>
        <name>Project Status field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_status_Quote_CLosed</fullName>
        <description>Project status</description>
        <field>NQT_Project_Status__c</field>
        <literalValue>Quote Closed</literalValue>
        <name>Project status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Project_status_Request_In_Review</fullName>
        <field>NQT_Project_Status__c</field>
        <literalValue>Request In-Review</literalValue>
        <name>Project status-Request In Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Quote_Date</fullName>
        <field>Document_Quote_Date__c</field>
        <formula>Now()</formula>
        <name>NQT Quote Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Review_Completed</fullName>
        <field>NQT_CPR_Review_Completed__c</field>
        <literalValue>1</literalValue>
        <name>NQT Review Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Review_Deadline</fullName>
        <description>NQT Review Deadline</description>
        <field>NQT_Review_Deadline__c</field>
        <name>NQT Review Deadline</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE</fullName>
        <field>NQT_SE__c</field>
        <name>NQT SE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SEMSC_Deliverable_Submitted</fullName>
        <description>NQT SEMSC Deriverables Submitted</description>
        <field>NQT_SE_MSC_Deliverables_Submitted__c</field>
        <literalValue>0</literalValue>
        <name>NQT SEMSC Deliverable Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SEMSC_Deriverables_Completed_flag</fullName>
        <description>NQT SEMSC Deriverables Completed flag</description>
        <field>NQT_SE_MSC_Deliverables_Completed_Flag__c</field>
        <literalValue>0</literalValue>
        <name>NQT SEMSC Deriverables Completed flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE_Assigned_Flag</fullName>
        <description>SE Assigned Flag</description>
        <field>NQT_SE_Assigned__c</field>
        <literalValue>0</literalValue>
        <name>SE Assigned Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE_Deadline</fullName>
        <description>SE Deadline Reset</description>
        <field>NQT_SE_Deadline__c</field>
        <name>SE Deadline</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE_Deliverable_Completed_Flag</fullName>
        <description>NQT SE Deliverable Completed Flag</description>
        <field>NQT_SE_Deliverables_Completed__c</field>
        <literalValue>1</literalValue>
        <name>NQT SE Deliverable Completed Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE_Deliverables_Completed_Flag_Reset</fullName>
        <field>NQT_SE_Deliverables_Completed__c</field>
        <literalValue>0</literalValue>
        <name>SE Deliverables Completed Flag Reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE_Deriverables_Submitted</fullName>
        <description>NQT Sales Deriverables Submitted</description>
        <field>NQT_SE_Deliverables_Submitted__c</field>
        <literalValue>0</literalValue>
        <name>NQT SE Deriverables Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE_FE_SEMSC_DEliverableIn_Review</fullName>
        <description>NQT SE FE SEMSC DEliverable Check flag Reset</description>
        <field>NQT_SE_FE_SEMSC_Deliverable_Check__c</field>
        <formula>0</formula>
        <name>NQT SE FE SEMSC DEliverable Check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE_In_Review</fullName>
        <field>SE_Review_Completed__c</field>
        <literalValue>1</literalValue>
        <name>NQT SE In Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE_MSC</fullName>
        <description>NQT SE MSC Reset</description>
        <field>NQT_SE_MSC__c</field>
        <name>NQT SE MSC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE_MSC_Assigned_Flag</fullName>
        <description>SE MSC Assigned Flag</description>
        <field>NQT_SE_MSC_Assigned__c</field>
        <literalValue>0</literalValue>
        <name>SE MSC Assigned Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE_MSC_Deadline</fullName>
        <description>SE MSC Deadline Reset</description>
        <field>NQT_SE_MSC_Deadline__c</field>
        <name>SE MSC Deadline</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE_MSC_Deliverable_Completed_Flag</fullName>
        <field>NQT_SE_MSC_Deliverables_Completed_Flag__c</field>
        <literalValue>1</literalValue>
        <name>NQT SE MSC Deliverable Completed Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE_MSC_In_Review</fullName>
        <field>SE_MSC_Review_Completed__c</field>
        <literalValue>1</literalValue>
        <name>NQT SE MSC In Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE_MSC_Review_Completed</fullName>
        <description>NQT SE MSC Review Completed Reset</description>
        <field>SE_MSC_Review_Completed__c</field>
        <literalValue>0</literalValue>
        <name>NQT SE MSC Review Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE_Review_Comments</fullName>
        <description>SE Review Comments Reset</description>
        <field>NQT_SE_Review_Comments__c</field>
        <name>NQT SE Review Comments</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_SE_Review_Completed</fullName>
        <description>NSE Review Completed</description>
        <field>SE_Review_Completed__c</field>
        <literalValue>0</literalValue>
        <name>NSE Review Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Sales_Deadline_1</fullName>
        <description>Sales Deadline Reset</description>
        <field>NQT_Sales_Deadline__c</field>
        <name>Sales Deadline</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Sales_Deliverable_start</fullName>
        <field>NQT_Sales_Deliverable_Start__c</field>
        <literalValue>1</literalValue>
        <name>NQT Sales Deliverable start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Sales_Deliverables_end_True</fullName>
        <description>NQT Sales Deliverables end True</description>
        <field>NQT_Sales_Deliverable_End__c</field>
        <literalValue>1</literalValue>
        <name>NQT Sales Deliverables end True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Sales_Start_Flag</fullName>
        <field>NQT_Sales_Deliverable_Start__c</field>
        <literalValue>0</literalValue>
        <name>Sales Start Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Sales_Start_Flag_FE</fullName>
        <description>NQT Sales Start Flag</description>
        <field>NQT_Sales_Deliverable_Start__c</field>
        <literalValue>0</literalValue>
        <name>NQT Sales Start Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Sales_Start_Flag_SEMSC</fullName>
        <description>Sales Start Flag</description>
        <field>NQT_Sales_Deliverable_Start__c</field>
        <literalValue>0</literalValue>
        <name>Sales Start Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_System_Engineering</fullName>
        <description>NQT System  Engineering REset</description>
        <field>NQT_System_Engineering__c</field>
        <name>NQT System  Engineering</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_System_MSC_Engineering</fullName>
        <description>NQT System  MSC Engineering</description>
        <field>NQT_System_MSC_Engineering__c</field>
        <name>NQT System  MSC Engineering</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Team_Assignement_Completed</fullName>
        <field>NQT_Team_Assignment_Completed__c</field>
        <literalValue>1</literalValue>
        <name>Team Assignement Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Team_Assignement_Completed_Reset</fullName>
        <description>NQT Team Assignement Completed Reset</description>
        <field>NQT_Team_Assignment_Completed__c</field>
        <literalValue>0</literalValue>
        <name>NQT Team Assignement Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NQT_Team_Assignment_complete</fullName>
        <field>NQT_Team_Assignment_Completed__c</field>
        <literalValue>1</literalValue>
        <name>NQT Team Assignment complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Nqt_project</fullName>
        <field>NQT_Deliverable_Status__c</field>
        <literalValue>Determine Deadline</literalValue>
        <name>Nqt project</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Number_of_times_CPR_was_submitted</fullName>
        <field>of_Times_CPR_was_Resubmitted__c</field>
        <formula>of_Times_CPR_was_Resubmitted__c + 1</formula>
        <name>Number of times CPR was submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Please_enter_Reason_for_FE_Rework</fullName>
        <description>Please enter Reason for FE Rework</description>
        <field>NQT_Please_enter_Reason_for_FE_Rework__c</field>
        <name>Please enter Reason for FE Rework</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Please_enter_Reason_for_SE_MSC_Rework</fullName>
        <description>Please enter Reason for SE-MSC Rework</description>
        <field>NQT_Please_enter_Reason_for_SEMSC_Rework__c</field>
        <name>Please enter Reason for SE-MSC Rework</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Please_enter_Reason_for_Sales_Rework</fullName>
        <description>Please enter Reason for Sales Rework</description>
        <field>NQT_Please_enter_Reason_for_Sales_Rework__c</field>
        <name>Please enter Reason for Sales Rework</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Manager_Reset</fullName>
        <field>NQT_Project_Manager__c</field>
        <name>Project Manager Reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Milestone_Start_Reset</fullName>
        <field>NQT_Project_Milestone_Start__c</field>
        <literalValue>0</literalValue>
        <name>Project Milestone Start Reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Status</fullName>
        <description>Project Status</description>
        <field>NQT_Project_Status__c</field>
        <literalValue>Quote Generation</literalValue>
        <name>Project Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_status_Engineering_Assigned</fullName>
        <field>NQT_Project_Status__c</field>
        <literalValue>Engineering Assigned</literalValue>
        <name>Project status-Engineering Assigned</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_status_Quote_Expired</fullName>
        <description>Project status-Quote Expired</description>
        <field>NQT_Project_Status__c</field>
        <literalValue>Quote Expired</literalValue>
        <name>Project status-Quote Expired</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SEMSC_Review_completed_reset</fullName>
        <field>SE_MSC_Review_Completed__c</field>
        <literalValue>0</literalValue>
        <name>SEMSC Review completed reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SE_MSC_Review_Comments</fullName>
        <field>NQT_SE_MSC_Review_Comments__c</field>
        <name>SE MSC Review Comments</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SE_Review_completed_reset</fullName>
        <field>SE_Review_Completed__c</field>
        <literalValue>0</literalValue>
        <name>SE Review completed reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SE_Services</fullName>
        <description>SE Services ($)</description>
        <field>NQT_SE_Services__c</field>
        <name>SE Services ($)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sales_AM</fullName>
        <field>NQT_Sales_AM__c</field>
        <name>Sales-AM</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sales_Deliverable_End</fullName>
        <description>Sales Deliverable End Reset</description>
        <field>NQT_Sales_Deliverable_End__c</field>
        <literalValue>0</literalValue>
        <name>Sales Deliverable End</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sales_Deliverable_Start</fullName>
        <description>Sales Deliverable Start</description>
        <field>NQT_Sales_Deliverable_Start__c</field>
        <literalValue>0</literalValue>
        <name>Sales Deliverable Start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Team_Assignment_on_layout</fullName>
        <field>NQT_Team_Assignment_Complet__c</field>
        <literalValue>0</literalValue>
        <name>Team Assignment on layout</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Team_assignment_completed_Reset</fullName>
        <field>NQT_Team_Assignment_Completed__c</field>
        <literalValue>0</literalValue>
        <name>Team assignment completed Reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Workflow_Run_Check</fullName>
        <field>Workflow_Run__c</field>
        <literalValue>1</literalValue>
        <name>Workflow Run Check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Workflow_Run_Reset</fullName>
        <field>Workflow_Run__c</field>
        <literalValue>0</literalValue>
        <name>Workflow Run Reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>NQT CPR Cancelled</fullName>
        <actions>
            <name>NQT_CPR_Cancelled</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CPR__c.NQT_Project_Status__c</field>
            <operation>equals</operation>
            <value>Cancelled</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Deliverable_Status__c</field>
            <operation>equals</operation>
            <value>Cancelled</value>
        </criteriaItems>
        <description>Execute After CPR is Cancelled</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT CPR Closed</fullName>
        <actions>
            <name>CPR_QUote_CLosed</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>CPR_Close_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Deliverable_status_Quote_Closed</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_status_Quote_CLosed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4</booleanFilter>
        <criteriaItems>
            <field>CPR__c.NQT_Close_Project__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Sales_Deliverable_End__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Execute After Quote is Closed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>NQT CPR Lock</fullName>
        <actions>
            <name>NQT_CPR_Submitted</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>NQT_Deliverable_status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Number_of_times_CPR_was_submitted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Execute After CPR is Submitted.</description>
        <formula>AND(IF( ISBLANK(Reason_for_Customer_Hold__c), true, false),OR( ISPICKVAL( NQT_Project_Status__c , &apos;&apos;), ISPICKVAL( NQT_Project_Status__c , &apos;Customer Hold&apos;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT CPR Review Completed</fullName>
        <actions>
            <name>Determine_deadline</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Nqt_project</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6 AND 7 AND 8 AND 9 AND 10</booleanFilter>
        <criteriaItems>
            <field>CPR__c.NQT_Team_Assignment_Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Team_Assignment_Complet__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_CPR_Lock__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_CPR_Review_Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Project_Milestone_Start__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_FE_agree_to_the_completeness_of_CPR__c</field>
            <operation>equals</operation>
            <value>YES,NO</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_SEM_agree_to_the_completeness_of_CPR__c</field>
            <operation>equals</operation>
            <value>YES,NO</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_SE_agree_to_the_completeness_of_CPR__c</field>
            <operation>equals</operation>
            <value>YES,NO</value>
        </criteriaItems>
        <description>NQT CPR Review Completed</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT Customer Hold</fullName>
        <actions>
            <name>NQT_Customer_Hold_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>CPR_Review_Completed_reset</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>FE_Review_Completed_reset</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Deliver_Status_Customer_Hold</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_Deliverable_Start_reset</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_Status_Customer_Hold</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Manager_Reset</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Milestone_Start_Reset</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SEMSC_Review_completed_reset</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SE_Review_completed_reset</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Team_assignment_completed_Reset</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CPR__c.NQT_Is_the_CPR_Complete_and_Accurate__c</field>
            <operation>equals</operation>
            <value>NO</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Executed when PM is selected NO for  &quot;is the CPR Complete and Accurate?&quot; Under PM Review and Assign Project Milestones</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT Customer Hold Admin</fullName>
        <actions>
            <name>Customer_Hold</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>CPR__c.Customer_Hold__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>triggers when AM/PM puts CPR in hold</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT Customer Hold Checkbox</fullName>
        <actions>
            <name>Customer_Hold_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Workflow_Run_Check</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CPR__c.NQT_Project_Status__c</field>
            <operation>equals</operation>
            <value>Customer Hold</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.Workflow_Run__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.Customer_Hold__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT Customer Hold1</fullName>
        <actions>
            <name>FE_Review_Comments</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>I_agree_to_the_completeness_of_CPR_FE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>I_agree_to_the_completeness_of_CPR_SE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>I_agree_to_the_completeness_of_CPR_SE_MS</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_FE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Review_Deadline</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_SE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_SE_MSC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_SE_Review_Comments</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SE_MSC_Review_Comments</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CPR__c.NQT_Is_the_CPR_Complete_and_Accurate__c</field>
            <operation>equals</operation>
            <value>NO</value>
        </criteriaItems>
        <description>Executed when PM is selected NO for  &quot;is the CPR Complete and Accurate?&quot; Under PM Review and Assign Project Milestones</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT Customer Hold2</fullName>
        <actions>
            <name>CPR_Lock_Reset</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Agree_with_Customer_Requested_Quote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_FE_Deadline</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Has_the_CPR_been_Reviewed</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Is_the_CPR_Complete_and_Accurate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_SE_Assigned_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_SE_Deadline</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_SE_MSC_Deadline</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Sales_Deadline_1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CPR__c.NQT_Is_the_CPR_Complete_and_Accurate__c</field>
            <operation>equals</operation>
            <value>NO</value>
        </criteriaItems>
        <description>Executed when PM is selected NO for  &quot;is the CPR Complete and Accurate?&quot; Under PM Review and Assign Project Milestones</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT Customer Hold3</fullName>
        <actions>
            <name>NQT_FE_Assigned_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_SE_FE_SEMSC_DEliverableIn_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_SE_MSC_Assigned_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Team_Assignment_on_layout</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CPR__c.NQT_Is_the_CPR_Complete_and_Accurate__c</field>
            <operation>equals</operation>
            <value>NO</value>
        </criteriaItems>
        <description>Executed when PM is selected NO for  &quot;is the CPR Complete and Accurate?&quot; Under PM Review and Assign Project Milestones</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT FE Deliverable</fullName>
        <actions>
            <name>NQT_SFE_Deliverable</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>NQT_FE_Deliverable_Completed_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CPR__c.NQT_FE_Deliverables_submit__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Project_Milestone_End__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_FE_Deliverables_Completed__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Execute When FE Deliverable Completed</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT FE In Review</fullName>
        <actions>
            <name>NQT_FE_In_Review</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>NQT_FE_In_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>CPR__c.NQT_FE_agree_to_the_completeness_of_CPR__c</field>
            <operation>equals</operation>
            <value>YES,NO</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_FE__c</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Team_Assignment_Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.FE_Review_Completed__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Executes when FE Review Completed</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT FE Rework</fullName>
        <actions>
            <name>NQT_EE_Rework</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>NQT_Deliver_Status_FE_Rework</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_FE_Deriverables_Completed_flag</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_FE_Deriverables_Submitted</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Field_Engineering</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_Deliverable_Complete_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_Deliverable_Start_flag</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_Status_FE_Rework_EA</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Sales_Start_Flag_FE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Please_enter_Reason_for_FE_Rework</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6 AND 7</booleanFilter>
        <criteriaItems>
            <field>CPR__c.NQT_Field_Engineering__c</field>
            <operation>equals</operation>
            <value>YES</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Sales_Deliverable_Start__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_FE__c</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_FE_agree_to_the_completeness_of_CPR__c</field>
            <operation>equals</operation>
            <value>YES,NO</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_FE_Deliverables_submit__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Execute When FE Deliverable assign to any Rework.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT MSC assigned Email to JR</fullName>
        <actions>
            <name>Email_sent_to_JR_when_SEMSC_is_assigned</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>CPR__c.NQT_CPR_Lock__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Team_Assignment_Completed__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Team_Assignment_Complet__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_SE_MSC_Assigned__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>When a SEMSC is assigned then an email is sent to JR.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT Project Milestone</fullName>
        <actions>
            <name>NQT_Project_Milestone</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Deliverable_status_Engineering_Assigned</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Determine_Deadline_Complete</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Engineering_Assigned_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_Deliverable_Start</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_status_Engineering_Assigned</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6 AND 7</booleanFilter>
        <criteriaItems>
            <field>CPR__c.NQT_CPR_Review_Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Project_Milestone_Start__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Project_Milestone_End__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Has_the_CPR_been_Reviewed__c</field>
            <operation>equals</operation>
            <value>YES,NO</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Has_the_CPR_been_Reviewed__c</field>
            <operation>equals</operation>
            <value>YES,NO</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Executes After CPR review is completed(It means SE, SE-MSC, FE completed their Reviews).</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT Request In Review</fullName>
        <actions>
            <name>NQT_Request_In_Review</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>NQT_Deliverable_status_In_review</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_status_Request_In_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Team_Assignement_Completed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5</booleanFilter>
        <criteriaItems>
            <field>CPR__c.NQT_CPR_Lock__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Team_Assignment_Completed__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Team_Assignment_Complet__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Execute After Team Assignment</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT Request Submitted</fullName>
        <actions>
            <name>NQT_CPR_Submitted</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>CPR__c.NQT_CPR_Lock__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Execute After CPR Submission</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT SE  MSC Deliverable</fullName>
        <actions>
            <name>NQT_SE_MSC_Deliverable</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>NQT_SE_MSC_Deliverable_Completed_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CPR__c.NQT_SE_MSC_Deliverables_Submitted__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Project_Milestone_End__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_SE_MSC_Deliverables_Completed_Flag__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Execute After SE-MSC Deliverable is Completed</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT SE Deliverable</fullName>
        <actions>
            <name>NQT_SE_Deliverable</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>NQT_SE_Deliverable_Completed_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CPR__c.NQT_Project_Milestone_End__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_SE_Deliverables_Submitted__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_SE_Deliverables_Completed__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Execute After SE-MSC Deliverable is Completed</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT SE In Review</fullName>
        <actions>
            <name>NQT_SE_In_Review</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>NQT_SE_In_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>CPR__c.NQT_SE_agree_to_the_completeness_of_CPR__c</field>
            <operation>equals</operation>
            <value>YES,NO</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Team_Assignment_Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_SE__c</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.SE_Review_Completed__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Executes when SE Review is Completed</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT SE MSC In Review</fullName>
        <actions>
            <name>NQT_SE_MSC_In_Review</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>NQT_SE_MSC_In_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>CPR__c.NQT_SEM_agree_to_the_completeness_of_CPR__c</field>
            <operation>equals</operation>
            <value>YES,NO</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Team_Assignment_Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_SE_MSC__c</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.SE_MSC_Review_Completed__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Executes when SE-MSC Review is Completed</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT SE Rework</fullName>
        <actions>
            <name>NQT_SE_Rework</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>NQT_Deliverable_Status_SE_Rework</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Please_enter_Reason_for_SE_Rework</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_Deliverable_Complete_Reset</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_Deliverable_Start_reset</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_Status_SE_Rework_EA</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_SE_Deliverables_Completed_Flag_Reset</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_SE_Deriverables_Submitted</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Sales_Start_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_System_Engineering</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6 AND 7</booleanFilter>
        <criteriaItems>
            <field>CPR__c.NQT_System_Engineering__c</field>
            <operation>equals</operation>
            <value>YES</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Sales_Deliverable_Start__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_SE__c</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_SE_agree_to_the_completeness_of_CPR__c</field>
            <operation>equals</operation>
            <value>YES,NO</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_SE_Deliverables_Submitted__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Execute When SE Deliverable assign to any Rework.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT SE-MSC Rework</fullName>
        <actions>
            <name>NQT_SE_MSC_Rework</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>NQT_Deliver_Status_SE_MSCRework</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_Delihverable_Complete_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_Desliverable_Start_flag</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_Status_SE_MSC_Rework_EA</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_SEMSC_Deliverable_Submitted</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_SEMSC_Deriverables_Completed_flag</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Sales_Start_Flag_SEMSC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_System_MSC_Engineering</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Please_enter_Reason_for_SE_MSC_Rework</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6 AND 7</booleanFilter>
        <criteriaItems>
            <field>CPR__c.NQT_System_MSC_Engineering__c</field>
            <operation>equals</operation>
            <value>YES</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Sales_Deliverable_Start__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_SE_MSC__c</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_SEM_agree_to_the_completeness_of_CPR__c</field>
            <operation>equals</operation>
            <value>YES,NO</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_SE_MSC_Deliverables_Submitted__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Execute When SE-MSC Deliverable assign to any Rework.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT Sales Deliverables</fullName>
        <actions>
            <name>NQT_Sales_Deliverables_Completed</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>NQT_Deliver_Status_Waiting_For_PO</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Project_Status_Quote_Submitted</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Quote_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>NQT_Sales_Deliverables_end_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6 AND 7 AND 8</booleanFilter>
        <criteriaItems>
            <field>CPR__c.NQT_Project_Deliverable_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Sales_Deliverable_Start__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Sales_Deliverable_End__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Field_Engineering__c</field>
            <operation>notEqual</operation>
            <value>YES</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_System_Engineering__c</field>
            <operation>notEqual</operation>
            <value>YES</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_System_MSC_Engineering__c</field>
            <operation>notEqual</operation>
            <value>YES</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Execute After Sales Deliverable is Completed</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT Sales Rework</fullName>
        <actions>
            <name>NQT_Sales_Rework</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Deliverable_status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Equipment</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>FE_Services</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>I_Agree</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Please_enter_Reason_for_Sales_Rework</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SE_Services</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Sales_AM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Sales_Deliverable_End</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Sales_Deliverable_Start</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6 AND 7</booleanFilter>
        <criteriaItems>
            <field>CPR__c.NQT_Deliverable_Status__c</field>
            <operation>equals</operation>
            <value>Waiting For PO</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Project_Status__c</field>
            <operation>equals</operation>
            <value>Quote Submitted</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Sales_Deliverable_End__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Sales_AM__c</field>
            <operation>equals</operation>
            <value>YES</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_I_Agree__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_After__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>CPR__c.NQT_Class_Access_Before__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Execute When Sales Deliverable assign to any Rework.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NQT Workflow Run Checkbox</fullName>
        <actions>
            <name>Workflow_Run_Reset</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CPR__c.Workflow_Run__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
