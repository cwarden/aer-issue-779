@IsTest
private class Repro07_OrgDefaultsAfterTestSetup {
    // Salesforce (observed in test runs): a test method can insert hierarchy custom setting org
    // defaults even though @TestSetup already inserted them; no DUPLICATE_VALUE.
    @TestSetup
    static void setup() {
        insert new Repro_Setting__c(SetupOwnerId = UserInfo.getOrganizationId(), Value__c = 'setup');
    }

    @IsTest
    static void secondOrgDefaultInsertIsAllowed() {
        insert new Repro_Setting__c(SetupOwnerId = UserInfo.getOrganizationId(), Value__c = 'test');
        Assert.isNotNull(Repro_Setting__c.getOrgDefaults());
    }
}
