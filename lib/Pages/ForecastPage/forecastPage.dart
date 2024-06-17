import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:sailwatch_mobile/Pages/BottomNavigationBar/navigationBar.dart';
import 'package:sailwatch_mobile/Pages/ForecastPage/widget/nextForecastCard.dart';
import 'package:sailwatch_mobile/Pages/Homepage/widget/HourlyWeatherCard.dart';
import 'package:sailwatch_mobile/Pages/Homepage/widget/weatherDetail.dart';
import 'package:sailwatch_mobile/services/weatherServices.dart';

class forecastPage extends StatefulWidget {
  const forecastPage({Key? key}) : super(key: key);

  @override
  State<forecastPage> createState() => _forecastPageState();
}

class _forecastPageState extends State<forecastPage> {
  final XmlToJsonService xmlToJsonService = XmlToJsonService();
  late Future<List<Map<String, dynamic>>> futureForecasts =
      xmlToJsonService.fetchWeatherForecast();

  @override
  void initState() {
    super.initState();
  }

  String getWeatherIconPath(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return 'assets/images/sunny.png';
      case 1:
        return 'assets/images/clear.png';
      case 2:
        return 'assets/images/moderateorheavyrainshower.png';
      case 3:
        return 'assets/images/cloud.png';
      case 4:
        return 'assets/images/cloudy.png';
      case 5:
        return 'assets/images/heavycloud.png';
      case 10:
        return 'assets/images/overcast.png';
      case 45:
        return 'assets/images/overcast.png';
      case 60:
        return 'assets/images/lightdrizzle.png';
      case 61:
        return 'assets/images/lightrainshower.png';
      case 63:
        return 'assets/images/lightrain.png';
      case 80:
        return 'assets/images/lightdrizzle.png';
      case 95:
        return 'assets/images/moderaterain.png';
      case 97:
        return 'assets/images/moderateorheavyrainwithunder.png';
      default:
        return 'assets/images/sunny.png';
    }
  }

  int parseWeatherCode(dynamic weatherCodeValue) {
    if (weatherCodeValue is int) {
      return weatherCodeValue;
    } else if (weatherCodeValue is double) {
      return weatherCodeValue.toInt();
    } else if (weatherCodeValue is String) {
      return int.tryParse(weatherCodeValue) ?? 0;
    } else {
      print('Invalid weather code format: $weatherCodeValue');
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => navigationBar()));
          },
        ),
        title: Text(
          'Forecast report',
          style: GoogleFonts.inter(
              fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
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
                      Text(
                        "Senin, 26 may 2024",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HourlyWeatherItem(
                          time: "14:00",
                          temperature: "32°C",
                          iconPath: "assets/images/overcast.png",
                        ),
                        HourlyWeatherItem(
                          time: "15:00",
                          temperature: "32°C",
                          iconPath: "assets/images/sunny.png",
                        ),
                        HourlyWeatherItem(
                          time: "16:00",
                          temperature: "32°C",
                          iconPath: "assets/images/cloud.png",
                        ),
                        HourlyWeatherItem(
                          time: "17:00",
                          temperature: "32°C",
                          iconPath: "assets/images/mist.png",
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: futureForecasts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return const Center(
                        child: Text('Tidak ada data tersedia',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            )));
                  } else {
                    try {
                      var forecastList = snapshot.data!.map<Widget>((forecast) {
                        var day = forecast['day'] ?? 'Unknown';
                        var date = forecast['date'] ?? 'Unknown';
                        var temperature = forecast['temperature'] ?? 'N/A';
                        var weatherCode =
                            parseWeatherCode(forecast['weatherCode'] ?? '0');

                        return nextForecastCard(
                          day: day,
                          date: date,
                          temperature: '$temperature°C',
                          iconPath: getWeatherIconPath(weatherCode),
                        );
                      }).toList();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Next forecast",
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          ...forecastList,
                        ],
                      );
                    } catch (e) {
                      print('Error extracting data: $e');
                      return Center(child: Text('Error extracting data: $e'));
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
