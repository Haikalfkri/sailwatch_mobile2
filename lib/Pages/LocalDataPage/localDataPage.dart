import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sailwatch_mobile/Pages/LocalDataPage/widget/humidity.dart';
import 'package:sailwatch_mobile/Pages/LocalDataPage/widget/temperature.dart';

class localData extends StatefulWidget {
  const localData({super.key});

  @override
  State<localData> createState() => _localDataState();
}

class _localDataState extends State<localData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              height: 20,
            ),
            Column(
              children: [
                HumidityPage(
                  title: "Humidity",
                  value: 70,
                  imagePath: "assets/images/sunny.png"
                ),
                SizedBox(height: 20,),
                TemperaturePage(
                  title: "Temperature", 
                  value: 30, 
                  imagePath: "assets/images/sunny.png"
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
