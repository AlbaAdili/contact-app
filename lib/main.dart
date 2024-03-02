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

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Contact> filteredContacts = _contacts.where((contact) {
      // Check if contact name or phone number contains the search query
      return contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          contact.phoneNumber.contains(_searchQuery);
    }).toList();

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
        itemCount: filteredContacts.length,
        itemBuilder: (context, index) {
          final contact = filteredContacts[index];
          // Check if it's the first contact with this initial
          final bool isFirstContactWithInitial =
              index == 0 || contact.name[0] != filteredContacts[index - 1].name[0];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isFirstContactWithInitial)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    contact.name[0],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  // Navigate to detail page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactDetailScreen(contact),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(contact.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.call),
                        onPressed: () {
                          // Perform call action
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.message),
                        onPressed: () {
                          // Perform message action
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.video_call),
                        onPressed: () {
                          // Perform video call action
                        },
                      ),
                      Icon(Icons.info),
                    ],
                  ),
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contact.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Phone: ${contact.phoneNumber}',
              style: TextStyle(fontSize: 16),
            ),
            // Add more fields as needed (e.g., email, address, etc.)
          ],
        ),
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
