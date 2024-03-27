trigger UpdatePrimaryContactPhone on Contact (after insert, after update) {
    List<Id> accountIdsToUpdate = new List<Id>();
    
    for (Contact c : Trigger.new) {
        if (c.IsPrimaryContact__c == true) {
            accountIdsToUpdate.add(c.AccountId);
        }
    }

    if (!accountIdsToUpdate.isEmpty()) {
        ContactHandler.updateSecondaryContactPhonesAsync(accountIdsToUpdate);
    }
}