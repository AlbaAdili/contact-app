import 'package:flutter/material.dart';


void main() {
  runApp(ContactsApp());
}

class ContactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactsPage(),
    );
  }
}

class ContactDetailScreen extends StatelessWidget {
  final Contact contact;

  ContactDetailScreen(this.contact);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue, // You can customize the color
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        contact.name[0], // Initial letter of the contact's name
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      contact.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Phone: ${contact.phoneNumber}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.call, color: Colors.green),
                        onPressed: () {
                          // Perform call action
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.message, color: Colors.blue),
                        onPressed: () {
                          // Perform message action
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.video_call, color: Colors.red),
                        onPressed: () {
                          // Perform video call action
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Viber',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.videocam, color: Colors.purple),
                    onPressed: () {
                      // Perform Viber video call action
                    },
                  ),
                  Text(
                    'WhatsApp',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.video_call, color: Colors.green),
                    onPressed: () {
                      // Perform WhatsApp video call action
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle History button press
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[300]!),
                ),
                child: Text('History'),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle Storage locations button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300], // Grey background color
                ),
                child: Text('Storage locations'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  String _searchQuery = '';
  Contact? _selectedContact;

  @override
  Widget build(BuildContext context) {
    List<Contact> filteredContacts = _contacts.where((contact) {
      // Check if contact name or phone number contains the search query
      return contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          contact.phoneNumber.contains(_searchQuery);
    }).toList();

    // Group contacts by the first letter of their names
    Map<String, List<Contact>> groupedContacts = {};
    for (var contact in filteredContacts) {
      String firstLetter = contact.name[0].toUpperCase();
      groupedContacts.putIfAbsent(firstLetter, () => []);
      groupedContacts[firstLetter]!.add(contact);
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search contacts...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: groupedContacts.length,
        itemBuilder: (context, index) {
          String initialLetter = groupedContacts.keys.elementAt(index);
          List<Contact> contacts = groupedContacts[initialLetter]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  initialLetter,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedContact = contact;
                          });
                        },
                        child: ListTile(
                          title: Text(contact.name),
                        ),
                      ),
                      if (_selectedContact == contact) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Phone: ${contact.phoneNumber}',
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 40, // Increase icon size
                                    icon: Icon(Icons.call, color: Colors.green),
                                    onPressed: () {
                                      // Perform call action
                                    },
                                  ),
                                  IconButton(
                                    iconSize: 40, // Increase icon size
                                    icon: Icon(Icons.message, color: Colors.blue),
                                    onPressed: () {
                                      // Perform message action
                                    },
                                  ),
                                  IconButton(
                                    iconSize: 40, // Increase icon size
                                    icon: Icon(Icons.video_call, color: Colors.red),
                                    onPressed: () {
                                      // Perform video call action
                                    },
                                  ),
                                  IconButton(
                                    iconSize: 40, // Increase icon size
                                    icon: Icon(Icons.info, color: Colors.orange), // Information icon
                                    onPressed: () {
                                      // Navigate to detail page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ContactDetailScreen(_selectedContact!),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                      Divider(), // Add a divider between contacts
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

// Dummy contacts data for demonstration
class Contact {
  final String name;
  final String phoneNumber;

  Contact({required this.name, required this.phoneNumber});
}

List<Contact> _contacts = [
  Contact(name: 'Alba Adili', phoneNumber: '123-456-7890'),
  Contact(name: 'Mea Gjura', phoneNumber: '987-654-3210'),
  Contact(name: 'Ale Jakupi', phoneNumber: '555-555-5555'),
  Contact(name: 'Noa Guri', phoneNumber: '777-777-7777'),
];
