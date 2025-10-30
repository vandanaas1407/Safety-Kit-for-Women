import 'package:flutter/material.dart';

class BluetoothScreen extends StatelessWidget {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bluetooth (HC-05)")),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("Not connected"),
            subtitle: Text("Tap 'Scan' (below) after we enable Bluetooth plugin."),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.bluetooth_searching),
            title: Text("Scan for devices"),
            subtitle: Text("Will show HC-05 here (coming next step)"),
          ),
        ],
      ),
    );
  }
}
