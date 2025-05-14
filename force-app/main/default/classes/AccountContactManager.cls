public with sharing class AccountContactManager {

    // Wrapper classes to simulate tables
    public class Account {
        public String accountName;
        public Integer accountNumber;
        public Id mainContact; // Holds the ID of the main contact
        public Integer totalContacts = 0;
        public Integer financeContacts = 0;
        public List<Contact> contacts = new List<Contact>(); // Holds the list of contacts
    }
    
    public class Contact {
        public String firstName; 
        public String lastName;
        public String salutation;
        public String position; 
        public Integer yearsOfService;
        public Id id;
    }

    // Create and add a new contact to the account
    public static void createContact(Account acc, Contact newContact) {
        acc.contacts.add(newContact);
        acc.totalContacts++;
        if (newContact.position == 'Finance') {
            acc.financeContacts++;
        }
    }

    // Set the main contact based on position and seniority
    public static void setMainContact(Account acc) {
        if (acc.contacts.isEmpty()) return;
        Map<String, Integer> positionRank = new Map<String, Integer>{ // Creating a map to rank positions
            'CEO' => 1,
            'Operational Manager' => 2,
            'Finance' => 3,
            'Administrative' => 4
        };
    
        Contact main = acc.contacts[0];
        for (Contact c : acc.contacts) {
            Boolean isHigher = false;
            if (positionRank.get(c.position) < positionRank.get(main.position)) { // Check if the current contact's position is higher
                isHigher = true;
            } else if (positionRank.get(c.position) == positionRank.get(main.position)) { // If positions are equal, check years of service
                if (c.yearsOfService > main.yearsOfService) {
                    isHigher = true;
                }
            }
            if (isHigher) { 
                main = c;
            }
        }

        acc.mainContact = main.id; 
    }
}
