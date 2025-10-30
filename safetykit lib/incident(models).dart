class Incident { 
  final String? id; 
  final String phone; 
  final double lat; 
  final double lng; 
  final DateTime timestamp; 

  Incident({ 
    this.id, 
    required this.phone, 
    required this.lat, 
    required this.lng, 
    required this.timestamp, 
  }); 
}