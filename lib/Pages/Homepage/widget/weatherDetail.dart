import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherDetails extends StatelessWidget {
  final String temperature;
  final String windSpeed;
  final String humidity;

  const WeatherDetails({
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildWeatherDetail(title: "Temp", value: "$temperature°C"),
        _buildWeatherDetail(title: "Wind Speed", value: "$windSpeed km/h"),
        _buildWeatherDetail(title: "Humidity", value: "$humidity%"),
      ],
    );
  }

  Widget _buildWeatherDetail({required String title, required String value}) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}