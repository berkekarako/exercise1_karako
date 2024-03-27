public class ContactHandler {
    @future
    public static void updateSecondaryContactPhonesAsync(List<Id> accountIds) {
        // Retrieve all contacts related to the accounts where a primary contact was set
        List<Contact> contactsToUpdate = [SELECT Id, AccountId, Primary_Contact_Phone__c
                                          FROM Contact
                                          WHERE AccountId IN :accountIds
                                          AND IsPrimaryContact__c != true];
        // Create a map to hold AccountId to PrimaryContactPhone
        Map<Id, String> accountToPrimaryPhone = new Map<Id, String>();

        // Get the primary contacts' phones and associate them with the account IDs
        for (Contact c : [SELECT Id, Phone, AccountId FROM Contact WHERE AccountId IN :accountIds AND IsPrimaryContact__c = true]) {
            accountToPrimaryPhone.put(c.AccountId, c.Phone);
        }
    }
}