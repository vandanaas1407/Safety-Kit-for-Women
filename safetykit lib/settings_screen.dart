import 'package:flutter/material.dart';
import 'bluetooth_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.bluetooth),
            title: const Text("Connect to HC-05"),
            subtitle: const Text("Pair your wearable"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BluetoothScreen()),
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.security),
            title: Text("Privacy & Permissions"),
            subtitle: Text("Location, Bluetooth, Contacts"),
          ),
        ],
      ),
    );
  }
}
