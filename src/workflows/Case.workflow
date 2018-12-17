<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>X1_hour_warning_before_milestone_expires</fullName>
        <description>1 hour warning before milestone expires.</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SupportEscalatedCaseNotification</template>
    </alerts>
    <outboundMessages>
        <fullName>TESTCASE</fullName>
        <apiVersion>40.0</apiVersion>
        <endpointUrl>https://suresh.com</endpointUrl>
        <fields>AccountId</fields>
        <fields>ContactEmail</fields>
        <fields>Id</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>pocsalesforce@sfdc.com</integrationUser>
        <name>TESTCASE</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
</Workflow>
