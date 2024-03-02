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
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search contacts...',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                // Check if contact matches search query
                final bool isMatch = contact.name.toLowerCase().contains(_searchQuery.toLowerCase());
                // Only show contacts that match search query
                if (_searchQuery.isNotEmpty && !isMatch) {
                  return SizedBox.shrink(); // Return empty container if not a match
                }
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.phoneNumber),
                  onTap: () {
                    // Navigate to detail page
                  },
                );
              },
            ),
          ),
        ],
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