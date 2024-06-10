import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sailwatch_mobile/Pages/LocalDataPage/widget/LocalSensorCard.dart';
import 'package:sailwatch_mobile/Pages/LocalDataPage/widget/location.dart';

class localData extends StatefulWidget {
  const localData({super.key});

  @override
  State<localData> createState() => _localDataState();
}

class _localDataState extends State<localData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Local Data",
                    style: GoogleFonts.inter(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  LocalSensorCard(
                      title: "Humidity",
                      condition: "normal",
                      value: "70 %",
                      imagePath: "assets/images/sunny.png"),
                  LocalSensorCard(
                      title: "Temperature",
                      condition: "normal",
                      value: "30 °C",
                      imagePath: "assets/images/sunny.png"),
                  LocalSensorCard(
                      title: "Wind Speed",
                      condition: "normal",
                      value: "10 km/h",
                      imagePath: "assets/images/sunny.png"),
                  LocalSensorCard(
                      title: "Pressure",
                      condition: "normal",
                      value: "40 pha",
                      imagePath: "assets/images/sunny.png"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
