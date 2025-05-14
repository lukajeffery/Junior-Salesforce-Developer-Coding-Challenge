@isTest
private class AccountContactManagerTest {

    @isTest
    static void testContactCreationAndMainContact() {
        // Create test Account
        AccountContactManager.Account acc = new AccountContactManager.Account();
        acc.accountName = 'Test Company';
        acc.accountNumber = 123;

        // Create Contacts
        AccountContactManager.Contact c1 = new AccountContactManager.Contact();
        c1.firstName = 'Alice';
        c1.lastName = 'Admin';
        c1.position = 'Administrative';
        c1.yearsOfService = 2;
        c1.id = Id.valueOf('003ABCDEF123456'); // Example ID

        AccountContactManager.Contact c2 = new AccountContactManager.Contact();
        c2.firstName = 'Bob';
        c2.lastName = 'Boss';
        c2.position = 'CEO';
        c2.yearsOfService = 1;
        c2.id = Id.valueOf('003GHIJKL123456'); // Example ID

        AccountContactManager.Contact c3 = new AccountContactManager.Contact();
        c3.firstName = 'Frank';
        c3.lastName = 'Finance';
        c3.position = 'Finance';
        c3.yearsOfService = 4;
        c3.id = Id.valueOf('003MNOPQR2123456'); // Example ID

        // Add contacts
        AccountContactManager.createContact(acc, c1);
        AccountContactManager.createContact(acc, c2);
        AccountContactManager.createContact(acc, c3);
        
        // Set main contact
        AccountContactManager.setMainContact(acc);
    }
}
