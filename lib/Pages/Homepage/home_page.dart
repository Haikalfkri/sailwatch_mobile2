import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:sailwatch_mobile/Pages/ForecastPage/forecastPage.dart';
import 'package:sailwatch_mobile/Pages/Homepage/widget/HourlyWeatherCard.dart';
import 'package:sailwatch_mobile/Pages/Homepage/widget/weatherDetail.dart';

import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String cityName = "Batam";
  String currentDate =
      DateFormat('EEEE, dd MMMM yyyy', 'id').format(DateTime.now());
  String weatherDescription = "";
  String weatherIcon = "assets/images/sunny.png"; // Default icon
  String temperature = "";
  String windSpeed = "";
  String humidity = "";

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
    _timer =
        Timer.periodic(Duration(minutes: 15), (Timer t) => fetchWeatherData());
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> fetchWeatherData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://data.bmkg.go.id/DataMKG/MEWS/DigitalForecast/DigitalForecast-KepulauanRiau.xml'));

      if (response.statusCode == 200) {
        final document = xml.XmlDocument.parse(response.body);

        final area = document.findAllElements('area').firstWhere(
              (element) => element.getAttribute('description') == cityName,
              orElse: () => throw Exception('Area not found'),
            );

        final temperatureElement = area.findElements('parameter').firstWhere(
              (element) => element.getAttribute('id') == 't',
              orElse: () => throw Exception('Temperature parameter not found'),
            );

        final windSpeedElement = area.findElements('parameter').firstWhere(
              (element) => element.getAttribute('id') == 'ws',
              orElse: () => throw Exception('Wind speed parameter not found'),
            );

        final humidityElement = area.findElements('parameter').firstWhere(
              (element) => element.getAttribute('id') == 'hu',
              orElse: () => throw Exception('Humidity parameter not found'),
            );

        final weatherElement = area.findElements('parameter').firstWhere(
              (element) => element.getAttribute('id') == 'weather',
              orElse: () => throw Exception('Weather parameter not found'),
            );
        final weather = weatherElement.findAllElements('value').first.innerText;

        // Map weather codes to descriptions
        final weatherMap = {
          "0": {"description": "Cerah", "icon": "assets/images/sunny.png"},
          "1": {"description": "Cerah Berawan", "icon": "assets/images/cloudy.png"},
          "2": {"description": "Cerah Berawan", "icon": "assets/images/cloudy.png"},
          "3": {"description": "Berawan", "icon": "assets/images/cloudy.png"},
          "4": {"description": "Berawan Tebal", "icon": "assets/images/cloudy.png"},
          "5": {"description": "Udara Kabur", "icon": "assets/images/haze.png"},
          "10": {"description": "Asap", "icon": "assets/images/smoke.png"},
          "45": {"description": "Kabut", "icon": "assets/images/fog.png"},
          "60": {"description": "Hujan Ringan", "icon": "assets/images/light_rain.png"},
          "61": {"description": "Hujan Sedang", "icon": "assets/images/moderate_rain.png"},
          "63": {"description": "Hujan Lebat", "icon": "assets/images/heavy_rain.png"},
          "80": {"description": "Hujan Lokal", "icon": "assets/images/local_rain.png"},
          "95": {"description": "Hujan Petir", "icon": "assets/images/thunderstorm.png"},
          // Add other mappings as necessary
        };

        final weatherInfo = weatherMap[weather];

        setState(() {
          weatherDescription = weatherInfo?['description'] ?? "Unknown";
          weatherIcon = weatherInfo?['icon'] ?? "assets/images/sunny.png";
          temperature = temperatureElement.findAllElements('value').first.innerText;
          windSpeed = windSpeedElement.findAllElements('value').first.innerText;
          humidity = humidityElement.findAllElements('value').first.innerText;
        });
      } else {
        print('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
          child: Column(
            children: [
              Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          cityName,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        Text(
                          currentDate,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Image.asset(
                        weatherIcon,
                        width: 300,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        weatherDescription,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              WeatherDetails(
                temperature: temperature,
                windSpeed: windSpeed,
                humidity: humidity,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today",
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const forecastPage()));
                    },
                    child: Text(
                      "View Full Forecast",
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Color(0xFF1d86de),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    HourlyWeatherItem(
                      time: "7:00",
                      temperature: "32°C",
                      iconPath: "assets/images/overcast.png",
                    ),
                    HourlyWeatherItem(
                      time: "10:00",
                      temperature: "32°C",
                      iconPath: "assets/images/sunny.png",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
