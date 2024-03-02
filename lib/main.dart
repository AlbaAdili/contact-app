import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


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
      body: Column(
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
                    color: Colors.blue,
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
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.message, color: Colors.blue),
                      onPressed: () {
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.video_call, color: Colors.red),
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Viber',
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.videocam, color: Colors.purple),
                      onPressed: () {
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'WhatsApp',
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.video_call, color: Colors.green),
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[300]!),
                  ),
                  child: Text('History'),
                ),
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    backgroundColor: Colors.grey[300],
                  ),
                  child: Text('Storage locations'),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.favorite),
                    Text('Favorites'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.edit),
                    Text('Edit'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.share),
                    Text('Share'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.more_vert),
                    Text('More'),
                  ],
                ),
              ],
            ),
          ),
        ],
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
    // Filter contacts based on search query
    List<Contact> filteredContacts = _contacts.where((contact) {
      // Check if contact name or phone number contains the search query
      return contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          contact.phoneNumber.contains(_searchQuery);
    }).toList();

    // Group filtered contacts by the first letter of their names
    Map<String, List<Contact>> groupedContacts = {};
    for (var contact in filteredContacts) {
      String firstLetter = contact.name[0].toUpperCase();
      groupedContacts.putIfAbsent(firstLetter, () => []);
      groupedContacts[firstLetter]!.add(contact);
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
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
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: groupedContacts.length,
        itemBuilder: (context, index) {
          String initialLetter = groupedContacts.keys.elementAt(index);
          List<Contact> contacts = groupedContacts[initialLetter]!;
          Color circleColor = contacts.first.circleColor;

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
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: circleColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                contact.name[0], // Initial letter of the contact's name
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
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
                                    iconSize: 40,
                                    icon: Icon(Icons.call, color: Colors.green),
                                    onPressed: () {

                                    },
                                  ),
                                  IconButton(
                                    iconSize: 40,
                                    icon: Icon(Icons.message, color: Colors.blue),
                                    onPressed: () {

                                    },
                                  ),
                                  IconButton(
                                    iconSize: 40,
                                    icon: Icon(Icons.video_call, color: Colors.red),
                                    onPressed: () {

                                    },
                                  ),
                                  IconButton(
                                    iconSize: 40,
                                    icon: Icon(Icons.info, color: Colors.orange),
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
                      Divider(),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.keyboard),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class Contact {
  final String name;
  final String phoneNumber;
  final Color circleColor;

  Contact({required this.name, required this.phoneNumber, required this.circleColor});
}

List<Contact> _contacts = [
  Contact(name: 'Alba Adili', phoneNumber: '123-456-7890',circleColor: Colors.blue),
  Contact(name: 'Mea Gjura', phoneNumber: '987-654-3210',circleColor: Colors.pink),
  Contact(name: 'Ale Jakupi', phoneNumber: '555-555-5555',circleColor: Colors.blue),
  Contact(name: 'Noa Guri', phoneNumber: '777-777-7777',circleColor: Colors.green),
];
