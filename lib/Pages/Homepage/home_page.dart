import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sailwatch_mobile/Pages/ForecastPage/forecastPage.dart';
import 'package:sailwatch_mobile/Pages/Homepage/widget/HourlyWeatherCard.dart';
import 'package:sailwatch_mobile/Pages/Homepage/widget/weatherDetail.dart';
import 'package:sailwatch_mobile/services/weatherServices.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final XmlToJsonService xmlToJsonService = XmlToJsonService();
  late Future<Map<String, dynamic>> jsonData;

  @override
  void initState() {
    super.initState();
    jsonData = xmlToJsonService.fetchAndConvertXmlToJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
          child: FutureBuilder<Map<String, dynamic>>(
            future: jsonData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Tidak ada data tersedia'));
              } else {
                try {
                  var area = snapshot.data!['data']['forecast']['area'];
                  var weatherData = area[0]['parameter'];
                  var cityName = area[0]['name'][0]['\$t'];
                  var temperature = weatherData[5]['timerange'][0]['value'][0]['\$t'];
                  var windSpeed = weatherData[8]['timerange'][0]['value'][0]['\$t'];
                  var humidity = weatherData[6]['timerange'][0]['value'][0]['\$t'];
                  var hourlyWeather = weatherData[5]['timerange'];
                  
                  return Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              cityName,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "May, 28 2024",  // Ubah sesuai kebutuhan
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Image.asset(
                            "assets/images/sunny.png",
                            width: 250,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Cerah",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 25),
                      WeatherDetails(
                        temperature: "$temperature°C",
                        windSpeed: "$windSpeed km/h",
                        humidity: "$humidity%",
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today",
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ForecastPage(),
                              ));
                            },
                            child: Text(
                              "View Full Forecast",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xFF1d86de),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: hourlyWeather.map<Widget>((hourData) {
                            var time = hourData['datetime'];
                            var temp = hourData['value'][0]['\$t']; // Simpan sebagai string
                            var iconPath = "assets/images/sunny.png"; // Logika untuk ikon bisa ditambahkan di sini

                            return HourlyWeatherItem(
                              time: "$time",
                              temperature: "$temp°C", // Gunakan langsung sebagai string
                              iconPath: iconPath,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                } catch (e) {
                  return Center(child: Text('Error extracting data: $e'));
                }
              }
            },
          ),
        ),
      ),
    );
  }
}