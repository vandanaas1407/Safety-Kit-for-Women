import 'package:flutter/material.dart';
import '../models/incident.dart';
import '../services/incidents_service.dart';

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SOS Logs")),
      body: StreamBuilder<List<Incident>>(
        stream: IncidentsService.instance.stream,
        builder: (context, snapshot) {
          final items = snapshot.data ?? const <Incident>[];
          if (items.isEmpty) {
            return const Center(child: Text("No incidents yet"));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final e = items[i];
              return ListTile(
                leading: const Icon(Icons.warning, color: Colors.red),
                title: Text("SOS from ${e.phone}"),
                subtitle: Text(
                  "Lat: ${e.lat}, Lng: ${e.lng}\n${e.timestamp.toLocal()}",
                ),
                isThreeLine: true,
              );
            },
          );
        },
      ),
    );
  }
}
