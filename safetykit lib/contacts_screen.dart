import 'package:flutter/material.dart';
import '../services/contacts_service.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _controller = TextEditingController();
  List<String> _contacts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    await ContactsService.instance.init();
    setState(() {
      _contacts = ContactsService.instance.getContacts();
      _loading = false;
    });
  }

  Future<void> _addContact() async {
    final v = _controller.text.trim();
    if (v.isNotEmpty) {
      await ContactsService.instance.addContact(v);
      _controller.clear();
      _loadContacts();
    }
  }

  Future<void> _removeContact(String number) async {
    await ContactsService.instance.removeContact(number);
    _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Emergency Contacts")),
      body: Column(
        children: [
          Expanded(
            child: _contacts.isEmpty
                ? const Center(child: Text("No contacts added yet"))
                : ListView.separated(
                    itemCount: _contacts.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) => ListTile(
                      leading: const Icon(Icons.phone),
                      title: Text(_contacts[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _removeContact(_contacts[index]),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "Add Contact (phone)",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addContact(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                  onPressed: _addContact,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
