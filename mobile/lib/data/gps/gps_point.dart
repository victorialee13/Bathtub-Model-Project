// GPS point model. Raw location data — never leave the device.

class GpsPoint {
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final double? accuracy;

  const GpsPoint({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.accuracy,
  });
}
