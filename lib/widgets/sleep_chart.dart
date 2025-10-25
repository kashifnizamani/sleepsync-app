import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/sleep_record.dart';

class SleepChart extends StatelessWidget {
  final List<SleepRecord> records;
  const SleepChart({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return const Center(child: Text('No data for chart'));
    }

    return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Text("Sleep Duration Trend", style: TextStyle(fontWeight: FontWeight.bold)),
    const SizedBox(height: 8),
    Expanded(
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: records.asMap().entries.map(
                (e) => FlSpot(e.key.toDouble(), e.value.duration),
              ).toList(),
              isCurved: true,
              color: Colors.deepPurple,
              barWidth: 3,
              dotData: const FlDotData(show: true),
            ),
          ],
        ),
      ),
    ),
  ],
);

  }
}
