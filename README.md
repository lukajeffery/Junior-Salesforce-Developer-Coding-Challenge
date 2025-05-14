# Junior Salesforce Developer Coding Challenge

Below is an explanation of how I have completed this challenge.

# Creating a contact
When a `Contact` is created using `createContact()`, the following happens:
``` apex
// Create and add a new contact to the account
    public static void createContact(Account acc, Contact newContact) {
        acc.contacts.add(newContact);
        acc.totalContacts++;
        if (newContact.position == 'Finance') {
            acc.financeContacts++;
        }
    }
```
- The `Contact` is added to the `Account`'s contact list
- The `totalContacts` field on the `Account` is incremented
- If the contact's position is 'Finance', the `financeContacts` field is also incremeneted

# Setting the main contact
The `setMainContact()` method selects the contact with the highest position:
``` apex
 // Set the main contact based on position and seniority
    public static void setMainContact(Account acct) {
        if (acct.contacts.isEmpty()) return;
        Map<String, Integer> positionRank = new Map<String, Integer>{ // Creating a map to rank positions
            'CEO' => 1,
            'Operational Manager' => 2,
            'Finance' => 3,
            'Administrative' => 4
        };
    
        Contact main = acct.contacts[0];
        for (Contact c : acct.contacts) {
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

        acct.mainContact = main.id; 
    }
```
- The position is a set hierarchy ( CEO > Operational Manager > Finance > Administrative )
- If two contacts have the same position, years of service is used to determine the main contact
- The chosen contact's ID is then set as the `mainContact` field on the `Account`

# Design choices
This section explains why I have opted for one implementation over another.
- Wrapper classes:
  ``` apex
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
  ```
  Wrapper classes were used for `Account` and `Contact` instead of real Salesforce SObjects for simplicity and so the code could be tested without connecting to an org.
- Position ranking:
  ``` apex
  Map<String, Integer> positionRank = new Map<String, Integer>{ // Creating a map to rank positions
            'CEO' => 1,
            'Operational Manager' => 2,
            'Finance' => 3,
            'Administrative' => 4
  ```
  The hierarchy of positions used for determining the main contact is handled using a `Map<String, Integer>` instead of a list to make readability easy and any changes or additional positions can be easily added. 
- Manual ID assignment
  ``` apex
  c1.id = Id.valueOf('003ABCDEF123456'); // Example ID
  ```
  In the test class, contact IDs are assigned manually rather than using real Salesforce record IDs. This is also done for simplicity, so that no actual records need to be added to a database to test the code.

