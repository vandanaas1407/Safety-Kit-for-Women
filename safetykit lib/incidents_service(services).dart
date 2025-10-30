import 'dart:async';
import 'dart:math';
import '../models/incident.dart';

class IncidentsService {
  IncidentsService._();
  static final instance = IncidentsService._();

  final _controller = StreamController<List<Incident>>.broadcast();
  final List<Incident> _items = [];

  Stream<List<Incident>> get stream => _controller.stream;

  void add(Incident i) {
    _items.insert(0, i);
    print("✅ Incident added: ${i.lat}, ${i.lng} at ${i.timestamp}");
    _controller.add(List.unmodifiable(_items));
  }

  Future<void> triggerSOS(List<String> contacts, {bool simulate = true}) async {
    try {
      double lat, lng;

      if (simulate) {
        final r = Random();
        lat = 12.9716 + r.nextDouble() * 0.01;
        lng = 77.5946 + r.nextDouble() * 0.01;
      } else {
        lat = 0.0;
        lng = 0.0;
      }

      for (var phone in contacts) {
        add(Incident(
          phone: phone,
          lat: double.parse(lat.toStringAsFixed(5)),
          lng: double.parse(lng.toStringAsFixed(5)),
          timestamp: DateTime.now(),
        ));
      }
    } catch (e) {
      print("⚠️ Error in triggerSOS: $e");
    }
  }
}
