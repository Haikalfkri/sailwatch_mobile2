import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sailwatch_mobile/Model/sensorData.dart';
import 'dart:async';

import 'package:sailwatch_mobile/Pages/LocalDataPage/widget/LocalSensorCard.dart';
import 'package:sailwatch_mobile/Pages/LocalDataPage/widget/chart.dart';

class LocalData extends StatefulWidget {
  const LocalData({super.key});

  @override
  State<LocalData> createState() => _LocalDataState();
}

class _LocalDataState extends State<LocalData> {
  late DatabaseReference databaseReference;
  SensorData sensorData = SensorData(humidity: 0, temperature: 0, windSpeed: 0, pressure: 0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    databaseReference = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: "https://sailwatch-48901-default-rtdb.asia-southeast1.firebasedatabase.app/",
    // ignore: deprecated_member_use
    ).reference().child("Sensor");

    fetchData();
    _timer = Timer.periodic(Duration(minutes: 2), (timer) => fetchData());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void fetchData() {
    databaseReference.onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot.value;
      if (snapshot != null && snapshot is Map) {
        final data = Map<String, dynamic>.from(snapshot);
        setState(() {
          sensorData = SensorData.fromMap(data);
        });
      } else {
        // Handle the case where snapshot is null or not a Map
        setState(() {
          sensorData = SensorData(humidity: 0, temperature: 0, windSpeed: 0, pressure: 0);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Local Data",
                style: GoogleFonts.inter(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  LocalSensorCard(
                    title: "Humidity",
                    condition: "normal",
                    value: "${sensorData.humidity.toStringAsFixed(1)} %",
                  ),
                  LocalSensorCard(
                    title: "Temperature",
                    condition: "normal",
                    value: "${sensorData.temperature.toStringAsFixed(1)} °C",
                  ),
                  LocalSensorCard(
                    title: "Wind Speed",
                    condition: "normal",
                    value: "${sensorData.windSpeed.toStringAsFixed(1)} kph",
                  ),
                  LocalSensorCard(
                    title: "Pressure",
                    condition: "normal",
                    value: "${sensorData.pressure.toStringAsFixed(1)} Pa",
                  ),
                ],
              ),
              const SizedBox(height: 40),
              RealtimeChart(
                humidityData: sensorData.humidity,
                temperatureData: sensorData.temperature,
                windSpeed: sensorData.windSpeed,
                pressure: sensorData.pressure,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
