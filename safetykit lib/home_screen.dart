import 'package:flutter/material.dart';
import '../services/sms_service.dart';
import '../services/incidents_service.dart';
import '../services/contacts_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _triggerSOS(BuildContext context) async {
    final contacts = ContactsService.instance.getContacts();

    if (contacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ No contacts added!")),
      );
      return;
    }

    // 🚨 Send SMS to all contacts at once
    await SMSService.instance.sendBulkSMS(
      "🚨 Emergency! I need help! My location: Simulated",
      contacts,
    );

    // Add incident logs
    await IncidentsService.instance.triggerSOS(contacts, simulate: true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("🚨 SOS sent to ${contacts.length} contact(s)!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SafetyKit")),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            shape: const CircleBorder(),
          ),
          onPressed: () => _triggerSOS(context),
          child: const Text(
            "SOS",
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
