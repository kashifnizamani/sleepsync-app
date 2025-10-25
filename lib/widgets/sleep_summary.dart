import 'package:flutter/material.dart';
import '../models/sleep_record.dart';

class SleepSummary extends StatelessWidget {
  final List<SleepRecord> records;
  const SleepSummary({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return const Text("Average: 0 hrs | Quality: N/A");
    }

    final avg = records.map((r) => r.duration).reduce((a, b) => a + b) / records.length;
    final goodCount = records.where((r) => r.quality == "Good").length;

    return Text(
      "Average Sleep: ${avg.toStringAsFixed(1)} hrs | Good Nights: $goodCount",
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }
}
