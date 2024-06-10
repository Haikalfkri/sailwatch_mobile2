import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RealtimeChart extends StatelessWidget {
  final double humidityData;
  final double temperatureData;
  final double windSpeed;
  final double pressure;

  const RealtimeChart({super.key, required this.humidityData, required this.temperatureData, required this.windSpeed, required this.pressure});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.transparent,
      child: LineChart(getLineChartData(humidityData, temperatureData, windSpeed, pressure)),
    );
  }

  LineChartData getLineChartData(double humidity, double temperature, double windSpeed, double pressure) {
    return LineChartData(
      gridData: gridData,
      titlesData: titlesData,
      borderData: borderData,
      lineBarsData: getLinesBarsData(humidity, temperature, windSpeed, pressure),
      minX: 0,
      maxX: 14,
      minY: 0,
      maxY: 100,
    );
  }

  List<LineChartBarData> getLinesBarsData(double humidity, double temperature, double windSpeed, double pressure) => [
    LineChartBarData(
      isCurved: true,
      color: Colors.white,
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: [FlSpot(1, humidity)], // Add more spots for a dynamic chart
    ),
    LineChartBarData(
      isCurved: true,
      color: Colors.yellow,
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: [FlSpot(1, temperature)], // Add more spots for a dynamic chart
    ),
    LineChartBarData(
      isCurved: true,
      color: Colors.blue, // Choose color for wind speed line
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    ),
    LineChartBarData(
      isCurved: true,
      color: Colors.green, // Choose color for wind speed line
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    ),

  ];
}

FlTitlesData get titlesData => FlTitlesData(
  bottomTitles: AxisTitles(
    sideTitles: bottomTitles,
  ),
  rightTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  ),
  topTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  ),
  leftTitles: AxisTitles(
    sideTitles: leftTitles(),
  ),
);

Widget leftTitlesWidget(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
  String text;
  switch (value.toInt()) {
    case 20:
      text = "20";
      break;
    case 40:
      text = "40";
      break;
    case 60:
      text = "60";
      break;
    case 80:
      text = "80";
      break;
    case 100:
      text = "100";
      break;
    default:
      return Container();
  }
  return Text(text, style: style, textAlign: TextAlign.center,);
}

SideTitles leftTitles() => SideTitles(
  getTitlesWidget: leftTitlesWidget,
  showTitles: true,
  interval: 20,
  reservedSize: 40,
);

SideTitles get bottomTitles => SideTitles(
  showTitles: true,
  reservedSize: 32,
  interval: 1,
);

FlGridData get gridData => FlGridData(show: true);

FlBorderData get borderData => FlBorderData(
  show: true,
  border: Border(
    bottom: BorderSide(color: Colors.grey, width: 4),
    left: BorderSide(color: Colors.grey),
    right: BorderSide(color: Colors.transparent),
    top: BorderSide(color: Colors.transparent),
  ),
);
