<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Push_Count_Update</fullName>
        <field>Push_Count__c</field>
        <formula>Push_Count__c + 1</formula>
        <name>Push Count Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Push Count Update</fullName>
        <actions>
            <name>Push_Count_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED(CloseDate),CloseDate &gt;  PRIORVALUE(CloseDate))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>test33</fullName>
        <active>false</active>
        <formula>true</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
