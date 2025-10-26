import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/sleep_provider.dart';
import '../models/sleep_record.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  double _averageSleep(List<SleepRecord> records) {
    if (records.isEmpty) return 0;
    final total = records.fold<double>(0, (sum, r) => sum + r.duration);
    return total / records.length;
  }

  int _goodNights(List<SleepRecord> records) {
    return records.where((r) => r.quality.toLowerCase() == "good").length;
  }

  int _longestStreak(List<SleepRecord> records) {
    if (records.isEmpty) return 0;
    records.sort((a, b) => a.date.compareTo(b.date));

    int current = 1, longest = 1;
    for (int i = 1; i < records.length; i++) {
      final diff = records[i].date.difference(records[i - 1].date).inDays;
      if (diff == 1) {
        current++;
      } else {
        longest = longest < current ? current : longest;
        current = 1;
      }
    }
    return longest < current ? current : longest;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SleepProvider>(context);
    final records = provider.records;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sleep Insights"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: records.isEmpty
            ? const Center(
                child: Text("No sleep data yet. Add some records first."),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Sleep Summary",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // Average Duration Card
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatCard(
                            "Average", "${_averageSleep(records).toStringAsFixed(1)} hrs", Colors.deepPurple),
                        _buildStatCard(
                            "Good Nights", _goodNights(records).toString(), Colors.teal),
                        _buildStatCard(
                            "Best Streak", "${_longestStreak(records)} days", Colors.orange),
                      ],
                    ),

                    const SizedBox(height: 24),
                    Text(
                      "Last 7 Days",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),

                    Container(
                      height: 240,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 4,
                              offset: const Offset(0, 2))
                        ],
                      ),
                      child: _buildBarChart(records),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      width: 110,
      height: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 6),
          Text(title,
              style: TextStyle(
                  fontSize: 14, color: color.withOpacity(0.8), fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildBarChart(List<SleepRecord> records) {
    final now = DateTime.now();
    final last7 = List.generate(7, (i) => now.subtract(Duration(days: 6 - i)));

    final barData = last7.map((day) {
      final record = records.firstWhere(
        (r) => r.date.year == day.year && r.date.month == day.month && r.date.day == day.day,
        orElse: () => SleepRecord(date: day, duration: 0, quality: ""),
      );
      return BarChartGroupData(
        x: day.day,
        barRods: [
          BarChartRodData(
            toY: record.duration,
            color: Colors.deepPurple,
            width: 18,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();

    return BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, interval: 2),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: false),
        barGroups: barData,
      ),
    );
  }
}
