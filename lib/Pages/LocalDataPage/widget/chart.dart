import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

class LineChartSample extends StatelessWidget {
  const LineChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 400,
        child: LineChart(
          LineChartData(
              // read about it in the LineChartData section
              ),
        ));
  }
}
