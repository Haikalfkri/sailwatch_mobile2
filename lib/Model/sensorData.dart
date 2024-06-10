class SensorData {
  final double humidity;
  final double temperature;
  final double windSpeed;
  final double pressure;

  SensorData({required this.humidity, required this.temperature, required this.windSpeed, required this.pressure});

  factory SensorData.fromMap(Map<String, dynamic> map) {
    return SensorData(
      humidity: (map['humidity'] ?? 0).toDouble(),
      temperature: (map['temperature'] ?? 0).toDouble(),
      windSpeed: (map['windSpeed'] ?? 0).toDouble(),
      pressure: (map['pressure'] ?? 0).toDouble(),
    );
  }
}
