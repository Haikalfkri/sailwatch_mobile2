import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sailwatch_mobile/Pages/ForecastPage/forecastPage.dart';
import 'package:sailwatch_mobile/Pages/Homepage/widget/HourlyWeatherCard.dart';
import 'package:sailwatch_mobile/Pages/Homepage/widget/weatherDetail.dart';
import 'package:sailwatch_mobile/services/weatherServices.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
          margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
          child: Column(
            children: [
              Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Batam",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        Text(
                          "May, 28 2024",
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
                        "assets/images/sunny.png",
                        width: 250,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Cerah",
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
                temperature: "32C",
                windSpeed: "10 km/h",
                humidity: "85%",
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
                    HourlyWeatherItem(
                      time: "10:00",
                      temperature: "32°C",
                      iconPath: "assets/images/sunny.png",
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
