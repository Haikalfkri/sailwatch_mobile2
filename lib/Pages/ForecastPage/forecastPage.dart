import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sailwatch_mobile/Pages/BottomNavigationBar/navigationBar.dart';
import 'package:sailwatch_mobile/Pages/ForecastPage/widget/nextForecastCard.dart';
import 'package:sailwatch_mobile/Pages/Homepage/widget/HourlyWeatherCard.dart';

class forecastPage extends StatefulWidget {
  const forecastPage({super.key});

  @override
  State<forecastPage> createState() => _forecastPageState();
}

class _forecastPageState extends State<forecastPage> {
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => navigationBar()));
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Next forecast",
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  nextForecastCard(
                    day: "Selasa",
                    date: "27 May 2024",
                    temperature: "32°C",
                    iconPath: "assets/images/sunny.png",
                  ),
                  nextForecastCard(
                    day: "Rabu",
                    date: "28 May 2024",
                    temperature: "32°C",
                    iconPath: "assets/images/overcast.png",
                  ),
                  nextForecastCard(
                    day: "Kamis",
                    date: "29 May 2024",
                    temperature: "32°C",
                    iconPath: "assets/images/lightrain.png",
                  ),
                  nextForecastCard(
                    day: "Jumat",
                    date: "30 May 2024",
                    temperature: "32°C",
                    iconPath: "assets/images/patchylightrainwiththunder.png",
                  ),
                  nextForecastCard(
                    day: "Sabtu",
                    date: "31 May 2024",
                    temperature: "32°C",
                    iconPath: "assets/images/sunny.png",
                  ),
                  nextForecastCard(
                    day: "Minggu",
                    date: "01 April 2024",
                    temperature: "32°C",
                    iconPath: "assets/images/moderateorheavyrainshower.png",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
